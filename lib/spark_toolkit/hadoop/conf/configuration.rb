module SparkToolkit
  module Conf
    Configuration = Java::OrgApacheHadoopConf::Configuration
    class Configuration
      java_import org.apache.hadoop.fs.Path
      java_import org.apache.hadoop.security.UserGroupInformation

      alias_method :initialise, :initialize
      def initialize(opts={})
        initialise

        default_opts = {
          'fs.hdfs.impl' => 'org.apache.hadoop.hdfs.DistributedFileSystem',
          'fs.file.impl' => 'org.apache.hadoop.fs.LocalFileSystem'
        }

        default_opts.merge(opts).each { |k, v| set(k, v) }
      end

      alias_method :add_resource_java, :add_resource
      def add_resource(f)
        add_resource_java(Path.new(f))
      end

      def krb_login(principle, keytab)
        set('hadoop.security.authentication', 'kerberos')
        UserGroupInformation.set_configuration(self)
        UserGroupInformation.login_user_from_keytab(principle, keytab)
      end

      def []=(k, v)
        set(k, v)
      end

      def [](k)
        get(k)
      end

      # Load *.xml files under input dir
      def add_config_dir(dir)
        Dir.glob("#{dir}/*.xml").each { |f| add_resource(f) }
      end
    end
  end
end
