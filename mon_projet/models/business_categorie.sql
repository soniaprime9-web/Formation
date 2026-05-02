{{ config(materialized='view') }}

with source_data as (
  select *
  from {{ source('demodb', 'business_employment') }}
)

select
  source_data.*,
  case
    when source_data."Period" > 2013 then 'nouveau'
    else 'ancien'
  end as classification
from source_data
