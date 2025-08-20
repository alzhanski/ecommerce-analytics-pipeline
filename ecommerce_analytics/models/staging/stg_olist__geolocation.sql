with

source as (
    
    select * from {{ source('raw', 'olist_geolocation_dataset') }}

),

geolocation as (

    select
    
        geolocation_zip_code_prefix as geolocation_zipcode,
        geolocation_city as city,
        geolocation_state as state

    from source
)

select * from geolocation