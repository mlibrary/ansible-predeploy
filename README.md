Automates pre-deployment setup for ruby applications run with puma.

Assumes the a functional and built out applicatin server as the target.

### Use:
`ansible-playbook staging.yml --extra-vars="config_file=someapp.staging.vars.yml"`
`ansible-playbook staging.yml --extra-vars="config_file=someapp.training.vars.yml"`

### Required Information:
see `roles/setup/README.md`

```yaml
---
# Application pre-deployment variables file
- app_name: demo-testing
- app_repo:  https://github.com/mlibrary/umrdr
- app_user_gid:  123000
- app_user_uid:  987000
- deploy_root: /hydra-dev
- deploy_users:
  - alice
  - bob
  - vagrant
- dependency_resque: no
- ruby_version: 2.3.1
- rbenv_root: /l/local/rbenv
- solr_core: /hydra-dev/solr/cores/demo-testing
- solr_home: /var/lib/solr/home
- app_domain: example-staging.hydra.lib.uni.edu
- app_url_root: /
- app_domain_alias:
- app_whitelisted_ips:
- app_port: 30999
- app_host_priv_ip: 127.0.0.1
- app_ssl_key_filename:   dev.lib.uni.edu.key
- app_ssl_crt_filename:   dev.lib.uni.edu.crt
- app_cosign_deny_friend: yes
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


### Testing with Vagrant using virtual box provider
1. install external ansible roles `ansible-galaxy install -r dependencies.yml`
1. install vagrant
2. install virtual-box
3. run `vagrant up` from project directory
5. Manually provision vagrant host using:
```bash
ansible-playbook --private-key=.vagrant/machines/default/virtualbox/private_key -u vagrant -i inventory/vagrant playbook.predeploy.yml --extra-vars="config_file=./demo.yml"
```


