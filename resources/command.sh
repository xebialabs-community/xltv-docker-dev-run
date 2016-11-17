#!/usr/bin/env sh

# Copy downloads into 'plugins'
if [ -d "/data/build/downloads/plugins" ]; then
    cp /data/build/downloads/plugins/* /opt/xltv/server/plugins
fi

# Copy to plugins
cp /data/build/libs/*.jar /opt/xltv/server/plugins

# Link `ext` folder
find /data/src/main/resources -maxdepth 1 -mindepth 1 -type d -exec ln -s -f '{}' /opt/xltv/server/ext/ \;

count=0
mkdir -p /opt/xltv/server/log
touch /opt/xltv/server/log/xl-testview.log
nohup /opt/xltv/server/bin/server.sh > /opt/xltv/server/log/xl-testview.log 2>&1 & echo $! > /tmp/run.pid
while true
do
  if [ $count -le 60 ]; then

    wget --spider -q http://localhost:6516
    if [ $? -ne 0 ] ;then 
      echo "waiting $count"
      tail -1 /opt/xltv/server/log/xl-testview.log
      sleep 4
      count=$(( count+1 ))
    else 
      echo "Loading test data..."
      if [ -f /data/build/resources/test/docker/initialize/initialize_data.sh ]; then
         /data/build/resources/test/docker/initialize/initialize_data.sh
         if [ $? -ne 0 ]; then
           exit $?
         fi
      fi
      echo "Shutting down server..."
      kill `cat /tmp/run.pid`
      sleep 3
      echo "Done."
      exit
    fi
  else
    echo "Timeout exceeded...giving up waiting for website"
    exit 1
  fi
done
