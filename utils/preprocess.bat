@echo off
setlocal ENABLEDELAYEDEXPANSION

set flecs_header=.\libs\flecs\flecs.h
set lua_source=.\src\ecs.lua
set output_directory=.\distr

for %%f in (%flecs_header% %lua_source% %output_directory%) do (
  if not exist %%f (
    echo Missing %%f, make sure to execute this script from the project root.
    exit /b 1
  )
)

set tmp_file="%TEMP%\flecs_noinc.h"
set preprocessed="%TEMP%\preprocessed.h"

type %flecs_header% | findstr /V "#include" > %tmp_file%
cl.exe /nologo /EP %* %tmp_file% | findstr /V "#pragma" | findstr /V /C:"typedef char bool" > %preprocessed%

(
  echo require^('ffi'^).cdef^[^[
  for /f "usebackq tokens=* delims=" %%L in (%preprocessed%) do (
    set "line=%%L"
    if not "!line: =!"=="" echo %%L
  )
  echo ^]^]
  echo:
  type %lua_source%
) > %output_directory%\ecs.lua

del %tmp_file%
del %preprocessed%
