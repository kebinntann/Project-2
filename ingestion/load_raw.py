import pandas as pd
from snowflake.connector.pandas_tools import write_pandas
import snowflake.connector

conn = snowflake.connector.connect(
    user='kebinn',
    password='As_JGPmY2TQ!h76',
    account='pz30598.ap-southeast-1',
    warehouse='dw_marts_wh',
    database='dw_marts',
    schema='main'
)

def ingest(data, name):
    write_pandas(
    conn,
    data,
    name,
    quote_identifiers=False,
)

# COMPANY_DIM
df = pd.read_csv("https://storage.googleapis.com/sql_de/company_dim.csv")
df = df[["company_id", "name"]]
ingest(df,"COMPANY_DIM")

# SKILLS_DIM
df = pd.read_csv('https://storage.googleapis.com/sql_de/skills_dim.csv')
df = df[["skill_id", "skills"]]
ingest(df, "SKILLS_DIM")

# JOB_POSTINGS_FACT
df = pd.read_csv('https://storage.googleapis.com/sql_de/job_postings_fact.csv')
df = df[[
    'job_id'                  ,
    'company_id'              ,
    'job_title_short'         ,
    'job_title'               ,
    'job_location'            ,
    'job_via'                 ,
    'job_schedule_type'       ,
    'job_work_from_home'      ,
    'search_location'         ,
    'job_posted_date'         ,
    'job_no_degree_mention'   ,
    'job_health_insurance'    ,
    'job_country'             ,
    'salary_rate'             ,
    'salary_year_avg'         ,
    'salary_hour_avg'
    ]]
ingest(df, "JOB_POSTINGS_FACT")

# SKILLS_JOB_DIM
df = pd.read_csv('https://storage.googleapis.com/sql_de/skills_job_dim.csv')
df = df[['skill_id', 'job_id']]
ingest(df, "SKILLS_JOB_DIM")