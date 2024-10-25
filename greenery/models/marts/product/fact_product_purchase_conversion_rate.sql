WITH unique_sessions AS (
    SELECT 
        product_id,
        COUNT(DISTINCT session_id) AS total_unique_sessions
    FROM 
        {{ ref('fact_page_views') }}
    GROUP BY 
        product_id
),
unique_sessions_purchase AS (
    SELECT 
        product_id,
        COUNT(DISTINCT session_id) AS unique_sessions_with_purchase
    FROM 
        {{ ref('fact_page_views') }}
    WHERE 
        checkout = 1
    GROUP BY 
        product_id
),
product_details AS (
    SELECT 
        product_id, 
        product_name
    FROM 
        {{ ref('stg_postgres__products') }}
)

SELECT 
    pd.product_id,
    pd.product_name,
    us.total_unique_sessions, 
    usp.unique_sessions_with_purchase,
    COALESCE(
        usp.unique_sessions_with_purchase::FLOAT / NULLIF(us.total_unique_sessions, 0), 
        0
    ) AS purchase_conversion_rate
FROM 
    product_details pd
LEFT JOIN 
    unique_sessions us ON pd.product_id = us.product_id
LEFT JOIN 
    unique_sessions_purchase usp ON pd.product_id = usp.product_id
