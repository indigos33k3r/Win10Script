##########
# Win10 Initial Setup Script Settings Menu
#
# Author: Madbomb122
# Website: https://github.com/madbomb122/Win10Script
# Version: 0.0, 02-14-2017
#
# Release Type: Work in Progress
##########

# At the moment the Script will ONLY display items
# The save/load works but nothing to load/save ATM

# This script it to make selection of settings easier

# This script it ment to
# 1. Make a file with your wanted settings
# 2. Edit Settings file (what you load)
# 3. Run script with setting inputed/loaded

# When done will be part of the main script with ability
# to bypass Menu for Automation

## READ ME!! Need to Set ALL variables with $Script:

## Remove the Bellow ITEM when done
$colors = @(
     "black",        #0
     "blue",         #1
     "cyan",         #2
     "darkblue",     #3
     "darkcyan",     #4
     "darkgray",     #5
     "darkgreen",    #6
     "darkmagenta",  #7
     "darkred",      #8
     "darkyellow",   #9
     "gray",         #10
     "green",        #11
     "magenta",      #12
     "red",          #13
     "white",        #14
     "yellow"        #15
)

If ($RanOnce -ne "Ran"){
$Script:CreateRestorePoint = 0
$Script:ShowColor = 1
$Script:RanOnce = "Ran"
}
## Remove the Above ITEM when done

##########
# Version Info -Start
##########

$CurrVer = "0.0 (02-11-17) "
$RelType = "Beta   "
#$RelType = "Testing"
#$RelType = "Stable "

##########
# Version Info -End
##########

##########
# Multi Use Functions -Start
##########

# Used to Help remove the Automatic variables
function cmpv {
    Compare-Object (Get-Variable) $AutomaticVariables -Property Name -PassThru | Where -Property Name -ne "AutomaticVariables"
}

##########
# Win10 Initial Setup Script Settings Menu
#
# Author: Madbomb122
# Website: https://github.com/madbomb122/Win10Script
# Version: 0.0, 02-14-2017
#
# Release Type: Work in Progress
##########

# At the moment the Script will ONLY display items
# The save/load works but nothing to load/save ATM

# This script it to make selection of settings easier

# This script it ment to
# 1. Make a file with your wanted settings
# 2. Edit Settings file (what you load)
# 3. Run script with setting inputed/loaded

# When done will be part of the main script with ability
# to bypass Menu for Automation

## READ ME!! Need to Set ALL variables with $Script:

## Remove the Bellow ITEM when done
$colors = @(
     "black",        #0
     "blue",         #1
     "cyan",         #2
     "darkblue",     #3
     "darkcyan",     #4
     "darkgray",     #5
     "darkgreen",    #6
     "darkmagenta",  #7
     "darkred",      #8
     "darkyellow",   #9
     "gray",         #10
     "green",        #11
     "magenta",      #12
     "red",          #13
     "white",        #14
     "yellow"        #15
)

If ($RanOnce -ne "Ran"){
$Script:CreateRestorePoint = 0
$Script:ShowColor = 1
$Script:RanOnce = "Ran"
}
## Remove the Above ITEM when done

##########
# Version Info -Start
##########

$CurrVer = "0.0 (02-11-17) "
$RelType = "Beta   "
#$RelType = "Testing"
#$RelType = "Stable "

##########
# Version Info -End
##########

##########
# Multi Use Functions -Start
##########

# Used to Help remove the Automatic variables
function cmpv {
    Compare-Object (Get-Variable) $AutomaticVariables -Property Name -PassThru | Where -Property Name -ne "AutomaticVariables"
}

# Function to Display in Color or NOT (for MENU ONLY)
Function DisplayOutMenu([String]$TxtToDisplay,[int]$TxtColor,[int]$BGColor,[int]$NewLine){
    If ($NewLine -eq 0){
        If($TxtColor -le 15 -and $ShowColor -eq 1){
             Write-Host -NoNewline $TxtToDisplay -ForegroundColor $colors[$TxtColor] -BackgroundColor $colors[$BGColor]
        } Else {
             Write-Host -NoNewline $TxtToDisplay
        }
	} Else {
	     If($TxtColor -le 15 -and $ShowColor -eq 1){
             Write-Host $TxtToDisplay -ForegroundColor $colors[$TxtColor] -BackgroundColor $colors[$BGColor]
        } Else {
             Write-Host $TxtToDisplay
        }
    }
}

function ChoicesMenu([String]$Vari, [Int]$Number) {
    $VariJ = -join($Vari,"Items")
    $VariV = Get-Variable $Vari -valueOnly #Variable
    $VariA = Get-Variable $VariJ -valueOnly #Array
    $ChoicesMenu = 'X'
    while($ChoicesMenu -ne "Out"){
        Clear-Host
	ChoicesDisplay $VariA $VariV
	If($Invalid -eq 1){
	    Write-host ""
	    Write-host "Invalid Selection" -ForegroundColor Red -BackgroundColor Black -NoNewline
	    $Invalid = 0
	}
        $ChoicesMenu = Read-Host "`nChoice"
	switch ($ChoicesMenu) {
	    C {$ReturnV = $VariV; $ChoicesMenu = "Out"}
            default {if($Number -ge $ChoicesMenu) {$ReturnV = $ChoicesMenu; $ChoicesMenu = "Out"} Else {$Invalid = 1}}
	}
    }
    Set-Variable -Name $Vari -Value $ReturnV -Scope Script;
}

function VariMenu([Array]$VariDisplay,[Array]$VariMenuItm) {
    $VariMenu = 'X'
    while($VariMenu -ne "Out"){
        Clear-Host
        MenuDisplay $VariDisplay
	If($Invalid -eq 1){
	    Write-host ""
	    Write-host "Invalid Selection" -ForegroundColor Red -BackgroundColor Black -NoNewline
	    $Invalid = 0
	}
        $VariMenu = Read-Host "`nSelection"
	$ConInt = $VariMenu -as [int]
        If($ConInt -is [int]){
            for ($i=0; $i -le $VariMenuItm.length; $i++) {
                   If($VariMenuItm[$i][0] -eq $ConInt){
                        $LoopVar = $i
                	$i = $VariMenuItm.length+1
            	   }
        	}
        	If($LoopVar -is [int]){
                     ChoicesMenu ($VariMenuItm[$LoopVar][1]) 1
                } Else{
                     $Invalid = 1        
        	}
	    } Else {
		switch ($VariMenu) {
                B {$VariMenu = "Out"}
                default {$Invalid = 1}
            }
	}
    }
}

