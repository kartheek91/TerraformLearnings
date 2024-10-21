terraform {
  cloud {
    organization = "kartheek91"

    workspaces {
      name = "TerraformLearnings"
      # The 'project' argument is not valid in this context; remove it if not needed.
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.6.0"
    }
  }
}

provider "azurerm" {
  features {}

  # It's generally better to use the Azure CLI or environment variables for authentication
  # instead of hardcoding the subscription_id.
  subscription_id = var.subscription_id  # Ensure this variable is defined in variables.tf
}
