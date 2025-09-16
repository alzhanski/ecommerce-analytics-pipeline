with

orders_enriched as (

    select * from {{ ref('orders_enriched')}}

),

geographic_performance as (

    select
        'Brazil' as country,
        customer_state,
        order_year,
        order_quarter,
        order_month,

        
        -- Revenue metrics
        round(sum(total_paid)::decimal, 2) as total_revenue,
        count(distinct order_id) as total_orders,
        count(distinct customer_unique_id) as unique_customers,
        
        -- Calculated business metrics
        round(sum(total_paid)::decimal / count(distinct order_id), 2) as avg_order_value,
        round(sum(total_paid)::decimal / count(distinct customer_unique_id), 2) as avg_customer_value
        

    from orders_enriched
    group by customer_state, order_year, order_quarter, order_month

)

select * from geographic_performance