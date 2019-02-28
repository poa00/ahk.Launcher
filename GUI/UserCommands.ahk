; Created by Asger Juul Brunshøj

; Note: Save with encoding UTF-8 with BOM if possible.
; I had issues with special characters like in ¯\_(ツ)_/¯ that wouldn't work otherwise.
; Notepad will save UTF-8 files with BOM automatically (even though it does not say so).
; Some editors however save without BOM, and then special characters look messed up in the AHK GUI.

; Write your own AHK commands in this file to be recognized by the GUI. Take inspiration from the samples provided here.

st := "C:\all\Sublime Text 3\sublime_text.exe"

; this is just a dummy condition, so that everything else starts with "else if Command ="
if 1 = 2
{ }
;-------------------------------------------------------------------------------
;;; SEARCH GOOGLE ;;;
;-------------------------------------------------------------------------------
else if Command = g%A_Space% ; Search Google
{
    gui_search_title = LMGTFY
    gui_search("https://www.google.com/search?num=50&safe=off&site=&source=hp&q=REPLACEME&btnG=Search&oq=&gs_l=")
}
else if Command = ahk%A_Space% ; Search Google for AutoHotkey related stuff
{
    gui_search_title = Autohotkey Google Search
    gui_search("https://www.google.com/search?num=50&safe=off&site=&source=hp&q=autohotkey%20REPLACEME&btnG=Search&oq=&gs_l=")
}
else if Command = xxx%A_Space% ; Search Google as Incognito
;   A note on how this works:
;   The function name "gui_search()" is poorly chosen.
;   What you actually specify as the parameter value is a command to run. It does not have to be a URL.
;   Before the command is run, the word REPLACEME is replaced by your input.
;   It does not have to be a search url, that was just the application I had in mind when I originally wrote it.
;   So what this does is that it runs chrome with the arguments "-incognito" and the google search URL where REPLACEME in the URL has been replaced by your input.
{
    gui_search_title = Google Search as Incognito
    gui_search("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe -incognito https://www.google.com/search?safe=off&q=REPLACEME")
}

else if Command = y%A_Space% ; Search Youtube
{
    gui_search_title = Search Youtube
    gui_search("https://www.youtube.com/results?search_query=REPLACEME")
}
else if Command = t%A_Space% ; Search torrent networks
{
    gui_search_title = Sharing is caring
    gui_search("https://kickass.to/usearch/REPLACEME")
}
else if Command = urba%A_Space% ; Search urbandictionary
{
    gui_search_title := "The dictionary which knows everything"
    gui_search("https://www.urbandictionary.com/define.php?term=REPLACEME")
}

;-------------------------------------------------------------------------------
;;; LAUNCH WEBSITES AND PROGRAMS ;;;
;-------------------------------------------------------------------------------
else if Command = cal ; Google Calendar
{
    gui_destroy()
    run https://www.google.com/calendar
}
else if Command = maps ; Google Maps
{
    gui_destroy()
    run "https://www.google.com/maps/"
}
else if Command = mail ; Open gmail
{
    gui_destroy()
    run "https://gmail.com"
    run "https://mail.tbp.land"
}
else if Command = fbmes ; Opens Facebook unread messages
{
    gui_destroy()
    run https://messenger.com
}
Else If Command = dest ; Google Maps destination
{
    gui_search_title := "Directions on Google Maps"
    gui_search("https://www.google.com/maps/dir/REPLACEME")
}

else if Command = url ; Open an URL from the clipboard (naive - will try to run whatever is in the clipboard)
{
    gui_destroy()
    run % Trim(ClipBoard)
}
else if Command = morning ; Morning routine
{
    gui_destroy()
    run "https://mail.tbp.land"
    run "https://forum.duplicacy.com"
    run "https://meta.discourse.org/"
    run "https://github.com/"
}
else if Command = skype
{
    gui_destroy()
    run "https://preview.web.skype.com/"
}
else if Command = start ; Open user Startup folder
{
    gui_destroy()
    run "shell:startup"
}

;-------------------------------------------------------------------------------
;;; INTERACT WITH THIS AHK SCRIPT ;;;
;-------------------------------------------------------------------------------
else if Command = rel ; Reload this script
{
    gui_destroy() ; removes the GUI even when the reload fails
    Reload
}
else if Command = dir ; Open the directory for this script
{
    gui_destroy()
    Run, %A_ScriptDir%
}
else if Command = host ; Edit host script
{
    gui_destroy()
    run, %st% "%A_ScriptFullPath%", , Max
}
else if Command = user ; Edit GUI user commands
{
    gui_destroy()
    run, %st% "%A_ScriptDir%\GUI\UserCommands.ahk", , Max
}


;-------------------------------------------------------------------------------
;;; TYPE RAW TEXT ;;;
;-------------------------------------------------------------------------------
else if Command = @ ; Email address
{
    gui_destroy()
    Send, my_email_address@gmail.com
}
else if Command = name ; My name
{
    gui_destroy()
    Send, My Full Name
}
else if Command = phone ; My phone number
{
    gui_destroy()
    SendRaw, +45-12345678
}
else if Command = logo ; ¯\_(ツ)_/¯
{
    gui_destroy()
    SendRaw ¯\_(ツ)_/¯
}
else if Command = loser ; you're a loser now
{
    gui_destroy()
    a =
    (LTrim
        just wanna point out that according to tidbit you are officially a loser now:
        https://discordapp.com/channels/115993023636176902/115993023636176902/537059851021451274
        congratulations @OP!
    )
    SendRaw % a
}
else if Command = clip ; Paste clipboard content without formatting
{
    gui_destroy()
    SendRaw, %ClipBoard%
}


;-------------------------------------------------------------------------------
;;; OPEN FOLDERS ;;;
;-------------------------------------------------------------------------------
else if Command = down ; Downloads
{
    gui_destroy()
    run C:\Users\%A_Username%\Downloads
}
else if Command = drop ; Dropbox folder (works when it is in the default directory)
{
    gui_destroy()
    run, C:\Users\%A_Username%\Dropbox\
}
else if Command = rec ; Recycle Bin
{
    gui_destroy()
    Run ::{645FF040-5081-101B-9F08-00AA002F954E}
}


;-------------------------------------------------------------------------------
;;; MISCELLANEOUS ;;;
;-------------------------------------------------------------------------------
else if Command = ping ; Ping Google
{
    gui_destroy()
    Run, cmd /K "ping -t www.google.com"
}
else if Command = date ; What is the date?
{
    gui_destroy()
    FormatTime, date,, LongDate
    MsgBox %date%
    date =
}
else if Command = week ; Which week is it?
{
    gui_destroy()
    FormatTime, weeknumber,, YWeek
    StringTrimLeft, weeknumbertrimmed, weeknumber, 4
    if (weeknumbertrimmed = 53)
        weeknumbertrimmed := 1
    MsgBox It is currently week %weeknumbertrimmed%
    weeknumber =
    weeknumbertrimmed =
}
else if Command = ? ; Tooltip with list of commands
{
    GuiControl,, Command, ; Clear the input box
    Gosub, gui_commandlibrary
}
