/**********************************************************************************************
Script Name : create_tables
Schema      : bronze
Author      : Oybek Alikulov

Script Purpose:
    This scripts creat new tables for Bronze layer
    Existing tables are dropped and recreated every time when this "bronze.create_tables" procedure is  executed
**********************************************************************************************/

CREATE OR ALTER PROCEDURE bronze.create_tables AS
BEGIN
	PRINT '******************'
	PRINT 'CREATE TABLES'
	PRINT '******************'

	IF OBJECT_ID('bronze.cards_data','U') IS NOT NULL
		DROP TABLE bronze.cards_data;
	CREATE TABLE bronze.cards_data (
			id INT,
			client_id INT,
			card_brand NVARCHAR(50),
			card_type NVARCHAR(50),
			card_number NVARCHAR(50),
			expires DATE,
			cvv INT,
			has_chip NVARCHAR(50),
			num_cards_issued INT,
			credit_limit DECIMAL(10,3),
			acct_open_date DATE,
			year_pin_last_changed DATE,
			card_on_dark_web NVARCHAR(50));


	IF OBJECT_ID('bronze.users_data','U') IS NOT NULL
		DROP TABLE bronze.users_data;
	CREATE TABLE bronze.users_data (
			id INT,
			current_age INT,
			retirement_age INT,
			birth_year INT,
			birth_month INT,
			gender NVARCHAR(50),
			address NVARCHAR(MAX),
			latitude DECIMAL(10,2),
			longitude DECIMAL(10,2),
			per_capita_income DECIMAL(10,3),
			yearly_income DECIMAL(10,3),
			total_debt DECIMAL(10,3),
			credit_score INT,
			num_credit_cards INT);


	IF OBJECT_ID('bronze.transaction_date','U') IS NOT NULL
		DROP TABLE bronze.transaction_date;
	CREATE TABLE bronze.transaction_date (
			id INT,
			date DATE,
			client_id INT,
			card_id INT,
			amount NVARCHAR(20),
			use_chip NVARCHAR(70),
			merchant_id INT,
			merchant_city NVARCHAR(MAX),
			merchant_state NVARCHAR(50),
			zip INT,
			mcc INT,
			errors NVARCHAR(MAX));


	IF OBJECT_ID('bronze.mcc_code','U') IS NOT NULL
		DROP TABLE bronze.mcc_code;
	CREATE TABLE bronze.mcc_code (
			mcc_code INT,
			description NVARCHAR(MAX)
			);


	IF OBJECT_ID('bronze.fraud_labels','U') IS NOT NULL
		DROP TABLE bronze.fraud_labels;
	CREATE TABLE bronze.fraud_labels (
			transcation_id INT,
			is_fraud NVARCHAR(10)
			);
END;
