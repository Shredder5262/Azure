@description('Name of the Storage Account. Must be globally unique, 3-24 lowercase alphanumeric.')
param storageAccountName string

@description('Region for the Storage Account.')
param location string = resourceGroup().location

@description('SKU / performance tier.')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
])
param skuName string = 'Standard_LRS'

@description('Storage Account kind.')
@allowed([
  'StorageV2' // general purpose v2 (recommended)
  'Storage'
  'BlobStorage'
  'FileStorage'
  'BlockBlobStorage'
])
param kind string = 'StorageV2'

@description('Allow public blob container access? (false is more secure).')
param allowBlobPublicAccess bool = false

@description('Enable hierarchical namespace for Data Lake Gen2 features (cannot be changed later).')
param isHnsEnabled bool = false

@description('Minimum TLS version to allow for incoming requests.')
@allowed([
  'TLS1_0'
  'TLS1_1'
  'TLS1_2'
])
param minimumTlsVersion string = 'TLS1_2'

@description('Tags to apply to the storage account.')
param tags object = {
  Owner: ''
  billingowner:''
  CostCenter:''
  datasensitivity:''
  application:''
  environment: 'test'
  Workload: workload
  Tier: Tier
  location: resourceGroup().location
}

resource stg 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: skuName
  }
  kind: kind
  tags: tags
  properties: {
    allowBlobPublicAccess: allowBlobPublicAccess
    minimumTlsVersion: minimumTlsVersion
    allowSharedKeyAccess: true
    supportsHttpsTrafficOnly: true

    encryption: {
      services: {
        blob: {
          enabled: true
        }
        file: {
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }

    // Data Lake Gen2
    isHnsEnabled: isHnsEnabled

    // Soft delete / retention policies
    deleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }

    // Default network rules (open to all - lock this down in prod)
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
    }

    accessTier: (kind == 'StorageV2' || kind == 'BlobStorage') ? 'Hot' : null
  }
}

@description('Storage Account resource ID output')
output storageAccountId string = stg.id

@description('Primary blob endpoint output')
output blobEndpoint string = stg.properties.primaryEndpoints.blob
