select
    company_id,
    name
from {{source('main', 'company_dim')}}
