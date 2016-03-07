#SingleInstance force

RegRead, X, HKEY_CURRENT_USER, SOFTWARE\Mario Studio\Mario's Max3, X
if ErrorLevel
  X = 1680

RegRead, Y0, HKEY_CURRENT_USER, SOFTWARE\Mario Studio\Mario's Max3, Y0
if ErrorLevel
  Y0 = -560

RegRead, Y1, HKEY_CURRENT_USER, SOFTWARE\Mario Studio\Mario's Max3, Y1
if ErrorLevel
  Y1 = 80

RegRead, Y2, HKEY_CURRENT_USER, SOFTWARE\Mario Studio\Mario's Max3, Y2
if ErrorLevel
  Y2 = 720

RegRead, W, HKEY_CURRENT_USER, SOFTWARE\Mario Studio\Mario's Max3, W
if ErrorLevel
  W = 1080

RegRead, H, HKEY_CURRENT_USER, SOFTWARE\Mario Studio\Mario's Max3, H
if ErrorLevel
  H = 640

Gui, Add, Text, , To setup with the moinitor you want to split, move this window to the target monitor.
Gui, Add, Text, , Then press OK.
Gui, Add, Button, x+400 w60 Default, OK
Gui, +MaximizeBox

Gui, About: New, , About Mario's Max3
Gui, About:Add, Text, , This is a handy tool for you to vertically split a monitor into three.
Gui, About:Add, Text, , Use the hotkeys Win + Numpad8, Win + Numpad5 and Win + Numpad2 to place
Gui, About:Add, Text, , your active window to one of the three parts in your target monitor.
Gui, About:Add, Text, , Hotkeys Win + Numpad4 and Win + Numpad6 are used for maximization.
Gui, About:Add, Text, , Copyright Mario Studio, all rights reserved ; ©

Menu, Tray, Tip, Mario's Max3
Menu, Tray, NoStandard
Menu, Tray, Add, Locate Monitor, SetupHandler
If %A_IsCompiled%
  Menu, Tray, Icon, 1&, %A_ScriptFullPath%, -997, 64
Menu, Tray, Default, 1&
Menu, Tray, Add, About Max3, AboutHandler
If %A_IsCompiled%
  Menu, Tray, Icon, 2&, %A_ScriptFullPath%, -998, 64
Menu, Tray, Add
Menu, Tray, Add, Exit, ExitHandler
If %A_IsCompiled%
  Menu, Tray, Icon, 4&, %A_ScriptFullPath%, -999, 64
Return

ButtonOK:
  Gui, Maximize
  WinGetPos, X, Y, W, H
  X += 3
  Y += 3
  W -= 6
  H -= 6
  H /= 3

  Y0 = %Y%
  Y += H
  Y1 = %Y%
  Y += H
  Y2 = %Y%

  RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\Mario Studio\Mario's Max3, X, %X%
  RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\Mario Studio\Mario's Max3, Y0, %Y0%
  RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\Mario Studio\Mario's Max3, Y1, %Y1%
  RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\Mario Studio\Mario's Max3, Y2, %Y2%
  RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\Mario Studio\Mario's Max3, W, %W%
  RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\Mario Studio\Mario's Max3, H, %H%

  Gui, Hide
Return

SetupHandler:
  Gui, Show, Restore, Mario's Max3 - Monitor Locator
  Gui, Flash
Return

AboutHandler:
  Gui, About: Show
Return

ExitHandler:
  ExitApp
Return

#Numpad8::
  WinRestore, A
  WinMove, A, , X, Y0, W, H
Return

#Numpad5::
  WinRestore, A
  WinMove, A, , X, Y1, W, H
Return

#Numpad2::
  WinRestore, A
  WinMove, A, , X, Y2, W, H
Return

#Numpad4::
  WinRestore, A
  WinMove, A, , 0, 0
  WinMaximize, A
Return

#Numpad6::
  WinRestore, A
  WinMove, A, , X, Y0
  WinMaximize, A
Return