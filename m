Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78D3B98F1B
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 11:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfHVJTB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 05:19:01 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:44242 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfHVJTA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Aug 2019 05:19:00 -0400
Received: by mail-qt1-f172.google.com with SMTP id 44so6741204qtg.11;
        Thu, 22 Aug 2019 02:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=glGLoM8BD6bui2GCTv8vtpyikMfHo4N2QySzBp5fv0U=;
        b=q1o4KrDqFlcrcgaGJ+NU6FFuemxWujumVtMjIOsxuj99H96mgmrWb/RrHsCySl4Fiu
         LiiW9f/jPo+Wzj3UJKVQbU+Fy53RzmBqp+0DJs0kFcrduOkdU9j3oKmWgeTr1QpC9g+u
         2n27qftYcVm2/eTshPtoavIGjf8mGxw4+/sME/FZ/8ThO4WuqIVEyKwGZ1UsUSqe8zf0
         YZhEImmOax23MG66m5zFdRDU4sFM1SbvzdPA7DNhnepconWM3F2D/gMcNl3lEA2lVABi
         D9s/LO9rnOZDISQHaWbJr3WcXxzPUC6JVdJhS9vfcpcij+HBJqauNIbkUDbF5QQhgV0T
         JZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=glGLoM8BD6bui2GCTv8vtpyikMfHo4N2QySzBp5fv0U=;
        b=bH6HHWo/7Zv7m4kq+wVyn1uohu1ZnRna44xCGQbCl41Xe3Xk89pvndF6i/JFxq2vnr
         EwI+CBRaHW3AdaqbNIdkH6h4hcm8853jA5N+YK9DcS9zh64t6eAc+n6TlGQtwjvuxpIz
         joP+iLR1roD2V+Xap2puI447LnAu0TWvHa8oQo+wAC8gF8n50v66pVz5Fy5RBAP/hn5N
         LHtuGETwLojk6zFGAXqA+iXtccc4jCBVI7oFS0xgpg/QXYEsVch34ORuG7hxVlftYXzk
         /+iaSeROVYQNN8WU+8UuI9/THzO7n7ug936aWj3L3vscCQTo/61xqDdOUw0ULwhwBSXX
         nHNw==
X-Gm-Message-State: APjAAAUh0HmRsLSxTdjkfaCgTWhULnSxx9Trkd6ZknDlHYu77/txU6Wv
        HMfmLcfSKp21+B7+6MwR+2YqLwRPgbDSL1UwLrc=
X-Google-Smtp-Source: APXvYqwQa4Uu+qAQByb2+qYo8T4l3GrehVyG5v+IPTVhmBcZ9TfNEFBqosJKKAap8LwBZyWYPdUElYBQrB2AAuroyQs=
X-Received: by 2002:aed:2e07:: with SMTP id j7mr34721218qtd.379.1566465535957;
 Thu, 22 Aug 2019 02:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAGgoGu5FfLFzCf0QiAd8UcMrZ7gtLyapgT3TZ-Hx0dknWy4LMQ@mail.gmail.com>
 <CAGgoGu4zP_7QpKHiXSkLfkb=zHEezBzstVfjQMQ4CO60+YubCw@mail.gmail.com>
 <CAGgoGu7rot61LSgu2syOMq9Onx26_u3PEtS7pf_QNQRxOaifhg@mail.gmail.com>
 <20190801171725.GD151852@google.com> <743ef7fab5144df69bfc8673fff7f0f7@SVR-IES-MBX-03.mgc.mentorg.com>
 <CAGgoGu4ZZR3ZVD5mx_oJN_8gwNM4fa=of=erwM+P8P7zzaMDrQ@mail.gmail.com>
In-Reply-To: <CAGgoGu4ZZR3ZVD5mx_oJN_8gwNM4fa=of=erwM+P8P7zzaMDrQ@mail.gmail.com>
From:   Fawad Lateef <fawadlateef@gmail.com>
Date:   Thu, 22 Aug 2019 11:18:44 +0200
Message-ID: <CAGgoGu5WP1qQUf4HS8xWGXUuP0L9vM6HGz1OZoGBBh1B67ZYSg@mail.gmail.com>
Subject: Re: Unhandled fault: imprecise external abort (0x1406) when loading
 xhci_pci.ko - uPD720202, PEX8605, iMX6Q and linux-4.19.25
To:     "Schmid, Carsten" <Carsten_Schmid@mentor.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

I started back with the issue and now trying with latest kernel 5.2.7
and still seeing same error "Unhandled fault: imprecise external abort
(0x1406) at xxxxxxx"; though this time it happens in different
conditions as mentioned below (with logs):

If I load the xhci-pci.ko driver, which then wait till timeout and
then gives error  -110 (as expected); then after loading the uPD720202
firmware (from user-space utility) I was able to see the USB 3.0 and
USB2.0 devices available through uPD chip (I couldn't connect any
external USB device to it yet as hardware prototype don't have power
support for external devices yet).

