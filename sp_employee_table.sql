CREATE OR REPLACE PROCEDURE SP_EMPLOYEE_TABLE
/*
PROCEDURE_NAME          : SP_EMPLOYEE_TABLE
PACKAGE_NAME            : STANDARD
APPLICATION NAME        : PERSONAL PROJECT
OWNER                   : KRIS
AUTHOR                  : KRISHNAN
DATE WRITTEN            : 29-AUG-2018
*****************************************************************************
28-AUG-2018  KRIS  -  Krishnan       Created
-----------------------------------------------------------------------------
Date       User    -------Name-------   -------  Comments  -------------------
*****************************************************************************
*/
AS
/*
*****************************************************************************
LOCAL VARIABLE DECLARATION
*****************************************************************************
*/
	PROCESS_NAME                  varchar2(50);
	LOCATOR_TEXT		      varchar2(250);
/*
*****************************************************************************
CURSOR DECLARATION
*****************************************************************************
*/
	CURSOR employee_cursor IS 
	SELECT 
        employee_id, 
        first_name, 
	last_name, 
	email,
	department,
	salary
	FROM 
	Employee;

	employee_row	employee_cursor%ROWTYPE;
 
  BEGIN
   /*
   *****************************************************************************
   SECTION     : 02  -  Initialize Variables 
   *****************************************************************************
   */
	PROCESS_NAME              := 'SP_EMPLOYEE_TABLE';
	LOCATOR_TEXT              := '';
   /*
   *****************************************************************************
   SECTION     : 02  -  Process employee_cursor
   *****************************************************************************
   */
  
    LOCATOR_TEXT  := 'Error Section 02 - From '||PROCESS_NAME||chr(10)||
                     ' while processing employee_grade_cursor';
    /*
    *****************************************************************************
    SECTION     : 02  -  Open the employee_cursor
    *****************************************************************************
    */
     OPEN employee_cursor;
     LOOP
    /*
    ************************************************************************************
    SECTION     : 03    LOOP thru employee_cursor
    FETCH employee data from cursor. 
    ************************************************************************************
    */
    LOCATOR_TEXT  := 'Error Section 03 - From '||PROCESS_NAME||chr(10)||
                     ' while FETCHING FROM employee_cursor';

    FETCH employee_cursor INTO employee_row;
    EXIT when employee_cursor%NOTFOUND;
    /*
    ************************************************************************************
    SECTION     : 03     Process Cursor row 
    ************************************************************************************
    */
    DBMS_OUTPUT.PUT_LINE
    (
    employee_row.employee_id || ' ' ||
    employee_row.first_name  || ' ' ||
    employee_row.last_name   || ' ' ||
    employee_row.email       || ' ' ||
    employee_row.department  || ' ' ||
    employee_row.salary
    );
    END LOOP;
    /*
    *****************************************************************************
    SECTION     : 02  -  Close the employee_cursor
    *****************************************************************************
    */
   CLOSE employee_cursor;	

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

        WHEN OTHERS  THEN
         DBMS_OUTPUT.put_line (SQLCODE);
         DBMS_OUTPUT.put_line (SQLERRM(SQLCODE)); 
	 DBMS_OUTPUT.PUT_LINE(LOCATOR_TEXT); 

END SP_EMPLOYEE_TABLE;
