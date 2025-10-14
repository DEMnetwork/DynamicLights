:: |--------------------------------|
:: |                                |
:: |  DynamicLights Datapack Build  |
:: |            Script              |
:: |                                |
:: |--------------------------------|
@echo off
set dir=%~dp0
if not exist "%dir%zipmake.exe" goto errorb
set hour=%TIME:~0,2%
set automated=0
if "%hour:~0,1%"==" " set hour=0%hour:~1,1%
set ctime=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2%_%hour%%TIME:~3,2%
if ["%~1"]==["--cleanbuilds"] goto clearbld
if ["%~1"]==["--version"] goto version
if ["%~1"]==["--help"] goto hlp
if ["%~1"]==["--automated"] set "automated=1" && goto build
if not ["%~1"]==[""] echo [ERROR] Invalid parameters, use --help ^for help && exit /B 3
goto build
::
:build
set logfile="%dir%builds\build_%ctime%.log"
if not exist "%dir%builds\" mkdir "%dir%builds\" && echo [%DATE% %TIME%] [WARN] Build Directory^("%dir%builds\"^) missing >> %logfile%
echo [%DATE% %TIME%] [INFO] Starting build process. >> %logfile%
echo [%DATE% %TIME%] [INFO] Directory: "%dir%" >> %logfile%
if not exist "%dir%src\" goto errora
goto archive
::
:archive
echo [%DATE% %TIME%] [INFO] Creating ZIP file... >> %logfile%
echo [%DATE% %TIME%] [INFO] File name: "%dir%builds\DynamicLights+%ctime%.zip" >> %logfile%
echo [%DATE% %TIME%] [INFO] ZIP process logs: >> %logfile%
echo --------------------------------------------------------------------------------------- >> %logfile%
"%dir%zipmake" "%dir%src" "%dir%builds\DynamicLights+%ctime%.zip" >> %logfile%
echo --------------------------------------------------------------------------------------- >> %logfile%
if %errorlevel% NEQ 0 echo Failed to build ZIP file. && echo Build failed >> %logfile%
echo [INFO] Built file: "%dir%builds\DynamicLights+%ctime%.zip"
echo Build complete
echo [%DATE% %TIME%] [INFO] Build complete >> %logfile%
goto :eof
::
:errora
echo.
echo [%DATE% %TIME%] [ERROR] The directory "src" is missing or is not a directory >> %logfile%
echo The directory "src" is missing or is not a directory
echo.
echo Error Code: 1
echo.
if ["%automated%"]==["1"] exit /B 1
echo Press any key to exit the script
pause >nul
exit /B 1
::
:clearbld
set logfile="%dir%builds\clean_%ctime%.log"
if not exist "%dir%builds\" echo [ERROR] Build Directory^("%dir%builds\"^) missing, this build script will make a directory ^for builds and ^exit with error code 2 && mkdir "%dir%builds\" && echo [%DATE% %TIME%] [ERROR] Build Directory^("%dir%builds\"^) missing, it was created and this script will ^exit with code 2 >> %logfile% && exit /B 2
echo [INFO] Starting to clean builds...
echo [%DATE% %TIME%] [INFO] Starting to clean builds... >> %logfile%
del /q "%dir%builds\DynamicLights+*.zip" >nul 2>nul
echo [%DATE% %TIME%] [INFO] Operation complete. >> %logfile%
echo [INFO] Operation complete.
goto :eof
::
:hlp
echo.
echo Usage:
echo   build.bat                ^| Builds the datapack.
echo   build.bat --cleanbuilds  ^| Deletes all previous builds.
echo   build.bat --version      ^| Displays the current version.
echo   build.bat --automated    ^| Allows f^or running the script in an automated environment.
echo   build.bat --help         ^| Displays this message.
echo.
echo Press any key to exit the help message...
pause >nul
goto :eof
::
:version
echo ^|---------------------------------^|
echo ^|  DynamicLights Datapack v1.0.1  ^|
echo ^|                                 ^|
echo ^|    DynamicLights Build Script   ^|
echo ^|---------------------------------^|
goto :eof
::
:errorb
echo.
echo Required file "%dir%zipmake" was not found.
echo.
echo Error Code: 4
echo.
exit /B 4