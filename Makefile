
all:
	@echo "#"
	@echo "# 1) Run 'make download' to download X-Pack!"
	@echo "# 2) Run 'make setup' to run Ansible against the Vagrant instance."
	@echo "# 3) Run 'vagrant ssh' and then '/vagrant/ansible/install-x-pack.sh /vagrant/x-pack-6.2.2.zip'"
	@echo "#"

download:
	@wget --no-clobber https://artifacts.elastic.co/downloads/packs/x-pack/x-pack-6.2.2.zip

setup:
	@vagrant up
	@cd ansible && ansible-playbook -i ./inventory ./playbook.yml
	@echo "# "
	@echo "# Ansible is complete!  At this point, you should be able to log into Kibana"
	@echo "# at http://localhost:5601/ with the login/pw elastic/elasticpw"
	@echo "# "
	@echo "# If you want things like Machine Learning (ML), your next step"
	@echo "# is to type 'vagrant ssh' to SSH in and install X-Pack:"
	@echo "# "
	@echo "# /vagrant/ansible/install-x-pack.sh /vagrant/x-pack-6.2.2.zip"
	@echo "# "
	@echo "# Good luck, we're all counting on you!"
	@echo "# "


