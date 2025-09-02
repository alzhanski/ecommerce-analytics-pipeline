with

orders as (

    select * from {{ ref('int_orders_enriched') }}

),

order_items as (

    select * from {{ ref('stg_olist__order_items') }}

),

products as (

    select * from {{ ref('stg_olist__products') }}

),

seasonal_trends as (
    select
        -- Time dimensions
        date_trunc('month', o.purchased_date) as order_month,
        extract(year from o.purchased_date) as order_year,
        extract(quarter from o.purchased_date) as order_quarter,
        extract(month from o.purchased_date) as order_month_num,
        
        -- Seasonal groupings (in Brazil)
        case 
            when extract(month from o.purchased_date) in (12, 1, 2) then 'Summer'
            when extract(month from o.purchased_date) in (3, 4, 5) then 'Fall'  
            when extract(month from o.purchased_date) in (6, 7, 8) then 'Winter'
            when extract(month from o.purchased_date) in (9, 10, 11) then 'Spring'
        end as season,
        
        -- Product dimension
        p.category,
        
        -- Revenue metrics
        round(sum(oi.price)::decimal, 2) as total_product_revenue,
        round(sum(oi.freight_value)::decimal, 2) as total_freight_revenue,
        round(sum(oi.price + oi.freight_value)::decimal, 2) as total_revenue,
        round(avg(oi.price + oi.freight_value)::decimal, 2) as avg_order_item_value,
        
        -- Volume metrics
        count(oi.order_item_id) as total_items_sold,
        count(distinct o.order_id) as total_orders,
        count(distinct oi.product_id) as unique_products_sold,
        
        -- Market concentration by time period
        sum(oi.price + oi.freight_value) / 
            sum(sum(oi.price + oi.freight_value)) over (
                partition by date_trunc('month', o.purchased_date)
            ) * 100 as category_market_share_pct,
            
        -- Seasonal comparison metrics
        sum(oi.price + oi.freight_value) / 
            avg(sum(oi.price + oi.freight_value)) over (
                partition by p.category, extract(month from o.purchased_date)
            ) as seasonal_index
        
    from orders o
    inner join order_items oi on o.order_id = oi.order_id
    left join products p on oi.product_id = p.product_id
    
    where p.category != 'unknown'
    
    group by 1, 2, 3, 4, 5, 6
)

select * from seasonal_trends
order by order_year, order_month_num, total_revenue desc