TRUNCATE TABLE bronze.cards_data;
BULK INSERT bronze.cards_data
FROM 'C:\Users\Oybek\Documents\projects\cards_data.csv'
WITH (
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
	 );

TRUNCATE TABLE bronze.fraud_labels;
BULK INSERT bronze.fraud_labels
FROM 'C:\Users\Oybek\My_projects\fraud_labels.csv'
WITH (
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
	 );

TRUNCATE TABLE bronze.mcc_code;
BULK INSERT bronze.mcc_code
FROM 'C:\Users\Oybek\My_projects\mcc_code.csv'
WITH (
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
	 );

TRUNCATE TABLE bronze.transactions_data;
BULK INSERT bronze.transactions_data
FROM 'C:\Users\Oybek\Documents\projects\transactions_data.csv'
WITH (
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
	 );


