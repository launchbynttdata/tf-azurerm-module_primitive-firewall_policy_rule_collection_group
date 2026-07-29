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

locals {
  resource_group                             = module.resource_names["resource_group"].standard
  firewall_name                              = module.resource_names["firewall"].standard
  firewall_policy_name                       = module.resource_names["firewall_policy"].standard
  firewall_policy_rule_collection_group_name = module.resource_names["fw_plcy_rule_colln_grp"].standard
  public_ip_custom_name                      = module.resource_names["public_ip"].standard
  virtual_network_name                       = module.resource_names["hub_vnet"].standard

  tags = merge({ provisioner = "terraform" }, var.tags)
}
