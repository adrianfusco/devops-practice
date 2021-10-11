# Devops Practice

Project using different tools just for practicing

## Description

This project use different tools to create a simple scenario. 
It has:

- A simple bash script that create an ansible control node and 10 managed nodes with dockers. I've used some docker commands inside the main script called launch. This script uses one docker-compose.yml file and two different dockerfiles, one for the control node and another for the managed nodes.
- Some ansible playbooks. I've used `ansible-playbook` to install some system packages and some python modules in all the controlled nodes (using the default "push" mode of ansible).
- SysV script: If you have tried to use `systemctl` commands in some docker images where usually accepts systemd maybe you've received the following message `System has not been booted with systemd as init system (PID 1). Can't operate.`, for this reason I've not prepared a systemd service. Instead of I've prepared a SysV script.
- A simple endpoint developed in Python using flask.
- Compiled Nginx used for web service.

## Usage

Create scenario:

```
bash launch.sh
```

Remove scenario:

```
bash launch.sh remove
```

## Authors and acknowledgment

Adrián Fusco
