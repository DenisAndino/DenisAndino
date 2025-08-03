<#
.SYNOPSIS
    This PowerShell script ensures that 'Turn off Microsoft consumer experiences' policy has been enabled.

.NOTES
    Author          : Denis Andino
    LinkedIn        : 
    GitHub          : https://github.com/DenisAndino
    Date Created    : 2025-07-09
    Last Modified   : 2025-07-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000197

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000197.ps1 
#>


# Define the path and value based on the Group Policy setting
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
$regName = "DisableWindowsConsumerFeatures"
$regValue = 1 # A value of 1 corresponds to "Enabled" for this policy

# Create the registry path if it doesn't already exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value to apply the policy
Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type DWord

Write-Host "✅ The 'Turn off Microsoft consumer experiences' policy has been enabled."
