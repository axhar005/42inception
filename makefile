#--- path to the directory containing the docker-compose.yml file ---#
DIR := srcs/


#--- basic Docker Compose command ---#
DC := docker compose -f $(DIR)docker-compose.yml


#--- ps ---#
ps:
	@docker ps


#--- start containers ---#
up:
	@$(DC) up -d


#--- stop containers ---#
down:
	@$(DC) down


#--- restart containers ---#
restart:
	@$(DC) down && $(DC) up -d


#--- build or rebuild services ---#
build:
	@$(DC) build


#--- stop and remove containers, networks, images, and volumes ---#
clean: down
	@$(DC) down --rmi all -v

logs:
	@docker logs srcs-nginx-1
	@docker logs srcs-wordpress-1
	@docker logs srcs-mariadb-1

.PHONY: up down build clean