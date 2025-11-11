/*********************************************************
Script Name: create_tables
Author     : Oybek Alikulov

Script Purpose: 
    This stored procedure is responsible for create new 
    dimension and fact tables
*********************************************************/
CREATE OR ALTER PROCEDURE gold.create_tables AS
BEGIN
	IF OBJECT_ID('gold.dim_cards','U') IS NOT NULL
		DROP TABLE gold.dim_cards;
	CREATE TABLE gold.dim_cards(
		card_key INT IDENTITY(1,1) PRIMARY KEY ,
		card_id INT,
		customer_id INT,
		card_brand NVARCHAR(50),
		card_type NVARCHAR(50),
		card_number NVARCHAR(16),
		expires_date DATE,
		cvv INT,
		open_date DATE,
		credit_limit DECIMAL(10,2)
		);

	IF OBJECT_ID('gold.dim_customer','U') IS NOT NULL
	  DROP TABLE gold.dim_customer;
	CREATE TABLE gold.dim_customer (
	  customer_key INT IDENTITY(1,1) PRIMARY KEY,
	  customer_id INT,
	  birth_year INT,
	  birth_month INT,
	  gender NVARCHAR(15),
	  address NVARCHAR(60),
	  average_income_per_person DECIMAL(10,2),
	  yearly_income DECIMAL(10,2),
	  total_debt DECIMAL(10,2)
	  );


	IF OBJECT_ID('gold.dim_merchants','U') IS NOT NULL
		DROP TABLE gold.dim_merchants;
	CREATE TABLE gold.dim_merchants(
		merchant_key INT IDENTITY(1,1) PRIMARY KEY,
		merchant_id INT,
		merchant_city NVARCHAR(50),
		merchant_state NVARCHAR(50),
		merchant_country NVARCHAR(50),
		zip NVARCHAR(10),
		category_id INT,
		category_description NVARCHAR(100),
		fraud_comitted NVARCHAR(10)
		);


	IF OBJECT_ID('gold.fact_transactions','U') IS NOT NULL
		DROP TABLE gold.fact_transactions;
	CREATE TABLE gold.fact_transactions (
		transaction_id INT,
		customer_key INT,
		card_key INT,
		merchant_key INT,
		transaction_amount DECIMAL(10,2),
		transaction_date DATETIME,
		transaction_method NVARCHAR(50),
		transaction_error NVARCHAR(100));
END;

