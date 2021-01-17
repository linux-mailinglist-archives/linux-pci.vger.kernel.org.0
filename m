Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0ED82F960B
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jan 2021 00:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbhAQXCg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Jan 2021 18:02:36 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:50683 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbhAQXCf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Jan 2021 18:02:35 -0500
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 26E5722EDB;
        Mon, 18 Jan 2021 00:01:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1610924510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cr1gOo2EpkIs/H1zjH6sc0NG6Iw4LQkC6LCP8M86d/g=;
        b=jrP/iwje4JsHAXn8FArFbiKSEmyyAK5jEiL6FbCXoRBukWT746POgqYCfFEXuCmERAcjbF
        8XPiIfU9wr1/4/M5WWi1QGnuFnys/9vMg3U6R8FIczHJIGCvxuo328DorGYu0zClVQHpKQ
        IPve4ztJUysRl9o/HixUc/mIdiu44d8=
From:   Michael Walle <michael@walle.cc>
To:     saravanak@google.com
Cc:     Jisheng.Zhang@synaptics.com, gregkh@linuxfoundation.org,
        john.stultz@linaro.org, kernel-team@android.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org, maz@kernel.org,
        nsaenzjulienne@suse.de, rafael@kernel.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, linux-pci@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v1 5/5] driver core: Set fw_devlink=on by default
Date:   Mon, 18 Jan 2021 00:01:34 +0100
Message-Id: <20210117230134.32042-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201218031703.3053753-6-saravanak@google.com>
References: <20201218031703.3053753-6-saravanak@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Saravana, again ;)

> Cyclic dependencies in some firmware was one of the last remaining
> reasons fw_devlink=on couldn't be set by default. Now that cyclic
> dependencies don't block probing, set fw_devlink=on by default.
> 
> Setting fw_devlink=on by default brings a bunch of benefits (currently,
> only for systems with device tree firmware):
> * Significantly cuts down deferred probes.
> * Device probe is effectively attempted in graph order.
> * Makes it much easier to load drivers as modules without having to
>   worry about functional dependencies between modules (depmod is still
>   needed for symbol dependencies).
> 
> If this patch prevents some devices from probing, it's very likely due
> to the system having one or more device drivers that "probe"/set up a
> device (DT node with compatible property) without creating a struct
> device for it.  If we hit such cases, the device drivers need to be
> fixed so that they populate struct devices and probe them like normal
> device drivers so that the driver core is aware of the devices and their
> status. See [1] for an example of such a case.
> 
> [1] - https://lore.kernel.org/lkml/CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com/
> Signed-off-by: Saravana Kannan <saravanak@google.com>

This breaks (at least) probing of the PCIe controllers of my board. The
driver in question is
  drivers/pci/controller/dwc/pci-layerscape.c
I've also put the maintainers of this driver on CC. Looks like it uses a
proper struct device. But it uses builtin_platform_driver_probe() and
apparently it waits for the iommu which uses module_platform_driver().
Dunno if that will work together.

The board device tree can be found here:
  arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts

