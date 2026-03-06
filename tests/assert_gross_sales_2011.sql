-- Teste do CEO: vendas brutas de 2011 devem ser exatamente $12.646.112,16
-- Este teste retorna linhas se o valor NÃO bater — zero linhas = teste passou

with vendas_2011 as (
    select
        round(sum(gross_sales), 2) as total_gross_sales
    from {{ ref('fct_sales') }}
    where year(order_date) = 2011
)

select total_gross_sales
from vendas_2011
where total_gross_sales != 12646112.16