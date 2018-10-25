#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=daten\ico3.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Icon_Add=daten\ico3.ico
#AutoIt3Wrapper_Res_File_Add=daten\sollte.JPG
#AutoIt3Wrapper_Res_File_Add=daten\oldTimes.JPG
#AutoIt3Wrapper_Res_File_Add=daten\schule.ini
#AutoIt3Wrapper_Res_File_Add=daten\AdFind.exe
#AutoIt3Wrapper_Res_File_Add=daten\cal2.bmp
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
#include <GUIConstants.au3>
#include <WinAPISys.au3>
#include <NetShare.au3>
#include <GuiComboBox.au3>
#include <Date.au3>
#include <DateTimeConstants.au3>


Local $bFileInstall = true ; Change to True and ammend the file paths accordingly.

Global $picture,$oldTimes,$testSzenarioForm,$schuleIniFile,$testSzenarioIni
Global $aMsg

Global $hGUI2 = 9999, $butExecGui2 ; Predeclare the variables with dummy values to prevent firing the Case statements, only for GUI this time
Global $RadioAlle,$Radio60,$Radio30
Global $hGUI3 = 9999, $butKennwort, $InputKennwort; Predeclare the variables with dummy values to prevent firing the Case statements, only for GUI this time
Global $hGuiDate = 9999, $idDate
Global $butDatum, $labDatum

