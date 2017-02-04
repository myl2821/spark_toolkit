module SparkToolkit
  module YARN
    class LogAccessor
      java_import org.apache.hadoop.security.UserGroupInformation
      java_import org.apache.hadoop.fs.FileContext
      java_import org.apache.hadoop.fs.Path
      java_import org.apache.hadoop.yarn.logaggregation.AggregatedLogFormat

      attr_reader :hconf
      def initialize(hconf)
        @hconf = hconf
        log_root = hconf.get('yarn.nodemanager.remote-app-log-dir')
        username = UserGroupInformation.get_current_user.get_short_user_name
        @log_dir = File.join(log_root, username, 'logs')
        @max_log_len = 1024 * 1024 # 1M log
      end

      def get_logs(appid, dev)
        case dev
        when :stdout
          get_logs_core(appid, ["stdout"])
        when :stderr
          get_logs_core(appid, ["stderr"])
        when :all
          get_logs_core(appid, ["stdout", "stderr"])
        end
      end

      private
      def read_one_log(stream, upload_time, log_type)
        dev = stream.readUTF
        length = stream.readUTF.to_i
        io = stream.to_io
        if log_type.include?(dev.to_s)
          skip_len = [length-@max_log_len, 0].max
          body = io.read(length)
          io.read skip_len
          {
            log_type: dev,
            upload_time: upload_time,
            length: length,
            body: body
          }
        else
          io.read length
          nil
        end
      end

      def read_logs_core(stream, mod_time, log_type)
        res = []
        begin
          loop do
            res << read_one_log(stream, mod_time, log_type)
          end
        rescue Java::JavaIO::EOFException
          res.compact.select { |x| x[:length] != 0 }
        end
      end

      def get_logs_core(appid, log_type)
        path = Path.new("#{@log_dir}/#{appid}")
        qdir = FileContext.getFileContext(hconf).makeQualified(path)
        files = FileContext.getFileContext(qdir.toUri(), hconf).listStatus(path)
        res = []
        while files.has_next
          file = files.next
          reader = AggregatedLogFormat::LogReader.new(hconf, file.get_path)
          key = AggregatedLogFormat::LogKey.new
          stream = reader.next(key)
          until stream.nil?
            parsed = {
              container: key.to_s,
              file: file.get_path.get_name,
              content: read_logs_core(stream, file_mod_time(file), log_type)
            }
            res << parsed
            stream = reader.next(key)
          end
        end
        res.reject { |x| x[:content].empty? }
      end

      def file_mod_time(file)
        Time.at(file.get_modification_time / 1000).to_s
      end
    end

    class LogFormatter
      def self.format(input)
        fail "Called from base class!"
      end
    end

    class SimpleLogFormatter < LogFormatter
      def self.format(formatables)
        formatted = ""
        formatables.each do |formatable|
          formatable[:content].each do |content|
            formatted << 'Container: ' << formatable[:container] << "\n"
            formatted << 'Node: ' << formatable[:file] << "\n"
            formatted << 'Log Type: ' << content[:log_type] << "\n"
            formatted << 'Log Upload Time: ' << content[:upload_time] << "\n"
            formatted << 'Log Length: ' << content[:length].to_s << "\n"
            formatted << '='*80 << "\n"
            formatted << content[:body] << "\n"*4
          end
        end
        formatted
      end
    end

    class HTMLLogFormatter < LogFormatter
      def self.format(formatables)
        fail NotImplementedError
      end
    end
  end
end
