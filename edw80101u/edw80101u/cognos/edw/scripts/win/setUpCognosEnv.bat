rem
rem AUDIT TRAIL: 1.1
rem 1. JEH        05/21/2008   Initail version.
rem 2. emorneau   17/03/2011   - Remove the database variable
rem                            - Added the following variables:
rem                              NAMESPACE_ID/LDAP_USER/LDAP_PASSWORD/
rem                              COGNOS_PACKAGE_LOCATION/COGNOS_PM_PACKAGE_LOCATION
rem
rem AUDIT TRAIL END
rem
rem FILE NAME..: setUpCognosEnvironment
rem PRODUCT....: INFORMATION ACCESS
rem USAGE......: Script for defining environment variables needed by Cognos scripts
rem
rem COPYRIGHT..: Copyright (c) SCT Corporation 2004.  All rights reserved.
rem
rem -----------------------------------------------------------
rem Set up Cognos Transformer env vars.
rem -----------------------------------------------------------
rem
rem Please fill out the follow variables:
rem a TNSNAME.ora entry is needed for EDW to reference the EDW server 
SET JAVA_HOME=C:\Program Files\Java\jdk1.5.0_22
SET NAMESPACE_ID=sunds
SET LDAP_USER=cognos
SET LDAP_PASSWORD=Bright*989
rem The root directory of the edw80100 code tree
SET EDW_ROOT_DIR=C:\edw80101u
rem The area the build cubes will be published
SET TRANSFORMER_CUBE_DIR=%EDW_ROOT_DIR%\cognos\edw\cubes
rem The root directory of the cognos binaries
SET COGNOS_ROOT_DIR=C:\Program Files\cognos\c841
SET COGNOS_PACKAGE_LOCATION=/content/folder[@name='EDW Packages']
rem SET COGNOS_PM_PACKAGE_LOCATION=/content/folder[@name='Performance Management Packages']
rem
rem Advance settings
SET TRANSFORMER_LOG_DIR=%EDW_ROOT_DIR%\cognos\edw\logs
SET TRANSFORMER_WORK_DIR=%EDW_ROOT_DIR%\cognos\edw\work
SET TRANSFORMER_MODEL_DIR=%EDW_ROOT_DIR%\cognos\edw\transformer_models\win
SET TRANSFORMER_SCRIPTS_DIR=%EDW_ROOT_DIR%\cognos\edw\scripts\win
SET TRANSFORMER_DATA_DIR=%EDW_ROOT_DIR%\cognos\edw\iqd