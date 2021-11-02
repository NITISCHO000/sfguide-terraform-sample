terraform {
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = "0.22.0"
    }
  }
}

provider "snowflake" {
  alias = "sys_admin"
  role  = "SYSADMIN"
  region = "US_EAST_1"
  account = "wza20831"
  private_key_path =  "C:\Users\NitinC\.ssh"
  username = "tf-snow"
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

