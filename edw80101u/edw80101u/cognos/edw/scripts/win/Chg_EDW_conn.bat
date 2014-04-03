@echo off
rem
rem AUDIT TRAIL: 1.0
rem 1. RLZ  05/10/2006      Initial Version
rem 1. JEH  06/01/2008      
rem
rem AUDIT TRAIL END
rem
rem FILE NAME..: Chg_EDW_conn.bat
rem PRODUCT....: INFORMATION ACCESS
rem USAGE......: General BAT script for altering Cognos cubes Connectors
rem
rem COPYRIGHT..: Copyright (c) SCT Corporation 2004.  All rights reserved.
rem   

rem -----------------------------------------------------------
rem  Set up Cognos Transformer env vars.
rem -----------------------------------------------------------

call setUpCognosEnv.bat

cd %COGNOS_ROOT_DIR%\webapps\utilities\PCConn

call PCConn.bat -f %TRANSFORMER_SCRIPTS_DIR%\changeEDWcube_connectors.txt > %TRANSFORMER_LOG_DIR%\changeEDWcube_connectors.log