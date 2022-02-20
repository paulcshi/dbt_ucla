
{{ config(materialized='table') }}


select * from SAKILA_RAW.MYSQL_RDS_SAKILA.ACTOR
where _fivetran_deleted = FALSE
