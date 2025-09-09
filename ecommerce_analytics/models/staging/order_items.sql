with

source as (

    select * from {{ source('raw', 'olist_order_items_dataset')}}

),

order_items as (

    select 

        order_id,
        order_item_id,
        product_id,
        (price + freight_value) as total_paid
    
    from source
)

select * from order_items