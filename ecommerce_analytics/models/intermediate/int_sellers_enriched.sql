-- models/intermediate/sellers/int_sellers_enriched.sql
with

sellers as (

    select * from {{ ref('stg_olist__sellers') }}

),

order_items as (

    select * from {{ ref('stg_olist__order_items') }}

),

orders as (

    select * from {{ ref('stg_olist__orders') }}

),

geolocation as (
    
    select * from {{ ref('stg_olist__geolocation') }}

),

sellers_enriched as (
    select
        s.seller_id,
        s.seller_city,
        s.seller_state,
        s.seller_zipcode,
        g.latitude,
        g.longitude,
        
        -- Sales performance
        count(oi.order_item_id) as total_items_sold,
        count(distinct oi.order_id) as unique_orders,
        count(distinct oi.product_id) as unique_products_sold,
        round(sum(oi.price)::decimal, 2) as total_revenue,
        round(avg(oi.price)::decimal, 2) as avg_item_price,
        
        -- Timing metrics
        min(o.purchased_date) as first_sale_date,
        max(o.purchased_date) as last_sale_date
        
    from sellers s
    left join order_items oi on s.seller_id = oi.seller_id
    left join orders o on oi.order_id = o.order_id
    left join geolocation g on s.seller_zipcode = g.geolocation_zipcode
    
    group by 1, 2, 3, 4, 5, 6
)

select * from sellers_enriched