Then I did query usb-devices in a loop for 10 mins and it was good.
When tried to reboot Linux then during driver unloading stage saw the
crash from xhci-pci.ko driver (same error as above). So this means it
was working somehow then when doing pci bus shutdown it crashed.
(Didn't have log for it).

Though after reboot tried to load the driver again _without_ firmware
loaded into uPD and got crash number 1 and next power-cycle loaded the
firmware of uPD first then loaded the driver and got crash number 2
(crashes logs are below).

In all crash cases (when loading/unloading the driver); system stays
response, so I can look into any possible device status using PCIe
registers of PEX8605 switch or iMX6 PCIe root hub. Please suggest if
something I can check to better understand the issue.

Have a question that: Can I disable PCIe power management completely
using some kernel CONFIG option OR boot parameter? If yes then how?

Thanks


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Crash log number 1 =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

barebox 2017.12.0-bsp-yocto-i.mx6-pd18.1.1 #1 Thu Jul 25 13:13:48 UTC 2019


Board: Phytec phyCORE-i.MX6 Quad with eMMC
detected i.MX6 Quad revision 1.5
i.MX6 unique ID: ee7f9502211821d4
mdio_bus: miibus0: probed
eth0: got preset MAC address: 50:2d:f4:15:a9:fe
m25p80 flash@00: n25q128a13 (16384 Kbytes)
imx-usb 2184200.usb: USB EHCI 1.00
imx-esdhc 2190000.usdhc: registered as 2190000.usdhc
imx-esdhc 219c000.usdhc: registered as 219c000.usdhc
da9063 da90620: da9062 with id 62.22.ff.1a detected
state: New state registered 'state'
state: Using bucket 0@0x00000000
netconsole: registered as netconsole-1
phySOM-i.MX6: Using environment in MMC
malloc space: 0x4fefb480 -> 0x8fdf68ff (size 1023 MiB)
mmc3: detected MMC card version 5.0
mmc3: registered mmc3.boot0
mmc3: registered mmc3.boot1
mmc3: registered mmc3
running /env/bin/init...

Hit m for menu or any other key to stop autoboot:    1
bootchooser: Target list $global.bootchooser.targets is empty
Nothing bootable found on 'bootchooser'
booting 'emmc'

Loading ARM Linux zImage '/mnt/emmc/zImage'
Loading devicetree from '/mnt/emmc/oftree'
m25p0: Cannot find nodepath
/soc/aips-bus@02000000/spba-bus@02000000/ecspi@02008000/flash@0,
cannot fixup
Failed to fixup node in of_partition_fixup+0x1/0x1f4: Invalid argument
at24 24c320: Cannot find nodepath
/soc/aips-bus@02100000/i2c@021a8000/eeprom@50, cannot fixup
Failed to fixup node in of_partition_fixup+0x1/0x1f4: Invalid argument
Failed to fixup node in of_state_fixup+0x1/0x1f8: No such device
mmc3: Cannot find nodepath /soc/aips-bus@02100000/usdhc@0219c000, cannot fi=
xup
Failed to fixup node in of_partition_fixup+0x1/0x1f4: Invalid argument
commandline:  console=3Dttymxc1,115200n8  root=3D/dev/mmcblk1p2 rootwait rw
Starting kernel in secure mode
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.2.7-bsp-yocto-i.mx6-pd18.1.1
(flateef@flateef-XPS-13-9360) (gcc version 8.2.0 (Buildroot
2018.11.4-gebef590b)) #1 SMP Fri Aug 9 01:40:51 CEST 2019
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=3D10=
c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] OF: fdt: Machine model: PHYTEC phyBOARD-Mira Quad full
featured with eMMC
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 128 MiB at 0x38000000
[    0.000000] percpu: Embedded 16 pages/cpu s34764 r8192 d22580 u65536
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 52275=
2
[    0.000000] Kernel command line:  console=3Dttymxc1,115200n8
root=3D/dev/mmcblk1p2 rootwait rw
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 by=
tes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 byte=
s)
[    0.000000] Memory: 1934212K/2097152K available (8192K kernel code,
365K rwdata, 2628K rodata, 1024K init, 400K bss, 31868K reserved,
131072K cma-reserved, 1309804K highmem)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 10 jiffies.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] L2C-310 errata 752271 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
[    0.000000] random: get_random_bytes called from
start_kernel+0x250/0x424 with crng_init=3D0
[    0.000000] Switching to timer-based delay loop, resolution 333ns
[    0.000013] sched_clock: 32 bits at 3000kHz, resolution 333ns,
wraps every 715827882841ns
[    0.000045] clocksource: mxc_timer1: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 637086815595 ns
[    0.002968] Console: colour dummy device 80x30
[    0.003030] Calibrating delay loop (skipped), value calculated
using timer frequency.. 6.00 BogoMIPS (lpj=3D30000)
[    0.003059] pid_max: default: 32768 minimum: 301
[    0.003348] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.003389] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 by=
tes)
[    0.004509] CPU: Testing write buffer coherency: ok
[    0.004568] CPU0: Spectre v2: using BPIALL workaround
[    0.005031] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.006145] Setting up static identity map for 0x10100000 - 0x10100078
[    0.006425] rcu: Hierarchical SRCU implementation.
[    0.007172] smp: Bringing up secondary CPUs ...
[    0.008418] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.008434] CPU1: Spectre v2: using BPIALL workaround
[    0.010016] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.010028] CPU2: Spectre v2: using BPIALL workaround
[    0.011464] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.011475] CPU3: Spectre v2: using BPIALL workaround
[    0.011703] smp: Brought up 1 node, 4 CPUs
[    0.011727] SMP: Total of 4 processors activated (24.00 BogoMIPS).
[    0.011740] CPU: All CPU(s) started in SVC mode.
[    0.013492] devtmpfs: initialized
[    0.031394] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 4
[    0.031858] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.031897] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.044667] pinctrl core: initialized pinctrl subsystem
[    0.046434] NET: Registered protocol family 16
[    0.060586] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.061407] audit: initializing netlink subsys (disabled)
[    0.061690] audit: type=3D2000 audit(0.060:1): state=3Dinitialized
audit_enabled=3D0 res=3D1
[    0.062705] CPU identified as i.MX6Q, silicon rev 1.5
[    0.074210] vdd1p1: supplied by regulator-dummy
[    0.075120] vdd3p0: supplied by regulator-dummy
[    0.075959] vdd2p5: supplied by regulator-dummy
[    0.097934] No ATAGs?
[    0.098173] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.098198] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.100756] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
[    0.154851] mxs-dma 110000.dma-apbh: initialized
[    0.163251] SCSI subsystem initialized
[    0.164034] usbcore: registered new interface driver usbfs
[    0.164136] usbcore: registered new interface driver hub
[    0.164296] usbcore: registered new device driver usb
[    0.166910] i2c i2c-0: IMX I2C adapter registered
[    0.167826] i2c i2c-1: IMX I2C adapter registered
[    0.169127] i2c i2c-2: IMX I2C adapter registered
[    0.169535] pps_core: LinuxPPS API ver. 1 registered
[    0.169553] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.169597] PTP clock support registered
[    0.170884] Bluetooth: Core ver 2.22
[    0.170962] NET: Registered protocol family 31
[    0.170978] Bluetooth: HCI device and connection manager initialized
[    0.171005] Bluetooth: HCI socket layer initialized
[    0.171027] Bluetooth: L2CAP socket layer initialized
[    0.171073] Bluetooth: SCO socket layer initialized
[    0.171920] clocksource: Switched to clocksource mxc_timer1
[    0.172177] VFS: Disk quotas dquot_6.6.0
[    0.172313] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)
[    0.188838] NET: Registered protocol family 2
[    0.190035] tcp_listen_portaddr_hash hash table entries: 512
(order: 0, 6144 bytes)
[    0.190094] TCP established hash table entries: 8192 (order: 3, 32768 by=
tes)
[    0.190261] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.190532] TCP: Hash tables configured (established 8192 bind 8192)
[    0.190852] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.190930] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.191441] NET: Registered protocol family 1
[    0.192495] RPC: Registered named UNIX socket transport module.
[    0.192514] RPC: Registered udp transport module.
[    0.192529] RPC: Registered tcp transport module.
[    0.192544] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.192568] PCI: CLS 0 bytes, default 64
[    0.193834] hw perfevents: no interrupt-affinity property for /pmu, gues=
sing.
[    0.194231] hw perfevents: enabled with armv7_cortex_a9 PMU driver,
7 counters available
[    0.197197] Initialise system trusted keyrings
[    0.197495] workingset: timestamp_bits=3D30 max_order=3D19 bucket_order=
=3D0
[    0.207211] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.208285] NFS: Registering the id_resolver key type
[    0.208336] Key type id_resolver registered
[    0.208351] Key type id_legacy registered
[    0.208432] jffs2: version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
[    0.209258] fuse: init (API version 7.31)
[    0.213555] Key type asymmetric registered
[    0.213574] Asymmetric key parser 'x509' registered
[    0.213690] bounce: pool size: 64 pages
[    0.213717] io scheduler mq-deadline registered
[    0.213734] io scheduler kyber registered
[    0.218253] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 range=
s:
[    0.218332] imx6q-pcie 1ffc000.pcie:    IO 0x01f80000..0x01f8ffff
-> 0x00000000
[    0.218376] imx6q-pcie 1ffc000.pcie:   MEM 0x01000000..0x01efffff
-> 0x01000000
[    0.221980] imx-pgc-pd imx-pgc-power-domain.0: DMA mask not set
[    0.222196] imx-pgc-pd imx-pgc-power-domain.1: DMA mask not set
[    0.224609] 21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq =3D 63,
base_baud =3D 5000000) is a IMX
[    0.432333] imx6q-pcie 1ffc000.pcie: Link up
[    0.432347] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
[    0.432363] imx6q-pcie 1ffc000.pcie: Link up, Gen1
[    0.432674] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.432697] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.432716] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.432731] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01effff=
f]
[    0.432792] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    0.432847] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    0.432878] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    0.432992] pci 0000:00:00.0: supports D1
[    0.433008] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    0.443007] PCI: bus0: Fast back to back transfers disabled
[    0.452193] printk: console [ttymxc1] enabled
[    0.457166] pci 0000:01:00.0: [10b5:8605] type 01 class 0x060400
[    0.464536] 21ec000.serial: ttymxc2 at MMIO 0x21ec000 (irq =3D 64,
base_baud =3D 5000000) is a IMX
[    0.470814] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff]
[    1.043539] pci 0000:01:00.0: supports D1 D2
[    1.047835] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.054752] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s x1 link at 0000:00:00.0 (capable of 4.000 Gb/s
with 5 GT/s x1 link)
[    1.059340] brd: module loaded
[    1.089066] loop: module loaded
[    1.101829] PCI: bus1: Fast back to back transfers disabled
[    1.102644] at24 2-0050: 4096 byte 24c32 EEPROM, writable, 1 bytes/write
[    1.107513] pci 0000:01:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    1.117615] da9062 2-0058: Device detected (device-ID: 0x62,
var-ID: 0x22, DA9062)
[    1.123400] pci 0000:02:01.0: [10b5:8605] type 01 class 0x060400
[    1.136415] buck1: mapping for mode 2 not defined
[    1.137173] pci 0000:02:01.0: supports D1 D2
[    1.144346] buck2: mapping for mode 2 not defined
[    1.145452] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.152359] buck3: mapping for mode 2 not defined
[    1.158019] pci 0000:02:02.0: [10b5:8605] type 01 class 0x060400
[    1.164551] buck4: mapping for mode 2 not defined
[    1.168967] pci 0000:02:02.0: supports D1 D2
[    1.176186] vdd_snvs: Bringing 3100000uV into 3000000-3000000uV
[    1.176486] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.186298] vdd_high: Bringing 3100000uV into 3000000-3000000uV
[    1.190263] pci 0000:02:03.0: [10b5:8605] type 01 class 0x060400
[    1.198810] vdd_eth_io: Bringing 2600000uV into 2500000-2500000uV
[    1.202512] pci 0000:02:03.0: supports D1 D2
[    1.209634] random: fast init done
[    1.211406] pci 0000:02:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.215289] vdd_emmc: Bringing 1900000uV into 1800000-1800000uV
[    1.231272] PCI: bus2: Fast back to back transfers disabled
[    1.234287] ahci-imx 2200000.sata: fsl,transmit-level-mV not
specified, using 00000024
[    1.236932] pci 0000:02:01.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    1.244858] ahci-imx 2200000.sata: fsl,transmit-boost-mdB not
specified, using 00000480
[    1.252928] pci 0000:02:02.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    1.260883] ahci-imx 2200000.sata: fsl,transmit-atten-16ths not
specified, using 00002000
[    1.268986] pci 0000:02:03.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    1.277120] ahci-imx 2200000.sata: fsl,receive-eq-mdB not
specified, using 05000000
[    1.285968] pci 0000:03:00.0: [1912:0015] type 00 class 0x0c0330
[    1.295948] ahci-imx 2200000.sata: SSS flag set, parallel bus scan disab=
led
[    1.299167] pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit=
]
[    1.305937] ahci-imx 2200000.sata: AHCI 0001.0300 32 slots 1 ports
3 Gbps 0x1 impl platform mode
[    1.313805] pci 0000:03:00.0: PME# supported from D0 D3hot
[    1.321495] ahci-imx 2200000.sata: flags: ncq sntf stag pm led clo
only pmp pio slum part ccc apst
[    1.327382] pci 0000:03:00.0: 2.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s x1 link at 0000:00:00.0 (capable of 4.000 Gb/s
with 5 GT/s x1 link)
[    1.352674] scsi host0: ahci-imx
[    1.356786] ata1: SATA max UDMA/133 mmio [mem
0x02200000-0x02203fff] port 0x100 irq 67
[    1.369348] libphy: Fixed MDIO Bus: probed
[    1.374400] CAN device driver interface
[    1.381135] usbcore: registered new interface driver asix
[    1.386670] usbcore: registered new interface driver ax88179_178a
[    1.392885] usbcore: registered new interface driver cdc_ether
[    1.398790] usbcore: registered new interface driver net1080
[    1.404561] usbcore: registered new interface driver cdc_subset
[    1.410570] usbcore: registered new interface driver zaurus
[    1.411450] PCI: bus3: Fast back to back transfers disabled
[    1.416301] usbcore: registered new interface driver cdc_ncm
[    1.421808] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    1.427487] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.440654] ehci-pci: EHCI PCI platform driver
[    1.443946] PCI: bus4: Fast back to back transfers enabled
[    1.445215] ehci-platform: EHCI generic platform driver
[    1.450613] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    1.456352] ehci-mxc: Freescale On-Chip EHCI Host driver
[    1.472297] PCI: bus5: Fast back to back transfers enabled
[    1.472675] usbcore: registered new interface driver usb-storage
[    1.477814] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
[    1.490502] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 05
[    1.497351] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff=
]
[    1.503369] ci_hdrc ci_hdrc.1: EHCI Host Controller
[    1.504225] pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x013fffff=
]
[    1.509092] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus numb=
er 1
[    1.515872] pci 0000:00:00.0: BAR 9: assigned [mem
0x01400000-0x015fffff pref]
[    1.515892] pci 0000:00:00.0: BAR 6: assigned [mem
0x01600000-0x0160ffff pref]
[    1.537451] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[    1.543615] pci 0000:01:00.0: BAR 8: assigned [mem 0x01100000-0x012fffff=
]
[    1.550429] pci 0000:01:00.0: BAR 9: assigned [mem
0x01400000-0x015fffff 64bit pref]
[    1.551979] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    1.558220] pci 0000:01:00.0: BAR 0: assigned [mem 0x01300000-0x01303fff=
]
[    1.564882] hub 1-0:1.0: USB hub found
[    1.570448] pci 0000:01:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[    1.574325] hub 1-0:1.0: 1 port detected
[    1.580326] pci 0000:02:01.0: BAR 8: assigned [mem 0x01100000-0x012fffff=
]
[    1.589036] da9063-rtc da9062-rtc: DMA mask not set
[    1.591060] pci 0000:02:01.0: BAR 9: assigned [mem
0x01400000-0x015fffff 64bit pref]
[    1.603738] pci 0000:02:01.0: BAR 7: assigned [io  0x1000-0x1fff]
[    1.606664] da9063-rtc da9062-rtc: registered as rtc1
[    1.609865] pci 0000:03:00.0: BAR 0: assigned [mem
0x01100000-0x01101fff 64bit]
[    1.609986] pci 0000:02:01.0: PCI bridge to [bus 03]
[    1.616452] rtc-m41t80 0-0068: Can't clear HT bit
[    1.622326] pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
[    1.622386] pci 0000:02:01.0:   bridge window [mem 0x01100000-0x012fffff=
]
[    1.629545] snvs_rtc 20cc000.snvs:snvs-rtc-lp: registered as rtc2
[    1.632084] pci 0000:02:01.0:   bridge window [mem
0x01400000-0x015fffff 64bit pref]
[    1.638453] i2c /dev entries driver
[    1.645047] pci 0000:02:02.0: PCI bridge to [bus 04]
[    1.657127] Bluetooth: HCI UART driver ver 2.3
[    1.659016] pci 0000:02:03.0: PCI bridge to [bus 05]
[    1.662398] Bluetooth: HCI UART protocol H4 registered
[    1.667487] pci 0000:01:00.0: PCI bridge to [bus 02-05]
[    1.672724] sdhci: Secure Digital Host Controller Interface driver
[    1.676837] pci 0000:01:00.0:   bridge window [io  0x1000-0x1fff]
[    1.681953] sdhci: Copyright(c) Pierre Ossman
[    1.687223] pci 0000:01:00.0:   bridge window [mem 0x01100000-0x012fffff=
]
[    1.693399] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.699522] pci 0000:01:00.0:   bridge window [mem
0x01400000-0x015fffff 64bit pref]
[    1.705765] sdhci-esdhc-imx 2190000.usdhc: Got CD GPIO
[    1.710726] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    1.734550] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    1.740665] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x013fffff=
]
[    1.747496] pci 0000:00:00.0:   bridge window [mem
0x01400000-0x015fffff pref]
[    1.750623] mmc0: SDHCI controller on 2190000.usdhc [2190000.usdhc]
using ADMA
[    1.755501] pcieport 0000:00:00.0: PME: Signaling with IRQ 310
[    1.768591] pcieport 0000:00:00.0: AER: enabled with IRQ 310
[    1.774932] pcieport 0000:01:00.0: enabling device (0140 -> 0143)
[    1.783212] pcieport 0000:02:01.0: enabling device (0140 -> 0143)
[    1.796922] pci 0000:03:00.0: enabling device (0140 -> 0142)
[    1.801987] mmc1: SDHCI controller on 219c000.usdhc [219c000.usdhc]
using ADMA
[    1.833410] leds-pca953x 0-0062: setting platform data
[    1.840035] gpio gpiochip7: GPIO integer space overlap, cannot add chip
[    1.846735] gpiochip_add_data_with_key: GPIOs 0..3 (gpio-pca9532)
failed to register, -16
[    1.854969] leds-pca953x 0-0062: could not add gpiochip
[    1.861998] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.867613] caam 2100000.caam: Entropy delay =3D 3200
[    1.869042] ata1.00: ATA-10: ADATA SU800NS38, R0427AC, max UDMA/133
[    1.879422] ata1.00: 250069680 sectors, multi 16: LBA48 NCQ (depth 32)
[    1.886669] ata1.00: configured for UDMA/133
[    1.933950] caam 2100000.caam: Instantiated RNG4 SH0
[    1.994710] caam 2100000.caam: Instantiated RNG4 SH1
[    1.999700] caam 2100000.caam: device ID =3D 0x0a16010000000000 (Era 4)
[    2.006182] caam 2100000.caam: job rings =3D 2, qi =3D 0
[    2.072565] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[    2.079296] mmc1: new DDR MMC card at address 0001
[    2.086681] mmcblk1: mmc1:0001 Q2J55L 7.09 GiB
[    2.093250] mmcblk1boot0: mmc1:0001 Q2J55L partition 1 16.0 MiB
[    2.123862] mmcblk1boot1: mmc1:0001 Q2J55L partition 2 16.0 MiB
[    2.130194] mmcblk1rpmb: mmc1:0001 Q2J55L partition 3 4.00 MiB,
chardev (247:0)
[    2.143013]  mmcblk1: p1 p2
[    2.283623] hub 1-1:1.0: USB hub found
[    2.287611] hub 1-1:1.0: 4 ports detected
[    2.621963] usb 1-1.4: new high-speed USB device number 3 using ci_hdrc
[    2.773484] hub 1-1.4:1.0: USB hub found
[    2.777610] hub 1-1.4:1.0: 4 ports detected
[    3.101966] usb 1-1.4.1: new full-speed USB device number 4 using ci_hdr=
c
[    8.747630] pci 0000:03:00.0: xHCI HW not ready after 5 sec (HC
bug?) status =3D 0x801
[    8.755547] pci 0000:03:00.0: quirk_usb_early_handoff+0x0/0x7e0
took 6795527 usecs
[    8.764593] scsi 0:0:0:0: Direct-Access     ATA      ADATA
SU800NS38  7AC  PQ: 0 ANSI: 5
[    8.774511] sd 0:0:0:0: [sda] 250069680 512-byte logical blocks:
(128 GB/119 GiB)
[    8.782235] sd 0:0:0:0: [sda] Write Protect is off
[    8.787290] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    8.796955] caam algorithms registered in /proc/crypto
[    8.799650]  sda: sda1 sda2
[    8.808296] sd 0:0:0:0: [sda] Attached SCSI disk
[    8.814588] caam_jr 2101000.jr0: registering rng-caam
[    8.820571] hidraw: raw HID events driver (C) Jiri Kosina
[    8.826405] usbcore: registered new interface driver usbhid
[    8.832029] usbhid: USB HID core driver
[    8.840054] NET: Registered protocol family 10
[    8.846091] Segment Routing with IPv6
[    8.849909] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    8.857015] NET: Registered protocol family 17
[    8.861494] can: controller area network core (rev 20170425 abi 9)
[    8.867914] NET: Registered protocol family 29
[    8.872416] can: raw protocol (rev 20170425)
[    8.876702] can: broadcast manager protocol (rev 20170425 t)
[    8.882454] can: netlink gateway (rev 20170425) max_hops=3D1
[    8.888236] 8021q: 802.1Q VLAN Support v1.8
[    8.892543] Key type dns_resolver registered
[    8.897466] vddarm: supplied by vdd_arm
[    8.902567] vddpu: supplied by vdd_soc
[    8.907413] vddsoc: supplied by vdd_soc
[    8.913956] Registering SWP/SWPB emulation handler
[    8.919910] Loading compiled-in X.509 certificates
[    8.941504] imx_thermal tempmon: Automotive CPU temperature grade -
max:125C critical:120C passive:115C
[    8.952742] hctosys: unable to open rtc device (rtc0)
[    8.958420] VCC_CAM0: disabling
[    8.961574] flexcan1-reg: disabling
[    8.965102] usb_otg_vbus: disabling
[    8.968600] peb-display: disabling
[    8.972735] vdd_eth_io: disabling
[    9.234016] EXT4-fs (mmcblk1p2): recovery complete
[    9.239575] EXT4-fs (mmcblk1p2): mounted filesystem with ordered
data mode. Opts: (null)
[    9.247752] VFS: Mounted root (ext4 filesystem) on device 179:2.
[    9.256504] devtmpfs: mounted
[    9.262033] Freeing unused kernel memory: 1024K
[    9.266858] Run /sbin/init as init process
[    9.364136] EXT4-fs (mmcblk1p2): re-mounted. Opts: (null)
Starting rsyslog daemon: OK
Starting auditd: OK
Starting mdev...
modprobe: can't load module xhci_pci (kernel/drivers/usb/host/xhc[
10.117274] usbcore: registered new interface driver usbserial_generic
i-pci.ko): No such file or direct[   10.125906] usbserial: USB Serial
support registered for generic
ory
[   10.142323] usbcore: registered new interface driver ftdi_sio
[   10.148277] usbserial: USB Serial support registered for FTDI USB
Serial Device
[   10.164601] ftdi_sio 1-1.4.1:1.0: FTDI USB Serial Device converter detec=
ted
[   10.171848] usb 1-1.4.1: Detected FT232RL
[   10.177424] usb 1-1.4.1: FTDI USB Serial Device converter now
attached to ttyUSB0
Starting irqbalance: OK
Initializing random number generator... [   10.298126] random: dd:
uninitialized urandom read (512 bytes read)
done.
Starting system message bus: [   10.347151] random: dbus-uuidgen:
uninitialized urandom read (12 bytes read)
[   10.354381] random: dbus-uuidgen: uninitialized urandom read (8 bytes re=
ad)
done
Starting network: Waiting for interface wlan0 to appear....

