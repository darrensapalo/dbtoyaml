# dbtoyaml

Extends [Pyrseas](https://pyrseas.readthedocs.io/) to be runnable within a docker command.

## Capabilities

- Able to connect to a local docker container that has a postgreSQL service.
- Provided a fish function under `scripts/` folder to easily copy-paste, if you need to run this through multiple microservices.

# Installation

1. [Docker](https://docker.com/), to be able to run the container.

2. [fish](https://fishshell.com/) if you want to be able to use the convenience script in `scripts/`. Otherwise, you'll need to run things manually.

# Usage

### Step 1: Building the docker image

```sh
make build-image
```

### Step 2: Configure

Visit `scripts/generate-schemas.fish` and edit the configurations there.

```fish
###  Configure

# The host of the database (can be docker container name).
set HOST postgres 

# Set this to some local docker network. 
# This will enable the dbtoyaml container to 
# connect to that network, and the postgre DB in that instance.
set NETWORK some-microservice_default

# Database name, user, and password
set DB_NAME some_db_name
set DB_USER postgres
set PGPASSWORD some_password
```

### Generating schemas

```sh
./scripts/generate-schemas.fish
```

You'll have your schemas in the `schemas/` folder.

# Debugging

If nothing happens, your db credentials may be incorrect causing the generation of the `metadata/` folder to be empty. Make sure it is correct.