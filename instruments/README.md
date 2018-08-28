1. mysql -u root -p LORIS < INSTRUMENT.sql

2. RUN SQLS:

	INSERT INTO test_battery (Test_name, AgeMinDays, AgeMaxDays, Active, Stage, SubprojectID, Visit_label, CenterID) VALUES 
		('$test', '0', '99999', 'Y', 'Visit', '1', 'V1', NULL)
		('$test', '0', '99999', 'Y', 'Visit', '2', 'V1', NULL);
        
3. Run tool "php tools/assign_missing_instruments.php" and "php tools/assign_missing_instruments.php confirm"