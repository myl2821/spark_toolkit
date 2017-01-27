require 'spark_toolkit/version'

Dir.glob("/usr/local/spark-2.1.0-bin-hadoop2.7/jars/*.jar").each { |jar| require jar }

# Set up log4j
org.apache.log4j.basicconfigrator.configure

#require_relative 'spark-assembly-1.5.2-hadoop2.6.0.jar'
require 'spark_toolkit/hadoop'
require 'spark_toolkit/spark'
