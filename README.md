Automates pre-deployment setup for ruby applications run with puma.

Assumes the a functional and built out applicatin server as the target.
Currently assumes running as root, but sudoers should allow use of `become: yes` in the future.

Use:
`ansible-playbook staging.yml --extra-vars="hosts=staginghost.umdl.umich.edu"`
