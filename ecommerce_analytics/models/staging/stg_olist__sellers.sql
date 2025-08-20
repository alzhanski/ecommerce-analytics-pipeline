with

source as (

    select * from {{ source('raw', 'olist_sellers_dataset') }}

),

sellers as (

    select

        seller_id,
        seller_zip_code_prefix as seller_zipcode,
        seller_city,
        seller_state
    
    from source

)

select * from sellers