


Connect-AzAccount -Tenant ''


New-AzTenantDeployment -Location eastus -TemplateFile 'Bicep Templates\Management Group Templates\ManagementGroups.bicep' -whatif


#sign in to Azure from Powershell, this will redirect you to a webbrowser for authentication, if required
Connect-AzAccount

#get object Id of the current user (that is used above)
$user = ""


#assign Owner role at Tenant root scope ("/") as a User Access Administrator to current user
New-AzRoleAssignment -Scope '/' -RoleDefinitionName 'Owner' -ObjectId 

#(optional) assign Owner role at Tenant root scope ("/") as a User Access Administrator to service principal (set $spndisplayname to your service principal displayname)
$spndisplayname = "<ServicePrincipal DisplayName>"
$spn = (Get-AzADServicePrincipal -DisplayName $spndisplayname).id
New-AzRoleAssignment -Scope '/' -RoleDefinitionName 'Owner' -ObjectId $spn


Connect-AzAccount
$user = Get-AzADUser -SignedIn

New-AzRoleAssignment -Scope '/' -RoleDefinitionName 'Owner' -ObjectId $user.Id

$spnAppId = "Deploymentaccount"
$spn = Get-AzADServicePrincipal -DisplayName $spnAppId

New-AzRoleAssignment -Scope '/' -RoleDefinitionName 'Owner' -ObjectId $spn