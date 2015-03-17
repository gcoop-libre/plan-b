SHELL := /bin/bash

deploy: deploy_bin deploy_cron

deploy_bin:
	parallel-ssh -v -h servers -h backups mkdir -p /tmp/plan-b.bin
	parallel-scp -v -h servers -h backups bin/* /tmp/plan-b.bin
	parallel-ssh -v -h servers -h backups sudo cp /tmp/plan-b.bin/* /bin

deploy_cron:
	parallel-scp -v -H servers cron.d/bz-backup /etc/cron.d/bz-backup
	parallel-ssh -v -h servers /etc/init.d/cron restart

