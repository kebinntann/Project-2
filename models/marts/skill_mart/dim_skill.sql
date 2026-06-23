select
    skill_id,
    skills,
    type   
from
    {{ source('main', 'skills_dim')}}