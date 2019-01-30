--------------------------------------------------------
--  File created - Wednesday-January-30-2019   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table STUDENTS
--------------------------------------------------------

  CREATE TABLE STUDENTS 
   (	"STUDENT_ID" VARCHAR2(250 BYTE), 
	"STUDENT_FIRSTNAME" VARCHAR2(250 BYTE), 
	"STUDENT_LASTNAME" VARCHAR2(250 BYTE), 
	"STUDENT_COURSENAME" VARCHAR2(250 BYTE), 
	"STUDENT_SCORE" NUMBER, 
	"LETTER_GRADE" VARCHAR2(5 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
REM INSERTING into STUDENTS
SET DEFINE OFF;
Insert into STUDENTS (STUDENT_ID,STUDENT_FIRSTNAME,STUDENT_LASTNAME,STUDENT_COURSENAME,STUDENT_SCORE,LETTER_GRADE) values ('S0006','NEW','RAMKI','Physics Calculus',67,'C+');
Insert into STUDENTS (STUDENT_ID,STUDENT_FIRSTNAME,STUDENT_LASTNAME,STUDENT_COURSENAME,STUDENT_SCORE,LETTER_GRADE) values ('S0007','HARRY','POTTER','Physics Calculus',93,'A');
Insert into STUDENTS (STUDENT_ID,STUDENT_FIRSTNAME,STUDENT_LASTNAME,STUDENT_COURSENAME,STUDENT_SCORE,LETTER_GRADE) values ('S0001','JACK','TESTER','Physics',67,null);
Insert into STUDENTS (STUDENT_ID,STUDENT_FIRSTNAME,STUDENT_LASTNAME,STUDENT_COURSENAME,STUDENT_SCORE,LETTER_GRADE) values ('S0002','MIKE','ALLSTON','Programming',60,null);
Insert into STUDENTS (STUDENT_ID,STUDENT_FIRSTNAME,STUDENT_LASTNAME,STUDENT_COURSENAME,STUDENT_SCORE,LETTER_GRADE) values ('S0002','MIKE','ALLSTON','Math',60,null);
Insert into STUDENTS (STUDENT_ID,STUDENT_FIRSTNAME,STUDENT_LASTNAME,STUDENT_COURSENAME,STUDENT_SCORE,LETTER_GRADE) values ('S0002','MIKE','ALLSTON','English',60,null);
Insert into STUDENTS (STUDENT_ID,STUDENT_FIRSTNAME,STUDENT_LASTNAME,STUDENT_COURSENAME,STUDENT_SCORE,LETTER_GRADE) values ('S0002','MIKE','ALLSTON','Physics',60,null);
Insert into STUDENTS (STUDENT_ID,STUDENT_FIRSTNAME,STUDENT_LASTNAME,STUDENT_COURSENAME,STUDENT_SCORE,LETTER_GRADE) values ('S0003','Nicholas','Sanders','Programming',54,null);
Insert into STUDENTS (STUDENT_ID,STUDENT_FIRSTNAME,STUDENT_LASTNAME,STUDENT_COURSENAME,STUDENT_SCORE,LETTER_GRADE) values ('S0003','Nicholas','Sanders','Math',62,null);
Insert into STUDENTS (STUDENT_ID,STUDENT_FIRSTNAME,STUDENT_LASTNAME,STUDENT_COURSENAME,STUDENT_SCORE,LETTER_GRADE) values ('S0003','Nicholas','Sanders','English',97,null);
Insert into STUDENTS (STUDENT_ID,STUDENT_FIRSTNAME,STUDENT_LASTNAME,STUDENT_COURSENAME,STUDENT_SCORE,LETTER_GRADE) values ('S0003','Nicholas','Sanders','Physics',81,null);
Insert into STUDENTS (STUDENT_ID,STUDENT_FIRSTNAME,STUDENT_LASTNAME,STUDENT_COURSENAME,STUDENT_SCORE,LETTER_GRADE) values ('S0004','Christopher','Ingram','Programming',71,null);
Insert into STUDENTS (STUDENT_ID,STUDENT_FIRSTNAME,STUDENT_LASTNAME,STUDENT_COURSENAME,STUDENT_SCORE,LETTER_GRADE) values ('S0004','Christopher','Ingram','Math',53,null);
Insert into STUDENTS (STUDENT_ID,STUDENT_FIRSTNAME,STUDENT_LASTNAME,STUDENT_COURSENAME,STUDENT_SCORE,LETTER_GRADE) values ('S0004','Christopher','Ingram','English',47,null);
Insert into STUDENTS (STUDENT_ID,STUDENT_FIRSTNAME,STUDENT_LASTNAME,STUDENT_COURSENAME,STUDENT_SCORE,LETTER_GRADE) values ('S0004','Christopher','Ingram','Physics',27,null);
Insert into STUDENTS (STUDENT_ID,STUDENT_FIRSTNAME,STUDENT_LASTNAME,STUDENT_COURSENAME,STUDENT_SCORE,LETTER_GRADE) values ('S0005','RAMKI','KRISHNAN','Physics',45,null);
Insert into STUDENTS (STUDENT_ID,STUDENT_FIRSTNAME,STUDENT_LASTNAME,STUDENT_COURSENAME,STUDENT_SCORE,LETTER_GRADE) values ('S0006','NEW','RAMKI','Programming',67,null);
Insert into STUDENTS (STUDENT_ID,STUDENT_FIRSTNAME,STUDENT_LASTNAME,STUDENT_COURSENAME,STUDENT_SCORE,LETTER_GRADE) values ('S0006','NEW','RAMKI','Java Progam  Intro',67,null);
--------------------------------------------------------
--  DDL for Index STUDENT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX STUDENT_PK ON STUDENTS ("STUDENT_ID", "STUDENT_COURSENAME") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Trigger TR_DELETESTUDENT
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER TR_DELETESTUDENT 
BEFORE DELETE ON STUDENTS
FOR EACH ROW
/*
TRIGGER_NAME            : TR_DELETETUDENT
PACKAGE_NAME            : STANDARD
APPLICATION NAME        : PERSONAL PROJECT
OWNER                   : KRIS
AUTHOR                  : KRISHNAN
DATE WRITTEN            : 2-SEP-2018
*****************************************************************************
1-SEP-2018  KRIS  -  Krishnan       Created
-----------------------------------------------------------------------------
Date       User    -------Name-------   -------  Comments  -------------------
*****************************************************************************
*/

/*
*****************************************************************************
Section : 01 - Declare variables
*****************************************************************************
*/
  DECLARE
        PROCESS_NAME              VARCHAR2(250);
	LOCATOR_TEXT              VARCHAR2(250);
	SESSION_USER              VARCHAR2(25);
  BEGIN
   /*
   *****************************************************************************
   SECTION     : 02  -  Initialize Variables and select student_id from Students
                        table
   *****************************************************************************
   */
	PROCESS_NAME              := 'TR_DELETESTUDENT';
	LOCATOR_TEXT              := '';
	SESSION_USER		  := '';
   BEGIN
    /*
   *****************************************************************************
   SECTION     : 03  -  Get session user
   *****************************************************************************
   */
   SELECT 
   user 
   INTO 
   SESSION_USER
   FROM 
   DUAL;
    /*
   *****************************************************************************
   SECTION     : 03  -  Insert a new row into the students_audit table
   *****************************************************************************
   */
     INSERT INTO students_audit
     (student_id, student_firstname, student_lastname, student_coursename, student_score, update_user, update_timestamp)
     VALUES
     (:old.student_id, :old.student_firstname, :old.student_lastname, :old.student_coursename, :old.student_score, session_user, sysdate);
   END;
    /*
   *****************************************************************************
   SECTION     : 04  -  Continue executing program after local exception
   *****************************************************************************
   */
   /*
   **********************************************************************
   SECTION  : 99
   Exception Handling
   **********************************************************************
   */
    EXCEPTION
        /*
        ******************************************************************
        SECTION   :  99-Z
        -
        Handle Database level exceptions WHEN OTHERS
        Insert a row into the RDC_EXCEPTION_LOG
        -
        ******************************************************************
        */
        WHEN OTHERS THEN
         DBMS_OUTPUT.put_line(SQLCODE);
         DBMS_OUTPUT.put_line(SQLERRM(SQLCODE));
END TR_DELETESTUDENT;
/
ALTER TRIGGER TR_DELETESTUDENT ENABLE;
--------------------------------------------------------
--  DDL for Trigger TR_INSERTSTUDENTGRADE
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER TR_INSERTSTUDENTGRADE 
BEFORE INSERT ON STUDENTS
FOR EACH ROW
/*
TRIGGER_NAME            : TR_INSERTSTUDENT
PACKAGE_NAME            : STANDARD
APPLICATION NAME        : PERSONAL PROJECT
OWNER                   : KRIS
AUTHOR                  : KRISHNAN
DATE WRITTEN            : 1-SEP-2018
*****************************************************************************
1-SEP-2018  KRIS  -  Krishnan       Created
-----------------------------------------------------------------------------
Date       User    -------Name-------   -------  Comments  -------------------
*****************************************************************************
*/

/*
*****************************************************************************
Section : 01 - Declare variables
*****************************************************************************
*/
  DECLARE
        PROCESS_NAME              VARCHAR2(250);
	LOCATOR_TEXT              VARCHAR2(250);
  BEGIN
   /*
   *****************************************************************************
   SECTION     : 02  -  Initialize Variables and select student_id from Students
                        table
   *****************************************************************************
   */
	PROCESS_NAME              := 'TR_INSERTSTUDENTGRADE';
	LOCATOR_TEXT              := '';
    /*
   *****************************************************************************
   SECTION     : 03  -  Insert a new row into the Students table having a local
                        exception.
   *****************************************************************************
   */
   BEGIN	
   :new.student_firstname  := UPPER(:new.student_firstname);
   :new.student_lastname   := UPPER(:new.student_lastname);
   :new.student_coursename := INITCAP(:new.student_coursename);
   :new.letter_grade       := FN_GRADERANGE(:new.student_score);
   END;
    /*
   *****************************************************************************
   SECTION     : 04  -  Continue executing program after local exception
   *****************************************************************************
   */
   /*
   **********************************************************************
   SECTION  : 99
   Exception Handling
   **********************************************************************
   */
    EXCEPTION
        /*
        ******************************************************************
        SECTION   :  99-Z
        -
        Handle Database level exceptions WHEN OTHERS
        Insert a row into the RDC_EXCEPTION_LOG
        -
        ******************************************************************
        */
        WHEN OTHERS THEN
         DBMS_OUTPUT.put_line(SQLCODE);
         DBMS_OUTPUT.put_line(SQLERRM(SQLCODE));
END TR_INSERTSTUDENTGRADE;
/
ALTER TRIGGER TR_INSERTSTUDENTGRAD ENABLE;
--------------------------------------------------------
--  DDL for Trigger TR_UPDATESTUDENTGRADE
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER TR_UPDATESTUDENTGRADE 
BEFORE UPDATE ON STUDENTS
FOR EACH ROW
/*
TRIGGER_NAME            : TR_UPDATESTUDENTGRADE
PACKAGE_NAME            : STANDARD
APPLICATION NAME        : PERSONAL PROJECT
OWNER                   : KRIS
AUTHOR                  : KRISHNAN
DATE WRITTEN            : 2-SEP-2018
*****************************************************************************
1-SEP-2018  KRIS  -  Krishnan       Created
-----------------------------------------------------------------------------
Date       User    -------Name-------   -------  Comments  -------------------
*****************************************************************************
*/

/*
*****************************************************************************
Section : 01 - Declare variables
*****************************************************************************
*/
  DECLARE
        PROCESS_NAME              VARCHAR2(250);
	LOCATOR_TEXT              VARCHAR2(250);
	LETTER_GRADE              VARCHAR2(5);
	SCORE		     	  NUMBER;
  BEGIN
   /*
   *****************************************************************************
   SECTION     : 02  -  Initialize Variables and select student_id from Students
                        table
   *****************************************************************************
   */
	PROCESS_NAME              := 'TR_UPDATESTUDENTGRADE';
	LOCATOR_TEXT              := '';
        LETTER_GRADE              := '';
    /*
   *****************************************************************************
   SECTION     : 03  -  Update a new row into the Students table having a local
                        exception.
   *****************************************************************************
   */
   BEGIN	
   :new.student_firstname  := UPPER(:old.student_firstname);
   :new.student_lastname   := UPPER(:old.student_lastname);
   :new.student_coursename := INITCAP(:old.student_coursename);
   :new.letter_grade       := FN_GRADERANGE(:new.student_score);
   END;
    /*
   *****************************************************************************
   SECTION     : 04  -  Continue executing program after local exception
   *****************************************************************************
   */
   /*
   **********************************************************************
   SECTION  : 99
   Exception Handling
   **********************************************************************
   */
    EXCEPTION
        /*
        ******************************************************************
        SECTION   :  99-Z
        -
        Handle Database level exceptions WHEN OTHERS
        Insert a row into the RDC_EXCEPTION_LOG
        -
        ******************************************************************
        */
        WHEN OTHERS THEN
         DBMS_OUTPUT.put_line(SQLCODE);
         DBMS_OUTPUT.put_line(SQLERRM(SQLCODE));
END TR_INSERTSTUDENTGRADE;
/
ALTER TRIGGER TR_UPDATESTUDENTGRADE ENABLE;
--------------------------------------------------------
--  Constraints for Table STUDENTS
--------------------------------------------------------

  ALTER TABLE STUDENTS ADD CONSTRAINT "STUDENT_PK" PRIMARY KEY ("STUDENT_ID", "STUDENT_COURSENAME");
