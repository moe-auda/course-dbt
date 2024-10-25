WITH unique_sessions AS (
    SELECT 
        COUNT(DISTINCT session_id) AS total_unique_sessions
    FROM 
        {{ ref('fact_page_views') }}
),
unique_sessions_purchase AS (
    SELECT 
        COUNT(DISTINCT session_id) AS unique_sessions_with_purchase
    FROM 
        {{ ref('fact_page_views') }}
    WHERE 
        checkout = 1
)

SELECT 
    us.total_unique_sessions, 
    usp.unique_sessions_with_purchase,
    (usp.unique_sessions_with_purchase::FLOAT / us.total_unique_sessions) AS purchase_conversion_rate
FROM 
    unique_sessions us, 
    unique_sessions_purchase usp
