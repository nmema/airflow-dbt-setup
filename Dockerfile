FROM apache/airflow:2.5.1

RUN python -m virtualenv dbt_venv

# https://github.com/microsoft/vscode-python/issues/14327
USER root
RUN sed -i 's/false/true/g' dbt_venv/pyvenv.cfg

USER airflow
RUN source dbt_venv/bin/activate && \
    pip install \
        dbt-core \
        dbt-bigquery \
        astronomer-cosmos[dbt.bigquery] && \
    deactivate


EXPOSE 8080

WORKDIR /opt/airflow

COPY dbt/ dbt/
COPY dags/ dags/

COPY ./init.sh .

# RUN chmod +x init.sh

ENTRYPOINT ["bash", "init.sh" ]