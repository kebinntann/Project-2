select
    js.job_title_short_id,
    j.job_title_id
from {{ref('dim_job_title')}} as j
    inner join {{ref('bridge_job')}} as m
    on j.job_title = m.job_title
    inner join {{ref('dim_job_title_short')}} as js
    on js.job_title_short = m.job_title_short
 