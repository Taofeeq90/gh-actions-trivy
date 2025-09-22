# Databricks Workspace Module

This module deploys an Azure Databricks Workspace.

## Requirements
- Terraform >= 1.3
- AzureRM Provider = 4.45.0

## Providers
| Name   | Version   |
|--------|-----------|
| azurerm | 4.45.0 |

## Resources
| Name | Type |
|------|------|
| azurerm_databricks_workspace | resource |

## Inputs
| Name      | Description                         | Type   | Required |
|-----------|-------------------------------------|--------|----------|
| settings  | Map of settings for the workspace. | map(any) | yes |

## Outputs
| Name | Description |
|------|-------------|
| id | The ID of the Databricks Workspace. |
| workspace_id | The unique identifier in Databricks control plane. |
| workspace_url | The workspace URL. |
| managed_resource_group_id | The ID of the managed resource group. |
| disk_encryption_set_id | The ID of the Managed Disk Encryption Set. |
| managed_disk_identity | A block containing the managed disk identity. |
| storage_account_identity | A block containing the storage account identity. |

## Supported `settings` keys
| Key | Description |
|-----|-------------|
| name | The name of the workspace. |
| resource_group_name | The name of the resource group. |
| location | Azure region. |
| sku | The SKU of the workspace (standard/premium/trial). |
| customer_managed_key_enabled | Whether to enable CMK. |
| infrastructure_encryption_enabled | Whether infra encryption is enabled. |
| public_network_access_enabled | Whether public network access is enabled. |
| network_security_group_rules_required | NSG rules requirement. |
| managed_resource_group_name | Name of the managed RG. |
| custom_parameters | Block for custom params. |
| storage_account_name | Custom storage account name. |
| vnet_address_prefix | VNet prefix (for managed VNet). |
| enhanced_security_compliance | Compliance/security configuration. |
| managed_services_cmk_key_vault_id | KV ID for managed services CMK. |
| managed_services_cmk_key_vault_key_id | Key ID for managed services CMK. |
| managed_disk_cmk_key_vault_id | KV ID for managed disk CMK. |
| managed_disk_cmk_key_vault_key_id | Key ID for managed disk CMK. |
| managed_disk_cmk_rotation_to_latest_version_enabled | Auto-rotate managed disk CMK. |
| tags | Map of tags. |


Connector

# Databricks Access Connector Module

This module deploys an Azure Databricks Access Connector.

## Requirements
- Terraform >= 1.3
- AzureRM Provider = 4.45.0

## Providers
| Name   | Version   |
|--------|-----------|
| azurerm | 4.45.0 |

## Resources
| Name | Type |
|------|------|
| azurerm_databricks_access_connector | resource |

## Inputs
| Name      | Description                             | Type   | Required |
|-----------|-----------------------------------------|--------|----------|
| settings  | Map of settings for the access connector. | map(any) | yes |

## Outputs
| Name | Description |
|------|-------------|
| id | The ID of the Databricks Access Connector. |
| identity | The identity block (principal_id, tenant_id, type). |

## Supported `settings` keys
| Key | Description |
|-----|-------------|
| name | The name of the connector. |
| resource_group_name | Resource group name. |
| location | Azure region. |
| identity | Identity block configuration. |
| tags | Map of tags. |


Peering
# Databricks Virtual Network Peering Module

This module deploys a Databricks Virtual Network Peering.

## Requirements
- Terraform >= 1.3
- AzureRM Provider = 4.45.0

## Providers
| Name   | Version   |
|--------|-----------|
| azurerm | 4.45.0 |

## Resources
| Name | Type |
|------|------|
| azurerm_databricks_virtual_network_peering | resource |

## Inputs
| Name      | Description                                   | Type   | Required |
|-----------|-----------------------------------------------|--------|----------|
| settings  | Map of settings for the virtual network peering. | map(any) | yes |

## Outputs
| Name | Description |
|------|-------------|
| id | The ID of the Databricks Virtual Network Peering. |

## Supported `settings` keys
| Key | Description |
|-----|-------------|
| name | The name of the peering. |
| resource_group_name | Resource group name. |
| workspace_id | ID of the Databricks workspace. |
| remote_virtual_network_id | ID of the remote VNet. |
| allow_virtual_network_access | Whether VNet access is allowed. |
| allow_forwarded_traffic | Whether forwarded traffic is allowed. |
| allow_gateway_transit | Whether gateway transit is allowed. |
| use_remote_gateways | Whether remote gateways are used. |


Custom

# Databricks Workspace Root DBFS Customer Managed Key Module

This module deploys a Databricks Workspace Root DBFS Customer Managed Key.

## Requirements
- Terraform >= 1.3
- AzureRM Provider = 4.45.0

## Providers
| Name   | Version   |
|--------|-----------|
| azurerm | 4.45.0 |

## Resources
| Name | Type |
|------|------|
| azurerm_databricks_workspace_root_dbfs_customer_managed_key | resource |

## Inputs
| Name      | Description                                    | Type   | Required |
|-----------|------------------------------------------------|--------|----------|
| settings  | Map of settings for DBFS CMK configuration.     | map(any) | yes |

## Outputs
| Name | Description |
|------|-------------|
| id | The ID of the DBFS Customer Managed Key resource. |

## Supported `settings` keys
| Key | Description |
|-----|-------------|
| workspace_id | ID of the Databricks Workspace. |
| key_vault_id | ID of the Key Vault hosting the key. |
| key_name | The name of the key. |
| key_version | Version of the key. |
