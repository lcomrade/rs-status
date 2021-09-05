#define RootDir "C:\rs-status"

#include AddBackslash(SourcePath) + "build.iss"

[Setup]
AllowCancelDuringInstall=no
AlwaysShowDirOnReadyPage=no
AppComments={#AppComment}
AppId={0F62F78E-7CC7-4568-8863-E9FDD0FE29CD}
AppReadmeFile={#AppURL}#readme
AppName={#AppName}
AppPublisher={#MAINTAINER}
AppVersion={#AppVersion}
AppVerName={cm:NameAndVersion,{#AppName},{#AppVersion}}
AppPublisherURL={#AppURL}
AppSupportURL={#AppURL}/issues
AppUpdatesURL={#AppURL}/releases/latest
;; ArchitecturesAllowed=x86 x64
DefaultDirName={commonpf}\Uninstall Information\{#AppName}
DisableDirPage=yes
DefaultGroupName={#AppName}
DisableProgramGroupPage=yes
DisableReadyMemo=yes
DisableStartupPrompt=yes
DisableWelcomePage=yes
DisableReadyPage=yes
LicenseFile={#RootDir}\LICENSE
;; MinVersion=6.0sp1
OutputDir={#RootDir}\dist
OutputBaseFilename={#AppName}.windows.{#GOARCH}.setup
DirExistsWarning=no
EnableDirDoesntExistWarning=no
PrivilegesRequired=admin
PrivilegesRequiredOverridesAllowed=commandline
TouchDate=none
TouchTime=none
ShowLanguageDialog=no
UsePreviousAppDir=no
UsePreviousGroup=no
UsePreviousLanguage=no
UsePreviousPrivileges=no
UsePreviousSetupType=no
UsePreviousTasks=no
UsePreviousUserInfo=no
UseSetupLdr=yes
Compression=lzma
SolidCompression=yes
SetupIconFile=compiler:SetupClassicIcon.ico
WizardStyle=classic

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "{#RootDir}\dist\{#AppName}.windows.{#GOARCH}.exe"; DestDir: "{win}"; DestName: "{#AppName}.exe"; Flags: ignoreversion

Source: "{#RootDir}\LICENSE"; DestDir: "{win}\Help\{#AppName}"; DestName: "LICENSE.txt"; Flags: ignoreversion
Source: "{#RootDir}\README.md"; DestDir: "{win}\Help\{#AppName}"; DestName: "README.md"; Flags: ignoreversion

[UninstallDelete]
Type: files; Name: "{win}\{#AppName}.exe"
Type: filesandordirs; Name: "{win}\Help\{#AppName}"
Type: filesandordirs; Name: "{commonpf}\Uninstall Information\{#AppName}"