........... timeout!
run-parts: /etc/network/if-pre-up.d/wait_iface: exit status 1
FAIL
Starting ntpd: OK
Starting nginx...
[   25.883748] urandom_read: 2 callbacks suppressed
[   25.883756] random: ssh-keygen: uninitialized urandom read (32 bytes rea=
d)
Starting sshd: [   25.920082] random: sshd: uninitialized urandom read
(32 bytes read)
OK

Welcome to iMX6
buildroot-imx6 login: root
Password:
#
#  insmod  /lib/modules/5.2.7-bsp-yocto-i.mx6-pd18.1.1/kernel/drivers/usb/h=
ost/x
hci-pci1.ko
[   50.709359] xhci_hcd 0000:03:00.0: xHCI Host Controller
[   50.715056] xhci_hcd 0000:03:00.0: new USB bus registered, assigned
bus number 2

[   56.943873] Unhandled fault: imprecise external abort (0x1406) at 0x01d8=
7004
[   56.950944] pgd =3D (ptrval)
[   56.953663] [01d87004] *pgd=3D8c181831
[   56.957262] Internal error: : 1406 [#1] SMP ARM
[   56.961804] Modules linked in: xhci_pci(+) ftdi_sio usbserial xhci_hcd
[   56.968375] CPU: 3 PID: 365 Comm: insmod Not tainted
5.2.7-bsp-yocto-i.mx6-pd18.1.1 #1
[   56.976302] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   56.982970] PC is at xhci_handshake+0x78/0xfc [xhci_hcd]
[   56.988315] LR is at __timer_delay+0x3c/0x88
[   56.992597] pc : [<bf001d80>]    lr : [<c085992c>]    psr: 600d0013
[   56.998874] sp : e4b0dbd8  ip : 43617a80  fp : c0b388d4
[   57.004111] r10: 000346dc  r9 : 00000000  r8 : 00989680
[   57.009348] r7 : f096a020  r6 : 00000000  r5 : 00000002  r4 : 00000000
[   57.015886] r3 : 00000000  r2 : 7fffd540  r1 : 00000000  r0 : 00000002
[   57.022430] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 none
[   57.029577] Control: 10c5387d  Table: 3493804a  DAC: 00000051
[   57.035336] Process insmod (pid: 365, stack limit =3D 0x(ptrval))
[   57.041267] Stack: (0xe4b0dbd8 to 0xe4b0e000)
[   57.045641] dbc0:
    233ec4e3 0000000e
