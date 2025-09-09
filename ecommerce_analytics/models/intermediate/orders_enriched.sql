with 

customers as (

    select * from {{ ref('customers')}}

),

orders as (

    select * from {{ ref('orders')}}
    where order_status = 'delivered' 
),

order_items as (

    select * from {{ ref('order_items')}}

),

products as (

    select * from {{ ref('products')}}

),

orders_enriched as (

    select
        -- Order details
        o.order_id,
        o.order_customer_id,
        oi.order_item_id as item_sequence,
        oi.total_paid,

        -- Date details
        o.purchased_date,
        extract(year from o.purchased_date) as order_year,
        extract(month from o.purchased_date) as order_month,
        extract(quarter from o.purchased_date) as order_quarter,
        
        -- Customer details
        c.customer_unique_id,
        c.customer_city,
        c.customer_state,

        -- Product category
        p.product_id,
        p.category,
        case  
            -- Fashion & Apparel
            when p.category in (
                'fashion_bags_accessories', 'fashion_childrens_clothes', 'fashion_female_clothing',
                'fashion_male_clothing', 'fashion_shoes', 'fashion_sport', 'fashion_underwear_beach'
            ) then 'Fashion & Apparel'
            
            -- Home & Furniture  
            when p.category in (
                'furniture_bedroom', 'furniture_decor', 'furniture_living_room', 
                'furniture_mattress_and_upholstery', 'office_furniture', 'bed_bath_table',
                'home_comfort', 'home_comfort_2', 'housewares', 'kitchen_dining_laundry_garden_furniture'
            ) then 'Home & Furniture'
            
            -- Electronics & Technology
            when p.category in (
                'computers', 'computers_accessories', 'consoles_games', 'electronics',
                'pc_gamer', 'tablets_printing_image', 'telephony', 'audio', 'cine_photo',
                'small_appliances', 'signaling_and_security'
            ) then 'Electronics & Technology'
            
            -- Construction & Home Improvement
            when p.category in (
                'construction_tools_construction', 'construction_tools_garden', 'construction_tools_lights',
                'construction_tools_safety', 'construction_tools_tools', 'home_construction',
                'garden_tools', 'home_appliances', 'home_appliances_2', 'small_appliances_home_oven_and_coffee',
                'portable_kitchens_and_food_preparers', 'air_conditioning'
            ) then 'Construction & Home Improvement'
            
            -- Health & Personal Care
            when p.category in (
                'health_beauty', 'perfumery', 'diapers_and_hygiene', 'baby'
            ) then 'Health & Personal Care'
            
            -- Books & Media
            when p.category in (
                'books_general_interest', 'books_imported', 'books_technical',
                'cds_dvds_musicals', 'music', 'musical_instruments', 'stationery',
                'dvds_blu_ray'
            ) then 'Books & Media'
            
            -- Sports & Leisure
            when p.category in (
                'sports_leisure', 'toys', 'cool_stuff', 'party_supplies'
            ) then 'Sports & Leisure'
            
            -- Food & Beverages
            when p.category in (
                'food', 'food_drink', 'drinks', 'la_cuisine'
            ) then 'Food & Beverages'
            
            -- Automotive & Transportation
            when p.category in (
                'auto', 'luggage_accessories'
            ) then 'Automotive & Transportation'
            
            -- Business & Industrial
            when p.category in (
                'agro_industry_and_commerce', 'industry_commerce_and_business',
                'market_place', 'security_and_services'
            ) then 'Business & Industrial'
            
            -- Specialty & Other
            when p.category in (
                'art', 'arts_and_craftmanship', 'christmas_supplies', 'flowers',
                'pet_shop', 'watches_gifts', 'fixed_telephony', 'unknown'
            ) then 'Specialty & Other'
            
            else 'Uncategorized'
        end as category_group

    from orders o
    left join customers c on o.order_customer_id = c.order_customer_id
    left join order_items oi on o.order_id = oi.order_id
    left join products p on oi.product_id = p.product_id

)

select * from orders_enriched