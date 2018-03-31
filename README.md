
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


## Usage

Go to http://localhost:5601/ and log in with elastic/elasticpw.

All train data will be in the `septa-*` Indexes.


## TODO

- Logrotate on `/var/log/septa-stats` file
- Figure out how to export visualizations from the `.kibana` Index.



