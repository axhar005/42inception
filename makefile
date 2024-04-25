# Chemin relatif au fichier docker-compose.yml depuis le dossier srcs
DC_FILE = srcs/docker compose.yml

# Commande de base pour Docker Compose
DC = docker compose $(DC_FILE)

.PHONY: up down build

# Démarrer les services en mode détaché
up:
	$(DC) up -d

# Arrêter les services
down:
	$(DC) down

# Reconstruire les services
build:
	$(DC) build

# Afficher les logs des services
logs:
	$(DC) logs

# Arrêter et supprimer les volumes
clean:
	$(DC) down -v
