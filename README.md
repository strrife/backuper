# Backup creation tool

Cron backup creation and upload

At the moment it dumps mongodb databases to dropbox.

##0) Requirements

The upload scripts are written in PHP, so to get it working you'll need to:

``apt-get install php5-cli php5-json php5-curl``

##1) Insert your credentials

``cp upload/dropbox.json.sample upload/dropbox.json``

Then edit ``upload/dropbox.json`` and insert your token retrieved on the app dashboard page.

##2) Run it

`` ./backup.sh mydatabase``

P.S. First I was planning to use google drive, but there was no way I could ever imagine the mess they have in their API docs. So screw google for now.
