module SparkToolkit
  module HDFS
    class FileSystem
      java_import org.apache.hadoop.fs.Path
      java_import org.apache.hadoop.security.UserGroupInformation
      java_import java.net.URI
      java_import org.apache.hadoop.fs.FileUtil

      def initialize(url, conf)
        @url = url
        @hdfs_conf = conf
        UserGroupInformation.set_configuration(@hdfs_conf)
        @hdfs = org.apache.hadoop.fs.FileSystem.get(URI.create(url), @hdfs_conf)
      end

      # ==== Returns
      #
      # * <~HdfsInputStream>
      def open(path)
        @hdfs.open(Path.new(path))
      end

      def list(path, recursively=false)
        if recursively
          paths = []
          dir_itr = @hdfs.listFiles(Path.new(path), true)

          while dir_itr.hasNext
            next_path = dir_itr.next.getPath
            paths << next_path
          end
          paths
        else
          file_status = @hdfs.listStatus(Path.new(path))
          FileUtil.stat2Paths(file_status)
        end
      end
      alias_method :ls, :list

      def copy_to_local(hdfs_src, local_dst)
        @hdfs.copy_to_local_file(false, Path.new(hdfs_src), Path.new(local_dst), true)
      end

      def get_file_status(entry)
        @hdfs.get_file_status(Path.new(entry))
      end
      alias_method :status, :get_file_status

      def rename(src, dst)
        @hdfs.rename(Path.new(src), Path.new(dst))
      end
      alias_method :mv, :rename

      def exists?(path)
        @hdfs.exists(Path.new(path))
      end

      def delete(path, recursively=false)
        @hdfs.delete(Path.new(path), recursively)
      end
      alias_method :rm, :delete

      def put(local_src, hdfs_dst)
        @hdfs.copyFromLocalFile(false, true, Path.new(local_src), Path.new(hdfs_dst))
      end

      def mkdir(path)
        @hdfs.mkdirs(Path.new(path))
      end
      alias_method :mkdir_p, :mkdir
    end
  end
end
