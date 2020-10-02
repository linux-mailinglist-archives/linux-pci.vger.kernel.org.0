Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A84280FDA
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 11:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgJBJaH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 05:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJBJaG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 05:30:06 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BF6C0613D0
        for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2020 02:30:05 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id o8so775496otl.4
        for <linux-pci@vger.kernel.org>; Fri, 02 Oct 2020 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zE69fsYMitPYyw0c71bvhOXi9871tbyiSnv4grxFsDM=;
        b=ZbdWm6eDLKEcPQ6LRLeHtAgaTqYSS3zDgIUINXQROYiws0gEdw02MnuDRLFUWWYfeq
         kzHxQZEbgAcEyRLHL1f52PSFjRLUxqnPYA07ZYguCACRdJHLuJobPZUUyyRhMA9in0N5
         glKL8YOleEIHw4e9QUsg7kfWZQgxbzH6QGNQsxc6bU6Sq0GHsBVur0QkKHkNJdI6Dhs0
         93AKFcuBy2LFU9o1sIevbJGTG12mFGFSGvp0RZhRAtYjQqD8QChK1BHb5w0qbiX8gHSt
         EJgyEY9UIiXnITSmAmEhYNLZuL/Yi4aEBKEkUoHoZt6m2Xm3XxfkMBZUyJ5GMcT2KJPR
         mSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zE69fsYMitPYyw0c71bvhOXi9871tbyiSnv4grxFsDM=;
        b=fDWtx1nxSKDzjpg694oeEMr7WNlLGJMbCcKqPrzr8FX0RXwI140PDw+gUK4qFfyqXW
         xEo2DEZ6FLcDKFd+Hr1Unk/hMKxnVPE5xf6xsLzpDfUiH6vd2s2yUSJtWBdWEx4oO9b1
         Ls7GXnBy+eYwuGHIZanO76YAHf9hNTk0pD+WIguA51Ldu4qfAtLCGmn9+XluAgELEHeO
         w24ginqf6ZO/MqZ0noooETPygHMj9zKUmSCuzCz4en2mXtOnkzOesfvdsdPAB5KC2M0K
         WD1TK8RfBq3LgmTN1DAhqX68vIEG60WV9YfkxXJ6DZFgq9UrFX4U4fAk93yf3jPfgXRI
         gw/Q==
X-Gm-Message-State: AOAM5300l8f/i/h82eMXHkTNbyZICQde3vj5aALlexNfhrgGz9IjJaPY
        8ofU72rnj2wNBCuMhlKrZhVoLKTwhMwhCgtIYQ/mbg==
X-Google-Smtp-Source: ABdhPJxv6lyt1iJBH4eWcrIwbz/ItzzeA6umb7mnJgmWW1zYxi3pFZKIFn/mpFBJ1EdCeJMlp9O36xTz2spU1WZo0YA=
X-Received: by 2002:a05:6830:22ce:: with SMTP id q14mr1029057otc.72.1601631004482;
 Fri, 02 Oct 2020 02:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200916054130.8685-1-Zhiqiang.Hou@nxp.com> <CAL_JsqJwgNUpWFTq2YWowDUigndSOB4rUcVm0a_U=FEpEmk94Q@mail.gmail.com>
 <HE1PR0402MB3371F8191538F47E8249F048843F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <CAL_JsqLdQY_DqpduaTv4hMDM_-cvZ_+s8W+HdOuZVVYjTO4yxw@mail.gmail.com>
 <HE1PR0402MB337180458625B05D1529535384390@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <20200928093911.GB12010@e121166-lin.cambridge.arm.com> <HE1PR0402MB33713A623A37D08AE3253DEB84320@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <DM5PR12MB1276D80424F88F8A9243D5E2DA320@DM5PR12MB1276.namprd12.prod.outlook.com>
 <CAL_JsqJJxq2jZzbzZffsrPxnoLJdWLLS-7bG-vaqyqs5NkQhHQ@mail.gmail.com>
 <9ac53f04-f2e8-c5f9-e1f7-e54270ec55a0@ti.com> <CAL_JsqJEp8yyctJYUjHM4Ti6ggPb4ouYM_WDvpj_PiobnAozBw@mail.gmail.com>
 <67ac959f-561e-d1a0-2d89-9a85d5f92c72@ti.com> <99d24fe08ecb5a6f5bba7dc6b1e2b42b@walle.cc>
