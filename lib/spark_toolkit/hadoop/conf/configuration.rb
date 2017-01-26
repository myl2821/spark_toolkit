module SparkToolkit
  module Conf
    class Configuration
      java_import org.apache.hadoop.conf.Configuration
      java_import org.apache.hadoop.fs.Path
      java_import org.apache.hadoop.security.UserGroupInformation

      def initialize(opts={})
        @conf = Configuration.new

        default_opts = {
          'fs.hdfs.impl' => 'org.apache.hadoop.hdfs.DistributedFileSystem',
          'fs.file.impl' => 'org.apache.hadoop.fs.LocalFileSystem'
        }

        default_opts.merge(opts).each { |k, v| @conf.set(k, v) }
      end

      def add_resource(f)
        @conf.add_resource(Path.new(f))
      end

      def []=(k, v)
        @conf.set(k, v)
      end

      def [](k)
        @conf.get(k)
      end

      def get_conf
        @conf
      end

      # Load *.xml files under input dir
      def add_config_dir(dir)
        Dir.glob("#{dir}/*.xml").each { |f| add_resource(f) }
      end
    end
  end
end
