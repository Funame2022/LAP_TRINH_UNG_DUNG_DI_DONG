@echo off
setlocal
set "PROJECT_DIR=%~dp0"
if not defined FLUTTER_ROOT set "FLUTTER_ROOT=G:\flutterSDKs\flutter"
if exist "%FLUTTER_ROOT%\bin\flutter.bat" set "PATH=%FLUTTER_ROOT%\bin;%PATH%"

cd /d "%PROJECT_DIR%"
where flutter >nul 2>nul
if errorlevel 1 (
  echo Flutter SDK was not found. Set FLUTTER_ROOT or add flutter\bin to PATH.
  exit /b 1
)

flutter pub get
if errorlevel 1 exit /b 1

flutter devices
flutter run
