select
    row_number() over(order by job_title_short) as job_title_short_id,
    job_title_short
from {{source('main', 'job_postings_fact')}}
group by job_title_short