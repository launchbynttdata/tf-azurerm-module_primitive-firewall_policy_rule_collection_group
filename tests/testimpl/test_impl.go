package common

import (
	"context"
	"os"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	"github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/network/armnetwork/v5"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
)

func TestFirewall(t *testing.T, ctx types.TestContext) {

	subscriptionID := os.Getenv("ARM_SUBSCRIPTION_ID")
	if len(subscriptionID) == 0 {
		t.Fatal("ARM_SUBSCRIPTION_ID is not set in the environment variables ")
	}

	cred, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		t.Fatalf("Unable to get credentials: %e\n", err)
	}

	firewallPolicyRuleCollectionGroupsClient, err := armnetwork.NewFirewallPolicyRuleCollectionGroupsClient(subscriptionID, cred, nil)
	if err != nil {
		t.Fatalf("Error getting firewall policy rule collection groups client: %v", err)
	}

	firewallIds := terraform.OutputMap(t, ctx.TerratestTerraformOptions(), "firewall_ids")
	for range firewallIds {
		t.Run("doesFwPolicyRuleCollGrpExist", func(t *testing.T) {
			resourceGroupName := terraform.Output(t, ctx.TerratestTerraformOptions(), "resource_group_name")
			policyName := terraform.Output(t, ctx.TerratestTerraformOptions(), "policy_name")
			policyRuleCollectionGroupName := terraform.Output(t, ctx.TerratestTerraformOptions(), "policy_rule_collection_group_name")

			prcg, err := firewallPolicyRuleCollectionGroupsClient.Get(context.Background(), resourceGroupName, policyName, policyRuleCollectionGroupName, nil)
			if err != nil {
				t.Fatalf("Error getting policy rule collection group: %v", err)
			}

			assert.Equal(t, policyRuleCollectionGroupName, *prcg.Name)
		})
	}
}