[   57.053838] dbe0: d026d750 e4442158 00000000 00000002 bf024494
00000000 e45b9878 00000006
[   57.062035] dc00: c0d05148 bf002c24 bf024494 00000000 e4442000
e4442000 e4442158 bf003430
[   57.070232] dc20: 00000030 5a6c0a29 e4b0dc3c e4442000 e45b9800
e4442000 00000000 00000080
[   57.078428] dc40: e44420c0 bf024b88 e4442000 00000000 c0d05148
c05c85b0 00000cc0 e45b9800
[   57.086623] dc60: e4a51000 5a6c0a29 00000001 e45b9800 bf025094
e4442000 bf026088 00000001
[   57.094819] dc80: 00000000 00000006 c0d05148 c05d9f74 00000000
00000000 0000003c e45b9878
[   57.103016] dca0: c0d05148 e45b9800 e45b996c bf026000 00000000
bf026088 bf025094 00000006
[   57.111213] dcc0: c0d05148 bf0240d0 e45b9878 e45b9800 bf026000
00000000 bf026038 bf025094
[   57.119410] dce0: 00000006 c045d18c e45b9878 c0db5b34 c0db5b38
00000000 00000000 bf026038
[   57.127608] dd00: 00000006 c04e17c4 e45b9878 bf026038 bf026038
c0d05148 ffffe000 00000028
[   57.135804] dd20: bf026140 c04e1afc 00000cc0 00000000 00000000
e45b9878 00000000 bf026038
[   57.144000] dd40: c0d05148 ffffe000 00000028 c04e1da8 00000000
bf026038 e45b9878 c04e1e08
[   57.152197] dd60: e45f43b4 bf026038 c04e1db0 c04dfca8 00000028
e416bb58 e45f43b4 5a6c0a29
[   57.160393] dd80: c0d1f6fc bf026038 e49e6e80 c0d1f6fc 00000000
c04e0ce4 bf0250cc 00000000
[   57.168589] dda0: bf026038 bf026038 c0d05148 bf029000 00000000
c04e2658 c0d5b800 c0d05148
[   57.176785] ddc0: bf029000 c0102738 8040003f e4912c80 00000000
5a6c0a29 e4b0ddd4 e744a240
[   57.184980] dde0: e744a240 ffffe000 8040003e 00000002 e4a49940
5a6c0a29 00000000 c0874e7c
[   57.193176] de00: 00000cc0 e4001e40 c0d05148 c021ecd0 bf026140
5a6c0a29 bf026140 e4a49a00
[   57.201371] de20: e4a49900 00000002 e4a49940 c019d004 00000002
e4a49900 e4b0df30 00000002
[   57.209567] de40: e4a49900 c019f320 bf02614c 00007fff bf026140
c019c134 00000041 bf026188
[   57.217763] de60: 01d87150 bf026254 bf02bb38 bf026140 bf026300
c0903efc 00000000 c0ab0e20
[   57.225957] de80: 00000001 00000000 c0b5e5ec c0b4f1ec 00000000
00000000 00000000 00000000
[   57.234152] dea0: 00000000 00000000 6e72656b 00006c65 00000000
00000000 00000000 00000000
[   57.242346] dec0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   57.250543] dee0: 00000000 5a6c0a29 7fffffff c0d05148 00000000
00000003 01d87150 7fffffff
[   57.258737] df00: 00000000 0000017b 00000000 c019f764 7fffffff
00000000 00000003 e48f8008
[   57.266933] df20: 00000001 f0800000 00002ea8 00000000 f0800de7
f0801780 f0800000 00002ea8
[   57.275129] df40: f08028e0 f080275c f08020c8 00003000 00003260
00002aec 000033c1 00000000
[   57.283324] df60: 00000000 00000000 00002adc 00000022 00000023
0000001c 00000018 00000016
[   57.291520] df80: 00000000 5a6c0a29 beb20f08 01d87150 ffffffff
beb20f08 0000017b c0101204
[   57.299715] dfa0: e4b0c000 c01011e0 01d87150 ffffffff 00000003
01d87150 00000000 beb20f08
[   57.307911] dfc0: 01d87150 ffffffff beb20f08 0000017b 00000000
00000000 b6fa1000 00000000
[   57.316106] dfe0: beb20c68 beb20c58 00027a1c b6ed7bf0 600d0010
00000003 00000000 00000000
[   57.324472] [<bf001d80>] (xhci_handshake [xhci_hcd]) from
[<bf002c24>] (xhci_reset+0x7c/0x168 [xhci_hcd])
[   57.334189] [<bf002c24>] (xhci_reset [xhci_hcd]) from [<bf003430>]
(xhci_gen_setup+0x1a4/0x308 [xhci_hcd])
[   57.343943] [<bf003430>] (xhci_gen_setup [xhci_hcd]) from
[<bf024b88>] (xhci_pci_setup+0x40/0x8c [xhci_pci])
[   57.353821] [<bf024b88>] (xhci_pci_setup [xhci_pci]) from
[<c05c85b0>] (usb_add_hcd+0x278/0x76c)
[   57.362646] [<c05c85b0>] (usb_add_hcd) from [<c05d9f74>]
(usb_hcd_pci_probe+0x200/0x36c)
[   57.370773] [<c05d9f74>] (usb_hcd_pci_probe) from [<bf0240d0>]
(xhci_pci_probe+0x2c/0x194 [xhci_pci])
[   57.380037] [<bf0240d0>] (xhci_pci_probe [xhci_pci]) from
[<c045d18c>] (pci_device_probe+0xa4/0x138)
[   57.389203] [<c045d18c>] (pci_device_probe) from [<c04e17c4>]
(really_probe+0xec/0x2c8)
[   57.397234] [<c04e17c4>] (really_probe) from [<c04e1afc>]
(driver_probe_device+0x5c/0x160)
[   57.405523] [<c04e1afc>] (driver_probe_device) from [<c04e1da8>]
(device_driver_attach+0x58/0x60)
[   57.414416] [<c04e1da8>] (device_driver_attach) from [<c04e1e08>]
(__driver_attach+0x58/0xcc)
[   57.422963] [<c04e1e08>] (__driver_attach) from [<c04dfca8>]
(bus_for_each_dev+0x70/0xb4)
[   57.431162] [<c04dfca8>] (bus_for_each_dev) from [<c04e0ce4>]
(bus_add_driver+0x194/0x1cc)
[   57.439449] [<c04e0ce4>] (bus_add_driver) from [<c04e2658>]
(driver_register+0x74/0x108)
[   57.447566] [<c04e2658>] (driver_register) from [<c0102738>]
(do_one_initcall+0x6c/0x1c8)
[   57.455780] [<c0102738>] (do_one_initcall) from [<c019d004>]
(do_init_module+0x58/0x230)
[   57.463899] [<c019d004>] (do_init_module) from [<c019f320>]
(load_module+0x20dc/0x22dc)
[   57.471929] [<c019f320>] (load_module) from [<c019f764>]
(sys_finit_module+0xbc/0xdc)
[   57.479780] [<c019f764>] (sys_finit_module) from [<c01011e0>]
(__sys_trace_return+0x0/0x20)
[   57.488141] Exception stack(0xe4b0dfa8 to 0xe4b0dff0)
[   57.493212] dfa0:                   01d87150 ffffffff 00000003
01d87150 00000000 beb20f08
[   57.501409] dfc0: 01d87150 ffffffff beb20f08 0000017b 00000000
00000000 b6fa1000 00000000
[   57.509599] dfe0: beb20c68 beb20c58 00027a1c b6ed7bf0
[   57.514671] Code: e12fff33 e5973000 e1a01003 ee074f9a (e0052003)
[   57.520782] ---[ end trace dada3d605486cdd8 ]---
Segmentation fault
#


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D Crash log number 2 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

