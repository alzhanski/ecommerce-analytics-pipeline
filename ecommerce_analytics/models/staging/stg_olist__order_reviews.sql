with

source as (

    select * from {{ source('raw', 'olist_order_reviews_dataset') }}

),

order_reviews as (

    select 

        review_id,
        order_id,
        review_score,
        coalesce(review_comment_title, 'Not Provided') as review_comment_title,
        coalesce(review_comment_message, 'Not Provided') as review_comment_message,
        review_creation_date as review_sent_at,
        review_answer_timestamp as review_answered_at,
        row_number() OVER (
            PARTITION BY review_id
            ORDER BY order_id
        ) as rn

    from source
    
)

select 

    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_sent_at,
    review_answered_at

from order_reviews

where rn = 1
