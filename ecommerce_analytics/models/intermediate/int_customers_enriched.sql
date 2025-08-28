with

customers as (

    select * from {{ ref('stg_olist__customers') }} 

),

orders as (

    select * from {{ ref('stg_olist__orders') }} 

),

geolocation as (

    select * from {{ ref('stg_olist__geolocation')}}

),

customers_enriched as (

    select 
        c.customer_unique_id,
        c.customer_city,
        c.customer_state,
        c.customer_zipcode,
        g.latitude,
        g.longitude,

        count(o.order_id) as total_orders,
        count(case when o.order_status = 'delivered' then 1 end) as delivered_orders,
        min(o.purchased_date) as first_order_date,
        max(o.purchased_date) as last_order_date,
        extract(day from max(o.purchased_date) - min(o.purchased_date)) as customer_lifespan_days
    
    from customers c
    left join orders o on c.order_customer_id = o.order_customer_id
    left join geolocation g on c.customer_zipcode = g.geolocation_zipcode
    
    group by 1, 2, 3, 4, 5, 6

)

select * from customers_enriched 