# Backup creation tool

Cron backup creation and upload

At the moment it dumps mongodb databases to dropbox.

##1) Insert your credentials

``cp upload/dropbox.json.sample upload/dropbox.json``

Then edit ``upload/dropbox.json`` and insert your token retrieved on the app dashboard page.

##2) Run it

`` ./backup.sh mydatabase``

P.S. First I was planning to use google drive, but there was no way I could ever imagine the mess they have in their API docs. So screw google for now.