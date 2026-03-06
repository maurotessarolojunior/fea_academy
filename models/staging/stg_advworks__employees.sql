with source as (
    select * from {{ source('advworks', 'humanresources_employee') }}
),

renamed as (
    select
        -- Primary Key
        cast(businessentityid as bigint) as employee_pk,
        
        -- Employee Info
        cast(nationalidnumber as bigint) as national_id_number,
        cast(loginid as string) as login_id,
        cast(jobtitle as string) as job_title,
        cast(birthdate as string) as birth_date,
        cast(maritalstatus as string) as marital_status,
        cast(gender as string) as gender,
        cast(hiredate as string) as hire_date,
        cast(salariedflag as boolean) as is_salaried,
        cast(vacationhours as bigint) as vacation_hours,
        cast(sickleavehours as bigint) as sick_leave_hours,
        cast(currentflag as boolean) as is_current,
        cast(organizationnode as string) as organization_node,
        
        -- System columns
        cast(rowguid as string) as rowguid,
        cast(modifieddate as string) as last_updated_at
        
    from source
)

select * from renamed