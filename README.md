
# ELK Septa Stats

An ELK-based attempt to pulling down stats from SEPTA's Regional Rail API.
Essentially, I am attempting to do what I did in Splunk for <a href="https://www.SeptaStats.com/">Septa Stats</a>
and do it with ELK.


## Prerequisites

- Vagrant
- Ansible
- Make


## Installation

- Run `make download` to download X-Pack
- Run `make setup` to spin up a Vagrant instance and run Ansible against it
- Run `vagrant ssh` to SSH into the Vagrant instance and then `/vagrant/ansible/install-x-pack.sh /vagrant/x-pack-6.2.2.zip` to install X-Pack for Elasticsearch and Kibana.

Once Ansible is complete, there will be a service in the VM called `septa-get-regional-rail-data`
which will hit the SEPTA Regional Rail API every 50 seconds or so, grab train data, and write it to 
`/var/log/septa-stats`.

### Development

If you are doing development and want to run Ansible by hand, cd into the `ansible/` directory and run:

`ansible-playbook -i ./inventory ./playbook.yml`


## Usage

Go to http://localhost:5601/ and log in with elastic/elasticpw.

All train data will be in the `septa-*` Indexes.


## Peeking under the hood

Here are the major components of this project:

- Filebeat: Used for ingesting data from `/var/log/septa-stats` as well as syslog.
- Logstash: Gets the events from Filebeat, routes them to the correct Index, and massages the data from SEPTA.
- Elasticsearch: The datastore, which is searchable.
- Kibana: Web frontend for searching and graphing the data.
- `septa-get-regional-rail-data` service:
   - This is a PHP script largely lifed from <a href="https://github.com/dmuth/SeptaStats">My SEPTA Stats project</a>.
   - In addition to splitting up the data into seprate JSON lines for each train, it also provides total minutes late for each line and for all train lines.


### Differences from Splunk

There are a few key differences that made development of this system more challenging:

- Increased RAM usage.
   - Splunk consists of a single binary written in C++.  It will run in half a Gig of RAM with no issues.
   - ELK on the other hand has separate pieces, each written in a different technology:
      - Filebeat: GoLang
      - Logstash: JRuby
      - Elasticsearch: Java
      - Kibana: Node.js
      - Total RAM usage for all of the above is 2-4 GB, or 4-8x what Splunk requires
- Reporting challenges
   - Splunk has <a href="https://www.splunk.com/en_us/resources/search-processing-language.html">a very powerful Search Processing Language (SPL)</a>.  While Elasticsearch is pretty impressive under the hood, I feel like the interface in Kibana is lacking.  Instead of a query language, searching is done via a GUI.  That makes it more challenging to create powerful queries.
   - I am also unsure if it is possible to programatically create queries and visualizations, which makes automation a challenge.


## Screenshots

((TODO))


## TODO

- Logrotate on `/var/log/septa-stats` file.
- Figure out how to export visualizations from the `.kibana` Index.
- Figure out how to embed reports in a public-facing website.


