select
    c.company_id,
    l.location_id
from {{ref('dim_location')}} as l
    inner join {{ref('bridge_loc')}} as m
    on l.job_location = m.job_location
    inner join {{ref('dim_company')}} as c
    on c.company_id = m.company_id