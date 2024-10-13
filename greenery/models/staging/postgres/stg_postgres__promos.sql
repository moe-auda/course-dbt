SELECT
	PROMO_ID,
	DISCOUNT,
	STATUS as promo_status
FROM {{ source('postgres', 'promos') }}