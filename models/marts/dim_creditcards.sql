with credit_cards as (
    select * from {{ ref('stg_advworks__credit_cards') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['credit_card_pk']) }} as credit_card_key,
        credit_card_pk,
        card_type,
        card_number,
        exp_month,
        exp_year,
        last_updated_at

    from credit_cards
)

select * from final