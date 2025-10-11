@echo off
set dir=%~dp0
if not exist "%dir%src\" goto error
if not exist "%dir%builds\" mkdir "%dir%builds\"
goto archive
::
:archive
powershell -command Compress-Archive -Path "%dir%src\*" -DestinationPath "%dir%builds\DynamicLights.zip" -Force >nul
echo Build complete
exit
::
:error
echo The directory "src" is missing or is not a directory
echo.
pause
exit /B 1