##########
# Multi Use Functions -End
##########

##########
# Confirm Menu -Start
##########

$ConfirmMenuItems1 = @(
'                 Confirm Dialog                  ',

'              Are You sure? (Y/N)                ',
'0. Cancel/Back to Main Menu                      '
)

$ConfirmMenuItems2 = @(
'                 Confirm Dialog                  ',
'                                                 ',
'  File Exists do you want to overwrite? (Y/N)    ',
'0. Cancel/Back to Main Menu                      '
)

function ConfirmMenu([int]$Option) {
    $ConfirmMenu = 'X'
    while($ConfirmMenu -ne "Out"){
        Clear-Host
		If ($Option -eq 1){
			VariableDisplay $ConfirmMenuItems1
		} ElseIf ($Option -eq 2){
			VariableDisplay $ConfirmMenuItems2
		}
		$ConfirmMenu = Read-Host "`nSelection (Y/N)"
        switch (ConfirmMenu) {
			Y {Return $true}
            N {Return $false}
		    default {Return $false}
		}
    }
}

##########
# Confirm Menu -End
##########

##########
# Menu Display Function -Start
##########

#DisplayOutMenu([String]$TxtToDisplay,[int]$TxtColor,[int]$BGColor,[int]$NewLine)

# Displays Menu items but has Seperators
function MenuDisplay ([Array]$ToDisplay) {
    TitleBottom $ToDisplay[0] 11
    DisplayOutMenu "|                         |                         |" 14 0 1
    for ($i=1; $i -lt $ToDisplay.length-1; $i++) {
	    DisplayOutMenu "|  " 14 0 0 ;DisplayOutMenu $ToDisplay[$i] 2 0 0 ;DisplayOutMenu "|  " 14 0 0 ;DisplayOutMenu $ToDisplay[$i+1] 2 0 0 ;DisplayOutMenu "|" 14 0 1
        $i++
    }
    DisplayOutMenu "|                         |                         |" 14 0 1
    TitleBottom $ToDisplay[$ToDisplay.length-1] 13
    Website
}

# To display Settings Item with Choices for it
# 1-2 are for description
# For loop = Choices
# $ChToDisplayVal = Current Value
function ChoicesDisplay ([Array]$ChToDisplay, [Int]$ChToDisplayVal) {
    TitleBottom $ChToDisplay[0] 11
    DisplayOutMenu "|                                                   |" 14 0 1
    DisplayOutMenu "|  " 14 0 0 ;DisplayOutMenu $ChToDisplay[1] 2 0 0 ;DisplayOutMenu "|" 14 0 1
    DisplayOutMenu "|  " 14 0 0 ;DisplayOutMenu $ChToDisplay[2] 2 0 0 ;DisplayOutMenu "|" 14 0 1
    DisplayOutMenu "|                                                   |" 14 0 1
    DisplayOutMenu "|---------------------------------------------------|" 14 0 1
    DisplayOutMenu "|                                                   |" 14 0 1
    for ($i=3; $i -lt $ChToDisplay.length-1; $i++) {
        DisplayOutMenu "|  " 14 0 0 ;DisplayOutMenu $ChToDisplay[$i] 2 0 0 ;DisplayOutMenu "|" 14 0 1
    }
    DisplayOutMenu "|                                                   |" 14 0 1
    DisplayOutMenu "|  " 14 0 0 ;DisplayOutMenu "Current Value: " 13 0 0 ;DisplayOutMenu $ChToDisplayVal 13 0 0 ;DisplayOutMenu "                                 |" 14 0 1
    TitleBottom $ChToDisplay[$ChToDisplay.length-1] 13
    Website
}


# Displays items but NO Seperators
function VariableDisplay ([Array]$VarToDisplay) {
    TitleBottom $VarToDisplay[0] 11
    for ($i=3; $i -lt $VarToDisplay.length-1; $i++) {
        DisplayOutMenu "|  " 14 0 0 ;DisplayOutMenu $VarToDisplay[$i] 2 0 0 ;DisplayOutMenu "|" 14 0 1
    }
    TitleBottom $VarToDisplay[$VarToDisplay.length-1] 16
}

# Displays Title of Menu but with color choices
function TitleBottom ([String]$TitleA,[Int]$TitleB) {
    DisplayOutMenu "|---------------------------------------------------|" 14 0 1
    If($TitleB -eq 16) {
        DisplayOutMenu "|  " 14 0 0 ;DisplayOutMenu "Current Version: " 15 0 0 ;DisplayOutMenu $CurrVer 15 0 0 ;DisplayOutMenu "|" 14 0 0
	If($RelType -eq "Stable "){
	    DisplayOutMenu " Release:" 11 0 0 ;DisplayOutMenu $RelType 11 0 0 ;
	} Else {
            DisplayOutMenu " Release:" 15 0 0 ;DisplayOutMenu $RelType 15 0 0 ;
        }
	DisplayOutMenu "|" 14 0 1
    } Else {
	DisplayOutMenu "|  " 14 0 0 ;DisplayOutMenu $TitleA $TitleB 0 0 ;DisplayOutMenu "|" 14 0 1
    }
    DisplayOutMenu "|---------------------------------------------------|" 14 0 1
}

function Website {
    DisplayOutMenu "|" 14 0 0 ;DisplayOutMenu "     https://github.com/madbomb122/Win10Script     " 15 0 0 ;DisplayOutMenu "|" 14 0 1
    DisplayOutMenu "|---------------------------------------------------|" 14 0 1
}

##########
# Menu Display Function -End
##########

##########
# Main Menu -Start
##########

$MainMenuItems = @(
'                    Main Menu                    ',
'1. Run Script          ','U. How to Use Script   ',
'2. Script Settings     ','H. Help                ',
'3. Load Setting        ','C. Copyright           ',
'4. Save Setting        ','A. About/Version       ',
'5. Script Options      ','                       ',
'Q. Exit/Quit                                     '
)

