with

products as (

    select * from {{ ref('stg_olist__products') }}

),

order_items as (
    
    select * from {{ ref('stg_olist__order_items') }}

),

order_reviews as (

    select * from {{ ref('stg_olist__order_reviews') }}

),

products_enriched as (

    select
        p.product_id,
        p.category,
        
        -- Sales metrics
        count(oi.order_item_id) as total_sales_qty,
        count(distinct oi.order_id) as unique_orders,
        round(sum(oi.price)::decimal, 2) as total_revenue,
        round(avg(oi.price)::decimal, 2) as avg_price,
        
        -- Review metrics
        count(r.review_id) as total_reviews,
        round(avg(r.review_score)::decimal, 2) as avg_review_score,
        
        -- Seller diversity
        count(distinct oi.seller_id) as unique_sellers
        
    from products p
    left join order_items oi on p.product_id = oi.product_id
    left join order_reviews r on oi.order_id = r.order_id
    
    group by 1, 2
)

select * from products_enriched