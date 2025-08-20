with

source as (
  
    select * from {{ source('raw', 'olist_customers_dataset') }}

),

customers as (

    select

        customer_unique_id,
        customer_id,
        customer_zip_code_prefix as customer_zipcode,
        customer_city as city,
        customer_state as city_state
        
    from source

)

select * from customers