Attached is the log with enabled "probe deferral" messages enabled.

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
[    0.000000] Linux version 5.11.0-rc3-next-20210115-00013-g43ea1c90dcc8-dirty (mwalle@mwalle01) (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #357 SMP PREEMPT Sun Jan 17 23:46:11 CET 2021
[    0.000000] Machine model: Kontron SMARC-sAL28 (Single PHY) on SMARC Eval 2.0 carrier
[    0.000000] efi: UEFI not found.
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000080000000-0x00000020ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x20ff7d9200-0x20ff7dafff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000020ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   node   0: [mem 0x0000002080000000-0x00000020ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000020ffffffff]
[    0.000000] On node 0 totalpages: 1048576
[    0.000000]   DMA zone: 8192 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 524288 pages, LIFO batch:63
[    0.000000]   Normal zone: 8192 pages used for memmap
[    0.000000]   Normal zone: 524288 pages, LIFO batch:63
[    0.000000] cma: Reserved 32 MiB at 0x00000000fcc00000
[    0.000000] percpu: Embedded 31 pages/cpu s89752 r8192 d29032 u126976
[    0.000000] pcpu-alloc: s89752 r8192 d29032 u126976 alloc=31*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Spectre-v3a
[    0.000000] CPU features: detected: Spectre-v2
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] CPU features: detected: ARM errata 1165522, 1319367, or 1530923
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1032192
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: debug root=/dev/mmcblk0p2 rootwait
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x00000000f8c00000-0x00000000fcc00000] (64MB)
[    0.000000] Memory: 3987204K/4194304K available (14592K kernel code, 2024K rwdata, 5776K rodata, 4736K init, 848K bss, 174332K reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] ftrace: allocating 51093 entries in 200 pages
[    0.000000] ftrace: allocated 200 pages with 3 groups
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=2.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] 	Rude variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 256 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: 16 PPIs implemented
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000006040000
[    0.000000] ITS [mem 0x06020000-0x0603ffff]
[    0.000000] ITS@0x0000000006020000: allocated 65536 Devices @2080180000 (flat, esz 8, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] GICv3: using LPI property table @0x0000002080200000
[    0.000000] GIC: using cache flushing for LPI property table
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000002080210000
[    0.000000] random: get_random_bytes called from start_kernel+0x668/0x830 with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 25.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x5c40939b5, max_idle_ns: 440795202646 ns
[    0.000000] sched_clock: 56 bits at 25MHz, resolution 40ns, wraps every 4398046511100ns
[    0.000120] Console: colour dummy device 80x25
[    0.000389] printk: console [tty0] enabled
[    0.000439] Calibrating delay loop (skipped), value calculated using timer frequency.. 50.00 BogoMIPS (lpj=100000)
[    0.000454] pid_max: default: 32768 minimum: 301
[    0.000500] LSM: Security Framework initializing
[    0.000553] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.000587] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.001510] rcu: Hierarchical SRCU implementation.
[    0.001667] Platform MSI: gic-its@6020000 domain created
[    0.001745] PCI/MSI: /interrupt-controller@6000000/gic-its@6020000 domain created
[    0.001980] EFI services will not be available.
[    0.002073] smp: Bringing up secondary CPUs ...
[    0.002344] Detected PIPT I-cache on CPU1
[    0.002365] GICv3: CPU1: found redistributor 1 region 0:0x0000000006060000
[    0.002375] GICv3: CPU1: using allocated LPI pending table @0x0000002080220000
[    0.002405] CPU1: Booted secondary processor 0x0000000001 [0x410fd083]
[    0.002471] smp: Brought up 1 node, 2 CPUs
[    0.002499] SMP: Total of 2 processors activated.
[    0.002507] CPU features: detected: 32-bit EL0 Support
[    0.002515] CPU features: detected: CRC32 instructions
[    0.002524] CPU features: detected: 32-bit EL1 Support
[    0.011735] CPU: All CPU(s) started at EL2
[    0.011761] alternatives: patching kernel code
[    0.012508] devtmpfs: initialized
[    0.014832] KASLR disabled due to lack of seed
[    0.020761] DMA-API: preallocated 65536 debug entries
[    0.020786] DMA-API: debugging enabled by kernel config
[    0.020795] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.020815] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    0.021457] pinctrl core: initialized pinctrl subsystem

