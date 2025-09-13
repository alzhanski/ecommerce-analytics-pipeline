with

orders_enriched as (

    select * from {{ ref('orders_enriched')}}

),

category_performance as (
    
    select
        category,
        subcategory,
        order_year,
        order_quarter,
        order_month,

        -- Revenue metrics
        round(sum(total_paid)::decimal, 2) as total_revenue,
        count(distinct order_id) as total_orders,

        -- Calculated business metrics
        round(sum(total_paid)::decimal / count(distinct order_id), 2) as avg_order_value,
        round(sum(total_paid)::decimal / count(*), 2) as avg_item_value
    
    from orders_enriched
    group by category, subcategory, order_year, order_quarter, order_month

)

select * from category_performance