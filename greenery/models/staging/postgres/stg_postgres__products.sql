SELECT
	PRODUCT_ID,
	NAME as product_name,
	PRICE,
	INVENTORY
FROM {{ source('postgres', 'products') }}