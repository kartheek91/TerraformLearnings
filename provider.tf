terraform {
  cloud {

    organization = "kartheek91"

    workspaces {
      name = "TerraformLearnings"
      project = "Skipper"
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
  features {

  }
  subscription_id = "3edb4498-c2e0-4679-aaa7-1c1b69419c0c"
}
