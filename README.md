## "Run Galaxy" training prerequisites

There is two prerequisites for the training: a personal Gmail address and a tested Google Cloud Engine account;

#### 1. If you do not have one, subscribe for personal Gmail address.
Those who have already a Gmail address can work with it.

#### 2. Activate a Google Cloud Engine (GCE) account
1. Connect to [Google Cloud Engine](https://console.cloud.google.com/getting-started)
2. Click on `Essai Gratuit` / `Free Trial`
3. Enter your Gmail mail address and password
4. Review conditions and accept
5. Inscription Form:
  - `Type de compte` / `Account type` : Particulier / Personnal
  - `Nom et Adresse` / `Name and Address` : put your coordinates
  - `Type de paiement` / `Payment type` : `montly / mensuel` is enforced. __Note: you will *not* be charged for this free trial__
  - `Mode de paiement` / `Payment mode` : Put your credit card infos
6. Click `start free trial` / `Démarrer l'essai gratuit` (12 months __or__ 300 $ compute resources)
7. go to your [Google Cloud Console for compute engine](https://console.cloud.google.com/compute/)
to spin off and control your Virtual Machines

#### 3. Ensure that you are able to start and connect to a GCE Virtual Machine

1. Go to the [General Google Cloud Dashboard](https://console.cloud.google.com/home/dashboard) and select "Compute Engine" on the ad hoc panel
Alternatively, you can directly access the [Google Cloud Compute Engine Dashboard](https://console.cloud.google.com/compute/) 
2. Select the submenu "Instances de VM"
3. Click on the top bar menu the "CREER UNE INSTANCE" panel
![Créer une instance](docs/images/IntancesVM.png)
4. Put name "bare-galaxy"
5. Choose a Zone (suggestion: `europe-west1-c`)
6. Type de machine: choose 2 vCPU with 7.5 Memory
7. Disque de Démarrage: Click on `Modifier`
  - Select `Ubuntu 14.04 LTS`
  - At the bottom of the form, put 100 Go for the Disk Size (Taille)
  - Leave the selection `Disque persistant standard` / `Standard persistant drive`
  - Click `Select` / `Sélectionner`
8. Click `Authorize HTTP traffic` / `Autoriser le traffic HTTP`
9. Click `Créer` / `Create`

After a few seconds, the VM turns on "green" and an `ssh` menu becomes selectable
![Running instance](docs/images/Running_instance.png)

#### We are going to test that you are able to connect to you running VM using an ssh connection:

10. Roll down this `ssh` menu and select the first option `Ouvrir dans la fenêtre du navigateur`
![Select ssh session in browser](docs/images/Select_ssh_option.png)
11. A shell console pop out and you should now be ready to control your VM with linux command lines
![OpenningSSH](docs/images/OpeningSSHconnection.png)
![OpenningSSH](docs/images/SSHConsole.png)
12. Try to enter the your-login@bare-galaxy:~$ `sudo -i` command and hit the return key.
13. The unix prompt become `root@bare-galaxy:~# `, you are mastering your VM as root administrator !
14. You can turn off the VM and even trash it:
  - in one shot, go back to your VM control panel in the web browser, ensure that the running VM is checked, and press the Trash button in the top menu.
  - Confirm that you want to trash the VM and loose everything.
  - after a few seconds the VM disappears from the Dashboard.

## To perform the training session, you need now to access to the [supporting manual](https://artbio.github.io/startbio/Run-Galaxy/)
