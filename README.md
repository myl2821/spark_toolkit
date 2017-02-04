# SparkToolkit

SparkToolkit was designed as the swiss army knife for interacting with Spark and Hadoop YARN cluster. Whether you need to get access to HDFS, monitor YARN cluster  node or job status, submit or run spark job, SparkToolkit is for you.

## Installation

Add this line to your application's Gemfile:

	gem 'spark_toolkit'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spark_toolkit

## Usage

Ensure `SPARK_HOME` variable was setted in your environment:

	$ export SPARK_HOME=/usr/local/spark

First, load all dep jars into JRuby:

	Dir.glob("#{SPARK_HOME}/jars/*.jar").each { |jar| require jar }

Then require this gem:

	require "spark_toolkit"

For more details, view the doc under `docs` directory.


## TODO

- ~~Support Spark 1.x~~
- Support Spark cluster mode
- ~~Add YARN application log analyzer~~

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/myl2821/spark_toolkit. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

