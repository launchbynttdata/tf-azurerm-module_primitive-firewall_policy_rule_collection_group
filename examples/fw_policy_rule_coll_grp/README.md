# tf-azurerm-module_primitive-firewall_policy_rule_collection_group

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.77 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_firewall_policy"></a> [firewall\_policy](#module\_firewall\_policy) | terraform.registry.launch.nttdata.com/module_primitive/firewall_policy/azurerm | ~> 1.0 |
| <a name="module_firewall_policy_rule_collection_group"></a> [firewall\_policy\_rule\_collection\_group](#module\_firewall\_policy\_rule\_collection\_group) | ../.. | n/a |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm | ~> 1.0 |
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 2.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_rule_collection"></a> [application\_rule\_collection](#input\_application\_rule\_collection) | The Application Rule Collection to use in this Firewall Policy Rule Collection Group. | <pre>list(object({<br/>    name     = string<br/>    action   = string<br/>    priority = number<br/>    rule = list(object({<br/>      name        = string<br/>      description = optional(string)<br/>      protocols = optional(list(object({<br/>        type = string<br/>        port = number<br/>      })))<br/>      http_headers = optional(list(object({<br/>        name  = string<br/>        value = string<br/>      })))<br/>      source_addresses      = optional(list(string))<br/>      source_ip_groups      = optional(list(string))<br/>      destination_addresses = optional(list(string))<br/>      destination_urls      = optional(list(string))<br/>      destination_fqdns     = optional(list(string))<br/>      destination_fqdn_tags = optional(list(string))<br/>      terminate_tls         = optional(bool)<br/>      web_categories        = optional(list(string))<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | Environment where resource is going to be deployed. | `string` | `"demo"` | no |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `0` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region to use | `string` | n/a | yes |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | Name of the product family for which the resource is created. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | Name of the product service for which the resource is created. | `string` | `"fwplcyrcoll"` | no |
| <a name="input_nat_rule_collection"></a> [nat\_rule\_collection](#input\_nat\_rule\_collection) | The NAT Rule Collection to use in this Firewall Policy Rule Collection Group. | <pre>list(object({<br/>    name     = string<br/>    action   = string<br/>    priority = number<br/>    rule = list(object({<br/>      name                = string<br/>      description         = optional(string)<br/>      protocols           = list(string)<br/>      source_addresses    = optional(list(string))<br/>      source_ip_groups    = optional(list(string))<br/>      destination_ports   = optional(list(string))<br/>      destination_address = optional(string)<br/>      translated_address  = optional(string)<br/>      translated_port     = number<br/>      translated_fqdn     = optional(string)<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_network_rule_collection"></a> [network\_rule\_collection](#input\_network\_rule\_collection) | The Network Rule Collection to use in this Firewall Policy Rule Collection Group. | <pre>list(object({<br/>    name     = string<br/>    action   = string<br/>    priority = number<br/>    rule = list(object({<br/>      name                  = string<br/>      description           = optional(string)<br/>      protocols             = list(string)<br/>      destination_ports     = list(string)<br/>      source_addresses      = optional(list(string))<br/>      source_ip_groups      = optional(list(string))<br/>      destination_addresses = optional(list(string))<br/>      destination_fqdns     = optional(list(string))<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | The priority of the Firewall Policy Rule Collection Group. The range is 100-65000. | `number` | n/a | yes |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br/>    name       = string<br/>    max_length = optional(number, 60)<br/>  }))</pre> | <pre>{<br/>  "firewall_policy": {<br/>    "max_length": 80,<br/>    "name": "fwpolicy"<br/>  },<br/>  "fw_plcy_rule_colln_grp": {<br/>    "max_length": 80,<br/>    "name": "fwplcyrulecollngrp"<br/>  },<br/>  "resource_group": {<br/>    "max_length": 80,<br/>    "name": "rg"<br/>  }<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall_ids"></a> [firewall\_ids](#output\_firewall\_ids) | Placeholder map used by terratest to drive post-deploy assertions |
| <a name="output_firewall_names"></a> [firewall\_names](#output\_firewall\_names) | Firewall policy name associated with the rule collection group |
| <a name="output_policy_name"></a> [policy\_name](#output\_policy\_name) | Firewall policy name |
| <a name="output_policy_rule_collection_group_id"></a> [policy\_rule\_collection\_group\_id](#output\_policy\_rule\_collection\_group\_id) | The ID of the firewall policy rule collection group |
| <a name="output_policy_rule_collection_group_name"></a> [policy\_rule\_collection\_group\_name](#output\_policy\_rule\_collection\_group\_name) | Firewall policy rule collection group name |
| <a name="output_private_ip_addresses"></a> [private\_ip\_addresses](#output\_private\_ip\_addresses) | Firewall private IP |
| <a name="output_public_ip_addresses"></a> [public\_ip\_addresses](#output\_public\_ip\_addresses) | Firewall public IP |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Resource group name |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | ID of the subnet attached to the firewall |
<!-- END_TF_DOCS -->
