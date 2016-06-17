## Vars

* db_name: name of the db
* db_user_name: name of the db user
* db_user_password: database user's **database** password
* db_deploy_users: list of users to be granted full permissions on the db


## Example usage

    - hosts: production
      become: yes
      roles:
        - role: db
          db_name:
          db_user_name:
          db_user_password:
          db_deploy_users:
            - bhock
            - grosscol
