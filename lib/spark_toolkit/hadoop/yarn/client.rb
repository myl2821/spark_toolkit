module SparkToolkit
  module YARN
    Client = Java::OrgApacheHadoopYarnClientApiImpl::YarnClientImpl

    class Client
      attr_reader :conf
      alias_method :initalise, :initialize
      def initialize(conf=nil)
        initalise
        @conf = conf
        init conf if conf
      end

      def get_applications
        getApplications.to_a
      end
      # get_application_report(app_id)

      def get_containers(app_id)
        getContainers(app_id).to_a
      end
      # get_container_report(container_id)

      def get_application_attempts(app_id)
        getApplicationAttempts(app_id).to_a
      end
      # get_attempt_report(app_id)

      def get_node_reports
        getNodeReports.to_a
      end

      def get_cluster_report
        sum = get_node_reports.reduce([0,0,0,0]) do |sum, report|
          sum[0] += report.get_total_memory
          sum[1] += report.get_used_memory
          sum[2] += report.get_total_vcores
          sum[3] += report.get_used_vcores
          sum
        end
        {
          total_memory: sum[0],
          used_memory: sum[1],
          total_vcores: sum[2],
          used_vcores: sum[3],
        }
      end

      # Available devs are:
      # - :all
      # - :stdout
      # - :stderr
      def get_application_logs(appid, dev=:all)
        @conf ||= SparkToolkit::Conf::Configuration.new
        @log_accssor ||= SparkToolkit::YARN::LogAccessor.new(@conf)
        @log_accssor.get_logs(appid, dev)
      end

      # kill_application(app_id)
    end
  end
end
