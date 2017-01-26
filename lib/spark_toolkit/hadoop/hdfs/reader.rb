module SparkToolkit
  module HDFS
    class Reader
      # ==== Parameters
      #
      # * input<~HdfsDataInputStream>
      def initialize(is)
        @is = is
        reader = java.io.InputStreamReader.new(is)
        @reader = java.io.BufferedReader.new(reader)
      end

      def to_io
        @is.to_io
      end

      def readline
        @reader.readLine
      end

      def readlines(rc=-1)
        if rc < 0
          return readalllines
        end
        lines = []
        while rc > 0
          line = readline
          if line == nil
            break
          end
          lines << line
          rc -= 1
        end
        lines
      end

      def readalllines
        lines = []
        while true
          line = readline
          if line == nil
            break
          end
          lines << line
        end
        lines
      end

      def close
        @reader.close
      end

      def method_missing(method_name, *args)
        @reader.send(method_name, *args)
      end
    end
  end
end

