# Purpose

This role sets up individual role variables from a much smaller 
set supplied to this role.

# Required Variables

If two or more sections require the same variable, it should be 
assumed that this is intentional.

## DB Role

* app_name
* deploy_users

## DB-User Role

* app_name

## User Role

* app_name
* app_user_uid
* app_user_gid
* deploy_users

## Puma Service Role

* app_name
* dependency_resque
* rbenv_root
* deploy_root

## Ruby Version Role

* ruby_version
* rbenv_root

## Solr Core Role

* solr_core
* solr_home
* app_repo

## Target Role

* app_name
* deploy_root

## Apache Config Role
* app_name
* app_domain
* app_url_root
* app_domain_alias
* app_whitelisted_ips
* app_port
* app_host_priv_ip
* app_ssl_key_filename
* app_ssl_crt_filename
* app_cosign_deny_friend

# Development

1. Create a file `tasks/<rolename>.yml`
2. Use the set_fact module to setup the variables.
3. Add a bare include line to `tasks/main.yml`
4. Note the variables that must be supplied to this role inside
   this readme, above.
   
