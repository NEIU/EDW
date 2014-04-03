@echo off
rem
rem AUDIT TRAIL: 1.0
rem 1. RLZ  05/10/2006      Initial Version
rem 1. RLZ  06/01/2006      remove redandent parameters
rem
rem AUDIT TRAIL: 8.1
rem 1.  Updated all cubes to use buildCognosCube script.       SPC 02/10/2009
rem 2.  Added 2 new Financial Aid cubes.                       SPC 02/10/2009
rem
rem AUDIT TRAIL END
rem
rem FILE NAME..: buildEDWCube.bat
rem PRODUCT....: INFORMATION ACCESS
rem USAGE......: General BAT script for building Cognos cubes
rem
rem COPYRIGHT..: Copyright (c) SCT Corporation 2004.  All rights reserved.
rem   
rem -----------------------------------------------------------
rem  Parameters: model name
rem -----------------------------------------------------------
rem 
rem
rem call buildCognosCube PM_Admissions_Counselor_Cube
rem call buildCognosCube PM_Admissions_Counselor_Cube_Current_Academic_Period
rem call buildCognosCube PM_Aid_Impact_Analysis_Cube
rem call buildCognosCube PM_Aid_Impact_Analysis_Cube_Current_Academic_Period
rem call buildCognosCube PM_Award_Analysis_Cube
rem call buildCognosCube PM_Award_Analysis_Cube_Current_Academic_Period
call buildCognosCube WFT_ACADEMIC_PROGRAM_COURSE
call buildCognosCube WFT_ENROLLMENT
rem call buildCognosCube WFT_RECRUITING_AND_ADMISSION
call buildCognosCube WFT_COURSE_REGISTRATION
call buildCognosCube WFT_GRADUATION_COMPLETION
rem call buildCognosCube WFT_FINANCIAL_AID_STUDENT
rem call buildCognosCube WFT_FINANCIAL_AID_PRE_STUDENT
rem call buildCognosCube WFT_OPERATING_LEDGER
rem call buildCognosCube WFT_GENERAL_LEDGER
rem call buildCognosCube WFT_GENERAL_LEDGER_EVENT
rem call buildCognosCube WFT_RECEIVABLE_CUSTOMER
rem call buildCognosCube WFT_RECEIVABLE_REVENUE
rem call buildCognosCube WFT_GRANT_AND_PROJECT
rem call buildCognosCube WFT_EMPLOYEE
rem call buildCognosCube WFT_EMPLOYEE_POSITION
rem call buildCognosCube WFT_EMPLOYEE_DEGREE
rem call buildCognosCube WFT_EMPLOYMENT_APPLICATION
rem call buildCognosCube WFT_ADVANCEMENT_GIFT
