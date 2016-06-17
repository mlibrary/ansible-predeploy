## Vars

* db-user_db_username: db user's username.  Note that this role does not 
  create the user.
* db-user_db_password: db user's password
* db-user_app_user: application user's username
* db-user_app_user_home: home dir of the application user

## Example usage

    - hosts: app
      become: yes
      roles:
        - role: db-user
          db-user_db_username: bhck
          db-user_db_password: "{{some_secret_password_we_made}}"
          db-user_app_user: bhock
          db-user_app_user_home: /home/bhock
