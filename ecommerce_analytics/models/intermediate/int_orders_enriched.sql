with

orders as (

    select * from {{ ref('stg_olist__orders') }}
    where order_status = 'delivered'  -- Only include delivered orders

),

order_items as (

    select * from {{ ref('stg_olist__order_items') }}

),

order_payments as (

    select * from {{ ref('stg_olist__order_payments') }}

),

orders_enriched as (
    
    select
        o.order_id,
        o.order_customer_id,
        o.purchased_date,
        o.approved_date,
        o.delivered_carrier_date,
        o.delivered_date,
        o.estimated_delivery_date,
        
        -- Order value metrics
        round(sum(oi.price)::decimal, 2) as total_product_value,
        round(sum(oi.freight_value)::decimal, 2) as total_freight_value,
        round(sum(oi.price + oi.freight_value)::decimal, 2) as total_order_value,
        round(sum(p.payment_value)::decimal, 2) as total_paid,
        
        -- Order composition
        count(oi.order_item_id) as total_items,
        count(distinct oi.product_id) as unique_products,
        count(distinct oi.seller_id) as unique_sellers,
        
        -- Payment info
        string_agg(p.payment_type, ', ') as payment_methods,
        max(p.payment_installments) as max_installments,
        
        -- Delivery performance
        extract(day from o.delivered_date - o.purchased_date) as days_to_deliver,
        extract(day from o.delivered_date - o.estimated_delivery_date) as delivery_vs_estimate_days
        
    from orders o
    inner join order_items oi on o.order_id = oi.order_id  -- Changed to inner join
    left join order_payments p on o.order_id = p.order_id
    
    group by 1, 2, 3, 4, 5, 6, 7
)

select * from orders_enriched