Automates pre-deployment setup for ruby applications run with puma.

Assumes the a functional and built out applicatin server as the target.

### Use:
Checkout repo into local directory
```
git@github.com:mlibrary/ansible-predeploy.git
cd ansible-predeploy
```
Run playbook supplying the inventory and config file
`ansible-playbook playbook.predeploy.yml -i /path/to/inventory/file --extra-vars="config_file=someapp.staging.vars.yml"`

### Testing with Vagrant using virtual box provider
1. install external ansible roles `ansible-galaxy install -r dependencies.yml`
1. install vagrant
2. install virtual-box
3. run `vagrant up` from project directory
5. provision vagrant host using:

```bash
# Run the full playbook
ansible-playbook playbook.predeploy.yml --private-key=.vagrant/machines/default/virtualbox/private_key -u vagrant -i inventory/vagrant --extra-vars="config_file=./vars/example-vars-staging.yml"

# Limit to just the tasks for the web servers
ansible-playbook playbook.predeploy.yml --private-key=.vagrant/machines/default/virtualbox/private_key -u vagrant -i inventory/vagrant --extra-vars="config_file=./vars/example-vars-staging.yml" -l web

```

### Required Information:
see `roles/setup/README.md`

```yaml
---
# Application pre-deployment variables file
# 'code name' for the app (e.g. umrdr-testing, heliotrope-staging)
- app_name: demo-testing
- app_repo:  https://github.com/mlibrary/umrdr
# Directory under which application dir will be created.
- deploy_root: /hydra-dev
# Users allowed to deploy the application
- deploy_users:
  - alice
  - bob
  - vagrant
# Does the project require resque or solr? (yes|no)
- dependency_resque: no
- dependency_solr: yes
# Whate version of ruby does the application require?
- ruby_version: 2.3.1
# The FQDN for the application.
- app_domain: example-staging.hydra.lib.uni.edu
# Alternate domains for the application
- app_domain_alias:
# Path under domain at which the application will be served.
- app_url_root: /
# Specifically allowed IPs for the application; leave blank to allow anyone.
- app_whitelisted_ips:
# Deny friend accounts for cosign authentication?
- app_cosign_deny_friend: yes

# Sysadmin/CoreServices provided:
- rbenv_root: /l/local/rbenv
- app_user_gid:  123000
- app_user_uid:  987000
- app_port: 30099
- db_host_priv_ip:  "127.0.0.1"
- app_host_priv_ip: "127.0.0.1"
- solr_home: /var/lib/solr/home
- solr_core: /hydra-dev/solr/cores/demo-testing
- app_ssl_key_filename:   dev.lib.uni.edu.key
- app_ssl_crt_filename:   dev.lib.uni.edu.crt
# If the apache host will be the terminus of the ssl connection use yes.
# If the load balancer will terminate the ssl connection, use no.
- apache_terminate_ssl:   yes
```

Each deployment stage or target of a project is its own application, should have it's own pre-deploy config file, and needs to be named uniquely.  The convention here is to use the project name with the stage or target separated by dashes.  For example, demo-staging and demo-testing.  The app name is used for naming the system for the app, the solr core (with `-` replaced by `_`), database name, and the database user name.  The database user name is a special case and needs to be 16 characters or fewer. The transform is the app name with all vowels after the first character removed and truncated to 16 characters.  


Get app gid and uid from ITS' UUID api/tool.

## Expected support existing on targer deployment machines.
all:
* python

database:
* python mysqldb module is required

web:
* apache
* common umich apache macros


