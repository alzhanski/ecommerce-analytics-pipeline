with

orders_enriched as (

    select * from {{ ref('orders_enriched')}}

),

geographic_performance as (

    select
        customer_state,
        order_year,
        order_quarter,

        round(sum(total_paid)::decimal, 2) as total_revenue,
        count(distinct order_id) as total_orders,
        count(distinct order_customer_id) as unique_customers

    from orders_enriched
    group by customer_state, order_year, order_quarter

)

select * from geographic_performance