## Backup and restore Gitlab
This document illustrates how to create Gitlab backup from docker container and restore in operating system.
~~~~
docker exec -t <container name> gitlab-backup create
~~~~

Backup file will be located at `/var/opt/gitlab/backup/` inside docker container. This backup file does not contain Gitlab configuration files. You should make a backup from below files manually.
* /etc/gitlab/gitlab-secrets.json
* /etc/gitlab/gitlab.rb


You can restore a backup only to the exact same version and type (CE/EE) of GitLab that you created it on (for example CE 9.1.0).
This procedure assumes that:
* You have installed the exact same version and type (CE/EE) of GitLab Omnibus with which the backup was created.
* You have run sudo gitlab-ctl reconfigure at least once.
* GitLab is running. If not, start it using sudo gitlab-ctl start.

First ensure your backup tar file is in the backup directory described in the gitlab.rb configuration `gitlab_rails['backup_path']`. The default is `/var/opt/gitlab/backups`. It needs to be owned by the git user.
Stop the processes that are connected to the database. Leave the rest of GitLab running:
~~~~
sudo gitlab-ctl stop unicorn
sudo gitlab-ctl stop puma
sudo gitlab-ctl stop sidekiq
sudo gitlab-ctl status
~~~~

Next, restore the backup, specifying the timestamp of the backup you wish to restore:
~~~~
sudo gitlab-backup restore BACKUP=<TIMESTAMP>
~~~~

Next, restore `</etc/gitlab/gitlab-secrets.json>` if necessary.
Reconfigure, restart and check GitLab:
~~~~
sudo gitlab-ctl reconfigure
sudo gitlab-ctl restart
sudo gitlab-rake gitlab:check SANITIZE=true
~~~~