function mainMenu {
    $mainMenu = 'X'
    while($mainMenu -ne "Out"){
        Clear-Host
	MenuDisplay $MainMenuItems 0
	If($Invalid -eq 1){
	    Write-host ""
	    Write-host "Invalid Selection" -ForegroundColor Red -BackgroundColor Black -NoNewline
	    $Invalid = 0
	}
	$mainMenu = Read-Host "`nSelection"
	switch ($mainMenu) {
            1 {""} #Run Script
            2 {ScriptSettingsMM} #Script Settings Main Menu
            3 {LoadSetting} #Load Settings
            4 {SaveSetting} #Save Settings
            5 {VariMenu $ScriptOptionMenuItems $ScriptOptionMenuItm} #Script Options
            H {HUACMenu "HelpItems"} #Help
	    U {HUACMenu "UsageItems"} #How to Use
            A {HUACMenu "AboutItems"}  #About/Version
            C {HUACMenu "CopyrightItems"}  #Copyright
	    Q {$mainMenu = "Out"} 
            default {$Invalid = 1}
        }
    }
}



##########
# Main Menu -End
##########

##########
# Script Settings -Start
##########

$ScriptSettingsMainMenuItems = @(
'            Script Setting Main Menu             ',
'1. Privacy Settings    ','7. Windows Update      ',
'2. Service Tweaks      ','8. Context Menu        ',
'3. Start Menu          ','9. Task Bar            ',
'4. Lock Screen         ','10. Features           ',
"5. 'This PC'           ",'11. Metro Apps         ',
'6. Explorer            ','12. Misc/Photo Viewer  ',
'B. Back to Main Menu                             '
)

function ScriptSettingsMM {
    $ScriptSettingsMM = 'X'
    while($ScriptSettingsMM -ne "Out"){
        Clear-Host
		MenuDisplay $ScriptSettingsMainMenuItems
		If($Invalid -eq 1){
			Write-host ""
			Write-host "Invalid Selection" -ForegroundColor Red -BackgroundColor Black -NoNewline
			$Invalid = 0
		}
        $ScriptSettingsMM = Read-Host "`nSelection"
		switch ($ScriptSettingsMM) {
            1 {""} #Privacy Settings
            2 {""} #Service Tweaks
            3 {""} #Star Menu
            4 {""} #Lock Screen
            5 {""} #'This PC'
            6 {""} #Explorer
            7 {""} #Windows Update
            8 {""} #Context Menu
            9 {""} #Task Bar
            10 {""} #Features
            11 {""} #Metro Apps
	    12 {""} #Misc/Photo Viewer
            B {$ScriptSettingsMM = "Out"}
            default {$Invalid = 1}
		}
    }
}

            5 {VariMenu $ScriptOptionMenuItems $ScriptOptionMenuItm} #Script Options

##########
# Script Settings -End
##########

##########
# Load/Save Settings -Start
##########

$SettingFileItems = @(
'                  Setting File                   ',
'                                                 ',
'            Please Input Filename.               ',
'  0. Cancel/Back to Main Menu                    '
)

function LoadSetting {
    $LoadSetting = 'X'
    while($LoadSetting -ne "Out"){
        Clear-Host
		VariableDisplay $SettingFileItems
		If($Invalid -eq 1){
		    Write-host ""
			Write-host "No file with the name " $LoadSetting -ForegroundColor Red -BackgroundColor Black -NoNewline
			$Invalid = 0
		}
	# Add ability to load Win Default Values
        $LoadSetting = Read-Host "`nFilename"
		If ($LoadSetting -eq $null -or $LoadSetting -eq 0){
			$LoadSetting ="Out"
		} ElseIf (Test-Path $LoadSetting -PathType Leaf){
			$Conf = ConfrmMenu 1
			If($Conf -eq $true){
			    Import-Clixml .\$LoadSetting | %{ Set-Variable $_.Name $_.Value }
				$LoadSetting = 0
			} Else {
				$LoadSetting = 0
			}
		} Else {
            $Invalid = 1
		}
    }
}

function SaveSetting {
    $SaveSetting = 'X'
    while($SaveSetting -ne "Out"){
        Clear-Host
		VariableDisplay $SettingFileItems
		$SaveSetting = Read-Host "`nFilename"
		If ($LoadSetting -eq $null -or $LoadSetting -eq 0){
			$SaveSetting = "Out"
		} Else {
			If (Test-Path $SaveSetting -PathType Leaf){
			    $Conf = ConfirmMenu 2
			    If($Conf -eq $true){
			        cmpv | Export-Clixml .\$SaveSetting
			    }
		    } Else {
			    cmpv | Export-Clixml .\$SaveSetting
		    }
			$SaveSetting = "Out"
		}
    }
}

##########
#  Load/Save Settings -End
##########

##########
# Script Options Sub Menu -Start
##########

$ScriptOptionMenuItems = @(
'              Metro Apps Items Menu              ',
'1. Create Restore Point','4. Show Color          ',
'2. Agree Term of Use   ','5. Restart when Done   ',
'3. Verbros             ','                       ',
'B. Back to Main Menu                             '
)

$ScriptOptionMenuItm = (
(1,"CreateRestorePoint"),
(2,"Term_of_Use"),
(3,"Verbros"),
(4,"ShowColor"),
(5,"Restart")
)

$CreateRestorePointItems = @(
'              Create Restore Point               ',
' Creates a restore point before the script runs. ',
' This Only can be done once ever 24 Hours.       ',
'0. Skip                                          ',
'1. Create Restore Point                          ',
'C. Cancel (Keeps Current Setting)                '
)

$Term_of_UseItems = @(
'                   Term of Use                   ',
'                                                 ',
' DO you Agree to the Terms of Use?               ',
'0. Agree to Term of Use                          ',
'1. Disagree (Will See Terms when you run script) ',
'C. Cancel (Keeps Current Setting)                '
)

$VerbrosItems = @(
'                     Verbros                     ',
'                                                 ',
' Shows output of the Script.                     ',
'0. Dont Show Output                              ',
'1. Show Output                                   ',
'C. Cancel (Keeps Current Setting)                '
)

$ShowColorItems = @(
'                   Show Color                    ',
'                                                 ',
' Shows color for the output of the Script.       ',
'0. Dont Show Color                               ',
'1. Show Color                                    ',
'C. Cancel (Keeps Current Setting)                '
)

$RestartItems = @(
'                     Restart                     ',
' Restart computer when Script is done?           ',
' I recommend you restart computer.               ',
'0. Dont Restart Computer                         ',
'1. Restart Computer                              ',
'C. Cancel (Keeps Current Setting)                '
)

##########
# Script Options Sub Menu -End
##########

##########
# Info Display Stuff -Start
##########

$HelpItems = @(
'                      Help                       ',
'                                                 ',
'                                                 ',
'Press "Enter" to go back                         '
)

