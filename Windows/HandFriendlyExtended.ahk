   ; 0; ^ = control
; ! = alt
; + = shift
; # = windows key
; `n = newline

#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#HotkeyInterval 2000
#MaxHotkeysPerInterval 200

SetTitleMatchMode 2
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetCapsLockState, AlwaysOff
DetectHiddenWindows, Off

tiltEnabled = 1 ; default setting


GroupAdd, myReddit, reddit
GroupAdd, myReddit, subreddits
GroupAdd, myReddit, newest submissions
GroupAdd, myReddit, GenshinImpact

; ----- end of auto execute section --------


; ------------------------ Program Hotkey / Shortcuts --------------------
#1::
XButton1 & 1::
Capslock & n::
WinActivate Notepad++
return

#2::
XButton1 & 2::
XButton1 & c::
Capslock & m::
WinActivate Chrome
return

#3::
XButton1 & 3::
XButton1 & g::
WinActivate ahk_exe idea64.exe
return

#4::
XButton1 & 4::
WinActivate ahk_exe brave.exe
return

#5::
XButton1 & 5::
WinActivate ahk_exe foobar2000.exe
return

#6::
XButton1 & 6::
WinActivate ahk_exe OUTLOOK.EXE
return

#t::
XButton1 & t::
WinActivate Timer
return

#e::
XButton1 & e::WinActivate ahk_class CabinetWClass

XButton1 & f::
WinActivate ahk_exe firefox.exe
return

; ========================== Extended Key Remapping  ==========================


CapsLock & 1:: ; one method to deal with windows randomly setting windows "always on top"
WinGet windows, List
Loop %windows%
{
	id := windows%A_Index%
	WinGetTitle wintitle, ahk_id %id%
	WinSet, AlwaysOnTop, Off, %wintitle%
}
SplashTextOn, 400, 100, , Done
Sleep 400
SplashTextOff
return

!`::Send {Del} ; alt ` -> Delete
$`::Send {Backspace} ; ` -> backspace
#Escape::Send {Backspace}

#`::Send,{Del} ; win ` -> Delete
!+`::Send,{~} ; shift ` -> ~
^`::Send,``  ; control ` -> `
^+`::Send +{Del} ; ctrl shift ` - > shift delete
^+Backspace::Send +{Del} ; ctrl shift ` - > shift delete

CapsLock & Backspace::Send ^{Backspace}
;CapsLock & \::Send {Del}
CapsLock & \::Send {F2}
!CapsLock::Send {Enter} ; alt+capslock = enter
^CapsLock::Send {Enter} ; ctrl+capslock = enter
CapsLock & ~Alt Up:: return ; do nothing if i press 1) caps, then 2) alt

CapsLock & z::Send ^z
CapsLock & x::Send ^x
CapsLock & c::Send ^c
CapsLock & v::Send ^v
CapsLock & s::Send ^s
CapsLock & f::Send ^f
CapsLock & '::Send {"}
CapsLock & 8::Send *
CapsLock & a::Send,^{a}
CapsLock & 9::Send,{(}
CapsLock & 0::Send,{)}
; CapsLock & Space::Send,{Del}
; CapsLock & [::Send,{{}
; CapsLock & ]::Send,{}}
CapsLock & -::Send,{_}
CapsLock & =::Send,{+}
CapsLock & Enter::Send {_}
;CapsLock & 1::Send {HOME}
;CapsLock & 2::Send {END}
CapsLock & WheelUp:: Send {UP}
CapsLock & WheelDown:: Send {DOWN}
CapsLock & g::Send ^g
Capslock & Insert::Send %Clipboard%
Capslock & ,::Send <
Capslock & .::Send >
$Insert::return ; disable the insert key when it is pressed by itself
^!WheelUp::Send ^{Home}
^!WheelDown::Send ^{End}
Capslock & RShift::Send -
RShift & LShift::Send (
LShift & RShift::Send )

CapsLock & q::
   if getkeystate("alt") = 0
	   Send {Backspace}
   else
	   Send ^{Home}
return

CapsLock & e::
   if getkeystate("alt") = 0
	   Send {Enter}
   else
	   Send ^{End}
return

CapsLock & Space::
       if getkeystate("shift") = 1 {
		   Send +{Del} 
		   return
	   }
	   if getkeystate("alt") = 0 {
               Send {Del}
			   return
	   }
return

CapsLock & Escape::Send {Backspace} ; WinMinimize, A ; "A" will minimize the active window
Capslock & p::SetCapsLockState, On
*Capslock::SetCapsLockState, AlwaysOff

LControl & LWin::Send +!{z} ; Open Tom Launcher

; -----------------Move window to on screen -----------------
Xbutton1 & MButton:: WinMove,A,,0,0

; -------------- copy paste --------------------

XButton1 & LButton::
SplashTextOn, 400, 100, , Copied
Sleep 200
SplashTextOff
Send ^c
return

XButton1 & RButton::Send ^v

XButton1::Send {XButton1}

; -------------- Continuously horizontal scroll ---------------
CapsLock & LButton::
Send {Left} ; caps + left click = move cursor one unit left
Sleep 150
state := GetKeyState("LButton", "P")
while (state)
{
	Send {Left}
	Sleep, 50
	state := GetKeyState("LButton", "P")
}
SetCapsLockState, AlwaysOff ; sometimes capslock is turned on, turn it back off
return

CapsLock & RButton::
Send {Right} ; caps + right click = move cursor one unit right
Sleep 150
state := GetKeyState("RButton", "P")
while (state)
{
	Send {Right}
	Sleep, 50
	state := GetKeyState("RButton", "P")
}
SetCapsLockState, AlwaysOff ; sometimes capslock is turned on, turn it back off
return

; --------- GUI to show the Date and Time ----
Capslock & 3::
#c::
FormatTime, date,, MMM dd, yyyy ; This is one type of the date format
FormatTime, day, ,  dddd
FormatTime, time,, h:mm tt
myTimeString = %date% `n`n%day% `n`n%time%

CustomMsgBox("Current Time",myTimeString,"","cBlack Bold s30")
;CustomMsgBox("Title","This MsgBox has a red font!","","cRed")
;CustomMsgBox("Title","This MsgBox has a blue italic Tahoma font!","Tahoma","cBlue Italic s30")
;CustomMsgBox("Title","This MsgBox has a white font and black background!!","","cWhite","Black")
;CustomMsgBox("Title","This MsgBox has a black Lucida Console font and horrible yellow background!","Lucida ;Console","cBlack","Yellow")
return

CustomMsgBox(Title,Message,Font="",FontOptions="",WindowColor="")
{
	Gui,66:Destroy ; Delete any previously existing gui with ID 66
	Gui,66:Color,%WindowColor% 
	
	Gui,66:Font,%FontOptions%,%Font% ; Set to specificed font options
	Gui,66:Add,Text,,%Message% ; Add text using new font
	Gui,66:Font ; Set the font back to default
	
	GuiControlGet,Text,66:Pos,Static1
	
	Gui,66:Add,Button,% "Default y+10 w75 g66OK xp+" (TextW / 2) - 38 ,OK
	
	;Gui,66:-MinimizeBox
	;Gui,66:-MaximizeBox
	Gui,66:-SysMenu ; Remove the system menu (and icon), Minimize, Maximize, and Close buttons in top right
	
	;SoundPlay,*-1
	Gui,66:Show,,%Title%
	
	Gui,66:+LastFound
	WinWaitClose,,,3 ; Close window after 3 seconds
	Gui,66:Destroy
	return
	
	66OK:
	Gui,66:Destroy
	return
}

; ---------- Hotstrings (text expansion / auto correct) ------
::hte::the
::teh::the
::ture::true
::flase::false
::kidn::kind
::onyl::only
::hwo::how
::ot::to
::nto::not
::wiht::with
::env::environment
::envs::environments
::chagne::change
::chagnes::changes
::isntead::instead
::goign::going
::ntoes::notes
::jsut::just
::ahve::have

; --------- text expansion: Insert DATE: YYYY-MM-DD ------------
/*
:R*?:dddd::
FormatTime, CurrentDateTime,, yyyy-MM-dd ; HH:mm
SendInput %CurrentDateTime%
return
*/

; ---------- Edit this script with Notepad++ ------
^!NumpadDiv::
^!Insert::
^!+'::
Run "C:\Program Files (x86)\Notepad++\notepad++.exe" "C:\Path\To\HandFriendlyExtended.ahk"
return

; ---------- Pause / suspend script ------
^!NumpadMult::
^!Home::
^!+\::
Suspend
if (A_IsSuspended)
	SplashTextOn, 400, 100, , Suspending
else
	SplashTextOn, 400, 100, , Resuming
Sleep 600
SplashTextOff
return

; ---------- Snipping tool ------
;!F1::Run, "C:\Windows\System32\SnippingTool.exe"
!1::
!F1::Run, "C:\Windows\Sysnative\SnippingTool.exe" ; for 64-bit systems

; ------- Disable certain keys --------
#Enter::return ; disable narrator shortcut: windows key + enter

; --------- Reload script ----------
^!NumpadSub::
^!PgUp::
^!+Enter::
;SoundBeep, 2500, 50
SplashTextOn, 400, 100, , Reloading
Sleep 600
SplashTextOff
Reload  
return

; -------- Insert Date ------------
CapsLock & t::    ;Type the Date: YYYY-MM-DD_
FormatTime, xx,, yyyy-MM-dd ; This is one type of the date format
SendInput, %xx%  
return

Capslock & r::
;FormatTime, xx,, HH'h'mm'm'ss's' ; 24Hr-Minutes-Seconds
FormatTime, xx,, yyyy-MM-dd_HH'h'mm'm'ss's' ; This is one type of the date format
SendInput, %xx%  
return

CapsLock & y::    ;Type the Date: MM-DD-YYYY
FormatTime, xx,, MM-dd-yyyy ; This is one type of the date format
SendInput, %xx%  
return

; ---------- Monitor Controls -------------
; Turn off monitor
!F9::
ScrollLock::
	SoundBeep, 1500, 80
	KeyWait Alt
	Send, {Sleep 500}
	SendMessage,0x112,0xF170,2,,Program Manager 
	return

; Start screensaver
/*
^F8:: ; screensaver
	KeyWait Alt
	RegRead, screensaver, HKCU,Control Panel\Desktop ,ScreenSaveActive
	if screensaver = 0
	{
		MsgBox, 0, ScreenSaver, ScreenSaver Not Active,3
	}
	else
	{
	RegRead, screensaver, HKCU,Control Panel\Desktop ,SCRNSAVE.EXE
	run,%screensaver% /s
	}
return
	*/

; --------------- Autohotkey's Window Spy ----------------
^!End::Run "C:\Program Files\AutoHotkey\AU3_Spy.exe"

	
; ------------ Center Mouse ------------
/*
Capslock & `::
LWin & F1::
	SendMode, Event
	CoordMode, Mouse, Screen
	MouseMove, (A_ScreenWidth // 2), (A_ScreenHeight // 2), 5
	CoordMode, Mouse, Relative
	SendMode, Input	
return
*/

; -------- Adjust Volume ---------
/*
If you want a "z up" hotkey, you would do it this way (which is documented):
z & v::MsgBox You pressed v while holding down z.
z::Send z 
*/
MButton & WheelUp::VolumeUp()
MButton & WheelDown::VolumeDown()
; MButton::Send {MButton}


LWin & WheelUp::VolumeUp()
LWin & WheelDown::VolumeDown()

^+F12::Send {Volume_Mute} ;toggle mute
^!F12::Send {Volume_Mute} ;toggle mute

^F12::VolumeUp()
^F11::VolumeDown()
^F10::VolumeSetTo20()

 ; Alternate volume controls for left hand
;#1::VolumeUp()
;#2::VolumeDown()
;#3::VolumeSetTo20()

 ; Alternate volume controls using media stop/prev/next keys
;Media_Next::VolumeUp()
;Media_Prev::VolumeDown()
;Media_Stop::VolumeSetTo20()

; for wireless ear buds, single tap
;Media_Play_Pause::SoundPlay *-1
Media_Play_Pause::SoundBeep, 300, 100
;Media_Play_Pause::Send {F1}

; ---- Volume functions ----
VolumeUp()
{
	Send {Volume_Up}
	;Soundset +1
	;SoundPlay *-1
	return
}

VolumeDown()
{
	Send {Volume_Down 2}
	;Soundset -2
	;SoundPlay *-1
	return
}

VolumeSetTo20()
{
	SoundSet 20
	SoundBeep, 300, 100
	;SoundPlay *-1
	return
}
;------------- Release stuck keys pause break-----------

*Pause::
SplashTextOn, 400, 100, , Done
Send,{Win up}
Send,{Ctrl up}
Send,{Alt up}
Send,{Shift up}
Send {CapsLock up}
SoundPlay *-1
DisableAlwaysOnTop()
Sleep 300
SplashTextOff
return

^CtrlBreak:: ; equivalent of control + pause break
Send {Win up}
Send {Ctrl up}
Send {Alt up}
Send {Shift up}
Send {CapsLock up}
SoundPlay *-1
return

; ---------- Disable "Always on top" Helper Function --------
DisableAlwaysOnTop()
{
	; Make sure DetectHiddenWindows is off, otherwise get too many, app freezes.
	WinGet windows, List, , , Program Manager
	Loop %windows%
	{
		id := windows%A_Index%
		WinGetTitle wintitle, ahk_id %id%
		if(wintitle)  ; use this to skip blank window titles
		{
			;MsgBox, %wintitle%
			WinSet, AlwaysOnTop, Off, %wintitle%
		}
	}
}

;------------- Resize Window Helper Function-----------
ResizeWin(Width = 0,Height = 0)
{
  WinGetPos,X,Y,W,H,A
  If %Width% = 0
    Width := W

  If %Height% = 0
    Height := H

  WinMove,A,,%X%,%Y%,%Width%,%Height%
}

; ----------------- Window move and resize ------------
Capslock & `::
	WinMove, A, , 250, 0
	ResizeWin(2000, 1417)
return

; Left and Right half of 1440p monitor:
;Capslock & Left:: WinMove, A, , -7, 0, 1294, 1417
;Capslock & Right:: WinMove, A, , 1273, 0, 1294, 1417
Capslock & Up:: WinMove, A, , , 0, , 1417

Capslock & Right:: ;Extend current window to right side of screen
WinGetPos, X, Y, Width, Height, A
WinMove, A,, X, Y, A_ScreenWidth-X +7, Height
return

Capslock & Left:: ;Extend current window to left side of screen
WinGetPos, X, Y, Width, Height, A
WinMove, A, ,-7, Y, X+Width+7, Height
return



; ========================== Hand Friendly ==========================
CapsLock & i::
	BlockInput On
   if getkeystate("alt") = 0
	   Send {Up}
   else
	   Send +{Up}
   BlockInput Off
return

CapsLock & l::
	BlockInput On
   if getkeystate("alt") = 0
	   Send {Right}
   else
	   Send +{Right}
	BlockInput Off
return

CapsLock & j::
	BlockInput On
   if getkeystate("alt") = 0
	   Send {Left}
   else
	   Send +{Left}
   BlockInput Off
return

CapsLock & k::
	BlockInput On
   if getkeystate("alt") = 0
	   Send {Down}
   else
		Send +{Down}
	BlockInput Off
return

CapsLock & u::
	BlockInput On
   if getkeystate("alt") = 0
	   Send {Home}
   else
	   Send +{Home}
   BlockInput Off
return

CapsLock & o::
	BlockInput On
   if getkeystate("alt") = 0
	   Send {End}
   else
	   Send +{End}
   BlockInput Off
return

CapsLock & h::
BlockInput On
   if getkeystate("alt") = 0
	   Send ^{Left}
   else
	   Send +^{Left}
BlockInput Off
return

CapsLock & `;::
	BlockInput On
	if getkeystate("alt") = 0
        	Send ^{Right}
	else
        	Send +^{Right}
	BlockInput Off
return

CapsLock & [::
	BlockInput On
	if getkeystate("alt") = 0
		 Send {{}
	else
		 Send {PgUp}
	 BlockInput Off
return                         

CapsLock & ]::
	BlockInput On
	if getkeystate("alt") = 0
		 Send {}}
	else
		 Send {PgDn}
	BlockInput Off
return

; ============= my Numpad ======================
^!+u::Send 7
^!+i::Send 8
^!+o::Send 9
^!+j::Send 4
^!+k::Send 5
^!+l::Send 6
^!+m::Send 1
^!+,::Send 2
^!+.::Send 3
^!+Space::Send 0


;===================== InoReader ======================

#IfWinActive, Inoreader

; ----- Standard Next/Prev article -----
Capslock & s::
XButton2::Send k

Capslock & d::
XButton1::Send j


NumpadAdd::Send j
NumpadSub::Send k

; ----- Mark all as read -----
XButton2 & RButton::Send +a
XButton2 & LButton::Send {Enter}

F23::
F24::Send +a ; mark all as read


Capslock & g:: ; mark next 10 articles as unread
Loop, 10
{
Send m
Sleep 100
Send n
Sleep 100
}
return

#IfWinActive

;===================== Youtube ======================
#IfWinActive, - YouTube

;F24::Send {F5}

XButton1 & WheelUp::Send {Right}
XButton1 & WheelDown::Send {Left}

XButton2::Send +.
XButton1::Send +,


Up::Send +.
Down::Send +,

XButton2 & WheelUp::Send {Right}
XButton2 & WheelDown::Send {Left}

#IfWinActive


;=========================================
resizeWindow()
{
BlockInput, MouseMove
SoundBeep, 800, 100
Send !{Space}
Sleep 100
;Send s
Send {Down 3}
Sleep 10
Send {Enter}
Sleep 10
Send {Down}
Sleep 10
Send {Right}
Sleep 10
BlockInput, MouseMoveOff
}

resizeWindowFirefox()
{
BlockInput, On
Send !{Space}
Sleep 80
Send s
;Send {Down 3}
;Send {Enter}
Send {Down}
Send {Right}
Sleep 20
BlockInput, Off
}


resizeWindow2()
{
WinGetPos, X, Y, Width, Height, A ; "A gets the active window"
CoordMode, Mouse, Screen
MouseMove, X+Width-5, Y+Height-5, 1
CoordMode, Mouse, Relative
Send {LButton down}
}

;================== Firefox ========================
#IfWinActive, ahk_exe firefox.exe
F13::resizeWindowFirefox()

Capslock & w::Send ^{t}
!w::Send ^{w}

F23::Send x ; toggle for reddit
F24::Send x

XButton2::Send ^+{TAB}
XButton1::Send ^{TAB}

; WheelRight::Send ^{TAB}
; WheelLeft::Send ^+{TAB}

/*
 ; enable disable the wheel left or wheel right
CapsLock & MButton::
if (tiltEnabled == 0)
{
	tiltEnabled = 1
    MsgBox Tilt is ON
}
else
{
	
	tiltEnabled = 0
    MsgBox Tilt is OFF
}
return
*/

WheelLeft::
; if (tiltEnabled == 1) {
Getkeystate, state, MButton, P
if state = U
 Send ^+{TAB}
; }
return

WheelRight::
; if (tiltEnabled == 1) {
Getkeystate, state, MButton, P
if state = U
 Send ^{TAB}
; }
return

; F12::SoundBeep, 800, 100 ; Disable developer console, play a sound for feedback

^s::SoundBeep, 100, 50 ; Disable Save shortcut on keyboard, play a sound for feedback
CapsLock & s::SoundBeep, 100, 50

#IfWinActive


;===================== Gmail Account ======================
 #IfWinActive,  <your gmail account>@gmail.com

Capslock & r::
F1::
BlockInput, On
Send {Esc}
Sleep 100
Send {Esc}
Sleep 200
Send c
Sleep 500
Send me
Sleep 300
Send {Tab}
Sleep 100
Send {Tab}
Sleep 100
BlockInput, Off
SoundBeep, 1000, 100
return

 XButton2::
Send {LButton}
Sleep 200
Send d
return
 
XButton1::Send i


 XButton1 & WheelUp:: Send k
 XButton1 & WheelDown:: Send j
 
 Capslock & d::Send j
 
 #IfWinActive
 
 ; =============== Reddit ===================
; see GroupAdd at the beginning of this script

#IfWinActive ahk_group myReddit

XButton2::Send k
XButton1::Send j
XButton2 & LButton::Send x

#IfWinActive

;===================== Chrome ====== Brave ================
#IfWinActive, ahk_class Chrome_WidgetWin_1

XButton2 & LButton::Send x ; for Reddit

!q::Send ^+{TAB}
!e::Send ^{TAB}

F13::resizeWindow()

;F23::Send x ; toggle for reddit
;F24::Send x

Capslock & w::Send ^{t}
!w::Send ^{w}

XButton1::Send j ;Send ^+{TAB}
XButton2::Send k ;Send ^{TAB}


XButton2 & WheelUp::Send ^{=}
XButton2 & WheelDown::Send ^{-}

;XButton1 & WheelUp::Send ^+{TAB}
;XButton1 & WheelDown::Send ^{TAB}

XButton2 & RButton::
Keywait RButton
Keywait XButton2
Send ^!a
return

; WheelRight::Send ^{TAB}
; WheelLeft::Send ^+{TAB}

WheelLeft::
if (tiltEnabled == 1) {
Getkeystate, state, MButton, P
if state = U
 Send {LALT}
 Send ^+{TAB}
}
return

WheelRight::
if (tiltEnabled == 1) {
Getkeystate, state, MButton, P
if state = U
 Send {LALT}
 Send ^{TAB}
}
return

; F12::SoundBeep, 800, 100 ; Disable developer console, play a sound for feedback

^s::SoundBeep, 200, 50 ; Disable Save shortcut on keyboard, play a sound for feedback
CapsLock & s::SoundBeep, 200, 50

;; Close downloads tab
^q::
SplashTextOn, 400, 100, , Clear Downloads
Send ^j
Sleep 100
Send ^w
Sleep 500
SplashTextOff
return

#IfWinActive


 ;===================== IntelliJ ======================
#IfWinActive, ahk_exe idea64.exe
Capslock & w::Send +{Esc}

#IfWinActive

;======================= Photo Viewer ==========================
#IfWinActive ahk_class Photo_Lightweight_Viewer
Down::Send, !{F4}
#IfWinActive

#IfWinActive ahk_class Photo_Slideshow_FrameWindow
Down::Send, !{F4}
#IfWinActive

;======================= Visual Studio ==========================
#IfWinActive Microsoft Visual Studio

MButton::
Send,{LButton}
Send,{F12}
return

#IfWinActive

;======================= Microsoft Excel ==========================
#IfWinActive ahk_class XLMAIN

WheelLeft::
CapsLock & q::Send ^{PgUp}

WheelRight::
CapsLock & e::Send ^{PgDn}

CapsLock & d::Send ^d


#IfWinActive

#IfWinActive metallicadpa_ppl_mine

\::Send *
NumPadAdd::Send *

Enter::
NumPadEnter::
Send {Tab}
Send ^s
return


#IfWinActive

; ========= WinMerge ===========
#IfWinActive ahk_exe WinMergeU.exe
 
XButton2::Send !{Up}
XButton1::Send !{Down}
 
 
#IfWinActive

; ========= FooBar music player ===========
#IfWinActive ahk_exe foobar2000.exe

Capslock & w::
XButton2::Send ^p ; Next track

XButton1::Send {Space} ; Play/Pause
 
MButton::Send !{q}
 
#IfWinActive

; ========= Alt tab ===========
/*
#IfWinActive ahk_exe AltTabTer64.exe

XButton2::Send {Enter} 
XButton1::Send {Enter}
 

#IfWinActive
*/
;======================= Notepad++ ==========================
#IfWinActive ahk_exe notepad++.exe

Capslock & w::Send ^n
!w::Send ^w

WheelLeft::Send ^{PGUP}
WheelRight::Send ^{PGDN}

;XButton1::Send ^{PGDN}
;XButton2::Send ^{PGUP}

#IfWinActive

; ===================== Explorer ======================
#IfWinActive ahk_exe explorer.exe
WheelLeft::Send !{Left}
WheelRight::Send !{Right}
#IfWinActive

; ============== Explorer make this folder have quick rename with unique name ==================
#IfWinActive my_folder_name ; change the folder name here

Capslock & w::
MButton::
Send {F2}
Send {Up 10}
Send {Home}
FormatTime, xx,, yyyy-MM-dd_HH'h'mm'm'ss's' ; This is one type of the date format
SendInput, %xx% 
Send _
Send {Enter}
Sleep 100
Send !{Tab}
return
#IfWinActive

; ------- IrfanView ------------
#IfWinActive ahk_class IrfanView

; Save file
Capslock & w:: 
Send ^s
Sleep 300
Send {Enter}
Sleep 300
Send {y}
return


0::Send ^{h}
Capslock & r::Send ^{r}

;Numpad0::Send ^{m}

Xbutton2::
LControl::
RControl::
Numpad0::
Send {Alt down}v{Alt up}
;Sleep 50
Send r
return

XButton1 & WheelUp:: Send ^{WheelUp}
Xbutton1 & WheelDown:: Send ^{WheelDown}

#IfWinActive

; ========= sumatra pdf ===========
#IfWinActive ahk_exe  sumatrapdf.exe


XButton1 & WheelUp:: Send ^{WheelUp}
Xbutton1 & WheelDown:: Send ^{WheelDown}

#IfWinActive

; ================ Windows Action  Center (notification center) =============
#IfWinActive Action center

Esc::
MButton::
`::
Send +{Tab}
Sleep 50
Send +{Tab}
Sleep 300
Send {Space}
Sleep 300
Send #a
return

#IfWinActive

; ================ VLC =============
#IfWinActive ahk_exe vlc.exe

XButton1::Send {Space}

;MButton::Send +{Right}
XButton2::Send +{Right}
;XButton2::Send {=}


XButton2 & WheelUp::Send ]
XButton2 & WheelDown::Send [
;XButton1::Send XButton1

XButton1 & WheelUp::Send {Right}
XButton1 & WheelDown::Send {Left}

Up::
WheelUp::Send {NumpadAdd}

Down::
WheelDown::Send {NumpadSub}

WheelLeft::Send {Left}
WheelRight::Send {Right}

Capslock & Up::
Capslock & WheelUp:: Send ]

Capslock & Down::
Capslock & WheelDown:: Send [

F1::
Capslock & w::
Send !3
Sleep 300
WinGetPos,,, Width, Height, %WinTitle%
WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
return

XButton2 & LButton::
Send ^n
Sleep 100
Send ^v
Send {Enter}
return

#IfWinActive


; ========= Affinity Photo ===========
#IfWinActive ahk_exe Photo.exe

;Capslock::Send {Esc}
Capslock & q::Send [
Capslock & e::Send ]
Capslock & d::WinMinimize
Capslock & w::Send b

XButton2::Send s
XButton1::Send v
!w::Send ^w
#IfWinActive

; ========= Photoshop ===========
#IfWinActive ahk_exe Photoshop.exe

!CapsLock::Send {NumpadEnter} ; alt+capslock = enter

XButton2::Send m
XButton1::Send b

; Save as PNG
^+P::
Send ^+s
Sleep 300
Send {Tab}
Sleep 300
Send {Down} ; first down arrow opens the dropdown list
Send {Down 20}
Send {Up 4}

Send +{Tab}
return

#IfWinActive

; ============== Pycharm =============
#IfWinActive ahk_exe pycharm64.exe
Capslock & r::Send {F9}
Capslock & w::Send !+{F9}
Capslock & d::Send {F8}
