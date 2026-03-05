with sales_reasons as (
    select * from {{ ref('stg_advworks__sales_reasons') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['sales_reason_pk']) }} as sales_reason_key,
        sales_reason_pk,
        reason_name,
        reason_type,
        sales_reason_modified_date

    from sales_reasons
)

select * from final