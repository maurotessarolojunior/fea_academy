with sales as (
    select * from {{ ref('int_sales_joined') }}
),

customers as (
    select customer_pk, customer_key from {{ ref('dim_customers') }}
),

products as (
    select product_pk, product_key from {{ ref('dim_products') }}
),

locations as (
    select address_pk, location_key from {{ ref('dim_locations') }}
),

salespersons as (
    select salesperson_pk, salesperson_key from {{ ref('dim_salesperson') }}
),

credit_cards as (
    select credit_card_pk, credit_card_key from {{ ref('dim_creditcards') }}
),

dates as (
    select date_actual, date_key from {{ ref('dim_date') }}
),

final as (
    select
        -- Surrogate key
        {{ dbt_utils.generate_surrogate_key(['s.sales_order_detail_pk']) }} as sales_key,

        -- Natural keys
        s.sales_order_detail_pk,
        s.sales_order_pk          as sales_order_header_pk,

        -- Foreign keys (surrogate)
        c.customer_key,
        p.product_key,
        l.location_key,
        sp.salesperson_key,
        cc.credit_card_key,
        d.date_key                as order_date_key,

        -- Foreign keys (natural)
        s.customer_fk,
        s.product_fk,
        s.ship_to_address_fk,
        s.salesperson_fk,
        s.credit_card_fk,
        s.territory_fk,

        -- Datas
        s.order_date,
        s.due_date,
        s.ship_date,

        -- Métricas do item
        s.order_qty,
        s.unit_price,
        s.unit_price_discount,
        s.order_qty * s.unit_price                                as gross_sales,
        s.order_qty * s.unit_price * (1 - s.unit_price_discount) as net_sales,
        s.line_total,

        -- Métricas do pedido
        s.subtotal,
        s.tax_amount,
        s.freight,
        s.total_due,

        -- Atributos do pedido
        s.order_status,
        s.is_online_order,

        -- Metadata
        s.last_updated_at

    from sales s
    left join customers c      on s.customer_fk        = c.customer_pk
    left join products p       on s.product_fk         = p.product_pk
    left join locations l      on s.ship_to_address_fk = l.address_pk
    left join salespersons sp  on s.salesperson_fk     = sp.salesperson_pk
    left join credit_cards cc  on s.credit_card_fk     = cc.credit_card_pk
    left join dates d          on cast(s.order_date as date) = d.date_actual
)

select * from final