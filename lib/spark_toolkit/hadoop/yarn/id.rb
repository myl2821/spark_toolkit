module SparkToolkit
  module YARN
    ID = Java::OrgApacheHadoopYarnApiRecordsImplPb::ApplicationIdPBImpl
    class ID
      java_import org.apache.hadoop.yarn.api.records.ApplicationId
      def self.new_instance(ts, id)
        ApplicationId.new_instance(ts.to_i, id.to_i)
      end

      def get_timestamp
        getClusterTimestamp
      end

      # def get_id
    end
  end
end
