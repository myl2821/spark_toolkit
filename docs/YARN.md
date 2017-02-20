# YARN

This document explains how to get started using SparkToolkit with YARN.


## Get and Initiate YARN Client Instance

```ruby
yarn = SparkToolkit::YARN::Client.new hadoop_conf
yarn.start
```
## YARN Client Operation

YARN client allows you to monitor the state of all node in its cluster, get report and diagnosis of specific YARN jobs, submit job to YARN cluster, and so on.

### Get Report of Running Nodes

```ruby
node_reports = yarn.get_node_reports
node_reports.each do |report|
	node_state = report.get_node_state
	node_id = report.get_node_id
	num_containers = report.get_num_containers
	node_total_memory = report.get_total_memory
	node_used_memory = report.get_used_memory
	node_vcores = report.get_total_vcores
	node_used_vcores = report.get_used_vcores
end
```

### Get Report of YARN Application

```ruby
app_report = yarn.get_application_report(app_id)
app_report_detail = app_report.get_detail
```

### Get Log of YARN Application

```ruby
log_stdout = yarn.get_application_logs(app_id, :stdout)
log_stderr = yarn.get_application_logs(app_id, :stderr)
log_all = yarn.get_application_logs(app_id, :all)
formatted_log = SparkToolkit::YARN::SimpleLogFormatter.format(log_all)
```

### Get Report of YARN Attempt

```ruby
attempts = yarn.get_application_reports(app_id)
attempts.each do |attempt|
	attempt_id = attempt.get_attempt_id
	attempt_diagnostics = attempt.get_dianostics
	tracking_url = attempt.get_tracking_url
	attempt_state = attempt.get_yarn_application_apptempt_state
	am_container_id = attempt.get_am_container_id
end
```

### Kill YARN Job

	yarn.kill_application(app_id)
