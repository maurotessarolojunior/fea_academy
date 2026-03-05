with source as (
    select * from {{ source('advworks', 'person_person') }}
),

renamed as (
    select
        -- Primary Key
        cast(businessentityid as bigint) as person_pk,
        
        -- Person Info
        cast(persontype as string) as person_type,
        cast(namestyle as boolean) as name_style,
        cast(title as string) as title,
        cast(firstname as string) as first_name,
        cast(middlename as string) as middle_name,
        cast(lastname as string) as last_name,
        cast(suffix as string) as suffix,
        cast(emailpromotion as bigint) as email_promotion,
        cast(additionalcontactinfo as string) as additional_contact_info,
        cast(demographics as string) as demographics,
        
        -- System columns
        cast(rowguid as string) as rowguid,
        cast(modifieddate as string) as last_updated_at
        
    from source
)

select * from renamed