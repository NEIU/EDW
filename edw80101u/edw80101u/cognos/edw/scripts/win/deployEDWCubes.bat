@echo off
rem
rem AUDIT TRAIL: 1.0
rem 1. RLZ  05/30/2006      Initial Version
rem
rem AUDIT TRAIL: 8.1
rem 1.  Added 2 new Financial Aid cubes.                SPC 02/10/2009
rem
rem AUDIT TRAIL END
rem
rem FILE NAME..: deployEDWCube.bat
rem PRODUCT....: INFORMATION ACCESS
rem USAGE......: Deploy newly built cognos cubes 
rem
rem COPYRIGHT..: Copyright (c) SCT Corporation 2004.  All rights reserved.
rem   
rem -----------------------------------------------------------
rem  Parameters: cube name 
rem -----------------------------------------------------------
rem 



rem --------------------------------------------------------------------------
rem Stop Cognos 8 service before update cube file
rem --------------------------------------------------------------------------

net stop "Cognos 8"
 
 
rem --------------------------------------------------------------------------
rem Update Cube files
rem --------------------------------------------------------------------------
rem call updateCognosCube PM_Admissions_Counselor_Cube
rem call updateCognosCube PM_Admissions_Counselor_Cube_Current_Academic_Period
rem call updateCognosCube PM_Aid_Impact_Analysis_Cube
rem call updateCognosCube PM_Aid_Impact_Analysis_Cube_Current_Academic_Period
rem call updateCognosCube PM_Award_Analysis_Cube
rem call updateCognosCube PM_Award_Analysis_Cube_Current_Academic_Period
call updateCognosCube WFT_ACADEMIC_PROGRAM_COURSE
call updateCognosCube WFT_ENROLLMENT 
rem call updateCognosCube WFT_RECRUITING_AND_ADMISSION   
call updateCognosCube WFT_COURSE_REGISTRATION        
call updateCognosCube WFT_GRADUATION_COMPLETION      
rem call updateCognosCube WFT_FINANCIAL_AID_STUDENT      
rem call updateCognosCube WFT_FINANCIAL_AID_PRE_STUDENT  
rem call updateCognosCube WFT_OPERATING_LEDGER           
rem call updateCognosCube WFT_GENERAL_LEDGER             
rem call updateCognosCube WFT_GENERAL_LEDGER_EVENT       
rem call updateCognosCube WFT_RECEIVABLE_CUSTOMER        
rem call updateCognosCube WFT_RECEIVABLE_REVENUE         
rem call updateCognosCube WFT_GRANT_AND_PROJECT          
rem call updateCognosCube WFT_EMPLOYEE                   
rem call updateCognosCube WFT_EMPLOYEE_POSITION          
rem call updateCognosCube WFT_EMPLOYEE_DEGREE            
rem call updateCognosCube WFT_EMPLOYMENT_APPLICATION     
rem call updateCognosCube WFT_ADVANCEMENT_GIFT           
        


rem --------------------------------------------------------------------------
rem Start Cognos 8 after updating cube files
rem --------------------------------------------------------------------------

net start "Cognos 8"