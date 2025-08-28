with

orders as (

    select * from {{ ref('int_orders_enriched') }}

),

customers as (

    select * from {{ ref('int_customer_bridge') }}

),

sellers as (

    select * from {{ ref('int_sellers_enriched') }}

),

order_items as (

    select * from {{ ref('stg_olist__order_items') }}

),

products as (
    
    select * from {{ ref('stg_olist__products') }}

),

geographic_sales as (
    select
        -- Geographic dimensions
        c.customer_state,
        c.customer_city,
        s.seller_state,
        s.seller_city,
        
        -- Time dimensions
        date_trunc('quarter', o.purchased_date) as order_quarter,
        extract(year from o.purchased_date) as order_year,
        
        -- Revenue metrics by geography
        sum(oi.price) as total_product_revenue,
        sum(oi.freight_value) as total_freight_revenue,
        sum(oi.price + oi.freight_value) as total_revenue,
        avg(oi.price + oi.freight_value) as avg_order_item_value,
        
        -- Volume metrics
        count(oi.order_item_id) as total_items_sold,
        count(distinct o.order_id) as total_orders,
        count(distinct oi.product_id) as unique_products_sold,
        count(distinct p.category) as unique_categories_sold,
        
        -- Customer behavior by geography
        count(distinct c.customer_unique_id) as unique_customers,
        avg(c.total_orders) as avg_orders_per_customer,
        avg(c.customer_lifespan_days) as avg_customer_lifespan_days,
        
        -- Seller performance by geography
        count(distinct s.seller_id) as unique_sellers,
        avg(s.total_revenue) as avg_seller_revenue,
        avg(s.total_items_sold) as avg_seller_items_sold,
        
        -- Logistics metrics
        avg(o.days_to_deliver) as avg_delivery_days,
        avg(o.delivery_vs_estimate_days) as avg_delivery_variance_days,
        
        -- Cross-state shipping analysis
        case 
            when c.customer_state = s.seller_state then 'intrastate'
            else 'interstate'
        end as shipping_type,
        
        -- Market concentration (will be calculated as percentages)
        sum(oi.price + oi.freight_value) / 
            sum(sum(oi.price + oi.freight_value)) over () * 100 as revenue_share_pct
        
    from orders o
    inner join order_items oi on o.order_id = oi.order_id
    left join customers c on o.order_customer_id = c.order_customer_id
    left join sellers s on oi.seller_id = s.seller_id
    left join products p on oi.product_id = p.product_id
    
    group by 1, 2, 3, 4, 5, 6, 
             case when c.customer_state = s.seller_state then 'intrastate' else 'interstate' end
)

select * from geographic_sales
order by order_year, order_quarter, total_revenue desc