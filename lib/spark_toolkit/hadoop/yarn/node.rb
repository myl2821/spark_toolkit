class Java::OrgApacheHadoopYarnApiRecordsImplPb::ResourcePBImpl
  # get_node_id

  # get_num_containers

  def get_node_state
    getNodeState.to_s.to_sym
  end

  def get_total_memory
    getCapability.getMemory
  end

  def get_used_memory
    getUsed.getMemory
  end

  def get_total_vcores
    getCapability.getVirtualCores
  end

  def get_used_vcores
    getUsed.getVirtualCores
  end
end
