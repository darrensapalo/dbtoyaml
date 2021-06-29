IMAGE_NAME=github.com/darrensapalo/dbtoyaml
TAG=latest

build-image:
	docker build . -t ${IMAGE_NAME}:${TAG}

prepare:
	@mkdir -p metadata
	@echo "Created directory metadata/"

clean: fix-permissions
	@rm -rf metadata
	@echo "Removed directory metadata/"


package-image: prepare
	@docker run --rm --name=dbtoyaml-extractor -d -it --network=${NETWORK} \
		-e DB_NAME=${DB_NAME} -e DB_USER=${DB_USER} -e PGPASSWORD=${PGPASSWORD} \
		-e HOST=${HOST} \
	 	-v "${PWD}/metadata/":/home/usr/dbtoyaml/metadata \
	 	"github.com/darrensapalo/dbtoyaml:latest" \
		-n public ${DB_NAME} \
		-H ${HOST} -U ${DB_USER} \
		--multiple-files

fix-permissions:
	@sudo chown ${USER}:${USER} -R metadata
	@echo "Permissions updated for directory metadata/"

# Example usage
generate: package-image fix-permissions
	@echo "Finished extracting schema. Please see directory metadata/"