[    0.021715] *************************************************************
[    0.021722] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.021729] **                                                         **
[    0.021736] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **
[    0.021742] **                                                         **
[    0.021749] ** This means that this kernel is built to expose internal **
[    0.021756] ** IOMMU data structures, which may compromise security on **
[    0.021762] ** your system.                                            **
[    0.021769] **                                                         **
[    0.021776] ** If you see this message and you are not debugging the   **
[    0.021782] ** kernel, report this immediately to your vendor!         **
[    0.021789] **                                                         **
[    0.021795] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.021802] *************************************************************
[    0.021884] DMI not present or invalid.
[    0.022167] NET: Registered protocol family 16
[    0.023001] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
[    0.023114] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.023286] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.023317] audit: initializing netlink subsys (disabled)
[    0.023434] audit: type=2000 audit(0.020:1): state=initialized audit_enabled=0 res=1
[    0.023717] thermal_sys: Registered thermal governor 'step_wise'
[    0.023953] cpuidle: using governor menu
[    0.024076] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.024112] ASID allocator initialised with 65536 entries
[    0.024394] Serial: AMBA PL011 UART driver
[    0.026053] Machine: Kontron SMARC-sAL28 (Single PHY) on SMARC Eval 2.0 carrier
[    0.026065] SoC family: QorIQ LS1028A
[    0.026071] SoC ID: svr:0x870b0110, Revision: 1.0
[    0.038310] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.038332] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.038342] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.038351] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    0.039157] cryptd: max_cpu_qlen set to 1000
[    0.040473] ACPI: Interpreter disabled.
[    0.040536] platform 22c0000.dma-controller: probe deferral - supplier 5000000.iommu not ready
[    0.040768] iommu: Default domain type: Translated 
[    0.040845] vgaarb: loaded
[    0.041009] SCSI subsystem initialized
[    0.041097] libata version 3.00 loaded.
[    0.041222] usbcore: registered new interface driver usbfs
[    0.041248] usbcore: registered new interface driver hub
[    0.041273] usbcore: registered new device driver usb
[    0.041554] imx-i2c 2000000.i2c: can't get pinctrl, bus recovery not supported
[    0.041843] i2c i2c-0: IMX I2C adapter registered
[    0.042000] imx-i2c 2030000.i2c: can't get pinctrl, bus recovery not supported
[    0.042104] i2c i2c-1: IMX I2C adapter registered
[    0.042208] imx-i2c 2040000.i2c: can't get pinctrl, bus recovery not supported
[    0.042391] i2c i2c-2: IMX I2C adapter registered
[    0.042516] mc: Linux media interface: v0.10
[    0.042539] videodev: Linux video capture interface: v2.00
[    0.042566] pps_core: LinuxPPS API ver. 1 registered
[    0.042573] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.042588] PTP clock support registered
[    0.042664] EDAC MC: Ver: 3.0.0
[    0.043046] FPGA manager framework
[    0.043090] Advanced Linux Sound Architecture Driver Initialized.
[    0.043543] clocksource: Switched to clocksource arch_sys_counter
[    0.066221] VFS: Disk quotas dquot_6.6.0
[    0.066273] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.066402] pnp: PnP ACPI: disabled
[    0.074668] NET: Registered protocol family 2
[    0.074996] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.075026] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.075122] TCP bind hash table entries: 32768 (order: 7, 524288 bytes, linear)
[    0.075454] TCP: Hash tables configured (established 32768 bind 32768)
[    0.075571] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.075604] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.075708] NET: Registered protocol family 1
[    0.076019] RPC: Registered named UNIX socket transport module.
[    0.076031] RPC: Registered udp transport module.
[    0.076038] RPC: Registered tcp transport module.
[    0.076045] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.076055] PCI: CLS 0 bytes, default 64
[    0.076425] hw perfevents: enabled with armv8_cortex_a72 PMU driver, 7 counters available
[    0.076625] kvm [1]: IPA Size Limit: 44 bits
[    0.077159] kvm [1]: GICv3: no GICV resource entry
[    0.077170] kvm [1]: disabling GICv2 emulation
[    0.077189] kvm [1]: GIC system register CPU interface enabled
[    0.077228] kvm [1]: vgic interrupt IRQ9
[    0.077288] kvm [1]: Hyp mode initialized successfully
[    0.088537] Initialise system trusted keyrings
[    0.088653] workingset: timestamp_bits=44 max_order=20 bucket_order=0
[    0.092096] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.092507] NFS: Registering the id_resolver key type
[    0.092532] Key type id_resolver registered
[    0.092540] Key type id_legacy registered
[    0.092590] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.092691] 9p: Installing v9fs 9p2000 file system support
[    0.123462] Key type asymmetric registered
[    0.123473] Asymmetric key parser 'x509' registered
[    0.123499] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    0.123510] io scheduler mq-deadline registered
[    0.123517] io scheduler kyber registered
[    0.124604] platform 1f0000000.pcie: probe deferral - supplier 5000000.iommu not ready
[    0.124746] platform 3400000.pcie: probe deferral - supplier 5000000.iommu not ready
[    0.124761] platform 3500000.pcie: probe deferral - supplier 5000000.iommu not ready
[    0.125145] EINJ: ACPI disabled.
[    0.128791] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.129769] 21c0500.serial: ttyS0 at MMIO 0x21c0500 (irq = 24, base_baud = 12500000) is a 16550A
[    1.276625] printk: console [ttyS0] enabled
[    1.281262] 21c0600.serial: ttyS1 at MMIO 0x21c0600 (irq = 24, base_baud = 12500000) is a 16550A
[    1.290396] platform 2270000.serial: probe deferral - supplier 22c0000.dma-controller not ready
[    1.299780] arm-smmu 5000000.iommu: probing hardware configuration...
[    1.306253] arm-smmu 5000000.iommu: SMMUv2 with:
[    1.310895] arm-smmu 5000000.iommu: 	stage 1 translation
[    1.316232] arm-smmu 5000000.iommu: 	stage 2 translation
[    1.321566] arm-smmu 5000000.iommu: 	nested translation
[    1.326815] arm-smmu 5000000.iommu: 	stream matching with 128 register groups
[    1.333984] arm-smmu 5000000.iommu: 	64 context banks (0 stage-2 only)
[    1.340542] arm-smmu 5000000.iommu: 	Supported page sizes: 0x61311000
[    1.347011] arm-smmu 5000000.iommu: 	Stage-1: 48-bit VA -> 48-bit IPA
[    1.353481] arm-smmu 5000000.iommu: 	Stage-2: 48-bit IPA -> 48-bit PA
[    1.364504] loop: module loaded
[    1.367804] at24 0-0050: supply vcc not found, using dummy regulator
[    1.375049] at24 0-0050: 4096 byte 24c32 EEPROM, writable, 32 bytes/write
[    1.381959] at24 1-0057: supply vcc not found, using dummy regulator
[    1.389165] at24 1-0057: 8192 byte 24c64 EEPROM, writable, 32 bytes/write
[    1.396063] at24 2-0050: supply vcc not found, using dummy regulator
[    1.403265] at24 2-0050: 4096 byte 24c32 EEPROM, writable, 32 bytes/write
[    1.424830] platform 2120000.spi: probe deferral - supplier 22c0000.dma-controller not ready
[    1.433801] spi-nor spi0.0: w25q32dw (4096 Kbytes)
[    1.438888] 8 fixed-partitions partitions found on MTD device 20c0000.spi
[    1.445729] Creating 8 MTD partitions on "20c0000.spi":
[    1.450984] 0x000000000000-0x000000010000 : "rcw"
[    1.459943] 0x000000010000-0x000000100000 : "failsafe bootloader"
[    1.467909] 0x000000100000-0x000000140000 : "failsafe DP firmware"
[    1.475904] 0x000000140000-0x0000001e0000 : "failsafe trusted firmware"
[    1.483901] 0x0000001e0000-0x000000200000 : "reserved"
[    1.491903] 0x000000200000-0x000000210000 : "configuration store"
[    1.499897] 0x000000210000-0x0000003e0000 : "bootloader"
[    1.507909] 0x0000003e0000-0x000000400000 : "bootloader environment"
[    1.516489] libphy: Fixed MDIO Bus: probed
[    1.521010] tun: Universal TUN/TAP device driver, 1.6
[    1.526180] CAN device driver interface
[    1.530778] thunder_xcv, ver 1.0
[    1.534051] thunder_bgx, ver 1.0
[    1.537311] nicpf, ver 1.0
[    1.540304] hclge is initializing
[    1.543646] hns3: Hisilicon Ethernet Network Driver for Hip08 Family - version
[    1.550901] hns3: Copyright (c) 2017 Huawei Corporation.
[    1.556270] igb: Intel(R) Gigabit Ethernet Network Driver
[    1.561694] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.567359] sky2: driver version 1.30
[    1.571307] VFIO - User Level meta-driver version: 0.3
[    1.576745] dwc3 3100000.usb: Adding to iommu group 0
[    1.582262] dwc3 3110000.usb: Adding to iommu group 1
[    1.588251] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.594825] ehci-pci: EHCI PCI platform driver
[    1.599307] ehci-platform: EHCI generic platform driver
[    1.604627] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.610844] ohci-pci: OHCI PCI platform driver
[    1.615324] ohci-platform: OHCI generic platform driver
[    1.620846] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    1.626370] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
[    1.634228] xhci-hcd xhci-hcd.0.auto: hcc params 0x0220f66d hci version 0x100 quirks 0x0000000002010010
[    1.643698] xhci-hcd xhci-hcd.0.auto: irq 29, io mem 0x03100000
[    1.650061] hub 1-0:1.0: USB hub found
[    1.653850] hub 1-0:1.0: 1 port detected
[    1.657959] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    1.663477] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 2
[    1.671174] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
[    1.677758] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.686134] hub 2-0:1.0: USB hub found
[    1.689917] hub 2-0:1.0: 1 port detected
[    1.694085] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    1.699607] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 3
[    1.707473] xhci-hcd xhci-hcd.1.auto: hcc params 0x0220f66d hci version 0x100 quirks 0x0000000002010010
[    1.716936] xhci-hcd xhci-hcd.1.auto: irq 30, io mem 0x03110000
[    1.723244] hub 3-0:1.0: USB hub found
[    1.727026] hub 3-0:1.0: 1 port detected
[    1.731114] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    1.736633] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 4
[    1.744329] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
[    1.750919] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.759300] hub 4-0:1.0: USB hub found
[    1.763090] hub 4-0:1.0: 1 port detected
[    1.767271] usbcore: registered new interface driver usb-storage
[    1.774135] udc-core: couldn't find an available UDC - added [g_ether] to list of pending drivers
[    1.783054] udc-core: couldn't find an available UDC - added [g_mass_storage] to list of pending drivers
[    1.792577] udc-core: couldn't find an available UDC - added [g_serial] to list of pending drivers
[    1.801840] input: buttons1 as /devices/platform/buttons1/input/input0
[    1.809670] ftm-alarm 2800000.timer: registered as rtc1
[    1.815661] rtc-rv8803 0-0032: Voltage low, temperature compensation stopped.
[    1.822837] rtc-rv8803 0-0032: Voltage low, data loss detected.
[    1.829877] rtc-rv8803 0-0032: Voltage low, data is invalid.
[    1.835639] rtc-rv8803 0-0032: registered as rtc0
[    1.840966] rtc-rv8803 0-0032: Voltage low, data is invalid.
[    1.846654] rtc-rv8803 0-0032: hctosys: unable to read the hardware clock
[    1.853617] i2c /dev entries driver
[    1.868940] sp805-wdt c000000.watchdog: registration successful
[    1.875000] sp805-wdt c010000.watchdog: registration successful
[    1.882900] sl28cpld-wdt 2000000.i2c:sl28cpld@4a:watchdog@4: initial timeout 6 sec
[    1.890998] qoriq-cpufreq qoriq-cpufreq: Freescale QorIQ CPU frequency scaling driver
[    1.899245] sdhci: Secure Digital Host Controller Interface driver
[    1.905461] sdhci: Copyright(c) Pierre Ossman
[    1.909933] Synopsys Designware Multimedia Card Interface Driver
[    1.916222] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.922189] sdhci-esdhc 2140000.mmc: Adding to iommu group 2
[    1.927922] sdhci-esdhc 2150000.mmc: Adding to iommu group 3
[    1.933859] ledtrig-cpu: registered to indicate activity on CPUs
[    1.940481] usbcore: registered new interface driver usbhid
[    1.946088] usbhid: USB HID core driver
[    1.951040] wm8904 2-001a: supply DCVDD not found, using dummy regulator
[    1.957849] wm8904 2-001a: supply DBVDD not found, using dummy regulator
[    1.959412] mmc0: SDHCI controller on 2150000.mmc [2150000.mmc] using ADMA
[    1.964608] wm8904 2-001a: supply AVDD not found, using dummy regulator
[    1.971498] mmc1: SDHCI controller on 2140000.mmc [2140000.mmc] using ADMA
[    1.978161] wm8904 2-001a: supply CPVDD not found, using dummy regulator
[    1.991795] wm8904 2-001a: supply MICVDD not found, using dummy regulator
[    2.000066] wm8904 2-001a: revision A
[    2.011006] platform f140000.audio-controller: probe deferral - supplier 22c0000.dma-controller not ready
[    2.020630] platform f150000.audio-controller: probe deferral - supplier 22c0000.dma-controller not ready
[    2.030314] drop_monitor: Initializing network drop monitor service
[    2.036934] NET: Registered protocol family 10
[    2.041875] Segment Routing with IPv6
[    2.045615] NET: Registered protocol family 17
[    2.050199] can: controller area network core
[    2.054614] NET: Registered protocol family 29
[    2.059081] can: raw protocol
[    2.062060] can: broadcast manager protocol
[    2.066276] can: netlink gateway - max_hops=1
[    2.070785] 9pnet: Installing 9P2000 support
[    2.071171] random: fast init done
[    2.075110] Key type dns_resolver registered
[    2.078504] usb 3-1: new high-speed USB device number 2 using xhci-hcd
[    2.082977] registered taskstats version 1
[    2.093467] Loading compiled-in X.509 certificates
[    2.096902] mmc0: new HS400 MMC card at address 0001
[    2.100484] fsl-edma 22c0000.dma-controller: Adding to iommu group 4
[    2.103805] mmcblk0: mmc0:0001 S0J58X 29.6 GiB 
[    2.110777] pci-host-generic 1f0000000.pcie: host bridge /soc/pcie@1f0000000 ranges:
[    2.114498] mmcblk0boot0: mmc0:0001 S0J58X partition 1 31.5 MiB
[    2.122014] pci-host-generic 1f0000000.pcie:      MEM 0x01f8000000..0x01f815ffff -> 0x0000000000
[    2.128314] mmcblk0boot1: mmc0:0001 S0J58X partition 2 31.5 MiB
[    2.136776] pci-host-generic 1f0000000.pcie:      MEM 0x01f8160000..0x01f81cffff -> 0x0000000000
[    2.147614] mmcblk0rpmb: mmc0:0001 S0J58X partition 3 4.00 MiB, chardev (241:0)
[    2.151551] pci-host-generic 1f0000000.pcie:      MEM 0x01f81d0000..0x01f81effff -> 0x0000000000
[    2.163146]  mmcblk0: p1 p2
[    2.167727] pci-host-generic 1f0000000.pcie:      MEM 0x01f81f0000..0x01f820ffff -> 0x0000000000
[    2.179375] pci-host-generic 1f0000000.pcie:      MEM 0x01f8210000..0x01f822ffff -> 0x0000000000
[    2.179619] mmc1: new ultra high speed SDR104 SDHC card at address 5048
[    2.188227] pci-host-generic 1f0000000.pcie:      MEM 0x01f8230000..0x01f824ffff -> 0x0000000000
[    2.203691] pci-host-generic 1f0000000.pcie:      MEM 0x01fc000000..0x01fc3fffff -> 0x0000000000
[    2.203959] mmcblk1: mmc1:5048 SD16G 14.4 GiB 
[    2.212582] pci-host-generic 1f0000000.pcie: ECAM at [mem 0x1f0000000-0x1f00fffff] for [bus 00]
[    2.225049] GPT:Primary header thinks Alt. header is not at the end of the disk.
[    2.225832] pci-host-generic 1f0000000.pcie: PCI host bridge to bus 0000:00
[    2.233193] GPT:266272 != 30253055
[    2.240157] pci_bus 0000:00: root bus resource [bus 00]
[    2.240164] pci_bus 0000:00: root bus resource [mem 0x1f8000000-0x1f815ffff] (bus address [0x00000000-0x0015ffff])
[    2.243589] GPT:Alternate GPT header not at the end of the disk.
[    2.248824] pci_bus 0000:00: root bus resource [mem 0x1f8160000-0x1f81cffff pref] (bus address [0x00000000-0x0006ffff])
[    2.259211] GPT:266272 != 30253055
[    2.265242] pci_bus 0000:00: root bus resource [mem 0x1f81d0000-0x1f81effff] (bus address [0x00000000-0x0001ffff])
[    2.276103] GPT: Use GNU Parted to correct GPT errors.
[    2.279483] pci_bus 0000:00: root bus resource [mem 0x1f81f0000-0x1f820ffff pref] (bus address [0x00000000-0x0001ffff])
[    2.279489] pci_bus 0000:00: root bus resource [mem 0x1f8210000-0x1f822ffff] (bus address [0x00000000-0x0001ffff])
[    2.279494] pci_bus 0000:00: root bus resource [mem 0x1f8230000-0x1f824ffff pref] (bus address [0x00000000-0x0001ffff])
[    2.279499] pci_bus 0000:00: root bus resource [mem 0x1fc000000-0x1fc3fffff] (bus address [0x00000000-0x003fffff])
[    2.279521] pci 0000:00:00.0: [1957:e100] type 00 class 0x020001
[    2.289971]  mmcblk1: p1
[    2.295081] pci 0000:00:00.0: BAR 0: [mem 0x1f8000000-0x1f803ffff 64bit] (from Enhanced Allocation, properties 0x0)
[    2.356551] pci 0000:00:00.0: BAR 2: [mem 0x1f8160000-0x1f816ffff 64bit pref] (from Enhanced Allocation, properties 0x1)
[    2.359017] hub 3-1:1.0: USB hub found
[    2.367482] pci 0000:00:00.0: VF BAR 0: [mem 0x1f81d0000-0x1f81dffff 64bit] (from Enhanced Allocation, properties 0x4)
[    2.371308] hub 3-1:1.0: 7 ports detected
[    2.381993] pci 0000:00:00.0: VF BAR 2: [mem 0x1f81f0000-0x1f81fffff 64bit pref] (from Enhanced Allocation, properties 0x3)
[    2.397218] pci 0000:00:00.0: PME# supported from D0 D3hot
[    2.402737] pci 0000:00:00.0: VF(n) BAR0 space: [mem 0x1f81d0000-0x1f81effff 64bit] (contains BAR0 for 2 VFs)
[    2.412699] pci 0000:00:00.0: VF(n) BAR2 space: [mem 0x1f81f0000-0x1f820ffff 64bit pref] (contains BAR2 for 2 VFs)
[    2.423260] pci 0000:00:00.1: [1957:e100] type 00 class 0x020001
[    2.429323] pci 0000:00:00.1: BAR 0: [mem 0x1f8040000-0x1f807ffff 64bit] (from Enhanced Allocation, properties 0x0)
[    2.439810] pci 0000:00:00.1: BAR 2: [mem 0x1f8170000-0x1f817ffff 64bit pref] (from Enhanced Allocation, properties 0x1)
[    2.450731] pci 0000:00:00.1: VF BAR 0: [mem 0x1f8210000-0x1f821ffff 64bit] (from Enhanced Allocation, properties 0x4)
[    2.461478] pci 0000:00:00.1: VF BAR 2: [mem 0x1f8230000-0x1f823ffff 64bit pref] (from Enhanced Allocation, properties 0x3)
[    2.472674] pci 0000:00:00.1: PME# supported from D0 D3hot
[    2.478193] pci 0000:00:00.1: VF(n) BAR0 space: [mem 0x1f8210000-0x1f822ffff 64bit] (contains BAR0 for 2 VFs)
[    2.488163] pci 0000:00:00.1: VF(n) BAR2 space: [mem 0x1f8230000-0x1f824ffff 64bit pref] (contains BAR2 for 2 VFs)
[    2.498689] pci 0000:00:00.2: [1957:e100] type 00 class 0x020001
[    2.504747] pci 0000:00:00.2: BAR 0: [mem 0x1f8080000-0x1f80bffff 64bit] (from Enhanced Allocation, properties 0x0)
[    2.515234] pci 0000:00:00.2: BAR 2: [mem 0x1f8180000-0x1f818ffff 64bit pref] (from Enhanced Allocation, properties 0x1)
[    2.526167] pci 0000:00:00.2: PME# supported from D0 D3hot
[    2.531802] pci 0000:00:00.3: [1957:ee01] type 00 class 0x088001
[    2.537868] pci 0000:00:00.3: BAR 0: [mem 0x1f8100000-0x1f811ffff 64bit] (from Enhanced Allocation, properties 0x0)
[    2.548357] pci 0000:00:00.3: BAR 2: [mem 0x1f8190000-0x1f819ffff 64bit pref] (from Enhanced Allocation, properties 0x1)
[    2.559290] pci 0000:00:00.3: PME# supported from D0 D3hot
[    2.564915] pci 0000:00:00.4: [1957:ee02] type 00 class 0x088001
[    2.570972] pci 0000:00:00.4: BAR 0: [mem 0x1f8120000-0x1f813ffff 64bit] (from Enhanced Allocation, properties 0x0)
[    2.581457] pci 0000:00:00.4: BAR 2: [mem 0x1f81a0000-0x1f81affff 64bit pref] (from Enhanced Allocation, properties 0x1)
[    2.592395] pci 0000:00:00.4: PME# supported from D0 D3hot
[    2.598030] pci 0000:00:00.5: [1957:eef0] type 00 class 0x020801
[    2.604092] pci 0000:00:00.5: BAR 0: [mem 0x1f8140000-0x1f815ffff 64bit] (from Enhanced Allocation, properties 0x0)
[    2.614583] pci 0000:00:00.5: BAR 2: [mem 0x1f81b0000-0x1f81bffff 64bit pref] (from Enhanced Allocation, properties 0x1)
[    2.625505] pci 0000:00:00.5: BAR 4: [mem 0x1fc000000-0x1fc3fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    2.636003] pci 0000:00:00.5: PME# supported from D0 D3hot
[    2.641641] pci 0000:00:00.6: [1957:e100] type 00 class 0x020001
[    2.647697] pci 0000:00:00.6: BAR 0: [mem 0x1f80c0000-0x1f80fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    2.658184] pci 0000:00:00.6: BAR 2: [mem 0x1f81c0000-0x1f81cffff 64bit pref] (from Enhanced Allocation, properties 0x1)
[    2.669118] pci 0000:00:00.6: PME# supported from D0 D3hot
[    2.675519] pci 0000:00:1f.0: [1957:e001] type 00 class 0x080700
[    2.681596] OF: /soc/pcie@1f0000000: no msi-map translation for id 0xf8 on (null)
[    2.689371] fsl_enetc 0000:00:00.0: Adding to iommu group 5
[    2.707554] usb 3-1.6: new full-speed USB device number 3 using xhci-hcd
[    2.799556] fsl_enetc 0000:00:00.0: enabling device (0400 -> 0402)
[    2.805802] fsl_enetc 0000:00:00.0: no MAC address specified for SI1, using 82:f0:96:19:76:9c
[    2.814373] fsl_enetc 0000:00:00.0: no MAC address specified for SI2, using 5e:fb:ae:4d:83:1f
[    2.823365] libphy: Freescale ENETC MDIO Bus: probed
[    2.829583] libphy: Freescale ENETC internal MDIO Bus: probed
[    2.836011] fsl_enetc 0000:00:00.1: Adding to iommu group 6
[    2.841724] fsl_enetc 0000:00:00.1: device is disabled, skipping
[    2.847885] fsl_enetc 0000:00:00.2: Adding to iommu group 7
[    2.853568] fsl_enetc 0000:00:00.2: device is disabled, skipping
[    2.859709] fsl_enetc_mdio 0000:00:00.3: Adding to iommu group 8
[    2.872274] hid-generic 0003:064F:2AF9.0001: device has no listeners, quitting
[    2.971555] fsl_enetc_mdio 0000:00:00.3: enabling device (0400 -> 0402)
[    2.978403] libphy: FSL PCIe IE Central MDIO Bus: probed
[    2.983940] mscc_felix 0000:00:00.5: Adding to iommu group 9
[    2.989781] mscc_felix 0000:00:00.5: device is disabled, skipping
[    2.996017] fsl_enetc 0000:00:00.6: Adding to iommu group 10
[    3.001802] fsl_enetc 0000:00:00.6: device is disabled, skipping
[    3.007871] OF: /soc/pcie@1f0000000: no iommu-map translation for id 0xf8 on (null)
[    3.015686] pcieport 0000:00:1f.0: PME: Signaling with IRQ 123
[    3.021749] pcieport 0000:00:1f.0: AER: enabled with IRQ 123
[    3.028170] 2270000.serial: ttyLP2 at MMIO 0x2270000 (irq = 25, base_baud = 12500000) is a FSL_LPUART
[    3.038551] spi-nor spi1.0: at25sl321 (4096 Kbytes)
[    3.047761] asoc-simple-card sound: ASoC: no DMI vendor name!
[    3.056720] input: buttons0 as /devices/platform/buttons0/input/input1
[    3.063570] ALSA device list:
[    3.066547]   #0: f150000.audio-controller-wm8904-hifi
[    3.075682] EXT4-fs (mmcblk0p2): INFO: recovery required on readonly filesystem
[    3.083049] EXT4-fs (mmcblk0p2): write access will be enabled during recovery
[    3.095936] EXT4-fs (mmcblk0p2): recovery complete
[    3.102318] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    3.103561] usb 3-1.3: new high-speed USB device number 4 using xhci-hcd
[    3.112153] VFS: Mounted root (ext4 filesystem) readonly on device 179:2.
[    3.125913] devtmpfs: mounted
[    3.133476] Freeing unused kernel memory: 4736K
[    3.147609] Missing param value! Expected 'debug=...value...'
[    3.153388] Missing param value! Expected 'rootwait=...value...'
[    3.159421] Run /sbin/init as init process
[    3.163540]   with arguments:
[    3.166513]     /sbin/init
[    3.169228]   with environment:
[    3.172378]     HOME=/
[    3.174741]     TERM=linux
[    3.205526] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null). Quota mode: none.
[    3.223479] usb-storage 3-1.3:1.0: USB Mass Storage device detected
[    3.230192] scsi host0: usb-storage 3-1.3:1.0
[    3.277936] udevd[139]: starting version 3.2.8
[    3.283246] random: udevd: uninitialized urandom read (16 bytes read)
[    3.290280] random: udevd: uninitialized urandom read (16 bytes read)
[    3.296805] random: udevd: uninitialized urandom read (16 bytes read)
[    3.304858] udevd[139]: specified group 'kvm' unknown
[    3.317735] udevd[140]: starting eudev-3.2.8
[    4.634039] scsi 0:0:0:0: Direct-Access     JetFlash Transcend 32GB   1100 PQ: 0 ANSI: 6
[    4.646337] sd 0:0:0:0: [sda] 61702144 512-byte logical blocks: (31.6 GB/29.4 GiB)
[    4.657126] sd 0:0:0:0: [sda] Write Protect is off
[    4.662029] sd 0:0:0:0: [sda] Mode Sense: 43 00 00 00
[    4.673461] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.710188]  sda: sda1
[    4.715321] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    4.753103] fsl_enetc 0000:00:00.0 gbe0: renamed from eth0
[    6.006576] urandom_read: 3 callbacks suppressed
[    6.006587] random: dd: uninitialized urandom read (512 bytes read)
[    6.108830] fsl_enetc 0000:00:00.0 gbe0: PHY [0000:00:00.0:05] driver [Qualcomm Atheros AR8031/AR8033] (irq=POLL)
[    6.127032] fsl_enetc 0000:00:00.0 gbe0: configuring for inband/sgmii link mode
[    6.153943] random: dropbear: uninitialized urandom read (32 bytes read)
[   10.212329] fsl_enetc 0000:00:00.0 gbe0: Link is Up - 1Gbps/Full - flow control rx/tx
[   10.220233] IPv6: ADDRCONF(NETDEV_CHANGE): gbe0: link becomes ready
[  164.963579] random: crng init done

HTH,
-michael
