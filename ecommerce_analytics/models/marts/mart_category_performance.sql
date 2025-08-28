with

orders as (
    
    select * from {{ ref('int_orders_enriched') }}

),

products as (
   
    select * from {{ ref('int_products_enriched') }}

),

order_items as (

    select * from {{ ref('stg_olist__order_items') }}

),

category_performance as (

    select
        p.category,
        
        -- Time dimensions for trend analysis
        date_trunc('month', o.purchased_date) as order_month,
        extract(year from o.purchased_date) as order_year,
        extract(quarter from o.purchased_date) as order_quarter,
        
        -- Revenue metrics
        round(sum(oi.price)::decimal, 2) as total_product_revenue,
        round(sum(oi.freight_value)::decimal, 2) as total_freight_revenue, 
        round(sum(oi.price + oi.freight_value)::decimal, 2) as total_revenue,
        round(avg(oi.price + oi.freight_value)::decimal, 2) as avg_item_value,
        
        -- Volume metrics
        count(oi.order_item_id) as total_items_sold,
        count(distinct o.order_id) as total_orders,
        count(distinct oi.product_id) as unique_products_in_category,
        
        -- Performance metrics from product enrichment
        round(avg(p.avg_review_score)::decimal, 2) as avg_category_rating,
        sum(p.total_reviews)::integer as total_category_reviews,
        
        -- Market share calculations (will be calculated as percentages)
        sum(oi.price + oi.freight_value) / 
            sum(sum(oi.price + oi.freight_value)) over () * 100 as revenue_market_share_pct,
        count(oi.order_item_id) / 
            sum(count(oi.order_item_id)) over () * 100 as volume_market_share_pct
        
    from products p
    inner join order_items oi on p.product_id = oi.product_id
    inner join orders o on oi.order_id = o.order_id
    
    where p.category != 'unknown'  -- Filter out the 'unknown' orders
    
    group by 1, 2, 3, 4
)

select * from category_performance
order by order_year, order_quarter, order_month, total_revenue desc