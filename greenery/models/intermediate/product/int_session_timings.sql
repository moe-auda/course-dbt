select  
    session_id,
    min(created_at) as session_start,
    max(created_at) as session_end
from {{ ref('stg_postgres__events')}}
group by 1