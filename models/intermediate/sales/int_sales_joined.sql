with
    order_items as (
        select *
        from {{ ref('stg_advworks__sales_salesorderdetail') }}
    )

    , orders as (
        select *
        from {{ ref('stg_advworks__sales_salesorderheader') }}
    )

    , joined as (
        select
            order_items.sales_order_detail_pk
            , order_items.product_fk
            , order_items.special_offer_fk
            , order_items.order_quantity
            , order_items.unit_price
            , order_items.unit_price_discount
            , order_items.line_total
            , orders.sales_order_pk
            , orders.customer_fk
            , orders.credit_card_fk
            , orders.territory_fk
            , orders.salesperson_fk
            , orders.ship_to_address_fk
            , orders.order_date
            , orders.due_date
            , orders.ship_date
            , orders.order_status
            , orders.is_online_order
            , orders.subtotal
            , orders.tax_amount
            , orders.freight
            , orders.total_due
            , order_items.last_updated_at
        from order_items
        inner join orders on order_items.sales_order_fk = orders.sales_order_pk
    )

select * from joined