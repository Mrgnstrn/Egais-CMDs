@echo off
color 0E
setlocal enabledelayedexpansion
:chcp 1251>nul

set fsrarid=030000163181
set TTNlist=TTN_list.txt
set UTMhost=localhost
set UTMport=8080

set dd=%DATE:~0,2%
set mm=%DATE:~3,2%
set yyyy=%DATE:~6,4%
set curdate=%yyyy%-%mm%-%dd%

echo Parameters:
echo List of TTN:	%TTNlist%
echo FSRAR_ID:	%fsrarid%
echo DATE:		%curdate%
echo UTM:		%UTMhost%:%UTMport%

FOR /f "usebackq delims=" %%a IN (%TTNlist%) DO (
	echo %%a
	
	FOR /f "usebackq delims=" %%n IN ("Act_template.xml") do ( 
 		set LINE=%%n 
 		set LINE=!LINE:[FSRARID]=%fsrarid%!
		set LINE=!LINE:[DATE]=%curdate%! 
		set LINE=!LINE:[TTN]=%%a! 
 		echo !LINE!>>Act_%%a.xml
	)
	curl -F "xml_file=@Act_%%a.xml" http://%UTMhost%:%UTMport%/opt/in/WayBillAct_v3
	del /S /Q Act_%%a.xml>null
)
pause>null