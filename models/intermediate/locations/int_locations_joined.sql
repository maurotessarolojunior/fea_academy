with
    addresses as (
        select *
        from {{ ref('stg_advworks__addresses') }}
    )

    , state_provinces as (
        select *
        from {{ ref('stg_advworks__state_provinces') }}
    )

    , country_regions as (
        select *
        from {{ ref('stg_advworks__country_regions') }}
    )

    , joined as (
        select
            addresses.address_pk
            , addresses.address_line_1
            , addresses.address_line_2
            , addresses.city
            , addresses.postal_code
            , addresses.spatial_location
            , state_provinces.state_province_pk
            , state_provinces.state_province_name
            , state_provinces.state_province_code
            , country_regions.country_region_pk
            , country_regions.country_name
        from addresses
        left join state_provinces on addresses.state_province_fk = state_provinces.state_province_pk
        left join country_regions on state_provinces.country_region_code = country_regions.country_region_pk
    )

select * from joined