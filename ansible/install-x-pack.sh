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


