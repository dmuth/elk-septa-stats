#!/bin/bash
#
# This script shuts down Elasticsearch and Kibana, and installs X-Pack
#

# Errors are fatal
set -e

echo "# "
echo "# Stopping Elasticsearch..."
echo "# "
systemctl stop elasticsearch

echo "# "
echo "# Stopping Kibana..."
echo "# "
systemctl stop kibana


if test ! -d "/usr/share/elasticsearch/plugins/x-pack/"
then
	echo "# "
	echo "# Installing X-Pack for Elasticsearch."
	echo "# "
	echo "# Some interactive input may be required..."
	echo "# "
	/usr/share/elasticsearch/bin/elasticsearch-plugin install file:///vagrant/x-pack-6.2.2.zip

	echo "# "
	echo "# Setting up passwords..."
	echo "# "
	echo "# For compatability with configuration files in Ansible, we recommend the following:"
	echo "# 	elastic/elasticpw"
	echo "# 	kibana/kibanapw"
	echo "# 	logstash/logstashpw"
	echo "# "
	echo "# Oh, did I mention this is intended for local development ONLY?"
	echo "# If you are putting this installation on the Internet, DO NOT USE THESE PASSWORDS."
	echo "# "
	/usr/share/elasticsearch/bin/x-pack/setup-passwords interactive

else
	echo "# "
	echo "# X-Pack is already installed for Elasticsearch, skipping!"
	echo "# "

fi


if test ! -d "/usr/share/kibana/plugins/x-pack"
then
	echo "# "
	echo "# Installing X-Pack for Kibana."
	echo "# "
	echo "# Some interactive input may be required..."
	echo "# "
	echo "# This may take up 5 minutes.  DON'T PANIC."
	echo "# "
	/usr/share/kibana/bin/kibana-plugin install file:///vagrant/x-pack-6.2.2.zip

else
	echo "# "
	echo "# X-Pack is already installed for Kibana, skipping!"
	echo "# "
fi


echo "# "
echo "# Restarting Elasticsearch..."
echo "# "
systemctl start elasticsearch

echo "# "
echo "# Restarting Kibana..."
echo "# "
systemctl start kibana

echo "# "
echo "# Done!"
echo "# "


