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
  #cloud {
  #  organization = "ExamPro"
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}

}

provider "terratowns" {
  endpoint  = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token     = var.terratowns_access_token
}
module "terrahouse_aws" {
  source              = "./modules/terrahouse_aws"
  user_uuid           = var.teacherseat_user_uuid
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version     = var.content_version
  assets_path         = var.assets_path
}

resource "terratowns_home" "home" {
  name        = "How to play Bejeweled in 2023!"
  description = <<DESCRIPTION
Bejeweled is a match-3 jewel game series created by PopCap. The objective of the game is to swap two 
adjacent gems of seven colors to create a line or row of three or more gems. The gems disappear once lined up.
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  #mock it
  domain_name     = module.terrahouse_aws.cloudfront_url
  town            = "missingo"
  content_version = 1
}

# test
