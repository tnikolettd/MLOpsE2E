projectName="MLOpsE2E"
roleName="Contributor"
subscriptionId="9c592bb0-0899-482e-aef3-39deec472240"
environment="Dev" #First letter should be capitalized
servicePrincipalName="Azure-ARM-${environment}-${projectName}"
# Verify the ID of the active subscription
echo "Using subscription ID $subscriptionID"
echo "Creating SP for RBAC with name $servicePrincipalName, with role $roleName and in scopes     /subscriptions/$subscriptionId"
az ad sp create-for-rbac --name $servicePrincipalName --role $roleName --scopes /subscriptions/$subscriptionId
echo "Please ensure that the information created here is properly save for future use."