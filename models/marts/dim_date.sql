with date_spine as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2005-01-01' as date)",
        end_date="cast('2015-12-31' as date)"
    ) }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['date_day']) }} as date_key,
        cast(date_day as date)                              as date_actual,
        cast(date_format(date_day, 'yyyyMMdd') as bigint)   as date_id,

        -- Year / Quarter / Month
        year(date_day)                                      as year_number,
        quarter(date_day)                                   as quarter_number,
        concat('Q', quarter(date_day))                      as quarter_name,
        month(date_day)                                     as month_number,
        date_format(date_day, 'MMMM')                       as month_name,
        date_format(date_day, 'MMM')                        as month_short_name,
        concat(year(date_day), '-', lpad(month(date_day), 2, '0')) as year_month,

        -- Week
        weekofyear(date_day)                                as week_of_year,
        dayofweek(date_day)                                 as day_of_week_number,
        date_format(date_day, 'EEEE')                       as day_of_week_name,
        date_format(date_day, 'EEE')                        as day_of_week_short_name,
        dayofmonth(date_day)                                as day_of_month,
        dayofyear(date_day)                                 as day_of_year,

        -- Flags
        case when dayofweek(date_day) in (1, 7) then true else false end as is_weekend,
        case when dayofweek(date_day) not in (1, 7) then true else false end as is_weekday,

        -- First/Last day helpers
        trunc(date_day, 'MM')                               as first_day_of_month,
        last_day(date_day)                                  as last_day_of_month,
        trunc(date_day, 'YYYY')                             as first_day_of_year

    from date_spine
)

select * from final