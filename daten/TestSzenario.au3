#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=ico3.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Icon_Add=ico1.ico
#AutoIt3Wrapper_Res_File_Add=TestDaten\Druckverlusttabelle.xlsx
#AutoIt3Wrapper_Res_File_Add=TestDaten\Trinkwasserspeicher.dwg
#AutoIt3Wrapper_Res_File_Add=PsExec.exe
#AutoIt3Wrapper_Res_File_Add=wolRechner.exe
#AutoIt3Wrapper_Res_File_Add=removeLogon.bat
#AutoIt3Wrapper_Res_File_Add=shutdown.bat
#AutoIt3Wrapper_Res_File_Add=reboot.bat
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <File.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>
#Include <Array.au3>
#include <GuiComboBox.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <StringConstants.au3>
#include <Inet.au3>
#include <array.au3>


Global $psExecFile,$tempDir
Global $HomeLaufwerke = "\\sc029903\SPUV\home_schueler\"

Local $testFileInstall = true ; Change to True and ammend the file paths accordingly.

if $testFileInstall Then
	If Not FileExists("c:\temp5\") Then DirCreate("c:\temp5\")
	; This will install the file C:\Test.bmp to the script location.
	If Not FileExists("c:\temp5\tempLogons") Then DirCreate("c:\temp5\tempLogons")
	$tempDir = "c:\temp5\tempLogons"
	If Not FileExists("c:\temp5\TestDaten\") Then DirCreate("c:\temp5\TestDaten\")

	FileInstall("PsExec.exe","C:\temp5\PsExec.exe")
	FileInstall("wolRechner.exe","C:\temp5\wolRechner.exe")
	FileInstall("TestDaten\Druckverlusttabelle.xlsx","C:\temp5\TestDaten\Druckverlusttabelle.xlsx")
	FileInstall("TestDaten\Trinkwasserspeicher.dwg","C:\temp5\TestDaten\Trinkwasserspeicher.dwg")
	FileInstall("removeLogon.bat","C:\temp5\removeLogon.bat")
	FileInstall("shutdown.bat","C:\temp5\shutdown.bat")
	FileInstall("reboot.bat","C:\temp5\reboot.bat")

	$psExecFile = "C:\temp5\PsExec.exe"
	$testDatenOrdner = "C:\temp5\TestDaten\*.*"
	$wolRechner = "C:\temp5\wolRechner.exe"
	$removeLogonBat = "C:\temp5\removeLogon.bat"
	$shutDownBat = "C:\temp5\shutdown.bat"
	$rebootBat = "C:\temp5\reboot.bat"
Else
	$psExecFile = @ScriptDir & "\PsExec.exe"
	$testDatenOrdner = @ScriptDir & "\TestDaten\*.*"
	$wolRechner = @ScriptDir & "\wolRechner.exe"
	$removeLogonBat =  @ScriptDir & "\removeLogon.bat"
	$shutDownBat =  @ScriptDir & "\shutdown.bat"
	$rebootBat =  @ScriptDir & "\reboot.bat"
	$tempDir = @ScriptDir & "\temp"
	If Not FileExists($tempDir) Then DirCreate($tempDir)

EndIf



#Region ### START Koda GUI section ### Form=c:\_natalie_eigene\pruefung_datenverteilungsammlung\daten\testszenario.kxf
$Form1_1 = GUICreate("Test", 523, 211, 388, 142)
$comboTest = GUICtrlCreateCombo("", 48, 80, 225, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
$Label1 = GUICtrlCreateLabel("            Test Szenario Raum F221  -  20 Rechner",0, 16, 522, 28)
GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x008080)
GUICtrlSetBkColor(-1, 0xC0DCC0)
$butExecute = GUICtrlCreateButton("Ausführen", 288, 80, 75, 25)
$Group1 = GUICtrlCreateGroup("Testdaten verteilen ", 48, 112, 225, 57)
$Radio1 = GUICtrlCreateRadio("alle", 64, 136, 81, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Radio2 = GUICtrlCreateRadio("random", 160, 136, 81, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Label2 = GUICtrlCreateLabel("nach \\sc029903\SPUV\home_schueler\xx.pruefung\Ergebnis_xx.pruefung_dd.mm.yyyy\", 48, 176, 448, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

hideShowControl(0)


;~ Global Const $g_aAcceptable[] = ["Chrome", _
;~                                  "Firefox", _
;~                                  "IE"]


Global $MacsF221[] = ["00:19:99:d3:84:76","00:19:99:d3:89:08","00:19:99:d3:46:7c","00:19:99:d3:25:ad","00:19:99:d0:67:26","00:19:99:d3:87:d6","00:19:99:d3:87:e9","00:19:99:d3:87:ea", _
"00:19:99:d3:43:73","00:19:99:cc:93:ba","00:19:99:cc:93:e9","00:19:99:cc:93:92","00:19:99:c6:4e:3d","00:19:99:c6:4d:2d","00:19:99:c6:4c:88","00:19:99:c6:4c:83", _
"00:19:99:c6:4d:0b","90:1b:0e:11:32:48","00:19:99:c6:4c:d7","00:19:99:d3:43:74"]
Global $Wnummern[] = ["w4026884","w4026885","w4027074","w4027075","w4027085","w4027092","w4027111","w4027112","w4027118","w4029155","w4029165","w4029169","w4029980","w4030009", _
"w4030011","w4030019","w4030021","w4040774","w4030015","w4026896"]
Global $Konten[] = ["01.pruefung","02.pruefung","03.pruefung","04.pruefung","05.pruefung","06.pruefung","07.pruefung","08.pruefung","09.pruefung","10.pruefung", _
"11.pruefung","12.pruefung","13.pruefung","14.pruefung","15.pruefung","16.pruefung","17.pruefung","18.pruefung","19.pruefung","20.pruefung"]
Global $Konten2[] = ["21.pruefung","22.pruefung","23.pruefung","24.pruefung","25.pruefung","26.pruefung","27.pruefung","28.pruefung","29.pruefung","30.pruefung", _
"31.pruefung","32.pruefung","33.pruefung","34.pruefung","35.pruefung","36.pruefung","37.pruefung","38.pruefung","39.pruefung","40.pruefung"]
Global $Konten3[] = ["41.pruefung","42.pruefung","43.pruefung","44.pruefung","45.pruefung","46.pruefung","47.pruefung","48.pruefung","49.pruefung","50.pruefung", _
"51.pruefung","52.pruefung","53.pruefung","54.pruefung","55.pruefung","56.pruefung","57.pruefung","58.pruefung","59.pruefung","60.pruefung"]

GUICtrlSetData($comboTest,"Rechner aufwecken F221|logon Pruefungskonten 1-20|logon Pruefungskonten 21-40|logon Pruefungskonten 41-60|Verteile Testdaten 1-20|Verteile Testdaten 21-40|Verteile Testdaten 41-60|entferne Logons|shutdown|reboot")

func hideShowControl($state)
if $state = 0 Then
	$state = $GUI_HIDE
Else
	$state = $GUI_SHOW
EndIf
	GuiCtrlSetState ($Group1,$state)
	GuiCtrlSetState ($Radio1, $state)
	GuiCtrlSetState ($Radio2, $state)
	GuiCtrlSetState ($Label2, $state)

EndFunc



While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			cleanup()
			Exit
		Case $butExecute
			$wahl = GUICtrlRead($comboTest)
			execChoice($wahl)
		Case $comboTest
;~ 			MsgBox($MB_SYSTEMMODAL, "Kontrolle ",GUICtrlRead($comboTest))
			if GUICtrlRead($comboTest) = "Verteile Testdaten 1-20" or  GUICtrlRead($comboTest) = "Verteile Testdaten 21-40" or  GUICtrlRead($comboTest) = "Verteile Testdaten 41-60" then
				hideShowControl(1)
			Else
				hideShowControl(0)
			EndIf

	EndSwitch
WEnd


func logons($kontenRange)
	$cedentials ="-u mschool-ad\n.scheuble_adm -p test12345"

	Switch $kontenRange
		Case "1"
			$KontenArrayNummer = $Konten
		Case "2"
			$KontenArrayNummer = $Konten2
		Case "3"
			$KontenArrayNummer = $Konten3
	EndSwitch
;~ 	_arrayDisplay($KontenArrayNummer)

	for $i = 0 to 19
		$file = $tempDir&"\logonPruef"&$i&".bat"
		$hFileOpen = FileOpen($file, $FO_APPEND)
		$konto = $KontenArrayNummer[$i]
;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle $konto",$konto)
		$ipPC = $Wnummern[$i]
		FileWrite($hFileOpen, 'REG add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 1 /f > NUL' & @CRLF)
		FileWrite($hFileOpen, 'REG add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUserName /t REG_SZ /d '&$konto&' /f > NUL'& @CRLF)
		FileWrite($hFileOpen, 'REG add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultDomainName /t REG_SZ /d mschool-ad /f > NUL' & @CRLF)
		FileWrite($hFileOpen, 'REG add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /t REG_SZ /d 12345678 /f > NUL' & @CRLF)
		FileWrite($hFileOpen, "shutdown -r -f -t 01")
		FileClose($hFileOpen)

;~ 		$hFileOpen = FileOpen($file, $FO_READ)
;~ 		$sFileRead = FileRead($hFileOpen)
;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle ",$sFileRead)
;~ 		FileClose($hFileOpen)

;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle $psExecFile",$psExecFile)
;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle $ipPC",$ipPC)
;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle $file",$file)
;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle $cedentials",$cedentials)
		run($psExecFile&" -accepteula \\"&$ipPC&" "&$cedentials&"  -s -f -c "&$file)
		sleep(100)
	next
	sleep(2000)
;~ 	for $i = 0 to 19
;~ 		$fileToDel = @ScriptDir & "\temp\logonPruef"&$i&".bat"
;~ 		FileDelete($fileToDel)
;~ 	Next
    ; Remove the directory and all sub-directories.
;~ 	MsgBox($MB_SYSTEMMODAL, "Kontrolle $tempDir ",$tempDir)

;~     DirRemove($tempDir,1)
;~ 	MsgBox($MB_SYSTEMMODAL, "Kontrolle folder temp im ausfuehrPfad ",$tempDir)

EndFunc

func execChoice($choice)
	Switch $choice
		Case "Rechner aufwecken F221"
			WolF221()
		Case "logon Pruefungskonten 1-20"
			logons("1")
		Case "logon Pruefungskonten 21-40"
			logons("2")
		Case "logon Pruefungskonten 41-60"
			logons("3")
		Case "Verteile Testdaten 1-20"
			verteileTestDaten1()
		Case "Verteile Testdaten 41-60"
			verteileTestDaten3()
		Case "Verteile Testdaten 21-40"
			verteileTestDaten2()

		Case "entferne Logons"
			removeLogons()
		Case "shutdown"
			shutdownRechner()
		Case "reboot"
			rebootRechner()
	EndSwitch

EndFunc

func verteileTestDaten1()
;~ 	$HomeLaufwerke = "\\sc029903\SPUV\home_schueler\"
	If GUICtrlRead($Radio1) = 1 Then
;~         MsgBox(0, "Test", "alle markiert")
		_ArraySort ( $Konten)
;~ 		_ArrayDisplay($Konten)
		$anzahl = 19
    Else
;~         MsgBox(0, "Test", "random markiert")
		_ArrayShuffle($Konten)
;~ 		_ArrayDisplay($Konten)
		$anzahl = 10
    EndIf

	ProgressOn("Verteilung der Daten läuft", "")
	$ProzentSchritte = 100 / $anzahl
	$datum = _NowDate()

	$ProzentFortschritt = $ProzentSchritte
	For $i = 0 to $anzahl
		$konto = $Konten[$i]
;~  	MsgBox($MB_SYSTEMMODAL, "Kontrolle $konto", $konto)
;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle $datum", $datum)
		$copyTo = $HomeLaufwerke&$konto&"\Ergebnis_"&$konto&"_"&$datum
;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle $copyTo", $copyTo)

;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle $testDatenOrdner", $testDatenOrdner)
		if NOT FileExists($copyTo) then
			DirCreate($copyTo)
		EndIf

		ProgressSet ($ProzentFortschritt,Round($ProzentFortschritt) & "%")
;~ 		XCOPY "%HOMEDRIVE%\%HOMEPATH%\*.*" "\\SERVER\backup\%USERNAME%"
		Run('xcopy /e /h /Y '&$testDatenOrdner&' '&$copyTo, "",@SW_HIDE )
		$ProzentFortschritt = $ProzentFortschritt + $ProzentSchritte
	Next
	ProgressSet(100, "Fertig", "Daten verteilt")
	Sleep(2000)
	ProgressOff()
EndFunc

func verteileTestDaten2()
;~ 	$HomeLaufwerke = "\\sc029903\SPUV\home_schueler\"
	If GUICtrlRead($Radio1) = 1 Then
;~         MsgBox(0, "Test", "alle markiert")
		_ArraySort ( $Konten2)
;~ 		_ArrayDisplay($Konten)
		$anzahl = 19
    Else
;~         MsgBox(0, "Test", "random markiert")
		_ArrayShuffle($Konten2)
;~ 		_ArrayDisplay($Konten)
		$anzahl = 10
    EndIf

	ProgressOn("Verteilung der Daten läuft", "")
	$ProzentSchritte = 100 / $anzahl
	$datum = _NowDate()

	$ProzentFortschritt = $ProzentSchritte
	For $i = 0 to $anzahl
		$konto = $Konten2[$i]
;~  	MsgBox($MB_SYSTEMMODAL, "Kontrolle $konto", $konto)
;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle $datum", $datum)
		$copyTo = $HomeLaufwerke&$konto&"\Ergebnis_"&$konto&"_"&$datum
;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle $copyTo", $copyTo)

;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle $testDatenOrdner", $testDatenOrdner)
		if NOT FileExists($copyTo) then
			DirCreate($copyTo)
		EndIf

		ProgressSet ($ProzentFortschritt,Round($ProzentFortschritt) & "%")
;~ 		XCOPY "%HOMEDRIVE%\%HOMEPATH%\*.*" "\\SERVER\backup\%USERNAME%"
		Run('xcopy /e /h /Y '&$testDatenOrdner&' '&$copyTo, "",@SW_HIDE )
		$ProzentFortschritt = $ProzentFortschritt + $ProzentSchritte
	Next
	ProgressSet(100, "Fertig", "Daten verteilt")
	Sleep(2000)
	ProgressOff()
EndFunc

func verteileTestDaten3()
;~ 	$HomeLaufwerke = "\\sc029903\SPUV\home_schueler\"
	If GUICtrlRead($Radio1) = 1 Then
;~         MsgBox(0, "Test", "alle markiert")
		_ArraySort ( $Konten3)
;~ 		_ArrayDisplay($Konten)
		$anzahl = 19
    Else
;~         MsgBox(0, "Test", "random markiert")
		_ArrayShuffle($Konten3)
;~ 		_ArrayDisplay($Konten)
		$anzahl = 10
    EndIf

	ProgressOn("Verteilung der Daten läuft", "")
	$ProzentSchritte = 100 / $anzahl
	$datum = _NowDate()

	$ProzentFortschritt = $ProzentSchritte
	For $i = 0 to $anzahl
		$konto = $Konten3[$i]
;~  	MsgBox($MB_SYSTEMMODAL, "Kontrolle $konto", $konto)
;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle $datum", $datum)
		$copyTo = $HomeLaufwerke&$konto&"\Ergebnis_"&$konto&"_"&$datum
;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle $copyTo", $copyTo)

;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle $testDatenOrdner", $testDatenOrdner)
		if NOT FileExists($copyTo) then
			DirCreate($copyTo)
		EndIf

		ProgressSet ($ProzentFortschritt,Round($ProzentFortschritt) & "%")
;~ 		XCOPY "%HOMEDRIVE%\%HOMEPATH%\*.*" "\\SERVER\backup\%USERNAME%"
		Run('xcopy /e /h /Y '&$testDatenOrdner&' '&$copyTo, "",@SW_HIDE )
		$ProzentFortschritt = $ProzentFortschritt + $ProzentSchritte
	Next
	ProgressSet(100, "Fertig", "Daten verteilt")
	Sleep(2000)
	ProgressOff()
EndFunc

func shutdownRechner()
	$cedentials ="-u mschool-ad\n.scheuble_adm -p test12345"
	for $i = 0 to 19
		$ipPC = $Wnummern[$i]
;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle ",$ipPC)
		run($psExecFile&" -accepteula \\"&$ipPC&" "&$cedentials&"  -s -f -c "&$shutDownBat)
	next
EndFunc

func removeLogons()
	$cedentials ="-u mschool-ad\n.scheuble_adm -p test12345"
	for $i = 0 to 19
		$ipPC = $Wnummern[$i]
;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle ",$ipPC)
		run($psExecFile&" -accepteula \\"&$ipPC&" "&$cedentials&"  -s -f -c "&$removeLogonBat)
	next
EndFunc

func rebootRechner()
	$cedentials ="-u mschool-ad\n.scheuble_adm -p test12345"
	for $i = 0 to 19
		$ipPC = $Wnummern[$i]
;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle ",$ipPC)
		run($psExecFile&" -accepteula \\"&$ipPC&" "&$cedentials&"  -s -f -c "&$rebootBat)
	next
EndFunc




;~ run(@ScriptDir & "\data\wolRechner.exe"&" "&$wolUebergabeString)


func WolF221()
	$broadcast = "10.96.140.255"
	$wolUebergabeString = $broadcast
		For $i = 0 to Ubound($MacsF221)-1
			local $mac = $MacsF221[$i]
	;~ 		MsgBox($MB_SYSTEMMODAL, "Mac aus DB",$mac)
			local $macSplit = StringSplit ($mac, ":")
			local $macKorrigiert = $macSplit[1]&$macSplit[2]&$macSplit[3]&$macSplit[4]&$macSplit[5]&$macSplit[6]
	;~ 		MsgBox($MB_SYSTEMMODAL, "Mac ohne :",$macKorrigiert)
			$wolUebergabeString = $wolUebergabeString & " " & $macKorrigiert
		next
;~ 		MsgBox($MB_SYSTEMMODAL, "Uebergabestring",$wolUebergabeString)
		run($wolRechner&" "&$wolUebergabeString)
	MsgBox($MB_SYSTEMMODAL, "Kontrolle","wol erfolgt")
EndFunc

func cleanup()
	$filePath = "c:\temp5"
    If FileExists($filePath) Then
		DirRemove ($filePath ,1 )
    EndIf

EndFunc