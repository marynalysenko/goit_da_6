--*************							 Big Query базова відмінність від postgresql  						************************--

-- Example 1 - Date Manipulation and Regular Expressions in BigQuery
SELECT
   CAST(event_timestamp AS STRING) AS event_timestamp_as_string, -- Casting event_timestamp as a string
   TIMESTAMP_MICROS(event_timestamp) AS timestamp_micros, -- Converting timestamp to microseconds
   event_timestamp / event_bundle_sequence_id AS timestamp_ratio,
   DATE(TIMESTAMP_MICROS(event_timestamp)) AS date_from_timestamp, -- Extracting date from a timestamp
   DATE_DIFF(CURRENT_DATE(), DATE(TIMESTAMP_MICROS(event_timestamp)), WEEK) AS date_difference_in_weeks, -- Calculating date difference in weeks
   event_name,
   REGEXP_EXTRACT(event_name, r'([^_]+)$') AS extracted_event_name -- Extracting part of event_name using a regular expression
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`
LIMIT 100;

-- Example 2 - Unnesting Arrays in BigQuery
SELECT
    event_timestamp,
    user_pseudo_id,
    ep
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`
CROSS JOIN UNNEST(event_params) AS ep -- Flattening the array
LIMIT 100;

-- Example 3 - Subquery and UNNEST in BigQuery
SELECT
    event_timestamp,
    user_pseudo_id,
    (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS session_id -- Using a subquery to extract session_id from event_params
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`
LIMIT 100;

-- Example 4 -  Nested Fields in BigQuery
SELECT
    event_timestamp,
    user_pseudo_id,
    (SELECT value.int_value FROM e.event_params WHERE key = 'ga_session_id') AS session_id, 
    geo.continent
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131` e -- accessing nested fields
LIMIT 100;

