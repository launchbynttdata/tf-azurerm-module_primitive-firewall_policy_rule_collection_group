// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module "firewall_policy_rule_collection_group" {
  source = "../.."

  name                        = local.firewall_policy_rule_collection_group_name
  firewall_policy_id          = module.firewall_policy.id
  priority                    = var.priority
  application_rule_collection = var.application_rule_collection
  network_rule_collection     = var.network_rule_collection
  nat_rule_collection         = var.nat_rule_collection
}

module "firewall_policy" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/firewall_policy/azurerm"
  version = "~> 1.0"

  name                = local.firewall_policy_name
  resource_group_name = module.resource_group.name
  location            = var.location

  depends_on = [module.resource_group]
}

module "resource_group" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm"
  version = "~> 1.0"

  name     = local.resource_group
  location = var.location
  tags = {
    resource_name = local.resource_group
  }
}

module "public_ip" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/public_ip/azurerm"
  version = "~> 2.0"

  name                = local.public_ip_custom_name
  resource_group_name = local.resource_group
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = local.tags

  depends_on = [module.resource_group]
}

module "network" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/virtual_network/azurerm"
  version = "~> 3.2"

  resource_group_name = local.resource_group
  vnet_name           = local.virtual_network_name
  vnet_location       = var.location
  address_space       = var.address_space

  subnets = {
    AzureFirewallSubnet           = { prefix = cidrsubnet(var.address_space[0], 10, 0) }
    AzureFirewallManagementSubnet = { prefix = cidrsubnet(var.address_space[0], 10, 1) }
  }

  tags = local.tags

  depends_on = [module.resource_group]
}

module "firewall" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/firewall/azurerm"
  version = "~> 2.0"

  name                = local.firewall_name
  resource_group_name = local.resource_group
  location            = var.location
  sku_tier            = var.sku_tier
  firewall_policy_id  = module.firewall_policy.id

  ip_configuration = [{
    name                 = "Data"
    subnet_id            = module.network.subnet_name_id_map["AzureFirewallSubnet"]
    public_ip_address_id = null
  }]

  management_ip_configuration = {
    name                 = "Management"
    subnet_id            = module.network.subnet_name_id_map["AzureFirewallManagementSubnet"]
    public_ip_address_id = module.public_ip.id
  }

  tags = local.tags

  depends_on = [module.resource_group, module.network, module.firewall_policy, module.public_ip]
}

# This module generates the resource-name of resources based on resource_type, naming_prefix, env etc.
module "resource_names" {
  source  = "terraform.registry.launch.nttdata.com/module_library/resource_name/launch"
  version = "~> 2.0"

  for_each = var.resource_names_map

  region                  = join("", split("-", var.location))
  class_env               = var.class_env
  cloud_resource_type     = each.value.name
  instance_env            = var.instance_env
  instance_resource       = var.instance_resource
  maximum_length          = each.value.max_length
  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
}
