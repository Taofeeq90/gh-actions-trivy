
## databricks_workspace
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.45.0"
    }
  }
}

resource "azurerm_databricks_workspace" "this" {
  name                = var.settings.name
  resource_group_name = var.settings.resource_group_name
  location            = var.settings.location
  sku                 = var.settings.sku

  managed_resource_group_name        = try(var.settings.managed_resource_group_name, null)
  access_connector_id                = try(var.settings.access_connector_id, null)
  customer_managed_key_enabled       = try(var.settings.customer_managed_key_enabled, null)
  default_storage_firewall_enabled   = try(var.settings.default_storage_firewall_enabled, null)
  infrastructure_encryption_enabled  = try(var.settings.infrastructure_encryption_enabled, null)
  network_security_group_rules_required = try(var.settings.network_security_group_rules_required, null)
  public_network_access_enabled      = try(var.settings.public_network_access_enabled, null)

  # Customer Managed Keys (CMK)
  managed_services_cmk_key_vault_id                 = try(var.settings.managed_services_cmk_key_vault_id, null)
  managed_services_cmk_key_vault_key_id             = try(var.settings.managed_services_cmk_key_vault_key_id, null)
  managed_disk_cmk_key_vault_id                     = try(var.settings.managed_disk_cmk_key_vault_id, null)
  managed_disk_cmk_key_vault_key_id                 = try(var.settings.managed_disk_cmk_key_vault_key_id, null)
  managed_disk_cmk_rotation_to_latest_version_enabled = try(var.settings.managed_disk_cmk_rotation_to_latest_version_enabled, null)

  custom_parameters {
    storage_account_name  = try(var.settings.custom_parameters.storage_account_name, null)
    public_subnet_name    = try(var.settings.custom_parameters.public_subnet_name, null)
    private_subnet_name   = try(var.settings.custom_parameters.private_subnet_name, null)
    virtual_network_id    = try(var.settings.custom_parameters.virtual_network_id, null)
    vnet_address_prefix   = try(var.settings.custom_parameters.vnet_address_prefix, null)
    public_subnet_network_security_group_association_id  = try(var.settings.custom_parameters.public_subnet_network_security_group_association_id, null)
    private_subnet_network_security_group_association_id = try(var.settings.custom_parameters.private_subnet_network_security_group_association_id, null)
    no_public_ip          = try(var.settings.custom_parameters.no_public_ip, null)
    nat_gateway_name      = try(var.settings.custom_parameters.nat_gateway_name, null)
  }

  enhanced_security_compliance {
    automatic_cluster_update_enabled      = try(var.settings.enhanced_security_compliance.automatic_cluster_update_enabled, null)
    compliance_security_profile_enabled   = try(var.settings.enhanced_security_compliance.compliance_security_profile_enabled, null)
    compliance_security_profile_standards = try(var.settings.enhanced_security_compliance.compliance_security_profile_standards, null)
    enhanced_security_monitoring_enabled  = try(var.settings.enhanced_security_compliance.enhanced_security_monitoring_enabled, null)
  }

  timeouts {
    create = try(var.settings.timeouts.create, "30m")
    read   = try(var.settings.timeouts.read, "5m")
    update = try(var.settings.timeouts.update, "30m")
    delete = try(var.settings.timeouts.delete, "30m")
  }

  tags = try(var.settings.tags, null)
}


variable "settings" {
  description = "Configuration settings for the Databricks Workspace."
  type        = any
}

output "id" {
  description = "The ID of the Databricks Workspace in the Azure management plane."
  value       = azurerm_databricks_workspace.this.id
}

output "disk_encryption_set_id" {
  description = "The ID of Managed Disk Encryption Set created by the Databricks Workspace."
  value       = azurerm_databricks_workspace.this.disk_encryption_set_id
}

output "managed_disk_identity" {
  description = "The managed disk identity block (principal_id, tenant_id, type)."
  value       = azurerm_databricks_workspace.this.managed_disk_identity
}

output "managed_resource_group_id" {
  description = "The ID of the Managed Resource Group created by the Databricks Workspace."
  value       = azurerm_databricks_workspace.this.managed_resource_group_id
}

output "workspace_url" {
  description = "The workspace URL."
  value       = azurerm_databricks_workspace.this.workspace_url
}

output "workspace_id" {
  description = "The unique identifier of the Databricks workspace in the control plane."
  value       = azurerm_databricks_workspace.this.workspace_id
}

output "storage_account_identity" {
  description = "The storage account identity block (principal_id, tenant_id, type)."
  value       = azurerm_databricks_workspace.this.storage_account_identity
}


## databricks_access_connector

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.45.0"
    }
  }
}

resource "azurerm_databricks_access_connector" "this" {
  name                = var.settings.name
  resource_group_name = var.settings.resource_group_name
  location            = var.settings.location

  identity {
    type         = var.settings.identity.type
    identity_ids = try(var.settings.identity.identity_ids, null)
  }

  tags = try(var.settings.tags, null)
}


variable "settings" {
  description = "Configuration settings for the Databricks Access Connector."
  type        = any
}


output "id" {
  description = "The ID of the Databricks Access Connector."
  value       = azurerm_databricks_access_connector.this.id
}

output "principal_id" {
  description = "The principal ID of the managed identity associated with the access connector."
  value       = azurerm_databricks_access_connector.this.identity[0].principal_id
}

output "tenant_id" {
  description = "The tenant ID of the managed identity associated with the access connector."
  value       = azurerm_databricks_access_connector.this.identity[0].tenant_id
}

output "type" {
  description = "The type of managed identity."
  value       = azurerm_databricks_access_connector.this.identity[0].type
}


## databricks_virtual_network_peering
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.45.0"
    }
  }
}

resource "azurerm_databricks_virtual_network_peering" "this" {
  name                       = var.settings.name
  resource_group_name        = var.settings.resource_group_name
  workspace_id               = var.settings.workspace_id
  remote_virtual_network_id  = var.settings.remote_virtual_network_id

  allow_virtual_network_access = try(var.settings.allow_virtual_network_access, null)
  allow_forwarded_traffic      = try(var.settings.allow_forwarded_traffic, null)
  allow_gateway_transit        = try(var.settings.allow_gateway_transit, null)
  use_remote_gateways          = try(var.settings.use_remote_gateways, null)
}

variable "settings" {
  description = "Configuration settings for the Databricks Virtual Network Peering."
  type        = any
}

output "id" {
  description = "The ID of the Databricks VNet Peering."
  value       = azurerm_databricks_virtual_network_peering.this.id
}

## databricks_workspace_root_dbfs_customer_managed_key

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.45.0"
    }
  }
}

resource "azurerm_databricks_workspace_root_dbfs_customer_managed_key" "this" {
  workspace_id     = var.settings.workspace_id
  key_vault_key_id = var.settings.key_vault_key_id
}


variable "settings" {
  description = "Configuration settings for the Workspace Root DBFS Customer Managed Key."
  type        = any
}

output "id" {
  description = "The ID of the Workspace Root DBFS Customer Managed Key."
  value       = azurerm_databricks_workspace_root_dbfs_customer_managed_key.this.id
}

output "workspace_id" {
  description = "The workspace ID this CMK belongs to."
  value       = azurerm_databricks_workspace_root_dbfs_customer_managed_key.this.workspace_id
}

output "key_vault_key_id" {
  description = "The Key Vault Key ID used for encryption."
  value       = azurerm_databricks_workspace_root_dbfs_customer_managed_key.this.key_vault_key_id
}
