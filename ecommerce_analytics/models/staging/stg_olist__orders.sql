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
        order_approved_at as approved_date,
        order_delivered_carrier_date as received_carrier_date,
        order_delivered_customer_date as delivered_date,
        order_estimated_delivery_date as estimated_delivery_date
    
    from source

)

select * from orders 