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

variable "name" {
  description = "(Required) The name which should be used for this Firewall Policy Rule Collection Group. Changing this forces a new Firewall Policy Rule Collection Group to be created."
  type        = string
}

variable "firewall_policy_id" {
  description = " (Required) The ID of the Firewall Policy where the Firewall Policy Rule Collection Group should exist. Changing this forces a new Firewall Policy Rule Collection Group to be created."
  type        = string
}

variable "priority" {
  description = "(Required) The priority of the Firewall Policy Rule Collection Group. The range is 100-65000."
  type        = number
}

variable "application_rule_collection" {
  description = "(Optional) The Application Rule Collection to use in this Firewall Policy Rule Collection Group."
  type = list(object({
    name     = string
    action   = string
    priority = number
    rule = list(object({
      name        = string
      description = optional(string)
      protocols = optional(list(object({
        type = string
        port = number
      })))
      http_headers = optional(list(object({
        name  = string
        value = string
      })))
      source_addresses      = optional(list(string))
      source_ip_groups      = optional(list(string))
      destination_addresses = optional(list(string))
      destination_urls      = optional(list(string))
      destination_fqdns     = optional(list(string))
      destination_fqdn_tags = optional(list(string))
      terminate_tls         = optional(bool)
      web_categories        = optional(list(string))
    }))
  }))
  default = []

  validation {
    condition     = alltrue([for collection in var.application_rule_collection : collection.priority >= 100 && collection.priority <= 65000])
    error_message = "application_rule_collection.priority must be in the range 100 - 65000, inclusive."
  }

  validation {
    condition     = alltrue([for collection in var.application_rule_collection : contains(["Allow", "Deny"], collection.action)])
    error_message = "application_rule_collection.action must contain 'Allow' or 'Deny'."
  }
}

variable "network_rule_collection" {
  description = "(Optional) The Network Rule Collection to use in this Firewall Policy Rule Collection Group."
  type = list(object({
    name     = string
    action   = string
    priority = number
    rule = list(object({
      name                  = string
      description           = optional(string)
      protocols             = list(string)
      destination_ports     = list(string)
      source_addresses      = optional(list(string))
      source_ip_groups      = optional(list(string))
      destination_addresses = optional(list(string))
      destination_fqdns     = optional(list(string))
    }))
  }))
  default = []

  validation {
    condition     = alltrue([for collection in var.network_rule_collection : collection.priority >= 100 && collection.priority <= 65000])
    error_message = "network_rule_collection.priority must be in the range 100 - 65000, inclusive."
  }

  validation {
    condition     = alltrue([for collection in var.network_rule_collection : contains(["Allow", "Deny"], collection.action)])
    error_message = "network_rule_collection.action must contain 'Allow' or 'Deny'."
  }
}

variable "nat_rule_collection" {
  description = "(Optional) The NAT Rule Collection to use in this Firewall Policy Rule Collection Group."
  type = list(object({
    name     = string
    action   = string
    priority = number
    rule = list(object({
      name                = string
      description         = optional(string)
      protocols           = list(string)
      source_addresses    = optional(list(string))
      source_ip_groups    = optional(list(string))
      destination_address = optional(string)
      destination_ports   = optional(list(string))
      translated_address  = optional(string)
      translated_port     = number
      translated_fqdn     = optional(string)
    }))
  }))
  default = []

  validation {
    condition     = alltrue([for collection in var.nat_rule_collection : collection.priority >= 100 && collection.priority <= 65000])
    error_message = "nat_rule_collection.priority must be in the range 100 - 65000, inclusive."
  }

  validation {
    condition     = alltrue([for collection in var.nat_rule_collection : contains(["Allow", "Deny"], collection.action)])
    error_message = "nat_rule_collection.action must contain 'Allow' or 'Deny'."
  }
}
