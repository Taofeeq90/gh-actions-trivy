provider "azurerm" {
  features {}
}

# Example locals with multiple subscriptions
locals {
  sub_ex = {
    sub1 = {
      scope        = "/subscriptions/11111111-1111-1111-1111-111111111111"
      principal_id = "00000000-0000-0000-0000-000000000001"
    }
    sub2 = {
      scope        = "/subscriptions/22222222-2222-2222-2222-222222222222"
      principal_id = "00000000-0000-0000-0000-000000000002"
    }
  }
}

# -----------------------------
# 1. Role Assignment (Built-in Owner role)
# -----------------------------
resource "azurerm_role_assignment" "owner_assignment" {
  for_each = local.sub_ex

  scope                = each.value.scope
  role_definition_name = "Owner" # <-- Built-in Owner
  principal_id         = each.value.principal_id
}

# -----------------------------
# 2. Policy definition (deny role assignments to Users/Groups)
# -----------------------------
resource "azurerm_policy_definition" "deny_user_group_rbac" {
  name         = "deny-user-group-role-assignments"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Deny role assignments to Users and Groups"

  policy_rule = <<POLICY
{
  "if": {
    "allOf": [
      {
        "field": "type",
        "equals": "Microsoft.Authorization/roleAssignments"
      },
      {
        "anyOf": [
          {
            "field": "Microsoft.Authorization/roleAssignments/principalType",
            "equals": "User"
          },
          {
            "field": "Microsoft.Authorization/roleAssignments/principalType",
            "equals": "Group"
          }
        ]
      }
    ]
  },
  "then": {
    "effect": "deny"
  }
}
POLICY
}

# -----------------------------
# 3. Assign Policy at each subscription
# -----------------------------
resource "azurerm_policy_assignment" "deny_user_group_rbac_assignment" {
  for_each = local.sub_ex

  name                 = "deny-user-group-role-assignments-${each.key}"
  scope                = each.value.scope
  policy_definition_id = azurerm_policy_definition.deny_user_group_rbac.id
}
