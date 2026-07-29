# // Licensed under the Apache License, Version 2.0 (the "License");
# // you may not use this file except in compliance with the License.
# // You may obtain a copy of the License at
#
# //     http://www.apache.org/licenses/LICENSE-2.0
#
# // Unless required by applicable law or agreed to in writing, software
# // distributed under the License is distributed on an "AS IS" BASIS,
# // WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# // See the License for the specific language governing permissions and
# // limitations under the License.

output "firewall_ids" {
  value = {
    firewall1 = module.firewall_policy_rule_collection_group.firewall_policy_rule_collection_group_id
  }
  description = "Placeholder map used by terratest to drive post-deploy assertions"
}

output "firewall_names" {
  value = {
    firewall1 = local.firewall_policy_name
  }
  description = "Firewall policy name associated with the rule collection group"
}

output "private_ip_addresses" {
  value       = {}
  description = "Firewall private IP"
}

output "public_ip_addresses" {
  value       = {}
  description = "Firewall public IP"
}

output "subnet_ids" {
  value       = {}
  description = "ID of the subnet attached to the firewall"
}

output "resource_group_name" {
  value       = module.resource_group.name
  description = "Resource group name"
}

output "policy_name" {
  value       = module.firewall_policy.name
  description = "Firewall policy name"
}

output "policy_rule_collection_group_name" {
  value       = module.firewall_policy_rule_collection_group.firewall_policy_rule_collection_group_name
  description = "Firewall policy rule collection group name"
}

output "policy_rule_collection_group_id" {
  value       = module.firewall_policy_rule_collection_group.firewall_policy_rule_collection_group_id
  description = "The ID of the firewall policy rule collection group"
}
