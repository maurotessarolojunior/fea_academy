with
    customers as (
        select *
        from {{ ref('stg_advworks__customers') }}
    )

    , persons as (
        select *
        from {{ ref('stg_advworks__persons') }}
    )

    , stores as (
        select *
        from {{ ref('stg_advworks__stores') }}
    )

    , business_entity_address as (
        select *
        from {{ ref('stg_advworks__business_entity_address') }}
    )

    , addresses as (
        select *
        from {{ ref('stg_advworks__addresses') }}
    )

    , joined as (
        select
            customers.customer_pk
            , persons.person_pk
            , persons.first_name
            , persons.last_name
            , persons.person_type
            , stores.store_pk
            , stores.store_name
            , addresses.address_pk
            , addresses.city
            , addresses.postal_code
        from customers
        left join persons on customers.person_fk = persons.person_pk
        left join stores on customers.store_fk = stores.store_pk
        left join business_entity_address on customers.customer_pk = business_entity_address.business_entity_fk
        left join addresses on business_entity_address.address_fk = addresses.address_pk
    )

select * from joined