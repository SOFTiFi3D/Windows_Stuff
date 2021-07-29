#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;-------------------------------------------------------------------------------
;Windows Key to Launch Launcher
;The Launcher Hotkey within it's app is set to [Alt + P]
;-------------------------------------------------------------------------------

LWin up::
If (A_PriorKey = "LWin") ; LWin was pressed alone
    Send, !p
return

; In this case its necessary to define a custom combination by using "&" or "<#" 
; to avoid that LWin loses its original function as a modifier key:

<#d:: Send #d  ; <# means LWin


;-------------------------------------------------------------------------------
;Capslock to run google search
;-------------------------------------------------------------------------------
CapsLock::
SoundPlay, C:\Users\TIDs\Documents\OKGOOGLE.wav
DefaultBrowser() {
	; Find the Registry key name for the default browser
	RegRead, BrowserKeyName, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html\UserChoice, Progid

	; Find the executable command associated with the above Registry key
	RegRead, BrowserFullCommand, HKEY_CLASSES_ROOT, %BrowserKeyName%\shell\open\command

	; The above RegRead will return the path and executable name of the brower contained within quotes and optional parameters
	; We only want the text contained inside the first set of quotes which is the path and executable
	; Find the ending quote position (we know the beginning quote is in position 0 so start searching at position 1)
	StringGetPos, pos, BrowserFullCommand, ",,1

	; Decrement the found position by one to work correctly with the StringMid function
	pos := --pos

	; Extract and return the path and executable of the browser
	StringMid, BrowserPathandEXE, BrowserFullCommand, 2, %pos%
	Return BrowserPathandEXE
}
InputBox, searchGoogle, Whatchu wanna know?,

if ErrorLevel
Return
else if searchGoogle=
Run, % DefaultBrowser()
else Run, https:google.com/search?q=%searchGoogle% 
Return

^SPACE::  Winset, Alwaysontop, , A

SetTimer, NextCTF, 5000
return
NextCTF:
If(Mod(A_Hour, 2) == 0)
		{
			if (A_Min = 50)
			{
				MsgBox, You have 5 minutes until CTF
				SetTimer, NextCTF, 7196999
			}
		}
Return