barebox 2017.12.0-bsp-yocto-i.mx6-pd18.1.1 #1 Thu Jul 25 13:13:48 UTC 2019


Board: Phytec phyCORE-i.MX6 Quad with eMMC
detected i.MX6 Quad revision 1.5
i.MX6 unique ID: ee7f9502211821d4
mdio_bus: miibus0: probed
eth0: got preset MAC address: 50:2d:f4:15:a9:fe
m25p80 flash@00: n25q128a13 (16384 Kbytes)
imx-usb 2184200.usb: USB EHCI 1.00
imx-esdhc 2190000.usdhc: registered as 2190000.usdhc
imx-esdhc 219c000.usdhc: registered as 219c000.usdhc
da9063 da90620: da9062 with id 62.22.ff.1a detected
state: New state registered 'state'
state: Using bucket 0@0x00000000
netconsole: registered as netconsole-1
phySOM-i.MX6: Using environment in MMC
malloc space: 0x4fefb480 -> 0x8fdf68ff (size 1023 MiB)
mmc3: detected MMC card version 5.0
mmc3: registered mmc3.boot0
mmc3: registered mmc3.boot1
mmc3: registered mmc3
running /env/bin/init...

Hit m for menu or any other key to stop autoboot:    0
bootchooser: Target list $global.bootchooser.targets is empty
Nothing bootable found on 'bootchooser'
booting 'emmc'