$UsageItems = @(
'                How to Use Script                ',
'                                                 ',
' Basic Usage:                                    ',
' Use the menu & select what you want to change.  ',
'                                                 ',
' Advanced Usage Choices (Bypasses Menu):         ',
' 1. Edit the script & change values there then   ',
'        run script with "-set Run"               ',
' 2. Run Script with an imported file with        ',
'        "-set filename"                          ',
' 3. Run Script with Window Default Values with   ',
'        "-set WD" or "-set WindowsDefault"       ',
'                                                 ',
' Examples:                                       ',
'    Win10-Mod.ps1 -set Run                       ',
'    Win10-Mod.ps1 -set Settings.xml              ',
'    Win10-Mod.ps1 -set WD                        ',
'                                                 ',
'Press "Enter" to go back                         '
)

$AboutItems = @(
'                About this Script                ',
'                                                 ',
' This script makes it easier to setup an         ',
' existing or new install with modded setting.    ',
'                                                 ',
' This script was made by Me (Madbomb122).        ',
'    https://github.com/madbomb122/Win10Script    ',
'                                                 ',
' Original basic script was made by Disassembler  ',
'    https://github.com/Disassembler0/            ',
'                                                 ',
"Press 'Enter' to go back                         "
)

$CopyrightItems = @(
'                    Copyright                    ',
'                                                 ',
' Copyright (c) 2017 Disassembler -Original       ',
' Copyright (c) 2017 Madbomb122 -This Script      ',
' This program is free software: you can          ',
' redistribute it and/or modify This program is   ',
' free software This program is free software:    ',
' you can redistribute it and/or modify it under  ',
' the terms of the GNU General Public License as  ',
' published by the Free Software Foundation,      ',
' version 3 of the License.                       ',
'                                                 ',
' This program is distributed in the hope that it ',
' will be useful, but WITHOUT ANY WARRANTY;       ',
' without even the implied warranty of            ',
' MERCHANTABILITY or FITNESS FOR A PARTICULAR     ',
' PURPOSE.  See the GNU General Public License    ',
' for more details.                               ',
'                                                 ',
' You should have received a copy of the GNU      ',
' General Public License along with this program. ',
' If not, see <http://www.gnu.org/licenses/>.     '
)

function HUACMenu([String]$VariJ) {
    $HUACMenu = 'X'
	$VariA = Get-Variable $VariJ -valueOnly #Array
    while($HUACMenu -ne "Out"){
        Clear-Host
		VariableDisplay $VariA 0
        $HUACMenu = Read-Host "`nPress 'Enter' to continue"
		switch ($HUACMenu) {
            default {$HUACMenu = "Out"}
        }
    }
}


##########
# Info Display Stuff -End
##########

##########
# Script Settings Sub Menu -Start
##########

$PrivacySetMenuItems = @(
'              Privacy Settings Menu              ',
'1. Telemetry           ','7. Wi-Fi Sense         ',
'2. Smart Screen        ','8. Auto Logger File    ',
'3. Location Tracking   ','9. Feedback            ',
'4. Explorer            ','10. Advertising ID     ',
'5. Cortana             ','11. Cortana Search     ',
'6. Error Reporting     ','12. WAP Push           ',
'B. Back to Script Setting Main Menu              '
)

$WindowsUpdateSetMenuItems = @(
'           Window Update Settings Menu           ',
'1. Check for Update    ','5. Update Type         ',
'2. Update Download     ','6. Update MSRT         ',
'3. Update Driver       ','7. Restart on Update   ',
'4. App Auto Download   ','                       ',
'B. Back to Script Setting Main Menu              '
)

$ServiceTweaksSetMenuItems = @(
'          Service Tweaks Settings Menu           ',
'1. User Agent Control  ','5. Sharing Mapped Drive',
'2. Admin Shares        ','6. Firewall            ',
'3. Windows Defender    ','7. HomeGroups          ',
'4. Remote Assistance   ','8. Remote Desktop      ',
'B. Back to Script Setting Main Menu              '
)

$ContextMenuSetMenuItems = @(
'             Context Menu Items Menu             ',
'1. Cast to Device      ','4. Previous Versions   ',
'2. Include in Library  ','5. Pin To              ',
'3. Share With          ','6. Send To             ',
'B. Back to Script Setting Main Menu              '
)

$StartMenuSetMenuItems = @(
'              Start Menu Items Menu              ',
'1. Startmenu Web Search','4. Most Used Apps      ',
'2. Suggestions         ','5. Recent & Frequent   ',
'3. Unpin Items         ','                       ',
'B. Back to Script Setting Main Menu              '
)

$TaskbarSetMenuItems = @(
'               Taskbar Items Menu                ',
'1. Battery UI Bar      ','7. Clock UI Bar        ',
'2. Volume Control Bar  ','8. Taskbar Search Box  ',
'3. Task View Button    ','9. Taskbar Icon Size   ',
'4. Taskbar Grouping    ','10. Notifcation Icons  ',
'5. Seconds in Clock    ','11. Last Active Click  ',
'6. Multi Display       ','12. Buttons on Display ',
'B. Back to Script Setting Main Menu              '
)

$ExplorerSetMenuItems = @(
'               Explorer Items Menu               ',
'1. Frequent Quick Acess','7. Content While Drag  ',
'2. Recent Quick Acess  ','8. Explorer Open Locat ',
'3. System Files        ','9. Known Extensions    ',
'4. Hidden Files        ','10. Autorun            ',
'5. Aero Snape          ','11. Autoplay           ',
'6. Aero Shake          ','12. Pid in Title Bar   ',
'B. Back to Script Setting Main Menu              '
)

$ThisPCSetMenuItems = @(
"               'This PC' Items Menu              ",
"1. 'This PC' On Desktop",'5. Desktop Icon        ',
'2. Documents Icon      ','6. Downloads Icon      ',
'3. Music Icon          ','7. Pictures Icon       ',
'4. Videos Icon         ','                       ',
'B. Back to Script Setting Main Menu              '
)

$LockScreenSetMenuItems = @(
'              Lock Screen Items Menu             ',
'1. Lock Screen         ','3. Lock Screen Alt     ',
'2. Power Menu          ','4. Camera              ',
'B. Back to Script Setting Main Menu              '
)

