## Vars

* group_gid: group's gid
* app_name: name of the app.  The user and group will be named this.
* user_uid: user's uid
* deploy_users: list of users that will be part of this group


## Example usage

    - hosts: production
      become: yes
      roles:
        - role: user
          app_name: sampleapp
          user_uid: 12313
          group_gid: 2923
          deploy_users:
            - bhock
            - grosscol