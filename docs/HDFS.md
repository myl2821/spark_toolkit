# HDFS

This document explains how to get started using SparkToolkit with HDFS.

## Set HDFS Config
Create new Hadoop Config:

```ruby
conf = SparkToolkit::Conf::Configuration.new
```

Set property, for example, you want to declare HDFS cluster was protected under `kerberos`:

```ruby
conf["hadoop.security.authentication"] = "kerberos"      
```

Load settings from XML file:

```ruby
conf.add_resource("hdfs-site.xml")
```

Load all XML files under a directory:

```ruby
conf.add_config_dir("config-dir")
```

## Get HDFS Instance and Do Operation

```ruby
name_service_url = conf.get('dfs.nameservices')
hdfs = SparkToolkit::HDFS::FileSystem.new(name_service_url, conf)
```
### List Entry

```ruby
hdfs.list '/path'
```

### Copy File From HDFS to Local

To request a view account details:

```ruby
hdfs.copy_to_local(hdfs_src_path, dst_local_path)
```

### Check if Entry Exists

```ruby
hdfs.exists?(entry_path)
```

### Delete File

```ruby
hdfs.delete(entry_path)
```

### Put file

```ruby
hdfs.put(local_src_path, hdfs_dst_path)
```

### Mkdir

```ruby
hdfs.mkdir(dst_path)
```

### Open and Read File

```ruby
fd = hdfs.open(dfs_path)
line = fd.readline
lines = fd.readlines
chunk = fd.read(4096)
whole_blob = fd.read
```
