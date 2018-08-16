@echo off

PATH=C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem

REM Set up MSVC environment before invoking `make` in Cygwin environment
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x86 10.0.15063.0

REM invoke `bash` to run login profile to prepend path "/usr/local/bin:/usr/bin" 
C:\cygwin\bin\bash -l