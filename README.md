# xltv_dev_run #

Docker image that has XLTV installed, mounts your source code and executes compilation using gradle wrapper. 
After compilation it starts XLTV and links the `ext` folder to your plugin.

# Supported tags #

* `latest`, `v1.4.4.1`

# Starting #

```
docker run -p 6516:6516 -v ~/myproject:/data -v ~/xl-licenses:/license -v ~/.xlgradle:/root/.gradle xebialabs/xltv_dev_run
```

where:

* `data`: Mountpoint pointing to root directory of your plugin.
* `xl-licenses`: Folder containing the XLTV license.
* `xlgradle`: Is used to cache gradle dependencies.
