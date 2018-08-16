@echo off

REM Minimize path scope, then set up MSVC environment before invoking Cygwin `make` 
PATH=C:\WINDOWS;C:\WINDOWS\SYSTEM32
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x86 10.0.15063.0

REM forward all arguments to `mvm` invoked from cygwin, prepending cygwin paths so `make` can be found
PATH=/usr/bin;/usr/local/bin;%PATH%
C:\cygwin\bin\bash mvm %*