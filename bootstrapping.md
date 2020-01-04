
Edge Lab Bring Up - RPi Version
==================

Return to [Edge Lab Overview](README.md) or [Assembly](assembly.md).

This page explains how to build and install the Edge Lab.  Before starting, please acquire all the required items from the [Edge Lab Bill of Materials](bill_of_materials.md).

Prerequisites
----------------
The Edge Lab uses Wifi for the cluster internet gateway.   Make sure you know your SSID and password.

**You must have access to Wifi for the Edge Lab to function correctly.**

You need a SD Card download utility to create two different type images.  We recommend [Balena.io Etcher](https://github.com/balena-io/etcher) which has as simple UX and works on multiple platforms.

You'll need at least two 32 Gb SD Cards (four is recommended).   Since SD Cards look alike, consider marking each with a unique letter or number for reference.

This step takes some time, you can proceed with Assembly while you burn the cards.

1. Download the two images:
	 1. **Client**: https://s3-us-west-2.amazonaws.com/get.rebar.digital/edge-lab/rpi-client-v1.0.0.img.xz
     1. **Server**: https://s3-us-west-2.amazonaws.com/get.rebar.digital/edge-lab/rpi-server-v1.0.0.img.xz
1. Burn one copy of the server image (`rpi-server`) to an SD Card.
1. Burn copies of the client image (`rpi-client`) on your remaining SD Cards. 

It is OK if you only have one card, you'll just need to boot the client RPi machines sequentially instead of in parallel.

Assembly
------------
NOTE: *DO NOT POWER THE SYSTEMS UNTIL INSTRUCTED!*

1. Assemble the mechanical environment, if needed
   1. For Cloudlet case, attach the fans and attach RPi boards to the riser cards.  Do not install the risers.
   2. For PoE HAT. attach the PoE boards and risers to the RPi 
2. Identify all the RPi numbers 0 to 3.  It is helpful to mark them for future reference.
   1.  The server is RPi #0 for reference.
3. Wire the USB power lines to all the servers.   Skip this step is using PoE.
   1. Recommended: label the end of the cables to reflect which RPi is plugged into each one
4. Wire the Network cables to the Network Switch
    1. Order does not matter
    2. If you are using PoE, make sure the RPi systems are plugged into the PoE ports.
 1. Attach the mini-HDMI adapter to the server (RPi #0) card using HDMI port 0 (the one near the USBC connector.  Connect the HDMI port to a monitor.
 1. Attach the USB Keyboard to the server (RPi #0) card using any of the four USB ports.

Bootstrapping
-----------------
You will only need the USB Keyboard and HDMI monitor during the initial bootstrap.

1. Install the Server SD Card into RPi #0 (with the keyboard and hdmi connectors)
2. Install the Client SD Cards into the other RPi systems.
   1. If you only have one SD Card then you'll need to power the systems on one at a time after each one has been registered with Digital Rebar.
3. Power on the systems including both the Network Switch and all RPis.
   1.  The red lights should be on for all RPis.  The green lights will flash.
4. Wait for the systems to flash their BIOS and reboot.
   1. This may take several minutes for the initial bring up.  During
   2. During this time, the instructions on the SD Cards updating the BIOS and setting the systems to 64bit mode.
   3. There may not be any HDMI output during much of this initial process.
5. When the HDMI monitor shows a login prompt, login
   1. credentials are root/r0cketsk8ts
6. Run the start-up script on the host with your Wifi information.
   1. The command is `./start-up [Wifi SSID] [Wifi Password]`
   2. It's normal for the initial command to show "cannot connect" while the Wifi is configured
   3. If the command fails, simply try a second time
   4. At the end of the process, the Wifi IP address of RPi #0 will be shown
7. Use the Wifi IP address to access Digital Rebar running on RPi #0
   1. visit `https://[RPi #0 Address]:8092` to access Digital Rebar
   2. accept the self-signed SSL certificate
   3. you will be redirected to https://portal.rackn.io/ with the address of your local system already registered
   4. The RackN portal is connecting LOCALLY to RPi #0 via the Wifi network
   5. The other RPis will automatically PXE boot and register to Digital Rebar.
   6. Watch for machine registration from the "Machines" page
8. SSH to RPi #0 to generate an keypair for access to the other RPis
   1. SSH to RPi #0: `ssh root@[RPi #0 Address]` with `r0cketsk8ts` password.
   2. type `ssh-keygen` and hit enter for all the prompts
   3. copy the public key using `cat ~/.ssh/id_rsa.pub` 
   4. Install your public key in Digital Rebar
      1. Shortcut: use the "Add Key" button under "Info & Preferences" to have the public key automatically installed during machine discovery.
      2. See [Add SSH Keys](https://provision.readthedocs.io/en/latest/doc/faq-troubleshooting.html#add-ssh-keys-to-authorized-keys) in the [Digital Rebar Documentation](https://provision.readthedocs.io)

Bootstrapping is complete!

Clients run In-Memory O/S
---------------------------------
The non-server RPis are running in-memory operating systems so no configuration is saved to the local system.  You can reset the entire environment by simply resetting the power on the clients.