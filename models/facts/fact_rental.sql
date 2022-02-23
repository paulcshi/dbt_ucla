{{ config(materialized='table') }}


select 
    stg_rental.rental_id, 
    dim_customer.customer_key,
    dim_staff.staff_key,
    1 as rental_quantity
from 
    {{ref('stg_rental')}}
    left join {{ref('dim_customer')}}
        on stg_rental.customer_id = dim_customer.customer_id
    left join {{ref('dim_staff')}}
        on stg_rental.staff_id = dim_staff.staff_id



-- {{ config(materialized='table') }}

-- select 
--     stg_rental.rental_id,
--     dim_customer.customer_key,
--     dim_staff.staff_key,
--     1 as rental_quantity
-- from
--     {{ ref('stg_rental') }}
--     left join {{ ref('dim_customer') }}
--         on stg_rental.customer_id = dim_customer.customer_id
--     left join {{ ref('dim_staff') }}
--         on stg_rental.staff_id = dim_staff.staff_id



