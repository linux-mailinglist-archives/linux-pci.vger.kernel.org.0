Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA989913A
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 12:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbfHVKpC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 06:45:02 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39271 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbfHVKpC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Aug 2019 06:45:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9so7029032qtu.6;
        Thu, 22 Aug 2019 03:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yEmGihXzUs2/f8ziMjgsqHIXnrNmbpPYrcK70jHwHLU=;
        b=cYpJv9wdUL+taTB7HXMuo0iCd2hZJ5ebrARUjES87nGhesvyafJQKKT+IbfrMUGfqZ
         yDbuZhSjoADOG7Xhg3zHOU/K1ciP7l3Vi7GuB8WYocSJYTt9TcR7/m+nbucVD1Ipjflq
         JPAWwYHmgXLoXaEA5kz1tCId3+f/gy2yyEheOzxOIQ/sxzq+RyIDWgkjNHcsDd5YB8Do
         NVtcZQyJse5uePdZoEeeiVZyvzOW9Pkzy/WhuMwO03os0wK7f1X8MlOMhi9HR4nSikmb
         q2RmY3iTTIMekpU1a3jURGFVeU6YTWR4opf93w11dcup7oaPy/NpDTse9jRrrtS6EJtM
         0IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yEmGihXzUs2/f8ziMjgsqHIXnrNmbpPYrcK70jHwHLU=;
        b=mwQRzDKRsIhUJVSsfzwEsDpsgg4OZ9Dchw6tHDyseZ9uSAifjMuqAfk932D7td93Gy
         agcJCAIiI0zZ5MlcsWGDKtCEGbsyGebnzhvUxCL9VV+hV5G/u/kD8uWFMlsonbdHVmy+
         /CIWL8X3G4kk67YwmfCxYoRaGDpbKDIOoFcoBKHUcChytuVP3X/BAe3vgxcX9wVIQMfH
         GwR2spZZANpsVtW9wjSlxERXJp0Zum1q153iCdmXnl5D69BzLG8F7BudDP2EVgNGFxPz
         ZDlPil6uFo1OoB+YYLgjB1yd46nK90cQbkortkPqImp8mq6TdJ8KJ4yMeWveV7NoUj2s
         tIHw==
X-Gm-Message-State: APjAAAWWcXT+pFieJIguTSehjhvt/xGzVW4ITWnRYLat/nc/gi+e0+T6
        Nv5UDTzygP/FRHUrgErokXaNVWARygkBRmXnXdM=
X-Google-Smtp-Source: APXvYqwKh2/370lVDeghBSLKqJFgsaBNdPnbFUt+ORL7mx2O+kWrNxGulMtnxkKT/XTSGZIso1u1sukiLdyke1HLELQ=
X-Received: by 2002:aed:31c2:: with SMTP id 60mr32347483qth.331.1566470700076;
 Thu, 22 Aug 2019 03:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAGgoGu5FfLFzCf0QiAd8UcMrZ7gtLyapgT3TZ-Hx0dknWy4LMQ@mail.gmail.com>
 <CAGgoGu4zP_7QpKHiXSkLfkb=zHEezBzstVfjQMQ4CO60+YubCw@mail.gmail.com>
 <CAGgoGu7rot61LSgu2syOMq9Onx26_u3PEtS7pf_QNQRxOaifhg@mail.gmail.com>
 <20190801171725.GD151852@google.com> <743ef7fab5144df69bfc8673fff7f0f7@SVR-IES-MBX-03.mgc.mentorg.com>
 <CAGgoGu4ZZR3ZVD5mx_oJN_8gwNM4fa=of=erwM+P8P7zzaMDrQ@mail.gmail.com>
 <CAGgoGu5WP1qQUf4HS8xWGXUuP0L9vM6HGz1OZoGBBh1B67ZYSg@mail.gmail.com> <5c4bae3d066e4f1084c7eeb394b8a7d7@SVR-IES-MBX-03.mgc.mentorg.com>
