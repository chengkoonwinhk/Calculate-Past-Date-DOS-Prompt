@echo off

for /f "tokens=1" %%i in ('date /t') do set thedate=%%i

set dda=0
set mma=0
set yyyy=0
set tt=0
set ddax=0
set mmax=0
set dday=0
set mmay=0
set yyyyx=0

set /A mmax=%thedate:~3,1%
set /A mmay=%thedate:~4,1%
set /A ddax=%thedate:~0,1%
set /A dday=%thedate:~1,1%
set /A yyyy=%thedate:~6,4%
set /A yyyyx = %yyyy%
set /A mma = %mmax%*10 + %mmay%
set /A dda = %ddax%*10 + %dday%

set /A dda=%dda% - %1
set /A mma=%mma% + 0

:LOOPCAL
if %dda% GTR 0 goto DONE
set /A mma=%mma% - 1
if %mma% GTR 0 goto ADJUSTDAY
set /A mma=12
set /A yyyy=%yyyy% - 1

:ADJUSTDAY
if %mma%==1 goto SET31
if %mma%==2 goto CHKLEAPYEAR
if %mma%==3 goto SET31
if %mma%==4 goto SET30
if %mma%==5 goto SET31
if %mma%==6 goto SET30
if %mma%==7 goto SET31
if %mma%==8 goto SET31
if %mma%==9 goto SET30
if %mma%==10 goto SET31
if %mma%==11 goto SET30
if %mma%==12 goto SET31
goto ERROR

:SET31
set /A dda=31 + %dda%
goto DONE

:SET30
set /A dda=30 + %dda%
goto DONE

:CHKLEAPYEAR
set /A tt=%yyyy% %% 4
if not %tt%==0 goto SET28
set /A tt=%yyyy% %% 100
if not %tt%==0 goto SET29
set /A tt=%yyyy% %% 400
if %tt%==0 goto SET29

:SET28
set /A dda=28 + %dda%
goto DONE

:SET29
set /A dda=29 + %dda%

:DONE
if %dda% LSS 0 goto LOOPCAL
if %1 LSS 0 goto CHKDAY
goto CALEXIT

:CHKDAY
rem echo CHECK DAY
if %mma%==1 goto MSET31
if %mma%==2 goto MCHKLEAPYEAR
if %mma%==3 goto MSET31
if %mma%==4 goto MSET30
if %mma%==5 goto MSET31
if %mma%==6 goto MSET30
if %mma%==7 goto MSET31
if %mma%==8 goto MSET31
if %mma%==9 goto MSET30
if %mma%==10 goto MSET31
if %mma%==11 goto MSET30
if %mma%==12 goto MSET31
set /A mma=1
set /A yyyy=%yyyy%+1
goto LOOPCAL

:MSET30
rem echo Check day 30
if %dda% LSS 31 goto CALEXIT
set /A dda=%dda% - 30
set /A mma=%mma% + 1
goto LOOPCAL

:MSET31
rem echo Check day 31
if %dda% LSS 32 goto CALEXIT
set /A dda=%dda% - 31
set /A mma=%mma% + 1
goto LOOPCAL

:MCHKLEAPYEAR
rem echo Check day 28/29
set /A tt=%yyyy% %% 4
if not %tt%==0 goto MSET28
set /A tt=%yyyy% %% 100
if not %tt%==0 goto MSET29
set /A tt=%yyyy% %% 400
if %tt%==0 goto MSET29

:MSET28
if %dda% LSS 29 goto CALEXIT
set /A dda=%dda% - 28
set /A mma=%mma% + 1
goto LOOPCAL

:MSET29
if %dda% LSS 30 goto CALEXIT
set /A dda=%dda% - 29
set /A mma=%mma% + 1
goto LOOPCAL

:ERROR
echo Program Error

:CALEXIT
if %dda% LSS 10 set dda=0%dda%
if %mma% LSS 10 set mma=0%mma%
set CALDATE=%dda%.%mma%.%yyyy%
echo Calculated Date: %CALDATE%
set TODAY=%ddax%%dday%.%mmax%%mmay%.%yyyyx%
echo Today          : %TODAY%