$MiscSetMenuItems = @(
'           Misc/Photo Viewer Items Menu          ',
'       Misc Item       ',' Photo Viewer Settings ',
'1. Action Center       ','8. File Association    ',
'2. Sticky Key Prompt   ','9. Open With Menu      ',
'3. Numblock On Start   ','                       ',
'4. F8 Boot Menu        ','                       ',
'5. Remote UAC Token    ','                       ',
'6. Hibernate           ','                       ',
'7. Sleep               ','                       ',
'B. Back to Script Setting Main Menu              '
)

$FeaturesAppsMenuItems = @(
'               Features Items Menu               ',
'1. One Drive           ','4. Media Player        ',
'2. One Drive Install   ','5. Work Folders        ',
'3. Xbox DVR            ','6. Linux Subsystem     ',
'B. Back to Script Setting Main Menu              '
)

$MetroAppsMenuItems = @(
'              Metro Apps Items Menu              ',
'1. ALL METRO APPS      ','12. Microsoft Solitaire',
"2. '3DBuilder' app     ",'13. One Connect        ',
"3. 'Alarms' app        ",'14. Office OneNote     ',
"4. 'Calculator' app    ","15. 'People' app       ",
"5. 'Camera' app        ","16. 'Photos' app       ",
'6. Feedback Hub        ',"17. 'Skype' app        ",
"7. 'Get Office' App    ",'18. Sticky Notes       ',
'8. Get Started         ',"19. 'Store' app        ",
"9. 'Groove Music' app  ",'20. Voice Recorder     ',
"10. 'Maps' app         ","21. 'Weather' app      ",
"11. 'Messaging' App    ","22. 'Xbox' App         ",
'B. Back to Script Setting Main Menu              '
)



##########
# Script Settings Sub Menu -End
##########


# Used to get all values BEFORE any defined so
# when exporting shows ALL defined after this point
$AutomaticVariables = Get-Variable

mainMenu
# Function to Display in Color or NOT (for MENU ONLY)
Function DisplayOutMenu([String]$TxtToDisplay,[int]$TxtColor,[int]$BGColor,[int]$NewLine){
    If ($NewLine -eq 0){
        If($TxtColor -le 15 -and $ShowColor -eq 1){
             Write-Host -NoNewline $TxtToDisplay -ForegroundColor $colors[$TxtColor] -BackgroundColor $colors[$BGColor]
        } Else {
             Write-Host -NoNewline $TxtToDisplay
        }
	} Else {
	     If($TxtColor -le 15 -and $ShowColor -eq 1){
             Write-Host $TxtToDisplay -ForegroundColor $colors[$TxtColor] -BackgroundColor $colors[$BGColor]
        } Else {
             Write-Host $TxtToDisplay
        }
    }
}

function ChoicesMenu([String]$Vari, [Int]$Number) {
    $VariJ = -join($Vari,"Items")
    $VariV = Get-Variable $Vari -valueOnly #Variable
    $VariA = Get-Variable $VariJ -valueOnly #Array
    $ChoicesMenu = 'X'
    while($ChoicesMenu -ne "Out"){
        Clear-Host
	ChoicesDisplay $VariA $VariV
	If($Invalid -eq 1){
	    Write-host ""
	    Write-host "Invalid Selection" -ForegroundColor Red -BackgroundColor Black -NoNewline
	    $Invalid = 0
	}
        $ChoicesMenu = Read-Host "`nChoice"
	switch ($ChoicesMenu) {
	    C {$ReturnV = $VariV; $ChoicesMenu = "Out"}
            default {if($Number -ge $ChoicesMenu) {$ReturnV = $ChoicesMenu; $ChoicesMenu = "Out"} Else {$Invalid = 1}}
	}
    }
    Set-Variable -Name $Vari -Value $ReturnV -Scope Script;
}

function VariMenu([Array]$VariDisplay,[Array]$VariMenuItm) {
    $VariMenu = 'X'
    while($VariMenu -ne "Out"){
        Clear-Host
        MenuDisplay $VariDisplay
	If($Invalid -eq 1){
	    Write-host ""
	    Write-host "Invalid Selection" -ForegroundColor Red -BackgroundColor Black -NoNewline
	    $Invalid = 0
	}
        $VariMenu = Read-Host "`nSelection"
	$ConInt = $VariMenu -as [int]
        If($ConInt -is [int]){
        	for ($i=0; $i -le $VariMenuItm.length; $i++) {
                     If($VariMenuItm[$i][0] -eq $ConInt){
                $LoopVar = $i
                	$i = $VariMenuItm.length+1
            	}
        	}
        	If($LoopVar -is [int]){
                ChoicesMenu ($VariMenuItm[$LoopVar][1]) 1
        	} Else{
                $Invalid = 1        
        	}
		} Else {
			switch ($VariMenu) {
                B {$VariMenu = "Out"}
                default {$Invalid = 1}
        	}
		}
    }
}

##########
# Multi Use Functions -End
##########

##########
# Confirm Menu -Start
##########

$ConfirmMenuItems1 = @(
'                 Confirm Dialog                  ',

'              Are You sure? (Y/N)                ',
'0. Cancel/Back to Main Menu                      '
)

$ConfirmMenuItems2 = @(
'                 Confirm Dialog                  ',
'                                                 ',
'  File Exists do you want to overwrite? (Y/N)    ',
'0. Cancel/Back to Main Menu                      '
)

function ConfirmMenu([int]$Option) {
    $ConfirmMenu = 'X'
    while($ConfirmMenu -ne "Out"){
        Clear-Host
		If ($Option -eq 1){
			VariableDisplay $ConfirmMenuItems1
		} ElseIf ($Option -eq 2){
			VariableDisplay $ConfirmMenuItems2
		}
		$ConfirmMenu = Read-Host "`nSelection (Y/N)"
        switch (ConfirmMenu) {
			Y {Return $true}
            N {Return $false}
		    default {Return $false}
		}
    }
}

##########
# Confirm Menu -End
##########

##########
# Menu Display Function -Start
##########

#DisplayOutMenu([String]$TxtToDisplay,[int]$TxtColor,[int]$BGColor,[int]$NewLine)

# Displays Menu items but has Seperators
function MenuDisplay ([Array]$ToDisplay) {
    TitleBottom $ToDisplay[0] 11
	DisplayOutMenu "|                         |                         |" 14 0 1
    for ($i=1; $i -lt $ToDisplay.length-1; $i++) {
	    DisplayOutMenu "|  " 14 0 0 ;DisplayOutMenu $ToDisplay[$i] 2 0 0 ;DisplayOutMenu "|  " 14 0 0 ;DisplayOutMenu $ToDisplay[$i+1] 2 0 0 ;DisplayOutMenu "|" 14 0 1
        $i++
    }
	DisplayOutMenu "|                         |                         |" 14 0 1
    TitleBottom $ToDisplay[$ToDisplay.length-1] 13
	Website
}

