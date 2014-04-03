@echo off
rem
rem AUDIT TRAIL: 1.0
rem 1. JEH  05/10/2008      Initial Version
rem
rem AUDIT TRAIL END
rem
rem FILE NAME..: buildCognosCube.bat
rem PRODUCT....: INFORMATION ACCESS
rem USAGE......: Script for building Cognos cubes
rem
rem COPYRIGHT..: Copyright (c) SCT Corporation 2004.  All rights reserved.
rem
rem -----------------------------------------------------------
rem  Program to automate generate COGNOS cube file.
rem  Parameters:   model name
rem -----------------------------------------------------------

SET MODEL_NAME=%1

rem -----------------------------------------------------------
rem  Check for model name to build
rem -----------------------------------------------------------

IF NOT "%MODEL_NAME%"=="" GOTO GOT_MODEL
ECHO No Model Name to Build supplied - please try again.
GOTO THE_END

:GOT_MODEL

rem -----------------------------------------------------------
rem  Set up Cognos Transformer env vars.
rem -----------------------------------------------------------

call setUpCognosEnv.bat

rem --------------------------------------------------------------------------
rem  Check for old version of temporary version of CUBE.
rem --------------------------------------------------------------------------

IF NOT EXIST "%TRANSFORMER_CUBE_DIR%\%MODEL_NAME%_BUILD.mdc" GOTO BUILD_CUBE
ECHO ... Old temporary (_BUILD) version of cube exists but should not. Remove this file before building cube.
GOTO THE_END

:BUILD_CUBE
rem --------------------------------------------------------------------------
rem Now build or refresh cubes
rem --------------------------------------------------------------------------

rem --------------------------------------------------------------------------
rem Create the driver MDL file
rem --------------------------------------------------------------------------
ECHO OpenMDL "Models\%MODEL_NAME%.MDL" > build_%MODEL_NAME%.MDL
ECHO CreateFiles >> build_%MODEL_NAME%.MDL
cd %COGNOS_ROOT_DIR%\bin
ECHO Loading Cube: %MODEL_NAME% ...

SET LogFileName=build_%MODEL_NAME%.log
SET LogFileDirectory=%TRANSFORMER_LOG_DIR%
SET ModelSaveDirectory=%TRANSFORMER_MODEL_DIR%
SET CubeSaveDirectory=%TRANSFORMER_CUBE_DIR%
SET ModelWorkDirectory=%TRANSFORMER_WORK_DIR%

rem --------------------------------------------------------------------------------------
rem Script below used for performance module - powercube name not maching cognos cube name
rem --------------------------------------------------------------------------------------
set x=%MODEL_NAME%
IF NOT %x:~0,3% == PM_ GOTO NOT_PM
set x=%x:_Current= - Current%
set CUBE_NAME=%x:_= %
@echo off
FOR %%B IN (%MODEL_NAME%) DO (
    FOR /F "delims=~" %%A IN ('ECHO %%B^> ~%%B ^& DIR /L /B ~%%B') DO (
        set MODEL_NAME_LOWER=%%A
        DEL /Q ~%%B
    )
)
set PACKAGE_LOCATION=%COGNOS_PM_PACKAGE_LOCATION% 
GOTO END_VAR
:NOT_PM
set CUBE_NAME=%MODEL_NAME%
set MODEL_NAME_LOWER=%MODEL_NAME%
set PACKAGE_LOCATION=%COGNOS_PACKAGE_LOCATION%
:END_VAR

echo ^<?xml version="1.0" encoding="UTF-8"?^>^<Settings^>^<Commands^>^<Command Name="Publish"^>^<Parameters^>^<Parameter Name="CubeName" Value="%MODEL_NAME_LOWER%"/^>^<Parameter Name="CognosConnectionDataSourceName" Value="%CUBE_NAME%"/^>^<Parameter Name="DataSourceWindowsLocation" Value="%TRANSFORMER_CUBE_DIR%\%MODEL_NAME%.mdc"/^>^<Parameter Name="DataSourceUnixLinuxLocation" Value="%TRANSFORMER_CUBE_DIR%/%MODEL_NAME%.mdc"/^>^<Parameter Name="DataSourceUpdate" Value="TRUE"/^>^<Parameter Name="PackageName" Value="%MODEL_NAME%"/^>^<Parameter Name="Packagelocation" Value="%PACKAGE_LOCATION%"/^>^<Parameter Name="PackageUpdate" Value="TRUE"/^>^</Parameters^>^</Command^>^</Commands^>^</Settings^> > %TRANSFORMER_SCRIPTS_DIR%\cognospref.xml

"%COGNOS_ROOT_DIR%\bin\cogtr" -n2 -r4 -f%TRANSFORMER_SCRIPTS_DIR%\cognospref.xml -y1%NAMESPACE_ID%=%LDAP_USER%/%LDAP_PASSWORD% "%TRANSFORMER_MODEL_DIR%\%MODEL_NAME%.MDL"

rem --------------------------------------------------------------------------
rem Check whether the cube build was successful. If not, stop processing
rem --------------------------------------------------------------------------

IF EXIST "%TRANSFORMER_CUBE_DIR%\%MODEL_NAME%_BUILD.mdc" GOTO BUILD_OK
ECHO Error building cube: %MODEL_NAME% - cube not found.
@ECHO ON
TYPE %TRANSFORMER_LOG_DIR%\build_%MODEL_NAME%.log
GOTO THE_END

:BUILD_OK

rem --------------------------------------------------------------------------
rem Get rid of the temporary MDL file
rem --------------------------------------------------------------------------
IF EXIST build_%MODEL_NAME%.MDL DEL build_%MODEL_NAME%.MDL


rem --------------------------------------------------------------------------
rem Refomat cube in order to compatable with Cognos 8
rem --------------------------------------------------------------------------
"%COGNOS_ROOT_DIR%\bin\pcoptimizer.exe" "%TRANSFORMER_CUBE_DIR%\%MODEL_NAME%_BUILD.mdc"


rem --------------------------------------------------------------------------
rem pcactive tool to deploy the cube
rem --------------------------------------------------------------------------
mkdir "%TRANSFORMER_CUBE_DIR%"\"%MODEL_NAME%"
move "%TRANSFORMER_CUBE_DIR%"\"%MODEL_NAME%"_BUILD.mdc "%TRANSFORMER_CUBE_DIR%"\"%MODEL_NAME%"\"%MODEL_NAME%".mdc
"%COGNOS_ROOT_DIR%\bin\pcactivate.exe" "%MODEL_NAME%".mdc "%TRANSFORMER_CUBE_DIR%"

rem --------------------------------------------------------------------------
rem Copy to other Content Manager -- NEIU MODIFICATION  djh 6/22/2011
rem --------------------------------------------------------------------------
copy /Y "%TRANSFORMER_CUBE_DIR%"\"%MODEL_NAME%"\"%MODEL_NAME%".mdc \\cog-test-01\cubes\"%MODEL_NAME%"\"%MODEL_NAME%".mdc

ECHO Cube build succesful for cube: %MODEL_NAME%


IF EXIST "%TRANSFORMER_CUBE_DIR%\%MODEL_NAME%.mdc" GOTO BUILD_OK
ECHO Error deploying cube: %MODEL_NAME% - cube not found.
@ECHO ON
TYPE %TRANSFORMER_LOG_DIR%\build_%MODEL_NAME%.log
GOTO THE_END

:BUILD_OK
ECHO Cube deployment succesful for cube: %MODEL_NAME%

:THE_END
cd %TRANSFORMER_SCRIPTS_DIR%
del *.mdl
del *.xml
