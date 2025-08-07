<#
.SYNOPSIS
    This PowerShell script ensures that the convenience PIN for Windows 10 must be disabled

.NOTES
    Author          : Denis Andino
    LinkedIn        : 
    GitHub          : https://github.com/DenisAndino
    Date Created    : 2025-07-09
    Last Modified   : 2025-07-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000390

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000390.ps1 
#>

# Set the registry path and value details
$registryPath = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
$valueName = "DisableThirdPartySuggestions"
$expectedValue = 1

# Check and create the registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
    Write-Host "Registry path '$registryPath' created."
}

# Check the current value
try {
    $currentValue = (Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction Stop).$valueName
}
catch {
    $currentValue = $null
}

# Set the value if it's not already correct
if ($currentValue -ne $expectedValue) {
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $expectedValue -Type DWord -Force
    Write-Host "Successfully set '$valueName' to '$expectedValue'."
} else {
    Write-Host "The value '$valueName' is already set to '$expectedValue'."
}
