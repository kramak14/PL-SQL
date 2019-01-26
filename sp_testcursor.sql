CREATE OR REPLACE PROCEDURE SP_TESTCURSOR
/*
PROCEDURE_NAME          : SP_TESTCURSOR
PROGRAM_ID              :  
PACKAGE_NAME            : STANDARD
APPLICATION NAME        : PERSONAL PROJECT
OWNER                   : KRIS
AUTHOR                  : KRISHNAN
DATE WRITTEN            : 28-AUG-2018
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
	CURSOR student_grade_cursor IS 
	SELECT 
        student_id, 
        student_firstname, 
	student_lastname, 
	student_coursename, 
	student_score, 
	letter_grade
	FROM 
	Student_Grade;

	student_grade_row	student_grade_cursor%ROWTYPE;
 
  BEGIN
   /*
   *****************************************************************************
   SECTION     : 02  -  Initialize Variables 
   *****************************************************************************
   */
	PROCESS_NAME              := 'SP_TESTCURSOR';
	LOCATOR_TEXT              := '';
   /*
   *****************************************************************************
   SECTION     : 02  -  Process student_grade_cursor
   *****************************************************************************
   */
  
    LOCATOR_TEXT  := 'Error Section 02 - From '||PROCESS_NAME||chr(10)||
                     ' while OPENING student_grade_cursor';
    /*
    *****************************************************************************
    SECTION     : 02  -  Open the student_gradecursor
    *****************************************************************************
    */
     OPEN student_grade_cursor;
     LOOP
    /*
    ************************************************************************************
    SECTION     : 03    LOOP thru Student_Grade_Cursor
    FETCH student data from cursor. 
    ************************************************************************************
    */
    LOCATOR_TEXT  := 'Error Section 03 - From '||PROCESS_NAME||chr(10)||
                     ' while FETCHING FROM student_grade_cursor';

    FETCH student_grade_cursor INTO student_grade_row;
    EXIT when student_grade_cursor%NOTFOUND;
    /*
    ************************************************************************************
    SECTION     : 03     Process Cursor row 
    ************************************************************************************
    */
    DBMS_OUTPUT.PUT_LINE
    (
    student_grade_row.student_id        	|| ' ' || 
    student_grade_row.student_firstname	        || ' ' ||
    student_grade_row.student_lastname          || ' ' || 
    student_grade_row.student_coursename        || ' ' || 
    student_grade_row.student_score             ||'  ' || 
    student_grade_row.letter_grade
    );
    END LOOP;
    /*
    *****************************************************************************
    SECTION     : 02  -  Close the student_grade_cursor
    *****************************************************************************
    */
   --CLOSE student_grade_cursor;	

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

END SP_TESTCURSOR;
