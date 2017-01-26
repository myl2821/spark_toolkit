class Java::OrgApacheHadoopYarnApiRecordsImplPb::ApplicationAttemptReportPBImpl
  def get_attempt_id
    getApplicationAttemptId
  end

  # get_diagnostics

  # get_tracking_url

  # get_original_tracking_url

  # get_yarn_application_apptempt_state

  # get_am_container_id

  def get_state
    get_yarn_application_apptempt_state.to_s.to_sym
  end
end
