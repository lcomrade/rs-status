@set BUILD_ROOT=%CD%

@set NAME=rs-status
@set /P VERSION="Version: "

@set GO=go
@set ZIP=7z

@set LDFLAGS=-w -s -X 'main.programVersion=%VERSION%'
@set MAIN_GO=.\cmd\%NAME%.go


@echo CLEAN
rd /S /Q %BUILD_ROOT%\dist\

@echo BUILD BIN
md dist\

set GOOS=windows
set GOARCH=386
%GO% build -ldflags="%LDFLAGS%" -o dist\%NAME%.windows.386.exe %MAIN_GO%
	
set GOARCH=amd64
%GO% build -ldflags="%LDFLAGS%" -o dist\%NAME%.windows.amd64.exe %MAIN_GO%
	
set GOARCH=arm
%GO% build -ldflags="%LDFLAGS%" -o dist\%NAME%.windows.arm.exe %MAIN_GO%
	

@echo PACK ZIP
cd dist\
	
md %NAME%.windows.386\
copy %BUILD_ROOT%\dist\%NAME%.windows.386.exe %NAME%.windows.386\%NAME%.exe
copy %BUILD_ROOT%\LICENSE %NAME%.windows.386\LICENSE.txt
copy %BUILD_ROOT%\README.md %NAME%.windows.386\README.md
cd %NAME%.windows.386\
%ZIP% a -tzip -mx9 %BUILD_ROOT%\dist\%NAME%.windows.386.zip %NAME%.exe LICENSE.txt README.md
cd ..
rd /S /Q %NAME%.windows.386\
	
md %NAME%.windows.amd64\
copy %BUILD_ROOT%\dist\%NAME%.windows.amd64.exe %NAME%.windows.amd64\%NAME%.exe
copy %BUILD_ROOT%\LICENSE %NAME%.windows.amd64\LICENSE.txt
copy %BUILD_ROOT%\README.md %NAME%.windows.amd64\README.md
cd %NAME%.windows.amd64\
%ZIP% a -tzip -mx9 %BUILD_ROOT%\dist\%NAME%.windows.amd64.zip %NAME%.exe LICENSE.txt README.md
cd ..
rd /S /Q %NAME%.windows.amd64\
	
md %NAME%.windows.arm\
copy %BUILD_ROOT%\dist\%NAME%.windows.arm.exe %NAME%.windows.arm\%NAME%.exe
copy %BUILD_ROOT%\LICENSE %NAME%.windows.arm\LICENSE.txt
copy %BUILD_ROOT%\README.md %NAME%.windows.arm\README.md
cd %NAME%.windows.arm\
%ZIP% a -tzip -mx9 %BUILD_ROOT%\dist\%NAME%.windows.arm.zip %NAME%.exe LICENSE.txt README.md
cd ..
rd /S /Q %NAME%.windows.arm\


@echo PACK NUPKG (CHOCO)
md %BUILD_ROOT%\dist\%NAME%.nupkg\tools
copy %BUILD_ROOT%\dist\%NAME%.windows.amd64.exe %BUILD_ROOT%\dist\%NAME%.nupkg\tools\%NAME%.exe
copy %BUILD_ROOT%\LICENSE %BUILD_ROOT%\dist\%NAME%.nupkg\tools\LICENSE.txt
copy %BUILD_ROOT%\README.md %BUILD_ROOT%\dist\%NAME%.nupkg\tools\README.md

@if exist "%BUILD_ROOT%\dist\%NAME%.nupkg\tools\%NAME%.exe" (
	@for /F "tokens=*" %%i in ('checksum -t=sha256 -f=%BUILD_ROOT%\dist\%NAME%.nupkg\tools\%NAME%.exe') do @set choco_main_bin_sha256=%%i
) else (
	@echo Error: %BUILD_ROOT%\dist\%NAME%.nupkg\tools\%NAME%.exe does not exist
	@exit /B 1
)

echo VERIFICATION> %BUILD_ROOT%\dist\%NAME%.nupkg\tools\VERIFICATION.txt
echo %choco_main_bin_sha256% %NAME%.exe >> %BUILD_ROOT%\dist\%NAME%.nupkg\tools\VERIFICATION.txt

cd %BUILD_ROOT%\dist\%NAME%.nupkg
call powershell -Command "& {(Get-Content -Path %BUILD_ROOT%\build\choco\%NAME%.nuspec.tmpl) -replace '__VERSION__','%VERSION%' | Set-Content -Path '.\%NAME%.nuspec'}"
choco pack --outdir %BUILD_ROOT%\dist\

cd %BUILD_ROOT%
rd /S /Q %BUILD_ROOT%\dist\%NAME%.nupkg\

@echo DONE
@exit /B
