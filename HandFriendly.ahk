; ==== Hand Friendly ====
; This is an AutoHotKey script that remaps Capslock + IJKL to the 4 arrow keys (plus more remapping)
; This is a modification of another Hand Friendly script taken from the internet: https://www.autohotkey.com/board/topic/113783-hand-friendly-text-navigation-help/


; Autohotkey uses this characters to represent keyboard modifier keys:
; ^ = control
; ! = alt
; + = shift
; # = windows key

#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

SetTitleMatchMode 2
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetCapsLockState, AlwaysOff ; Disables the normal behavior of the capslock key

CapsLock & i::
       if getkeystate("alt") = 0
               Send,{Up} ; Capslock + i = Send Up arrow
       else
               Send,+{Up} ; Capslock + Alt + i = Send Shift+Up arrow
return

CapsLock & l::
       if getkeystate("alt") = 0
               Send,{Right}
       else
               Send,+{Right}
return

CapsLock & j::
       if getkeystate("alt") = 0
               Send,{Left}
       else
               Send,+{Left}
return

CapsLock & k::
       if getkeystate("alt") = 0
               Send,{Down}
       else
               Send,+{Down}
return

CapsLock & ,::
       if getkeystate("alt") = 0
               Send,^{Down}
       else
               Send,+^{Down}
return

CapsLock & 8::
       if getkeystate("alt") = 0
               Send,^{Up}
       else
               Send,+^{Up}
return

CapsLock & u::
       if getkeystate("alt") = 0
               Send,{Home}
       else
               Send,+{Home}
return

CapsLock & o::
       if getkeystate("alt") = 0
               Send,{End}
       else
               Send,+{End}
return

CapsLock & H::
       if getkeystate("alt") = 0
               Send,^{Left}
       else
               Send,+^{Left}
return

; --- Use Capslock instead of Control key for common keyboard shortcuts ---
CapsLock & z::Send ^z
CapsLock & x::Send ^x
CapsLock & c::Send ^c
CapsLock & v::Send ^v
CapsLock & s::Send ^s
CapsLock & f::Send ^f


; --- Additional remapping ---
CapsLock & BS::Send,^{BS}
CapsLock & \::Send,{Del}
!CapsLock::Send,{Enter} ; alt+capslock = enter
^CapsLock::Send,{Enter} ; ctrl+capslock = enter
CapsLock & '::Send,{"}


; --------- Reload script (fast way to reload and test change changes to this file) ----------
^!NumpadSub:: 
Reload  
SoundBeep, 800, 100
return

; -------- Insert Date ------------
CapsLock & t::    ;Type the Date: YYYY-MM-DD_
FormatTime, xx,, yyyy-MM-dd ; This is one type of the date format
SendInput, %xx%  
return

CapsLock & r::    ;Type the Date: MM-DD-YYYY
FormatTime, xx,, MM-dd-yyyy ; This is one type of the date format
SendInput, %xx%  
return



