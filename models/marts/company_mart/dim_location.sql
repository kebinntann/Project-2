select
    row_number() over (order by job_location) as location_id,
    job_location,
    max(job_country) as job_country
from {{source('main', 'job_postings_fact')}}
group by job_location