with

source as (

    select * from {{ source('raw', 'olist_order_payments_dataset') }}

),

order_payments as (

    select

        order_id,
        payment_sequential,
        CASE WHEN payment_type = 'boleto' THEN 'bank_ticket' ELSE payment_type END,
        payment_installments,
        payment_value
    from source
)

select * from order_payments