## Install a minimal galaxy server with git

### Spin off a virtual Machine `bare-galaxy`
You may have already done this in the [previous section](spin_off_VM.md). If not, refer to this section
We are going to use a GCE VM 
- under Ubuntu 14.04
- 2 processors
- 7.5 Gb RAM
- a 100 Gb Volume (more than enough)

### Connect to the VM as explained in [previous section](spin_off_VM.md) using the ssh web console

### Installation of dependencies

To install Galaxy, we only need the `git` program installed and a limited number of command line.
We are going to execute these instruction as the `root` unix user. This is easier because installation
of new programs as well as manipulations of network interfaces is generally permitted only
to users with administration rights.

So let's do this step by step:

1. `sudo -i`

This command open a new "shell" where you are root. You can check this by typing `pwd` that
should return `/root/`, meaning that you are now working in the directory of the `root` user.

2. `apt-get install -y git`

This command install the `git program`. The `-y` option specifies to the `apt-get` package
installer that no confirmation is needed for this command.

3. `git clone https://github.com/galaxyproject/galaxy.git`

This command says to `git` to `clone` the code repository located at `https://github.com/galaxyproject/galaxy.git`.
You may try to visualize this URL [https://github.com/galaxyproject/galaxy.git](https://github.com/galaxyproject/galaxy.git)
in your web browser.

4. `cd galaxy`

This command shift you in the `galaxy` directory that was created by git

5. `cp config/galaxy.ini.sample config/galaxy.ini`

This command makes a copie of the `galaxy.ini.sample` file into `galaxy.ini` - in the
directory `config` that is in the `galaxy` directory.

6. `nano config/galaxy.ini`

With this command, we are going to edit some important settings that are required to run our galaxy instance.

- Find the line `#port = 8080` and edit it to `port = 80`

By doing this, we uncomment the line that becomes active to specify that the port `listen` by the
integrated galaxy web server will be the port `80`

- Find the line `#host = 127.0.0.1` and edit it to `host = 0.0.0.0`.

By doing this, we uncomment the line that specifies that the galaxy web server will listen the port `80 `
of **all available** network interfaces: in practical, you will be able to connect to you GCE VM from Pasteur or
anywhere else in the world.

- save your edits by pressing the key combination `Ctrl`+`o`
- quit nano by pressiong the key combination `Ctrl`+`x`

7. Ready for the Big Bang ?

Then type `sh run.sh` and press the `enter` key !

You should see an abundant log scrolling down. Don't worry !
- All Galaxy dependencies required for the Galaxy server instance are being downloaded and installed
- The Galaxy computing environment is automatically set up
- The Galaxy database is automatically upgraded to the latest structure
- Various tools are upgraded.

After a minute or so, you should see the log freezing with

```
Starting server in PID 3192.
serving on 0.0.0.0:80 view at http://127.0.0.1:80
```
8. Connect to your living Galaxy instance

If so, this is all good, and you can now access to you Galaxy instance in a you web browser window:

Go back to your Google Cloud Engine control panel. Find the `External IP address` / `Adresse IP externe`
in the 7th column of the Dashbord (to the left of the ssh menu that you used before. And just click on the hyperlink.









