This directory contains instructions for transforming a set of global input
variables into a set of output variables for use in various Ansible roles.

# Format

For each ansible role, supply a YAML file with one key per variable required by
the ansible role.

There are several options for the value of each key:

1) Populate `role_var` with the value of the `global_var` field provided in the template.
```yaml
role_var: global_var
```

For example:
```yaml
user_name: app_name
```
would populate the `user_name` Ansible variable with the value of the `app_name` field
provided in the template.

2) Provide a global name, default value, and output transformation:

```yaml
role_var:
  global: global_var
  default: some_default
  output: Some.ruby.code(global_var)
```

At least one of `global` or `default` must be provided; `output` is optional.

For example:

```yaml
solr_core_name:
  global: solr_core
  output: File.basename(solr_core).gsub("-", "_")
```

This takes the `solr_core` field provided in the filled-out template, replaces
dashes with underscores, and uses that as the value of the `solr_core_name`
Ansible variable.

If `default` is provided, that value will be used as the default if the
corresponding global field is not present in the filled-out template. If it is
not provided, a value must be given in the filled-out template.

If `global` is not provided, the default value will always be used - there is
no corresponding global variable name.

If the `output` transformation is not provided, the value of the input variable
or default will be used verbatim.

# Usage

`bin/required_vars` will process the files in this directory and emit a list of
global variables. This template should be in sync with `required_vars.yml` in
this repository.

`bin/setup_ansible` uses the files in this directory to process a filled-out
template and generate the expanded variables for use by the pre-deploy
playbook.
