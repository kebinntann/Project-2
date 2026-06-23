select
    row_number() over(order by job_title) as job_title_id,
    job_title
from {{source('main', 'job_postings_fact')}}
group by job_title