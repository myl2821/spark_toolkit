module SparkToolkit
  module Spark
    class Client
      java_import org.apache.hadoop.security.UserGroupInformation
      java_import org.apache.spark.deploy.SparkHadoopUtil

      def initialize(hconf)
        @hconf = hconf
        UserGroupInformation.set_configuration(@hconf)
        @sconf = org.apache.spark.SparkConf.new
        @sconf.set_spark_home(ENV['SPARK_HOME']) if ENV['SPARK_HOME']
      end

      def get_spark_conf
        @sconf
      end

      def set_app_name s
        @sconf.set_app_name s
      end

      # ==== Returns
      #
      # <~AppID>
      def yarn_submit(args)
        prepare_yarn_propreties
        begin
          cli_args = org.apache.spark.deploy.yarn.ClientArguments.new(args)
        rescue ArgumentError # Spark 1.x
          cli_args = org.apache.spark.deploy.yarn.ClientArguments.new(args, @sconf)
        end
        client = org.apache.spark.deploy.yarn.Client.new(cli_args, @hconf, @sconf)
        client.submit_application
      end

      def yarn_run(args)
        prepare_yarn_propreties
        begin
          cli_args = org.apache.spark.deploy.yarn.ClientArguments.new(args)
        rescue ArgumentError # Spark 1.x
          cli_args = org.apache.spark.deploy.yarn.ClientArguments.new(args, @sconf)
        end
        client = org.apache.spark.deploy.yarn.Client.new(cli_args, @hconf, @sconf)
        client.run
      end

      def is_python_job t
        if t
          @sconf.set('spark.yarn.isPython', 'true')
        else
          @sconf.set('spark.yarn.isPython', 'false')
        end
      end

      def yarn_deploy_mode mode
        case mode
        when :cluster
          @sconf.set('spark.submit.deployMode', 'cluster')
        when :client
          @sconf.set('spark.submit.deployMode', 'client')
        else
          fail "Unsupported deploy mode!"
        end
      end

      def active_kerberos
        prepare_yarn_propreties

        @sconf.set("spark.hadoop.hadoop.security.authentication", "kerberos")
        @sconf.set("spark.hadoop.hadoop.security.authorization", "true")

        UserGroupInformation.set_configuration(SparkHadoopUtil.get.newConfiguration(@sconf))
        credentials = UserGroupInformation.getLoginUser.getCredentials
        SparkHadoopUtil.get.addCurrentUserCredentials(credentials)
      end

      def executor_cores n
        @sconf.set_property('spark.executor.cores', n.to_s)
      end

      def num_executors n
        @sconf.set_property('spark.executor.instances', n.to_s)
      end

      private
      def prepare_yarn_propreties
        @sconf.set_master('yarn')
        begin
          @sconf.get('spark.submit.deployMode')
        rescue
          @sconf.set('spark.submit.deployMode', 'cluster')
        end

        java.lang.System.set_property("SPARK_YARN_MODE", "true")
      end
    end
  end
end
