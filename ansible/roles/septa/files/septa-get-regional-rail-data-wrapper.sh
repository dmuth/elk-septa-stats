#!/bin/bash
#
# Fetch our Regional Trail train info.
#
# A full list of API endpoints can be found at http://www3.septa.org/hackathon/
#

#
# Errors are fatal
#
set -e

#
# Change into this script's directory
#
pushd $(dirname $0) > /dev/null


while true
do

	./septa-get-regional-rail-data.php

	sleep 50

done


