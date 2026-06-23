select
    jpf.company_id,
    djs.job_title_short_id,
    date_trunc('month', jpf.job_posted_date)::date as month_start_date,
    jpf.job_country,
    count(*) as postings_count,
    median(jpf.salary_year_avg) as median_salary_year,
    min(jpf.salary_year_avg) as min_salary_year,
    max(jpf.salary_year_avg) as max_salary_year
from {{source('main', 'job_postings_fact')}} as jpf
    left join {{ref('dim_job_title_short')}} as djs
    on jpf.job_title_short = djs.job_title_short
where jpf.job_country is not null 
--and jpf.salary_year_avg is not null
group by
    jpf.company_id,
    djs.job_title_short_id,
    date_trunc('month', jpf.job_posted_date)::date,
    jpf.job_country
order by jpf.company_id, djs.job_title_short_id, month_start_date, jpf.job_country