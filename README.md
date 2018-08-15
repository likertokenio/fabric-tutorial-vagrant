# Introduction
This REPO contains a Vagrant-based VM for running hyperledger fabric and composer examples and sample (include cloud9 IDE)

# Preparation
- Download and install vagrant (include virtualbox installation) on the host system from [vagrantup.com](https://www.vagrantup.com/downloads.html)
- If you are using windows 7, please use [vagrant 1.9.6 only](https://releases.hashicorp.com/vagrant/1.9.6/) and [Virtual Box 5.1.x](https://www.virtualbox.org/wiki/Download_Old_Builds_5_1)
- Download the `Vagrantfile` from this repo at this [link](https://raw.githubusercontent.com/suenchunhui/fabric-tutorial-vagrant/master/Vagrantfile) to an empty folder

# Settings
- Adjust the VM memory and number of cores, in the `Vagrantfile` using a text editor at the lines:
```
v.memory = 2048
v.cpus = 2
```

# Provisioning
- change directory to the folder containing the downloaded `Vagrantfile`
- run `vagrant up` from the commandline(OSX: terminal, Win: cmd.exe) to provision the entire system. Download and provisioning system can take a long up (up to 10-20mins)
- Once you reach the success screen output,
```
==> default:
==> default: tern_from_ts@0.0.1 node_modules/tern_from_ts
==> default: --------------------------------------------------------------------
==> default: Success!
==> default: run 'node server.js -p 8080 -a :' to launch Cloud9
==> default: ++ echo 'cd /cloud9 ; su ubuntu -c "nodejs server.js -l 0.0.0.0 -w /home/ubuntu --auth root:secret" &'
==> default: ++ cd /cloud9
==> default: ++ su ubuntu -c 'nodejs server.js -l 0.0.0.0 -w /home/ubuntu --auth root:secret'
```
- and the terminal command exits, you can open the browser based IDE at [10.10.10.201:8181](http://10.10.10.201:8181)
- login into the IDE using the default credentials `root` and `secret`

# Using fabric samples
The repo containing [hyperledger fabric samples](https://github.com/hyperledger/fabric-samples) are already downloaded inside the provisioned VM. You can use the browser IDE to run the sample scripts directly in the cloud9 IDE.

# Starting and stopping VM
Use `vagrant halt` to shutdown the VM (recommended before shutting down the computer)

Use `vagrant up` to start the VM again (After restarting computer, or after VM shutdown)

Use `vagrant destroy` to completely erase the entire VM, including all saved data.

# Starting composer-playground
Going to the `composer-playground` folder and start `./playground.sh` will bring up a 4-peer network with 1 orderer and 1 fabric-ca, and composer-playground at [http://10.10.10.201:8080](http://10.10.10.201:8080)
Have fun!

# Creating NetworkAdmin credentials for the playground
This command will enroll the root registrar inside the fabric-ca container itself, using the default password of fabric-ca.
```
docker exec -it ca.org1.example.com fabric-ca-client enroll -M registrar -u http://admin:adminpw@localhost:7054
```

Then, use this command to use the registrar credentials to register a new user (to be used as a NetworkAdmin for composer-playground).
```
docker exec -it ca.org1.example.com fabric-ca-client register -M registrar -u http://10.10.10.201:7054 --id.name <user_id> --id.affiliation org1 --id.attrs '"hf.Registrar.Roles=client"' --id.type user
```
Use the returned password and specified `user_id` as NetworkAdmin when deploying a new network inside the composer-playground. (ID and Secrets method in playground)

# Package to Vagrant Box
Packaging VM to Vagrant Box
```
$ ./build-vm.sh package
```
