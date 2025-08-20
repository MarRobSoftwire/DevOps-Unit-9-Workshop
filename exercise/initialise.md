# Initialising the project
Instructions to get the code working from scratch

## Github Actions

### Secrets
Three secrets are needed to run actions in github: 
 - `AZURE_CREDENTIALS`
    ```
    {
        "clientSecret":  "******", // Taken from A Cloud Guru sandbox
        "subscriptionId":  "******", // Found in Azure `Subscriptions` page
        "tenantId":  "******", // Found in Azure `Tenant Properties`
        "clientId":  "******" // Taken from A Cloud Guru sandbox
    }
    ```
 - `TF_VAR_RESOURCE_GROUP` - Resource Group used in the terraform
 - `TF_VAR_SUBSCRIPTION_ID` - Subscription ID used in the terraform - should be the same as azure credentials

 ## Terraform State
 The terraform state provider details cannot be stored as an environment variable so will need to be updated manually - this needs an azure storage account & container to store the state in.

