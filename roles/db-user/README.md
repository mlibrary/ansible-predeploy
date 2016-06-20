## Vars

* db_user_db_username: db user's username.  Note that this role does not 
  create the user.
* db_user_db_password: db user's password
* db_user_app_user: application user's username
* db_user_app_user_home: home dir of the application user

## Example usage

    - hosts: app
      become: yes
      roles:
        - role: db-user
          db_user_db_username: bhck
          db_user_db_password: "{{some_secret_password_we_made}}"
          db_user_app_user: bhock
          db_user_app_user_home: /home/bhock
