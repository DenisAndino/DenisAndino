<#
.SYNOPSIS
    This PowerShell script ensures that Users must be prompted for a password on resume from sleep (on battery)

.NOTES
    Author          : Denis Andino
    LinkedIn        : 
    GitHub          : https://github.com/DenisAndino
    Date Created    : 2025-07-09
    Last Modified   : 2025-07-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000145

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000145.ps1 
#>


# Define registry path and value details
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51"
$regName = "DCSettingIndex"
$regValue = 1

try {
    # Check if the registry key path exists. If not, create it.
    if (-not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
        Write-Host "Registry path created: $regPath" -ForegroundColor Yellow
    }

    # Set the registry value to enable the policy
    Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type DWord -Force

    Write-Host "✅ Remediation applied successfully." -ForegroundColor Green
    Write-Host "Policy 'Require a password when a computer wakes (on battery)' is now enabled."
}
catch {
    Write-Host "❌ An error occurred. Please ensure you are running PowerShell as an Administrator." -ForegroundColor Red
    Write-Host "Error details: $($_.Exception.Message)"
}
