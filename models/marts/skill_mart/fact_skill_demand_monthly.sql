with t as(
    select
        sjd.skill_id,
        date_trunc('month', jpf.job_posted_date)::date as month_start_date,
        jpf.job_title_short,
        -- convert boolean
        case when jpf.job_work_from_home = true then 1 else 0 end as is_remote,
        case when jpf.job_health_insurance = true then 1 else 0 end as has_health_insurance,
        case when jpf.job_no_degree_mention = true then 1 else 0 end as no_degree_mentioned,
    from
        {{source('main', 'job_postings_fact')}} as jpf
    inner join
        {{source('main', 'skills_job_dim')}} as sjd
        on sjd.job_id = jpf.job_id
)
select
    skill_id,
    month_start_date,
    job_title_short,
    count(*) as postings_count,
    sum(is_remote) as remote_postings_count,
    sum(has_health_insurance) as health_insurance_postings_count,
    sum(no_degree_mentioned) as no_degree_mentioned_postings_count
from t
where job_title_short like '%Data%'
group by 
    skill_id,
    month_start_date,
    job_title_short
order by skill_id, month_start_date, job_title_short