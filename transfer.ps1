$oldComputer = Read-Host -Prompt 'Enter the old computer name: '
$newComputer = Read-Host -Prompt 'Enter the new computer name: '
$username = Read-Host -Prompt 'Enter the username: '
$oldSourcePath = "\\$oldComputer\Users\$username" 
$newSourcePath = "\\$newComputer\Users\$username"


# Check if the source directories exist. If not, exit the script. If the new computer directory does not exist, prompt the user to create it.
if (!(Test-Path -Path $oldSourcePath)) {
    Write-Host "The directory ($oldSourcePath) for the old computer does not exist. Exiting..."
    exit
} elseif (!(Test-Path -Path $newSourcePath)) {
    Write-Host "The directory ($newSourcePath) for the new computer does not exist. Would you like to create the directory? (Y/N)"
    $response = Read-Host
    if ($response -eq 'Y') {
        New-Item -Path $newSourcePath -ItemType Directory
    } else {
        Write-Host "Exiting..."
        exit
    }
}

Write-Host "Copying files from $oldComputer to $newComputer. The folders (Desktop, Documents, Downloads, Pictures, and Videos) will be copied from"
Write-Host "the source path ($oldSourcePath) to the destination path ($newSourcePath). If everything looks correct, press Enter to continue."
Read-Host

# Copy the specified folders from the old computer to the new computer
Copy-Item -Path "$oldSourcePath\Desktop" -Destination "$newSourcePath\Desktop" -Recurse -Force
Copy-Item -Path "$oldSourcePath\Documents" -Destination "$newSourcePath\Documents" -Recurse -Force
Copy-Item -Path "$oldSourcePath\Downloads" -Destination "$newSourcePath\Downloads" -Recurse -Force
Copy-Item -Path "$oldSourcePath\Pictures" -Destination "$newSourcePath\Pictures" -Recurse -Force
Copy-Item -Path "$oldSourcePath\Videos" -Destination "$newSourcePath\Videos" -Recurse -Force

Write-Host "User files from user $username have been successfully copied from $oldComputer ($oldSourcePath) to $newComputer ($newSourcePath)."
Wrtite-Host "Transfer complete. Press Enter to exit."
Read-Host
