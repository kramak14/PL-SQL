CREATE OR REPLACE PROCEDURE           SP_COPY_TABLE             
/*
PROCEDURE_NAME          : SP_COPY_TABLE
PROGRAM_ID              :  
PACKAGE_NAME            : STANDARD
APPLICATION NAME        : PERSONAL PROJECT
OWNER                   : KRIS
AUTHOR                  : KRISHNAN
DATE WRITTEN            : 27-AUG-2018
*****************************************************************************
27-AUG-2018  KRIS  -  Krishnan       Created
-----------------------------------------------------------------------------
Date       User    -------Name-------   -------  Comments  -------------------
*****************************************************************************

*
Function :
********
-
The procedure will use 
-
---------------------------------------------------------------------------------
Call format :     SP_COPY_TABLE 
---------------------------------------------------------------------------------
ERROR MESSAGES
**************
-
RETURN CODE:
-
0           - Successful Completion of program

1 - 20000   - ORACLE Database errors as reported by SQLCODE on SQL Operation
              They are reported in the table SCENARIO_EXCEPTION_LOG with all traces 
              implemented in the locator variable and related text.
-
*/
IS                              
/*
*****************************************************************************
LOCAL VARIABLE DECLARATION

FILL IN VARIABLES and EXECEPTIONS AS NEEDED LOOKING AT THE FUNCTION

*****************************************************************************
*/
        PROCESS_NAME                  varchar2(50); 
	LOCATOR_TEXT		      varchar2(250);

BEGIN
/*
***************************************************************************** 
START OF PROCEDURE
*****************************************************************************
*/
   /*
   *****************************************************************************
   SECTION - 01 - Initialize Variables
   *****************************************************************************
   */
      PROCESS_NAME                  := 'SP_COPY_TABLE';
      LOCATOR_TEXT                  := '';

   /*
   *****************************************************************************
   SECTION     : 02  -  Create OUTPUT Table
   *****************************************************************************
   */
 
    LOCATOR_TEXT    := 'Error Encountered in Section 02  - From '||PROCESS_NAME||chr(10)||
                       ' while creating the output table.';
 
      INSERT  INTO STUDENT_GRADE
      (
      STUDENT_ID,
      STUDENT_FIRSTNAME,
      STUDENT_LASTNAME,
      STUDENT_COURSENAME,  
      STUDENT_SCORE,
      LETTER_GRADE                    
      )              
      SELECT 
      STUDENT_ID, 
      STUDENT_FIRSTNAME, 
      STUDENT_LASTNAME, 
      STUDENT_COURSENAME, 
      STUDENT_SCORE, 
      FN_GRADERANGE(STUDENT_SCORE) 
      FROM STUDENTS;

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
  

END SP_COPY_TABLE;
/*
*********************************************************************
END of PROCEDURE  SP_COPY_TABLE;
**********************************************************************
*/
/
