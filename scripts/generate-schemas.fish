#! /usr/local/bin/fish

function create_target_schema_dir -d "Creates the target directory for the extacted schema"
  set CURRENT_DIR $PWD
  mkdir -p schemas
  mkdir -p "$PWD/schemas/$argv[1]"
end

function copy_source_schema_to_target_dir -d "Copies the newly generated schema to its target directory"
  set CURRENT_DIR $PWD
  cd metadata/schema.public
  set TABLES (ls | grep table)
  cp $TABLES "$CURRENT_DIR/schemas/$argv[1]"
  cd $CURRENT_DIR  
end

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




### Process

# Step 1: Create the place where the schemas will be stored.
create_target_schema_dir $DB_NAME
# Step 2: Generate the schemas.
make generate HOST=$HOST DB_NAME=$DB_NAME DB_USER=$DB_USER PGPASSWORD=$PGPASSWORD NETWORK=$NETWORK
# Step 3: Be cute and wait for a few seconds.
sleep 3
# Step 4: Copy schema to the target directory.
copy_source_schema_to_target_dir $DB_NAME
# Step 5: Clean up metadata folder.
make clean