# To display Settings Item with Choices for it
# 1-2 are for description
# For loop = Choices
# $ChToDisplayVal = Current Value
function ChoicesDisplay ([Array]$ChToDisplay, [Int]$ChToDisplayVal) {
    TitleBottom $ChToDisplay[0] 11
    DisplayOutMenu "|                                                   |" 14 0 1
    DisplayOutMenu "|  " 14 0 0 ;DisplayOutMenu $ChToDisplay[1] 2 0 0 ;DisplayOutMenu "|" 14 0 1
    DisplayOutMenu "|  " 14 0 0 ;DisplayOutMenu $ChToDisplay[2] 2 0 0 ;DisplayOutMenu "|" 14 0 1
    DisplayOutMenu "|                                                   |" 14 0 1
    DisplayOutMenu "|---------------------------------------------------|" 14 0 1
    DisplayOutMenu "|                                                   |" 14 0 1
    for ($i=3; $i -lt $ChToDisplay.length-1; $i++) {
        DisplayOutMenu "|  " 14 0 0 ;DisplayOutMenu $ChToDisplay[$i] 2 0 0 ;DisplayOutMenu "|" 14 0 1
    }
    DisplayOutMenu "|                                                   |" 14 0 1
	DisplayOutMenu "|  " 14 0 0 ;DisplayOutMenu "Current Value: " 13 0 0 ;DisplayOutMenu $ChToDisplayVal 13 0 0 ;DisplayOutMenu "                                 |" 14 0 1
    TitleBottom $ChToDisplay[$ChToDisplay.length-1] 13
	Website
}


# Displays items but NO Seperators
function VariableDisplay ([Array]$VarToDisplay) {
    TitleBottom $VarToDisplay[0] 11
    for ($i=3; $i -lt $VarToDisplay.length-1; $i++) {
        DisplayOutMenu "|  " 14 0 0 ;DisplayOutMenu $VarToDisplay[$i] 2 0 0 ;DisplayOutMenu "|" 14 0 1
    }
    TitleBottom $VarToDisplay[$VarToDisplay.length-1] 16
}

# Displays Title of Menu but with color choices
function TitleBottom ([String]$TitleA,[Int]$TitleB) {
    DisplayOutMenu "|---------------------------------------------------|" 14 0 1
	If($TitleB -eq 16) {
	    DisplayOutMenu "|  " 14 0 0 ;DisplayOutMenu "Current Version: " 15 0 0 ;DisplayOutMenu $CurrVer 15 0 0 ;DisplayOutMenu "|" 14 0 0
		If($RelType -eq "Stable "){
		DisplayOutMenu " Release:" 11 0 0 ;DisplayOutMenu $RelType 11 0 0 ;
		} Else {
		DisplayOutMenu " Release:" 15 0 0 ;DisplayOutMenu $RelType 15 0 0 ;
        }
		DisplayOutMenu "|" 14 0 1
    } Else {
	    DisplayOutMenu "|  " 14 0 0 ;DisplayOutMenu $TitleA $TitleB 0 0 ;DisplayOutMenu "|" 14 0 1
	}
    DisplayOutMenu "|---------------------------------------------------|" 14 0 1
}

function Website {
    DisplayOutMenu "|" 14 0 0 ;DisplayOutMenu "     https://github.com/madbomb122/Win10Script     " 15 0 0 ;DisplayOutMenu "|" 14 0 1
    DisplayOutMenu "|---------------------------------------------------|" 14 0 1
}

##########
# Menu Display Function -End
##########

##########
# Main Menu -Start
##########

$MainMenuItems = @(
'                    Main Menu                    ',
'1. Run Script          ','U. How to Use Script   ',
'2. Script Settings     ','H. Help                ',
'3. Load Setting        ','C. Copyright           ',
'4. Save Setting        ','A. About/Version       ',
'5. Script Options      ','                       ',
'Q. Exit/Quit                                     '
)

function mainMenu {
    $mainMenu = 'X'
    while($mainMenu -ne "Out"){
        Clear-Host
		MenuDisplay $MainMenuItems 0
		If($Invalid -eq 1){
		    Write-host ""
			Write-host "Invalid Selection" -ForegroundColor Red -BackgroundColor Black -NoNewline
			$Invalid = 0
		}
		$mainMenu = Read-Host "`nSelection"
		switch ($mainMenu) {
            1 {""} #Run Script
            2 {ScriptSettingsMM} #Script Settings Main Menu
            3 {LoadSetting} #Load Settings
            4 {SaveSetting} #Save Settings
            5 {VariMenu $ScriptOptionMenuItems $ScriptOptionMenuItm} #Script Options
            H {HUACMenu "HelpItems"} #Help
	    U {HUACMenu "UsageItems"} #How to Use
            A {HUACMenu "AboutItems"}  #About/Version
            C {HUACMenu "CopyrightItems"}  #Copyright
	    Q {$mainMenu = "Out"} 
            default {$Invalid = 1}
        }
    }
}



##########
# Main Menu -End
##########

##########
# Script Settings -Start
##########

$ScriptSettingsMainMenuItems = @(
'            Script Setting Main Menu             ',
'1. Privacy Settings    ','7. Windows Update      ',
'2. Service Tweaks      ','8. Context Menu        ',
'3. Start Menu          ','9. Task Bar            ',
'4. Lock Screen         ','10. Features           ',
"5. 'This PC'           ",'11. Metro Apps         ',
'6. Explorer            ','12. Misc/Photo Viewer  ',
'B. Back to Main Menu                             '
)

