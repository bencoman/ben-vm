@echo off
REM We want to use GNU Make build system from Cygwin, but using MSVC compiler and linker.
REM This is a small experiment to familiarise with passing the required the environment variables through to the Cygwin environment.
REM This is done by running "vcvarsall.bat" [1] before invoking a Cygwin shell.


PATH=C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\Users\Ben\AppData\Local\Microsoft\VisualStudio\15.0_ecf0505e\Extensions\lgwdbad4.s0i

echo ===CMD.EXE FRESH          > out.cmdexe.fresh.txt
set                           >> out.cmdexe.fresh.txt

echo ===CYGWIN FRESH           > out.cygwin.fresh.txt
C:\cygwin\bin\bash env.sh     >> out.cygwin.fresh.txt


call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x86 10.0.17134.0


echo ===CMD.EXE VCVARS         > out.cmdexe.vcvars.txt
set                           >> out.cmdexe.vcvars.txt

echo ===CYGWIN VCVARS         > out.cygwin.vcvars.txt
C:\cygwin\bin\bash env.sh     >> out.cygwin.vcvars.txt


REM [1] https://docs.microsoft.com/en-us/cpp/build/building-on-the-command-line
REM For quick reference, the before & after of running "vcvarsall.bat" is shown for...
REM   cmd.exe at... https://www.diffchecker.com/cb5MM4z3
REM   cygwin at.... https://www.diffchecker.com/gLAheP7Z