In-Reply-To: <99d24fe08ecb5a6f5bba7dc6b1e2b42b@walle.cc>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 2 Oct 2020 14:59:53 +0530
Message-ID: <CA+G9fYtR5MwQ_Gd1=R=815eCAz+5uC67wXV2x094pc_=PtkA2g@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of dw_child_pcie_ops
To:     Zhiqiang.Hou@nxp.com, Rob Herring <robh@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Michael Walle <michael@walle.cc>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 1 Oct 2020 at 22:16, Michael Walle <michael@walle.cc> wrote:
>
> Am 2020-10-01 15:32, schrieb Kishon Vijay Abraham I:
>
> > Meanwhile would it be okay to add linkup check atleast for DRA7X so
> > that
> > we could have it booting in linux-next?
>
> Layerscape SoCs (at least the LS1028A) are also still broken in
> linux-next,
> did I miss something here?

I have been monitoring linux next boot and functional testing on nxp devices
for more than two week and still the problem exists on nxp-ls2088.

Do you mind checking the possibilities to revert bad patches on linux next tree
and continue to work on fixes please ?

suspected bad commit: [ I have not bisected this problem ]
c2b0c098fbd1 ("PCI: dwc: Use generic config accessors")

crash log snippet:
[    1.563008] SError Interrupt on CPU5, code 0xbf000002 -- SError
[    1.563010] CPU: 5 PID: 1 Comm: swapper/0 Not tainted
5.9.0-rc7-next-20201001 #1
[    1.563011] Hardware name: Freescale Layerscape 2088A RDB Board (DT)
[    1.563013] pstate: 20000085 (nzCv daIf -PAN -UAO -TCO BTYPE=--)
[    1.563014] pc : pci_generic_config_read+0x44/0xe8
[    1.563015] lr : pci_generic_config_read+0x2c/0xe8


