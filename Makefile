
all:
	@echo "#"
	@echo "# Run 'make download' to download X-Pack!"
	@echo "#"


download:
	@wget --no-clobber https://artifacts.elastic.co/downloads/packs/x-pack/x-pack-6.2.2.zip


