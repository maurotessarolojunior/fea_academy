with order_reasons as (
    select * from {{ ref('stg_advworks__sales_order_header_sales_reason') }}
),

sales_reasons as (
    select sales_reason_pk, sales_reason_key from {{ ref('dim_salesreason') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['o.sales_order_fk', 'o.sales_reason_fk']) }} as bridge_key,
        o.sales_order_fk,
        sr.sales_reason_key,
        o.sales_reason_fk,
        o.last_updated_at

    from order_reasons o
    left join sales_reasons sr on o.sales_reason_fk = sr.sales_reason_pk
)

select * from final