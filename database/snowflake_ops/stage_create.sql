-- Create S3 Stage
CREATE OR REPLACE STAGE aws_ext_stage_integration
    URL = 's3://churn-project-roman'
    STORAGE_INTEGRATION = snowflake_churn_s3;

-- Check for S3 files
list @aws_ext_stage_integration;