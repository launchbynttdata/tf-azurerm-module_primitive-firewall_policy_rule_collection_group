package common

import (
	"context"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azcore"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/arm"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/cloud"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	armNetwork "github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/network/armnetwork/v5"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/lib/azure/configure"
	"github.com/launchbynttdata/lcaf-component-terratest/lib/azure/login"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
)

const terraformDir string = "../../examples/fw_policy_rule_coll_grp"
const varFile string = "test.tfvars"

func TestFirewall(t *testing.T, ctx types.TestContext) {

	envVarMap := login.GetEnvironmentVariables()
	subscriptionID := envVarMap["subscriptionID"]

	credential, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		t.Fatalf("Unable to get credentials: %e\n", err)
	}
	options := arm.ClientOptions{
		ClientOptions: azcore.ClientOptions{
			Cloud: cloud.AzurePublic,
		},
	}

	firewallPolicyRuleCollectionGroupsClient, err := armNetwork.NewFirewallPolicyRuleCollectionGroupsClient(subscriptionID, credential, &options)
	if err != nil {
		t.Fatalf("Error getting firewall policy rule collection groups client: %v", err)
	}

	terraformOptions := configure.ConfigureTerraform(terraformDir, []string{terraformDir + "/" + varFile})

	firewallIds := terraform.OutputMap(t, ctx.TerratestTerraformOptions(), "firewall_ids")
	for range firewallIds {
		t.Run("doesFwPolicyRuleCollGrpExist", func(t *testing.T) {
			resourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")
			policyName := terraform.Output(t, terraformOptions, "policy_name")
			policyRuleCollectionGroupName := terraform.Output(t, terraformOptions, "policy_rule_collection_group_name")

			prcg, err := firewallPolicyRuleCollectionGroupsClient.Get(context.Background(), resourceGroupName, policyName, policyRuleCollectionGroupName, nil)
			if err != nil {
				t.Fatalf("Error getting policy rule collection group: %v", err)
			}

			assert.Equal(t, policyRuleCollectionGroupName, *prcg.Name)
		})
	}
}
