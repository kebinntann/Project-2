select distinct
    company_id,
    job_location
from {{source('main', 'job_postings_fact')}}
