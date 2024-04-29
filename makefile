#--- path to the directory containing the docker-compose.yml file ---#
DIR := srcs/
DATA_DIR = /home/$(USER)/data
WP_DIR = /home/$(USER)/data/wordpress
MA_DIR = /home/$(USER)/data/mariadb

#--- basic Docker Compose command ---#
DC := docker compose -f $(DIR)docker-compose.yml


#--- directory ---#
$(DATA_DIR): 
	mkdir ${DATA_DIR}

$(WP_DIR): 
	mkdir ${WP_DIR}

$(MA_DIR): 
	mkdir ${MA_DIR}

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

log: ## Shows logs lively in the container
	@cd srcs && docker compose logs --follow --tail 100

log-%: check_docker_status ## Shows logs lively for the selected container
	@cd srcs && while true; do docker compose logs --tail 100 --follow $*; sleep 1; done

.PHONY: up down build clean