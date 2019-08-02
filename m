Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD767F591
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2019 12:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfHBKzf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Aug 2019 06:55:35 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38719 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfHBKze (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Aug 2019 06:55:34 -0400
Received: by mail-qk1-f193.google.com with SMTP id a27so54437548qkk.5;
        Fri, 02 Aug 2019 03:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XW6JYevwAaHlybD0JfOTxC5W5OvACr5CMzkar8ByWvk=;
        b=ShZ14OKv+FrudOCJwNI+BgJ5tjKMHR0VC75jUT82OYGanoomT3fVzXjpSA7YieCBK1
         3+vXV+VuRif9oRage3kQIIVgPQ+/Q2mSogdBLROAiCLQWu9IbZhiPXNufY593gE5n3bL
         IH6PzzxrD9iyQbqGaG8lE2R+HiHsyTqnuOa4E/wW3CoCRKnSquDkvlud9EQRAhZ/3T7U
         Cpw4t1gT+iyusGDSz81/Hm9Nl/kEKLgUYjZM30/7MRampn6Y2QOU30ZZfy6E11UDObxg
         ANfOjqsFabQh9QNEq6QGZgZRBXa6vnEpRVOQcLgZDDssY9t1jUilGgZZ+subXhlvBKH9
         Bn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XW6JYevwAaHlybD0JfOTxC5W5OvACr5CMzkar8ByWvk=;
        b=r32Hfm2fycoHTJSuboaq1Nx9yBb9MftILc9i4RR8BsEQa07+5qlRNuoX1EAPkqnebw
         Ha4AS9zEMXuaRQyuflE1BQoDQDopgi6bkQd1V8ndJDi6Udotlf1jHtXT0t2Is5riX0t4
         MIKKDt/PE/3Nrx+uWgHOoJZrc4tY0CseXbt+BEZbOc/4kpkRDp0NIglUTx5SXGRpvfyu
         2mCm7O6GaZLpW3hMXiBD+6LzW/ozy+SiV0Z3gsI2dOpF4sh0OsZHFRenLeByiM0YU96l
         uvccDGWqylB0YiHcy/UgDLdDqauNndy2OdRZ8wcKIWB7ixtSugvsbhCAwWngLiOWjJKM
         toDQ==
X-Gm-Message-State: APjAAAUxL9OWxK5Aw+HA2i917E1RRkVdkVqaD9fzkIbvGXimWzKiPsXX
        WNPc6N4QdRtCSeG+DP36inH7SFuZm6iPSY7iBFg=
X-Google-Smtp-Source: APXvYqw7tBTXG4Msq2lbiiwJPI4wkXTJINr63faq4z7uoVyoDZwwI22CnkQ645gdLKwh6boyZq7d5mrKWp0FgdwxZSw=
X-Received: by 2002:a37:90c1:: with SMTP id s184mr79939879qkd.217.1564743331579;
 Fri, 02 Aug 2019 03:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAGgoGu5FfLFzCf0QiAd8UcMrZ7gtLyapgT3TZ-Hx0dknWy4LMQ@mail.gmail.com>
 <CAGgoGu4zP_7QpKHiXSkLfkb=zHEezBzstVfjQMQ4CO60+YubCw@mail.gmail.com>
 <CAGgoGu7rot61LSgu2syOMq9Onx26_u3PEtS7pf_QNQRxOaifhg@mail.gmail.com> <20190801171725.GD151852@google.com>
In-Reply-To: <20190801171725.GD151852@google.com>
From:   Fawad Lateef <fawadlateef@gmail.com>
Date:   Fri, 2 Aug 2019 12:55:20 +0200
Message-ID: <CAGgoGu6Wpjad28Ruv5Bwb=PgqC62Sv9NEytYjYQmFH3+xp3KOA@mail.gmail.com>
Subject: Re: Unhandled fault: imprecise external abort (0x1406) when loading
 xhci_pci.ko - uPD720202, PEX8605, iMX6Q and linux-4.19.25
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
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

Hi Bjorn,

On Thu, 1 Aug 2019 at 19:17, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc i.MX6 folks]
>
> On Thu, Aug 01, 2019 at 10:18:22AM +0200, Fawad Lateef wrote:
> > Hi everyone,
> >
> > I am trying to get Renesas uPD720202 USB3.0 hub working which is
> > connected PCIe switch (PEX8605); PEX8605 is connected to i.MX6Q
> > through its x1 PCIe Gen2 interface. Running Linux-4.19.25 vanilla
> > kernel with patches from Phytec.de for their Phycore-iMX6Q SOM.
> >
> > We have 2x PEX8605 ports connected to mPCIe slots and 2x WLAN modules
> > (QCA9880) working perfectly.
> >
> > Facing kernel "Unhandled fault: imprecise external abort (0x1406)"
> > when trying to load xhci_pci.ko module for uPD720202. Receiving this
> > fault straight-away when driver trying to setup device.
> >
> > uPD720202 don't have external EEPROM support, so I have to load
> > firmware in chips memory before loading the driver. Sometimes after
> > loading the driver, I see the USB3.0 hub but then doing "lsusb -v"
> > crashes the driver with same above mentioned fault.
>
> I'm guessing this is an MMIO read to the xHCI that failed.  When an
> MIMO read fails, most systems just return 0xffffffff data without
> causing an exception.
>
> Can you tell if the external abort is related to a CPU memory access?
> If so, can you find the address?  If it's an MMIO access to the xHCI,
> it should be in the [mem 0x01100000-0x01101fff 64bit] range assigned
> to its BAR 0, but I didn't see any likely looking addresses in the
> dump.
>

The current update is:

When uPD720202 is attached to PEX8605, after getting chips out of
RESET state; in few minutes PCIe switch (PEX8605) asserts FATAL_ERR
pin. If uPD is not attached then FATAL_ERR don't happen.

After FATAL_ERR; the Error register FB8h (of PEX8065) for bus
"2:01:00" (connected to uPD) reports "00 00 00 20h" .... set bit for
Surprise Down Error. Though we can still continue to upload firmware
to the chip.

When loading xhci_pci.ko driver, I am consistently seeing "Unhandled
fault: imprecise external abort (0x1406) at xxxxxxxxx" while in
xhci_gen_setup(); adding debug messages somehow shows that the
xhci->cap_regs =3D=3D NULL thus the assignment "xhci->cap_regs =3D
hcd->regs;" fails. Though once I saw it moved forward till "
xhci_zero_64b_regs(xhci);"  and died.

