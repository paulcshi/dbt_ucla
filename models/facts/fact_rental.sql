{{ config(materialized='table') }}


-- select 
--     stg_rental.rental_id, 
--     dim_customer_type_two.customer_key,
--     dim_staff.staff_key,
--     1 as rental_quantity
-- from 
--     {{ref('stg_rental')}}
--     left join {{ref('dim_customer_type_two')}}
--         on stg_rental.customer_id = dim_customer_type_two.customer_id
--     left join {{ref('dim_staff')}}
--         on stg_rental.staff_id = dim_staff.staff_id


SELECT d.DATE_KEY as rental_date_key,
tod.TIMEOFDAY_KEY as rental_timeofday_key,
//HOUR(r.rental_date),
//r.rental_date,
r.rental_id,
c.CUSTOMER_KEY,
f.FILM_KEY,
sd.staff_key,
sl.STORE_LOCATION_KEY,
1 as rental_quantity,
p.amount
-- select count(*)
FROM  
    {{ref('stg_rental')}} r
     JOIN {{ source('dbt_cshih', 'date_dim') }}  d 
        ON to_number(to_varchar(to_date(r.rental_date),'YYYYMMDD')) = d.DATE_KEY
     JOIN {{ source('dbt_cshih', 'timeofday_dim') }} tod 
        ON HOUR(r.rental_date) = tod.HROFDAY AND MINUTE(r.rental_date) = tod.MINOFDAY
     JOIN {{ source('analytics', 'timeofday_dim') }} c 
        ON r.customer_id = c.customer_id
     JOIN {{ref('stg_inventory')}} i 
        ON r.inventory_id = i.inventory_id
     JOIN {{ref('dim_store')}} sl 
        ON i.store_id = sl.STORE_ID
     JOIN {{ref('dim_film')}} f 
        ON  f.film_id = i.film_id
     JOIN {{ref('dim_staff')}} sd 
        ON r.staff_id = sd.STAFF_ID
     JOIN  {{ref('stg_payment')}}" p 
        ON r.rental_id = p.rental_id
        WHERE to_date(r.rental_date) < '2020-01-01' 



