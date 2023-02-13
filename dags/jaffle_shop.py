from airflow import DAG
from airflow.datasets import Dataset
from airflow.operators.empty import EmptyOperator
from pendulum import datetime

from cosmos.providers.dbt.task_group import DbtTaskGroup


with DAG(
    dag_id="jaffle_shop",
    start_date=datetime(2022, 11, 27),
    schedule=None,
    doc_md=__doc__,
    catchup=False,
    default_args={"owner": "02-TRANSFORM"},
) as dag:

    pre_dbt_workflow = EmptyOperator(task_id="pre_dbt_workflow")

    jaffle_shop = DbtTaskGroup(
        dbt_project_name="jaffle_shop",
        dbt_root_path="/opt/airflow/dbt",
        conn_id="bigquery_id",
        dbt_args={
            "schema": "public",
            "dbt_executable_path": "/home/airflow/.local/bin/dbt"
        },
        test_behavior="after_each",
    )

    post_dbt_workflow = EmptyOperator(task_id="post_dbt_workflow")

    pre_dbt_workflow >> jaffle_shop >> post_dbt_workflow