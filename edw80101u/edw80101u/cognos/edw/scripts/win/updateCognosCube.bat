@echo off
rem
rem AUDIT TRAIL: 1.0
rem 1. JEH  05/15/2008      Initial Version
rem
rem AUDIT TRAIL END
rem
rem FILE NAME..: updateCognosCube.bat
rem PRODUCT....: INFORMATION ACCESS
rem USAGE......: Updating old cube with newly built one.
rem
rem COPYRIGHT..: Copyright (c) SCT Corporation 2004.  All rights reserved.
rem
rem -----------------------------------------------------------
rem  Parameters: model name
rem -----------------------------------------------------------

SET MODEL_NAME=%1


rem -----------------------------------------------------------
rem  Set up Cognos env vars.
rem -----------------------------------------------------------

call setUpCognosEnv.bat


rem --------------------------------------------------------------------------
rem  Check if an updated cube available.
rem --------------------------------------------------------------------------

IF EXIST "%TRANSFORMER_CUBE_DIR%\%MODEL_NAME%_BUILD.mdc" GOTO UPDATE_CUBE
ECHO ... no cube exists for update. Please load cube first.
GOTO THE_END

:UPDATE_CUBE  
rem --------------------------------------------------------------------------
rem Backup old .mdc cube file and make new built cube available
rem --------------------------------------------------------------------------
IF EXIST "%TRANSFORMER_CUBE_DIR%\%MODEL_NAME%_BACKUP.mdc" DEL "%TRANSFORMER_CUBE_DIR%\%MODEL_NAME%_BACKUP.mdc"
IF EXIST "%TRANSFORMER_CUBE_DIR%\%MODEL_NAME%.mdc" RENAME "%TRANSFORMER_CUBE_DIR%\%MODEL_NAME%.mdc" "%MODEL_NAME%_BACKUP.mdc"
RENAME "%TRANSFORMER_CUBE_DIR%\%MODEL_NAME%_BUILD.mdc" "%MODEL_NAME%.mdc"


ECHO %MODEL_NAME%  has been updated ...

:THE_END
