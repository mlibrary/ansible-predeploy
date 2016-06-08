Automates pre-deployment setup for ruby applications run with puma.

Assumes the a functional and built out applicatin server as the target.
Currently assumes running as root, but sudoers should allow use of `become: yes` in the future.

Use:
`ansible-playbook staging.yml --extra-vars="hosts=staginghost.umdl.umich.edu"`

Required information:

```yaml
app_name: myapp
user_gid:  123456
user_uid:  987654
deploy_users:
  - user1
  - user2
dependency_mysql: no
dependency_solr: no
dependency_resque: no
```

Get app gid and uid from ITS' UUID api/tool.


### Testing with Vagrant using virtual box provider





