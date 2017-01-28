# Spark

This document explains how to get started using SparkToolkit with Spark.

## Get and Initialize Spark Client Instance

```
spark_client = SparkToolkit::Spark::Client.new(hadoop_conf)
```
## Set config metadate
```
spark_conf = spark_client.get_spark_conf
spark_conf.set_app_name "example"
```

## Submit Spark Job

```
# example of submit pi python job
args = ["--class", "org.apache.spark.deploy.PythonRunner",
        "--primary-py-file", "pi.py",
        "--arg", 2]
spark_conf.yarn_deploy_mode(:cluster) # or :client
spark_client.is_python_job(true)
# Submit your job to YARN and get its app_id for query
yarn_app_id = spark_client.yarn_submit(args)
# Or run as client, print all output into console
spark_client.yarn_run(args)
```