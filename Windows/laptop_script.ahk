; 0; ^ = control
; ! = alt
; + = shift/
; # = windows key
; `n = newline

#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#HotkeyInterval 2000
#MaxHotkeysPerInterval 200

SetTitleMatchMode 2
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
DetectHiddenWindows, Off


; ---------- Edit script with Notepad++ ------
Capslock & NumpadDiv::
keyWait Capslock
Run "C:\Program Files (x86)\Notepad++\notepad++.exe" "C:\path\to\laptop_script.ahk"
SetCapsLockState, Off
return

; ---------- Pause / suspend script ------
Capslock & NumpadMult::
keyWait Capslock
Suspend
if (A_IsSuspended)
	SplashTextOn, 400, 100, , Suspending
else
	SplashTextOn, 400, 100, , Resuming
Sleep 600
SplashTextOff
SetCapsLockState, Off
return

; -------------- Global Helpers -----------------
addDelay() {
	BlockInput On
	Sleep 200
	BlockInput Off
	SetCapsLockState, Off
}

resizeWindow()
{
BlockInput, MouseMove
SoundBeep, 800, 100
Send !{Space}
Sleep 100
Send s
;Send {Down 3}
Sleep 10
;Send {Enter}
Sleep 10
Send {Down}
Sleep 10
Send {Right}
Sleep 10
BlockInput, MouseMoveOff
}


; -------------- Global Hotkeys -----------------

RControl & RAlt::
keywait RControl
keywait RAlt
resizeWindow()
return

; w: 1349	h: 1057
Capslock & up:: WinMove,A,,200,0,1400,1057


; Down swipe
^!+F1::
Sleep 30
Send !{F4}
return

; Up swipe
^!+F2::
Sleep 30
Send +!z
return



;===================== Notepadpp Notepad++ ======================
#IfWinActive, ahk_exe notepad++.exe
; Down swipe2
^!+F1::
Sleep 30
Send ^w
return

; Up swipe
^!+F2::
Sleep 30
Send ^n
return

#IfWinActive
;===================== Chrome ======================
#IfWinActive, ahk_class Chrome_WidgetWin_1

; Down swipe
^!+F1::
Sleep 30
Send ^w
return

; Up swipe
^!+F2::
Sleep 30
Send ^t
return

#IfWinActive

;===================== Firefox ======================
#IfWinActive, ahk_exe firefox.exe

; Down swipe
^!+F1::
Sleep 30
Send ^w
return

; Up swipe
^!+F2::
Sleep 30
Send ^t
return

#IfWinActive
