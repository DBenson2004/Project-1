SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE IF NOT EXISTS Student	(
	stuId		varchar(6),
	lastName	varchar(20)  NOT NULL,
	firstName 	varchar(20)  NOT NULL,
	major		varchar(10),
	credits  	integer DEFAULT 0,
	CONSTRAINT Student_stuId_pk PRIMARY KEY (stuId),
CONSTRAINT Student_credits_cc CHECK ((credits>=0) AND (credits < 150))); 

CREATE TABLE IF NOT EXISTS Faculty	(
	facId		varchar(6),
	name	 	varchar(20)  NOT NULL,
	department	varchar(20),
	title 		varchar(10),
	CONSTRAINT Faculty_facId_pk PRIMARY KEY (facId));

CREATE TABLE IF NOT EXISTS Class	(
	classNumber	varchar(8),
	facId	 	varchar(6)  NOT NULL,
	schedule  	varchar(8),
	room		varchar(6),
	CONSTRAINT Class_classNumber_pk PRIMARY KEY (classNumber),
	CONSTRAINT Class_facId_fk FOREIGN KEY (facId) REFERENCES Faculty (facId),
	CONSTRAINT Class_schedule_room_uk UNIQUE (schedule, room));

CREATE TABLE IF NOT EXISTS Enroll	(
	stuId		varchar(6),	
	classNumber	varchar(8),
	grade		varchar(2),
	CONSTRAINT Enroll_classNumber_stuId_pk PRIMARY KEY (classNumber, stuId),
	CONSTRAINT Enroll_classNumber_fk FOREIGN KEY (classNumber) REFERENCES Class (classNumber) ON DELETE CASCADE, -- RESTRICT | CASCADE | SET NULL | NO ACTION | SET DEFAULT	
	CONSTRAINT Enroll_stuId_fk FOREIGN KEY (stuId) REFERENCES Student (stuId)
		ON DELETE CASCADE);

INSERT INTO STUDENT VALUES('S1001','Smith','Tom','History',90);
INSERT INTO STUDENT VALUES('S1002','Chin','Ann','Math',36);
INSERT INTO STUDENT VALUES('S1005','Lee','Perry','History',3);
INSERT INTO STUDENT VALUES('S1010','Burns','Edward','Art',63);
INSERT INTO STUDENT VALUES('S1013','McCarthy','Owen','Math',0);
INSERT INTO STUDENT VALUES('S1015','Jones','Mary','Math',42);
INSERT INTO STUDENT VALUES('S1020','Rivera','Jane','CSC',15);

INSERT INTO FACULTY VALUES('F101','Adams','Art','Professor');
INSERT INTO FACULTY VALUES('F105','Tanaka','CSC','Instructor');
INSERT INTO FACULTY VALUES('F110','Byrne','Math','Assistant');
INSERT INTO FACULTY VALUES('F115','Smith','History','Associate');
INSERT INTO FACULTY VALUES('F221','Smith','CSC','Professor');

INSERT INTO CLASS VALUES('ART103A','F101','MWF9','H221');
INSERT INTO CLASS VALUES('CSC201A','F105','TuThF10','M110');
INSERT INTO CLASS VALUES('CSC203A','F105','MThF12','M110');
INSERT INTO CLASS VALUES('HST205A','F115','MWF11','H221');
INSERT INTO CLASS VALUES('MTH101B','F110','MTuTh9','H225');
INSERT INTO CLASS VALUES('MTH103C','F110','MWF11','H225');


INSERT INTO ENROLL VALUES('S1001','ART103A','A');
INSERT INTO ENROLL VALUES('S1001','HST205A','C');
INSERT INTO ENROLL VALUES('S1002','ART103A','D');
INSERT INTO ENROLL VALUES('S1002','CSC201A','F');
INSERT INTO ENROLL VALUES('S1002','MTH103C','B');
INSERT INTO ENROLL(stuId,classNumber) VALUES('S1010','ART103A');
INSERT INTO ENROLL(stuId,classNumber) VALUES('S1010','MTH103C');	
INSERT INTO ENROLL VALUES('S1020','CSC201A','B');
INSERT INTO ENROLL VALUES('S1020','MTH101B','A');

SET FOREIGN_KEY_CHECKS=1;