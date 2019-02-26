# Commercium-Masternode-Single/Multi-Installer

> **Version 1.0.1:**

Login to your vps as root, download and run the install.sh file using this command:

```
curl -O https://raw.githubusercontent.com/PostJoke/masternode/master/install.sh > install.sh
bash install.sh
```


------

### Bash Updater for masternode on Ubuntu 16.04 LTS x64 <This script must be run as root user!>

------

> **Version 1.0.1:**

- Auto-update for update/install scripts Added.
- Update time becomes random for each vps.
- Debug log cleared every 2 days.
- Log file to UpdateNode shell added.
- This shell script can now be used either for a single update or Multi-vps update.

> **This shell script has 4 cronjobs:**

1. Scripts auto-update: [Check-scripts.sh](https://github.com/PostJoke/masternode/blob/master/Masternode/Check-scripts.sh)
2. Ensuring that the daemon never gets stuck: [daemon_check.sh](https://github.com/PostJoke/masternode/blob/master/Masternode/daemon_check.sh)
3. Log file clearing: [clearlog.sh](https://github.com/PostJoke/masternode/blob/master/Masternode/clearlog.sh)
4. Auto-update for Commercium Core: [UpdateNode.sh](https://github.com/PostJoke/masternode/blob/master/Masternode/UpdateNode.sh)

> **How to use:**

Login to your vps as root, download and run the Update.sh file using this command:

```
curl -O https://raw.githubusercontent.com/PostJoke/masternode/master/update.sh > update.sh
bash update.sh
```

> **Available options:**

1. **Update Masternode & Auto-update script**
2. **Update only the Auto-update script**
3. **Exit**

>#### **1. Update Masternode & Auto-update script:**

Updates the Commercium core & the update script, PS.available for both single and multi-vps update:

**1.1-Update a Single Masternode:**

```
Updates only the vps that runs the shell script.
```

**1.2- Update Multi-vps Masternode**

```
Updates all the vps that you will add using these two options here:

  1.2.1. Use the same SSH Port and Password for all vps's:
  
         Enter your vps ip's: (Exemple: 111.111.111.111-222.222.222.222-... )
         
         SSH port: (Exemple: 22 )
         
         password: (Exemple: Des53G2v3P )
         
  1.2.2. Use a different SSH Port and Password for each vps:
  
         Enter your vps data: 'Host:Password:SSHPort' ( Exemple: 111.111.111.111:ERdX5h64dSer:22-222.222.222.222:Wz65D232Fty:165-... )
```

>#### **2. Update the Auto-update script only:**

Updates only the shell scripts in your vps, PS.available for both single and multi-vps update.

>#### **3. Exit:**

Ends the Shell script.

------

### Bash Checker for Masternodes on Ubuntu 16.04 LTS x64 <This script must be run as root user!>

------

```
curl -O https://raw.githubusercontent.com/PostJoke/masternode/master/check-masternode.sh > check-masternode.sh
bash check-masternode.sh
```
