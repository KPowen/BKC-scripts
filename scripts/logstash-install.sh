#! /bin/bash
#
# Check if logstash exists
#
OUTPUT=$(systemctl status logstash)
if [ -z "$OUTPUT" ]
then
  sudo apt-get install default-jre
  wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
  echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
  cat /etc/apt/sources.list.d/elastic-7.x.list
  deb https://artifacts.elastic.co/packages/7.x/apt stable main
  sudo apt-get update
  sudo apt-get install logstash
  sudo systemctl status logstash
  sleep 2
  sudo systemctl start logstash
sudo lsof -i -P -n | grep LISTEN | grep 9600
touch /etc/logstash/conf.d/logstash.conf
echo -e "input {
  udp {
    host => \"127.0.0.1\"
    port => 10514
    codec => \"json\"
    type => \"rsyslog\"
  }
}

# The Filter pipeline stays empty here. no formatting is done.
# filter { }


# Every single log will be forwarded to ElasticSearch. If you are using another port, you should specify it here.
output {
  if [type] == \"rsyslog\" {
    elasticsearch {
      hosts => [ \"127.0.0.1:9200\" ]
    }
  }
}" > /etc/logstash/conf.d/logstash.conf
ln -s /etc/logstash/conf.d/logstash.conf ./link-logstash.conf
fi

sudo lsof -i -P -n | grep LISTEN
