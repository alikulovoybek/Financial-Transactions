CREATE OR ALTER PROCEDURE silver.create_tables AS
BEGIN
	PRINT '******************'
	PRINT 'CREATE TABLES'
	PRINT '******************'

	IF OBJECT_ID('silver.cards_data','U') IS NOT NULL
		DROP TABLE silver.cards_data;
	CREATE TABLE silver.cards_data (
			id INT,
			client_id INT,
			card_brand NVARCHAR(50),
			card_type NVARCHAR(50),
			card_number BIGINT,
			expires DATE,
			cvv INT,
			has_chip NVARCHAR(50),
			num_cards_issued INT,
			credit_limit DECIMAL(10,2),
			acct_open_date DATE,
			year_pin_last_changed DATE,
			card_on_dark_web NVARCHAR(50),
			dwh_create_date DATETIME2 DEFAULT GETDATE()
			);


	IF OBJECT_ID('silver.users_data','U') IS NOT NULL
		DROP TABLE silver.users_data;
	CREATE TABLE silver.users_data (
			id INT,
			current_age INT,
			retirement_age INT,
			birth_year INT,
			birth_month INT,
			gender NVARCHAR(50),
			address NVARCHAR(200),
			latitude DECIMAL(10,2),
			longitude DECIMAL(10,2),
			per_capita_income DECIMAL(10,2),
			yearly_income DECIMAL(10,2),
			total_debt DECIMAL(10,2),
			credit_score INT,
			num_credit_cards INT,
			dwh_create_date DATETIME2 DEFAULT GETDATE()
			);


	IF OBJECT_ID('silver.transactions_data','U') IS NOT NULL
		DROP TABLE silver.transactions_data;
	CREATE TABLE silver.transactions_data (
			id INT,
			date DATETIME,
			client_id INT,
			card_id INT,
			amount DECIMAL(10,2),
			use_chip NVARCHAR(70),
			merchant_id INT,
			merchant_city NVARCHAR(50),
			merchant_state NVARCHAR(10),
			zip INT,
			mcc INT,
			errors NVARCHAR(50),
			dwh_create_date DATETIME2 DEFAULT GETDATE()
			);


	IF OBJECT_ID('silver.mcc_code','U') IS NOT NULL
		DROP TABLE silver.mcc_code;
	CREATE TABLE silver.mcc_code (
			mcc_code INT,
			description NVARCHAR(MAX),
			dwh_create_date DATETIME2 DEFAULT GETDATE()
			);


	IF OBJECT_ID('silver.fraud_labels','U') IS NOT NULL
		DROP TABLE silver.fraud_labels;
	CREATE TABLE silver.fraud_labels (
			transcation_id INT,
			is_fraud NVARCHAR(10),
			dwh_create_date DATETIME2 DEFAULT GETDATE()
			);
END;
