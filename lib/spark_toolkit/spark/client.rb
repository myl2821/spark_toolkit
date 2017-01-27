module SparkToolkit
  module Spark
    class Client
      def initialize(hconf)
        @hconf = hconf
        @sconf = org.apache.spark.SparkConf.new
        @sconf.set_spark_home(ENV['SPARK_HOME']) if ENV['SPARK_HOME']
      end

      def spark_conf
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
        cli_args = org.apache.spark.deploy.yarn.ClientArguments.new(args)
        client = org.apache.spark.deploy.yarn.Client.new(cli_args, @hconf, @sconf)
        client.submit_application
      end

      def yarn_run(args)
        prepare_yarn_propreties
        cli_args = org.apache.spark.deploy.yarn.ClientArguments.new(args)
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

      private
      def prepare_yarn_propreties
        @sconf.set_master('yarn')
        begin
          @sconf.get 'spark.submit.deployMode'
        rescue
          @sconf.set('spark.submit.deployMode', 'cluster')
        end
        java.lang.System.setProperty("SPARK_YARN_MODE", "true")
      end
    end
  end
end
