CREATE TABLE `Cognition` (
`CommentID` varchar(255) NOT NULL default '',
                          `UserID` varchar(255) default NULL,
                          `Examiner` varchar(255) default NULL,
                          `Testdate` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          `Data_entry_completion_status` enum('Incomplete','Complete') NOT NULL default 'Incomplete',
`Date_taken` date default NULL,
`Candidate_Age` varchar(255) default NULL,
`Window_Difference` varchar(255) default NULL,
`FSIQ` numeric default NULL,
`FSIQ_status` enum('not_answered') default NULL,
`VIQ` numeric default NULL,
`VIQ_status` enum('not_answered') default NULL,
`PIQ` numeric default NULL,
`PIQ_status` enum('not_answered') default NULL,
`VCI` numeric default NULL,
`VCI_status` enum('not_answered') default NULL,
`POI` numeric default NULL,
`POI_status` enum('not_answered') default NULL,
`WMI` numeric default NULL,
`WMI_status` enum('not_answered') default NULL,
`PSI` numeric default NULL,
`PSI_status` enum('not_answered') default NULL,
`IQ_measure` varchar(255) default NULL,
`IQ_measure_status` enum('not_answered') default NULL,
`IQ_date` date default NULL,
`IQ_date_status` enum('not_answered') default NULL,
`IQ_testing_site` enum('fts','UCSF','UQ','IDOR','Caltech') default NULL,
`PictureComp_SS` numeric default NULL,
`PictureComp_SS_status` enum('not_answered') default NULL,
`Vocab_SS` numeric default NULL,
`Vocab_SS_status` enum('not_answered') default NULL,
`DigitSymbolCoding_SS` numeric default NULL,
`DigitSymbolCoding_SS_status` enum('not_answered') default NULL,
`Similarities_SS` numeric default NULL,
`Similarities_SS_status` enum('not_answered') default NULL,
`BlockDesign_SS` numeric default NULL,
`BlockDesign_SS_status` enum('not_answered') default NULL,
`ArithmeticSS` numeric default NULL,
`ArithmeticSS_status` enum('not_answered') default NULL,
`MatrixReasoning_SS` numeric default NULL,
`MatrixReasoning_SS_status` enum('not_answered') default NULL,
`DigitSpan_SS` numeric default NULL,
`DigitSpan_SS_status` enum('not_answered') default NULL,
`Information_SS` numeric default NULL,
`Information_SS_status` enum('not_answered') default NULL,
`PictureArrangement_SS` numeric default NULL,
`PictureArrangement_SS_status` enum('not_answered') default NULL,
`Comprehension_SS` numeric default NULL,
`Comprehension_SS_status` enum('not_answered') default NULL,
`SymbolSearch_SS` numeric default NULL,
`SymbolSearch_SS_status` enum('not_answered') default NULL,
`LetterNumber_SS` numeric default NULL,
`LetterNumber_SS_status` enum('not_answered') default NULL,
PRIMARY KEY  (`CommentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
REPLACE INTO test_names (Test_name, Full_name, Sub_group) VALUES ('Cognition', 'Cognition', 1);