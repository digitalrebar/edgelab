
Edge Lab Bring Up - RPi Version
==================

Return to [Edge Lab Overview](README.md) or [Assembly](assembly.md).

This page explains how to build and install the Edge Lab.  Before starting, please acquire all the required items from the [Edge Lab Bill of Materials](bill_of_materials.md).

**Follow [assembly steps](assembly.md) first!**

Video Tutorial (35 min)
-----

[![Video Tutorial](https://i9.ytimg.com/vi/Zb6_HRZxsIo/mq3.jpg?sqp=CLK5xPAF&rs=AOn4CLDT0G12hzlgYW1NAfu0PRPJ3H7d3w)](https://youtu.be/Zb6_HRZxsIo)

[Video](https://youtu.be/Zb6_HRZxsIo) includes a complete k3s install.

Bootstrapping
-----------------
You will only need the USB Keyboard and HDMI monitor during the initial bootstrap.

1. Confirm the [Server SD Card](https://s3-us-west-2.amazonaws.com/get.rebar.digital/edge-lab/rpi-server-v1.1.0.img.xz) is in RPi #0 (with the keyboard and hdmi connectors).
2. Confirm the [Client SD Cards](https://s3-us-west-2.amazonaws.com/get.rebar.digital/edge-lab/rpi-client-v1.0.0.img.xz) are inthe other RPi systems.
   1. If you only have one SD Card then you'll need to power the systems on one at a time after each one has been registered with Digital Rebar.
3. Power on the systems including both the Network Switch and all RPis.
   1.  The red lights should be on for all RPis.  The green lights will flash.
4. Wait for the systems to flash their BIOS and reboot.
   1. This may take several minutes for the initial bring up.  During
   2. During this time, the instructions on the SD Cards updating the BIOS and setting the systems to 64bit mode.
   3. There may not be any HDMI output during much of this initial process.
5. Get a command Prompt (two options)
     1. Credentials are root/r0cketsk8ts
     1. Via Monitor & Keyboard:
        1.When the HDMI monitor shows a login prompt, login
     1. Via IP Network:
        1. Attach a wired network connection from your client to the switch
        1. Configure your system to have a static IP (e.g.: 10.3.14.2 subnet 255.255.255.0)
        1. Ping test until the system is available
        1. On switch network, SSH to root@10.3.14.1
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

Bootstrapping is complete!

Fast Reset: Clients run In-Memory O/S
-------------------------

The non-server RPis are running in-memory operating systems so no configuration is saved to the local system.  You can reset the entire environment by simply resetting the power on the clients.

Depending on your development approach, you may want to also delete the associated machines, profiles and reservations from Digital Rebar.

Kubernetes (k3s) Install
-------------------

RackN [Digital Rebar Edge Lab Content](https://github.com/digitalrebar/provision-content/blob/edgelab/edge-lab/._Documentation.meta) includes simple instructions for installing k3s into your Edge Lab cluster.
