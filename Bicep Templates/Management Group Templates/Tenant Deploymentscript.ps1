


Connect-AzAccount -Tenant '1f6e2dff-78cb-428b-a93a-293c68d7bfcf'


New-AzTenantDeployment -Location eastus -TemplateFile 'Bicep Templates\Management Group Templates\ManagementGroups.bicep' -whatif


#sign in to Azure from Powershell, this will redirect you to a webbrowser for authentication, if required
Connect-AzAccount

#get object Id of the current user (that is used above)
$user = "asutcliffe25_outlook.com#EXT#@asutcliffe25outlook.onmicrosoft.com"


#assign Owner role at Tenant root scope ("/") as a User Access Administrator to current user
New-AzRoleAssignment -Scope '/' -RoleDefinitionName 'Owner' -ObjectId d352bac1-71b6-4e29-b26f-4d1b793d1f75

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