In-Reply-To: <5c4bae3d066e4f1084c7eeb394b8a7d7@SVR-IES-MBX-03.mgc.mentorg.com>
From:   Fawad Lateef <fawadlateef@gmail.com>
Date:   Thu, 22 Aug 2019 12:44:49 +0200
Message-ID: <CAGgoGu5vH0LZsJDyTag2aWqicrTboLFHdYJ=0pWAsjuNp-J-BA@mail.gmail.com>
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

Hi Carsten,

Thanks for your reply. I though CONFIG_PM covers CPU only (but now I
am compiling kernel with PM completely).

Occasionally we see crash at boot too without even reaching stage of
loading xhci-pci.ko driver.

Log is below. Is this can be because of again uPD connected on PCIe
bus (through PCIe switch)?

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
[    0.000014] sched_clock: 32 bits at 3000kHz, resolution 333ns,
wraps every 715827882841ns
[    0.000045] clocksource: mxc_timer1: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 637086815595 ns
[    0.002929] Console: colour dummy device 80x30
[    0.002992] Calibrating delay loop (skipped), value calculated
using timer frequency.. 6.00 BogoMIPS (lpj=3D30000)
[    0.003020] pid_max: default: 32768 minimum: 301
[    0.003305] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.003346] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 by=
tes)
[    0.004458] CPU: Testing write buffer coherency: ok
[    0.004517] CPU0: Spectre v2: using BPIALL workaround
[    0.004985] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.006111] Setting up static identity map for 0x10100000 - 0x10100078
[    0.006389] rcu: Hierarchical SRCU implementation.
[    0.007121] smp: Bringing up secondary CPUs ...
[    0.008372] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.008384] CPU1: Spectre v2: using BPIALL workaround
[    0.009974] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.009986] CPU2: Spectre v2: using BPIALL workaround
[    0.011430] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.011442] CPU3: Spectre v2: using BPIALL workaround
[    0.011668] smp: Brought up 1 node, 4 CPUs
[    0.011692] SMP: Total of 4 processors activated (24.00 BogoMIPS).
[    0.011706] CPU: All CPU(s) started in SVC mode.
[    0.013443] devtmpfs: initialized
[    0.031486] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 4
[    0.031960] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.031999] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.044743] pinctrl core: initialized pinctrl subsystem
[    0.046494] NET: Registered protocol family 16
[    0.060588] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.061412] audit: initializing netlink subsys (disabled)
[    0.061745] audit: type=3D2000 audit(0.060:1): state=3Dinitialized
audit_enabled=3D0 res=3D1
[    0.062760] CPU identified as i.MX6Q, silicon rev 1.5
[    0.074287] vdd1p1: supplied by regulator-dummy
[    0.075185] vdd3p0: supplied by regulator-dummy
[    0.076039] vdd2p5: supplied by regulator-dummy
[    0.098019] No ATAGs?
[    0.098256] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.098280] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.100851] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
[    0.155153] mxs-dma 110000.dma-apbh: initialized
[    0.163489] SCSI subsystem initialized
[    0.164302] usbcore: registered new interface driver usbfs
[    0.164405] usbcore: registered new interface driver hub
[    0.164564] usbcore: registered new device driver usb
[    0.167207] i2c i2c-0: IMX I2C adapter registered
[    0.168137] i2c i2c-1: IMX I2C adapter registered
[    0.169506] i2c i2c-2: IMX I2C adapter registered
[    0.169852] pps_core: LinuxPPS API ver. 1 registered
[    0.169870] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.169912] PTP clock support registered
[    0.171200] Bluetooth: Core ver 2.22
[    0.171280] NET: Registered protocol family 31
[    0.171297] Bluetooth: HCI device and connection manager initialized
[    0.171323] Bluetooth: HCI socket layer initialized
[    0.171346] Bluetooth: L2CAP socket layer initialized
[    0.171386] Bluetooth: SCO socket layer initialized
[    0.172256] clocksource: Switched to clocksource mxc_timer1
[    0.172507] VFS: Disk quotas dquot_6.6.0
[    0.172647] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)
[    0.189291] NET: Registered protocol family 2
[    0.190486] tcp_listen_portaddr_hash hash table entries: 512
(order: 0, 6144 bytes)
[    0.190545] TCP established hash table entries: 8192 (order: 3, 32768 by=
tes)
[    0.190711] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.190978] TCP: Hash tables configured (established 8192 bind 8192)
[    0.191318] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.191399] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.191909] NET: Registered protocol family 1
[    0.192938] RPC: Registered named UNIX socket transport module.
[    0.192958] RPC: Registered udp transport module.
[    0.192973] RPC: Registered tcp transport module.
[    0.192988] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.193014] PCI: CLS 0 bytes, default 64
[    0.194260] hw perfevents: no interrupt-affinity property for /pmu, gues=
sing.
[    0.194654] hw perfevents: enabled with armv7_cortex_a9 PMU driver,
7 counters available
[    0.197613] Initialise system trusted keyrings
[    0.197913] workingset: timestamp_bits=3D30 max_order=3D19 bucket_order=
=3D0
[    0.207642] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.208713] NFS: Registering the id_resolver key type
[    0.208767] Key type id_resolver registered
[    0.208782] Key type id_legacy registered
[    0.208862] jffs2: version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
[    0.209675] fuse: init (API version 7.31)
[    0.213974] Key type asymmetric registered
[    0.213995] Asymmetric key parser 'x509' registered
[    0.214112] bounce: pool size: 64 pages
[    0.214139] io scheduler mq-deadline registered
[    0.214155] io scheduler kyber registered
[    0.218668] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 range=
s:
[    0.218744] imx6q-pcie 1ffc000.pcie:    IO 0x01f80000..0x01f8ffff
-> 0x00000000
[    0.218792] imx6q-pcie 1ffc000.pcie:   MEM 0x01000000..0x01efffff
-> 0x01000000
[    0.222382] imx-pgc-pd imx-pgc-power-domain.0: DMA mask not set
[    0.222592] imx-pgc-pd imx-pgc-power-domain.1: DMA mask not set
[    0.225009] 21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq =3D 63,
base_baud =3D 5000000) is a IMX
[    0.432757] imx6q-pcie 1ffc000.pcie: Link up
[    0.432772] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
[    0.432788] imx6q-pcie 1ffc000.pcie: Link up, Gen1
[    0.433089] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.433113] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.433132] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.433147] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01effff=
f]
[    0.433208] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    0.433263] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    0.433295] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    0.433415] pci 0000:00:00.0: supports D1
[    0.433432] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    0.443431] PCI: bus0: Fast back to back transfers disabled
[    0.452524] printk: console [ttymxc1] enabled
[    0.457506] pci 0000:01:00.0: [10b5:8605] type 01 class 0x060400
[    0.464859] 21ec000.serial: ttymxc2 at MMIO 0x21ec000 (irq =3D 64,
base_baud =3D 5000000) is a IMX
[    0.471144] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff]
[    1.045420] pci 0000:01:00.0: supports D1 D2
[    1.049720] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.056633] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s x1 link at 0000:00:00.0 (capable of 4.000 Gb/s
with 5 GT/s x1 link)
[    1.059816] brd: module loaded
[    1.090896] loop: module loaded
[    1.095347] at24 2-0050: 4096 byte 24c32 EEPROM, writable, 1 bytes/write
[    1.111966] PCI: bus1: Fast back to back transfers disabled
[    1.115041] da9062 2-0058: Device detected (device-ID: 0x62,
var-ID: 0x22, DA9062)
[    1.117640] pci 0000:01:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    1.132102] buck1: mapping for mode 2 not defined
[    1.134384] pci 0000:02:01.0: [10b5:8605] type 01 class 0x060400
[    1.141080] buck2: mapping for mode 2 not defined
[    1.145459] pci 0000:02:01.0: supports D1 D2
[    1.150935] buck3: mapping for mode 2 not defined
[    1.153030] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.160781] buck4: mapping for mode 2 not defined
[    1.165605] pci 0000:02:02.0: [10b5:8605] type 01 class 0x060400
[    1.173134] vdd_snvs: Bringing 3100000uV into 3000000-3000000uV
[    1.176628] pci 0000:02:02.0: supports D1 D2
[    1.184894] vdd_high: Bringing 3100000uV into 3000000-3000000uV
[    1.185364] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.195081] vdd_eth_io: Bringing 2600000uV into 2500000-2500000uV
[    1.199096] pci 0000:02:03.0: [10b5:8605] type 01 class 0x060400
[    1.206486] random: fast init done
[    1.211471] pci 0000:02:03.0: supports D1 D2
[    1.213913] vdd_emmc: Bringing 1900000uV into 1800000-1800000uV
[    1.217737] pci 0000:02:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.229382] ahci-imx 2200000.sata: fsl,transmit-level-mV not
specified, using 00000024
[    1.238426] ahci-imx 2200000.sata: fsl,transmit-boost-mdB not
specified, using 00000480
[    1.239840] PCI: bus2: Fast back to back transfers disabled
[    1.246487] ahci-imx 2200000.sata: fsl,transmit-atten-16ths not
specified, using 00002000
[    1.252084] pci 0000:02:01.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    1.260275] ahci-imx 2200000.sata: fsl,receive-eq-mdB not
specified, using 05000000
[    1.268376] pci 0000:02:02.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    1.279100] ahci-imx 2200000.sata: SSS flag set, parallel bus scan disab=
led
[    1.284078] pci 0000:02:03.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    1.291063] ahci-imx 2200000.sata: AHCI 0001.0300 32 slots 1 ports
3 Gbps 0x1 impl platform mode
[    1.299888] pci 0000:03:00.0: [1912:0015] type 00 class 0x0c0330
[    1.307868] ahci-imx 2200000.sata: flags: ncq sntf stag pm led clo
only pmp pio slum part ccc apst
[    1.323238] pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit=
]
[    1.330943] pci 0000:03:00.0: PME# supported from D0 D3hot
[    1.333765] scsi host0: ahci-imx
[    1.336899] pci 0000:03:00.0: 2.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s x1 link at 0000:00:00.0 (capable of 4.000 Gb/s
with 5 GT/s x1 link)
[    1.340548] ata1: SATA max UDMA/133 mmio [mem
0x02200000-0x02203fff] port 0x100 irq 67
[    1.366074] libphy: Fixed MDIO Bus: probed
[    1.371078] CAN device driver interface
[    1.377871] usbcore: registered new interface driver asix
[    1.383406] usbcore: registered new interface driver ax88179_178a
[    1.389575] usbcore: registered new interface driver cdc_ether
[    1.391766] PCI: bus3: Fast back to back transfers disabled
[    1.395530] usbcore: registered new interface driver net1080
[    1.401066] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    1.406829] usbcore: registered new interface driver cdc_subset
[    1.419402] usbcore: registered new interface driver zaurus
[    1.423154] PCI: bus4: Fast back to back transfers enabled
[    1.425124] usbcore: registered new interface driver cdc_ncm
[    1.430495] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    1.436182] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.449351] ehci-pci: EHCI PCI platform driver
[    1.452591] PCI: bus5: Fast back to back transfers enabled
[    1.453918] ehci-platform: EHCI generic platform driver
[    1.459313] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
[    1.465055] ehci-mxc: Freescale On-Chip EHCI Host driver
[    1.471218] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 05
[    1.477127] usbcore: registered new interface driver usb-storage
[    1.483263] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff=
]
[    1.496056] pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x013fffff=
]
[    1.502900] pci 0000:00:00.0: BAR 9: assigned [mem
0x01400000-0x015fffff pref]
[    1.510148] pci 0000:00:00.0: BAR 6: assigned [mem
0x01600000-0x0160ffff pref]
[    1.517427] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[    1.523652] pci 0000:01:00.0: BAR 8: assigned [mem 0x01100000-0x012fffff=
]
[    1.530486] pci 0000:01:00.0: BAR 9: assigned [mem
0x01400000-0x015fffff 64bit pref]
[    1.538305] pci 0000:01:00.0: BAR 0: assigned [mem 0x01300000-0x01303fff=
]
[    1.544420] ci_hdrc ci_hdrc.1: EHCI Host Controller
[    1.545184] pci 0000:01:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[    1.550038] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus numb=
er 1
[    1.556158] pci 0000:02:01.0: BAR 8: assigned [mem 0x01100000-0x012fffff=
]
[    1.570027] pci 0000:02:01.0: BAR 9: assigned [mem
0x01400000-0x015fffff 64bit pref]
[    1.577822] pci 0000:02:01.0: BAR 7: assigned [io  0x1000-0x1fff]
[    1.584022] pci 0000:03:00.0: BAR 0: assigned [mem
0x01100000-0x01101fff 64bit]
[    1.591434] pci 0000:02:01.0: PCI bridge to [bus 03]
[    1.592307] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    1.596461] pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
[    1.603118] hub 1-0:1.0: USB hub found
[    1.607982] pci 0000:02:01.0:   bridge window [mem 0x01100000-0x012fffff=
]
[    1.611734] hub 1-0:1.0: 1 port detected
[    1.618511] pci 0000:02:01.0:   bridge window [mem
0x01400000-0x015fffff 64bit pref]
[    1.618577] pci 0000:02:02.0: PCI bridge to [bus 04]
[    1.627207] da9063-rtc da9062-rtc: DMA mask not set
[    1.630359] pci 0000:02:03.0: PCI bridge to [bus 05]
[    1.645199] pci 0000:01:00.0: PCI bridge to [bus 02-05]
[    1.645950] da9063-rtc da9062-rtc: registered as rtc1
[    1.650454] pci 0000:01:00.0:   bridge window [io  0x1000-0x1fff]
[    1.650505] pci 0000:01:00.0:   bridge window [mem 0x01100000-0x012fffff=
]
[    1.657054] rtc-m41t80 0-0068: Can't clear HT bit
[    1.661696] pci 0000:01:00.0:   bridge window [mem
0x01400000-0x015fffff 64bit pref]
[    1.670643] snvs_rtc 20cc000.snvs:snvs-rtc-lp: registered as rtc2
[    1.673281] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    1.681326] i2c /dev entries driver
[    1.687148] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    1.698425] Bluetooth: HCI UART driver ver 2.3
[    1.702000] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x013fffff=
]
[    1.706483] Bluetooth: HCI UART protocol H4 registered
[    1.713291] pci 0000:00:00.0:   bridge window [mem
0x01400000-0x015fffff pref]
[    1.714014] pcieport 0000:00:00.0: PME: Signaling with IRQ 310
[    1.719379] sdhci: Secure Digital Host Controller Interface driver
[    1.726380] pcieport 0000:00:00.0: AER: enabled with IRQ 310
[    1.731570] sdhci: Copyright(c) Pierre Ossman
[    1.738430] pcieport 0000:01:00.0: enabling device (0140 -> 0143)
[    1.743497] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.745401] sdhci-esdhc-imx 2190000.usdhc: Got CD GPIO
[    1.750361] pcieport 0000:02:01.0: enabling device (0140 -> 0143)
[    1.778719] pci 0000:03:00.0: enabling device (0140 -> 0142)
[    1.805368] mmc0: SDHCI controller on 2190000.usdhc [2190000.usdhc]
using ADMA
[    1.862340] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.869326] ata1.00: ATA-10: ADATA SU800NS38, R0427AC, max UDMA/133
[    1.875661] ata1.00: 250069680 sectors, multi 16: LBA48 NCQ (depth 32)
[    1.882860] ata1.00: configured for UDMA/133
[    2.002303] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[    2.203882] hub 1-1:1.0: USB hub found
[    2.207885] hub 1-1:1.0: 4 ports detected
[    2.532298] usb 1-1.4: new high-speed USB device number 3 using ci_hdrc
[    2.706870] hub 1-1.4:1.0: USB hub found
[    2.711007] hub 1-1.4:1.0: 4 ports detected
[    8.263117] Unhandled fault: imprecise external abort (0x1406) at 0xfaf0=
6a5b
[    8.270180] pgd =3D (ptrval)
[    8.272898] [faf06a5b] *pgd=3D00000000
[    8.276495] Internal error: : 1406 [#1] SMP ARM
[    8.281035] Modules linked in:
[    8.284116] CPU: 2 PID: 7 Comm: kworker/u8:0 Not tainted
5.2.7-bsp-yocto-i.mx6-pd18.1.1 #1
[    8.292390] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    8.298954] Workqueue: events_unbound async_run_entry_fn
[    8.304297] PC is at quirk_usb_early_handoff+0x400/0x7e0
[    8.309634] LR is at __timer_delay+0x3c/0x88
[    8.313916] pc : [<c05dd808>]    lr : [<c085992c>]    psr: 20000013
[    8.320194] sp : e4085d60  ip : 00000000  fp : 0020c498
[    8.325430] r10: c0b388d4  r9 : 00000000  r8 : f097c024
[    8.330666] r7 : 000091d1  r6 : f097c000  r5 : c0d05148  r4 : e444a000
[    8.337205] r3 : 00000000  r2 : fffe5480  r1 : 00000730  r0 : 0000001d
[    8.343747] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 none
[    8.350894] Control: 10c5387d  Table: 1000404a  DAC: 00000051
[    8.356652] Process kworker/u8:0 (pid: 7, stack limit =3D 0x(ptrval))
[    8.362932] Stack: (0xe4085d60 to 0xe4086000)
[    8.367313] 5d60: f097c020 00000504 e42323b8 c041d570 3b9aca00
5a6c0a29 e4085d9c c0b4a25c
[    8.375510] 5d80: e444a000 c0b4a26c 0000ffff c0d5b820 c05dd408
00000000 69e28c0a c0466a5c
[    8.383706] 5da0: 00000000 c04ec3c4 e4449878 e4084000 c0d05148
e444a000 e4479814 e4479800
[    8.391901] 5dc0: e423d618 e40e5210 e423d618 e423d440 e6f9e968
c0450b9c e444a000 e4479814
[    8.400097] 5de0: e4479800 c0450c44 e4448800 e4478814 e4478800
c0450c78 e4065000 e423f414
[    8.408294] 5e00: e423f400 c0450c78 e4064800 e423ec14 e423ec00
c0450c78 e43cc858 e423ec0c
[    8.416490] 5e20: 00000000 c0475254 00000000 00000000 00000000
e43cc840 e40e5210 e6f9e968
[    8.424685] 5e40: e40e5200 e43cc840 c0d05148 00000000 00000000
c0476bd4 00000000 00000001
[    8.432880] 5e60: 00000000 c02a57b0 00000000 00000000 00000000
00000000 00000000 00000000
[    8.441074] 5e80: 00000000 5a6c0a29 00000000 e40e5210 00000000
c0d2022c 00000000 00000000
[    8.449269] 5ea0: c0d2022c 00000000 ffffe000 c04e3538 e40e5210
c0db5b34 c0db5b38 00000000
[    8.457464] 5ec0: 00000000 c04e17c4 e40e5210 c0d2022c e42b0c80
e4008000 00000000 00000000
[    8.465659] 5ee0: e42b0c94 c04e1afc 00000000 c0d179f8 00000000
e40e5210 c0d5b820 e42b0c80
[    8.473855] 5f00: e4008000 00000000 00000000 c04e1c50 e42b0c90
c0144ca0 e42b0c90 e401b580
[    8.482051] 5f20: e4006200 e4008000 00000000 c013bae4 00000088
e4006218 e401b580 e401b594
[    8.490246] 5f40: e4006200 00000088 e4006218 c0d03d00 e4006200
c013c8ec e406a280 00000000
[    8.498441] 5f60: ffffe000 00000000 e4030b80 e4030a40 e4084000
e401b580 c013c8c0 e4055ea4
[    8.506636] 5f80: e4030b9c c0141b18 e4072480 e4030a40 c01419e8
00000000 00000000 00000000
[    8.514830] 5fa0: 00000000 00000000 00000000 c01010e8 00000000
00000000 00000000 00000000
[    8.523023] 5fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    8.531216] 5fe0: 00000000 00000000 00000000 00000000 00000013
00000000 00000000 00000000
[    8.539442] [<c05dd808>] (quirk_usb_early_handoff) from
[<c0466a5c>] (pci_do_fixups+0xd8/0x144)
[    8.548179] [<c0466a5c>] (pci_do_fixups) from [<c0450b9c>]
(pci_bus_add_device+0x18/0x94)
[    8.556383] [<c0450b9c>] (pci_bus_add_device) from [<c0450c44>]
(pci_bus_add_devices+0x2c/0x70)
[    8.565103] [<c0450c44>] (pci_bus_add_devices) from [<c0450c78>]
(pci_bus_add_devices+0x60/0x70)
[    8.573908] Code: e2577001 0a0000b5 e5983000 ee079f9a (e3130b02)
[    8.580028] ---[ end trace d9b763ceb334a93b ]---
[    8.616873] mmc1: SDHCI controller on 219c000.usdhc [219c000.usdhc]
using ADMA
[    8.625016] leds-pca953x 0-0062: setting platform data
[    8.632724] gpio gpiochip7: GPIO integer space overlap, cannot add chip
[    8.639385] gpiochip_add_data_with_key: GPIOs 0..3 (gpio-pca9532)
failed to register, -16
[    8.647652] leds-pca953x 0-0062: could not add gpiochip
[    8.661886] caam 2100000.caam: Entropy delay =3D 3200
[    8.727627] caam 2100000.caam: Instantiated RNG4 SH0
[    8.788388] caam 2100000.caam: Instantiated RNG4 SH1
[    8.793408] caam 2100000.caam: device ID =3D 0x0a16010000000000 (Era 4)
[    8.799880] caam 2100000.caam: job rings =3D 2, qi =3D 0
[    8.832613] caam algorithms registered in /proc/crypto
[    8.847675] caam_jr 2101000.jr0: registering rng-caam
[    8.850017] mmc1: new DDR MMC card at address 0001
[    8.853722] hidraw: raw HID events driver (C) Jiri Kosina
[    8.860165] mmcblk1: mmc1:0001 Q2J55L 7.09 GiB
[    8.863418] usbcore: registered new interface driver usbhid
[    8.869589] mmcblk1boot0: mmc1:0001 Q2J55L partition 1 16.0 MiB
[    8.873257] usbhid: USB HID core driver
[    8.881187] mmcblk1boot1: mmc1:0001 Q2J55L partition 2 16.0 MiB
[    8.887424] NET: Registered protocol family 10
[    8.889380] mmcblk1rpmb: mmc1:0001 Q2J55L partition 3 4.00 MiB,
chardev (247:0)
[    8.895030] Segment Routing with IPv6
[    8.903032]  mmcblk1: p1 p2
[    8.904682] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    8.914409] NET: Registered protocol family 17
[    8.918894] can: controller area network core (rev 20170425 abi 9)
[    8.925265] NET: Registered protocol family 29
[    8.929747] can: raw protocol (rev 20170425)
[    8.934076] can: broadcast manager protocol (rev 20170425 t)
[    8.939777] can: netlink gateway (rev 20170425) max_hops=3D1
[    8.945587] 8021q: 802.1Q VLAN Support v1.8
[    8.949853] Key type dns_resolver registered
[    8.954839] vddarm: supplied by vdd_arm
[    8.959844] vddpu: supplied by vdd_soc
[    8.964669] vddsoc: supplied by vdd_soc
[    8.971151] Registering SWP/SWPB emulation handler
[    8.976724] Loading compiled-in X.509 certificates
[    8.997905] imx_thermal tempmon: Automotive CPU temperature grade -
max:125C critical:120C passive:115C
[    9.002301] usb 1-1.4.1: new full-speed USB device number 4 using ci_hdr=
c
[    9.016846] hctosys: unable to open rtc device (rtc0)
[    9.022666] VCC_CAM0: disabling
[    9.025820] flexcan1-reg: disabling
[    9.029318] usb_otg_vbus: disabling
[    9.032867] peb-display: disabling
[    9.036999] vdd_eth_io: disabling







-- Fawad Lateef

On Thu, 22 Aug 2019 at 11:34, Schmid, Carsten <Carsten_Schmid@mentor.com> w=
rote:
>
> >
> > Have a question that: Can I disable PCIe power management completely
> > using some kernel CONFIG option OR boot parameter? If yes then how?
> >
> > Thanks
> >
> See CONFIG_PM and what it depends on.
>
> BR
> Carsten
