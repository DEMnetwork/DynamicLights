@echo off 
set dir=%~dp0
:: Delegate to build.bat
call "%dir%build.bat" --cleanbuilds