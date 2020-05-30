Assembly: Edge Lab Bring Up - RPi Version
==================

Return to [Edge Lab Overview](README.md) or [Bill of Materials](bill_of_materials.md).

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
  1. **Server**: https://s3-us-west-2.amazonaws.com/get.rebar.digital/edge-lab/rpi-server-v1.2.0.img.xz
1. Burn one copy of the server image (`rpi-server`) to an SD Card.
1. Burn copies of the client image (`rpi-client`) on your remaining SD Cards.

It is OK if you only have one card, you'll just need to boot the client RPi machines sequentially instead of in parallel.

NOTE: If you are planning on do a full k3s install, you will need SD cards for your client machines as well.  They are used
as container storage.

Assembly
------------

Like pictures?  Use the [visual assembly](assembly_visual.md) instructions.

NOTE: *DO NOT POWER THE SYSTEMS UNTIL INSTRUCTED!*

1. Assemble the mechanical environment, if needed
   1. For Cloudlet case, attach the fans and attach RPi boards to the riser cards.  Do not install the risers.
   2. For PoE HAT. attach the PoE boards and risers to the RPi
1. Identify all the RPi numbers 0 to 3.  It is helpful to mark them for future reference.
   1.  The server is RPi #0 for reference.
1. Wire the USB power lines to all the servers.   Skip this step is using PoE.
   1. Recommended: label the end of the cables to reflect which RPi is plugged into each one
1. Insert the SD Cards into the systems,
   1. Make sure to note which one has the server image.
1. Wire the Network cables to the Network Switch
    1. Order does not matter
    1. If you are using PoE, make sure the RPi systems are plugged into the PoE ports.
 1. Attach the mini-HDMI adapter to the server (RPi #0) card using HDMI port 0 (the one near the USBC connector.  Connect the HDMI port to a monitor.
 1. Attach the USB Keyboard to the server (RPi #0) card using any of the four USB ports.

Time to Power On!
----

See [Bootstrapping](bootstrapping.md) for next steps!
