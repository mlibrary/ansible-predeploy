## Puma Service Role
Install systemd service files for running app using puma.

### Required variables:

```yaml
puma_svc_resque_dependency: no
puma_svc_rbenv_root:        /l/local/rbenv
puma_svc_app_name:          myapp-staging
puma_svc_app_group:         myapp-staging
puma_svc_deploy_dir:        /hydra-dev/myapp-staging/app"
```
