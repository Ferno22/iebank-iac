

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: 'afernandezstorage'
  location: 'westus3'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource appServicePlan 'Microsoft.Web/serverFarms@2022-03-01' = {
  name: 'jseijas-asp-bicep'
  location: 'westus3'
  sku: {
  name: 'F1'
  }
}
resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: 'jseijas-app-bicep'
  location: 'westus3'
  properties: {
  serverFarmId: appServicePlan.id
  httpsOnly: true
  }
}
