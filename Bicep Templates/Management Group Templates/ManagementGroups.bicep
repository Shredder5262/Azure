// Bicep Template to Deploy Management Groups Hierarchy
targetScope = 'tenant'


param globalMgName string = 'Global'
param decommissionMgName string = 'Decommission-MG'
param developmentMgName string = 'Development-MG'
param productionMgName string = 'Production-MG'
param sandboxMgName string = 'Sandbox-MG'
param testMgName string = 'Test-MG'

// Deploy Parent Management Group - Global
resource globalMg 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: globalMgName
  properties: {
    displayName: 'Global'
  }
}


// Deploy Child Management Groups under Global
resource decommissionMg 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: decommissionMgName
  properties: {
    displayName: 'Decommission Management Group'
    details:{
      parent: {
        id: globalMg.id
      }
    }
  }
}

resource developmentMg 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: developmentMgName
  properties: {
    displayName: 'Development Management Group'
    details:{
      parent: {
        id: globalMg.id
      }
    }
  }
}

resource productionMg 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: productionMgName
  properties: {
    displayName: 'Production Management Group'
    details:{
      parent: {
        id: globalMg.id
      }
    }
  }
}

resource sandboxMg 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: sandboxMgName
  properties: {
    displayName: 'Sandbox Management Group'
    details:{
    parent: {
        id: globalMg.id
      }
    }
  }
}

resource testMg 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: testMgName
  properties: {
    displayName: 'Test Management Group'
    details:{
    parent: {
        id: globalMg.id
      }
    }
  }
}
