<#
.SYNOPSIS 
    This PowerShell script prevents printing on HTTP

.NOTES
    Author          : Denis Andino
    LinkedIn        : 
    GitHub          : https://github.com/DenisAndino
    Date Created    : 2025-07-09
    Last Modified   : 2025-07-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000110

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000110.ps1 
#>

# Define the registry path and value based on the STIG
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$regName = "DisableHTTPPrinting"
$regValue = 1 # A value of 1 corresponds to "Enabled" for this policy

# Create the registry path if it does not exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value to disable printing over HTTP
Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type DWord

Write-Host "✅ Printing over HTTP has been disabled."
