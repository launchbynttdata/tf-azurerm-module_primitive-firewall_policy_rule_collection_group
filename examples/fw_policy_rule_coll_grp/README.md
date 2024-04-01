# tf-azurerm-module_primitive-firewall_policy_rule_collection_group

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | <= 1.5.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.77 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_firewall"></a> [firewall](#module\_firewall) | git::https://github.com/launchbynttdata/tf-azurerm-module_primitive-firewall.git | 1.0.0 |
| <a name="module_firewall_policy"></a> [firewall\_policy](#module\_firewall\_policy) | git::https://github.com/launchbynttdata/tf-azurerm-module_primitive-firewall_policy.git | 1.0.0 |
| <a name="module_firewall_policy_rule_collection_group"></a> [firewall\_policy\_rule\_collection\_group](#module\_firewall\_policy\_rule\_collection\_group) | ../.. | n/a |
| <a name="module_network"></a> [network](#module\_network) | git::https://github.com/launchbynttdata/tf-azurerm-module_collection-virtual_network.git | 1.0.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | git::https://github.com/launchbynttdata/tf-azurerm-module_primitive-resource_group.git | 1.0.0 |
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | git::https://github.com/launchbynttdata/tf-launch-module_library-resource_name.git | 1.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br>    name       = string<br>    max_length = optional(number, 60)<br>  }))</pre> | <pre>{<br>  "firewall": {<br>    "max_length": 80,<br>    "name": "fw"<br>  },<br>  "firewall_policy": {<br>    "max_length": 80,<br>    "name": "fwpolicy"<br>  },<br>  "fw_plcy_rule_colln_grp": {<br>    "max_length": 80,<br>    "name": "fwplcyrulecollngrp"<br>  },<br>  "hub_vnet": {<br>    "max_length": 80,<br>    "name": "hubvnet"<br>  },<br>  "hub_vnet_ip_configuration": {<br>    "max_length": 80,<br>    "name": "ipconfig"<br>  },<br>  "public_ip": {<br>    "max_length": 80,<br>    "name": "pip"<br>  },<br>  "resource_group": {<br>    "max_length": 80,<br>    "name": "rg"<br>  }<br>}</pre> | no |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `0` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"network"` | no |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | (Required) Environment where resource is going to be deployed. For example. dev, qa, uat | `string` | `"dev"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region to use | `string` | n/a | yes |
| <a name="input_logs_destinations_ids"></a> [logs\_destinations\_ids](#input\_logs\_destinations\_ids) | List of destination resources IDs for logs diagnostic destination. Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set. If you want to specify an Azure EventHub to send logs and metrics to, you need to provide a formated string with both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the `|` character. | `list(string)` | `[]` | no |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr) | The address prefix to use for the firewall's subnet | `string` | n/a | yes |
| <a name="input_additional_public_ips"></a> [additional\_public\_ips](#input\_additional\_public\_ips) | List of additional public ips' ids to attach to the firewall. | <pre>list(object(<br>    {<br>      name                 = string,<br>      public_ip_address_id = string<br>  }))</pre> | `[]` | no |
| <a name="input_application_rule_collections"></a> [application\_rule\_collections](#input\_application\_rule\_collections) | Create an application rule collection | <pre>list(object(<br>    {<br>      name     = string,<br>      priority = number,<br>      action   = string,<br>      rules = list(object(<br>        { name             = string,<br>          source_addresses = list(string),<br>          source_ip_groups = list(string),<br>          target_fqdns     = list(string),<br>          protocols = list(object(<br>            { port = string,<br>          type = string }))<br>        }<br>      ))<br>  }))</pre> | `null` | no |
| <a name="input_custom_diagnostic_settings_name"></a> [custom\_diagnostic\_settings\_name](#input\_custom\_diagnostic\_settings\_name) | Custom name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add | `map(string)` | `{}` | no |
| <a name="input_firewall_private_ip_ranges"></a> [firewall\_private\_ip\_ranges](#input\_firewall\_private\_ip\_ranges) | A list of SNAT private CIDR IP ranges, or the special string `IANAPrivateRanges`, which indicates Azure Firewall does not SNAT when the destination IP address is a private range per IANA RFC 1918. | `list(string)` | <pre>[<br>  "IANAPrivateRanges"<br>]</pre> | no |
| <a name="input_network_rule_collections"></a> [network\_rule\_collections](#input\_network\_rule\_collections) | Create a network rule collection | <pre>list(object({<br>    name     = string,<br>    priority = number,<br>    action   = string,<br>    rules = list(object({<br>      name                  = string,<br>      source_addresses      = list(string),<br>      source_ip_groups      = optional(list(string)),<br>      destination_ports     = list(string),<br>      destination_addresses = list(string),<br>      destination_ip_groups = optional(list(string)),<br>      destination_fqdns     = optional(list(string)),<br>      protocols             = list(string)<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_public_ip_zones"></a> [public\_ip\_zones](#input\_public\_ip\_zones) | (Optional)Public IP zones to configure. | `list(number)` | <pre>[<br>  1,<br>  2,<br>  3<br>]</pre> | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | SKU tier of the Firewall. Possible values are `Premium` and `Standard` | `string` | `"Standard"` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | (Optional)Specifies a list of Availability Zones in which this Azure Firewall should be located. Changing this forces a new Azure Firewall to be created. | `list(number)` | `null` | no |
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | The address space that is used the virtual network. | `list(string)` | n/a | yes |
| <a name="input_subnet_prefixes"></a> [subnet\_prefixes](#input\_subnet\_prefixes) | The address prefixes to use for the subnet. | `list(string)` | n/a | yes |
| <a name="input_bgp_community"></a> [bgp\_community](#input\_bgp\_community) | The BGP community to use for the virtual network. | `string` | `null` | no |
| <a name="input_ddos_protection_plan"></a> [ddos\_protection\_plan](#input\_ddos\_protection\_plan) | The DDoS protection plan to associate with the virtual network. | <pre>object(<br>    {<br>      enable = bool<br>      id     = string<br>    }<br>  )</pre> | `null` | no |
| <a name="input_nsg_ids"></a> [nsg\_ids](#input\_nsg\_ids) | The IDs of the network security groups to associate with the subnet. | `map(string)` | `{}` | no |
| <a name="input_route_tables_ids"></a> [route\_tables\_ids](#input\_route\_tables\_ids) | The IDs of the route tables to associate with the subnet. | `map(string)` | `{}` | no |
| <a name="input_subnet_delegation"></a> [subnet\_delegation](#input\_subnet\_delegation) | The subnet delegation to associate with the subnet. | `map(map(any))` | `{}` | no |
| <a name="input_subnet_enforce_private_link_endpoint_network_policies"></a> [subnet\_enforce\_private\_link\_endpoint\_network\_policies](#input\_subnet\_enforce\_private\_link\_endpoint\_network\_policies) | Controls if private link endpoint network policies should be enforced on the subnet. | `map(bool)` | `{}` | no |
| <a name="input_subnet_enforce_private_link_service_network_policies"></a> [subnet\_enforce\_private\_link\_service\_network\_policies](#input\_subnet\_enforce\_private\_link\_service\_network\_policies) | Controls if private link service network policies should be enforced on the subnet. | `map(bool)` | `{}` | no |
| <a name="input_subnet_service_endpoints"></a> [subnet\_service\_endpoints](#input\_subnet\_service\_endpoints) | value of the service endpoints to associate with the subnet. | `map(list(string))` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_tracing_tags_enabled"></a> [tracing\_tags\_enabled](#input\_tracing\_tags\_enabled) | Controls if tracing tags should be enabled on the subnet. | `bool` | `false` | no |
| <a name="input_tracing_tags_prefix"></a> [tracing\_tags\_prefix](#input\_tracing\_tags\_prefix) | The prefix to use for the subnet tracing tag. | `string` | `""` | no |
| <a name="input_use_for_each"></a> [use\_for\_each](#input\_use\_for\_each) | Controls if the subnet should be created for each. | `bool` | n/a | yes |
| <a name="input_priority"></a> [priority](#input\_priority) | (Required) The priority of the Firewall Policy Rule Collection Group. The range is 100-65000. | `number` | n/a | yes |
| <a name="input_application_rule_collection"></a> [application\_rule\_collection](#input\_application\_rule\_collection) | (Optional) The Application Rule Collection to use in this Firewall Policy Rule Collection Group. | <pre>list(object({<br>    name     = string<br>    action   = string<br>    priority = number<br>    rule = list(object({<br>      name        = string<br>      description = optional(string)<br>      protocols = optional(list(object({<br>        type = string<br>        port = number<br>      })))<br>      http_headers = optional(list(object({<br>        name  = string<br>        value = string<br>      })))<br>      source_addresses      = optional(list(string))<br>      source_ip_groups      = optional(list(string))<br>      destination_addresses = optional(list(string))<br>      destination_urls      = optional(list(string))<br>      destination_fqdns     = optional(list(string))<br>      destination_fqdn_tags = optional(list(string))<br>      terminate_tls         = optional(bool)<br>      web_categories        = optional(list(string))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_network_rule_collection"></a> [network\_rule\_collection](#input\_network\_rule\_collection) | (Optional) The Network Rule Collection to use in this Firewall Policy Rule Collection Group. | <pre>list(object({<br>    name     = string<br>    action   = string<br>    priority = number<br>    rule = list(object({<br>      name                  = string<br>      description           = optional(string)<br>      protocols             = list(string)<br>      destination_ports     = list(string)<br>      source_addresses      = optional(list(string))<br>      source_ip_groups      = optional(list(string))<br>      destination_addresses = optional(list(string))<br>      destination_fqdns     = optional(list(string))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_nat_rule_collection"></a> [nat\_rule\_collection](#input\_nat\_rule\_collection) | (Optional) The NAT Rule Collection to use in this Firewall Policy Rule Collection Group. | <pre>list(object({<br>    name     = string<br>    action   = string<br>    priority = number<br>    rule = list(object({<br>      name                = string<br>      description         = optional(string)<br>      protocols           = list(string)<br>      source_addresses    = optional(list(string))<br>      source_ip_groups    = optional(list(string))<br>      destination_ports   = optional(list(string))<br>      destination_address = optional(string)<br>      translated_address  = optional(string)<br>      translated_port     = number<br>      translated_fqdn     = optional(string)<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall_ids"></a> [firewall\_ids](#output\_firewall\_ids) | Firewall generated ids |
| <a name="output_firewall_names"></a> [firewall\_names](#output\_firewall\_names) | Firewall names |
| <a name="output_private_ip_addresses"></a> [private\_ip\_addresses](#output\_private\_ip\_addresses) | Firewall private IP |
| <a name="output_public_ip_addresses"></a> [public\_ip\_addresses](#output\_public\_ip\_addresses) | Firewall public IP |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | ID of the subnet attached to the firewall |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Resource group name |
| <a name="output_policy_name"></a> [policy\_name](#output\_policy\_name) | Firewall policy name |
| <a name="output_policy_rule_collection_group_name"></a> [policy\_rule\_collection\_group\_name](#output\_policy\_rule\_collection\_group\_name) | Firewall policy rule collection group name |
| <a name="output_policy_rule_collection_group_id"></a> [policy\_rule\_collection\_group\_id](#output\_policy\_rule\_collection\_group\_id) | The ID of the firewall policy rule collection group |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
