module SparkToolkit
  module YARN
    Client = Java::OrgApacheHadoopYarnClientApiImpl::YarnClientImpl
    class Client
      alias_method :initalise, :initialize
      def initialize(conf=nil)
        initalise
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

      # kill_application(app_id)
    end
  end
end