if $bFileInstall Then
	If Not FileExists("c:\temp4\") Then
		DirCreate("c:\temp4\")
		FileInstall("daten\sollte.JPG","C:\temp4\sollte.JPG")
		FileInstall("daten\ico3.ico","C:\temp4\ico3.ico")
		FileInstall("daten\oldTimes.JPG","C:\temp4\oldTimes.JPG")
		FileInstall("daten\schule.ini","C:\temp4\schule.ini")
		FileInstall("daten\AdFind.exe","C:\temp4\AdFind.exe")
		FileInstall("daten\cal2.bmp","C:\temp4\cal2.bmp")
	EndIf
	$picture = "c:\temp4\sollte.JPG"
	$oldTimes = "c:\temp4\oldTimes.JPG"
	$schuleIniFile = "C:\temp4\schule.ini"
	$adfind = "C:\temp4\AdFind.exe"
	$cal = "C:\temp4\cal2.bmp"

Else
	$picture = @ScriptDir & "\daten\sollte.JPG"
	$oldTimes = @ScriptDir & "\daten\oldTimes.JPG"
	$schuleIniFile = @ScriptDir & "\daten\schule.ini"
	$adfind = @ScriptDir & "\daten\AdFind.exe"
	$cal =  @ScriptDir & "\daten\cal2.bmp"
EndIf

#Region ### START Koda GUI section ### Form=c:\_natalie_eigene\pruefung_datenverteilungsammlung\datenverteilung.kxf
$hGUI1 = GUICreate("PruefTool", 702, 660, 224, 130)

$mInfo = GUICtrlCreateMenu("Info")
$mVerteiler = GUICtrlCreateMenuItem("Info zu diesem Tool", $mInfo)
$mAutoitLink = GUICtrlCreateMenuItem("Autoit Webseite", $mInfo)

$mKonten = GUICtrlCreateMenu("Konten")
$mKontenLeeren = GUICtrlCreateMenuItem("Prüfungskonten leeren", $mKonten)
$mGoAdmin = GUICtrlCreateMenuItem("Admin", $mKonten)


$Label1 = GUICtrlCreateLabel("Prüfungskonten Datenverteilung und Dateneinsammlung", 112, 8, 457, 24)
GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")

$Label3 = GUICtrlCreateLabel("Daten verteilen", 32, 80, 91, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$Label4 = GUICtrlCreateLabel("Datein einsammeln", 32, 176, 110, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$checkSpalte1 = GUICtrlCreateCheckbox("Spalte 1", 32, 584, 70, 17)
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetBkColor(-1, 0xC0DCC0)
$butDatenAuswahl = GUICtrlCreateButton("....", 32, 102, 19, 19)
$butSpeicherortAuswahl = GUICtrlCreateButton("....", 32, 199, 19, 19)
$labAuswahl = GUICtrlCreateLabel("Ordnerauswahl", 56, 104, 427, 17)
$labSpeicher = GUICtrlCreateLabel("Speicherort", 56, 201, 426, 17)
$butVerteilen = GUICtrlCreateButton("ausführen", 32, 128, 75, 25)
$butEinsammeln = GUICtrlCreateButton("ausführen", 32, 224, 75, 25)
$Pic1 = GUICtrlCreatePic($picture, 496, 70, 188, 164)
$CheckboxCheckAll = GUICtrlCreateCheckbox("alle markieren", 32, 274, 89, 17)
GUICtrlSetBkColor(-1, 0xC0DCC0)
$Combo1 = GUICtrlCreateCombo("combo", 496, 274, 121, 25,  $CBS_DROPDOWNLIST + $WS_VSCROLL)
$Label7 = GUICtrlCreateLabel("Homeverzeichnis im Explorer öffnen", 496, 248, 172, 17)
$butOpenKonto = GUICtrlCreateButton("öffnen", 624, 274, 61, 25)
$checkSpalte2 = GUICtrlCreateCheckbox("Spalte 2", 140, 584, 70, 17)
GUICtrlSetBkColor(-1, 0xC0DCC0)
$checkSpalte3 = GUICtrlCreateCheckbox("Spalte 3", 248, 584, 70, 17)
GUICtrlSetBkColor(-1, 0xC0DCC0)
$checkSpalte4 = GUICtrlCreateCheckbox("Spalte 4", 356, 584, 70, 17)
GUICtrlSetBkColor(-1, 0xC0DCC0)
$checkSpalte6 = GUICtrlCreateCheckbox("Spalte 6", 572, 584, 70, 17)
GUICtrlSetBkColor(-1, 0xC0DCC0)
$checkSpalte5 = GUICtrlCreateCheckbox("Spalte 5", 464, 584, 70, 17)
GUICtrlSetBkColor(-1, 0xC0DCC0)
$Label8 = GUICtrlCreateLabel("                                                                                             spaltenweise markieren", 0, 560, 704, 17)
GUICtrlSetBkColor(-1, 0xC0DCC0)
$comboSchule = GUICtrlCreateCombo("", 584, 40, 97, 25,   $CBS_DROPDOWNLIST + $WS_VSCROLL)
;~ $Label2 = GUICtrlCreateLabel("Schule: ", 528, 40, 43, 17)
$Label5 = GUICtrlCreateLabel("Eingeloggter Nutzer: ", 112, 40, 103, 17)
$Group1 = GUICtrlCreateGroup("", 24, 64, 465, 201)

$labDatum = GUICtrlCreateLabel(_NowDate ( ), 152, 176, 78, 17)
$butDatum = GUICtrlCreateButton("....", 218, 168, 30, 30, $BS_BITMAP)
GUICtrlSetImage(-1,"C:\_natalie_eigene\Pruefung_DatenVerteilungSammlung_V3\daten\cal2.bmp", -1)
GUICtrlSetCursor ($butDatum, 0)

GUICtrlCreateGroup("", -99, -99, 1, 1)
$labUser = GUICtrlCreateLabel("Name - Rolle - Schule",  216, 40, 307, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

func guiAdminKennwort()
	Global $hGUI3 = GUICreate("Admin", 271, 58, 282, 145)
	$Label1 = GUICtrlCreateLabel("Kennwort: ", 16, 16, 55, 17)
	$InputKennwort = GUICtrlCreateInput("", 72, 16, 105, 21,BitOR($ES_PASSWORD, $GUI_SS_DEFAULT_INPUT))
	$butKennwort = GUICtrlCreateButton("Absenden", 184, 16, 75, 25)
	GUISetState()
EndFunc

func gui2()
	Global $hGUI2 = GUICreate("Konten leeren", 308, 147, 262, 126)
	$Label1 = GUICtrlCreateLabel("           Prüfungskonten (Homelaufwerk und Desktop) leeren", 0, 8, 309, 18)
	GUICtrlSetBkColor(-1, 0xC0DCC0)
	$Radio30 = GUICtrlCreateRadio("Konten 1 bis 30", 32, 48, 113, 17)
	$Radio60 = GUICtrlCreateRadio("Konten 31 bis 60", 32, 74, 113, 17)
	$RadioAlle = GUICtrlCreateRadio("alle Konten", 32, 98, 113, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	Global $butExecGui2 = GUICtrlCreateButton("ausführen", 208, 64, 75, 25)
	GUISetState()

EndFunc

func guiDate()
	Global $hGuiDate = GUICreate("Auswahl Datum", 210, 190)

;~     Local $idDate = GUICtrlCreateMonthCal("1953/03/25", 10, 10)
    Global $idDate = GUICtrlCreateDate("", 10, 10, 100, 20, $DTS_SHORTDATEFORMAT)
    GUISetState(@SW_SHOW)
EndFunc

func setDatum($dat)
;~ 	MsgBox($MB_SYSTEMMODAL, "debug", _NowDate())
	If $dat > _NowDate() Then
		MsgBox($MB_SYSTEMMODAL, "Hinweis", "Datum liegt in Zukunft")
	Else
		GUICtrlSetData($labDatum,$dat)
	EndIf

EndFunc

GuiCtrlSetState ($comboSchule, $GUI_HIDE)
Global $userRolleSchule
Global $HomeLaufwerke
Global $checkboxSpalte1[10]
Global $checkboxSpalte2[10]
Global $checkboxSpalte3[10]
Global $checkboxSpalte4[10]
Global $checkboxSpalte5[10]
Global $checkboxSpalte6[10]
Global $pruefKonten[60]
Global $alleCheckboxKonten[60]
Global $ErgebnisArray[0]
Global $selectedFolderVerteil, $selectedFolderSammel


populateSchule()
fillKontenArray()
createCheckboxesKonten()
populateComboKonten()


func populateSchule()
			$nutzer = @UserName
		;~ 	$nutzer = "m.kurz_adm"
		;~ 	$nutzer = "michael.feichtner"
		;~ 	$nutzer = "1772.spuv01"
		;~ 	$nutzer = "frank.fischer"  ;MEBE
		;~ 	$nutzer = "julian.auerbach"  ;MEBE Schueler
		;~ 	$nutzer = "hans.stefani"
		;~ 	$nutzer = "benjamin.daum"  ;INTK
		;~ 	$nutzer = "christine.kazemi"   ;EHNO Lehrerin

		$userRolleSchule = $nutzer&" - "
			$schulIni = IniReadSection($schuleIniFile,"Schule")
		;~    MsgBox($MB_SYSTEMMODAL, "kontrolle $schuleIniFile", $schuleIniFile)
		;~    _arrayDisplay($schulIni)
			For $i = 1 To $schulIni[0][0]
		   ;~ MsgBox(4096, "", "Key: " & $var[$i][0] & @CRLF & "Value: " & $var[$i][1])
				GUICtrlSetData($comboSchule,$schulIni[$i][0])
			Next

		;~   ----------------------------------- Schulverbund und Rolle mittels AD Abfraermitteln ---------------------------

			$abfrageTeil1 = $adfind&" -b DC=mschool-ad,DC=muenchen,DC=musin,DC=de -f "
			$abfrageTeil2 = "(&(objectcategory=user)(samaccountname="&$nutzer&"))"
			$abfrageTeil3 = " distinguishedName"
			$abfrageGesamt = $abfrageTeil1 &'"'& $abfrageTeil2 &'"'&$abfrageTeil3

		;~ 	MsgBox($MB_SYSTEMMODAL, "kontrolle $abfrageGesamt", $abfrageGesamt)
			$DOS = Run($abfrageGesamt, "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
			ProcessWaitClose($DOS)
			$Message = StdoutRead($DOS)
		;~ 	MsgBox(0, "Stdout Read:", $Message)

		;~ 	OU=Administration
		;~ 	OU=Lehrer
		;~ 	OU=Schulverbund_SPUV
		;~ 	OU=Schulverbund_MEBE

			if StringInStr ( $Message, "OU=Administration") > 1 then
				$userRolleSchule = $userRolleSchule&"Admin"&" - "
				_GUICtrlComboBox_SelectString ($comboSchule, "SPUV")
		;~ 		MsgBox($MB_SYSTEMMODAL, "kontrolle admin", "admin")
				GuiCtrlSetState ($comboSchule, $GUI_SHOW)
			elseif StringInStr ( $Message, "OU=Lehrer") > 1 then
				$userRolleSchule = $userRolleSchule&"Lehrer"&" - "
		;~ 		MsgBox($MB_SYSTEMMODAL, "kontrolle lehrer", "lehrer")

		;~ 		----------------------- Schule ermitteln -----------------------------------
				if StringInStr ( $Message, "OU=Schulverbund_SPUV") > 1 then
					$userRolleSchule = $userRolleSchule&"SPUV"
		;~ 			GuiCtrlSetState ($comboSchule, $GUI_SHOW)
					 _GUICtrlComboBox_SelectString ($comboSchule, "SPUV")
				elseif StringInStr ( $Message, "OU=Schulverbund_EHNO") > 1 then
					$userRolleSchule = $userRolleSchule&"EHNO"
		;~ 			GuiCtrlSetState ($comboSchule, $GUI_SHOW)
					 _GUICtrlComboBox_SelectString ($comboSchule, "EHNO")
				elseif StringInStr ( $Message, "OU=Schulverbund_BSTR") > 1 then
					$userRolleSchule = $userRolleSchule&"BSTR"
		;~ 			GuiCtrlSetState ($comboSchule, $GUI_SHOW)
					 _GUICtrlComboBox_SelectString ($comboSchule, "BSTR")
				elseif StringInStr ( $Message, "OU=Schulverbund_BRIK") > 1 then
					$userRolleSchule = $userRolleSchule&"BRIK"
		;~ 			GuiCtrlSetState ($comboSchule, $GUI_SHOW)
					 _GUICtrlComboBox_SelectString ($comboSchule, "BRIK")
				Else
					MsgBox($MB_SYSTEMMODAL, "Schulverbund nicht registriert", "keine Berechtigung für dieses Tool")
					cleanup()
					Exit
				endif
			Else
				MsgBox($MB_SYSTEMMODAL, "Rolle des Nutzers: schueler", "keine Berechtigung für dieses Tool oder keine Netzwerkverbindung")
				cleanup()
				Exit
			EndIf
			GUICtrlSetData($labUser,$userRolleSchule)
			getHomelaufwerk()
endFunc

func getHomelaufwerk()
	$schule = GUICtrlRead($comboSchule)
;~ 	MsgBox($MB_SYSTEMMODAL, "kontrolle $schule", $schule)
	$schulIni = IniReadSection($schuleIniFile,"Schule")
	For $i = 1 To $schulIni[0][0]
		if $schulIni[$i][0] = $schule Then
			$HomeLaufwerke = $schulIni[$i][1]
		EndIf
	Next
;~ 	MsgBox($MB_SYSTEMMODAL, "kontrolle $HomeLaufwerke", $HomeLaufwerke)
EndFunc

func emptyErgebnisArray()
	For $i = UBound($ErgebnisArray) - 1 To 0 Step -1
;~     If $ErgebnisArray[$i] = "" Then                 ------------- gut wenn nur leere Werte gelöscht werden sollen
;~         _ArrayDelete($ErgebnisArray, $i)
;~     EndIf
	    _ArrayDelete($ErgebnisArray, $i)
	Next
EndFunc


func fillKontenArray()
	$schule = GUICtrlRead($comboSchule)
	Switch $schule
		Case "SPUV"
			For $i = 1 to 60
				if $i < 10 then
					$pruefKonten[$i-1] = "0"&$i&".pruefung"
				Else
					$pruefKonten[$i-1] = $i&".pruefung"
				endif
			next
		Case "EHNO"   ;- pruefung01.ehno
			For $i = 1 to 60
				if $i < 10 then
					$pruefKonten[$i-1] = "pruefung0"&$i&".ehno"
				Else
					$pruefKonten[$i-1] = "pruefung"&$i&".ehno"
				endif
			next
		Case "BSTR"   ;- pruefung01.ehno
			For $i = 1 to 60
				if $i < 10 then
					$pruefKonten[$i-1] = "pruefung0"&$i&".bstr"
				Else
					$pruefKonten[$i-1] = "pruefung"&$i&".bstr"
				endif
			next
		Case "BRIK"   ;- pruefung01.ehno
			For $i = 1 to 60
				if $i < 10 then
					$pruefKonten[$i-1] = "pruefung0"&$i&".brik"
				Else
					$pruefKonten[$i-1] = "pruefung"&$i&".brik"
				endif
			next



	EndSwitch


;~ 	_arrayDisplay($pruefKonten)
EndFunc

func getErgebnisListe()
emptyErgebnisArray()

local $zaehler = 0
	For $i = 0 To Ubound($alleCheckboxKonten)-1
		If _IsChecked($alleCheckboxKonten[$i]) Then
;~ 			$ErgebnisArray[$zaehler] = GUICtrlRead($alleCheckboxKonten[$i],1)
			_ArrayAdd($ErgebnisArray,GUICtrlRead($alleCheckboxKonten[$i],1))
			$zaehler = $zaehler + 1
		EndIf
	Next
;~ _ArrayDisplay($ErgebnisArray)
EndFunc


func createCheckboxesKonten()
	local $leftPix = 32  ; 108 Schritt   140 - 248
	local $topPix = 309  ;24 Schritt  - 400 - 424 -
	local $width = 97
	local $height = 17
	local $zaehlerPruefkonten = 0

	For $i = 0 to 9  ; 1. Spalte
		$checkboxSpalte1[$i] = GUICtrlCreateCheckbox($pruefKonten[$zaehlerPruefkonten], $leftPix,$topPix, 97, 17)  ;left,top,width,height
		$alleCheckboxKonten[$zaehlerPruefkonten]= $checkboxSpalte1[$i]
		$topPix = $topPix + 24
		$zaehlerPruefkonten = $zaehlerPruefkonten +1
	next

	$leftPix = 140
	$topPix = 309
	For $i = 0 to 9  ; 2. Spalte
		$checkboxSpalte2[$i] = GUICtrlCreateCheckbox($pruefKonten[$zaehlerPruefkonten], $leftPix,$topPix, 97, 17)  ;left,top,width,height
		$alleCheckboxKonten[$zaehlerPruefkonten]= $checkboxSpalte2[$i]
		$topPix = $topPix + 24
		$zaehlerPruefkonten = $zaehlerPruefkonten +1
	next

	$leftPix = 248
	$topPix = 309
	For $i = 0 to 9  ; 3. Spalte
		$checkboxSpalte3[$i] = GUICtrlCreateCheckbox($pruefKonten[$zaehlerPruefkonten], $leftPix,$topPix, 97, 17)  ;left,top,width,height
		$alleCheckboxKonten[$zaehlerPruefkonten]= $checkboxSpalte3[$i]
		$topPix = $topPix + 24
		$zaehlerPruefkonten = $zaehlerPruefkonten +1
	next

	$leftPix = 356
	$topPix = 309
	For $i = 0 to 9  ; 4. Spalte
		$checkboxSpalte4[$i] = GUICtrlCreateCheckbox($pruefKonten[$zaehlerPruefkonten], $leftPix,$topPix, 97, 17)  ;left,top,width,height
		$alleCheckboxKonten[$zaehlerPruefkonten]= $checkboxSpalte4[$i]
		$topPix = $topPix + 24
		$zaehlerPruefkonten = $zaehlerPruefkonten +1
	next

	$leftPix = 464
	$topPix = 309
	For $i = 0 to 9  ; 5. Spalte
		$checkboxSpalte5[$i] = GUICtrlCreateCheckbox($pruefKonten[$zaehlerPruefkonten], $leftPix,$topPix, 97, 17)  ;left,top,width,height
		$alleCheckboxKonten[$zaehlerPruefkonten]= $checkboxSpalte5[$i]
		$topPix = $topPix + 24
		$zaehlerPruefkonten = $zaehlerPruefkonten +1
	next

	$leftPix = 572
	$topPix = 309
	For $i = 0 to 9  ; 6. Spalte
		$checkboxSpalte6[$i] = GUICtrlCreateCheckbox($pruefKonten[$zaehlerPruefkonten], $leftPix,$topPix, 97, 17)  ;left,top,width,height
		$alleCheckboxKonten[$zaehlerPruefkonten]= $checkboxSpalte6[$i]
		$topPix = $topPix + 24
		$zaehlerPruefkonten = $zaehlerPruefkonten +1
	next
;~ 	_ArrayDisplay($alleCheckboxKonten)
EndFunc

Func populateComboKonten()
	$cData = ""
	For $i = 0 To Ubound($pruefKonten)-1
		$cData &= "|" & $pruefKonten[$i]
	Next
	GUICtrlSetData($Combo1, $cData)
	GUICtrlSendMsg($Combo1, $CB_SETMINVISIBLE, 15, 0)
EndFunc

func otherSchoolChosen()
	getHomelaufwerk()
	fillKontenArray()
	populateComboKonten()
;~ _ArrayDisplay($checkboxSpalte1)
;~ _ArrayDisplay($alleCheckboxKonten)
	For $i = 0 to 59  ;dlle checkboxen entfernen
		GUICtrlDelete($alleCheckboxKonten[$i])
	next

	createCheckboxesKonten()
EndFunc

func testServerConnection()
	getHomelaufwerk()
	$server = StringMid ( $HomeLaufwerke, 3,8)
	$var = Ping($server)
	If not @error Then
		return True
	else
		return False
	EndIf


EndFunc

While 1

	$aMsg = GUIGetMsg($GUI_EVENT_ARRAY)

	Switch $aMsg[1]
		Case $hGUI1  ; The event comes from the GUI1
			 Switch $aMsg[0]
					case $butDatum
						guiDate()
				    case $mGoAdmin
						guiAdminKennwort()
					Case $comboSchule
			;~ 			MsgBox($MB_SYSTEMMODAL, "kontrolle gewählte Schule", guiCtrlread($comboSchule,1))
						otherSchoolChosen()
					Case $GUI_EVENT_CLOSE
						cleanup()
						Exit
					Case $mVerteiler
						MsgBox(64, "Info", "Tool zum Verteilen und Einsammeln von Prüfungsdaten." & @CRLF & _
						"für die Konten :  01.pruefung .. bis .. 60.pruefung" & @CRLF & _
						"" & @CRLF & _
						"" & @CRLF & _
						"" & @CRLF & _
						"" & @CRLF & _
						"Unter 'Daten verteilen' einen Ordner auswählen, dessen Inhalt in die " & @CRLF & _
						"Prüfungs-Homeverzeichnisse kopiert werden soll." & @CRLF & _
						"Das Datenvolumen der zu verteilenden Daten wird überprüft." & @CRLF & _
						"Das Maximum beträgt 40 MB" & @CRLF & _
						"Die Daten werden im Homeverzeichnis in einem Ordner namens" & @CRLF & _
						"'PruefungsDaten_dd.mm.yyyy' abgelegt." & @CRLF & _
						"" & @CRLF & _
						"" & @CRLF & _
						"Gleichzeitig wird in den Homeverzeichnissen ein leerer Ordner namens" & @CRLF & _
						"'Ergebnis_Kontoname_dd.mm.yyyy' erzeugt." & @CRLF & _
						"In diesem Ordner ist auch das Prüfungsergebnis abzulegen." & @CRLF & _
						"Dieser Ordner wird eingesammelt" & @CRLF & _
						"" & @CRLF & _
						"" & @CRLF & _
						"Unter 'Daten einsammln' einen Ordner auswählen." & @CRLF & _
						"In diesem wird ein Ordner namens" & @CRLF & _
						"'Pruefungsergebnisse_dd.mm.yyyy' angelegt," & @CRLF & _
						"worin dann die Prüfungsergebnisse gesammelt werden." & @CRLF & _
						"Bitte sicherstellen, dass genügend Speicherplatz vorhanden ist." & @CRLF & _
						"Es erfolgt hier keine Prüfung" & @CRLF & _
						"" & @CRLF & _
						"" & @CRLF & _
						"" & @CRLF & _
						"Dieses Tool wurde mit Autoit erstellt." & @CRLF & _
						""&@CRLF&@CRLF&@CRLF&"Natalie Scheuble, Juni 2018")
					Case $mAutoitLink
						Run(@ComSpec & " /c Start https://www.autoitscript.com/site/autoit/")
			;~ 		Case $labOldTimes
			;~ 			ShellExecute(@ScriptDir & "\daten\oldTimes.JPG")
			;~ 			$SplashScreenGui = GUICreate("SplashScreen", 502, 502, -1,-1,$WS_POPUP)
			;~ 			WinSetTrans($SplashScreenGui, "", 502)
			;~ 			$Pic1 = GUICtrlCreatePic($oldTimes, 0, 0, 502, 502)
			;~ 			GUISetState(@SW_SHOW,$SplashScreenGui)
			;~ 			Sleep(3000)
			;~ 			GUISetState(@SW_HIDE,$SplashScreenGui)
					Case $checkSpalte1
							If _IsChecked($checkSpalte1) Then
								checkUncheckSpalten($checkboxSpalte1,1)
							Else
								checkUncheckSpalten($checkboxSpalte1,0)
							EndIf
					Case $checkSpalte2
							If _IsChecked($checkSpalte2) Then
								checkUncheckSpalten($checkboxSpalte2,1)
							Else
								checkUncheckSpalten($checkboxSpalte2,0)
							EndIf
					Case $checkSpalte3
							If _IsChecked($checkSpalte3) Then
								checkUncheckSpalten($checkboxSpalte3,1)
							Else
								checkUncheckSpalten($checkboxSpalte3,0)
							EndIf
					Case $checkSpalte4
							If _IsChecked($checkSpalte4) Then
								checkUncheckSpalten($checkboxSpalte4,1)
							Else
								checkUncheckSpalten($checkboxSpalte4,0)
							EndIf
					Case $checkSpalte5
							If _IsChecked($checkSpalte5) Then
								checkUncheckSpalten($checkboxSpalte5,1)
							Else
								checkUncheckSpalten($checkboxSpalte5,0)
							EndIf
					Case $checkSpalte6
							If _IsChecked($checkSpalte6) Then
								checkUncheckSpalten($checkboxSpalte6,1)
							Else
								checkUncheckSpalten($checkboxSpalte6,0)
							EndIf
					Case $CheckboxCheckAll
							If _IsChecked($CheckboxCheckAll) Then
								checkUncheckSpalten($alleCheckboxKonten,1)
								checkUncheckBox($checkSpalte1,1)
								checkUncheckBox($checkSpalte2,1)
								checkUncheckBox($checkSpalte3,1)
								checkUncheckBox($checkSpalte4,1)
								checkUncheckBox($checkSpalte5,1)
								checkUncheckBox($checkSpalte6,1)
							Else
								checkUncheckSpalten($alleCheckboxKonten,0)
								checkUncheckBox($checkSpalte1,0)
								checkUncheckBox($checkSpalte2,0)
								checkUncheckBox($checkSpalte3,0)
								checkUncheckBox($checkSpalte4,0)
								checkUncheckBox($checkSpalte5,0)
								checkUncheckBox($checkSpalte6,0)
							EndIf
					Case $butOpenKonto
							If testServerConnection() Then
;~ 							 	MsgBox($MB_SYSTEMMODAL, "kontrolle $server", $server)
								local $konto = GUICtrlRead($Combo1)
;~ 					 			MsgBox($MB_SYSTEMMODAL, "kontrolle", $konto)
								$FolderPath = $HomeLaufwerke&$konto
								if FileExists($FolderPath) then
									Run("Explorer.exe " & $FolderPath)
								Else
									MsgBox(64, "Hinweis", "Ordner nicht vorhanden")
								EndIf
							Else
								MsgBox(0, "Connection Status", "Server nicht erreichbar")
							Endif


					Case $mKontenLeeren
							; Disable the first GUI
;~ 							GUISetState(@SW_DISABLE, $hGUI1)
							gui2()
							; Re-enable the first GUI
;~ 							GUISetState(@SW_ENABLE, $hGUI1)

			;~ 			if(jaNeinButton("Alle Daten auf Desktop und in Homeverzeichnissen löschen?")) then
			;~ 				_ArrayDisplay($pruefKonten)
			;~ 				alleKontenZuruecksetzen()
			;~ 			EndIf

					Case $butDatenAuswahl
						selectFolder($labAuswahl,"Ordner auswählen","1")
					Case $butSpeicherortAuswahl
						selectFolder($labSpeicher,"Ziel für gesammelte Daten","2")
					Case $butVerteilen
						if(jaNeinButton("Daten jetzt verteilen?")) then
							Verteilung()
						EndIf

					Case $butEinsammeln
						if(jaNeinButton("Daten jetzt einsammeln?")) then
							Einsammlung()
						EndIf
			 EndSwitch


		Case $hGUI2  ; The event comes from the GUI2

			 Switch $aMsg[0]
				    Case $GUI_EVENT_CLOSE
                        GUIDelete($hGUI2)
				 Case $butExecGui2
					 	if(jaNeinButton("Alle Daten auf Desktop und in Homeverzeichnissen löschen?")) then
					    if GUICtrlRead($Radio30) = 1 Then
							alleKontenZuruecksetzen("30")
					    EndIf
					    if GUICtrlRead($Radio60) = 1 Then
							alleKontenZuruecksetzen("60")
						EndIf
					    if GUICtrlRead($RadioAlle) = 1 Then
							alleKontenZuruecksetzen("all")
						EndIf
						EndIf
             EndSwitch

		Case $hGUI3  ; The event comes from the GUI2
			 Switch $aMsg[0]
				    Case $GUI_EVENT_CLOSE
                        GUIDelete($hGUI3)
				    Case $butKennwort
						if GUICtrlRead($InputKennwort) = "xxxx" Then
							GuiCtrlSetState ($comboSchule, $GUI_SHOW)
							GUIDelete($hGUI3)
						Else
							GUICtrlSetData($InputKennwort,"")
							MsgBox($MB_SYSTEMMODAL, "Info", "Passwort nicht korrekt")
						EndIf


             EndSwitch
		Case $hGuiDate  ; The event comes from $hGuiDate
			 Switch $aMsg[0]
				    Case $GUI_EVENT_CLOSE
                        GUIDelete($hGuiDate)
					Case $idDate
						setDatum(GUICtrlRead($idDate))
;~ 						GUICtrlSetData($butDatum,$idDate)
;~ 						MsgBox($MB_SYSTEMMODAL, "Date", GUICtrlRead($idDate), 2)

             EndSwitch

	EndSwitch
WEnd



;~ Ergebnis_xx.pruefung_dd.mm.yyyy  - cave: nicht überschreiben!
;~ PruefungsDaten_dd.mm.yyyy
func testeOrdnerGroesse($dir)  ; teste erst ob Ordner ausgewählt ist und dann ob Inhalt leer oder über 40 MB enthält
	if $dir = "" or $dir = "Ordnerauswahl" Then
		MsgBox($MB_SYSTEMMODAL, "Hinweis", "kein Ordner ausgewählt")
		return false
	EndIf
	$gewaehlterOrdner = _FileListToArray ( $dir)
		if IsArray($gewaehlterOrdner) then
		Local $iSizeByte = DirGetSize($dir)
;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle $iSizeByte", $iSizeByte)
		Local $iSizeMB = DirGetSize($dir) / 1024 / 1024
	;~ 	MsgBox($MB_SYSTEMMODAL, "Kontrolle $iSizeByte", $iSizeByte)
	;~ 	MsgBox($MB_SYSTEMMODAL, "Kontrolle $iSizeMB", $iSizeMB)

	;~ 	if $iSizeByte = 0 Then   ;nicht zuverlässig wenn kleine Datei unter ein byte
	;~ 		MsgBox($MB_SYSTEMMODAL, "Hinweis", "Ordner ist leer")
	;~ 		return false
	;~ 	EndIf
		if $iSizeMB > 40 then
			MsgBox($MB_SYSTEMMODAL, "Hinweis", "Der Ordner enthält mehr als 40MB")
			return false
		EndIf
	EndIf
	return True
EndFunc

func testeObKontenAugewaehlt()
	getErgebnisListe()
	if UBound($ErgebnisArray) > 0 Then
		return True
	Else
		MsgBox($MB_SYSTEMMODAL, "Hinweis", "es wurden keine Konten für die Verteilung ausgewählt")
		return False
	EndIf

EndFunc

func Verteilung()
;~ 	als erstes wird überprüft, ob Server erreichbar, dann ob ein Ordner gewählt wurde - dann ob er Inhalt hat - wenn ja, ob nicht über 40 MB gross (funktion testeOrdnerGroesse($dir))
;~ dann wird in Schleife das ErgebnisArray (die Prüfungskonten, die ausgwählt wurden) durchlaufen und in jedem Homeverzeichnis
;~ ein Ordner "PruefungsDaten_dd.mm.yyyy" angelegt. In diesen werden die Daten kopiert. Sollte der Ordner schon existieren, wird er ersetzt
;~ ausserdem wird in jedem Homeverzeichnis ein leerer Ordner "Ergebnis_xx.pruefung_dd.mm.yyyy" angelegt. Dort soll Schüler sein Ergebnis hineinkopieren.
;~ dieser Ordner wird eingesammelt.

If testServerConnection() Then
	local $kontrolDirCreateSuccess = 1 ; 0 = failure

	getHomelaufwerk()
	local $folderSelected = $selectedFolderVerteil  ;wird in funktion "Select Folder" zugewiesen - label ablesen geht nicht immer, weil Anzeige eingekuerzt wird
	if testeOrdnerGroesse($folderSelected) and testeObKontenAugewaehlt() > 0 then

		ProgressOn("Kopiervorgang läuft", "")


			;------------------------ ab hier kopierroutine ----------------------------------------------
			getErgebnisListe()
;~ 			_ArrayDisplay($ErgebnisArray)
			$copyFrom = $folderSelected
			$copyFrom = '"'&$copyFrom&'"'
			$datum = _NowDate()
;~ 			MsgBox($MB_SYSTEMMODAL, "Kontrolle $datum", $datum)
			$ordner = "PruefungsDaten_"&$datum&"\"
		$ProzentSchritte = 100 / UBound($ErgebnisArray)
;~ 			MsgBox($MB_SYSTEMMODAL, "Kontrolle $ProzentSchritte", $ProzentSchritte)
		$ProzentFortschritt = $ProzentSchritte
			For $i = 0 to UBound($ErgebnisArray) - 1
		ProgressSet ($ProzentFortschritt,Round($ProzentFortschritt) & "%")
				$konto = $ErgebnisArray[$i]
				$ordner2 = "Ergebnis_"&$konto&"_"&$datum&"\"
;~ 				MsgBox($MB_SYSTEMMODAL, "Kontrolle $konto", $konto)
				$copyTo = $HomeLaufwerke&$konto&"\"&$ordner
				$copyToLeererErgebnisFolder = $HomeLaufwerke&$konto&"\"&$ordner2
				if FileExists($copyTo) then
					DirRemove($copyTo,1)   ; flag 1 remove files and subdirectories     -  flag 0 deletes the folder, only if it is empty
;~ 					MsgBox($MB_SYSTEMMODAL, "Kontrolle $copyTo", "Ordner existiert und wird gelöscht")
				EndIf
				if NOT FileExists($copyToLeererErgebnisFolder) then
					$kontrol = DirCreate($copyToLeererErgebnisFolder)
					if $kontrol = 0 and $kontrolDirCreateSuccess = 1 Then
						$kontrolDirCreateSuccess = 0
					EndIf
				EndIf




;~ 			MsgBox($MB_SYSTEMMODAL, "Kontrolle $copyTo", $copyTo)
;~ 			MsgBox($MB_SYSTEMMODAL, "Kontrolle $copyFrom", $copyFrom)
;~ 				Run('xcopy /e /h /Y '&$copyFrom&' '&$copyTo, "")
				Run('xcopy /e /h /Y '&$copyFrom&' '&$copyTo, "", @SW_HIDE )
		$ProzentFortschritt = $ProzentFortschritt + $ProzentSchritte
;~ 				MsgBox($MB_SYSTEMMODAL, "Kontrolle $ProzentSchritte", $ProzentFortschritt &" von: "&$i)
			next
		if $kontrolDirCreateSuccess = 0 Then
			ProgressSet(100, "Fehler", "Fehler beim Kopiervorgang")
			Sleep(3000)
			MsgBox($MB_SYSTEMMODAL, "Kopiervorgang", "Kopiervorgang nicht erfolgreich.")
		Else
			ProgressSet(100, "Fertig", "Daten kopiert")
		EndIf

		Sleep(2000)
		ProgressOff()

	EndIf
Else
	MsgBox(0, "Connection Status", "Server nicht erreichbar")
Endif

EndFunc


func Einsammlung()
	If testServerConnection() Then
		getHomelaufwerk()
		local $showReport = ""
		local $showReportOrdnerFehlt = ""
		local $WarnFehlen,$WarnLeer
	;~ 	MsgBox($MB_SYSTEMMODAL, "kontrolle", "Daten werden eingesammelt")
		if testeObKontenAugewaehlt() > 0 then
			local $folderSelected = $selectedFolderSammel  ;wird in funktion "Select Folder" zugewiesen - label ablesen geht nicht immer, weil Anzeige eingekuerzt wird
			if $folderSelected = "" or $folderSelected = "Speicherort" then
				MsgBox($MB_SYSTEMMODAL, "Hinweis", "kein Ordner ausgewählt")
			Else
				ProgressOn("Einsammeln der Daten läuft", "")

					;------------------------ ab hier kopierroutine ----------------------------------------------
					getErgebnisListe()
		;~ 			_ArrayDisplay($ErgebnisArray)
					$datum = GUICtrlRead($labDatum)
	;~ 	 			MsgBox($MB_SYSTEMMODAL, "Kontrolle $datum", $datum)
					$SammelOberOrdner = "Pruefungsergebnisse_"&$datum&"\"
					$Ziel = $folderSelected&"\"&$SammelOberOrdner
					$Ziel = StringReplace ( $Ziel, "\\", "\")   ;für den Fall dass root von Laufwerk angegeben wird, dann kommt zu E:\\Ergebnis_dd.mm.yyyy\
					if FileExists($Ziel) then
						DirRemove($Ziel,1)   ;
					EndIf
					DirCreate($Ziel)
		;~ 			MsgBox($MB_SYSTEMMODAL, "Kontrolle $Ziel", $Ziel)
					$ProzentSchritte = 100 / UBound($ErgebnisArray)
		;~ 			MsgBox($MB_SYSTEMMODAL, "Kontrolle $ProzentSchritte", $ProzentSchritte)
					$ProzentFortschritt = $ProzentSchritte
					For $i = 0 to UBound($ErgebnisArray) - 1
						ProgressSet ($ProzentFortschritt,Round($ProzentFortschritt) & "%")
						$konto = $ErgebnisArray[$i]
						$ordnerToCollect = "Ergebnis_"&$konto&"_"&$datum  ;Ordner des Prueflings

		;~ 				MsgBox($MB_SYSTEMMODAL, "Kontrolle $ordnerToCollect", $ordnerToCollect)
						$copyFrom = $HomeLaufwerke&$konto&"\"&$ordnerToCollect

	;~ 	 				MsgBox($MB_SYSTEMMODAL, "Kontrolle $copyFrom", $copyFrom)

						$OrdnerToCollectImZiel =$Ziel&$ordnerToCollect
						if FileExists($copyFrom) then
							DirCreate($OrdnerToCollectImZiel)


							$OrdnerToCollectImZiel = '"'&$OrdnerToCollectImZiel&'"'
		;~ 				MsgBox($MB_SYSTEMMODAL, "Kontrolle $copyFrom", $copyFrom)
		;~ 				MsgBox($MB_SYSTEMMODAL, "Kontrolle $OrdnerToCollectImZiel", $OrdnerToCollectImZiel)

							Run('xcopy /e /h /Y '&$copyFrom&' '&$OrdnerToCollectImZiel, "",@SW_HIDE )
		;~ 				----------------------------- Pruefe auf leere Ergebnis Ordner ---------------------------------------------
		;~ 					MsgBox($MB_SYSTEMMODAL, "Kontrolle $copyFrom", $copyFrom)
							$testArray = _FileListToArray ( $copyFrom)
		;~ 					_ArrayDisplay($testArray)
		;~ 					MsgBox($MB_SYSTEMMODAL, "Kontrolle $sizeFolder", $sizeFolder)
							if not IsArray($testArray) then
								$showReport = $showReport & @CRLF & $ordnerToCollect
							EndIf
		;~ 				-----------------------------  ENDE Pruefe auf leere Ergebnis Ordner ---------------------------------------------

							$ProzentFortschritt = $ProzentFortschritt + $ProzentSchritte
			;~ 				MsgBox($MB_SYSTEMMODAL, "Kontrolle $ProzentSchritte", $ProzentFortschritt &" von: "&$i)
						else
							$showReportOrdnerFehlt = $showReportOrdnerFehlt & @CRLF & $ordnerToCollect

						EndIf

					next
				ProgressSet(100, "Fertig", "Daten eingesammelt")
				Sleep(1000)
				ProgressOff()

		;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle $Ziel", $Ziel)
				Run("Explorer.exe " & $Ziel)   ;Ergebnisordner im Explorer öffnen

		;~ 		----------------- ermitteln ob Ordner leer sind, d.h. Prüfling hat seine Ergebnisse nicht darin gespeichert --------------------------------

			EndIf
		EndIf
		if not $showReport = "" or not $showReportOrdnerFehlt = "" then
			if not $showReport = "" then
				$WarnLeer = "Folgende Ordner sind leer:"& $showReport
			EndIf
			if not $showReportOrdnerFehlt = "" then
				$WarnFehlen = "Folgende Ordner fehlen:" & $showReportOrdnerFehlt
			EndIf

			MsgBox($MB_SYSTEMMODAL, "Kontrolle Ergebnisordner",$WarnLeer & @CRLF & @CRLF & $WarnFehlen)
		EndIf
	Else
		MsgBox(0, "Connection Status", "Server nicht erreichbar")
	Endif
EndFunc

func pruefeAufLeereErgebnisOrdner($peicherOrdner)
$gesammelteOrdner = _FileListToArray ( $peicherOrdner)
	;~ 		_ArrayDisplay($gesammelteOrdner)
			$showReport = ""
			for $i = 1 to $gesammelteOrdner[0]
				$ordnerToCheck = $peicherOrdner&$gesammelteOrdner[$i]&"\"
	;~ 			MsgBox($MB_SYSTEMMODAL, "Kontrolle $ordnerToCheck", $ordnerToCheck)
				$testArray = _FileListToArray ( $ordnerToCheck)
;~ 				MsgBox($MB_SYSTEMMODAL, "Kontrolle $sizeFolder", $sizeFolder)
				if not IsArray($testArray) then
					$showReport = $showReport & @CRLF & $gesammelteOrdner[$i]
				EndIf
	;~ 			MsgBox($MB_SYSTEMMODAL, "Kontrolle $sizeFolder", $sizeFolder)
			next
			if not $showReport = "" Then
				$Warn = "Folgende Ordner sind leer:" & @CRLF & @CRLF
				MsgBox($MB_SYSTEMMODAL, "Kontrolle Ergebnisordner",$Warn & $showReport)
			EndIf
EndFunc

func alleKontenZuruecksetzen($anzahl)
	GUIDelete($hGUI2)
	$zuLoeschende = 59
	$anfang = 0
	$ende = 59
	switch $anzahl
		case "30"
			$ende = 29
			$zuLoeschende = 30
		case "60"
			$anfang = 30
			$zuLoeschende = 30
	EndSwitch
;~ 	MsgBox($MB_SYSTEMMODAL, "Kontrolle anzahl zu löschende: ", "anfang: "&$anfang &"ende: "&$ende)

;~ 	$breakForLoop = 1


	getHomelaufwerk()
	ProgressOn("Daten in den Pruefungs-Homeverzeichnissen werden gelöscht", "")
	$ProzentSchritte = 100 / $zuLoeschende
	$ProzentFortschritt = $ProzentSchritte

;~ 	For $i = 10 to 11
	For $i = $anfang to $ende

		$FolderToEmpty = $HomeLaufwerke&$pruefKonten[$i]
;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle $FolderToEmpty",$FolderToEmpty)
;~ 	if 	$breakForLoop = 1 Then  ;del nach test
;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle $FolderToEmpty", $FolderToEmpty)  ;del nach test
;~ 	else  ;del nach test

		if FileExists($FolderToEmpty) then
			$aFileList = _FileListToArray($FolderToEmpty, "*")
;~ 			_ArrayDisplay($aFileList)
			if IsArray($aFileList) Then  ;prüfen ob homelaufwerk überhaupt daten enthält
				for $j = 1 to $aFileList[0]
					if $aFileList[$j] = "Eigene Dateien" then
	;~ 					MsgBox($MB_SYSTEMMODAL, "Kontrolle Eigene Dateien", "eigene Dateien existent - Desktop Inhalt löschen")
						$desktop = $FolderToEmpty&"\"&$aFileList[$j]&"\Desktop\*"
	;~ 					MsgBox($MB_SYSTEMMODAL, "Kontrolle Eigene Dateien desktop",$desktop)
						FileDelete($desktop)
					ElseIf $aFileList[$j] = "Dokumente" then
						$desktop = $FolderToEmpty&"\"&$aFileList[$j]&"\Desktop\*"
;~ 						MsgBox($MB_SYSTEMMODAL, "Kontrolle Dokumente desktop",$desktop)
						FileDelete($desktop)
					else
						$ordnerFileToDelete = $FolderToEmpty&"\"&$aFileList[$j]
;~ 	     				MsgBox($MB_SYSTEMMODAL, "Kontrolle $ordnerFileToDelete", $ordnerFileToDelete)
;~ 						MsgBox($MB_SYSTEMMODAL, "Kontrolle FileGetAttrib()", FileGetAttrib($ordnerFileToDelete))
						if FileGetAttrib($ordnerFileToDelete)="A" Then     ; file = A   directory = D
							FileDelete($ordnerFileToDelete)
						Else
							DirRemove($ordnerFileToDelete,1)
						EndIf
					EndIf
				Next
			EndIf
		EndIf
;~ 	endif	  ;del nach test

	ProgressSet ($ProzentFortschritt,Round($ProzentFortschritt) & "%")
	$ProzentFortschritt = $ProzentFortschritt + $ProzentSchritte
	Next

	ProgressSet(100, "Daten wurden gelöscht", "Löschvorgang erfolgt")
	Sleep(2000)
	ProgressOff()

EndFunc


Func selectFolder($labelToShowSelection,$TextToDisplay,$vonButton)   ;$vonButton = 1 (verteiler)   $vonButton = 2 (einsammeln)
;~ 	Local $sFileOpenDialog = FileOpenDialog($sMessage, @WindowsDir & "\", "CSV Datei (*.csv)", $FD_FILEMUSTEXIST)
;~ 	$selectedFolder = FileSelectFolder($TextToDisplay,"c:\")
	$selectedFolder = FileSelectFolder($TextToDisplay,"C:\")  ;---------------- nur während entwicklung
;~  MsgBox($MB_SYSTEMMODAL, "Kontrolle $vonButton", $vonButton)

	if $vonButton = "1" Then
		$selectedFolderVerteil = $selectedFolder
	else
		$selectedFolderSammel = $selectedFolder
	EndIf
;~ 	 MsgBox($MB_SYSTEMMODAL, "Kontrolle $selectedFolderVerteil", $selectedFolderVerteil)
;~ 	 MsgBox($MB_SYSTEMMODAL, "Kontrolle $selectedFolderSammel", $selectedFolderSammel)

	If @error Then
        MsgBox($MB_SYSTEMMODAL, "", "Kein Ordner ausgewählt.")
	EndIf
;~ 	MsgBox($MB_SYSTEMMODAL, "StringLen($selectedFolder)", StringLen($selectedFolder))
	if StringLen($selectedFolder) > 65 then
		GUICtrlSetData($labelToShowSelection, "..... "&StringRight($selectedFolder, 65))
	Else
		GUICtrlSetData($labelToShowSelection,$selectedFolder)

	EndIf
EndFunc

func checkUncheckSpalten($spalte,$checkJa)
	if $checkJa Then
		For $i = 0 To Ubound($spalte)-1
			GUICtrlSetState($spalte[$i],$GUI_CHECKED)
		Next
	else
		For $i = 0 To Ubound($spalte)-1
			GUICtrlSetState($spalte[$i],$GUI_UNCHECKED)
		Next
	EndIf

EndFunc

func checkUncheckBox($boxname,$checkJa)
	if $checkJa Then
		GUICtrlSetState($boxname,$GUI_CHECKED)
	else
		GUICtrlSetState($boxname,$GUI_UNCHECKED)
	EndIf

EndFunc


Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

func jaNeinButton($text)  ;Sicherheitsabfrage bei "shutdown all", "log PCs on", "Remove Logon" and "WOL all"
	$verify = MsgBox(4, $text, "Ja oder Nein?")
	If $verify = 6 Then
;~ 		MsgBox(0, "Yes", "Yes")
		return True
	ElseIf $verify = 7 Then
;~ 		MsgBox(0, "No", "No")
		return False
	EndIf
EndFunc

func cleanup()
	$filePath = "c:\temp4"
    If FileExists($filePath) Then
		DirRemove ($filePath ,1 )
    EndIf
	$filePath = "c:\temp6"
    If FileExists($filePath) Then
		DirRemove ($filePath ,1 )
    EndIf
	$filePath = "c:\temp8"
    If FileExists($filePath) Then
		DirRemove ($filePath ,1 )
    EndIf
EndFunc
