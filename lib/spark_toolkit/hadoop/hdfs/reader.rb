class Java::OrgApacheHadoopHdfsClient::HdfsDataInputStream
  def read(*args)
    @io ||= self.to_io
    @io.read(*args)
  end

  def readline
    @io ||= self.to_io
    @io.read_line
  end

  def readlines
    lines = []
    loop do
      line = readline
      line.nil? ? break : lines << line
    end
    lines
  end
end

