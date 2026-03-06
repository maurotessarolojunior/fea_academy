with sales_reasons as (
    select * from {{ ref('stg_advworks__sales_reasons') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['sales_reason_pk']) }} as sales_reason_key,
        sales_reason_pk,
        sales_reason_name,
        reason_type,
        last_updated_at

    from sales_reasons
)

select * from final