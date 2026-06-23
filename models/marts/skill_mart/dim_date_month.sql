select distinct
    date_trunc('month', job_posted_date)::date as month_start_date,
    extract(year from job_posted_date) as year,
    extract(month from job_posted_date) as month,
    extract(quarter from job_posted_date) as quarter,
    case
        when extract(quarter from job_posted_date) = 1 then 'Q1'
        when extract(quarter from job_posted_date) = 2 then 'Q2'
        when extract(quarter from job_posted_date) = 3 then 'Q3'
        when extract(quarter from job_posted_date) = 4 then 'Q4'
        else null
    end as quarter_name,
    case
        when extract(quarter from job_posted_date) = 1 then extract(year from job_posted_date) || '-' || 'Q1'
        when extract(quarter from job_posted_date) = 2 then extract(year from job_posted_date) || '-' || 'Q2'
        when extract(quarter from job_posted_date) = 3 then extract(year from job_posted_date) || '-' || 'Q3'
        when extract(quarter from job_posted_date) = 4 then extract(year from job_posted_date) || '-' || 'Q4'
        else null
    end as year_quarter

from {{source('main', 'job_postings_fact')}}
order by month_start_date