full boot log and its link,
----------------------------------
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd082]
[    0.000000] Linux version 5.9.0-rc7-next-20201001
(TuxBuild@40858153859f) (aarch64-linux-gnu-gcc (Debian 9.3.0-8) 9.3.0,
GNU ld (GNU Binutils for Debian) 2.34) #1 SMP PREEMPT Thu Oct 1
14:14:17 UTC 2020
[    0.000000] Machine model: Freescale Layerscape 2088A RDB Board
[    0.000000] earlycon: uart8250 at MMIO 0x00000000021c0600 (options '')
[    0.000000] printk: bootconsole [uart8250] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] [Firmware Bug]: Kernel image misaligned at boot, please
fix your bootloader!
[    0.000000] cma: Reserved 32 MiB at 0x00000000f9c00000
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem
0x0000000080000000-0x000000837fffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x837e3fb100-0x837e3fcfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000bfffffff]
[    0.000000]   DMA32    [mem 0x00000000c0000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000837fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000fbdfffff]
[    0.000000]   node   0: [mem 0x0000008080000000-0x000000837fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000837fffffff]
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] percpu: Embedded 31 pages/cpu s89624 r8192 d29160 u126976
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: EL2 vector hardening
[    0.000000] CPU features: kernel page table isolation forced ON by KASLR
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] CPU features: detected: Spectre-v2
[    0.000000] CPU features: detected: ARM errata 1165522, 1319367, or 1530923
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 3596040
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: console=ttyS1,115200n8
root=/dev/nfs rw
nfsroot=59.144.98.45:/var/lib/lava/dispatcher/tmp/90794/extract-nfsrootfs-r9w7i8h0,tcp,hard,v3
earlycon=uart8250,mmio,0x21c0600 nousb default_hugepagesz=2m
hugepagesz=2m hugepages=256 arm-smmu-mod.disable_bypass=n
arm-smmu.disable_bypass=n  ip=dhcp
[    0.000000] Dentry cache hash table entries: 2097152 (order: 12,
16777216 bytes, linear)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 11,
8388608 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem
0x00000000bbfff000-0x00000000bffff000] (64MB)
[    0.000000] Memory: 14189284K/14612480K available (17468K kernel
code, 3990K rwdata, 9344K rodata, 9344K init, 566K bss, 390428K
reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] ftrace: allocating 59411 entries in 233 pages
[    0.000000] ftrace: allocated 233 pages with 5 groups
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: RCU event tracing is enabled.
[    0.000000] rcu: RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=8.
[    0.000000] Trampoline variant of Tasks RCU enabled.
[    0.000000] Rude variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 256 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: 16 PPIs implemented
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000006100000
[    0.000000] ITS [mem 0x06020000-0x0603ffff]
[    0.000000] ITS@0x0000000006020000: allocated 8192 Devices
@836e5d0000 (flat, esz 8, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] GICv3: using LPI property table @0x000000836e5e0000
[    0.000000] GIC: using cache flushing for LPI property table
[    0.000000] GICv3: CPU0: using allocated LPI pending table
@0x000000836e5f0000
[    0.000000] random: get_random_bytes called from
start_kernel+0x39c/0x56c with crng_init=0
[    0.000000] arch_timer: Enabling global workaround for Freescale
erratum a005858
[    0.000000] arch_timer: CPU0: Trapping CNTVCT access
[    0.000000] arch_timer: cp15 timer(s) running at 25.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0x5c409fb33, max_idle_ns: 440795203156 ns
[    0.000002] sched_clock: 56 bits at 25MHz, resolution 39ns, wraps
every 4398046511103ns
[    0.008260] Console: colour dummy device 80x25
[    0.012772] Calibrating delay loop (skipped), value calculated
using timer frequency.. 50.00 BogoMIPS (lpj=100000)
[    0.023192] pid_max: default: 32768 minimum: 301
[    0.027878] LSM: Security Framework initializing
[    0.032588] Mount-cache hash table entries: 32768 (order: 6, 262144
bytes, linear)
[    0.040245] Mountpoint-cache hash table entries: 32768 (order: 6,
262144 bytes, linear)
[    0.049245] rcu: Hierarchical SRCU implementation.
[    0.054670] Platform MSI: gic-its@6020000 domain created
[    0.060101] PCI/MSI: /interrupt-controller@6000000/gic-its@6020000
domain created
[    0.067682] fsl-mc MSI: gic-its@6020000 domain created
[    0.073366] EFI services will not be available.
[    0.078210] smp: Bringing up secondary CPUs ...
[    0.083166] Detected PIPT I-cache on CPU1
[    0.083182] GICv3: CPU1: found redistributor 1 region 0:0x0000000006120000
[    0.083190] GICv3: CPU1: using allocated LPI pending table
@0x000000836e600000
[    0.083206] arch_timer: CPU1: Trapping CNTVCT access
[    0.083216] CPU1: Booted secondary processor 0x0000000001 [0x410fd082]
[    0.083656] Detected PIPT I-cache on CPU2
[    0.083671] GICv3: CPU2: found redistributor 100 region 0:0x0000000006140000
[    0.083679] GICv3: CPU2: using allocated LPI pending table
@0x000000836e610000
[    0.083694] arch_timer: CPU2: Trapping CNTVCT access
[    0.083703] CPU2: Booted secondary processor 0x0000000100 [0x410fd082]
[    0.084154] Detected PIPT I-cache on CPU3
[    0.084164] GICv3: CPU3: found redistributor 101 region 0:0x0000000006160000
[    0.084171] GICv3: CPU3: using allocated LPI pending table
@0x000000836e620000
[    0.084181] arch_timer: CPU3: Trapping CNTVCT access
[    0.084188] CPU3: Booted secondary processor 0x0000000101 [0x410fd082]
[    0.084608] Detected PIPT I-cache on CPU4
[    0.084624] GICv3: CPU4: found redistributor 200 region 0:0x0000000006180000
[    0.084632] GICv3: CPU4: using allocated LPI pending table
@0x000000836e630000
[    0.084647] arch_timer: CPU4: Trapping CNTVCT access
[    0.084656] CPU4: Booted secondary processor 0x0000000200 [0x410fd082]
[    0.085098] Detected PIPT I-cache on CPU5
[    0.085109] GICv3: CPU5: found redistributor 201 region 0:0x00000000061a0000
[    0.085116] GICv3: CPU5: using allocated LPI pending table
@0x000000836e640000
[    0.085126] arch_timer: CPU5: Trapping CNTVCT access
[    0.085134] CPU5: Booted secondary processor 0x0000000201 [0x410fd082]
[    0.085563] Detected PIPT I-cache on CPU6
[    0.085581] GICv3: CPU6: found redistributor 300 region 0:0x00000000061c0000
[    0.085589] GICv3: CPU6: using allocated LPI pending table
@0x000000836e650000
[    0.085604] arch_timer: CPU6: Trapping CNTVCT access
[    0.085615] CPU6: Booted secondary processor 0x0000000300 [0x410fd082]
[    0.086050] Detected PIPT I-cache on CPU7
[    0.086061] GICv3: CPU7: found redistributor 301 region 0:0x00000000061e0000
[    0.086068] GICv3: CPU7: using allocated LPI pending table
@0x000000836e660000
[    0.086079] arch_timer: CPU7: Trapping CNTVCT access
[    0.086087] CPU7: Booted secondary processor 0x0000000301 [0x410fd082]
[    0.086162] smp: Brought up 1 node, 8 CPUs
[    0.299613] SMP: Total of 8 processors activated.
[    0.304348] CPU features: detected: 32-bit EL0 Support
[    0.309537] CPU features: detected: CRC32 instructions
[    0.314711] CPU features: detected: 32-bit EL1 Support
[    0.339004] CPU: All CPU(s) started at EL2
[    0.343157] alternatives: patching kernel code
[    0.348551] devtmpfs: initialized
[    0.353789] KASLR enabled
[    0.356755] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.366571] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.374031] pinctrl core: initialized pinctrl subsystem
[    0.379863] DMI not present or invalid.
[    0.384013] NET: Registered protocol family 16
[    0.389659] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
[    0.397124] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for
atomic allocations
[    0.405317] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool
for atomic allocations
[    0.413398] audit: initializing netlink subsys (disabled)
[    0.418940] audit: type=2000 audit(0.280:1): state=initialized
audit_enabled=0 res=1
[    0.419382] thermal_sys: Registered thermal governor 'step_wise'
[    0.426741] thermal_sys: Registered thermal governor 'power_allocator'
[    0.433373] cpuidle: using governor menu
[    0.444057] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.451014] ASID allocator initialised with 32768 entries
[    0.457115] Serial: AMBA PL011 UART driver
[    0.482622] Machine: Freescale Layerscape 2088A RDB Board
[    0.488055] SoC family: QorIQ LS2088A
[    0.491733] SoC ID: svr:0x87090010, Revision: 1.0
[    0.511230] HugeTLB registered 2.00 MiB page size, pre-allocated 256 pages
[    0.518172] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.524921] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.531661] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    0.541027] cryptd: max_cpu_qlen set to 1000
[    0.550747] ACPI: Interpreter disabled.
[    0.556228] iommu: Default domain type: Translated
[    0.561321] vgaarb: loaded
[    0.564177] SCSI subsystem initialized
[    0.568186] usbcore: registered new interface driver usbfs
[    0.573730] usbcore: registered new interface driver hub
[    0.579135] usbcore: registered new device driver usb
[    0.584676] imx-i2c 2000000.i2c: can't get pinctrl, bus recovery
not supported
[    0.592140] i2c i2c-0: IMX I2C adapter registered
[    0.597181] mc: Linux media interface: v0.10
[    0.601505] videodev: Linux video capture interface: v2.00
[    0.607040] pps_core: LinuxPPS API ver. 1 registered
[    0.612031] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.621226] PTP clock support registered
[    0.625279] EDAC MC: Ver: 3.0.0
[    0.629525] fsl-ifc 2240000.ifc: Freescale Integrated Flash Controller
[    0.636130] fsl-ifc 2240000.ifc: IFC version 2.0, 8 banks
[    0.641716] FPGA manager framework
[    0.645165] Advanced Linux Sound Architecture Driver Initialized.
[    0.651768] clocksource: Switched to clocksource arch_sys_counter
[    1.001279] VFS: Disk quotas dquot_6.6.0
[    1.005269] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.012344] pnp: PnP ACPI: disabled
[    1.019574] NET: Registered protocol family 2
[    1.024205] tcp_listen_portaddr_hash hash table entries: 8192
(order: 5, 131072 bytes, linear)
[    1.032962] TCP established hash table entries: 131072 (order: 8,
1048576 bytes, linear)
[    1.041546] TCP bind hash table entries: 65536 (order: 8, 1048576
bytes, linear)
[    1.049454] TCP: Hash tables configured (established 131072 bind 65536)
[    1.056243] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    1.063249] UDP-Lite hash table entries: 8192 (order: 6, 262144
bytes, linear)
[    1.070792] NET: Registered protocol family 1
[    1.075466] RPC: Registered named UNIX socket transport module.
[    1.081446] RPC: Registered udp transport module.
[    1.086178] RPC: Registered tcp transport module.
[    1.090909] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.097393] PCI: CLS 0 bytes, default 64
[    1.102116] hw perfevents: enabled with armv8_pmuv3 PMU driver, 7
counters available
[    1.110121] kvm [1]: IPA Size Limit: 44 bits
[    1.115035] kvm [1]: vgic-v2@c0e0000
[    1.118651] kvm [1]: GIC system register CPU interface enabled
[    1.124671] kvm [1]: vgic interrupt IRQ9
[    1.128787] kvm [1]: Hyp mode initialized successfully
[    1.137122] Initialise system trusted keyrings
[    1.141697] workingset: timestamp_bits=44 max_order=22 bucket_order=0
[    1.150888] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    1.157123] NFS: Registering the id_resolver key type
[    1.162230] Key type id_resolver registered
[    1.166438] Key type id_legacy registered
[    1.170508] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.177326] 9p: Installing v9fs 9p2000 file system support
[    1.204782] NET: Registered protocol family 38
[    1.209256] Key type asymmetric registered
[    1.213377] Asymmetric key parser 'x509' registered
[    1.218299] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 244)
[    1.225741] io scheduler mq-deadline registered
[    1.230299] io scheduler kyber registered
[    1.244691] layerscape-pcie 3600000.pcie: host bridge
/soc/pcie@3600000 ranges:
[    1.252091] layerscape-pcie 3600000.pcie:       IO
0x3000010000..0x300001ffff -> 0x0000000000
[    1.260693] layerscape-pcie 3600000.pcie:      MEM
0x3040000000..0x307fffffff -> 0x0040000000
[    1.269382] layerscape-pcie 3600000.pcie: PCI host bridge to bus 0000:00
[    1.276126] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.281644] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    1.287862] pci_bus 0000:00: root bus resource [mem
0x3040000000-0x307fffffff] (bus address [0x40000000-0x7fffffff])
[    1.298475] pci 0000:00:00.0: [1957:8240] type 01 class 0x060400
[    1.304533] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00ffffff]
[    1.310844] pci 0000:00:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
[    1.317155] pci 0000:00:00.0: reg 0x38: [mem 0x3048000000-0x3048ffffff pref]
[    1.324323] pci 0000:00:00.0: supports D1 D2
[    1.328616] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
[    1.335444] pci 0000:01:00.0: [8086:10d3] type 00 class 0x020000
[    1.341558] pci 0000:01:00.0: reg 0x10: [mem 0x3049000000-0x304901ffff]
[    1.348250] pci 0000:01:00.0: reg 0x14: [mem 0x3049080000-0x30490fffff]
[    1.354941] pci 0000:01:00.0: reg 0x18: [io  0x1000-0x101f]
[    1.360585] pci 0000:01:00.0: reg 0x1c: [mem 0x3049100000-0x3049103fff]
[    1.367360] pci 0000:01:00.0: reg 0x30: [mem 0x3049140000-0x304917ffff pref]
[    1.374722] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    1.392335] pci 0000:00:00.0: BAR 1: assigned [mem 0x3040000000-0x3043ffffff]
[    1.399519] pci 0000:00:00.0: BAR 0: assigned [mem 0x3044000000-0x3044ffffff]
[    1.406703] pci 0000:00:00.0: BAR 6: assigned [mem
0x3045000000-0x3045ffffff pref]
[    1.414321] pci 0000:00:00.0: BAR 14: assigned [mem
0x3046000000-0x30460fffff]
[    1.421588] pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[    1.427806] pci 0000:01:00.0: BAR 1: assigned [mem 0x3046000000-0x304607ffff]
[    1.434996] pci 0000:01:00.0: BAR 6: assigned [mem
0x3046080000-0x30460bffff pref]
[    1.442613] pci 0000:01:00.0: BAR 0: assigned [mem 0x30460c0000-0x30460dffff]
[    1.449802] pci 0000:01:00.0: BAR 3: assigned [mem 0x30460e0000-0x30460e3fff]
[    1.456991] pci 0000:01:00.0: BAR 2: assigned [io  0x1000-0x101f]
[    1.463132] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    1.468388] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    1.474519] pci 0000:00:00.0:   bridge window [mem 0x3046000000-0x30460fffff]
[    1.481942] layerscape-pcie 3700000.pcie: host bridge
/soc/pcie@3700000 ranges:
[    1.489357] layerscape-pcie 3700000.pcie:       IO
0x3800010000..0x380001ffff -> 0x0000000000
[    1.497969] layerscape-pcie 3700000.pcie:      MEM
0x3840000000..0x387fffffff -> 0x0040000000
[    1.506647] layerscape-pcie 3700000.pcie: PCI host bridge to bus 0001:00
[    1.513390] pci_bus 0001:00: root bus resource [bus 00-ff]
[    1.518910] pci_bus 0001:00: root bus resource [io
0x10000-0x1ffff] (bus address [0x0000-0xffff])
[    1.527925] pci_bus 0001:00: root bus resource [mem
0x3840000000-0x387fffffff] (bus address [0x40000000-0x7fffffff])
[    1.538539] pci 0001:00:00.0: [1957:8240] type 01 class 0x060400
[    1.544609] pci 0001:00:00.0: reg 0x38: [mem 0x3840000000-0x38400007ff pref]
[    1.551773] pci 0001:00:00.0: supports D1 D2
[    1.556066] pci 0001:00:00.0: PME# supported from D0 D1 D2 D3hot
[    1.563008] SError Interrupt on CPU5, code 0xbf000002 -- SError
[    1.563010] CPU: 5 PID: 1 Comm: swapper/0 Not tainted
5.9.0-rc7-next-20201001 #1
[    1.563011] Hardware name: Freescale Layerscape 2088A RDB Board (DT)
[    1.563013] pstate: 20000085 (nzCv daIf -PAN -UAO -TCO BTYPE=--)
[    1.563014] pc : pci_generic_config_read+0x44/0xe8
[    1.563015] lr : pci_generic_config_read+0x2c/0xe8
[    1.563016] sp : ffff80001005b7d0
[    1.563017] x29: ffff80001005b7d0 x28: 0000000000000001
[    1.563020] x27: 0000000000000000 x26: ffff0082eddfb800
[    1.563022] x25: ffffc428e3e1dde8 x24: 0000000000000000
[    1.563025] x23: ffff80001005b924 x22: 0000000000000087
[    1.563027] x21: ffff0082eddfb800 x20: 0000000000000004
[    1.563029] x19: ffff80001005b864 x18: 0000000000000000
[    1.563032] x17: 00000000be711609 x16: 000000006455f136
[    1.563034] x15: ffff0082ee750480 x14: ffffffffffffffff
[    1.563036] x13: ffff0082cd313a1c x12: ffff0082cd313293
[    1.563039] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
[    1.563041] x9 : ffffc428e1d4a53c x8 : 0000000000000004
[    1.563043] x7 : ffff800011200000 x6 : ffff800011200000
[    1.563046] x5 : 0000000000000003 x4 : 0000000000000004
[    1.563048] x3 : 0000000000000004 x2 : dda16212b714c600
[    1.563050] x1 : 0000000000000000 x0 : ffff800010202000
[    1.563053] Kernel panic - not syncing: Asynchronous SError Interrupt
[    1.563054] CPU: 5 PID: 1 Comm: swapper/0 Not tainted
5.9.0-rc7-next-20201001 #1
[    1.563056] Hardware name: Freescale Layerscape 2088A RDB Board (DT)
[    1.563057] Call trace:
[    1.563058]  dump_backtrace+0x0/0x1d8
[    1.563059]  show_stack+0x20/0x70
[    1.563059]  dump_stack+0xf8/0x168
[    1.563060]  panic+0x184/0x390
[    1.563061]  nmi_panic+0x94/0x98
[    1.563062]  arm64_serror_panic+0x88/0x94
[    1.563063]  do_serror+0xac/0x1c8
[    1.563064]  el1_error+0x88/0x104
[    1.563065]  pci_generic_config_read+0x44/0xe8
[    1.563066]  dw_pcie_rd_other_conf+0x20/0x78
[    1.563067]  pci_bus_read_config_dword+0x88/0xe0
[    1.563068]  pci_bus_generic_read_dev_vendor_id+0x3c/0x1b8
[    1.563070]  pci_bus_read_dev_vendor_id+0x54/0x78
[    1.563071]  pci_scan_single_device+0x84/0xf8
[    1.563072]  pci_scan_slot+0x48/0x128
[    1.563073]  pci_scan_child_bus_extend+0x60/0x340
[    1.563074]  pci_scan_child_bus+0x1c/0x28
[    1.563075]  pci_scan_bridge_extend+0x168/0x5a8
[    1.563076]  pci_scan_child_bus_extend+0x138/0x340
[    1.563077]  pci_scan_root_bus_bridge+0x6c/0xe0
[    1.563078]  pci_host_probe+0x20/0xd0
[    1.563079]  dw_pcie_host_init+0x1b0/0x320
[    1.563080]  ls_pcie_probe+0x108/0x140
[    1.563081]  platform_drv_probe+0x5c/0xb0
[    1.563082]  really_probe+0xf0/0x4d8
[    1.563083]  driver_probe_device+0xfc/0x168
[    1.563084]  device_driver_attach+0x7c/0x88
[    1.563085]  __driver_attach+0xac/0x178
[    1.563086]  bus_for_each_dev+0x78/0xc8
[    1.563087]  driver_attach+0x2c/0x38
[    1.563088]  bus_add_driver+0x14c/0x230
[    1.563089]  driver_register+0x6c/0x128
[    1.563090]  __platform_driver_probe+0x80/0x148
[    1.563091]  ls_pcie_driver_init+0x2c/0x38
[    1.563092]  do_one_initcall+0x4c/0x2d0
[    1.563093]  kernel_init_freeable+0x214/0x280
[    1.563094]  kernel_init+0x1c/0x128
[    1.563095]  ret_from_fork+0x10/0x30
[    1.563111] SMP: stopping secondary CPUs
[    1.563112] Kernel Offset: 0x4428d1680000 from 0xffff800010000000
[    1.563113] PHYS_OFFSET: 0xffffd10300000000
[    1.563114] CPU features: 0x0240022,21806008
[    1.563115] Memory Limit: none

link,
https://lavalab.nxp.com/scheduler/job/90794#L791

-- 
Linaro LKFT
https://lkft.linaro.org
