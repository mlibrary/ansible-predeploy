## Vars

* user_group: Group's name
* user_gid: Group's gid
* user_name: User's name
* user_uid: User's uid
* user_home: User's home, which will be created.
* user_deploy_users: list of users that will be part of this group


## Example usage

    - hosts: production
      become: yes
      roles:
        - role: user
          user_group: "{{app_name}}"
          user_name: "{{app_name}}"
          user_home: "/var/local/{{app_name}}"
          user_uid: 12313
          user_gid: 2923
          user_deploy_users:
            - bhock
            - grosscol