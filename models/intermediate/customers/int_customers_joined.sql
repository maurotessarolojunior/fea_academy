with customers as (
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

, joined as (
    select
        customers.customer_pk
        , persons.person_pk
        , persons.first_name
        , persons.middle_name
        , persons.last_name
        , concat_ws(' ',
            persons.first_name,
            persons.middle_name,
            persons.last_name
          )                          as full_name
        , persons.person_type
        , stores.store_pk
        , stores.store_name

        -- Customer type: se tem loja é Reseller, senão é Individual
        , case
            when stores.store_pk is not null then stores.store_name
            else concat_ws(' ', persons.first_name, persons.middle_name, persons.last_name)
          end                        as customer_name

        , case
            when stores.store_pk is not null then 'Reseller'
            else 'Individual'
          end                        as customer_type

    from customers
    left join persons on customers.person_fk = persons.person_pk
    left join stores on customers.store_fk = stores.store_pk
)

select * from joined