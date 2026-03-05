with source as (
    select * from {{ source('advworks', 'sales_creditcard') }}
),

renamed as (
    select
        -- Primary Key
        cast(creditcardid as bigint) as credit_card_pk,
        
        -- Credit Card Info
        cast(cardtype as string) as card_type,
        cast(cardnumber as bigint) as card_number,
        cast(expmonth as bigint) as exp_month,
        cast(expyear as bigint) as exp_year,
        
        -- System columns
        cast(modifieddate as string) as last_updated_at
        
    from source
)

select * from renamed