Not sure if the above is because of some kernel bug or hardware issue.
Didn't debugged it yet from the calling function as this is weird that
xhci->cap_regs is NULL (can it be null if there is some hardware
communication error before xhci_gen_setup call?

I will also look at the addresses closer as you mentioned to see if
its CPU memory access or MMIO. At this moment I don't have access to
hardware; left it with the hardware designer to verify/debug some
hardware clocks.

> > Tried to disable DMA from kernel configuration but still same result.
> > From hardware side verified the RESET pins for PEX8605 and uPD720202
> > chips but no change.
> >
> > Also wanted to read PCIe switch registers using I2C interface but have
> > to figure-out how to do that (saw some patches email from Rajat Jain
> > from 2014 but seems like can't find the patch attachment anywhere on
> > Google).
> >
> > The kernel log is below. Any help or pointers in solving this problem
> > will be much appreciated.
> >
> > [    0.000000] Booting Linux on physical CPU 0x0
> > [    0.000000] Linux version 4.19.25-bsp-yocto-i.mx6-pd18.1.1
> > (br-user@flateef-XPS-13-9360) (gcc version 8.2.0 (Buildroot
> > 2018.11.4-gebef590b)) #3 SMP Wed Jul 31 11:13:06 UTC 2019
> > [    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=
=3D10c5387d
> > [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> > instruction cache
> > [    0.000000] OF: fdt: Machine model: PHYTEC phyBOARD-Mira Quad full
> > featured with eMMC
> > [    0.000000] Memory policy: Data cache writealloc
> > [    0.000000] cma: Reserved 128 MiB at 0x86000000
> > [    0.000000] On node 0 totalpages: 524288
> > [    0.000000]   Normal zone: 1536 pages used for memmap
> > [    0.000000]   Normal zone: 0 pages reserved
> > [    0.000000]   Normal zone: 196608 pages, LIFO batch:63
> > [    0.000000]   HighMem zone: 327680 pages, LIFO batch:63
> > [    0.000000] random: get_random_bytes called from
> > start_kernel+0x88/0x3f8 with crng_init=3D0
> > [    0.000000] percpu: Embedded 16 pages/cpu @(ptrval) s34828 r8192
> > d22516 u65536
> > [    0.000000] pcpu-alloc: s34828 r8192 d22516 u65536 alloc=3D16*4096
> > [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
> > [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 5=
22752
> > [    0.000000] Kernel command line:  console=3Dttymxc1,115200n8
> > root=3D/dev/mmcblk3p2 rootwait rw
> > [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 52428=
8 bytes)
> > [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 =
bytes)
> > [    0.000000] Memory: 1934476K/2097152K available (8192K kernel code,
> > 357K rwdata, 2464K rodata, 1024K init, 398K bss, 31604K reserved,
> > 131072K cma-reserved, 1178732K highmem)
> > [    0.000000] Virtual kernel memory layout:
> > [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> > [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> > [    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
> > [    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
> > [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> > [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> > [    0.000000]       .text : 0x(ptrval) - 0x(ptrval)   (9184 kB)
> > [    0.000000]       .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
> > [    0.000000]       .data : 0x(ptrval) - 0x(ptrval)   ( 358 kB)
> > [    0.000000]        .bss : 0x(ptrval) - 0x(ptrval)   ( 399 kB)
> > [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D=
4, Nodes=3D1
> > [    0.000000] rcu: Hierarchical RCU implementation.
> > [    0.000000] rcu:     RCU event tracing is enabled.
> > [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> > [    0.000000] L2C-310 errata 752271 769419 enabled
> > [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> > [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
> > [    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
> > [    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabl=
ed
> > [    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
> > [    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
> > [    0.000000] Switching to timer-based delay loop, resolution 333ns
> > [    0.000015] sched_clock: 32 bits at 3000kHz, resolution 333ns,
> > wraps every 715827882841ns
> > [    0.000049] clocksource: mxc_timer1: mask: 0xffffffff max_cycles:
> > 0xffffffff, max_idle_ns: 637086815595 ns
> > [    0.002812] Console: colour dummy device 80x30
> > [    0.002873] Calibrating delay loop (skipped), value calculated
> > using timer frequency.. 6.00 BogoMIPS (lpj=3D30000)
> > [    0.002903] pid_max: default: 32768 minimum: 301
> > [    0.003188] Mount-cache hash table entries: 2048 (order: 1, 8192 byt=
es)
> > [    0.003229] Mountpoint-cache hash table entries: 2048 (order: 1, 819=
2 bytes)
> > [    0.004259] CPU: Testing write buffer coherency: ok
> > [    0.004319] CPU0: Spectre v2: using BPIALL workaround
> > [    0.004991] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> > [    0.006092] Setting up static identity map for 0x10100000 - 0x101000=
78
> > [    0.006363] rcu: Hierarchical SRCU implementation.
> > [    0.007568] smp: Bringing up secondary CPUs ...
> > [    0.008817] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> > [    0.008827] CPU1: Spectre v2: using BPIALL workaround
> > [    0.010352] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
> > [    0.010364] CPU2: Spectre v2: using BPIALL workaround
> > [    0.011759] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
> > [    0.011770] CPU3: Spectre v2: using BPIALL workaround
> > [    0.011973] smp: Brought up 1 node, 4 CPUs
> > [    0.011997] SMP: Total of 4 processors activated (24.00 BogoMIPS).
> > [    0.012014] CPU: All CPU(s) started in SVC mode.
> > [    0.013747] devtmpfs: initialized
> > [    0.031282] VFP support v0.3: implementor 41 architecture 3 part 30
> > variant 9 rev 4
> > [    0.031759] clocksource: jiffies: mask: 0xffffffff max_cycles:
> > 0xffffffff, max_idle_ns: 19112604462750000 ns
> > [    0.031800] futex hash table entries: 1024 (order: 4, 65536 bytes)
> > [    0.044378] pinctrl core: initialized pinctrl subsystem
> > [    0.046052] NET: Registered protocol family 16
> > [    0.058858] DMA: preallocated 256 KiB pool for atomic coherent alloc=
ations
> > [    0.059733] audit: initializing netlink subsys (disabled)
> > [    0.060061] audit: type=3D2000 audit(0.060:1): state=3Dinitialized
> > audit_enabled=3D0 res=3D1
> > [    0.061065] CPU identified as i.MX6Q, silicon rev 1.5
> > [    0.071628] vdd1p1: supplied by regulator-dummy
> > [    0.072504] vdd3p0: supplied by regulator-dummy
> > [    0.073315] vdd2p5: supplied by regulator-dummy
> > [    0.093445] No ATAGs?
> > [    0.093674] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
> > watchpoint registers.
> > [    0.093704] hw-breakpoint: maximum watchpoint size is 4 bytes.
> > [    0.096202] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl dr=
iver
> > [    0.134079] mxs-dma 110000.dma-apbh: initialized
> > [    0.141747] SCSI subsystem initialized
> > [    0.142183] libata version 3.00 loaded.
> > [    0.142561] usbcore: registered new interface driver usbfs
> > [    0.142661] usbcore: registered new interface driver hub
> > [    0.142816] usbcore: registered new device driver usb
> > [    0.145330] i2c i2c-0: IMX I2C adapter registered
> > [    0.145364] i2c i2c-0: can't use DMA, using PIO instead.
> > [    0.146253] i2c i2c-1: IMX I2C adapter registered
> > [    0.146285] i2c i2c-1: can't use DMA, using PIO instead.
> > [    0.147511] i2c i2c-2: IMX I2C adapter registered
> > [    0.147543] i2c i2c-2: can't use DMA, using PIO instead.
> > [    0.147877] pps_core: LinuxPPS API ver. 1 registered
> > [    0.147898] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
> > Rodolfo Giometti <giometti@linux.it>
> > [    0.147942] PTP clock support registered
> > [    0.149207] Bluetooth: Core ver 2.22
> > [    0.149351] NET: Registered protocol family 31
> > [    0.149371] Bluetooth: HCI device and connection manager initialized
> > [    0.149400] Bluetooth: HCI socket layer initialized
> > [    0.149421] Bluetooth: L2CAP socket layer initialized
> > [    0.149488] Bluetooth: SCO socket layer initialized
> > [    0.150351] clocksource: Switched to clocksource mxc_timer1
> > [    0.150704] VFS: Disk quotas dquot_6.6.0
> > [    0.150854] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096=
 bytes)
> > [    0.167130] NET: Registered protocol family 2
> > [    0.168273] tcp_listen_portaddr_hash hash table entries: 512
> > (order: 0, 6144 bytes)
> > [    0.168336] TCP established hash table entries: 8192 (order: 3, 3276=
8 bytes)
> > [    0.168506] TCP bind hash table entries: 8192 (order: 4, 65536 bytes=
)
> > [    0.168780] TCP: Hash tables configured (established 8192 bind 8192)
> > [    0.169113] UDP hash table entries: 512 (order: 2, 16384 bytes)
> > [    0.169195] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
> > [    0.169686] NET: Registered protocol family 1
> > [    0.170642] RPC: Registered named UNIX socket transport module.
> > [    0.170663] RPC: Registered udp transport module.
> > [    0.170677] RPC: Registered tcp transport module.
> > [    0.170692] RPC: Registered tcp NFSv4.1 backchannel transport module=
.
> > [    0.170715] PCI: CLS 0 bytes, default 64
> > [    0.171954] hw perfevents: no interrupt-affinity property for /pmu, =
guessing.
> > [    0.172349] hw perfevents: enabled with armv7_cortex_a9 PMU driver,
> > 7 counters available
> > [    0.175261] Initialise system trusted keyrings
> > [    0.175573] workingset: timestamp_bits=3D30 max_order=3D19 bucket_or=
der=3D0
> > [    0.184016] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> > [    0.185099] NFS: Registering the id_resolver key type
> > [    0.185145] Key type id_resolver registered
> > [    0.185163] Key type id_legacy registered
> > [    0.185238] jffs2: version 2.2. (NAND) =EF=BF=BD=C2=A9 2001-2006 Red=
 Hat, Inc.
> > [    0.186012] fuse init (API version 7.27)
> > [    0.195230] Key type asymmetric registered
> > [    0.195255] Asymmetric key parser 'x509' registered
> > [    0.195358] bounce: pool size: 64 pages
> > [    0.195390] io scheduler noop registered
> > [    0.195407] io scheduler deadline registered
> > [    0.195663] io scheduler cfq registered (default)
> > [    0.195687] io scheduler mq-deadline registered
> > [    0.195704] io scheduler kyber registered
>
> > [    0.199805] imx6q-pcie 1ffc000.pcie: Linked as a consumer to regulat=
or.12
> > [    0.199899] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 r=
anges:
> > [    0.199964] imx6q-pcie 1ffc000.pcie:    IO 0x01f80000..0x01f8ffff
> > -> 0x00000000
> > [    0.200006] imx6q-pcie 1ffc000.pcie:   MEM 0x01000000..0x01efffff
> > -> 0x01000000
> > [    0.420529] imx6q-pcie 1ffc000.pcie: Link up
> > [    0.420554] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
> > [    0.420575] imx6q-pcie 1ffc000.pcie: Link up, Gen1
> > [    0.420902] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> > [    0.420934] pci_bus 0000:00: root bus resource [bus 00-ff]
> > [    0.420959] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> > [    0.420982] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01e=
fffff]
> > [    0.421051] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
> > [    0.421106] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
> > [    0.421133] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff p=
ref]
> > [    0.421237] pci 0000:00:00.0: supports D1
> > [    0.421252] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> > [    0.431113] PCI: bus0: Fast back to back transfers disabled
> > [    0.431458] pci 0000:01:00.0: [10b5:8605] type 01 class 0x060400
> > [    0.431685] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff]
> > [    0.432403] pci 0000:01:00.0: supports D1 D2
> > [    0.432418] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3c=
old
> > [    0.432622] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth,
> > limited by 2.5 GT/s x1 link at 0000:00:00.0 (capable of 4.000 Gb/s
> > with 5 GT/s x1 link)
> > [    0.469726] PCI: bus1: Fast back to back transfers disabled
> > [    0.469770] pci 0000:01:00.0: bridge configuration invalid ([bus
> > 00-00]), reconfiguring
> > [    0.470736] pci 0000:02:01.0: [10b5:8605] type 01 class 0x060400
> > [    0.471649] pci 0000:02:01.0: supports D1 D2
> > [    0.471663] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3c=
old
> > [    0.472678] pci 0000:02:02.0: [10b5:8605] type 01 class 0x060400
> > [    0.473584] pci 0000:02:02.0: supports D1 D2
> > [    0.473598] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3c=
old
> > [    0.474617] pci 0000:02:03.0: [10b5:8605] type 01 class 0x060400
> > [    0.475520] pci 0000:02:03.0: supports D1 D2
> > [    0.475534] pci 0000:02:03.0: PME# supported from D0 D1 D2 D3hot D3c=
old
> > [    0.485021] PCI: bus2: Fast back to back transfers disabled
> > [    0.485062] pci 0000:02:01.0: bridge configuration invalid ([bus
> > 00-00]), reconfiguring
> > [    0.485132] pci 0000:02:02.0: bridge configuration invalid ([bus
> > 00-00]), reconfiguring
> > [    0.485199] pci 0000:02:03.0: bridge configuration invalid ([bus
> > 00-00]), reconfiguring
> > [    0.485764] pci 0000:03:00.0: [1912:0015] type 00 class 0x0c0330
> > [    0.485993] pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x00001fff 6=
4bit]
> > [    0.486752] pci 0000:03:00.0: PME# supported from D0 D3hot
> > [    0.487022] pci 0000:03:00.0: 2.000 Gb/s available PCIe bandwidth,
> > limited by 2.5 GT/s x1 link at 0000:00:00.0 (capable of 4.000 Gb/s
> > with 5 GT/s x1 link)
> > [    0.549694] PCI: bus3: Fast back to back transfers disabled
> > [    0.549732] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to=
 03
> > [    0.550287] pci 0000:04:00.0: [168c:003c] type 00 class 0x028000
> > [    0.550576] pci 0000:04:00.0: reg 0x10: [mem 0x00000000-0x001fffff 6=
4bit]
> > [    0.550832] pci 0000:04:00.0: reg 0x30: [mem 0x00000000-0x0000ffff p=
ref]
> > [    0.551344] pci 0000:04:00.0: supports D1 D2
> > [    0.551360] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3c=
old
> > [    0.561547] PCI: bus4: Fast back to back transfers disabled
> > [    0.561583] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to=
 04
> > [    0.571176] PCI: bus5: Fast back to back transfers enabled
> > [    0.571210] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to=
 05
> > [    0.571256] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to=
 05
> > [    0.571586] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010f=
ffff]
> > [    0.571620] pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x016f=
ffff]
> > [    0.571647] pci 0000:00:00.0: BAR 9: assigned [mem
> > 0x01700000-0x018fffff pref]
> > [    0.571672] pci 0000:00:00.0: BAR 6: assigned [mem
> > 0x01900000-0x0190ffff pref]
> > [    0.571695] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
> > [    0.571727] pci 0000:01:00.0: BAR 8: assigned [mem 0x01100000-0x015f=
ffff]
> > [    0.571751] pci 0000:01:00.0: BAR 9: assigned [mem
> > 0x01700000-0x018fffff 64bit pref]
> > [    0.571773] pci 0000:01:00.0: BAR 0: assigned [mem 0x01600000-0x0160=
3fff]
> > [    0.571816] pci 0000:01:00.0: BAR 7: assigned [io  0x1000-0x1fff]
> > [    0.571849] pci 0000:02:01.0: BAR 8: assigned [mem 0x01100000-0x012f=
ffff]
> > [    0.571872] pci 0000:02:01.0: BAR 9: assigned [mem
> > 0x01700000-0x018fffff 64bit pref]
> > [    0.571896] pci 0000:02:02.0: BAR 8: assigned [mem 0x01300000-0x015f=
ffff]
> > [    0.571917] pci 0000:02:01.0: BAR 7: assigned [io  0x1000-0x1fff]
> > [    0.571945] pci 0000:03:00.0: BAR 0: assigned [mem
> > 0x01100000-0x01101fff 64bit]
> > [    0.572040] pci 0000:02:01.0: PCI bridge to [bus 03]
> > [    0.572071] pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
> > [    0.572119] pci 0000:02:01.0:   bridge window [mem 0x01100000-0x012f=
ffff]
> > [    0.572157] pci 0000:02:01.0:   bridge window [mem
> > 0x01700000-0x018fffff 64bit pref]
> > [    0.572221] pci 0000:04:00.0: BAR 0: assigned [mem
> > 0x01400000-0x015fffff 64bit]
> > [    0.572313] pci 0000:04:00.0: BAR 6: assigned [mem
> > 0x01300000-0x0130ffff pref]
> > [    0.572334] pci 0000:02:02.0: PCI bridge to [bus 04]
> > [    0.572380] pci 0000:02:02.0:   bridge window [mem 0x01300000-0x015f=
ffff]
> > [    0.572454] pci 0000:02:03.0: PCI bridge to [bus 05]
> > [    0.572552] pci 0000:01:00.0: PCI bridge to [bus 02-05]
> > [    0.572580] pci 0000:01:00.0:   bridge window [io  0x1000-0x1fff]
> > [    0.572626] pci 0000:01:00.0:   bridge window [mem 0x01100000-0x015f=
ffff]
> > [    0.572663] pci 0000:01:00.0:   bridge window [mem
> > 0x01700000-0x018fffff 64bit pref]
> > [    0.572716] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> > [    0.572735] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> > [    0.572757] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x016f=
ffff]
> > [    0.572777] pci 0000:00:00.0:   bridge window [mem
> > 0x01700000-0x018fffff pref]
> > [    0.573483] pcieport 0000:00:00.0: Signaling PME with IRQ 296
> > [    0.573835] pcieport 0000:00:00.0: AER enabled with IRQ 296
> > [    0.574202] pcieport 0000:01:00.0: enabling device (0140 -> 0143)
> > [    0.576139] pcieport 0000:02:01.0: enabling device (0140 -> 0143)
> > [    0.578257] pcieport 0000:02:02.0: enabling device (0140 -> 0142)
> > [    0.581817] pci 0000:03:00.0: enabling device (0140 -> 0142)
> > [    7.527313] pci 0000:03:00.0: xHCI HW not ready after 5 sec (HC
> > bug?) status =3D 0x801
> > [    7.527485] pci 0000:03:00.0: quirk_usb_early_handoff+0x0/0x80c
> > took 6782847 usecs
> > [    7.531041] imx-sdma 20ec000.sdma: loaded firmware 3.3
> > [    7.536911] imx-pgc-pd imx-pgc-power-domain.0: DMA mask not set
> > [    7.537029] imx-pgc-pd imx-pgc-power-domain.0: Linked as a consumer
> > to 20dc000.gpc
> > [    7.537137] imx-pgc-pd imx-pgc-power-domain.1: DMA mask not set
> > [    7.539524] 21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq =3D 63,
> > base_baud =3D 5000000) is a IMX
> > [    8.735339] console [ttymxc1] enabled
> > [    8.740143] 21ec000.serial: ttymxc2 at MMIO 0x21ec000 (irq =3D 64,
> > base_baud =3D 5000000) is a IMX
> > [    8.766636] brd: module loaded
> > [    8.786902] loop: module loaded
> > [    8.791356] at24 2-0050: 4096 byte 24c32 EEPROM, writable, 1 bytes/w=
rite
> > [    8.801418] da9062 2-0058: Device detected (device-ID: 0x62,
> > var-ID: 0x22, DA9062)
> > [    8.836209] vdd_snvs: Bringing 3100000uV into 3000000-3000000uV
> > [    8.842493] random: fast init done
> > [    8.849376] vdd_high: Bringing 3100000uV into 3000000-3000000uV
> > [    8.859173] vdd_eth_io: Bringing 2600000uV into 2500000-2500000uV
> > [    8.868280] vdd_emmc: Bringing 1900000uV into 1800000-1800000uV
> > [    8.879983] ahci-imx 2200000.sata: fsl,transmit-level-mV not
> > specified, using 00000024
> > [    8.887987] ahci-imx 2200000.sata: fsl,transmit-boost-mdB not
> > specified, using 00000480
> > [    8.896071] ahci-imx 2200000.sata: fsl,transmit-atten-16ths not
> > specified, using 00002000
> > [    8.904307] ahci-imx 2200000.sata: fsl,receive-eq-mdB not
> > specified, using 05000000
> > [    8.915070] ahci-imx 2200000.sata: SSS flag set, parallel bus scan d=
isabled
> > [    8.922155] ahci-imx 2200000.sata: AHCI 0001.0300 32 slots 1 ports
> > 3 Gbps 0x1 impl platform mode
> > [    8.931006] ahci-imx 2200000.sata: flags: ncq sntf stag pm led clo
> > only pmp pio slum part ccc apst
> > [    8.942593] scsi host0: ahci-imx
> > [    8.946389] ata1: SATA max UDMA/133 mmio [mem
> > 0x02200000-0x02203fff] port 0x100 irq 67
> > [    8.962342] m25p80 spi0.0: n25q128a13 (16384 Kbytes)
> > [    8.969007] spi_imx 2008000.ecspi: probed
> > [    8.974411] libphy: Fixed MDIO Bus: probed
> > [    8.979382] CAN device driver interface
> > [    8.986038] usbcore: registered new interface driver asix
> > [    8.991578] usbcore: registered new interface driver ax88179_178a
> > [    8.997747] usbcore: registered new interface driver cdc_ether
> > [    9.003697] usbcore: registered new interface driver net1080
> > [    9.009430] usbcore: registered new interface driver cdc_subset
> > [    9.015466] usbcore: registered new interface driver zaurus
> > [    9.021189] usbcore: registered new interface driver cdc_ncm
> > [    9.026862] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
> > [    9.033434] ehci-pci: EHCI PCI platform driver
> > [    9.038000] ehci-platform: EHCI generic platform driver
> > [    9.043770] ehci-mxc: Freescale On-Chip EHCI Host driver
> > [    9.049668] usbcore: registered new interface driver usb-storage
> > [    9.058946] imx_usb 2184000.usb: Linked as a consumer to regulator.1=
4
> > [    9.071501] imx_usb 2184200.usb: Linked as a consumer to regulator.1=
3
> > [    9.081344] ci_hdrc ci_hdrc.1: EHCI Host Controller
> > [    9.086283] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus =
number 1
> > [    9.120413] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
> > [    9.127076] hub 1-0:1.0: USB hub found
> > [    9.130967] hub 1-0:1.0: 1 port detected
> > [    9.139528] da9063-rtc da9062-rtc: DMA mask not set
> > [    9.154230] da9063-rtc da9062-rtc: rtc core: registered da9063-rtc a=
s rtc1
> > [    9.169336] rtc-m41t80 0-0068: registered as rtc0
> > [    9.176016] snvs_rtc 20cc000.snvs:snvs-rtc-lp: rtc core: registered
> > 20cc000.snvs:snvs-rtc-lp as rtc2
> > [    9.185537] i2c /dev entries driver
> > [    9.194316] Bluetooth: HCI UART driver ver 2.3
> > [    9.198784] Bluetooth: HCI UART protocol H4 registered
> > [    9.204831] sdhci: Secure Digital Host Controller Interface driver
> > [    9.211078] sdhci: Copyright(c) Pierre Ossman
> > [    9.215449] sdhci-pltfm: SDHCI platform and OF driver helper
> > [    9.222674] sdhci-esdhc-imx 2190000.usdhc: Got CD GPIO
> > [    9.261834] mmc0: SDHCI controller on 2190000.usdhc [2190000.usdhc]
> > using ADMA
> > [    9.270559] sdhci-esdhc-imx 219c000.usdhc: Linked as a consumer to
> > regulator.23
> > [    9.312317] mmc1: SDHCI controller on 219c000.usdhc [219c000.usdhc]
> > using ADMA
> > [    9.321406] leds-pca953x 0-0062: setting platform data
> > [    9.329555] leds-pca953x 0-0062: gpios 508...511
> > [    9.342193] caam 2100000.caam: Entropy delay =3D 3200
> > [    9.384183] mmc1: new DDR MMC card at address 0001
> > [    9.391491] mmcblk3: mmc1:0001 Q2J55L 7.09 GiB
> > [    9.397946] mmcblk3boot0: mmc1:0001 Q2J55L partition 1 16.0 MiB
> > [    9.405996] mmcblk3boot1: mmc1:0001 Q2J55L partition 2 16.0 MiB
> > [    9.407887] caam 2100000.caam: Instantiated RNG4 SH0
> > [    9.412372] mmcblk1rpmb: mmc1:0001 Q2J55L partition 3 4.00 MiB,
> > chardev (247:0)
> > [    9.426692]  mmcblk3: p1 p2
> > [    9.450457] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > [    9.457449] ata1.00: ATA-10: ADATA SU800NS38, R0427AC, max UDMA/133
> > [    9.463784] ata1.00: 250069680 sectors, multi 16: LBA48 NCQ (depth 3=
2)
> > [    9.468646] caam 2100000.caam: Instantiated RNG4 SH1
> > [    9.470985] ata1.00: configured for UDMA/133
> > [    9.475356] caam 2100000.caam: device ID =3D 0x0a16010000000000 (Era=
 4)
> > [    9.480309] scsi 0:0:0:0: Direct-Access     ATA      ADATA
> > SU800NS38  7AC  PQ: 0 ANSI: 5
> > [    9.486109] caam 2100000.caam: job rings =3D 2, qi =3D 0
> > [    9.500440] usb 1-1: new high-speed USB device number 2 using ci_hdr=
c
> > [    9.502828] sd 0:0:0:0: [sda] 250069680 512-byte logical blocks:
> > (128 GB/119 GiB)
> > [    9.514605] sd 0:0:0:0: [sda] Write Protect is off
> > [    9.519428] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> > [    9.519615] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
> > enabled, doesn't support DPO or FUA
> > [    9.525366] caam algorithms registered in /proc/crypto
> > [    9.531304]  sda: sda1 sda2
> > [    9.539319] sd 0:0:0:0: [sda] Attached SCSI disk
> > [    9.539813] caam_jr 2101000.jr0: registering rng-caam
> > [    9.549942] hidraw: raw HID events driver (C) Jiri Kosina
> > [    9.555665] usbcore: registered new interface driver usbhid
> > [    9.561283] usbhid: USB HID core driver
> > [    9.568887] NET: Registered protocol family 10
> > [    9.575051] Segment Routing with IPv6
> > [    9.578866] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> > [    9.585961] NET: Registered protocol family 17
> > [    9.590479] can: controller area network core (rev 20170425 abi 9)
> > [    9.596811] NET: Registered protocol family 29
> > [    9.601308] can: raw protocol (rev 20170425)
> > [    9.605592] can: broadcast manager protocol (rev 20170425 t)
> > [    9.611298] can: netlink gateway (rev 20170425) max_hops=3D1
> > [    9.617070] 8021q: 802.1Q VLAN Support v1.8
> > [    9.621374] Key type dns_resolver registered
> > [    9.626321] vddarm: supplied by vdd_arm
> > [    9.631239] cpu cpu0: Linked as a consumer to regulator.4
> > [    9.636701] vddpu: supplied by vdd_soc
> > [    9.641499] cpu cpu0: Linked as a consumer to regulator.5
> > [    9.646962] vddsoc: supplied by vdd_soc
> > [    9.651884] cpu cpu0: Linked as a consumer to regulator.6
> > [    9.665622] cpu cpu0: Not using anatop LDO's: enabling LDO bypass
> > [    9.695470] Registering SWP/SWPB emulation handler
> > [    9.701162] Loading compiled-in X.509 certificates
> > [    9.701528] hub 1-1:1.0: USB hub found
> > [    9.709899] hub 1-1:1.0: 4 ports detected
> > [    9.724555] imx-pgc-pd imx-pgc-power-domain.1: Linked as a consumer
> > to regulator.5
> > [    9.732273] imx-pgc-pd imx-pgc-power-domain.1: Linked as a consumer
> > to 20dc000.gpc
> > [    9.740632] imx_thermal tempmon: Automotive CPU temperature grade -
> > max:125C critical:120C passive:115C
> > [    9.753112] rtc-m41t80 0-0068: hctosys: unable to read the hardware =
clock
> > [    9.760548] VCC_CAM0: disabling
> > [    9.763698] flexcan1-reg: disabling
> > [    9.767197] usb_otg_vbus: disabling
> > [    9.770727] peb-display: disabling
> > [    9.775283] vdd_eth_io: disabling
> > [    9.797362] EXT4-fs (mmcblk3p2): mounted filesystem with ordered
> > data mode. Opts: (null)
> > [    9.805576] VFS: Mounted root (ext4 filesystem) on device 179:2.
> > [    9.814229] devtmpfs: mounted
> > [    9.819797] Freeing unused kernel memory: 1024K
> > [    9.840589] Run /sbin/init as init process
> > [    9.953030] EXT4-fs (mmcblk3p2): re-mounted. Opts: (null)
> > [   10.040419] usb 1-1.4: new high-speed USB device number 3 using ci_h=
drc
> > [   10.191698] hub 1-1.4:1.0: USB hub found
> > [   10.195822] hub 1-1.4:1.0: 4 ports detected
> > [   10.520393] usb 1-1.4.1: new full-speed USB device number 4 using ci=
_hdrc
> > [   10.715913] cfg80211: Loading compiled-in X.509 certificates for
> > regulatory database
> > [   10.717475] usbcore: registered new interface driver usbserial_gener=
ic
> > [   10.730640] usbserial: USB Serial support registered for generic
> > [   10.748984] usbcore: registered new interface driver ftdi_sio
> > [   10.754914] usbserial: USB Serial support registered for FTDI USB
> > Serial Device
> > [   10.762608] ftdi_sio 1-1.4.1:1.0: FTDI USB Serial Device converter d=
etected
> > [   10.769803] usb 1-1.4.1: Detected FT232RL
> > [   10.772021] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea=
7'
> > [   10.774616] usb 1-1.4.1: FTDI USB Serial Device converter now
> > attached to ttyUSB0
> > [   10.849210] ath10k_pci 0000:04:00.0: enabling device (0140 -> 0142)
> > [   10.856167] ath10k_pci 0000:04:00.0: pci irq msi oper_irq_mode 2
> > irq_mode 0 reset_mode 0
> > [   10.989785] xhci_hcd 0000:03:00.0: xHCI Host Controller
> > [   10.995277] xhci_hcd 0000:03:00.0: new USB bus registered, assigned
> > bus number 2
> > [   11.148145] ath10k_pci 0000:04:00.0: qca988x hw2.0 target
> > 0x4100016c chip_id 0x043202ff sub 0000:0000
> > [   11.157413] ath10k_pci 0000:04:00.0: kconfig debug 1 debugfs 1
> > tracing 0 dfs 1 testmode 1
> > [   11.167090] ath10k_pci 0000:04:00.0: firmware ver 10.2.4-1.0-00037
> > api 5 features no-p2p,raw-mode,mfp,allows-mesh-bcast crc32 a4a52adb
> > [   11.216682] ath10k_pci 0000:04:00.0: board_file api 1 bmi_id N/A
> > crc32 bebc7c08
> >
> > <This below rcu_stall don't happen if I blacklist xhci_pci.ko module
> > and insmod it after uPD720202 firmware load)
> >
> > [   32.040328] rcu: INFO: rcu_sched self-detected stall on CPU
> > [   32.045923] rcu:     2-....: (1998 ticks this GP)
> > idle=3D2de/1/0x40000002 softirq=3D177/177 fqs=3D897
> > [   32.054448] rcu:      (t=3D2100 jiffies g=3D-887 q=3D34)
> > [   32.058988] NMI backtrace for cpu 2
> > [   32.062486] CPU: 2 PID: 190 Comm: modprobe Not tainted
> > 4.19.25-bsp-yocto-i.mx6-pd18.1.1 #3
> > [   32.070753] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tre=
e)
> > [   32.077313] [<c0110738>] (unwind_backtrace) from [<c010bbf4>]
> > (show_stack+0x10/0x14)
> > [   32.085073] [<c010bbf4>] (show_stack) from [<c0835458>]
> > (dump_stack+0x8c/0xac)
> > [   32.092309] [<c0835458>] (dump_stack) from [<c083b8a0>]
> > (nmi_cpu_backtrace+0x84/0xbc)
> > [   32.100150] [<c083b8a0>] (nmi_cpu_backtrace) from [<c083b9dc>]
> > (nmi_trigger_cpumask_backtrace+0x104/0x130)
> > [   32.109820] [<c083b9dc>] (nmi_trigger_cpumask_backtrace) from
> > [<c0179ee4>] (rcu_dump_cpu_stacks+0x94/0xc8)
> > [   32.119490] [<c0179ee4>] (rcu_dump_cpu_stacks) from [<c01792f0>]
> > (rcu_check_callbacks+0x66c/0x844)
> > [   32.128463] [<c01792f0>] (rcu_check_callbacks) from [<c017ea08>]
> > (update_process_times+0x30/0x6c)
> > [   32.137352] [<c017ea08>] (update_process_times) from [<c01904cc>]
> > (tick_sched_timer+0x5c/0xc0)
> > [   32.145976] [<c01904cc>] (tick_sched_timer) from [<c017fd0c>]
> > (__hrtimer_run_queues+0x148/0x208)
> > [   32.154772] [<c017fd0c>] (__hrtimer_run_queues) from [<c0180158>]
> > (hrtimer_interrupt+0x134/0x2cc)
> > [   32.163655] [<c0180158>] (hrtimer_interrupt) from [<c010f770>]
> > (twd_handler+0x2c/0x38)
> > [   32.171588] [<c010f770>] (twd_handler) from [<c016ce38>]
> > (handle_percpu_devid_irq+0x98/0x14c)
> > [   32.180123] [<c016ce38>] (handle_percpu_devid_irq) from
> > [<c0167a24>] (generic_handle_irq+0x20/0x34)
> > [   32.189182] [<c0167a24>] (generic_handle_irq) from [<c0168020>]
> > (__handle_domain_irq+0x64/0xe0)
> > [   32.197890] [<c0168020>] (__handle_domain_irq) from [<c041de38>]
> > (gic_handle_irq+0x4c/0xa8)
> > [   32.206252] [<c041de38>] (gic_handle_irq) from [<c0101a2c>]
> > (__irq_svc+0x6c/0x90)
> > [   32.213739] Exception stack(0xeca3dbd0 to 0xeca3dc18)
> > [   32.218798] dbc0:                                     00000002
> > 00000090 7fffd540 00000002
> > [   32.226982] dbe0: 00446304 ec4b2140 f0d7c020 00000000 000346dc
> > c0b21818 ec087078 c0d05148
> > [   32.235164] dc00: 000014e4 eca3dc20 c0832c1c bf1c6c74 20030013 fffff=
fff
> > [   32.241850] [<c0101a2c>] (__irq_svc) from [<bf1c6c74>]
> > (xhci_reset+0x9c/0x1d8 [xhci_hcd])
> > [   32.250101] [<bf1c6c74>] (xhci_reset [xhci_hcd]) from [<bf1c7568>]
> > (xhci_gen_setup+0x1e8/0x480 [xhci_hcd])
> > [   32.259802] [<bf1c7568>] (xhci_gen_setup [xhci_hcd]) from
> > [<bf1efaa8>] (xhci_pci_setup+0x40/0x8c [xhci_pci])
> > [   32.269651] [<bf1efaa8>] (xhci_pci_setup [xhci_pci]) from
> > [<c05b6f68>] (usb_add_hcd+0x258/0x764)
> > [   32.278454] [<c05b6f68>] (usb_add_hcd) from [<c05c9270>]
> > (usb_hcd_pci_probe+0x204/0x368)
> > [   32.286562] [<c05c9270>] (usb_hcd_pci_probe) from [<bf1ef0b0>]
> > (xhci_pci_probe+0x2c/0x174 [xhci_pci])
> > [   32.295801] [<bf1ef0b0>] (xhci_pci_probe [xhci_pci]) from
> > [<c0440a38>] (pci_device_probe+0xa4/0x138)
> > [   32.304954] [<c0440a38>] (pci_device_probe) from [<c04bf6d8>]
> > (really_probe+0x1f0/0x2bc)
> > [   32.313055] [<c04bf6d8>] (really_probe) from [<c04bf904>]
> > (driver_probe_device+0x5c/0x160)
> > [   32.321330] [<c04bf904>] (driver_probe_device) from [<c04bfae4>]
> > (__driver_attach+0xdc/0xe0)
> > [   32.329776] [<c04bfae4>] (__driver_attach) from [<c04bd9ec>]
> > (bus_for_each_dev+0x70/0xb4)
> > [   32.337966] [<c04bd9ec>] (bus_for_each_dev) from [<c04beb58>]
> > (bus_add_driver+0x194/0x1f8)
> > [   32.346241] [<c04beb58>] (bus_add_driver) from [<c04c0444>]
> > (driver_register+0x74/0x108)
> > [   32.354342] [<c04c0444>] (driver_register) from [<c0102698>]
> > (do_one_initcall+0x6c/0x1ac)
> > [   32.362535] [<c0102698>] (do_one_initcall) from [<c0198db0>]
> > (do_init_module+0x58/0x1f0)
> > [   32.370636] [<c0198db0>] (do_init_module) from [<c019b0b4>]
> > (load_module+0x2104/0x230c)
> > [   32.378647] [<c019b0b4>] (load_module) from [<c019b504>]
> > (sys_finit_module+0xbc/0xdc)
> > [   32.386485] [<c019b504>] (sys_finit_module) from [<c01011d4>]
> > (__sys_trace_return+0x0/0x10)
> > [   32.394838] Exception stack(0xeca3dfa8 to 0xeca3dff0)
> > [   32.399897] dfa0:                   00000000 01253268 00000003
> > 000b8342 00000000 012530b8
> > [   32.408081] dfc0: 00000000 01253268 01252e28 0000017b 000c9cb0
> > 00000001 012530b8 012532a8
> > [   32.416262] dfe0: befaac38 befaac28 00027a1c b6f1dbf0
> > [   49.524438] xhci_hcd 0000:03:00.0: can't setup: -110
> > [   49.529455] xhci_hcd 0000:03:00.0: USB bus 2 deregistered
> > [   49.534981] xhci_hcd 0000:03:00.0: init 0000:03:00.0 fail, -110
> > [   49.541005] xhci_hcd: probe of 0000:03:00.0 failed with error -110
> > [   49.577131] ath10k_pci 0000:04:00.0: htt-ver 2.1 wmi-op 5 htt-op 2
> > cal otp max-sta 128 raw 0 hwcrypto 1
> > [   49.674185] random: dd: uninitialized urandom read (512 bytes read)
> > [   49.708707] ath: EEPROM regdomain: 0x6a
> > [   49.708716] ath: EEPROM indicates we should expect a direct regpair =
map
> > [   49.708728] ath: Country alpha2 being used: 00
> > [   49.708731] ath: Regpair used: 0x6a
> > [   49.756484] random: dbus-uuidgen: uninitialized urandom read (12 byt=
es read)
> > [   49.763653] random: dbus-uuidgen: uninitialized urandom read (8 byte=
s read)
> > [   65.289080] urandom_read: 2 callbacks suppressed
> > [   65.289088] random: ssh-keygen: uninitialized urandom read (32 bytes=
 read)
> > [   65.330131] random: sshd: uninitialized urandom read (32 bytes read)
> > [  360.132197] random: crng init done
> >
> >
> > < Loading of uPD720202 firmware here>
> > # cd /upd72020x-load/
> > # sh ./check-and-init
> > Doing the upload
> > bus =3D 3
> > dev =3D 0
> > fct =3D 0
> > fname =3D ./K2026.mem
> > got firmware version: 200000
> > ERROR: ROM doesnt exist
> > no EEPROM installed
> > STATUS: enabling firmware upload
> > STATUS: performing firmware upload
> > STATUS: finishing firmware upload
> > STATUS: confirming firmware upload
> >  =3D=3D=3D=3D=3D=3D> PASSED
> >
> > [  505.546414] pci 0000:03:00.0: 2.000 Gb/s available PCIe bandwidth,
> > limited by 2.5 GT/s x1 link at 0000:00:00.0 (capable of 4.000 Gb/s
> > with 5 GT/s x1 link)
> > [  505.604961] pci 0000:03:00.0: BAR 0: assigned [mem
> > 0x01100000-0x01101fff 64bit]
> > [  505.612430] pci 0000:03:00.0: enabling device (0000 -> 0002)
> > [  505.618456] xhci_hcd 0000:03:00.0: xHCI Host Controller
> > [  505.623743] xhci_hcd 0000:03:00.0: new USB bus registered, assigned
> > bus number 2
> > [  505.638427] xhci_hcd 0000:03:00.0: hcc params 0x014051cf hci
> > version 0x100 quirks 0x0000000100000090
> > [  505.650036] hub 2-0:1.0: USB hub found
> > [  505.654043] hub 2-0:1.0: 2 ports detected
> > [  505.659855] xhci_hcd 0000:03:00.0: xHCI Host Controller
> > [  505.665354] xhci_hcd 0000:03:00.0: new USB bus registered, assigned
> > bus number 3
> > [  505.672879] xhci_hcd 0000:03:00.0: Host supports USB 3.0  SuperSpeed
> > [  505.679421] usb usb3: We don't know the algorithms for LPM for this
> > host, disabling LPM.
> > [  505.688555] hub 3-0:1.0: USB hub found
> > [  505.692429] hub 3-0:1.0: 2 ports detected
> > #
> >
> > < Doing lsusb -v never returned, had to kill it >
> > # /root/lsusb -v
> > # dmesg
> > [  573.066231] Unhandled fault: imprecise external abort (0x1406) at 0x=
02012628
> > [  573.075162] pgd =3D 2544a558
> > [  573.080731] [02012628] *pgd=3D84185831
> > [  573.087184] Internal error: : 1406 [#1] SMP ARM
> > [  573.094304] Modules linked in: xhci_pci xhci_hcd ath10k_pci
> > ath10k_core mac80211 ath ftdi_sio usbserial cfg80211
> > [  573.107353] CPU: 3 PID: 504 Comm: lsusb Not tainted
> > 4.19.25-bsp-yocto-i.mx6-pd18.1.1 #3
> > [  573.117951] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tre=
e)
> > [  573.126681] PC is at xhci_bus_resume+0xbc/0x534 [xhci_hcd]
> > [  573.134973] LR is at xhci_bus_resume+0x9c/0x534 [xhci_hcd]
> > [  573.143263] pc : [<bf1d7248>]    lr : [<bf1d7228>]    psr: 200f0093
> > [  573.151610] sp : ec923cc8  ip : 00000000  fp : ffffe000
> > [  573.158830] r10: 00000002  r9 : ec703800  r8 : 00000004
> > [  573.166138] r7 : ecad3000  r6 : 00000000  r5 : eca2ff80  r4 : ecad30=
00
> > [  573.174659] r3 : 00000000  r2 : 00000000  r1 : 00000018  r0 : 200f00=
13
> > [  573.183272] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
> > Segment none
> > [  573.192835] Control: 10c5387d  Table: 3ca0804a  DAC: 00000051
> > [  573.200750] Process lsusb (pid: 504, stack limit =3D 0x8e3ed15c)
> > [  573.208750] Stack: (0xec923cc8 to 0xec924000)
> > [  573.215370] 3cc0:                   00000001 00000008 ec736460
> > 00000340 ecad3140 200f0013
> > [  573.226150] 3ce0: ecad3170 ec135d40 006000c0 ecad3000 ec703800
> > eca6c878 c05be2e8 00000004
> > [  573.237089] 3d00: ec703800 c015a638 ffffe000 c05b8c4c ec703800
> > 00000410 eca6c878 c05be2e8
> > [  573.247255] 3d20: ec2b3f00 c05bd35c ec703878 00000000 eca6c878
> > c04ca280 00000004 ec703878
> > [  573.257509] 3d40: c05be2e8 eca6c878 c0d03d00 ec2b3f00 ec703800
> > c015a638 ffffe000 c04ca334
> > [  573.267676] 3d60: ec703878 c05be2e8 eca6c878 c04c9e6c ec923dcc
> > ec703914 00000001 c02273e0
> > [  573.277844] 3d80: eccb4ac0 ec08d080 ecafdd34 793301cc ec31a358
> > ec703878 00000004 ec7038f0
> > [  573.288011] 3da0: 600f0013 ec2b3f00 ec703800 00000000 ec2b3f00
> > c04ca0a8 ecae2380 ec703878
> > [  573.298178] 3dc0: ec703878 ec7038ac ec2b3f00 c05bd994 ecae2380
> > ec9f1550 ec703878 c05c27bc
> > [  573.308345] 3de0: c0db5dc4 c0964384 00000000 ec9f1550 c0d05148
> > ec2b3f00 00000000 c02209a4
> > [  573.318512] 3e00: 00000080 793301cc ec2b3f00 ec9f1550 00020002
> > 00000000 c02208cc ec2b3f08
> > [  573.328679] 3e20: 00000000 c0218874 ec923ec0 00000000 00020002
> > 00000000 00000006 ea4775d8
> > [  573.338847] 3e40: 00000000 c022afb4 00000000 c0d05148 00000000
> > 00000002 00000041 ffffe000
> > [  573.349099] 3e60: 00000000 00000000 00000000 ec923e6c ec923e6c
> > 793301cc 00000002 ec9f1550
> > [  573.359267] 3e80: ec34e710 ea477660 00000023 0200f603 00000023
> > 793301cc 00000023 00000009
> > [  573.369520] 3ea0: ec923f70 c0d05148 00000001 fffff000 ec922000
> > 00000142 0000000c c022d148
> > [  573.379687] 3ec0: ec34e710 ea477660 d1ef8db8 00000003 ec907021
> > 00000000 00000000 ea24f088
> > [  573.389856] 3ee0: ec9f1550 00000101 00000002 00000040 00000000
> > 00000000 00000000 ec923f00
> > [  573.400109] 3f00: 600b0013 ea1146e8 00000000 ec02a180 006000c0
> > c084ad90 006000c0 00000ff0
> > [  573.410362] 3f20: 0000000c 793301cc 00000009 00000020 ec907000
> > 00000000 00000000 00000002
> > [  573.420529] 3f40: ffffff9c c023bbdc 000a0002 793301cc ffffff9c
> > 00000009 c0d05148 ffffff9c
> > [  573.430784] 3f60: ec907000 c0219ef0 00000142 ec923fb0 00020002
> > 00000000 00000006 00000100
> > [  573.441038] 3f80: 00000001 793301cc be9c8950 00000000 02018390
> > 00000142 c0101204 ec922000
> > [  573.451292] 3fa0: 00000142 c01011d4 be9c8950 00000000 ffffff9c
> > be9c8950 000a0002 00000000
> > [  573.461546] 3fc0: be9c8950 00000000 02018390 00000142 0200f368
> > 00000002 b6f65e6c 0000000c
> > [  573.471799] 3fe0: 00000000 be9c8918 b6f967a0 b6e96bc8 800f0010
> > ffffff9c 00000000 00000000
> > [  573.482096] [<bf1d7248>] (xhci_bus_resume [xhci_hcd]) from
> > [<c05b8c4c>] (hcd_bus_resume+0x54/0x1a4)
> > [  573.493967] [<c05b8c4c>] (hcd_bus_resume) from [<c05bd35c>]
> > (usb_resume_both+0xa0/0x134)
> > [  573.504653] [<c05bd35c>] (usb_resume_both) from [<c04ca280>]
> > (__rpm_callback+0x158/0x1ec)
> > [  573.515335] [<c04ca280>] (__rpm_callback) from [<c04ca334>]
> > (rpm_callback+0x20/0x80)
> > [  573.523082] [<c04ca334>] (rpm_callback) from [<c04c9e6c>]
> > (rpm_resume+0x4d8/0x6b4)
> > [  573.530656] [<c04c9e6c>] (rpm_resume) from [<c04ca0a8>]
> > (__pm_runtime_resume+0x60/0x8c)
> > [  573.538665] [<c04ca0a8>] (__pm_runtime_resume) from [<c05bd994>]
> > (usb_autoresume_device+0x14/0x3c)
> > [  573.547634] [<c05bd994>] (usb_autoresume_device) from [<c05c27bc>]
> > (usbdev_open+0xb0/0x214)
> > [  573.555993] [<c05c27bc>] (usbdev_open) from [<c02209a4>]
> > (chrdev_open+0xd8/0x1ac)
> > [  573.563488] [<c02209a4>] (chrdev_open) from [<c0218874>]
> > (do_dentry_open+0x114/0x38c)
> > [  573.571328] [<c0218874>] (do_dentry_open) from [<c022afb4>]
> > (path_openat+0x2b0/0x1304)
> > [  573.579251] [<c022afb4>] (path_openat) from [<c022d148>]
> > (do_filp_open+0x6c/0xd8)
> > [  573.586741] [<c022d148>] (do_filp_open) from [<c0219ef0>]
> > (do_sys_open+0x150/0x1f0)
> > [  573.594405] [<c0219ef0>] (do_sys_open) from [<c01011d4>]
> > (__sys_trace_return+0x0/0x10)
> > [  573.602322] Exception stack(0xec923fa8 to 0xec923ff0)
> > [  573.607378] 3fa0:                   be9c8950 00000000 ffffff9c
> > be9c8950 000a0002 00000000
> > [  573.615558] 3fc0: be9c8950 00000000 02018390 00000142 0200f368
> > 00000002 b6f65e6c 0000000c
> > [  573.623737] 3fe0: 00000000 be9c8918 b6f967a0 b6e96bc8
> > [  573.628795] Code: e597214c e5926000 e3a02000 ee072f9a (e3c66004)
> > [  573.634894] ---[ end trace 2247f322516b4181 ]---
> > #
> >
> > Thanks in advance,
> >
> > -- Fawad Lateef
