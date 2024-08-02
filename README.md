# BR setup example

The Makefile serves as a wrapper so you can do any make command for buildroot as if you were in mainline buildroot, the setup script pulls in the mainline buildroot described in the script

It will either use the default output structure or you can pass O=${OUT_DIR} to use another output dir, by default make will always execute it's commands in the "output" folder

The external tree still needs to be setup with your own custom packages and configs
