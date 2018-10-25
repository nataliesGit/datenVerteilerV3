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

$copyFrom = "c:\Temp2"
$konto = "11.pruefung"
$copyTo = "\\sc029903\d$\SPUV\home_schueler\"&$konto&"\heute\"
CopyFolder()


Func CopyFolder()
;~ 	Run('xcopy /e /h "c:\Temp2" C:\Temp3', "", @SW_HIDE )

	Run('xcopy /e /h '&$copyFrom&' '&$copyTo, "", @SW_HIDE )

EndFunc