################################################################################
##  File:  Validate-AzureModules.ps1
##  Team:  ReleaseManagement
##  Desc:  Validate Azure PowerShell modules
################################################################################

$env:PSModulePath = $env:PSModulePath + ";C:\Modules"

$azureModules = Get-Module -Name Azure -ListAvailable | Select-Object Name,Version,Path | Format-Table | Out-String

Write-Host "The Azure Modules finally present are:"
$azureModules

if( ($azureModules -match "2.1.0") -and ($azureModules -match "3.8.0") -and ($azureModules -match "4.2.1") -and ($azureModules -match "5.0.0"))
{
    Write-Host "Required Azure modules are present"
}
else {
    Write-Host "One or more required Azure modules are not present"
    throw "One or more required Azure modules are not present."
}


$azureRMModules = Get-Module -Name AzureRM -ListAvailable | Select-Object Name,Version,Path | Format-Table | Out-String

Write-Host "The AzureRM Modules finally present are:"
$azureRMModules

if( ($azureRMModules -match "2.1.0") -and ($azureRMModules -match "3.8.0") -and ($azureRMModules -match "4.2.1") -and ($azureRMModules -match "5.0.0"))
{
    Write-Host "Required AzureRM modules are present"

}
else {
    Write-Host "One or more required AzureRM modules are not present"
    throw "One or more required AzureRM modules are not present."
}

