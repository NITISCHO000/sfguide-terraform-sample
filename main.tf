terraform {
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = "0.22.0"
    }
  }
}

variable "test" 
{
  type = string
  default = "C:\Users\NitinC\.ssh"
}

provider "snowflake" {
  alias = "sys_admin"
  role  = "SYSADMIN"
  region = "US_EAST_1"
  account = "wza20831"
  username = "tf-snow"
  private_key_path = var.test
}

resource "snowflake_database" "db" {
  provider = snowflake.sys_admin
  name     = "TF_DEMO"
}

resource "snowflake_warehouse" "warehouse" {
  provider       = snowflake.sys_admin
  name           = "TF_DEMO"
  warehouse_size = "large"

  auto_suspend = 60
}

