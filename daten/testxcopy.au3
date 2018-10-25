#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <File.au3>
#Include <Array.au3>
#include <GuiComboBox.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <StringConstants.au3>
#include <Inet.au3>
#include <GUIConstants.au3>
#include <WinAPISys.au3>
#include <NetShare.au3>
#include <GuiComboBox.au3>

$origdirect = "c:\Temp2"
$copydirect = "C:\Temp3"
$file = FileExists ("C:\Temp3")  ;ziel

If $file = 1 then
      If msgbox(1, "Confirmation", "The directory already exists. Are you sure youwant to replace it?") = 2 then
      Exit
      Else
      CopyFolder()
   EndIf
EndIf

If $file = 0 then
      If msgbox(1, "Confirmation", "The specified directory doesnt exist. Would you like to create it?") = 1 then
      DirCreate ($copydirect)
      CopyFolder()
      Else
     Exit
   EndIf
EndIf

Func CopyFolder()

Run('xcopy /e /h "c:\Temp2" C:\Temp3', "", @SW_HIDE )

ProgressOn("Kopiervorgang", "")

Do

$origfilesize = dirGetSize($origdirect)
$copyfilesize = dirGetSize($copydirect)
$MB = dirGetSize($copydirect) / 1024 / 1024

$percent = $copyfilesize / $origfilesize * 100

$decimalplace = Round ($percent)
$decimalplaceMB = Round ($MB)

ProgressSet ($percent, $decimalplace  & " % " & "(" & $decimalplaceMB & ") Mb has been copied.")

Until $copyfilesize = $origfilesize

ProgressOff ()

If $copyfilesize = $origfilesize then
Msgbox(0,"Complete", "All files and folders have been copied successfully.")
Else
Msgbox(0,"Error", "1 or more of the files/folders did not copy correctly.")
EndIf

EndFunc