/*************************************************************************
Script Name    : load_gold
Author         : Oybek Alikulov

Script Purpose :
	This stored procedure is responsible for loading the Gold Layer tables 
	from the cleansed and transformed Silver Layer data.
	It performs a full load process (truncate and insert) for all dimension 
	and fact tables in the data warehouse. 
	The procedure builds a star schema structure consisting of customer, 
	card, and merchant dimensions, and a central fact table for transactions.
	TABLOCK is applied during insert operations to enhance load performance.
*************************************************************************/
CREATE OR ALTER PROCEDURE load_gold AS
BEGIN
	PRINT'========================================================='
	PRINT'START LOADING DIMENSION AND FACT TABLES'
	PRINT'========================================================='
	
	DECLARE @start_time DATETIME, @end_time DATETIME,
			@start_loading DATETIME, @end_loading DATETIME;
		
	BEGIN TRY 
		SET @start_loading = GETDATE();

		SET @start_time=GETDATE();
		TRUNCATE TABLE gold.dim_cards
		INSERT INTO gold.dim_cards WITH(TABLOCK) (
			card_id ,
			customer_id ,
			card_brand ,
			card_type ,
			card_number ,
			expires_date ,
			cvv ,
			open_date,
			credit_limit
			)
		SELECT 
			id AS card_id ,
			client_id AS customer_id ,
			card_brand ,
			card_type ,
			card_number ,
			expires AS expires_date ,
			cvv ,
			acct_open_date AS open_date,
			credit_limit
		FROM silver.cards_data;
		SET @end_time=GETDATE();
		PRINT'LOADING DURATION IS '+CAST(DATEDIFF(SECOND,@start_time,@end_time) as NVARCHAR)+' SECONDS'
		PRINT'-------------------------------------------------------'


		SET @start_time=GETDATE();
		TRUNCATE TABLE gold.dim_customer
		INSERT INTO gold.dim_customer WITH(TABLOCK)(
		  customer_id ,
		  birth_year,
		  birth_month ,
		  gender,
		  address,
		  average_income_per_person ,
		  yearly_income,
		  total_debt)
		SELECT 
		  id AS customer_id,
		  birth_year,
		  birth_month,
		  gender,
		  address,
		  per_capita_income AS average_income_per_person,
		  yearly_income,
		  total_debt
		FROM silver.users_data
		SET @end_time=GETDATE();
		PRINT'LOADING DURATION IS '+CAST(DATEDIFF(SECOND,@start_time,@end_time) as NVARCHAR)+' SECONDS'
		PRINT'-------------------------------------------------------'


		SET @start_time=GETDATE();
		TRUNCATE TABLE gold.dim_merchants;
		INSERT INTO gold.dim_merchants WITH(TABLOCK)(
			merchant_id ,
			merchant_city,
			merchant_state ,
			merchant_country,
			zip 
			 )
		SELECT 
			DISTINCT
			merchant_id,
			merchant_city,
			merchant_state,
			merchant_country,
			zip	
		FROM silver.transactions_data 
		
		SET @end_time=GETDATE();
		PRINT'LOADING DURATION IS '+CAST(DATEDIFF(SECOND,@start_time,@end_time) as NVARCHAR)+' SECONDS'
		PRINT'-------------------------------------------------------'


		SET @start_time=GETDATE();
		TRUNCATE TABLE gold.fact_transactions;
		INSERT INTO gold.fact_transactions WITH(TABLOCK)(
			transaction_id ,
			customer_id ,
			card_id ,
			merchant_id ,
			transaction_amount ,
			transaction_date,
			transaction_description ,
			transaction_method ,
			transaction_error ,
			fraud_comitted
		)
		SELECT 
			td.id AS transaction_id,
			td.client_id AS customer_id,
			td.card_id,
			td.merchant_id,
			td.amount AS transaction_amount,
			td.date AS transaction_date,
			mc.description AS transaction_description,
			td.use_chip AS transaction_method,
			td.errors AS transaction_error,
			ISNULL(fl.is_fraud,'Unknown') AS fraud_comitted

		FROM silver.transactions_data td
		LEFT JOIN silver.fraud_labels fl
		ON td.id=fl.transcation_id
		LEFT JOIN silver.mcc_code mc
		ON td.mcc=mc.mcc_code

		SET @end_time=GETDATE();
		PRINT'LOADING DURATION IS '+CAST(DATEDIFF(SECOND,@start_time,@end_time) as NVARCHAR)+' SECONDS'
		PRINT'-------------------------------------------------------'

		PRINT'========================================================='
		SET @end_loading=GETDATE();
		PRINT'TOTAL DURATION IS '+CAST(DATEDIFF(SECOND,@start_loading,@end_loading) as NVARCHAR)+' SECONDS'
		PRINT'========================================================='
	END TRY
	BEGIN CATCH
		PRINT 'ERROR OCCURED DURING LOADING GOLD LAYER'
		PRINT 'ERROR MESSAGE'+ ERROR_MESSAGE()
		PRINT 'ERROR NUMBER' + CAST(ERROR_NUMBER() AS NVARCHAR)
		PRINT 'ERROR STATE' + CAST(ERROR_STATE() AS NVARCHAR)
	END CATCH;
END;
