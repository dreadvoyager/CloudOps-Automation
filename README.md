Intern Project: Azure Cloud Infrastructure & CI/CD Implementation

Objective
Deploy a complete cloud environment using Terraform and set up CI/CD pipelines using Azure DevOps for:

A Node.js web application deployed to Azure Web App (App Service)

A containerized Node.js app deployed to Azure Kubernetes Service (AKS)

## Project Structure

```bash
Devops_project/
├── terraform/ 
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── modules/
│   │   ├── key-vault/
│   │   ├── sql-server/
│   │   ├── app-service/
│   │   ├── aks/
│   │   └── acr/
│   └── k8s-manifests/
│       ├── deployment.yaml
│       ├── service.yaml
│       └── secret-provider.yaml
├── nodejs-app/
├── media/  
├── infra-pipelines.yml
├── webapp-pipelines.yml
├── aks-pipelines.yml
└── README.md
```
## Purpose of Each Folder

terraform/             	    Contains the root Terraform configuration and module calls
terraform/modules/	        Reusable modules for each Azure resource
terraform/k8s-manifests/	Kubernetes YAML manifests (deployment, service, SecretProviderClass)
nodejs-app                  Contains application code and Dockerfile
pipelines/	                Azure DevOps multi-stage YAML pipeline definitions for infra, App Service app, and AKS app
media/                      Pdf file containing screenshots of deployed resources
README.md	                Documentation for setup, architecture, pipelines, and execution

## Key Features
Infrastructure as Code (Terraform)

Remote backend using Azure Storage Account

Secrets management via Azure Key Vault

Modular architecture: dedicated module per Azure resource

Outputs feed into CI/CD pipelines securely

✅ CI/CD Pipelines (Azure DevOps)

Multi-stage pipelines (Dev → QA → Stage → Prod)

Pipelines:

infra-pipelines.yml: Provisions Azure infrastructure

appservice-pipelines.yml: Builds + deploys Node.js web app to Azure App Service

aks-pipelines.yml: Builds + deploys Docker app to AKS

Dynamic SecretProviderClass with environment-specific user-assigned identity

Branch policies enforced (main branch → PR approvals required)

Approvals using Azure DevOps Environments

🚀 Pipelines
infra-pipelines.yml
Stages: Terraform Init, Terraform Plan, Terraform Apply

Apply gated: Runs only on main branch with manual approval

appservice-pipelines.yml
Build and deploy Node.js app to App Service

Multi-environment (Dev, QA, Staging, Prod)

Optional slot swap for staging → production

aks-pipelines.yml
Build Docker image → Push to ACR → Deploy to AKS

Dynamic substitution of Kubernetes manifests using sed or kubectl kustomize

Use of CSI Secret Store + Key Vault for secrets

🔒 Branch Policies
✅ main branch

Pull request (PR) required

At least one mandatory reviewer

Pipeline runs on PR (plan only) and gated apply on main after approval

⚙️ Dynamic Configuration
USER_ASSIGNED_ID is generated dynamically using environment name:

bash
Copy
Edit
USER_ASSIGNED_ID="/subscriptions/<sub-id>/resourceGroups/MC_proj-${environment}-rg_proj-${environment}-aks/providers/Microsoft.ManagedIdentity/userAssignedIdentities/azurekeyvaultsecretsprovider-proj-${environment}-aks"
sed "s|\${USER_ASSIGNED_ID}|$USER_ASSIGNED_ID|g" deployment.yaml | kubectl apply -f -
Pipelines conditionally run:

appservice-pipelines.yml and aks-pipelines.yml trigger only after successful infra-pipelines.yml run

Example resource dependency in pipeline:

yaml
Copy
Edit
resources:
  pipelines:
    - pipeline: infra
      source: InfraPipelineName
      trigger:
        branches:
          include:
            - main
📝 How to Run
1️⃣ Set up the remote backend manually (once)

Create Azure Storage Account + blob container tfstate

Enable versioning

2️⃣ Run the infra pipeline

bash
Copy
Edit
az pipelines run --name "infra-pipelines"
Or trigger via PR merge → main

3️⃣ Run app pipelines

Automatically triggered after infra (or manual)

Or via:

bash
Copy
Edit
az pipelines run --name "appservice-pipelines"
az pipelines run --name "aks-pipelines"
✅ Evaluation Criteria
Clear module separation and reuse

No hardcoded secrets — use Key Vault + CSI driver

Branch policies + approvals implemented

Clean Azure DevOps YAML pipelines with multi-stage design

Proper output usage and remote state configured

Dynamic manifest substitution for environment-specific configs

🗂 Assumptions
Service connections for App Service, ACR, AKS are pre-configured in Azure DevOps

AKS nodes have user-assigned managed identity assigned correctly per environment

Azure DevOps Environments are set up for gating approvals

If you'd like, I can export this as a downloadable README.md file or help you further polish or extend it (e.g. with diagrams or screenshots placeholders). Let me know! 🚀