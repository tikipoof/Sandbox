<#
Create new user profile and install some colored theme
Start firefox with :
    firefox.exe -no-remote --profile-manager
    firefox.exe -no-remote -P profilename
#>

Param(
    [Parameter(Mandatory=$true)][string]$username = "tprofile",
    [Parameter(Mandatory=$false)][string]$theme = "Default"  # not used for the moment
)

$FirefoxPath = 'C:\Users\Prigeb70\AppData\Local\Mozilla Firefox\firefox.exe'
$ProfileDir = 'C:\Users\Prigeb70\Documents\sandbox\firefox\profiles'
$ConfigDir = 'C:\Users\Prigeb70\Documents\sandbox\firefox\scripts\config'

# Theme codes :
# Default 
# Green 29198
# Blue 255566
# Red 255565
# Yellow 255682


$ProfileExists = Test-Path $ProfileDir"\"$username
#$ProfileExists = $False

If ($ProfileExists -eq $False) {
        Write-Host Creating profile for $username
        &$FirefoxPath -no-remote -CreateProfile "$username $ProfileDir\$username" | Out-Null
        # Copy preference file
        Copy-Item -Path "$ConfigDir\prefs.js" -Destination "$ProfileDir\$username"
        # Set theme
          # todo replace the line user_pref("lightweightThemes.selectedThemeID", ""); by user_pref("lightweightThemes.selectedThemeID", "THEME CODE");
        # Copy extensions
        Copy-Item -Path "$ConfigDir\extensions" -Destination "$ProfileDir\$username\extensions" -Recurse

    } Else {
        Write-Host Profile $username already exists. Do nothing
    }

#Remove-Item $ProfileDir"\"$username -recurse