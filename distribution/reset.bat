@echo off
Title "Reset Constellation"

REM Remove any local configuration files which is sometimes required to reset
REM  Constellation and remove old/redundant cached files that can cause unexpected
REM  errors to occur when upgrading to newer versions of Constellation.

REM  Author        : arcturus
REM  Version       : 1.0
REM  Last Modified : 26/11/2021

set app_name=CONSTELLATION

set directory=%userprofile%\.%app_name%

if not exist %directory% (
  goto ask_directory
)

:continue
if not exist %directory% (
    echo The directory %directory% does not exist.
    goto no_files_removed
)

echo WARNING: The contents of %directory% will be removed and cannot be undone
echo.

set /p answer= Are you sure you want to continue? (yes/no):

if /i "%answer%"=="yes" (
    goto remove_files
) else (
    goto no_files_removed
)

:os_not_supported
    echo Sorry, $1 is not supported by this script
exit /b

:ask_directory
    echo The directory %directory% was not found.
    echo.
    echo What is the location of your Constellation user directory? You can find it by running Constellation and selecting Help - About and look for the user directory location.
    echo.

    set /p directory= Enter the location (or Ctrl + C to cancel):

    goto continue
exit /b

:no_files_removed
    echo No files removed. Bye!
exit /b

:remove_files
    rd /s /q %directory%
    echo Files removed
exit /b
