<#
.SYNOPSIS
    This PowerShell script ensures that the built in guest account is renamed.

.NOTES
    Author          : Denis Andino
    LinkedIn        : 
    GitHub          : https://github.com/DenisAndino
    Date Created    : 2025-07-09
    Last Modified   : 2025-07-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000025

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-SO-000025.ps1 
#>

# --- IMPORTANT ---
# Set the desired new name for the Guest account below.
# Replace "StigCompliantGuest" with the name required by your organization's policy.
$newName = "OnePieceUser"
$oldName = "Guest"

try {
    # First, check if an account with the default name "Guest" exists.
    # The -ErrorAction Stop will trigger the catch block if the user isn't found.
    Get-LocalUser -Name $oldName -ErrorAction Stop

    # If the script gets here, the "Guest" account was found. Now, rename it.
    Rename-LocalUser -Name $oldName -NewName $newName
    Write-Host "✅ Remediation applied successfully." -ForegroundColor Green
    Write-Host "The '$oldName' account has been renamed to '$newName'."
}
catch {
    # This block runs if the Get-LocalUser command fails.
    if ($_.Exception.Message -like "*Principal $oldName was not found*") {
        # This is the expected outcome if the account was already renamed.
        Write-Host "🟡 Account named 'Guest' was not found. It may have already been renamed, which is compliant." -ForegroundColor Yellow
    }
    else {
        # This catches other potential errors, such as permissions issues.
        Write-Host "❌ An error occurred. Please ensure you are running PowerShell as an Administrator." -ForegroundColor Red
        Write-Host "Error details: $($_.Exception.Message)"
    }
}
