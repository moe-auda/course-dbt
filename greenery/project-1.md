# project 1 answers

How many users do we have?
Answer: 130

'''
select count(*)
from DEV_DB.DBT_MABOUAUDAGMAILCOM.stg_postgres__users
'''


On average, how many orders do we receive per hour?
Answer: 15

'''
SELECT 
    EXTRACT(HOUR FROM CREATED_AT) AS order_hour,
    COUNT(ORDER_ID) AS total_orders,
    AVG(COUNT(ORDER_ID)) OVER () AS avg_orders_per_hour
FROM 
    DEV_DB.DBT_MABOUAUDAGMAILCOM.stg_postgres__orders
GROUP BY 
    order_hour
ORDER BY 
    order_hour;
'''

On average, how long does an order take from being placed to being delivered?
Answer: 93.4 hours

'''
SELECT 
    AVG(DATEDIFF('HOUR', created_at, delivered_at)) AS avg_delivery_time_hours
FROM 
    DEV_DB.DBT_MABOUAUDAGMAILCOM.stg_postgres__orders;
'''

How many users have only made one purchase? Two purchases? Three+ purchases?

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

1 Order	25
2 Orders 28
3+ Orders 71

'''
WITH user_order_counts AS (
    SELECT 
        user_id, 
        COUNT(DISTINCT order_id) AS total_orders
    FROM 
        DEV_DB.DBT_MABOUAUDAGMAILCOM.stg_postgres__orders
    GROUP BY 
        user_id
)
SELECT 
    CASE 
        WHEN total_orders = 1 THEN '1 Order'
        WHEN total_orders = 2 THEN '2 Orders'
        ELSE '3+ Orders'
    END AS order_category,
    COUNT(user_id) AS user_count
FROM 
    user_order_counts
GROUP BY 
    order_category
'''

On average, how many unique sessions do we have per hour?
Answer: 148.041

'''
SELECT 
    EXTRACT(HOUR FROM CREATED_AT) AS order_hour,
    COUNT(distinct SESSION_ID) AS distinct_sessions,
    avg(COUNT(SESSION_ID)) OVER () AS avg_unique_session_per_hour

FROM DEV_DB.DBT_MABOUAUDAGMAILCOM.STG_POSTGRES__EVENTS

GROUP BY 
    order_hour
ORDER BY 
    order_hour;
'''