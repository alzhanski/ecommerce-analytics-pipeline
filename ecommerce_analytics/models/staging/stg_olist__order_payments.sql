with

source as (

    select * from {{ source('raw', 'olist_order_payments_dataset') }}

),

order_payments as (

    select

        order_id,
        payment_sequential,
        CASE WHEN payment_type = 'boleto' THEN 'bank_ticket' ELSE payment_type END,
        payment_installments as installments,
        round((payment_value / 5.43)::numeric, 2) as paid_amount_us

    from source
)

select * from order_payments