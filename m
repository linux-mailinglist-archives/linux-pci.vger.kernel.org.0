Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5DB357094
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 17:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbhDGPkl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 11:40:41 -0400
Received: from smtp-out.xnet.cz ([178.217.244.18]:13373 "EHLO smtp-out.xnet.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235715AbhDGPkl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 11:40:41 -0400
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id 9A90D184EF;
        Wed,  7 Apr 2021 17:30:50 +0200 (CEST)
Received: by meh.true.cz (OpenSMTPD) with ESMTP id f42563f3;
        Wed, 7 Apr 2021 17:30:25 +0200 (CEST)
Date:   Wed, 7 Apr 2021 17:30:47 +0200
From:   Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Koen Vandeputte <koen.vandeputte@citymesh.com>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files
Message-ID: <20210407153041.GA17046@meh.true.cz>
Reply-To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
References: <20200909112850.hbtgkvwqy2rlixst@pali>
 <20201006222222.GA3221382@bjorn-Precision-5520>
 <20201007081227.d6f6otfsnmlgvegi@pali>
 <20210407142538.GA12387@meh.true.cz>
 <20210407145147.bvtubdmz4k6nulf7@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210407145147.bvtubdmz4k6nulf7@pali>
X-PGP-Key: https://gist.githubusercontent.com/ynezz/477f6d7a1623a591b0806699f9fc8a27/raw/a0878b8ed17e56f36ebf9e06a6b888a2cd66281b/pgp-key.pub
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali Rohár <pali@kernel.org> [2021-04-07 16:51:47]:

> Could you run 'dmesg' and provide its output? So also missing / garbage
> messages would be visible.

Adding it inline for archives. It's log from serial console, with output of dmesg at the
bottom so one can compare if needed.

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.10.27 (ynezz@ntbk) (arm-openwrt-linux-muslgnueabi-gcc (OpenWrt GCC 8.4.0 r12719+30-84f4a783c698) 8.4.0, GNU ld (GNU Binutils) 2.34) #0 SMP Wed Apr 7 12:52:23 2021
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: Toradex Apalis iMX6Q/D Module on Ixora Carrier Board
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Ignoring RAM at 0x80000000-0x90000000
[    0.000000] Consider using a HIGHMEM enabled kernel.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000010000000-0x000000007fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000010000000-0x000000007fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000010000000-0x000000007fffffff]
[    0.000000] percpu: Embedded 19 pages/cpu s47628 r8192 d22004 u77824
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 454720
[    0.000000] Kernel command line: earlyprintk console=ttymxc0,115200n8 root=PARTUUID=5452574f-02 rootfstype=squashfs rootwait pci=nomsi
[    0.000000] Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes, linear)
[    0.000000] Inode-cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 1802104K/1835008K available (9040K kernel code, 1170K rwdata, 2328K rodata, 1024K init, 242K bss, 32904K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] ftrace: allocating 31336 entries in 62 pages
[    0.000000] ftrace: allocated 62 pages with 5 groups
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000]  Rude variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] L2C-310 errata 752271 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
[    0.000000] random: get_random_bytes called from start_kernel+0x3e0/0x5a0 with crng_init=0
[    0.000000] Switching to timer-based delay loop, resolution 333ns
[    0.000008] sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 715827882841ns
[    0.000029] clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 637086815595 ns
[    0.001279] Console: colour dummy device 80x30
[    0.001318] Calibrating delay loop (skipped), value calculated using timer frequency.. 6.00 BogoMIPS (lpj=30000)
[    0.001340] pid_max: default: 32768 minimum: 301
[    0.001548] Mount-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
[    0.001588] Mountpoint-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
[    0.002484] CPU: Testing write buffer coherency: ok
[    0.002522] CPU0: Spectre v2: using BPIALL workaround
[    0.002789] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.003686] Setting up static identity map for 0x10100000 - 0x10100060
[    0.003845] rcu: Hierarchical SRCU implementation.
[    0.004844] smp: Bringing up secondary CPUs ...
[    0.005689] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.005698] CPU1: Spectre v2: using BPIALL workaround
[    0.006667] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.006676] CPU2: Spectre v2: using BPIALL workaround
[    0.007606] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.007615] CPU3: Spectre v2: using BPIALL workaround
[    0.007755] smp: Brought up 1 node, 4 CPUs
[    0.007770] SMP: Total of 4 processors activated (24.00 BogoMIPS).
[    0.007780] CPU: All CPU(s) started in SVC mode.
[    0.017479] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.017696] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.017731] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.017995] pinctrl core: initialized pinctrl subsystem
[    0.019710] NET: Registered protocol family 16
[    0.021665] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.023180] thermal_sys: Registered thermal governor 'step_wise'
[    0.023660] CPU identified as i.MX6Q, silicon rev 1.5
[    0.245571] vdd1p1: supplied by regulator-dummy
[    0.254210] vdd3p0: supplied by regulator-dummy
[    0.262785] vdd2p5: supplied by regulator-dummy
[    0.271321] vddarm: supplied by regulator-dummy
[    0.279909] vddpu: supplied by regulator-dummy
[    0.288419] vddsoc: supplied by regulator-dummy
[    0.628532] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    0.628554] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.628861] debugfs: Directory 'dummy-iomuxc-gpr@20e0000' with parent 'regmap' already present!
[    0.629263] imx6q-pinctrl 20e0000.pinctrl: initialized IMX pinctrl driver
[    0.647595] Kprobes globally optimized
[    0.650233] cryptd: max_cpu_qlen set to 1000
[    0.666849] mxs-dma 110000.dma-apbh: initialized
[    0.669973] usb_host_vbus: supplied by usb_host_vbus_hub
[    0.670896] SCSI subsystem initialized
[    0.671797] usbcore: registered new interface driver usbfs
[    0.671910] usbcore: registered new interface driver hub
[    0.671999] usbcore: registered new device driver usb
[    0.674185] i2c i2c-0: IMX I2C adapter registered
[    0.676657] i2c i2c-2: IMX I2C adapter registered
[    0.677730] i2c i2c-1: IMX I2C adapter registered
[    0.678202] pps_core: LinuxPPS API ver. 1 registered
[    0.678217] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.678258] PTP clock support registered
[    0.680434] clocksource: Switched to clocksource mxc_timer1
[    0.800167] NET: Registered protocol family 2
[    0.801060] tcp_listen_portaddr_hash hash table entries: 1024 (order: 1, 12288 bytes, linear)
[    0.801141] TCP established hash table entries: 16384 (order: 4, 65536 bytes, linear)
[    0.801432] TCP bind hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.802002] TCP: Hash tables configured (established 16384 bind 16384)
[    0.802377] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.802490] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.802831] NET: Registered protocol family 1
[    0.802876] PCI: CLS 0 bytes, default 64
[    0.803583] hw perfevents: no interrupt-affinity property for /pmu, guessing.
[    0.803842] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available
[    0.809163] workingset: timestamp_bits=14 max_order=19 bucket_order=5
[    0.813910] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.926864] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.929303] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:
[    0.929370] imx6q-pcie 1ffc000.pcie:       IO 0x0001f80000..0x0001f8ffff -> 0x0000000000
[    0.929411] imx6q-pcie 1ffc000.pcie:      MEM 0x0001000000..0x0001efffff -> 0x0001000000
[    0.936834] imx-sdma 20ec000.sdma: loaded firmware 3.5
[    0.938840] pfuze100-regulator 2-0008: Full layer: 1, Metal layer: 1
[    0.939545] pfuze100-regulator 2-0008: FAB: 0, FIN: 0
[    0.939560] pfuze100-regulator 2-0008: pfuze100 found.
[    0.956572] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    0.957946] 2020000.serial: ttymxc0 at MMIO 0x2020000 (irq = 34, base_baud = 5000000) is a IMX
[    1.670939] printk: console [ttymxc0] enabled
[    1.676645] 21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq = 81, base_baud = 5000000) is a IMX
[    1.686125] 21f0000.serial: ttymxc3 at MMIO 0x21f0000 (irq = 82, base_baud = 5000000) is a IMX
[    1.695541] 21f4000.serial: ttymxc4 at MMIO 0x21f4000 (irq = 83, base_baud = 5000000) is a IMX
[    1.711037] loop: module loaded
[    1.714198] Loading iSCSI transport class v2.0-870.
[    1.720904] ahci-imx 2200000.sata: fsl,transmit-level-mV not specified, using 00000024
[    1.728838] ahci-imx 2200000.sata: fsl,transmit-boost-mdB not specified, using 00000480
[    1.736873] ahci-imx 2200000.sata: fsl,transmit-atten-16ths not specified, using 00002000
[    1.745076] ahci-imx 2200000.sata: fsl,receive-eq-mdB not specified, using 05000000
[    1.752856] ahci-imx 2200000.sata: supply ahci not found, using dummy regulator
[    1.760380] ahci-imx 2200000.sata: supply phy not found, using dummy regulator
[    1.767721] ahci-imx 2200000.sata: supply target not found, using dummy regulator
[    1.778076] ahci-imx 2200000.sata: SSS flag set, parallel bus scan disabled
[    1.785108] ahci-imx 2200000.sata: AHCI 0001.0300 32 slots 1 ports 3 Gbps 0x1 impl platform mode
[    1.793935] ahci-imx 2200000.sata: flags: ncq sntf stag pm led clo only pmp pio slum part ccc apst
[    1.804523] scsi host0: ahci-imx
[    1.808138] ata1: SATA max UDMA/133 mmio [mem 0x02200000-0x02203fff] port 0x100 irq 86
[    1.818261] libphy: Fixed MDIO Bus: probed
[    1.836498] pps pps0: new PPS source ptp0
[    1.842688] libphy: fec_enet_mii_bus: probed
[    1.848952] fec 2188000.ethernet eth0: registered PHC device 0
[    1.855343] e1000e: Intel(R) PRO/1000 Network Driver
[    1.860315] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.866373] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.872957] ehci-pci: EHCI PCI platform driver
[    1.877464] ehci-mxc: Freescale On-Chip EHCI Host driver
[    1.886285] rtc-ds1307 0-0068: oscillator failed, set time!
[    1.892036] rtc-ds1307 0-0068: registered as rtc0
[    1.898144] rtc-ds1307 0-0068: hctosys: unable to read the hardware clock
[    1.905241] i2c /dev entries driver
[    1.911218] sdhci: Secure Digital Host Controller Interface driver
[    1.917410] sdhci: Copyright(c) Pierre Ossman
[    1.921792] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.928836] sdhci-esdhc-imx 2194000.mmc: Got CD GPIO
[    1.929555] caam 2100000.crypto: Entropy delay = 3200
[    1.966821] mmc2: SDHCI controller on 2198000.mmc [2198000.mmc] using ADMA
[    1.974375] mmc1: SDHCI controller on 2194000.mmc [2194000.mmc] using ADMA
[    1.999674] caam 2100000.crypto: Instantiated RNG4 SH0
[    2.040446] imx6q-pcie 1ffc000.pcie: Phy link never came up
[    2.049259] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    2.055566] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.060434] caam 2100000.crypto: Instantiated RNG4 SH1
[    2.061088] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    2.066207] caam 2100000.crypto: device ID = 0x0a16010000000000 (Era 4)
[    2.072406] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
[    2.076096] mmc2: new DDR MMC card at address 0001
[    2.077087] mmcblk2: mmc2:0001 BIWIN  7.28 GiB
[    2.077714] mmcblk2boot0: mmc2:0001 BIWIN  partition 1 4.00 MiB
[    2.078331] mmcblk2boot1: mmc2:0001 BIWIN  partition 2 4.00 MiB
[    2.078464] mmcblk2rpmb: mmc2:0001 BIWIN  partition 3 4.00 MiB, chardev (248:0)
[    2.079029] caam 2100000.crypto: job rings = 2, qi = 0
[    2.079769]  mmcblk2: p1 p2
[    2.085973] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    2.098373] caam algorithms registered in /proc/crypto
[    2.101276] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    2.108603] caam 2100000.crypto: registering rng-caam
[    2.114480] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    2.124125] NET: Registered protocol family 10
[    2.128468] pci 0000:00:00.0: Limiting cfg_size to 512
[    2.134736] Segment Routing with IPv6
[    2.139879] pci 0000:00:00.0: imx6_pcie_quirk+0x0/0x84 took 11125 usecs
[    2.142319] ata1: SATA link down (SStatus 0 SControl 300)
[    2.142367] ahci-imx 2200000.sata: no device found, disabling link.
[    2.142376] ahci-imx 2200000.sata: pass ahci_imx..hotplug=1 to enable hotplug
[    2.145016] NET: Registered protocol family 17
[    2.151684] pci 0000:00:00.0: supports D1
[    2.156289] 8021q: 802.1Q VLAN Support v1.8
[    2.161238] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    2.165900] PCI: bus0: Fast back to back transfers disabled
[    2.173156] Registering SWP/SWPB emulation handler
[    2.181426] PCI: bus1: Fast back to back transfers enabled
[    2.185540] Key type ._fscrypt registered
[    2.190445] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
[    2.194840] Key type .fscrypt registered
[    2.198843] pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff pref]
[    2.203025] Key type fscrypt-provisioning registered
[    2.207714] Key type encrypted registered
[    2.209408] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    2.239936] imx_thermal 20c8000.anatop:tempmon: Industrial CPU temperature grade - max:105C critical:100C passive:95C
[    2.240101] pci 0000:00:00.0: Max Payload Size set to  128/ 128 (was  128), Max Read Rq  128
[    2.280656] sysfs: cannot create duplicate filename '/devices/platform/soc/1ffc000.pcie/pci0000:00/0000:00:00.0/config'
[    2.291471] CPU: 1 PID: 46 Comm: kworker/u8:3 Not tainted 5.10.27 #0
[    2.297832] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    2.303545] random: fast init done
[    2.304384] Workqueue: events_unbound async_run_entry_fn
[    2.313090] Backtrace:
[    2.315558] [<8010cc88>] (dump_backtrace) from [<8010d134>] (show_stack+0x20/0x24)
[    2.323136]  r7:813285d4 r6:60000013 r5:00000000 r4:80ec845c
[    2.328815] [<8010d114>] (show_stack) from [<805971fc>] (dump_stack+0xa4/0xb8)
[    2.336058] [<80597158>] (dump_stack) from [<803a7128>] (sysfs_warn_dup+0x68/0x74)
[    2.343636]  r7:813285d4 r6:80af0dfc r5:812fc8f0 r4:81bcb000
[    2.349305] [<803a70c0>] (sysfs_warn_dup) from [<803a6c90>] (sysfs_add_file_mode_ns+0x100/0x1cc)
[    2.358098]  r7:813285d4 r6:812fc8f0 r5:80b4299c r4:ffffffef
[    2.363765] [<803a6b90>] (sysfs_add_file_mode_ns) from [<803a6fe8>] (sysfs_create_bin_file+0x94/0x9c)
[    2.372991]  r6:81e68078 r5:80b4299c r4:00000000
[    2.377626] [<803a6f54>] (sysfs_create_bin_file) from [<805da848>] (pci_create_sysfs_dev_files+0x58/0x2cc)
[    2.387285]  r6:81e68000 r5:81e68078 r4:81e68000
[    2.391923] [<805da7f0>] (pci_create_sysfs_dev_files) from [<805cba98>] (pci_bus_add_device+0x34/0x90)
[    2.401237]  r10:80b45d88 r9:81818810 r8:81328400 r7:813285d4 r6:81bd8000 r5:81e68078
[    2.409071]  r4:81e68000
[    2.411615] [<805cba64>] (pci_bus_add_device) from [<805cbb30>] (pci_bus_add_devices+0x3c/0x80)
[    2.420318]  r5:81bd8014 r4:81e68000
[    2.423905] [<805cbaf4>] (pci_bus_add_devices) from [<805cf898>] (pci_host_probe+0x50/0xa0)
[    2.425126] random: crng init done
[    2.432263]  r7:813285d4 r6:81bd8000 r5:81bd800c r4:00000000
[    2.432279] [<805cf848>] (pci_host_probe) from [<805eeb20>] (dw_pcie_host_init+0x1d0/0x414)
[    2.432294]  r7:813285d4 r6:81328258 r5:00000200 r4:00000000
[    2.455360] [<805ee950>] (dw_pcie_host_init) from [<805ef5a8>] (imx6_pcie_probe+0x38c/0x69c)
[    2.463807]  r10:81226180 r9:ef0205c4 r8:81818800 r7:81328240 r6:81328240 r5:81818810
[    2.471640]  r4:00000020
[    2.474197] [<805ef21c>] (imx6_pcie_probe) from [<8065e858>] (platform_drv_probe+0x58/0xa8)
[    2.482557]  r10:80ec9f78 r9:00000000 r8:80f160a8 r7:00000000 r6:80ec9f78 r5:00000000
[    2.490390]  r4:81818810
[    2.492937] [<8065e800>] (platform_drv_probe) from [<8065c0a0>] (really_probe+0x128/0x534)
[    2.501207]  r7:00000000 r6:80f5b8c4 r5:81818810 r4:80f5b8d4
[    2.506877] [<8065bf78>] (really_probe) from [<8065c700>] (driver_probe_device+0x88/0x200)
[    2.515148]  r10:00000000 r9:80f0bb60 r8:00000000 r7:80f160a8 r6:80ec9f78 r5:80ec9f78
[    2.522981]  r4:81818810
[    2.525526] [<8065c678>] (driver_probe_device) from [<8065c904>] (__driver_attach_async_helper+0x8c/0xb4)
[    2.535100]  r9:80f0bb60 r8:00000000 r7:8104d000 r6:80ec9f78 r5:80f25010 r4:81818810
[    2.542853] [<8065c878>] (__driver_attach_async_helper) from [<8015b930>] (async_run_entry_fn+0x58/0x1bc)
[    2.552425]  r6:81a758c0 r5:80f25010 r4:81a758d0
[    2.557060] [<8015b8d8>] (async_run_entry_fn) from [<8015114c>] (process_one_work+0x238/0x5ac)
[    2.565681]  r8:00000000 r7:8104d000 r6:81048400 r5:8127a080 r4:81a758d0
[    2.572392] [<80150f14>] (process_one_work) from [<8015152c>] (worker_thread+0x6c/0x5c0)
[    2.580493]  r10:81048400 r9:80e03d00 r8:81048418 r7:00000088 r6:81048400 r5:8127a094
[    2.588325]  r4:8127a080
[    2.590874] [<801514c0>] (worker_thread) from [<80158168>] (kthread+0x174/0x178)
[    2.598278]  r10:8127a080 r9:81217fe4 r8:8116fe74 r7:81364000 r6:00000000 r5:8127b040
[    2.606111]  r4:81217fc0
[    2.608654] [<80157ff4>] (kthread) from [<80100148>] (ret_from_fork+0x14/0x2c)
[    2.615881] Exception stack(0x81365fb0 to 0x81365ff8)
[    2.620941] 5fa0:                                     00000000 00000000 00000000 00000000
[    2.629127] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.637311] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.643934]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:80157ff4
[    2.651766]  r4:8127b040
[    2.654741] pcieport 0000:00:00.0: PME: Signaling with IRQ 316
[    2.672706] VFS: Mounted root (squashfs filesystem) readonly on device 179:2.
[    2.684075] Freeing unused kernel memory: 1024K
[    2.710947] Run /sbin/init as init process
[    2.959976] init: Console is alive
[    2.963628] init: - watchdog -
[    3.364282] kmodloader: loading kernel modules from /etc/modules-boot.d/*
[    3.418956] gpio-keys gpio-keys: does not support key code:143
[    3.427977] kmodloader: done loading kernel modules from /etc/modules-boot.d/*
[    3.441567] init: - preinit -
[    4.224669] Micrel KSZ9031 Gigabit PHY 2188000.ethernet-1:07: attached PHY driver [Micrel KSZ9031 Gigabit PHY] (mii_bus:phy_addr=2188000.ethernet-1:07, irq=120)
Press the [f] key and hit [enter] to enter failsafe mode
Press the [1], [2], [3] or [4] key and hit [enter] to select the debug level
[    8.560835] EXT4-fs (loop0): recovery complete
[    8.566782] EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: (null)
[    8.576293] mount_root: switching to ext4 overlay
[    8.824878] EXT4-fs (mmcblk2p1): mounted filesystem without journal. Opts: (null)
[    8.841054] urandom-seed: Seeding with /etc/urandom.seed
[    8.957052] procd: - early -
[    8.960004] procd: - watchdog -
[    9.553020] procd: - watchdog -
[    9.556647] procd: - ubus -
[    9.719723] procd: - init -
Please press Enter to activate this console.
[   10.135757] kmodloader: loading kernel modules from /etc/modules.d/*
[   10.147710] urngd: v1.0.2 started.
[   10.158876] can: controller area network core
[   10.163463] NET: Registered protocol family 29
[   10.169546] CAN device driver interface
[   10.174395] can: raw protocol
[   10.510803] sps30 0-0069: failed to reset device
[   10.518325] usbcore: registered new interface driver usbserial_generic
[   10.524997] usbserial: USB Serial support registered for generic
[   10.537468] xt_time: kernel timezone is -0000
[   10.560920] usbcore: registered new interface driver option
[   10.566594] usbserial: USB Serial support registered for GSM modem (1-port)
[   10.580628] kmodloader: done loading kernel modules from /etc/modules.d/*
[   15.264668] Micrel KSZ9031 Gigabit PHY 2188000.ethernet-1:07: attached PHY driver [Micrel KSZ9031 Gigabit PHY] (mii_bus:phy_addr=2188000.ethernet-1:07, irq=120)
[   15.280953] br-lan: port 1(eth0) entered blocking state
[   15.286194] br-lan: port 1(eth0) entered disabled state
[   15.291801] device eth0 entered promiscuous mode



BusyBox v1.33.0 () built-in shell (ash)

  _______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__| W I R E L E S S   F R E E D O M
 -----------------------------------------------------
 OpenWrt SNAPSHOT, r16433+39-e48c6400e477
 -----------------------------------------------------
=== WARNING! =====================================
There is no root password defined on this device!
Use the "passwd" command to set up a new password
in order to prevent unauthorized SSH logins.
--------------------------------------------------
root@OpenWrt:/# dmesg
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.10.27 (ynezz@ntbk) (arm-openwrt-linux-muslgnueabi-gcc (OpenWrt GCC 8.4.0 r12719+30-84f4a783c698) 8.4.0, GNU ld (GNU Binutils) 2.34) #0 SMP Wed Apr 7 12:52:23 2021
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: Toradex Apalis iMX6Q/D Module on Ixora Carrier Board
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Ignoring RAM at 0x80000000-0x90000000
[    0.000000] Consider using a HIGHMEM enabled kernel.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000010000000-0x000000007fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000010000000-0x000000007fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000010000000-0x000000007fffffff]
[    0.000000] On node 0 totalpages: 458752
[    0.000000]   Normal zone: 4032 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 458752 pages, LIFO batch:63
[    0.000000] percpu: Embedded 19 pages/cpu s47628 r8192 d22004 u77824
[    0.000000] pcpu-alloc: s47628 r8192 d22004 u77824 alloc=19*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 454720
[    0.000000] Kernel command line: earlyprintk console=ttymxc0,115200n8 root=PARTUUID=5452574f-02 rootfstype=squashfs rootwait pci=nomsi
[    0.000000] Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes, linear)
[    0.000000] Inode-cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 1802104K/1835008K available (9040K kernel code, 1170K rwdata, 2328K rodata, 1024K init, 242K bss, 32904K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] ftrace: allocating 31336 entries in 62 pages
[    0.000000] ftrace: allocated 62 pages with 5 groups
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000]  Rude variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] L2C-310 errata 752271 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
[    0.000000] random: get_random_bytes called from start_kernel+0x3e0/0x5a0 with crng_init=0
[    0.000000] Switching to timer-based delay loop, resolution 333ns
[    0.000008] sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 715827882841ns
[    0.000029] clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 637086815595 ns
[    0.001279] Console: colour dummy device 80x30
[    0.001318] Calibrating delay loop (skipped), value calculated using timer frequency.. 6.00 BogoMIPS (lpj=30000)
[    0.001340] pid_max: default: 32768 minimum: 301
[    0.001548] Mount-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
[    0.001588] Mountpoint-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
[    0.002484] CPU: Testing write buffer coherency: ok
[    0.002522] CPU0: Spectre v2: using BPIALL workaround
[    0.002789] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.003686] Setting up static identity map for 0x10100000 - 0x10100060
[    0.003845] rcu: Hierarchical SRCU implementation.
[    0.004844] smp: Bringing up secondary CPUs ...
[    0.005689] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.005698] CPU1: Spectre v2: using BPIALL workaround
[    0.006667] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.006676] CPU2: Spectre v2: using BPIALL workaround
[    0.007606] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.007615] CPU3: Spectre v2: using BPIALL workaround
[    0.007755] smp: Brought up 1 node, 4 CPUs
[    0.007770] SMP: Total of 4 processors activated (24.00 BogoMIPS).
[    0.007780] CPU: All CPU(s) started in SVC mode.
[    0.017479] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.017696] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.017731] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.017995] pinctrl core: initialized pinctrl subsystem
[    0.019710] NET: Registered protocol family 16
[    0.021665] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.023180] thermal_sys: Registered thermal governor 'step_wise'
[    0.023660] CPU identified as i.MX6Q, silicon rev 1.5
[    0.245571] vdd1p1: supplied by regulator-dummy
[    0.254210] vdd3p0: supplied by regulator-dummy
[    0.262785] vdd2p5: supplied by regulator-dummy
[    0.271321] vddarm: supplied by regulator-dummy
[    0.279909] vddpu: supplied by regulator-dummy
[    0.288419] vddsoc: supplied by regulator-dummy
[    0.628532] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    0.628554] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.628861] debugfs: Directory 'dummy-iomuxc-gpr@20e0000' with parent 'regmap' already present!
[    0.629263] imx6q-pinctrl 20e0000.pinctrl: initialized IMX pinctrl driver
[    0.647595] Kprobes globally optimized
[    0.650233] cryptd: max_cpu_qlen set to 1000
[    0.666849] mxs-dma 110000.dma-apbh: initialized
[    0.669973] usb_host_vbus: supplied by usb_host_vbus_hub
[    0.670896] SCSI subsystem initialized
[    0.671303] libata version 3.00 loaded.
[    0.671797] usbcore: registered new interface driver usbfs
[    0.671910] usbcore: registered new interface driver hub
[    0.671999] usbcore: registered new device driver usb
[    0.674185] i2c i2c-0: IMX I2C adapter registered
[    0.676657] i2c i2c-2: IMX I2C adapter registered
[    0.677730] i2c i2c-1: IMX I2C adapter registered
[    0.678202] pps_core: LinuxPPS API ver. 1 registered
[    0.678217] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.678258] PTP clock support registered
[    0.680434] clocksource: Switched to clocksource mxc_timer1
[    0.800167] NET: Registered protocol family 2
[    0.801060] tcp_listen_portaddr_hash hash table entries: 1024 (order: 1, 12288 bytes, linear)
[    0.801141] TCP established hash table entries: 16384 (order: 4, 65536 bytes, linear)
[    0.801432] TCP bind hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.802002] TCP: Hash tables configured (established 16384 bind 16384)
[    0.802377] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.802490] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.802831] NET: Registered protocol family 1
[    0.802876] PCI: CLS 0 bytes, default 64
[    0.803583] hw perfevents: no interrupt-affinity property for /pmu, guessing.
[    0.803842] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available
[    0.809163] workingset: timestamp_bits=14 max_order=19 bucket_order=5
[    0.813910] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.926864] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.929303] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:
[    0.929370] imx6q-pcie 1ffc000.pcie:       IO 0x0001f80000..0x0001f8ffff -> 0x0000000000
[    0.929411] imx6q-pcie 1ffc000.pcie:      MEM 0x0001000000..0x0001efffff -> 0x0001000000
[    0.936834] imx-sdma 20ec000.sdma: loaded firmware 3.5
[    0.938840] pfuze100-regulator 2-0008: Full layer: 1, Metal layer: 1
[    0.939545] pfuze100-regulator 2-0008: FAB: 0, FIN: 0
[    0.939560] pfuze100-regulator 2-0008: pfuze100 found.
[    0.956572] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    0.957946] 2020000.serial: ttymxc0 at MMIO 0x2020000 (irq = 34, base_baud = 5000000) is a IMX
[    1.670939] printk: console [ttymxc0] enabled
[    1.676645] 21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq = 81, base_baud = 5000000) is a IMX
[    1.686125] 21f0000.serial: ttymxc3 at MMIO 0x21f0000 (irq = 82, base_baud = 5000000) is a IMX
[    1.695541] 21f4000.serial: ttymxc4 at MMIO 0x21f4000 (irq = 83, base_baud = 5000000) is a IMX
[    1.711037] loop: module loaded
[    1.714198] Loading iSCSI transport class v2.0-870.
[    1.720904] ahci-imx 2200000.sata: fsl,transmit-level-mV not specified, using 00000024
[    1.728838] ahci-imx 2200000.sata: fsl,transmit-boost-mdB not specified, using 00000480
[    1.736873] ahci-imx 2200000.sata: fsl,transmit-atten-16ths not specified, using 00002000
[    1.745076] ahci-imx 2200000.sata: fsl,receive-eq-mdB not specified, using 05000000
[    1.752856] ahci-imx 2200000.sata: supply ahci not found, using dummy regulator
[    1.760380] ahci-imx 2200000.sata: supply phy not found, using dummy regulator
[    1.767721] ahci-imx 2200000.sata: supply target not found, using dummy regulator
[    1.778076] ahci-imx 2200000.sata: SSS flag set, parallel bus scan disabled
[    1.785108] ahci-imx 2200000.sata: AHCI 0001.0300 32 slots 1 ports 3 Gbps 0x1 impl platform mode
[    1.793935] ahci-imx 2200000.sata: flags: ncq sntf stag pm led clo only pmp pio slum part ccc apst
[    1.804523] scsi host0: ahci-imx
[    1.808138] ata1: SATA max UDMA/133 mmio [mem 0x02200000-0x02203fff] port 0x100 irq 86
[    1.818261] libphy: Fixed MDIO Bus: probed
[    1.836498] pps pps0: new PPS source ptp0
[    1.842688] libphy: fec_enet_mii_bus: probed
[    1.848952] fec 2188000.ethernet eth0: registered PHC device 0
[    1.855343] e1000e: Intel(R) PRO/1000 Network Driver
[    1.860315] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.866373] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.872957] ehci-pci: EHCI PCI platform driver
[    1.877464] ehci-mxc: Freescale On-Chip EHCI Host driver
[    1.886285] rtc-ds1307 0-0068: oscillator failed, set time!
[    1.892036] rtc-ds1307 0-0068: registered as rtc0
[    1.898144] rtc-ds1307 0-0068: hctosys: unable to read the hardware clock
[    1.905241] i2c /dev entries driver
[    1.911218] sdhci: Secure Digital Host Controller Interface driver
[    1.917410] sdhci: Copyright(c) Pierre Ossman
[    1.921792] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.928836] sdhci-esdhc-imx 2194000.mmc: Got CD GPIO
[    1.929555] caam 2100000.crypto: Entropy delay = 3200
[    1.966821] mmc2: SDHCI controller on 2198000.mmc [2198000.mmc] using ADMA
[    1.974375] mmc1: SDHCI controller on 2194000.mmc [2194000.mmc] using ADMA
[    1.999674] caam 2100000.crypto: Instantiated RNG4 SH0
[    2.040446] imx6q-pcie 1ffc000.pcie: Phy link never came up
[    2.049259] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    2.055566] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.060434] caam 2100000.crypto: Instantiated RNG4 SH1
[    2.061088] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    2.066207] caam 2100000.crypto: device ID = 0x0a16010000000000 (Era 4)
[    2.072406] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
[    2.076096] mmc2: new DDR MMC card at address 0001
[    2.077087] mmcblk2: mmc2:0001 BIWIN  7.28 GiB
[    2.077714] mmcblk2boot0: mmc2:0001 BIWIN  partition 1 4.00 MiB
[    2.078331] mmcblk2boot1: mmc2:0001 BIWIN  partition 2 4.00 MiB
[    2.078464] mmcblk2rpmb: mmc2:0001 BIWIN  partition 3 4.00 MiB, chardev (248:0)
[    2.079029] caam 2100000.crypto: job rings = 2, qi = 0
[    2.079769]  mmcblk2: p1 p2
[    2.085973] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    2.098373] caam algorithms registered in /proc/crypto
[    2.101276] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    2.108603] caam 2100000.crypto: registering rng-caam
[    2.114480] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    2.124125] NET: Registered protocol family 10
[    2.128468] pci 0000:00:00.0: Limiting cfg_size to 512
[    2.134736] Segment Routing with IPv6
[    2.139879] pci 0000:00:00.0: imx6_pcie_quirk+0x0/0x84 took 11125 usecs
[    2.142319] ata1: SATA link down (SStatus 0 SControl 300)
[    2.142367] ahci-imx 2200000.sata: no device found, disabling link.
[    2.142376] ahci-imx 2200000.sata: pass ahci_imx..hotplug=1 to enable hotplug
[    2.145016] NET: Registered protocol family 17
[    2.151684] pci 0000:00:00.0: supports D1
[    2.156289] 8021q: 802.1Q VLAN Support v1.8
[    2.161238] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    2.165900] PCI: bus0: Fast back to back transfers disabled
[    2.173156] Registering SWP/SWPB emulation handler
[    2.181426] PCI: bus1: Fast back to back transfers enabled
[    2.185540] Key type ._fscrypt registered
[    2.190445] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
[    2.194840] Key type .fscrypt registered
[    2.198843] pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff pref]
[    2.203025] Key type fscrypt-provisioning registered
[    2.207714] Key type encrypted registered
[    2.209408] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    2.239936] imx_thermal 20c8000.anatop:tempmon: Industrial CPU temperature grade - max:105C critical:100C passive:95C
[    2.240101] pci 0000:00:00.0: Max Payload Size set to  128/ 128 (was  128), Max Read Rq  128
[    2.280656] sysfs: cannot create duplicate filename '/devices/platform/soc/1ffc000.pcie/pci0000:00/0000:00:00.0/config'
[    2.291471] CPU: 1 PID: 46 Comm: kworker/u8:3 Not tainted 5.10.27 #0
[    2.297832] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    2.303545] random: fast init done
[    2.304384] Workqueue: events_unbound async_run_entry_fn
[    2.313090] Backtrace:
[    2.315558] [<8010cc88>] (dump_backtrace) from [<8010d134>] (show_stack+0x20/0x24)
[    2.323136]  r7:813285d4 r6:60000013 r5:00000000 r4:80ec845c
[    2.328815] [<8010d114>] (show_stack) from [<805971fc>] (dump_stack+0xa4/0xb8)
[    2.336058] [<80597158>] (dump_stack) from [<803a7128>] (sysfs_warn_dup+0x68/0x74)
[    2.343636]  r7:813285d4 r6:80af0dfc r5:812fc8f0 r4:81bcb000
[    2.349305] [<803a70c0>] (sysfs_warn_dup) from [<803a6c90>] (sysfs_add_file_mode_ns+0x100/0x1cc)
[    2.358098]  r7:813285d4 r6:812fc8f0 r5:80b4299c r4:ffffffef
[    2.363765] [<803a6b90>] (sysfs_add_file_mode_ns) from [<803a6fe8>] (sysfs_create_bin_file+0x94/0x9c)
[    2.372991]  r6:81e68078 r5:80b4299c r4:00000000
[    2.377626] [<803a6f54>] (sysfs_create_bin_file) from [<805da848>] (pci_create_sysfs_dev_files+0x58/0x2cc)
[    2.387285]  r6:81e68000 r5:81e68078 r4:81e68000
[    2.391923] [<805da7f0>] (pci_create_sysfs_dev_files) from [<805cba98>] (pci_bus_add_device+0x34/0x90)
[    2.401237]  r10:80b45d88 r9:81818810 r8:81328400 r7:813285d4 r6:81bd8000 r5:81e68078
[    2.409071]  r4:81e68000
[    2.411615] [<805cba64>] (pci_bus_add_device) from [<805cbb30>] (pci_bus_add_devices+0x3c/0x80)
[    2.420318]  r5:81bd8014 r4:81e68000
[    2.423905] [<805cbaf4>] (pci_bus_add_devices) from [<805cf898>] (pci_host_probe+0x50/0xa0)
[    2.425126] random: crng init done
[    2.432263]  r7:813285d4 r6:81bd8000 r5:81bd800c r4:00000000
[    2.432279] [<805cf848>] (pci_host_probe) from [<805eeb20>] (dw_pcie_host_init+0x1d0/0x414)
[    2.432294]  r7:813285d4 r6:81328258 r5:00000200 r4:00000000
[    2.455360] [<805ee950>] (dw_pcie_host_init) from [<805ef5a8>] (imx6_pcie_probe+0x38c/0x69c)
[    2.463807]  r10:81226180 r9:ef0205c4 r8:81818800 r7:81328240 r6:81328240 r5:81818810
[    2.471640]  r4:00000020
[    2.474197] [<805ef21c>] (imx6_pcie_probe) from [<8065e858>] (platform_drv_probe+0x58/0xa8)
[    2.482557]  r10:80ec9f78 r9:00000000 r8:80f160a8 r7:00000000 r6:80ec9f78 r5:00000000
[    2.490390]  r4:81818810
[    2.492937] [<8065e800>] (platform_drv_probe) from [<8065c0a0>] (really_probe+0x128/0x534)
[    2.501207]  r7:00000000 r6:80f5b8c4 r5:81818810 r4:80f5b8d4
[    2.506877] [<8065bf78>] (really_probe) from [<8065c700>] (driver_probe_device+0x88/0x200)
[    2.515148]  r10:00000000 r9:80f0bb60 r8:00000000 r7:80f160a8 r6:80ec9f78 r5:80ec9f78
[    2.522981]  r4:81818810
[    2.525526] [<8065c678>] (driver_probe_device) from [<8065c904>] (__driver_attach_async_helper+0x8c/0xb4)
[    2.535100]  r9:80f0bb60 r8:00000000 r7:8104d000 r6:80ec9f78 r5:80f25010 r4:81818810
[    2.542853] [<8065c878>] (__driver_attach_async_helper) from [<8015b930>] (async_run_entry_fn+0x58/0x1bc)
[    2.552425]  r6:81a758c0 r5:80f25010 r4:81a758d0
[    2.557060] [<8015b8d8>] (async_run_entry_fn) from [<8015114c>] (process_one_work+0x238/0x5ac)
[    2.565681]  r8:00000000 r7:8104d000 r6:81048400 r5:8127a080 r4:81a758d0
[    2.572392] [<80150f14>] (process_one_work) from [<8015152c>] (worker_thread+0x6c/0x5c0)
[    2.580493]  r10:81048400 r9:80e03d00 r8:81048418 r7:00000088 r6:81048400 r5:8127a094
[    2.588325]  r4:8127a080
[    2.590874] [<801514c0>] (worker_thread) from [<80158168>] (kthread+0x174/0x178)
[    2.598278]  r10:8127a080 r9:81217fe4 r8:8116fe74 r7:81364000 r6:00000000 r5:8127b040
[    2.606111]  r4:81217fc0
[    2.608654] [<80157ff4>] (kthread) from [<80100148>] (ret_from_fork+0x14/0x2c)
[    2.615881] Exception stack(0x81365fb0 to 0x81365ff8)
[    2.620941] 5fa0:                                     00000000 00000000 00000000 00000000
[    2.629127] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.637311] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.643934]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:80157ff4
[    2.651766]  r4:8127b040
[    2.654741] pcieport 0000:00:00.0: PME: Signaling with IRQ 316
[    2.672706] VFS: Mounted root (squashfs filesystem) readonly on device 179:2.
[    2.684075] Freeing unused kernel memory: 1024K
[    2.710947] Run /sbin/init as init process
[    2.715058]   with arguments:
[    2.715065]     /sbin/init
[    2.715073]     earlyprintk
[    2.715079]   with environment:
[    2.715086]     HOME=/
[    2.715092]     TERM=linux
[    2.959976] init: Console is alive
[    2.963628] init: - watchdog -
[    3.364282] kmodloader: loading kernel modules from /etc/modules-boot.d/*
[    3.418956] gpio-keys gpio-keys: does not support key code:143
[    3.427977] kmodloader: done loading kernel modules from /etc/modules-boot.d/*
[    3.441567] init: - preinit -
[    4.224669] Micrel KSZ9031 Gigabit PHY 2188000.ethernet-1:07: attached PHY driver [Micrel KSZ9031 Gigabit PHY] (mii_bus:phy_addr=2188000.ethernet-1:07, irq=120)
[    8.560835] EXT4-fs (loop0): recovery complete
[    8.566782] EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: (null)
[    8.576293] mount_root: switching to ext4 overlay
[    8.824878] EXT4-fs (mmcblk2p1): mounted filesystem without journal. Opts: (null)
[    8.841054] urandom-seed: Seeding with /etc/urandom.seed
[    8.957052] procd: - early -
[    8.960004] procd: - watchdog -
[    9.553020] procd: - watchdog -
[    9.556647] procd: - ubus -
[    9.719723] procd: - init -
[   10.135757] kmodloader: loading kernel modules from /etc/modules.d/*
[   10.147710] urngd: v1.0.2 started.
[   10.158876] can: controller area network core
[   10.163463] NET: Registered protocol family 29
[   10.169546] CAN device driver interface
[   10.174395] can: raw protocol
[   10.510803] sps30 0-0069: failed to reset device
[   10.518325] usbcore: registered new interface driver usbserial_generic
[   10.524997] usbserial: USB Serial support registered for generic
[   10.537468] xt_time: kernel timezone is -0000
[   10.560920] usbcore: registered new interface driver option
[   10.566594] usbserial: USB Serial support registered for GSM modem (1-port)
[   10.580628] kmodloader: done loading kernel modules from /etc/modules.d/*
[   15.264668] Micrel KSZ9031 Gigabit PHY 2188000.ethernet-1:07: attached PHY driver [Micrel KSZ9031 Gigabit PHY] (mii_bus:phy_addr=2188000.ethernet-1:07, irq=120)
[   15.280953] br-lan: port 1(eth0) entered blocking state
[   15.286194] br-lan: port 1(eth0) entered disabled state
[   15.291801] device eth0 entered promiscuous mode

Cheers,

Petr
