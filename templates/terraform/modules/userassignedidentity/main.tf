data "azurerm_container_registry" "containerregistry" {
    name                = var.ContainerRegistryName
    resource_group_name = var.ResourceGroupName
}

resource "azurerm_user_assigned_identity" "appidentity" {
  location            = var.ResourceLocation
  name                = var.AppIdentityName
  resource_group_name = var.ResourceGroupName
}

# Set the container app permissions to the container registry
resource "azurerm_role_assignment" "container_app_role_assignment_reader" {

  scope                = data.azurerm_container_registry.containerregistry.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.appidentity.principal_id
}

resource "azurerm_role_assignment" "container_app_role_assignment_acrpull" {

  scope                = data.azurerm_container_registry.containerregistry.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.appidentity.principal_id
}