select distinct
    job_title,
    job_title_short
from {{source('main', 'job_postings_fact')}}