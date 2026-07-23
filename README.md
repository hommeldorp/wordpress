# hommeldorp-wordpress

This git repo contains Wordpress content for Hommeldorp website:

- website theme
- custom plugins
- everything needed to run Wordpress locally with Docker

Since the vast majority of docs and community content for wordpress is in English, that is the language used for approachability

## Prerequisites

- Docker & Docker Compose

## Setup

1. Copy `env.example` to a new `.env` file (and update values if needed)
2. If you would like to restore from an existing database, copy the SQL seed script into `wp-data`. All SQL files in this folder will be run, so append "backup" to any you don't want to be run.
3. Run `docker compose up` to start all the containers
   1. After this you may need to modify the permissions of `wp-app`; see "Folder permissions" below
4. Navigate to `localhost` in your browser to see the Wordpress site

## Resetting

You can reset the docker containers by running `docker compose down -v`. This will shut everything down and delete all site content from the DB.
You can also delete `wp-app` to remove all plugins and themes. 

## Development

You can run `docker compose run dev` to start a container with PHP/Node development tools.
This command will enter immediately into an interactive shell.
You can exit the shell with `Crtl+P` and then `Ctls+Q` or by running `exit`.
You can also run `docker compose exec dev bash` to enter a shell in the dev container.

## Sources

The following sources were used to develop this project:

- https://hookturn.io/version-control-wp-content-using-git/
- https://github.com/nezhar/wordpress-docker-compose

## Folder permissions

Depending on how the system is setup, you may encounter issues with file permissions.
The most basic issues are addressed via the compose file, but some may persist and present in various ways (i.e. can't install plugins via WP admin panel).

In particular the wp-app (volume of all WP files), may be created with permissions that prevent editing.
To diagnose and solve these issues, run:
```
> ls -ld wp-app
drwxr-xr-x. 1 33 tape 582 20 jul 10:42 wp-app
# this shows permissions 755 and that the onwer is nobody (33)

# to fix, run chown for the current user 
> sudo chown -R <user> wp-app

# and then change permissions to 777
> sudo chmod -R 777 wp-app

# then you can check again to see if the permissions are correct
> ls -ld wp-app
drwxrwxrwx. 1 greg tape 582 20 jul 10:42 wp-app

```