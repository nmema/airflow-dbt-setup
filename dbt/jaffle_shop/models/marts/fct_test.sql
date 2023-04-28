{{
    config(
        tags=["example"]
    )
}}

with

test as (

    select * from {{ ref('stg_test') }}

)

select * from test
