{{ config(materialized='table') }}

SELECT 
    {{ dbt_utils.surrogate_key(['f.film_id']) }} as FILM_KEY,
    f.film_id,
	f.title AS film_title,
	l.name AS LANGUAGE,
	c.name AS category_name,
	f.rental_duration,
	f.RENTAL_RATE,
	f.REPLACEMENT_COST,
	f.LENGTH
FROM 
    {{ref('stg_film')}}
JOIN {{ref('stg_language')}}
    ON stg_film.language_id = stg_language.language_id
JOIN {{ref('stg_film_category')}}
    ON stg_film.film_id = stg_film_category.film_id
JOIN {{ref('stg_category')}} 
    ON stg_film_category.category_id = stg_category.category_id
