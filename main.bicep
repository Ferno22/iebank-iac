@sys.description('The Web App name.')
@minLength(3)
@maxLength(24)
param appServiceAppName string = 'aferandez-app-bicep'
@sys.description('The App Service Plan name.')
@minLength(3)
@maxLength(24)
param appServicePlanName string = 'aferandez-app-bicep'
@sys.description('The Storage Account name.')
@minLength(3)
@maxLength(24)
param storageAccountName string = 'aferandezstorage'
@allowed([
  'nonprod'
  'prod'
  ])
  param environmentType string = 'nonprod'
  param location string = resourceGroup().location

  var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
  var appServicePlanSkuName = (environmentType == 'prod') ? 'P2V3' : 'F1'


resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

module appService 'modules/appStuff.bicep' = {
  name: 'appService'
  params: {
    location: location
    appServiceAppName: appServiceAppName
    appServicePlanName: appServicePlanName
    environmentType: environmentType
  }
  }
  output appServiceAppHostName string = appService.outputs.appServiceAppHostName
