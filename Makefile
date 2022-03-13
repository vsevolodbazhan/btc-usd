include .env

start:
	@docker compose -d

stop:
	@docker compose stop

setup:
	@python -m pip install --upgrade pip
	@pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"
	@pip install -r requirements.txt
