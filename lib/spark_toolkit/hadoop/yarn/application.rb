class Java::OrgApacheHadoopYarnApiRecordsImplPb::ApplicationReportPBImpl
  # get_application_id
  # get_application_type
  # get_start_time
  # get_finish_time
  # get_user
  # get_host
  # get_name
  # get_tracking_url
  def get_detail
    {
      id: get_application_id,
      name: get_name,
      user: get_user,
      type: get_application_type,
      host: get_host,
      tracking_url: get_tracking_url,
      start_time: get_start_time,
      finish_time: get_finish_time,
      state: get_yarn_application_state
    }
  end
end
