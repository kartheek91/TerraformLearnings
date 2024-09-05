terraform { 
  cloud { 
    
    organization = "SailsSoftwareSolutions" 

    workspaces { 
      name = "Kartheek-Learnings-CLI" 
    } 
  } 
}
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
}
provider "azurerm" {
  features {
    
  }
subscription_id = "dfbccd65-4e2b-4923-8ad1-2de63fdb2c3a"
}