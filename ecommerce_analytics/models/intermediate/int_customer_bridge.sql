with 

staging_customers as (

    select * from {{ ref('stg_olist__customers') }}

),

enriched_customers as (
    select * from {{ ref('int_customers_enriched') }}
),

customer_bridge as (
    select 
        -- Join keys
        sc.order_customer_id,         -- For joining from orders
        sc.customer_unique_id,        -- For joining to enriched data
        
        -- Basic customer attributes
        sc.customer_city,
        sc.customer_state,
        sc.customer_zipcode,
        
        -- Enriched customer metrics
        ec.total_orders,
        ec.delivered_orders,
        ec.first_order_date,
        ec.last_order_date,
        ec.customer_lifespan_days
        
    from staging_customers sc
    left join enriched_customers ec 
        on sc.customer_unique_id = ec.customer_unique_id
)

select * from customer_bridge