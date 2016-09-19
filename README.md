# Overview

This project automates the pre-deployment setup for ruby applications 
run with puma.  

It assumes a functional application, web, and database tier is already
in place.

# Paradigm

The predeployment offered by this project is intended to be configured
and run once, resulting in full preparation for deployment to the web, 
app, and db tiers.  Actual deployment of the application is up to the developer(s), 
as is the configuration of their application's deployment.  

Each deployment stage (or target) of a project is its own, self-contained 
application.  I.e., `umrdr-staging` and `umrdr-production` are two 
separate applications.  

Each application is associated with its own application user and group.
Developers with deployment permission are added to the application 
group.  Thus, this project provisions the necessary file and sudo 
permissions to allow them to deploy and restart the application.

Each application should have its own:
* unique name, preferably of the form appname-stagename
* predeploy configuration file
* inventory file

# Usage

## Short Version

```
git clone git@github.com:mlibrary/ansible-predeploy.git
cd ansible-predeploy
cp inventory/vagrant appname_inventory
# A&E fills out appname_inventory
cp required_vars.yml appname_vars.yml
# A&E and the developer fills out appname_vars.yml (not doesn't matter)
./bin/setup_ansible -v appname_vars.yml > appname_expanded_vars.yml
ansible-playbook playbook.predeploy.yml -i appname_inventory -e "config_file=appname_expanded_vars.yml"
```

## Full Version


1. Minimally, the developer provides an application name and stagename.
   By convention, stage names should be one of `production`, `staging`,
   or `testing`.  
2. Get application gid and uid from ITS's UUID api/tool, passing the 
   application name and stage into the foreign key or other field.
3. Identify the hosts to which the application will be deployed.  
4. Create a appname-stagename-inventory file, following the example
   in inventory.example.
5. A&E and the developer(s) fill out a copy of `required_vars.yml`
6. Run `bin/setup_ansible -v /file/from/previous/step` to convert the
   file we just created into the form that ansible will use.  There is 
   no need to edit the resulting file.  However, it does contain some useful 
   information, such as the passwords generated for the deploy and the 
   final database user name.
7. Run the appropriate ansible playbook, as below:

`ansible-playbook playbook.predeploy.yml -i /file/from/step/4 -e "config_file=/file/from/step/6"`

From here, the playbook should run without issue.  The playbook
is idempotent, so re-running if there is an problem is not an
issue.

# Infrastructure Requirements
all:
* python
* passwordless ssh as root

database:
* mysql
* python mysqldb module is required

web:
* apache
* common umich apache macros



# Testing
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

