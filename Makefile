SHELL:=/bin/bash

include .env

start:
	@docker compose up --build --detach

stop:
	@docker compose stop

clean: stop
	@docker compose rm --force --volumes && docker compose down --volumes --rmi local

setup:
	@python -m pip install --upgrade pip
	@pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"
	@pip install -r requirements.txt

storage:
	@docker exec -it `docker ps --filter name=storage -aq` psql -U ${STORAGE_USER}
