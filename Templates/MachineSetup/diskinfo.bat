@ECHO OFF
IF "%~1"=="" goto help
@SETLOCAL ENABLEEXTENSIONS
@SETLOCAL ENABLEDELAYEDEXPANSION

@FOR /F "skip=1 tokens=1" %%x IN ('"WMIC /node:"%1" LOGICALDISK GET Name " ') DO (
REM @ECHO %%x

@FOR /F "tokens=1-3" %%n IN ('"WMIC /node:"%1" LOGICALDISK GET Name,Size,FreeSpace | find /i "%%x""') DO ( @SET FreeBytes=%%n & @SET TotalBytes=%%p

SET TotalSpace=!TotalBytes:~0,-9!
SET FreeSpace=!FreeBytes:~0,-10!

SET /A TotalUsed=!TotalSpace! - !FreeSpace!

REM IF !TotalSpace! LSS 0 goto error

@echo.
@echo.
@echo Drive: %%x
@ECHO ===========================
@ECHO Total space: !TotalSpace! GB
@ECHO Free space : !FreeSpace! GB

REM @SET TotalSpace=
REM @SET FreeSpace=
REM @SET TotalUsed=
REM goto end
)
)
goto end
:error
echo.
echo *** Invalid server or drive specified ***
echo.
goto help

:help
echo.
echo diskfree.cmd
echo.
echo Queries remote server for free disk space.
echo Specify a MACHINENAME and a drive letter to be queried
echo.
echo Example:   diskfree.cmd MACHINENAME c:
echo.
goto end

:end