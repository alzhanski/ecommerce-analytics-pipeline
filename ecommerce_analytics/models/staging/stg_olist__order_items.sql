with

source as (

    select * from {{ source('raw', 'olist_order_items_dataset')}}

),

order_items as (

    select 

        order_id,
        order_item_id as num_items,
        product_id,
        seller_id,
        shipping_limit_date as shipping_deadline_date,
        round((price / 5.43)::numeric, 2) as price_us,
        round((freight_value / 5.43)::numeric, 2) as freight_price_us
    
    from source
)

select * from order_items