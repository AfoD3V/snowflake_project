-- Make S3 integration
CREATE STORAGE INTEGRATION snowflake_churn_s3
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::787262016738:role/snowflake-churn-s3-role'
  STORAGE_ALLOWED_LOCATIONS = ('s3://churn-project-roman');

-- Print info about integration
DESC INTEGRATION snowflake_churn_s3;