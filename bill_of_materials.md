Bill of Materials
==================

Return to [Edge Lab Overview](README.md) 

List of needed items for the Edge Lab with prices and links for ordering. 

We recommend a four Raspberry Pi system, but two is the minimum.

We’re offering multiple configurations based on your desktop real estate.  For starters, we recommend the Simple PoE since it reduces wiring; however, ordering the Cloudlet without the case is a less expensive option.

Once you have acquired the materials, consult the [Bootstrapping Guide](bootstrapping.md) for build instructions.

NOTES:
* The RPi 4B with 4GB RAM is the required minimum specification.  The Edge Lab design requires features of this model and in memory boot plus application requires 4 GB of RAM.
* The RPi 4B drAmazon 3.4 watts so plan for 5 watts per RPi when designing USB or PoE power.
* It is possible to combine Cloudcase and PoE choices.
* Amazon links provided for reference

Common Items
----

Required Items
1. Raspberry Pi 4 Model B 2019 (4GB) Quad Core 64 Bit WiFi Bluetooth [4 @ $65/each from [Amazon](https://www.amazon.com/Raspberry-Model-2019-Quad-Bluetooth/dp/B07TC2BK1X/ref=wl_mb_wl_huc_mrai_1_dp?ie=UTF8&pd_rd_i=B07TC2BK1X&pd_rd_r=R635T00HNVN2W0961XXB&pd_rd_w=q1GHd&pd_rd_wg=RXVTi&pf_rd_p=eef9c7bd-10f9-4dd2-8aa3-f83976b6a214&pf_rd_r=R635T00HNVN2W0961XXB)]
1. Micro SD Card (32+ Gb) [4 @ $7/each from [Amazon](https://www.amazon.com/gp/product/B06XWN9Q99/ref=ppx_yo_dt_b_asin_title_o00_s02?ie=UTF8&psc=1)]
1. Cat 6 Ethernet Cables [4 @ $9/5-pack from [Amazon](https://www.amazon.com/gp/product/B01IQWGKQ6/ref=ppx_yo_dt_b_asin_title_o00_s01?ie=UTF8&psc=1)]
1. Micro SD Card reader USB [1 @ $6/each from [Amazon](https://www.amazon.com/Saicoo-USB3-0-Slots-Reader-Micro/dp/B00CMKS2DI/ref=sr_1_21?keywords=micro+sd+card+usb&qid=1576369082&s=electronics&sr=1-21)]
1. Micro HDMI to HDMI Adapter Cable [1 @ $8/2-pack from [Amazon](https://www.amazon.com/GANA-Adapter-Female-Action-Supported/dp/B07K21HSQX/ref=wl_mb_wl_huc_mrai_2_dp?ie=UTF8&pd_rd_i=B07K21HSQX&pd_rd_r=4Z67NWY585QSZTZFV9GF&pd_rd_w=9CP1x&pd_rd_wg=8fupg&pf_rd_p=eef9c7bd-10f9-4dd2-8aa3-f83976b6a214&pf_rd_r=4Z67NWY585QSZTZFV9GF)]
1. HDMI Monitor (Bring your own)
1. USB Keyboard (Bring your own)

See lists below for power supplies.


Simple Stack with Power over Ethernet (PoE, approx $500)
----

[Picture Pending]

This approach minimizes the amount of cables by using power over ethernet.

Required Items
1. The common items listed above
1. PoE Gigabit Ethernet Switch (5+ ports) [1 @ $58/each from [Amazon](https://www.amazon.com/NETGEAR-Gigabit-Ethernet-Unmanaged-Desktop/dp/B01MRO4M73/ref=sr_1_2_sspa?crid=8JE1A74MSIIB&keywords=poe%2Bswitch%2B8%2Bport&qid=1578071369&s=electronics&sprefix=poe%2Bswitch%2Celectronics%2C173&sr=1-2-spons&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUExTTZXMzZJQ0RVSVdXJmVuY3J5cHRlZElkPUEwMzMzNjUzMThDTkVTT09HTkRKSiZlbmNyeXB0ZWRBZElkPUEwNzYyNDAxMkY4QVdHT0lIMVYxRyZ3aWRnZXROYW1lPXNwX2F0ZiZhY3Rpb249Y2xpY2tSZWRpcmVjdCZkb05vdExvZ0NsaWNrPXRydWU&th=1)]
1. PoE HAT for RPi [4 @ $30/each from [Amazon](https://www.amazon.com/dp/B07GR9XQJH?psc=1&pf_rd_p=d920f245-16d7-4d66-8ff3-66ebfa3d00fd&pf_rd_r=Z8Y2F7X2CB4ZRX9Y6WET&pd_rd_wg=sFlQw&pd_rd_i=B07GR9XQJH&pd_rd_w=mUNHk&pd_rd_r=9201e2db-2884-43d8-b329-25b49bbf8780&ref_=pd_luc_rh_crh_rh_sbs_sem_02_01_t_img_lh)]

Suggested Items
1. RPi Standoff Posts [2 @ $6/20-pack from [Amazon](https://www.amazon.com/gp/product/B0721SP83Q/ref=ox_sc_act_title_8?smid=A3OWUO30LQJ1NE&psc=1)]

USBC Power and Cloudlet Case (approx $450)
----

![Cloudlet Case Picture](images/cloudlet-case.jpg)

This approach scales out to 8 nodes and is visually appealing as a desktop cluster.

Required Items
1. The common items listed above
1. USB Power Hub (3A per port) [1 @ $30/each from [Amazon](https://www.amazon.com/gp/product/B00WI2DN4S/ref=ppx_yo_dt_b_asin_title_o00_s00?ie=UTF8&psc=1)]
1. USB Cables [4 @ 32/5-pack from [Amazon](https://www.amazon.com/gp/product/B07CZW75J5/ref=ppx_yo_dt_b_asin_title_o00_s00?ie=UTF8&psc=1)]
1. Gigabit Ethernet Switch (5+ ports) [1 @ $21/each from [Amazon](https://www.amazon.com/NETGEAR-8-Port-Gigabit-Ethernet-Unmanaged/dp/B07PFYM5MZ/ref=sr_1_1_sspa?crid=20G0PIEX2Z5IT&keywords=8+port+gigabit+switch&qid=1576369630&s=electronics&sprefix=8+port+%2Celectronics%2C178&sr=1-1-spons&psc=1&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUEyT05YOU1NTjBFQVAyJmVuY3J5cHRlZElkPUEwNjk1MjQ5MzNPOFZVMTVaOVZNTCZlbmNyeXB0ZWRBZElkPUEwNTg2NTQ3M0g2UldQU1BXUUhFRCZ3aWRnZXROYW1lPXNwX2F0ZiZhY3Rpb249Y2xpY2tSZWRpcmVjdCZkb05vdExvZ0NsaWNrPXRydWU=)]

Suggested Items
1. Cloudlet CASE (holds 8 RPi) [1 @ $60/each from [Amazon](https://www.amazon.com/gp/product/B07D5NM9ZG/ref=ppx_yo_dt_b_asin_title_o01_s00?ie=UTF8&psc=1)]

Next Step
---

[Cluster Assembly](assembly.md)!
