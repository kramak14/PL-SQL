CREATE OR REPLACE PROCEDURE SP_EXCEPTION(in_student_id IN varchar2)
/*
PROCEDURE_NAME          : SP_EXCEPTION
PACKAGE_NAME            : STANDARD
APPLICATION NAME        : PERSONAL PROJECT
OWNER                   : KRIS
AUTHOR                  : KRISHNAN
DATE WRITTEN            : 30-AUG-2018
*****************************************************************************
28-AUG-2018  KRIS  -  Krishnan       Created
-----------------------------------------------------------------------------
Date       User    -------Name-------   -------  Comments  -------------------
*****************************************************************************
*/
AS
/*
*****************************************************************************
Section : 01 - Declare variables
*****************************************************************************
*/
	PROCESS_NAME                  varchar2(50);
	LOCATOR_TEXT		      varchar2(250);
        STD_ID                        varchar2(10); 
        STD_FIRSTNAME                 varchar2(250);
        STD_LASTNAME                  varchar2(250);
  BEGIN
   /*
   *****************************************************************************
   SECTION     : 02  -  Initialize Variables and select student_id from Students
                        table
   *****************************************************************************
   */
	PROCESS_NAME              := 'SP_EXCEPTION';
	LOCATOR_TEXT              := '';
        STD_ID                    := ''; 
        STD_FIRSTNAME             := '';  
        STD_LASTNAME              := '';    
    /*
   *****************************************************************************
   SECTION     : 03  -  Insert a new row into the Students table having a local
                        exception.
   *****************************************************************************
   */
   BEGIN	
        SELECT 
        student_id, 
        student_firstname, 
        student_lastname 
        INTO 
        STD_ID, 
        STD_FIRSTNAME, 
        STD_LASTNAME
        FROM Students 
        WHERE 
        student_id = in_student_id;
   DBMS_OUTPUT.PUT_LINE(std_id || ' ' || std_firstname || ' ' || std_lastname);
   EXCEPTION 
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.put_line(SQLCODE);
   	DBMS_OUTPUT.put_line(SQLERRM(SQLCODE)); 
        DBMS_OUTPUT.PUT_LINE('Trapped pre-defined exception');
      WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.put_line(SQLCODE);
   	DBMS_OUTPUT.put_line(SQLERRM(SQLCODE)); 
        DBMS_OUTPUT.PUT_LINE('Trapped TOO_MANY_ROWS user-defined-exception');
      WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(SQLCODE);
   	DBMS_OUTPUT.put_line(SQLERRM(SQLCODE));    
   END;
    /*
   *****************************************************************************
   SECTION     : 04  -  Continue executing program after local exception
   *****************************************************************************
   */
   DBMS_OUTPUT.PUT_LINE('Program execution continues even after a possible SQL error in Section 2');
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
END SP_EXCEPTION;
