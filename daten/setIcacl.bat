@echo off

if not exist "C:\temp6\" mkdir C:\temp6
REM ntfs Berechtigungen setzen
icacls "C:\temp6" /grant:r Jeder:F