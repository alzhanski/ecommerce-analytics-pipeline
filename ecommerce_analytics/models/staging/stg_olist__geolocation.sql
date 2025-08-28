with

source as (
    
    select * from {{ source('raw', 'olist_geolocation_dataset') }}

),

geolocation as (

    select
    
        geolocation_zip_code_prefix as geolocation_zipcode,
        avg(geolocation_lat) as latitude,
        avg(geolocation_lng) as longitude

    from source
    group by geolocation_zip_code_prefix
)

select * from geolocation