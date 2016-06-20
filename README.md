Automates pre-deployment setup for ruby applications run with puma.

Assumes the a functional and built out applicatin server as the target.
Currently assumes running as root, but sudoers should allow use of `become: yes` in the future.

### Use:
`ansible-playbook staging.yml --extra-vars="vars_file=someapp.staging.vars.yml"`
`ansible-playbook staging.yml --extra-vars="vars_file=someapp.training.vars.yml"`

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
  - kelly
- dependency_resque: no
- ruby_version: 2.3.1
- rbenv_root: /l/local/rbenv
- solr_core: /hydra-dev/solr/cores/demo-testing
- solr_home: /var/lib/solr/home
```

Get app gid and uid from ITS' UUID api/tool.

## Expected support existing on targer deployment machines.
all:
* python

database:
* python mysqldb module is required


### Testing with Vagrant using virtual box provider
1. install external ansible roles `ansible-galaxy install -r dependencies.yml`
1. install vagrant
2. install virtual-box
3. run `vagrant up` from project directory
5. Manually provision vagrant host using:
```bash
ansible-playbook --private-key=.vagrant/machines/default/virtualbox/private_key -u vagrant -i inventory/vagrant playbook.predeploy.yml --extra-vars="config_file=./demo.yml"
```


