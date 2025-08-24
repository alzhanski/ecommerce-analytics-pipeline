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
        review_answer_timestamp as review_answered_at
      
    from source
    
)

select * from order_reviews