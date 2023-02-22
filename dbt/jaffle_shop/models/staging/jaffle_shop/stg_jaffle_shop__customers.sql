-- will only use customers table since
-- customer_deletes table is not located in US

with

source as (

    select * from {{ source('jaffle_shop','customers') }}

),

customers as (

    select
        id as customer_id,
        first_name,
        last_name

    from source

)

select * from customers