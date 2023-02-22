# Airflow + dbt Core Set Up

Guide to use the [Cosmos Project](https://astronomer.github.io/astronomer-cosmos/index.html) to do the T (ELT) with dbt in Apache Airflow.

The warehouse used for this set up is **BigQuery**. 

### Additional Set Up
- Grant `bigquery.tables.create` permission to the Service Account. [Resource](https://stackoverflow.com/questions/67491335/why-do-i-get-the-permission-denied-error-when-creating-a-table-in-bigquery-gcp-c)
- Create a Connection for the Service Account in Airflow (in this case we named it `bigquery_id`). [Resource](https://cloud.google.com/composer/docs/how-to/managing/connections#creating_a_connection_to_another_project)


### TroubleShooting
- The DAG will fail due to ownership in the `dbt/` folder. A workaround is to enter on the webserver container as root user & execute `chown -R airflow dbt/`