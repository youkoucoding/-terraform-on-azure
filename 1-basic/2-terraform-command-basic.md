# Terraform Command Basic

## Basic Terraform Command

1. `terraform init`
2. `terraform validate`
3. `terraform plan`
4. `terraform apply`
5. `terraform destroy`

## Terraform Workflow

1. init:

- used to initialize a working directory containing terraform config files
- This is the first command that should be run after writing a new Terraform configuration
- Downloads Providers

2. validate:

- Validates the terraform configurations files in that respective directory to ensure they are syntactically valid and internally consistent.

3. plan

- Creates an execution plan
- Terraform performs a refresh and determines what actions are necessary to achieve the desired state specified in configuration files

4. apply

- Used to apply the changes required to reach the desired state of the configuration
- By default, apply scans the current directory for the configuration and applies and changes appropriately.

5. destroy

- Used to destroy the Terraform-managed infrastructure
- Thsi will ask for confirmatin before destroying.

## Azure cli tips

1. get azure regions

- `az account list-locations -o table`

2. list subscription

- `az account list`

3. set specific subscription

- `az account set --subscription="<subscription_id>"`

## Terraform code

```tf
# Terraform settings block

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
# Create Resource Group
resource "azurerm_resource_group" "my_demo_rg1" {
  location = "japaneast"
  name = "my-demo-rg1"
}
```
