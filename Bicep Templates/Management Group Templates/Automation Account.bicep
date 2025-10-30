param workload string
param Tier string

@description('Name of the Automation Account')
param automationAccountName string = 'AA-${uniqueString(resourceGroup().id)}'

@description('Location for the Automation Account')
param location string = resourceGroup().location

@description('The SKU for the Automation Account (Free or Basic)')
@allowed([
  'Free'
  'Basic'
])
param skuName string = 'Basic'

@description('Optional tags for the Automation Account')
param tags object = {
Workload: workload
Tier: Tier
location: resourceGroup().location
}

// Resource: Automation Account
resource automationAccount 'Microsoft.Automation/automationAccounts@2023-05-15-preview' = {
  name: automationAccountName
  location: location
  sku: {
    name: skuName
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    publicNetworkAccess: false
  }
  tags: tags
}

output automationAccountId string = automationAccount.id
output automationAccountName string = automationAccount.name
