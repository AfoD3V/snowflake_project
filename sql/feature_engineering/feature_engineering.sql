--Create Feature Table--
CREATE OR REPLACE TABLE engineered_data AS
SELECT
    CREDITScore,       
    GEOGRAPHY,      
    GENDER,         
    AGE,               
    TENURE,            
    BALANCE,        
    NUMOFPRODUCTS,     
    HASCRCARD,          
    ISACTIVEMEMBER,     
    ESTIMATEDSALARY,
    COMPLAIN,           
    SATISFACTION_SCORE, 
    CARD_TYPE,                 
    POINT_EARNED,      

    -- 1. Age bucket for easier one hot --
    CASE
         WHEN AGE < 25 THEN 'AGE_<25'
         WHEN AGE BETWEEN 25 AND 34 THEN 'AGE_25_34'
         WHEN AGE BETWEEN 35 AND 44 THEN 'AGE_35_44'
         WHEN AGE BETWEEN 45 AND 54 THEN 'AGE_45_54'
         WHEN AGE BETWEEN 55 AND 64 THEN 'AGE_55_64'
         ELSE 'AGE_65_PLUS'
    END AS AGE_BUCKET,

    -- 2. Feature Salary/Holdings [what's the income to saving correlation]
    IFF(ESTIMATEDSALARY = 0, NULL, BALANCE / ESTIMATEDSALARY) 
    AS BALANCE_TO_SALARY,

    -- 3. Binary flag for high score [1 if >= 800]
    IFF(CREDITScore >= 800, 1, 0)
    AS HIGH_CREDIT_SCORE_FLAG,

    -- 4. Premium Customer [High Balance + Many Products]
    IFF(NUMOFPRODUCTS >= 3 AND BALANCE > 100000, 1, 0) 
    AS PREMIUM_CLIENT_FLAG,

    -- 5. Active Client [Balance >0 and IsActiveMember]
    IFF(ISACTIVEMEMBER = 1 AND BALANCE > 0, 1, 0) 
    AS ACTIVE_WITH_BALANCE,
    CHURNED
FROM STAGING.cleaned_bank_churn;
