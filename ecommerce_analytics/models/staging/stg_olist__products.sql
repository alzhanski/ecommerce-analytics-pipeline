with

source as (

    select * from {{ source('raw', 'olist_products_dataset') }}

),

products as (

    select

        product_id,
        COALESCE(product_category_name, 'Unknown') as category

    from source

)

select * from products