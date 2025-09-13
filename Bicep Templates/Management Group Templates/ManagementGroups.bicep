#################################################################################
# Written By: Andrew Sutcliffe                                                  #
# Company: [company name]                                                       #
#                                                                               #
# Description: Bicep template to deploy a DTAP Management Group hierarchy,      #
#              including groups for decommissioned subscriptions and            #
#              administrative subscriptions. All groups are suffixed with -MG.  #
#                                                                               #
# Notes: Ensure you have tenant-level permissions to deploy management groups.  #
#                                                                               #
# Environment: Tenant Scope                                                     #
# Last updated By: Andrew Sutcliffe                                             #
# Script Version: 1.0                                                           #
#################################################################################

#Static Variables
targetScope = 'tenant'

######################################################################################
######################################################################################
#Authentication
# (Handled by the deployment context when running the Bicep file)
######################################################################################
######################################################################################

# Root Management Group
resource rootMgmtGroup 'Microsoft.Management/managementGroups@2020-05-01' = {
  name: 'contoso-root-MG'
  properties: {
    displayName: 'Contoso Root - MG'
  }
}

######################################################################################
######################################################################################
# DTAP Management Groups
######################################################################################
######################################################################################

resource devMgmtGroup 'Microsoft.Management/managementGroups@2020-05-01' = {
  name: 'contoso-dev-MG'
  properties: {
    displayName: 'Development - MG'
    parent: {
      id: rootMgmtGroup.id
    }
  }
}

resource testMgmtGroup 'Microsoft.Management/managementGroups@2020-05-01' = {
  name: 'contoso-test-MG'
  properties: {
    displayName: 'Test - MG'
    parent: {
      id: rootMgmtGroup.id
    }
  }
}

resource accMgmtGroup 'Microsoft.Management/managementGroups@2020-05-01' = {
  name: 'contoso-acc-MG'
  properties: {
    displayName: 'Acceptance - MG'
    parent: {
      id: rootMgmtGroup.id
    }
  }
}

resource prodMgmtGroup 'Microsoft.Management/managementGroups@2020-05-01' = {
  name: 'contoso-prod-MG'
  properties: {
    displayName: 'Production - MG'
    parent: {
      id: rootMgmtGroup.id
    }
  }
}

######################################################################################
######################################################################################
# Decommissioned Subscriptions Group
######################################################################################
######################################################################################

resource decommMgmtGroup 'Microsoft.Management/managementGroups@2020-05-01' = {
  name: 'contoso-decom-MG'
  properties: {
    displayName: 'Decommissioned - MG'
    parent: {
      id: rootMgmtGroup.id
    }
  }
}

######################################################################################
######################################################################################
# Administrative Subscriptions Group
######################################################################################
######################################################################################

resource adminMgmtGroup 'Microsoft.Management/managementGroups@2020-05-01' = {
  name: 'contoso-admin-MG'
  properties: {
    displayName: 'Administration - MG'
    parent: {
      id: rootMgmtGroup.id
    }
  }
}
