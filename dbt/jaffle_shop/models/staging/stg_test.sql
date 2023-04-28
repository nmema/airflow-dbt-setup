{{
    config(
        tags=["example"]
    )
}}

with

test as (

    select 1 as id
    union all
    select 2 as id

)

select * from test
