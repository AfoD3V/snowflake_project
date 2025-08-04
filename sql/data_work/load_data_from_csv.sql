COPY INTO RAW.customer_churn_raw (
  RowNumber,
  CustomerId,
  Surname,
  CreditScore,
  Geography,
  Gender,
  Age,
  Tenure,
  Balance,
  NumOfProducts,
  HasCrCard,
  IsActiveMember,
  EstimatedSalary,
  Exited,
  Complain,
  Satisfaction_Score,
  Card_Type,
  Point_Earned,
  FILE_NAME
)
FROM (
  SELECT
    t.$1,  -- RowNumber
    t.$2,  -- CustomerId
    t.$3,  -- Surname
    t.$4,  -- CreditScore
    t.$5,  -- Geography
    t.$6,  -- Gender
    t.$7,  -- Age
    t.$8,  -- Tenure
    t.$9,  -- Balance
    t.$10, -- NumOfProducts
    t.$11, -- HasCrCard
    t.$12, -- IsActiveMember
    t.$13, -- EstimatedSalary
    t.$14, -- Exited
    t.$15, -- Complain
    t.$16, -- Satisfaction Score
    t.$17, -- Card Type
    t.$18, -- Point Earned
    METADATA$FILENAME
  FROM @CHURN_PROJECT.STAGING.AWS_EXT_STAGE_INTEGRATION t
)
FILE_FORMAT = (
  TYPE = 'CSV'
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
)
ON_ERROR = 'CONTINUE';

-- Check for data
SELECT * FROM CHURN_PROJECT.RAW.CUSTOMER_CHURN_RAW;
