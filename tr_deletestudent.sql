CREATE OR REPLACE TRIGGER TR_DELETESTUDENT
BEFORE DELETE ON STUDENTS
FOR EACH ROW
/*
TRIGGER_NAME            : TR_DELETESTUDENT
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
