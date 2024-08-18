@echo off 
Title "Constellation"

REG ADD "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%cd%\bin\constellation64.exe" /t REG_SZ /d "~ DPIUNAWARE" /f
start "" bin/constellation64.exe --console suppress