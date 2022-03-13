from datetime import timedelta
from typing import Tuple

import requests
from airflow.decorators import dag, task
from airflow.providers.postgres.operators.postgres import PostgresOperator
from pendulum import datetime, DateTime


@dag(
    start_date=datetime(year=2022, month=1, day=1, tz="UTC"),
    schedule_interval=timedelta(hours=3),
    catchup=True,
)
def btc_usd():
    @task
    def extract_rate(**kwargs) -> Tuple:
        execution_date: DateTime = kwargs["execution_date"]
        response = requests.get(
            url="https://api.exchangerate.host/convert",
            params={
                "from": "BTC",
                "to": "USD",
                "date": execution_date.to_date_string(),
            },
        )
        content = response.json()
        return (
            content["query"]["from"],
            content["query"]["to"],
            content["date"],
            content["result"],
        )

    load_rate = PostgresOperator(
        task_id="load_rate",
        sql="""
        INSERT INTO exchange_rates
        VALUES {{ ti.xcom_pull(task_ids='extract_rate') | replace('[', '(') | replace(']', ')') }}
        ON CONFLICT ("from", "to", "date") DO UPDATE SET rate = excluded.rate;
        """,  # noqa: 501,
    )

    extract_rate() >> load_rate


dag = btc_usd()
