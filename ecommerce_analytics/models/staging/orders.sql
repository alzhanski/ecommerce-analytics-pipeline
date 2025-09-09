with

source as (

    select * from {{ source('raw', 'olist_orders_dataset') }}

),

orders as (

    select

        order_id,
        customer_id as order_customer_id,
        order_status,
        order_purchase_timestamp as purchased_date,
    
    from source

)

select * from orders 