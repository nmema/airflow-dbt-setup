{% macro test_count(model) %}

{% set compare_model = kwargs.get('compare_model', kwargs.get('arg')) %}

with a as (

    select
        count(*) as count_a
    from {{ model }}

),

b as (

    select
        count(*) as count_b
    from {{ compare_model }}

),

final as (

    select
        (select count_a from a) -
        (select count_b from b) as diff_count

)

select diff_count from final
where diff_count != 0

{% endmacro %}
