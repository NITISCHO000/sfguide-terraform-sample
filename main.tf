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
  role  = "sysadmin"
  region = "us-west-2"
  account = "kka94144"
  username = "tf-snow"
  private_key_path = "C:\\Users\\NitinC\\.ssh\\snowflake_tf_snow_key"
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
  provider "snowflake" {
        alias = "security_admin"
        role  = "SECURITYADMIN"
    }


    resource "snowflake_role" "role" {
        provider = snowflake.security_admin
        name     = "TF_DEMO_SVC_ROLE"
    }


    resource "snowflake_database_grant" "grant" {
        provider          = snowflake.security_admin
        database_name     = snowflake_database.db.name
        privilege         = "USAGE"
        roles             = [snowflake_role.role.name]
        with_grant_option = false
    }
