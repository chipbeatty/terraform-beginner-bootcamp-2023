terraform {
  required_providers {
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  cloud {
    organization = "ChipBeatty"
    workspaces {
      name = "terra-house-1"
    }
  }
}

provider "terratowns" {
  endpoint  = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token     = var.terratowns_access_token
}
module "home_butterfinger_hosting" {
  source          = "./modules/terrahome_aws"
  user_uuid       = var.teacherseat_user_uuid
  public_path     = var.butterfinger.public_path
  content_version = var.butterfinger.content_version
}

resource "terratowns_home" "home" {
  name        = "Butterfinger"
  description = <<DESCRIPTION
Butterfinger is a candy bar manufactured by the Ferrara Candy Company, a subsidiary of Ferrero.
It consists of a layered crisp peanut butter core covered in a chocolatey coating.
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  #mock it
  domain_name     = module.home_butterfinger_hosting.domain_name
  town            = "cooker-cove"
  content_version = var.butterfinger.content_version
}

module "home_snickers_hosting" {
  source          = "./modules/terrahome_aws"
  user_uuid       = var.teacherseat_user_uuid
  public_path     = var.snickers.public_path
  content_version = var.snickers.content_version
}

resource "terratowns_home" "home_snickers" {
  name            = "Snickers"
  description     = <<DESCRIPTION
You aren't you when you're hungry. That's why there's SNICKERS Full Size Chocolate Bars. Packed with roasted peanuts, 
nougat, caramel and milk chocolate, SNICKERS Candy handles your hunger so you can handle things that don't relate to 
hunger at all.
DESCRIPTION
  domain_name     = module.home_snickers_hosting.domain_name
  town            = "cooker-cove"
  content_version = var.snickers.content_version
}
