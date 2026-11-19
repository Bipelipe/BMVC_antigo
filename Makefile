COMPOSE = docker compose -f  dockercompose.yml --project-directory .

up:
	docker compose up

down: 
	docker compose down

stop:
	docker compose stop
ps:
	docker compose ps

psa: 
	docker compose ps -a

