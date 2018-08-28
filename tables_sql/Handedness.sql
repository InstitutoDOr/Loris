CREATE TABLE `Handedness` (
`CommentID` varchar(255) NOT NULL default '',
                          `UserID` varchar(255) default NULL,
                          `Examiner` varchar(255) default NULL,
                          `Testdate` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          `Data_entry_completion_status` enum('Incomplete','Complete') NOT NULL default 'Incomplete',
`Date_taken` date default NULL,
`Candidate_Age` varchar(255) default NULL,
`Window_Difference` varchar(255) default NULL,
`WritingLeft` enum('0','2','1','99','98','not_answered') default NULL,
`WritingRight` enum('0','4','5','99','98','not_answered') default NULL,
`Writing` enum('3','not_answered') default NULL,
`DrawingLeft` enum('0','2','1','99','98','not_answered') default NULL,
`DrawingRight` enum('0','4','5','99','98','not_answered') default NULL,
`Drawing` enum('3','not_answered') default NULL,
`ThrowingLeft` enum('0','2','1','99','98','not_answered') default NULL,
`ThrowingRight` enum('0','4','5','99','98','not_answered') default NULL,
`Throwing` enum('3','not_answered') default NULL,
`ScissorsLeft` enum('0','2','1','99','98','not_answered') default NULL,
`ScissorsRight` enum('None','4','5','99','98','not_answered') default NULL,
`Scissors` enum('3','not_answered') default NULL,
`ToothbrushLeft` enum('0','2','1','99','98','not_answered') default NULL,
`ToothbrushRight` enum('0','4','5','99','98','not_answered') default NULL,
`Toothbrush` enum('3','not_answered') default NULL,
`KnifeLeft` enum('0','2','1','99','98','not_answered') default NULL,
`KnifeRight` enum('0','4','5','99','98','not_answered') default NULL,
`Knife` enum('3','not_answered') default NULL,
`SpoonLeft` enum('0','2','1','99','98','not_answered') default NULL,
`SpoonRight` enum('0','4','5','99','98','not_answered') default NULL,
`Spoon` enum('3','not_answered') default NULL,
`BroomLeft` enum('0','2','1','99','98','not_answered') default NULL,
`BroomRight` enum('0','4','5','99','98','not_answered') default NULL,
`Broom` enum('3','not_answered') default NULL,
`StrikingMatchLeft` enum('0','2','1','99','98','not_answered') default NULL,
`StrikingMatchRight` enum('0','4','5','99','98','not_answered') default NULL,
`StrikingMatch` enum('3','not_answered') default NULL,
`OpeningBoxLeft` enum('0','2','1','99','98','not_answered') default NULL,
`OpeningBoxRight` enum('0','4','5','99','98','not_answered') default NULL,
`OpeningBox` enum('3','not_answered') default NULL,
`HandednessTotalLeft` numeric default NULL,
`HandednessTotalLeft_status` enum('not_answered') default NULL,
`HandednessTotalRight` numeric default NULL,
`HandednessTotalRight_status` enum('not_answered') default NULL,
`KickingLeft` enum('0','2','1','99','98','not_answered') default NULL,
`KickingRight` enum('0','4','5','99','98','not_answered') default NULL,
`Kicking` enum('3','not_answered') default NULL,
`CameraLeft` enum('0','2','1','99','98','not_answered') default NULL,
`CameraRight` enum('0','4','5','99','98','not_answered') default NULL,
`Camera` enum('3','not_answered') default NULL,
`BiologicalMom` enum('1','2','3','4','99','97','not_answered') default NULL,
`BiologicalDad` enum('1','2','3','4','99','97','not_answered') default NULL,
`BiologicalBrother1` enum('1','2','3','4','99','97','not_answered') default NULL,
`BiologicalBrother2` enum('1','2','3','4','99','97','not_answered') default NULL,
`BiologicalBrother3` enum('1','2','3','4','99','97','not_answered') default NULL,
`BiologicalSister1` enum('1','2','3','4','99','97','not_answered') default NULL,
`BiologicalSister2` enum('1','2','3','4','99','97','not_answered') default NULL,
`BiologicalSister3` enum('1','2','3','4','99','97','not_answered') default NULL,
`HandednessCategory` enum('1','2','3','4','99','97','not_answered') default NULL,
`EdinburghHandedness` numeric default NULL,
`EdinburghHandedness_status` enum('not_answered') default NULL,
`Notes` varchar(255) default NULL,
`Notes_status` enum('not_answered') default NULL,
`DegreeHandedness` enum('41','42','43','44','45','not_answered') default NULL,
PRIMARY KEY  (`CommentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
REPLACE INTO test_names (Test_name, Full_name, Sub_group) VALUES ('Handedness', 'Handedness', 1);
