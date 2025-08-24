with

source as (

    select * from {{ source('raw', 'olist_products_dataset') }}

),

translations as (

    select * from {{ source('raw', 'product_category_name_translation') }}

),

products as (

    select

        product_id,
        coalesce(t.product_category_name_english, p.product_category_name, 'unknown') as category

    from source p 
    left join translations t 
        on p.product_category_name = t.product_category_name

)

select * from products