function ScriptSettingsMM {
    $ScriptSettingsMM = 'X'
    while($ScriptSettingsMM -ne "Out"){
        Clear-Host
		MenuDisplay $ScriptSettingsMainMenuItems
		If($Invalid -eq 1){
			Write-host ""
			Write-host "Invalid Selection" -ForegroundColor Red -BackgroundColor Black -NoNewline
			$Invalid = 0
		}
        $ScriptSettingsMM = Read-Host "`nSelection"
		switch ($ScriptSettingsMM) {
            1 {""} #Privacy Settings
            2 {""} #Service Tweaks
            3 {""} #Star Menu
            4 {""} #Lock Screen
            5 {""} #'This PC'
            6 {""} #Explorer
            7 {""} #Windows Update
            8 {""} #Context Menu
            9 {""} #Task Bar
            10 {""} #Features
            11 {""} #Metro Apps
	    12 {""} #Misc/Photo Viewer
            B {$ScriptSettingsMM = "Out"}
            default {$Invalid = 1}
		}
    }
}

            5 {VariMenu $ScriptOptionMenuItems $ScriptOptionMenuItm} #Script Options

##########
# Script Settings -End
##########

##########
# Load/Save Settings -Start
##########

$SettingFileItems = @(
'                  Setting File                   ',
'                                                 ',
'            Please Input Filename.               ',
'  0. Cancel/Back to Main Menu                    '
)

function LoadSetting {
    $LoadSetting = 'X'
    while($LoadSetting -ne "Out"){
        Clear-Host
		VariableDisplay $SettingFileItems
		If($Invalid -eq 1){
		    Write-host ""
			Write-host "No file with the name " $LoadSetting -ForegroundColor Red -BackgroundColor Black -NoNewline
			$Invalid = 0
		}
	# Add ability to load Win Default Values
        $LoadSetting = Read-Host "`nFilename"
		If ($LoadSetting -eq $null -or $LoadSetting -eq 0){
			$LoadSetting ="Out"
		} ElseIf (Test-Path $LoadSetting -PathType Leaf){
			$Conf = ConfrmMenu 1
			If($Conf -eq $true){
			    Import-Clixml .\$LoadSetting | %{ Set-Variable $_.Name $_.Value }
				$LoadSetting = 0
			} Else {
				$LoadSetting = 0
			}
		} Else {
            $Invalid = 1
		}
    }
}

function SaveSetting {
    $SaveSetting = 'X'
    while($SaveSetting -ne "Out"){
        Clear-Host
		VariableDisplay $SettingFileItems
		$SaveSetting = Read-Host "`nFilename"
		If ($LoadSetting -eq $null -or $LoadSetting -eq 0){
			$SaveSetting = "Out"
		} Else {
			If (Test-Path $SaveSetting -PathType Leaf){
			    $Conf = ConfirmMenu 2
			    If($Conf -eq $true){
			        cmpv | Export-Clixml .\$SaveSetting
			    }
		    } Else {
			    cmpv | Export-Clixml .\$SaveSetting
		    }
			$SaveSetting = "Out"
		}
    }
}

##########
#  Load/Save Settings -End
##########

##########
# Script Options Sub Menu -Start
##########

$ScriptOptionMenuItems = @(
'              Metro Apps Items Menu              ',
'1. Create Restore Point','4. Show Color          ',
'2. Agree Term of Use   ','5. Restart when Done   ',
'3. Verbros             ','                       ',
'B. Back to Main Menu                             '
)

$ScriptOptionMenuItm = (
(1,"CreateRestorePoint"),
(2,"Term_of_Use"),
(3,"Verbros"),
(4,"ShowColor"),
(5,"Restart")
)

$CreateRestorePointItems = @(
'              Create Restore Point               ',
' Creates a restore point before the script runs. ',
' This Only can be done once ever 24 Hours.       ',
'0. Skip                                          ',
'1. Create Restore Point                          ',
'C. Cancel (Keeps Current Setting)                '
)

$Term_of_UseItems = @(
'                   Term of Use                   ',
'                                                 ',
' DO you Agree to the Terms of Use?               ',
'0. Agree to Term of Use                          ',
'1. Disagree (Will See Terms when you run script) ',
'C. Cancel (Keeps Current Setting)                '
)

$VerbrosItems = @(
'                     Verbros                     ',
'                                                 ',
' Shows output of the Script.                     ',
'0. Dont Show Output                              ',
'1. Show Output                                   ',
'C. Cancel (Keeps Current Setting)                '
)

$ShowColorItems = @(
'                   Show Color                    ',
'                                                 ',
' Shows color for the output of the Script.       ',
'0. Dont Show Color                               ',
'1. Show Color                                    ',
'C. Cancel (Keeps Current Setting)                '
)

$RestartItems = @(
'                     Restart                     ',
' Restart computer when Script is done?           ',
' I recommend you restart computer.               ',
'0. Dont Restart Computer                         ',
'1. Restart Computer                              ',
'C. Cancel (Keeps Current Setting)                '
)

##########
# Script Options Sub Menu -End
##########

##########
# Info Display Stuff -Start
##########

$HelpItems = @(
'                      Help                       ',
'                                                 ',
'                                                 ',
'Press "Enter" to go back                         '
)

$UsageItems = @(
'                How to Use Script                ',
'                                                 ',
' Basic Usage:                                    ',
' Use the menu & select what you want to change.  ',
'                                                 ',
' Advanced Usage Choices (Bypasses Menu):         ',
' 1. Edit the script & change values there then   ',
'        run script with "-set Run"               ',
' 2. Run Script with an imported file with        ',
'        "-set filename"                          ',
' 3. Run Script with Window Default Values with   ',
'        "-set WD" or "-set WindowsDefault"       ',
'                                                 ',
' Examples:                                       ',
'    Win10-Mod.ps1 -set Run                       ',
'    Win10-Mod.ps1 -set Settings.xml              ',
'    Win10-Mod.ps1 -set WD                        ',
'                                                 ',
'Press "Enter" to go back                         '
)

$AboutItems = @(
'                About this Script                ',
'                                                 ',
' This script makes it easier to setup an         ',
' existing or new install with modded setting.    ',
'                                                 ',
' This script was made by Me (Madbomb122).        ',
'    https://github.com/madbomb122/Win10Script    ',
'                                                 ',
' Original basic script was made by Disassembler  ',
'    https://github.com/Disassembler0/            ',
'                                                 ',
"Press 'Enter' to go back                         "
)

$CopyrightItems = @(
'                    Copyright                    ',
'                                                 ',
' Copyright (c) 2017 Disassembler -Original       ',
' Copyright (c) 2017 Madbomb122 -This Script      ',
' This program is free software: you can          ',
' redistribute it and/or modify This program is   ',
' free software This program is free software:    ',
' you can redistribute it and/or modify it under  ',
' the terms of the GNU General Public License as  ',
' published by the Free Software Foundation,      ',
' version 3 of the License.                       ',
'                                                 ',
' This program is distributed in the hope that it ',
' will be useful, but WITHOUT ANY WARRANTY;       ',
' without even the implied warranty of            ',
' MERCHANTABILITY or FITNESS FOR A PARTICULAR     ',
' PURPOSE.  See the GNU General Public License    ',
' for more details.                               ',
'                                                 ',
' You should have received a copy of the GNU      ',
' General Public License along with this program. ',
' If not, see <http://www.gnu.org/licenses/>.     '
)