Loading ARM Linux zImage '/mnt/emmc/zImage'
Loading devicetree from '/mnt/emmc/oftree'
m25p0: Cannot find nodepath
/soc/aips-bus@02000000/spba-bus@02000000/ecspi@02008000/flash@0,
cannot fixup
Failed to fixup node in of_partition_fixup+0x1/0x1f4: Invalid argument
at24 24c320: Cannot find nodepath
/soc/aips-bus@02100000/i2c@021a8000/eeprom@50, cannot fixup
Failed to fixup node in of_partition_fixup+0x1/0x1f4: Invalid argument
Failed to fixup node in of_state_fixup+0x1/0x1f8: No such device
mmc3: Cannot find nodepath /soc/aips-bus@02100000/usdhc@0219c000, cannot fi=
xup
Failed to fixup node in of_partition_fixup+0x1/0x1f4: Invalid argument
commandline:  console=3Dttymxc1,115200n8  root=3D/dev/mmcblk1p2 rootwait rw
Starting kernel in secure mode
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.2.7-bsp-yocto-i.mx6-pd18.1.1
(flateef@flateef-XPS-13-9360) (gcc version 8.2.0 (Buildroot
2018.11.4-gebef590b)) #1 SMP Fri Aug 9 01:40:51 CEST 2019
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=3D10=
c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] OF: fdt: Machine model: PHYTEC phyBOARD-Mira Quad full
featured with eMMC
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 128 MiB at 0x38000000
[    0.000000] percpu: Embedded 16 pages/cpu s34764 r8192 d22580 u65536
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 52275=
2
[    0.000000] Kernel command line:  console=3Dttymxc1,115200n8
root=3D/dev/mmcblk1p2 rootwait rw
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 by=
tes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 byte=
s)
[    0.000000] Memory: 1934212K/2097152K available (8192K kernel code,
365K rwdata, 2628K rodata, 1024K init, 400K bss, 31868K reserved,
131072K cma-reserved, 1309804K highmem)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 10 jiffies.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] L2C-310 errata 752271 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
[    0.000000] random: get_random_bytes called from
start_kernel+0x250/0x424 with crng_init=3D0
[    0.000000] Switching to timer-based delay loop, resolution 333ns
[    0.000015] sched_clock: 32 bits at 3000kHz, resolution 333ns,
wraps every 715827882841ns
[    0.000048] clocksource: mxc_timer1: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 637086815595 ns
[    0.002967] Console: colour dummy device 80x30
[    0.003027] Calibrating delay loop (skipped), value calculated
using timer frequency.. 6.00 BogoMIPS (lpj=3D30000)
[    0.003055] pid_max: default: 32768 minimum: 301
[    0.003347] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.003390] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 by=
tes)
[    0.004513] CPU: Testing write buffer coherency: ok
[    0.004573] CPU0: Spectre v2: using BPIALL workaround
[    0.005037] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.006162] Setting up static identity map for 0x10100000 - 0x10100078
[    0.006439] rcu: Hierarchical SRCU implementation.
[    0.007181] smp: Bringing up secondary CPUs ...
[    0.008430] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.008441] CPU1: Spectre v2: using BPIALL workaround
[    0.010029] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.010041] CPU2: Spectre v2: using BPIALL workaround
[    0.011478] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.011490] CPU3: Spectre v2: using BPIALL workaround
[    0.011712] smp: Brought up 1 node, 4 CPUs
[    0.011734] SMP: Total of 4 processors activated (24.00 BogoMIPS).
[    0.011748] CPU: All CPU(s) started in SVC mode.
[    0.013487] devtmpfs: initialized
[    0.031377] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 4
[    0.031850] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.031887] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.044638] pinctrl core: initialized pinctrl subsystem
[    0.046412] NET: Registered protocol family 16
[    0.060569] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.061389] audit: initializing netlink subsys (disabled)
[    0.061721] audit: type=3D2000 audit(0.060:1): state=3Dinitialized
audit_enabled=3D0 res=3D1
[    0.062738] CPU identified as i.MX6Q, silicon rev 1.5
[    0.074208] vdd1p1: supplied by regulator-dummy
[    0.075101] vdd3p0: supplied by regulator-dummy
[    0.075947] vdd2p5: supplied by regulator-dummy
[    0.097942] No ATAGs?
[    0.098179] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.098204] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.100772] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
[    0.155225] mxs-dma 110000.dma-apbh: initialized
[    0.163618] SCSI subsystem initialized
[    0.164408] usbcore: registered new interface driver usbfs
[    0.164509] usbcore: registered new interface driver hub
[    0.164666] usbcore: registered new device driver usb
[    0.167291] i2c i2c-0: IMX I2C adapter registered
[    0.168222] i2c i2c-1: IMX I2C adapter registered
[    0.169594] i2c i2c-2: IMX I2C adapter registered
[    0.169934] pps_core: LinuxPPS API ver. 1 registered
[    0.169952] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.169995] PTP clock support registered
[    0.171262] Bluetooth: Core ver 2.22
[    0.171340] NET: Registered protocol family 31
[    0.171357] Bluetooth: HCI device and connection manager initialized
[    0.171383] Bluetooth: HCI socket layer initialized
[    0.171405] Bluetooth: L2CAP socket layer initialized
[    0.171445] Bluetooth: SCO socket layer initialized
[    0.172417] clocksource: Switched to clocksource mxc_timer1
[    0.172673] VFS: Disk quotas dquot_6.6.0
[    0.172809] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)
[    0.189479] NET: Registered protocol family 2
[    0.190668] tcp_listen_portaddr_hash hash table entries: 512
(order: 0, 6144 bytes)
[    0.190725] TCP established hash table entries: 8192 (order: 3, 32768 by=
tes)
[    0.190885] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.191155] TCP: Hash tables configured (established 8192 bind 8192)
[    0.191489] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.191571] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.192084] NET: Registered protocol family 1
[    0.193064] RPC: Registered named UNIX socket transport module.
[    0.193084] RPC: Registered udp transport module.
[    0.193099] RPC: Registered tcp transport module.
[    0.193113] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.193138] PCI: CLS 0 bytes, default 64
[    0.194396] hw perfevents: no interrupt-affinity property for /pmu, gues=
sing.
[    0.194829] hw perfevents: enabled with armv7_cortex_a9 PMU driver,
7 counters available
[    0.197803] Initialise system trusted keyrings
[    0.198115] workingset: timestamp_bits=3D30 max_order=3D19 bucket_order=
=3D0
[    0.207805] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.208883] NFS: Registering the id_resolver key type
[    0.208923] Key type id_resolver registered
[    0.208938] Key type id_legacy registered
[    0.209020] jffs2: version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
[    0.209845] fuse: init (API version 7.31)
[    0.214178] Key type asymmetric registered
[    0.214198] Asymmetric key parser 'x509' registered
[    0.214313] bounce: pool size: 64 pages
[    0.214342] io scheduler mq-deadline registered
[    0.214359] io scheduler kyber registered
[    0.218863] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 range=
s:
[    0.218943] imx6q-pcie 1ffc000.pcie:    IO 0x01f80000..0x01f8ffff
-> 0x00000000
[    0.218989] imx6q-pcie 1ffc000.pcie:   MEM 0x01000000..0x01efffff
-> 0x01000000
[    0.222593] imx-pgc-pd imx-pgc-power-domain.0: DMA mask not set
[    0.222809] imx-pgc-pd imx-pgc-power-domain.1: DMA mask not set
[    0.225241] 21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq =3D 63,
base_baud =3D 5000000) is a IMX
[    0.433045] imx6q-pcie 1ffc000.pcie: Link up
[    0.433059] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
[    0.433075] imx6q-pcie 1ffc000.pcie: Link up, Gen1
[    0.433389] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.433411] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.433428] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.433444] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01effff=
f]
[    0.433504] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    0.433556] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    0.433586] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    0.433702] pci 0000:00:00.0: supports D1
[    0.433718] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    0.443769] PCI: bus0: Fast back to back transfers disabled
[    0.452698] printk: console [ttymxc1] enabled
[    0.457679] pci 0000:01:00.0: [10b5:8605] type 01 class 0x060400
[    0.465044] 21ec000.serial: ttymxc2 at MMIO 0x21ec000 (irq =3D 64,
base_baud =3D 5000000) is a IMX
[    0.471328] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff]
[    1.044171] pci 0000:01:00.0: supports D1 D2
[    1.048470] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.055394] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s x1 link at 0000:00:00.0 (capable of 4.000 Gb/s
with 5 GT/s x1 link)
[    1.060051] brd: module loaded
[    1.089765] loop: module loaded
[    1.102366] PCI: bus1: Fast back to back transfers disabled
[    1.103161] at24 2-0050: 4096 byte 24c32 EEPROM, writable, 1 bytes/write
[    1.108062] pci 0000:01:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    1.118163] da9062 2-0058: Device detected (device-ID: 0x62,
var-ID: 0x22, DA9062)
[    1.123945] pci 0000:02:01.0: [10b5:8605] type 01 class 0x060400
[    1.137453] buck1: mapping for mode 2 not defined
[    1.137621] pci 0000:02:01.0: supports D1 D2
[    1.145334] buck2: mapping for mode 2 not defined
[    1.146500] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.153377] buck3: mapping for mode 2 not defined
[    1.159045] pci 0000:02:02.0: [10b5:8605] type 01 class 0x060400
[    1.165633] buck4: mapping for mode 2 not defined
[    1.170011] pci 0000:02:02.0: supports D1 D2
[    1.177250] vdd_snvs: Bringing 3100000uV into 3000000-3000000uV
[    1.177582] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.187366] vdd_high: Bringing 3100000uV into 3000000-3000000uV
[    1.191343] pci 0000:02:03.0: [10b5:8605] type 01 class 0x060400
[    1.199961] vdd_eth_io: Bringing 2600000uV into 2500000-2500000uV
[    1.203615] pci 0000:02:03.0: supports D1 D2
[    1.210740] random: fast init done
[    1.212544] pci 0000:02:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.216392] vdd_emmc: Bringing 1900000uV into 1800000-1800000uV
[    1.232342] PCI: bus2: Fast back to back transfers disabled
[    1.235292] ahci-imx 2200000.sata: fsl,transmit-level-mV not
specified, using 00000024
[    1.238007] pci 0000:02:01.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    1.245931] ahci-imx 2200000.sata: fsl,transmit-boost-mdB not
specified, using 00000480
[    1.254000] pci 0000:02:02.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    1.261949] ahci-imx 2200000.sata: fsl,transmit-atten-16ths not
specified, using 00002000
[    1.270053] pci 0000:02:03.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    1.278188] ahci-imx 2200000.sata: fsl,receive-eq-mdB not
specified, using 05000000
[    1.287030] pci 0000:03:00.0: [1912:0015] type 00 class 0x0c0330
[    1.297021] ahci-imx 2200000.sata: SSS flag set, parallel bus scan disab=
led
[    1.300229] pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit=
]
[    1.306986] ahci-imx 2200000.sata: AHCI 0001.0300 32 slots 1 ports
3 Gbps 0x1 impl platform mode
[    1.314843] pci 0000:03:00.0: PME# supported from D0 D3hot
[    1.322564] ahci-imx 2200000.sata: flags: ncq sntf stag pm led clo
only pmp pio slum part ccc apst
[    1.337541] pci 0000:03:00.0: 2.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s x1 link at 0000:00:00.0 (capable of 4.000 Gb/s
with 5 GT/s x1 link)
[    1.340272] scsi host0: ahci-imx
[    1.355545] ata1: SATA max UDMA/133 mmio [mem
0x02200000-0x02203fff] port 0x100 irq 67
[    1.368058] libphy: Fixed MDIO Bus: probed
[    1.373143] CAN device driver interface
[    1.379878] usbcore: registered new interface driver asix
[    1.385420] usbcore: registered new interface driver ax88179_178a
[    1.391588] usbcore: registered new interface driver cdc_ether
[    1.397536] usbcore: registered new interface driver net1080
[    1.403304] usbcore: registered new interface driver cdc_subset
[    1.409317] usbcore: registered new interface driver zaurus
[    1.411982] PCI: bus3: Fast back to back transfers disabled
[    1.415047] usbcore: registered new interface driver cdc_ncm
[    1.420550] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    1.426243] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.439399] ehci-pci: EHCI PCI platform driver
[    1.442684] PCI: bus4: Fast back to back transfers enabled
[    1.443963] ehci-platform: EHCI generic platform driver
[    1.449361] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    1.455080] ehci-mxc: Freescale On-Chip EHCI Host driver
[    1.471030] PCI: bus5: Fast back to back transfers enabled
[    1.471390] usbcore: registered new interface driver usb-storage
[    1.476585] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
[    1.489270] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 05
[    1.496114] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff=
]
[    1.502148] ci_hdrc ci_hdrc.1: EHCI Host Controller
[    1.502975] pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x013fffff=
]
[    1.507893] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus numb=
er 1
[    1.514683] pci 0000:00:00.0: BAR 9: assigned [mem
0x01400000-0x015fffff pref]
[    1.528985] pci 0000:00:00.0: BAR 6: assigned [mem
0x01600000-0x0160ffff pref]
[    1.536259] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[    1.542386] pci 0000:01:00.0: BAR 8: assigned [mem 0x01100000-0x012fffff=
]
[    1.542482] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    1.549225] pci 0000:01:00.0: BAR 9: assigned [mem
0x01400000-0x015fffff 64bit pref]
[    1.555925] hub 1-0:1.0: USB hub found
[    1.562436] pci 0000:01:00.0: BAR 0: assigned [mem 0x01300000-0x01303fff=
]
[    1.562483] pci 0000:01:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[    1.566313] hub 1-0:1.0: 1 port detected
[    1.573052] pci 0000:02:01.0: BAR 8: assigned [mem 0x01100000-0x012fffff=
]
[    1.584002] da9063-rtc da9062-rtc: DMA mask not set
[    1.589905] pci 0000:02:01.0: BAR 9: assigned [mem
0x01400000-0x015fffff 64bit pref]
[    1.602592] pci 0000:02:01.0: BAR 7: assigned [io  0x1000-0x1fff]
[    1.605485] da9063-rtc da9062-rtc: registered as rtc1
[    1.608782] pci 0000:03:00.0: BAR 0: assigned [mem
0x01100000-0x01101fff 64bit]
[    1.615323] rtc-m41t80 0-0068: Can't clear HT bit
[    1.621252] pci 0000:02:01.0: PCI bridge to [bus 03]
[    1.628137] snvs_rtc 20cc000.snvs:snvs-rtc-lp: registered as rtc2
[    1.630919] pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
[    1.637312] i2c /dev entries driver
[    1.643195] pci 0000:02:01.0:   bridge window [mem 0x01100000-0x012fffff=
]
[    1.652765] Bluetooth: HCI UART driver ver 2.3
[    1.653499] pci 0000:02:01.0:   bridge window [mem
0x01400000-0x015fffff 64bit pref]
[    1.657894] Bluetooth: HCI UART protocol H4 registered
[    1.665716] pci 0000:02:02.0: PCI bridge to [bus 04]
[    1.671718] sdhci: Secure Digital Host Controller Interface driver
[    1.675969] pci 0000:02:03.0: PCI bridge to [bus 05]
[    1.682066] sdhci: Copyright(c) Pierre Ossman
[    1.687172] pci 0000:01:00.0: PCI bridge to [bus 02-05]
[    1.691440] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.696715] pci 0000:01:00.0:   bridge window [io  0x1000-0x1fff]
[    1.704200] sdhci-esdhc-imx 2190000.usdhc: Got CD GPIO
[    1.708532] pci 0000:01:00.0:   bridge window [mem 0x01100000-0x012fffff=
]
[    1.720448] pci 0000:01:00.0:   bridge window [mem
0x01400000-0x015fffff 64bit pref]
[    1.728277] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    1.733552] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    1.739667] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x013fffff=
]
[    1.746502] pci 0000:00:00.0:   bridge window [mem
0x01400000-0x015fffff pref]
[    1.747461] mmc0: SDHCI controller on 2190000.usdhc [2190000.usdhc]
using ADMA
[    1.754500] pcieport 0000:00:00.0: PME: Signaling with IRQ 310
[    1.767684] pcieport 0000:00:00.0: AER: enabled with IRQ 310
[    1.774025] pcieport 0000:01:00.0: enabling device (0140 -> 0143)
[    1.782211] pcieport 0000:02:01.0: enabling device (0140 -> 0143)
[    1.796086] pci 0000:03:00.0: enabling device (0140 -> 0142)
[    1.801677] mmc1: SDHCI controller on 219c000.usdhc [219c000.usdhc]
using ADMA
[    1.833377] leds-pca953x 0-0062: setting platform data
[    1.841082] gpio gpiochip7: GPIO integer space overlap, cannot add chip
[    1.847787] gpiochip_add_data_with_key: GPIOs 0..3 (gpio-pca9532)
failed to register, -16
[    1.856016] leds-pca953x 0-0062: could not add gpiochip
[    1.862488] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.869508] ata1.00: ATA-10: ADATA SU800NS38, R0427AC, max UDMA/133
[    1.875885] ata1.00: 250069680 sectors, multi 16: LBA48 NCQ (depth 32)
[    1.877447] caam 2100000.caam: Entropy delay =3D 3200
[    1.883147] ata1.00: configured for UDMA/133
[    1.948151] caam 2100000.caam: Instantiated RNG4 SH0
[    1.951672] mmc1: new DDR MMC card at address 0001
[    1.952468] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[    1.966948] mmcblk1: mmc1:0001 Q2J55L 7.09 GiB
[    1.973562] mmcblk1boot0: mmc1:0001 Q2J55L partition 1 16.0 MiB
[    1.981566] mmcblk1boot1: mmc1:0001 Q2J55L partition 2 16.0 MiB
[    1.988087] mmcblk1rpmb: mmc1:0001 Q2J55L partition 3 4.00 MiB,
chardev (247:0)
[    1.997611]  mmcblk1: p1 p2
[    2.008919] caam 2100000.caam: Instantiated RNG4 SH1
[    2.013949] caam 2100000.caam: device ID =3D 0x0a16010000000000 (Era 4)
[    2.020411] caam 2100000.caam: job rings =3D 2, qi =3D 0
[    2.174122] hub 1-1:1.0: USB hub found
[    2.178117] hub 1-1:1.0: 4 ports detected
[    2.512501] usb 1-1.4: new high-speed USB device number 3 using ci_hdrc
[    2.664115] hub 1-1.4:1.0: USB hub found
[    2.668239] hub 1-1.4:1.0: 4 ports detected
[    2.997078] usb 1-1.4.1: new full-speed USB device number 4 using ci_hdr=
c
[    8.742783] pci 0000:03:00.0: xHCI HW not ready after 5 sec (HC
bug?) status =3D 0x801
[    8.750671] pci 0000:03:00.0: quirk_usb_early_handoff+0x0/0x7e0
took 6791593 usecs
[    8.759810] scsi 0:0:0:0: Direct-Access     ATA      ADATA
SU800NS38  7AC  PQ: 0 ANSI: 5
[    8.769965] sd 0:0:0:0: [sda] 250069680 512-byte logical blocks:
(128 GB/119 GiB)
[    8.777727] sd 0:0:0:0: [sda] Write Protect is off
[    8.782828] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    8.791790] caam algorithms registered in /proc/crypto
[    8.798431]  sda: sda1 sda2
[    8.805299] sd 0:0:0:0: [sda] Attached SCSI disk
[    8.813743] caam_jr 2101000.jr0: registering rng-caam
[    8.819715] hidraw: raw HID events driver (C) Jiri Kosina
[    8.825459] usbcore: registered new interface driver usbhid
[    8.831044] usbhid: USB HID core driver
[    8.839081] NET: Registered protocol family 10
[    8.845457] Segment Routing with IPv6
[    8.849272] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    8.856397] NET: Registered protocol family 17
[    8.860876] can: controller area network core (rev 20170425 abi 9)
[    8.867258] NET: Registered protocol family 29
[    8.871726] can: raw protocol (rev 20170425)
[    8.876145] can: broadcast manager protocol (rev 20170425 t)
[    8.881837] can: netlink gateway (rev 20170425) max_hops=3D1
[    8.887669] 8021q: 802.1Q VLAN Support v1.8
[    8.891951] Key type dns_resolver registered
[    8.896920] vddarm: supplied by vdd_arm
[    8.901892] vddpu: supplied by vdd_soc
[    8.906812] vddsoc: supplied by vdd_soc
[    8.913320] Registering SWP/SWPB emulation handler
[    8.919225] Loading compiled-in X.509 certificates
[    8.940828] imx_thermal tempmon: Automotive CPU temperature grade -
max:125C critical:120C passive:115C
[    8.952035] hctosys: unable to open rtc device (rtc0)
[    8.957774] VCC_CAM0: disabling
[    8.960925] flexcan1-reg: disabling
[    8.964440] usb_otg_vbus: disabling
[    8.967935] peb-display: disabling
[    8.972029] vdd_eth_io: disabling
[    9.146170] EXT4-fs (mmcblk1p2): recovery complete
[    9.151596] EXT4-fs (mmcblk1p2): mounted filesystem with ordered
data mode. Opts: (null)
[    9.159954] VFS: Mounted root (ext4 filesystem) on device 179:2.
[    9.169613] devtmpfs: mounted
[    9.175135] Freeing unused kernel memory: 1024K
[    9.179988] Run /sbin/init as init process
[    9.277437] EXT4-fs (mmcblk1p2): re-mounted. Opts: (null)
Starting rsyslog daemon: OK
Starting auditd: OK
Starting mdev...
modprobe: can't load module xhci_pci (kernel/drivers/usb/host/xhc[
10.029319] usbcore: registered new interface driver usbserial_generic
i-pci.ko): No such file or direct[   10.037550] usbserial: USB Serial
support registered for generic
ory
[   10.054682] usbcore: registered new interface driver ftdi_sio
[   10.060817] usbserial: USB Serial support registered for FTDI USB
Serial Device
[   10.068752] ftdi_sio 1-1.4.1:1.0: FTDI USB Serial Device converter detec=
ted
[   10.084547] usb 1-1.4.1: Detected FT232RL
[   10.089885] usb 1-1.4.1: FTDI USB Serial Device converter now
attached to ttyUSB0
Starting irqbalance: OK
Initializing random number generator... [   10.213230] random: dd:
uninitialized urandom read (512 bytes read)
done.
Starting system message bus: [   10.262147] random: dbus-uuidgen:
uninitialized urandom read (12 bytes read)
[   10.269384] random: dbus-uuidgen: uninitialized urandom read (8 bytes re=
ad)
done
Starting network: Waiting for interface wlan0 to appear............... time=
out!
run-parts: /etc/network/if-pre-up.d/wait_iface: exit status 1
FAIL
Starting ntpd: OK
Starting nginx...
[   25.792613] urandom_read: 2 callbacks suppressed
[   25.792621] random: ssh-keygen: uninitialized urandom read (32 bytes rea=
d)
Starting sshd: [   25.829864] random: sshd: uninitialized urandom read
(32 bytes read)
OK

