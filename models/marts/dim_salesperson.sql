with salespersons as (
    select * from {{ ref('stg_advworks__salespersons') }}
),
employees as (
    select * from {{ ref('stg_advworks__employees') }}
),
persons as (
    select * from {{ ref('stg_advworks__persons') }}
),
final as (
    select
        {{ dbt_utils.generate_surrogate_key(['sp.salesperson_pk']) }} as salesperson_key,
        sp.salesperson_pk,
        sp.territory_fk,

        -- Person info
        p.first_name,
        p.last_name,
        p.first_name || ' ' || p.last_name as full_name,

        -- Employee info
        e.job_title,
        e.hire_date,
        e.birth_date,
        e.gender,
        e.marital_status,

        -- Sales metrics
        sp.sales_quota,
        sp.bonus,
        sp.commission_pct,
        sp.sales_ytd,
        sp.sales_last_year,

        -- Metadata
        sp.last_updated_at

    from salespersons sp
    left join employees e on sp.salesperson_pk = e.employee_pk
    left join persons p on e.employee_pk = p.person_pk
)
select * from final