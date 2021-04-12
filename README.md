#### <u>c</u>ore <u>d</u>ata <u>f</u>oundation - local ####
##### v0.1-alpha, April 2021 #####

----------

**Why another *docker-compose* file?** After a catastrophic hardware failure and dev machine replacement,  I opted to try the *docker* route.

The aim of <u>**cdf-local**</u> is to make [re]configuring my development environment easier as well as have the  ability to control local data services with a single "`docker-compose`" command. The initial version uses `docker-compose`, though a *kubernetes* approach is being considered.  As this is my first attempt using docker containers on my dev machine, I'll be looking for more efficient ways in the future. [Any suggestions would be appreciated.] 

These containers are focused on providing the data foundation used in my development environment and will be modified as needed. They are common services I add to many of my projects. I've often at times also just need a data-store to test against without an actual application. So instead of installing all the services locally on my dev machine, I've used docker containers. Of course, my projects that rely on custom resources have those specifics added as needed. Note: This was created on a Windows 10 machine, so it has not yet been tested on other platforms.

----------

#### Installation Steps ####

Pre-reqs: Docker (and docker-compose) should be set up and running correctly.

1. Clone the **cdf-local** repo to your local drive.
2. Create a new external network using docker: `docker network create cdflocal-mesh`. 
3. Change the default user names or passwords in the **.env** file.
4. In the `./server-conf/redis` folder, modify the **redis.conf** file as desired.
5. In the `./server-conf/mongo/docker-entrypoint-initdb.d` folder, modify the **mongo-init.js** file as desired.
6. Update the various `docker-config` files as needed.
7. Run the `./docker-up.ps1` script to execute `docker compose up --build` on the compose files.
8. Run the `./docker-down.ps1` script to shut down all containers as needed.

----------

##### cdf-local `docker-compose` files #####

- **docker-compose-data.yml**
	- [Microsoft SQL Server](https://hub.docker.com/_/microsoft-mssql-server) 
	- [mongo](https://hub.docker.com/_/mongo)
	- [redis](https://hub.docker.com/_/redis) 
		- "alpine helper layer", addresses ([THP issues](https://github.com/docker-library/redis/issues/55))
- **docker-compose-support.yml**
	- [rediscommander](https://hub.docker.com/r/rediscommander/redis-commander)
	- [mongo express](https://hub.docker.com/_/mongo-express)
	- [seq](https://hub.docker.com/r/datalust/seq)
- **docker-compose-azure.yml**
	- Azure Blob Storage Emulator via [Azureite](https://hub.docker.com/_/microsoft-azure-storage-azurite)
- **docker-compose.yml**
	- Used for testing individual resources.
	
----------

##### dockup-up.ps1 script #####

This PowerShell helper script can be used to build or start (`docker compose up`) all containers. Switches:

- `-BuildOnly:$true`, executes `docker compose build` instead of `docker compose up`  
- `-Azure:$true`, adds **docker-compose-azure.yml** file to the `docker compose up` command 
- `-Force:$true`, appends `--force-recreate --renew-anon-volumes` to the `docker compose up` command
- `-Detach:$true`, appends `--detach` to the `docker compose up` command

The companion `docker-down.ps1` runs `docker compose down` on all containers.

----------

##### References & Thanks! #####

Thanks to all the old-hats out there that have been blogging for years and the official sites/documentation that exists. Though this took me a bit longer than I initially forecast, the learning was worth it. Other than the official doc sites, here is a list of sites that continue to assist me in my journey:
 
- [Defining your multi-container application with docker-compose.yml](https://docs.microsoft.com/en-us/dotnet/architecture/microservices/multi-container-microservice-net-applications/multi-container-applications-docker-compose)
- [A Linux Dev Environment on Windows with WSL 2, Docker Desktop and More](https://nickjanetakis.com/blog/a-linux-dev-environment-on-windows-with-wsl-2-docker-desktop-and-more)
- [How to link multiple docker-compose services via network](https://tjtelan.com/blog/how-to-link-multiple-docker-compose-via-network/)
- [How to split your huge Docker Compose into multiple files?](https://medium.com/@piotr.macha/how-to-split-your-huge-docker-compose-into-multiple-files-3c8866e495dd)
- [Docker-Compose mongoDB Prod, Dev, Test](https://onexlab-io.medium.com/docker-compose-mongodb-prod-dev-test-environment-eb1a75675f93)
- [MongoDB container with Docker Compose](https://zgadzaj.com/development/docker/docker-compose/containers/mongodb)
- [How To Configure Redis + Redis Commander + Docker](https://hackernoon.com/how-to-configurate-redis-redis-commander-docker-616136f2)
- [Install and run the Azurite Docker image](https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azurite#install-and-run-the-azurite-docker-image) 
- [eShopOnContainers](https://github.com/dotnet-architecture/eShopOnContainers)

----------