Welcome to iMX6
buildroot-imx6 login: root
Password:
# cd /upd72020x-load/
# ./upd72020x-load1 -u -b 0x3 -d 0 -f 0 -i ./K2026.mem
Doing the upload
bus =3D 3
dev =3D 0
fct =3D 0
fname =3D ./K2026.mem
got firmware version: 200000
ERROR: ROM doesnt exist
no EEPROM installed
STATUS: enabling firmware upload
STATUS: performing firmware upload
STATUS: finishing firmware upload
STATUS: confirming firmware upload
 =3D=3D=3D=3D=3D=3D> PASSED
# [  113.345141] pci 0000:03:00.0: 2.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s x1 link at 0000:00:00.0 (capable of
4.000 Gb/s with 5 GT/s x1 link)

#  insmod  /lib/modules/5.2.7-bsp-yocto-i.mx6-pd18.1.1/kernel/drivers/usb/h=
ost/x
hci-pci1.ko
[  195.608734] xhci_hcd 0000:03:00.0: enabling device (0000 -> 0002)
[  195.615156] xhci_hcd 0000:03:00.0: xHCI Host Controller
[  195.620455] xhci_hcd 0000:03:00.0: new USB bus registered, assigned
bus number 2
[  195.627933] Unhandled fault: imprecise external abort (0x1406) at 0x0198=
1004
[  195.634988] pgd =3D (ptrval)
[  195.637697] [01981004] *pgd=3D8c165831
[  195.641283] Internal error: : 1406 [#1] SMP ARM
[  195.645815] Modules linked in: xhci_pci(+) ftdi_sio usbserial xhci_hcd
[  195.652370] CPU: 2 PID: 369 Comm: insmod Not tainted
5.2.7-bsp-yocto-i.mx6-pd18.1.1 #1
[  195.660296] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  195.666964] PC is at xhci_gen_setup+0x9c/0x308 [xhci_hcd]
[  195.672453] LR is at xhci_gen_setup+0x88/0x308 [xhci_hcd]
[  195.677867] pc : [<bf003328>]    lr : [<bf003314>]    psr: 200d0013
[  195.684145] sp : e4989c20  ip : 5a6c0a29  fp : c0d05148
[  195.689381] r10: 00000006  r9 : e4611878  r8 : 00000001
[  195.694617] r7 : bf024494  r6 : e4469158  r5 : e4469000  r4 : e4469000
[  195.701156] r3 : 00000000  r2 : 00000000  r1 : f096a000  r0 : e4469228
[  195.707700] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 none
[  195.714848] Control: 10c5387d  Table: 34b0404a  DAC: 00000051
[  195.720605] Process insmod (pid: 369, stack limit =3D 0x(ptrval))
[  195.726536] Stack: (0xe4989c20 to 0xe498a000)
[  195.730918] 9c20: 00000030 5a6c0a29 e4469000 e4469000 e4611800
e4469000 00000000 00000080
[  195.739115] 9c40: e44690c0 bf024b88 e4469000 00000000 c0d05148
c05c85b0 00000cc0 e4611800
[  195.747313] 9c60: e461b800 5a6c0a29 00000001 e4611800 bf025094
e4469000 bf026088 00000001
[  195.755509] 9c80: 00000000 00000006 c0d05148 c05d9f74 00000000
00000000 0000003c e4611878
[  195.763707] 9ca0: c0d05148 e4611800 e461196c bf026000 00000000
bf026088 bf025094 00000006
[  195.771905] 9cc0: c0d05148 bf0240d0 e4611878 e4611800 bf026000
00000000 bf026038 bf025094
[  195.780103] 9ce0: 00000006 c045d18c e4611878 c0db5b34 c0db5b38
00000000 00000000 bf026038
[  195.788301] 9d00: 00000006 c04e17c4 e4611878 bf026038 bf026038
c0d05148 ffffe000 00000028
[  195.796498] 9d20: bf026140 c04e1afc 00000cc0 00000000 00000000
e4611878 00000000 bf026038
[  195.804695] 9d40: c0d05148 ffffe000 00000028 c04e1da8 00000000
bf026038 e4611878 c04e1e08
[  195.812891] 9d60: e421c434 bf026038 c04e1db0 c04dfca8 00000028
e416bb58 e421c434 5a6c0a29
[  195.821087] 9d80: c0d1f6fc bf026038 e461cd00 c0d1f6fc 00000000
c04e0ce4 bf0250cc 00000000
[  195.829283] 9da0: bf026038 bf026038 c0d05148 bf029000 00000000
c04e2658 c0d5b800 c0d05148
[  195.837479] 9dc0: bf029000 c0102738 8040003f e4699c80 00000000
5a6c0a29 e4989dd4 e7445320
[  195.845675] 9de0: e7445320 ffffe000 8040003e 00000002 e4a86600
5a6c0a29 00000000 c0874e7c
[  195.853870] 9e00: 00000cc0 e4001e40 c0d05148 c021ecd0 bf026140
5a6c0a29 bf026140 e4a866c0
[  195.862066] 9e20: e4a865c0 00000002 e4a86600 c019d004 00000002
e4a865c0 e4989f30 00000002
[  195.870262] 9e40: e4a865c0 c019f320 bf02614c 00007fff bf026140
c019c134 00000041 bf026188
[  195.878458] 9e60: 01981150 bf026254 bf02bb38 bf026140 bf026300
c0903efc 00000000 c0ab0e20
[  195.886654] 9e80: 00000001 00000000 c0b5e5ec c0b4f1ec 00000000
00000000 00000000 00000000
[  195.894849] 9ea0: 00000000 00000000 6e72656b 00006c65 00000000
00000000 00000000 00000000
[  195.903045] 9ec0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  195.911241] 9ee0: 00000000 5a6c0a29 7fffffff c0d05148 00000000
00000003 01981150 7fffffff
[  195.919436] 9f00: 00000000 0000017b 00000000 c019f764 7fffffff
00000000 00000003 e48da488
[  195.927632] 9f20: 00000001 f0800000 00002ea8 00000000 f0800de7
f0801780 f0800000 00002ea8
[  195.935830] 9f40: f08028e0 f080275c f08020c8 00003000 00003260
00002aec 000033c1 00000000
[  195.944026] 9f60: 00000000 00000000 00002adc 00000022 00000023
0000001c 00000018 00000016
[  195.952222] 9f80: 00000000 5a6c0a29 bea64ef1 01981150 ffffffff
bea64ef1 0000017b c0101204
[  195.960417] 9fa0: e4988000 c01011e0 01981150 ffffffff 00000003
01981150 00000000 bea64ef1
[  195.968613] 9fc0: 01981150 ffffffff bea64ef1 0000017b 00000000
00000000 b6f8d000 00000000
[  195.976809] 9fe0: bea64c58 bea64c48 00027a1c b6ec3bf0 600d0010
00000003 00000000 00000000
[  195.985119] [<bf003328>] (xhci_gen_setup [xhci_hcd]) from
[<bf024b88>] (xhci_pci_setup+0x40/0x8c [xhci_pci])
[  195.995006] [<bf024b88>] (xhci_pci_setup [xhci_pci]) from
[<c05c85b0>] (usb_add_hcd+0x278/0x76c)
[  196.003830] [<c05c85b0>] (usb_add_hcd) from [<c05d9f74>]
(usb_hcd_pci_probe+0x200/0x36c)
[  196.011956] [<c05d9f74>] (usb_hcd_pci_probe) from [<bf0240d0>]
(xhci_pci_probe+0x2c/0x194 [xhci_pci])
[  196.021220] [<bf0240d0>] (xhci_pci_probe [xhci_pci]) from
[<c045d18c>] (pci_device_probe+0xa4/0x138)
[  196.030387] [<c045d18c>] (pci_device_probe) from [<c04e17c4>]
(really_probe+0xec/0x2c8)
[  196.038422] [<c04e17c4>] (really_probe) from [<c04e1afc>]
(driver_probe_device+0x5c/0x160)
[  196.046709] [<c04e1afc>] (driver_probe_device) from [<c04e1da8>]
(device_driver_attach+0x58/0x60)
[  196.055602] [<c04e1da8>] (device_driver_attach) from [<c04e1e08>]
(__driver_attach+0x58/0xcc)
[  196.064149] [<c04e1e08>] (__driver_attach) from [<c04dfca8>]
(bus_for_each_dev+0x70/0xb4)
[  196.072348] [<c04dfca8>] (bus_for_each_dev) from [<c04e0ce4>]
(bus_add_driver+0x194/0x1cc)
[  196.080635] [<c04e0ce4>] (bus_add_driver) from [<c04e2658>]
(driver_register+0x74/0x108)
[  196.088752] [<c04e2658>] (driver_register) from [<c0102738>]
(do_one_initcall+0x6c/0x1c8)
[  196.096965] [<c0102738>] (do_one_initcall) from [<c019d004>]
(do_init_module+0x58/0x230)
[  196.105082] [<c019d004>] (do_init_module) from [<c019f320>]
(load_module+0x20dc/0x22dc)
[  196.113108] [<c019f320>] (load_module) from [<c019f764>]
(sys_finit_module+0xbc/0xdc)
[  196.120957] [<c019f764>] (sys_finit_module) from [<c01011e0>]
(__sys_trace_return+0x0/0x20)
[  196.129320] Exception stack(0xe4989fa8 to 0xe4989ff0)
[  196.134391] 9fa0:                   01981150 ffffffff 00000003
01981150 00000000 bea64ef1
[  196.142589] 9fc0: 01981150 ffffffff bea64ef1 0000017b 00000000
00000000 b6f8d000 00000000
[  196.150781] 9fe0: bea64c58 bea64c48 00027a1c b6ec3bf0
[  196.155853] Code: e5841160 e5912000 e3a03000 ee073f9a (e6e12072)
[  196.161964] ---[ end trace 9ae639a4b44e462a ]---
Segmentation fault




-- Fawad Lateef

On Fri, 2 Aug 2019 at 12:56, Fawad Lateef <fawadlateef@gmail.com> wrote:
>
> Hi Schmid,
>
> On Fri, 2 Aug 2019 at 10:24, Schmid, Carsten <Carsten_Schmid@mentor.com> =
wrote:
> >
> > > >
> > > > Facing kernel "Unhandled fault: imprecise external abort (0x1406)"
> > > > when trying to load xhci_pci.ko module for uPD720202. Receiving thi=
s
> > > > fault straight-away when driver trying to setup device.
> > > >
> > I had "imprecise external abort" on ARM systems in the following cases:
> > - Subsystem that was accessed was not powered
> > - Clock of accessed subsystem was turned off
> > Maybe this enables you to find the true reason.
> >
>
> Thanks for suggestion. Going to verify these points.
>
> > Can you try to disable runtime power management to check if it works?
> >
>
> I will try soon as currently don't have access to prototype board.
>
> > Best regards
> > Carsten
