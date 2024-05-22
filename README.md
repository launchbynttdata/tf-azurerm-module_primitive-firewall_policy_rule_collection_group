# tf-azurerm-module_primitive-firewall_application_rule_collection

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This module creates a firewall policy rule collection group. And optionally creates Network rule collection, Application rule collection and NAT rule collection along with rules.

## Pre-Commit hooks

[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly

- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below

```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. _THIS STEP APPLIES ONLY TO MICROSOFT AZURE. IF YOU ARE USING A DIFFERENT PLATFORM PLEASE SKIP THIS STEP._ The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `azure_env.sh` file on local workstation. Devloper would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Service principle used for authentication(value of ARM_CLIENT_ID) should have below privileges on resource group within the subscription.

```
"Microsoft.Resources/subscriptions/resourceGroups/write"
"Microsoft.Resources/subscriptions/resourceGroups/read"
"Microsoft.Resources/subscriptions/resourceGroups/delete"
```

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `azure` specific. If primitive/segment under development uses any other cloud provider than azure, this section may not be relevant.

- A file named `provider.tf` with contents below

```
provider "azurerm" {
  features {}
}
```

- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitignore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target

- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | <= 1.5.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.77 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.104.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_firewall_policy_rule_collection_group.policy_rule_collection_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy_rule_collection_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name which should be used for this Firewall Policy Rule Collection Group. Changing this forces a new Firewall Policy Rule Collection Group to be created. | `string` | n/a | yes |
| <a name="input_firewall_policy_id"></a> [firewall\_policy\_id](#input\_firewall\_policy\_id) | (Required) The ID of the Firewall Policy where the Firewall Policy Rule Collection Group should exist. Changing this forces a new Firewall Policy Rule Collection Group to be created. | `string` | n/a | yes |
| <a name="input_priority"></a> [priority](#input\_priority) | (Required) The priority of the Firewall Policy Rule Collection Group. The range is 100-65000. | `number` | n/a | yes |
| <a name="input_application_rule_collection"></a> [application\_rule\_collection](#input\_application\_rule\_collection) | (Optional) The Application Rule Collection to use in this Firewall Policy Rule Collection Group. | <pre>list(object({<br>    name     = string<br>    action   = string<br>    priority = number<br>    rule = list(object({<br>      name        = string<br>      description = optional(string)<br>      protocols = optional(list(object({<br>        type = string<br>        port = number<br>      })))<br>      http_headers = optional(list(object({<br>        name  = string<br>        value = string<br>      })))<br>      source_addresses      = optional(list(string))<br>      source_ip_groups      = optional(list(string))<br>      destination_addresses = optional(list(string))<br>      destination_urls      = optional(list(string))<br>      destination_fqdns     = optional(list(string))<br>      destination_fqdn_tags = optional(list(string))<br>      terminate_tls         = optional(bool)<br>      web_categories        = optional(list(string))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_network_rule_collection"></a> [network\_rule\_collection](#input\_network\_rule\_collection) | (Optional) The Network Rule Collection to use in this Firewall Policy Rule Collection Group. | <pre>list(object({<br>    name     = string<br>    action   = string<br>    priority = number<br>    rule = list(object({<br>      name                  = string<br>      description           = optional(string)<br>      protocols             = list(string)<br>      destination_ports     = list(string)<br>      source_addresses      = optional(list(string))<br>      source_ip_groups      = optional(list(string))<br>      destination_addresses = optional(list(string))<br>      destination_fqdns     = optional(list(string))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_nat_rule_collection"></a> [nat\_rule\_collection](#input\_nat\_rule\_collection) | (Optional) The NAT Rule Collection to use in this Firewall Policy Rule Collection Group. | <pre>list(object({<br>    name     = string<br>    action   = string<br>    priority = number<br>    rule = list(object({<br>      name                = string<br>      description         = optional(string)<br>      protocols           = list(string)<br>      source_addresses    = optional(list(string))<br>      source_ip_groups    = optional(list(string))<br>      destination_address = optional(string)<br>      destination_ports   = optional(list(string))<br>      translated_address  = optional(string)<br>      translated_port     = number<br>      translated_fqdn     = optional(string)<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall_policy_rule_collection_group_name"></a> [firewall\_policy\_rule\_collection\_group\_name](#output\_firewall\_policy\_rule\_collection\_group\_name) | value of the Azure Firewall policy rule collection group name |
| <a name="output_firewall_policy_rule_collection_group_id"></a> [firewall\_policy\_rule\_collection\_group\_id](#output\_firewall\_policy\_rule\_collection\_group\_id) | The ID of the Firewall Policy Rule Collection Group. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