function HUACMenu([String]$VariJ) {
    $HUACMenu = 'X'
	$VariA = Get-Variable $VariJ -valueOnly #Array
    while($HUACMenu -ne "Out"){
        Clear-Host
		VariableDisplay $VariA 0
        $HUACMenu = Read-Host "`nPress 'Enter' to continue"
		switch ($HUACMenu) {
            default {$HUACMenu = "Out"}
        }
    }
}


##########
# Info Display Stuff -End
##########

##########
# Script Settings Sub Menu -Start
##########

$PrivacySetMenuItems = @(
'              Privacy Settings Menu              ',
'1. Telemetry           ','7. Wi-Fi Sense         ',
'2. Smart Screen        ','8. Auto Logger File    ',
'3. Location Tracking   ','9. Feedback            ',
'4. Explorer            ','10. Advertising ID     ',
'5. Cortana             ','11. Cortana Search     ',
'6. Error Reporting     ','12. WAP Push           ',
'B. Back to Script Setting Main Menu              '
)

$WindowsUpdateSetMenuItems = @(
'           Window Update Settings Menu           ',
'1. Check for Update    ','5. Update Type         ',
'2. Update Download     ','6. Update MSRT         ',
'3. Update Driver       ','7. Restart on Update   ',
'4. App Auto Download   ','                       ',
'B. Back to Script Setting Main Menu              '
)

$ServiceTweaksSetMenuItems = @(
'          Service Tweaks Settings Menu           ',
'1. User Agent Control  ','5. Sharing Mapped Drive',
'2. Admin Shares        ','6. Firewall            ',
'3. Windows Defender    ','7. HomeGroups          ',
'4. Remote Assistance   ','8. Remote Desktop      ',
'B. Back to Script Setting Main Menu              '
)

$ContextMenuSetMenuItems = @(
'             Context Menu Items Menu             ',
'1. Cast to Device      ','4. Previous Versions   ',
'2. Include in Library  ','5. Pin To              ',
'3. Share With          ','6. Send To             ',
'B. Back to Script Setting Main Menu              '
)

$StartMenuSetMenuItems = @(
'              Start Menu Items Menu              ',
'1. Startmenu Web Search','4. Most Used Apps      ',
'2. Suggestions         ','5. Recent & Frequent   ',
'3. Unpin Items         ','                       ',
'B. Back to Script Setting Main Menu              '
)

$TaskbarSetMenuItems = @(
'               Taskbar Items Menu                ',
'1. Battery UI Bar      ','7. Clock UI Bar        ',
'2. Volume Control Bar  ','8. Taskbar Search Box  ',
'3. Task View Button    ','9. Taskbar Icon Size   ',
'4. Taskbar Grouping    ','10. Notifcation Icons  ',
'5. Seconds in Clock    ','11. Last Active Click  ',
'6. Multi Display       ','12. Buttons on Display ',
'B. Back to Script Setting Main Menu              '
)

$ExplorerSetMenuItems = @(
'               Explorer Items Menu               ',
'1. Frequent Quick Acess','7. Content While Drag  ',
'2. Recent Quick Acess  ','8. Explorer Open Locat ',
'3. System Files        ','9. Known Extensions    ',
'4. Hidden Files        ','10. Autorun            ',
'5. Aero Snape          ','11. Autoplay           ',
'6. Aero Shake          ','12. Pid in Title Bar   ',
'B. Back to Script Setting Main Menu              '
)

$ThisPCSetMenuItems = @(
"               'This PC' Items Menu              ",
"1. 'This PC' On Desktop",'5. Desktop Icon        ',
'2. Documents Icon      ','6. Downloads Icon      ',
'3. Music Icon          ','7. Pictures Icon       ',
'4. Videos Icon         ','                       ',
'B. Back to Script Setting Main Menu              '
)

$LockScreenSetMenuItems = @(
'              Lock Screen Items Menu             ',
'1. Lock Screen         ','3. Lock Screen Alt     ',
'2. Power Menu          ','4. Camera              ',
'B. Back to Script Setting Main Menu              '
)

$MiscSetMenuItems = @(
'           Misc/Photo Viewer Items Menu          ',
'       Misc Item       ',' Photo Viewer Settings ',
'1. Action Center       ','8. File Association    ',
'2. Sticky Key Prompt   ','9. Open With Menu      ',
'3. Numblock On Start   ','                       ',
'4. F8 Boot Menu        ','                       ',
'5. Remote UAC Token    ','                       ',
'6. Hibernate           ','                       ',
'7. Sleep               ','                       ',
'B. Back to Script Setting Main Menu              '
)

$FeaturesAppsMenuItems = @(
'               Features Items Menu               ',
'1. One Drive           ','4. Media Player        ',
'2. One Drive Install   ','5. Work Folders        ',
'3. Xbox DVR            ','6. Linux Subsystem     ',
'B. Back to Script Setting Main Menu              '
)

$MetroAppsMenuItems = @(
'              Metro Apps Items Menu              ',
'1. ALL METRO APPS      ','12. Microsoft Solitaire',
"2. '3DBuilder' app     ",'13. One Connect        ',
"3. 'Alarms' app        ",'14. Office OneNote     ',
"4. 'Calculator' app    ","15. 'People' app       ",
"5. 'Camera' app        ","16. 'Photos' app       ",
'6. Feedback Hub        ',"17. 'Skype' app        ",
"7. 'Get Office' App    ",'18. Sticky Notes       ',
'8. Get Started         ',"19. 'Store' app        ",
"9. 'Groove Music' app  ",'20. Voice Recorder     ',
"10. 'Maps' app         ","21. 'Weather' app      ",
"11. 'Messaging' App    ","22. 'Xbox' App         ",
'B. Back to Script Setting Main Menu              '
)



##########
# Script Settings Sub Menu -End
##########


# Used to get all values BEFORE any defined so
# when exporting shows ALL defined after this point
$AutomaticVariables = Get-Variable

mainMenu
