with

source as (

    select * from {{ source('raw', 'olist_order_items_dataset')}}

),

order_items as (

    select 

        order_id,
        order_item_id,
        product_id,
        seller_id,
        shipping_limit_date as shipping_deadline_date,
        price,
        freight_value
    
    from source
)

select * from order_items