#!/bin/bash

# Setting variables
bin_source="/root/docker-backup-scripts"
backup_path="/backup-docker"
tar_opts="--exclude=var/run --exclude=data/addons/data/core_mariadb/databases --exclude=data/databases --exclude=data/backup"
rsync_opts="--exclude=var/run --exclude=data/addons/data/core_mariadb/databases --exclude=data/databases --exclude=data/backup"


cd "${BASH_SOURCE%/*}" || exit
mkdir -p $backup_path

echo starting docker backup

echo ""

echo - backing up images

echo ""

source backup-images.sh || exit

echo ""

echo - backing up volumes

echo ""

source backup-volumes.sh || exit

echo "Done."
