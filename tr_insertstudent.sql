CREATE OR REPLACE TRIGGER TR_INSERTSTUDENT
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
	PROCESS_NAME              := 'TR_INSERTSTUDENT';
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
END TR_INSERTSTUDENT;
