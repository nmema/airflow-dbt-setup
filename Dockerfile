FROM apache/airflow:2.5.3

RUN python -m virtualenv dbt_venv

# https://github.com/microsoft/vscode-python/issues/14327
USER root
RUN sed -i 's/false/true/g' dbt_venv/pyvenv.cfg

# Preparing airflow scripts
COPY scripts/entrypoint.sh /custom-entrypoint.sh
COPY dbt-env-requirements.txt /opt/airflow/dbt-env-requirements.txt
RUN chown -R airflow:0 /opt && \
    chmod 755 /custom-entrypoint.sh

# Airflow Env Setup
USER airflow
ENV PATH="/opt/airflow/dags:${PATH}"
ENV PYTHONPATH="/opt/airflow/dags:${PYTHONPATH}"

RUN source dbt_venv/bin/activate && \
    pip install -r /opt/airflow/dbt-env-requirements.txt && \
    deactivate

ENTRYPOINT [ "/custom-entrypoint.sh" ]
CMD []