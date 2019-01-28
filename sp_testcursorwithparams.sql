CREATE OR REPLACE PROCEDURE SP_TESTCURSORWITHPARAMS
/*
PROCEDURE_NAME          : SP_TESTCURSORWITHPARAMS
PROGRAM_ID              :  
PACKAGE_NAME            : STANDARD
APPLICATION NAME        : PERSONAL PROJECT
OWNER                   : KRIS
AUTHOR                  : KRISHNAN
DATE WRITTEN            : 6-SEP-2018
*****************************************************************************
28-AUG-2018  KRIS  -  Krishnan       Created
-----------------------------------------------------------------------------
Date       User    -------Name-------   -------  Comments  -------------------
*****************************************************************************
*/
AS
/*
*****************************************************************************
Section :01 - LOCAL VARIABLE DECLARATION
*****************************************************************************
*/
	PROCESS_NAME                  varchar2(50);
	LOCATOR_TEXT		      varchar2(250);
        STD_ID                        varchar2(10);
        STD_COURSENAME                varchar2(50);

/*
*****************************************************************************
Section :02 - CURSOR DECLARATION
*****************************************************************************
*/
	CURSOR all_students
	IS
	SELECT 
	student_id, 
	student_firstname, 
	student_lastname, 
	student_coursename, 
	student_score
	FROM
	students;

	CURSOR ONE_STUDENT(STD_ID VARCHAR2)
	IS
	SELECT 
	student_id, 
	student_firstname, 
	student_lastname, 
	student_coursename, 
	student_score
	FROM
	students
	WHERE 
        student_id  = STD_ID;

	CURSOR ONE_STUDENT_COURSE(STD_ID VARCHAR2, STD_COURSENAME VARCHAR2)
	IS
	SELECT 
	student_id, 
	student_firstname, 
	student_lastname, 
	student_coursename, 
	student_score
	FROM
	students
	WHERE 
        student_id          = STD_ID   AND
	student_coursename  = STD_COURSENAME;

	ALL_STD_ROW		ALL_STUDENTS%ROWTYPE;
	ONE_STD_ROW		ONE_STUDENT%ROWTYPE;
	ONE_STDCOURSE_ROW	ONE_STUDENT_COURSE%ROWTYPE;
  BEGIN
   /*
   *****************************************************************************
   SECTION     : 03  -  Initialize Variables 
   *****************************************************************************
   */
	PROCESS_NAME              :=  'SP_TESTCURSORWITHPARAMS';
	LOCATOR_TEXT              :=  '';
        STD_ID                    :=  'S0006';
        STD_COURSENAME            :=  'Physics Calculus';
   /*
   *****************************************************************************
   SECTION     : 04  -  Process ALL_STUDENTS cursor
   *****************************************************************************
   */
    LOCATOR_TEXT  := 'Error Section 02 - From '||PROCESS_NAME||chr(10)||
                     ' while OPENING ALL_STUDENTS cursor';
     OPEN ALL_STUDENTS;
     LOOP
    /*
    ************************************************************************************
    SECTION     : 06    LOOP thru ALL_STUDENTS cursor
    FETCH student data from cursor
    ************************************************************************************
    */
    LOCATOR_TEXT  := 'Error Section 03 - From '||PROCESS_NAME||chr(10)||
                     ' while FETCHING FROM student_grade_cursor';

    FETCH ALL_STUDENTS INTO ALL_STD_ROW;
    EXIT when ALL_STUDENTS%NOTFOUND;
    /*
    ************************************************************************************
    SECTION     : 07     Process Cursor row 
    ************************************************************************************
    */
    DBMS_OUTPUT.PUT_LINE
    (
    ALL_STD_ROW.STUDENT_ID 	      	|| ' ' ||
    ALL_STD_ROW.STUDENT_FIRSTNAME 	|| ' ' ||
    ALL_STD_ROW.STUDENT_LASTNAME  	|| ' ' ||
    ALL_STD_ROW.STUDENT_COURSENAME 	|| ' ' ||
    ALL_STD_ROW.STUDENT_SCORE	
    );
    END LOOP;
    CLOSE ALL_STUDENTS;
   /*
   *****************************************************************************
   SECTION     : 09  -  Process ONE_STUDENT cursor
   *****************************************************************************
   */
    LOCATOR_TEXT  := 'Error Section 09 - From '||PROCESS_NAME||chr(10)||
                     ' while OPENING ONE_STUDENT cursor';
    /*
    *****************************************************************************
    SECTION     : 10  -  Open the ONE_STUDENT cursor
    *****************************************************************************
    */
     OPEN ONE_STUDENT(ALL_STD_ROW.STUDENT_ID);
     LOOP
    /*
    ************************************************************************************
    SECTION     : 11    LOOP thru ONE_STUDENT cursor
    FETCH student data from cursor. 
    ************************************************************************************
    */
    LOCATOR_TEXT  := 'Error Section 11 - From '||PROCESS_NAME||chr(10)||
                     ' while FETCHING FROM ONE_STUDENT cursor';

    FETCH ONE_STUDENT INTO ONE_STD_ROW;
    EXIT when ONE_STUDENT%NOTFOUND;
    /*
    ************************************************************************************
    SECTION     : 12     Process Cursor row 
    ************************************************************************************
    */
    DBMS_OUTPUT.PUT_LINE
    (
    ONE_STD_ROW.STUDENT_ID 	      	|| ' ' ||
    ONE_STD_ROW.STUDENT_FIRSTNAME 	|| ' ' ||
    ONE_STD_ROW.STUDENT_LASTNAME  	|| ' ' ||
    ONE_STD_ROW.STUDENT_COURSENAME 	|| ' ' ||
    ONE_STD_ROW.STUDENT_SCORE	
    );
    END LOOP;
    /*
    *****************************************************************************
    SECTION     : 13  -  Close the ONE_STUDENT cursor
    *****************************************************************************
    */
   CLOSE ONE_STUDENT;	
   DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Indicating that the ONE_STUDENT cursor is closed' || CHR(10));
   /*
   *****************************************************************************
   SECTION     : 14  -  Process ONE_STUDENT_COURSE cursor
   *****************************************************************************
   */
    LOCATOR_TEXT  := 'Error Section 14 - From '||PROCESS_NAME||chr(10)||
                     ' while OPENING ONE_STUDENT_COURSE cursor';
    /*
    *****************************************************************************
    SECTION     : 15  -  Open the ONE_STUDENT_COURSE cursor
    *****************************************************************************
    */
     OPEN ONE_STUDENT_COURSE(ALL_STD_ROW.STUDENT_ID, ALL_STD_ROW.STUDENT_COURSENAME);
     LOOP
    /*
    ************************************************************************************
    SECTION     : 16    LOOP thru ONE_STUDENT_COURSE cursor
    FETCH student data from cursor. 
    ************************************************************************************
    */
    LOCATOR_TEXT  := 'Error Section 11 - From '||PROCESS_NAME||chr(10)||
                     ' while FETCHING FROM ONE_STUDENT_COURSE cursor';

    FETCH ONE_STUDENT_COURSE INTO ONE_STDCOURSE_ROW;
    EXIT when ONE_STUDENT_COURSE%NOTFOUND;
    /*
    ************************************************************************************
    SECTION     : 17     Process Cursor row 
    ************************************************************************************
    */
    DBMS_OUTPUT.PUT_LINE
    (
    ONE_STDCOURSE_ROW.STUDENT_ID 	      		|| ' ' ||
    ONE_STDCOURSE_ROW.STUDENT_FIRSTNAME 		|| ' ' ||
    ONE_STDCOURSE_ROW.STUDENT_LASTNAME	 	 	|| ' ' ||
    ONE_STDCOURSE_ROW.STUDENT_COURSENAME	 	|| ' ' ||
    ONE_STDCOURSE_ROW.STUDENT_SCORE	
    );
    END LOOP;
    /*
    *****************************************************************************
    SECTION     : 13  -  Close the ONE_STUDENT cursor
    *****************************************************************************
    */
   CLOSE ONE_STUDENT_COURSE;	
   DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Indicating that the ONE_STUDENT_COURSE cursor is closed' || CHR(10));	
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

END SP_TESTCURSORWITHPARAMS;
