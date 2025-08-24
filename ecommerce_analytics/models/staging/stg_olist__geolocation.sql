with

source as (
    
    select * from {{ source('raw', 'olist_geolocation_dataset') }}

),

geolocation as (

    select
    
        geolocation_zip_code_prefix as geo_zipcode,
        geolocation_city as geo_city,
        geolocation_state as geo_state

    from source
)

select * from geolocation