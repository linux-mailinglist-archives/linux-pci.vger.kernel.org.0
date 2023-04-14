Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D456E2835
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 18:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDNQTZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 12:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNQTY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 12:19:24 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00715FF6;
        Fri, 14 Apr 2023 09:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X1USNpBFHjn1ACx9+mPqMYWUsn3hu9XfVGwIIKGWDQI=; b=pNPqcZWkis+Rf84RQ7j9e12iPJ
        6fXBoIBmE80QYK193OWsyFEQpbVdcHUJguOL00iBq25W9CIiG/uWJkeUki+UWPw008q4XilocPy34
        /mKY5JSDHkzM+bI5Ghz9OhEBJyysMEdruRT5/a3xLI2x3lwkFLKAWXCw8apYrB9fzn7C/7+4fBxJ9
        ntoFSSwMFUsOhtM8aw2fhb/WlOw6lQHkN28wdE46iI2jwrv9yN6GurFdnCO6nyv8IWSH/FADN1Ifn
        Pq5YGQ19j47JV4pdPNoBy6vGH/t7s7VCWDz4IhR/CYJ5csKVgAMtz+FRzKF16pPzXJmUwiH00Udjy
        dp7RhueA==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1pnM8k-001Rf5-36; Fri, 14 Apr 2023 16:19:12 +0000
Date:   Fri, 14 Apr 2023 18:19:07 +0200
From:   Cyril Brulebois <kibi@debian.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] PCI: brcmstb: CLKREQ# accomodations of downstream
 device
Message-ID: <20230414161907.zfd2ibshfx4rz56j@mraw.org>
Organization: Debian
References: <20230411165919.23955-1-jim2101024@gmail.com>
 <20230411165919.23955-3-jim2101024@gmail.com>
 <20230413143935.pmbyjk2boxl3rwne@mraw.org>
 <CANCKTBtXKAYf1LxR4qN+dVyxsWgyDztUVB4EdG=xhHbuhNCq5w@mail.gmail.com>
 <20230413200646.ddgsoqgmaae343nl@mraw.org>
 <CANCKTBuZ=Hxy9WgnjbauhHqXGx4QU_t8pgX=3che2K89=2BT9A@mail.gmail.com>
 <85a1cca1-f59b-6a0c-dee3-9d9ed5d6b6d1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gkufxfnhq527jljh"
Content-Disposition: inline
In-Reply-To: <85a1cca1-f59b-6a0c-dee3-9d9ed5d6b6d1@gmail.com>
X-Debian-User: kibi
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--gkufxfnhq527jljh
Content-Type: multipart/mixed; boundary="qxcrms5uunjosgsi"
Content-Disposition: inline


--qxcrms5uunjosgsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Florian Fainelli <f.fainelli@gmail.com> (2023-04-14):
> Cyril, based upon the table and logs you provided whereby you have used t=
he
> following:
>=20
> - Raspberry Pi Compute Module 4 (Rev 1.0, 8G RAM, 32G storage)
> - Raspberry Pi Compute Module 4 IO Board
> - SupaHub PCIe-to-multiple-USB adapter, reference PCE6U1C-R02, VER 006S
>=20
> in the before/unpatched case we have a PCIe link down and in the
> after/patched we have a PCIe link up but a kernel panic. Neither are great
> nor resulting in a fully functional PCIe device.

Based on Jim's feedback, I'm attaching a new dmesg for the aforementioned
setup, with an unpatched kernel (dmesg-unpatched-pcie-link-up.txt).

I fear that initially I might have not waited enough before power off and
power on when replugging the SupaHub adapter, and I've only seen the PCIe
link down a few times (now that I'm actively paying attention to that
part). I'm indeed seeing PCIe link up consistently (100%) when using the
following method:

    for i in $(seq 1 20); do
      # power on, let the system boot up and settle:
      sispmctl -t 4; sleep 2m
      ssh cm4 sh -c "dmesg > dmesg-$i.txt; poweroff"
      # let the system power down, and power off:
      sleep 30; sispmctl -t 4
      # wait before power cycling:
      sleep 10
    done

> Looking at:
> https://www.amazon.co.uk/SupaHub-Express-BandWidth-Capable-Expanding/dp/B=
092ZQWG5B
>=20
> it would appear that it can accept an external power supply, do you have =
one
> connected to that USB expansion card by any chance?

With the patched kernel, I have tried several things (leaving the regular
12V adapter plugged in all the time):
 - No external power supply (that's what I've been using in all previous
   attempts).
 - Using a 5V PSU with 2 pins (ground and 5V) plugged on the Ext PSU
   4-pin header on the IO Board.
 - Using a 5V PSU with a SATA connector plugged directly onto the SupaHub
   adapter.

I'm getting the same trace in all cases.

> Are you able to boot the kernel before/after if you disconnect any USB
> peripheral?

The trace is obtained without any USB peripheral (on the extension card or
on the onboard USB slots). Besides the SupaHub adapter on the PCIe slot, I
only have Ethernet and HDMI plugged in (I'm getting traces via serial
console, and operating the system over SSH when it boots fine).

As soon as I unplug the SupaHub board itself, the system boots fine.

> Does that SupaHub board plugged to the CM4 1.0 system work fine in the
> Raspberry Pi kernel tree?

With the Raspberry Pi OS (64-bit) > Raspberry Pi OS Lite image
(2023-02-21-raspios-bullseye-arm64-lite.img.xz), the system at least
boots fine; I haven't tried adding devices to the mix just yet, trying
to stick with that particular setup.

A full dmesg is attached (dmesg-raspios.txt).


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--qxcrms5uunjosgsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-unpatched-pcie-link-up.txt"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
[    0.000000] Linux version 6.3.0-rc6+ (kibi@genova) (aarch64-linux-gnu-gc=
c (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.=
2) #1 SMP Thu Apr 13 20:03:01 CEST 2023
[    0.000000] random: crng init done
[    0.000000] Machine model: Raspberry Pi Compute Module 4 Rev 1.0
[    0.000000] efi: UEFI not found.
[    0.000000] Reserved memory: created CMA memory pool at 0x00000000374000=
00, size 64 MiB
[    0.000000] OF: reserved mem: initialized node linux,cma, compatible id =
shared-dma-pool
[    0.000000] OF: reserved mem: 0x0000000037400000..0x000000003b3fffff (65=
536 KiB) map reusable linux,cma
[    0.000000] OF: reserved mem: 0x000000003ef625a0..0x000000003ef626d0 (0 =
KiB) nomap non-reusable nvram@0
[    0.000000] earlycon: bcm2835aux0 at MMIO32 0x00000000fe215040 (options =
'115200n8')
[    0.000000] printk: bootconsole [bcm2835aux0] enabled
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x00000001fff=
fffff]
[    0.000000] NUMA: NODE_DATA [mem 0x1ff00c280-0x1ff00efff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000]   DMA32    [mem 0x0000000040000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000001ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000003b3fffff]
[    0.000000]   node   0: [mem 0x0000000040000000-0x00000000fbffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x00000001ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000001fffff=
fff]
[    0.000000] On node 0, zone DMA32: 19456 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 16384 pages in unavailable ranges
[    0.000000] percpu: Embedded 31 pages/cpu s88232 r8192 d30552 u126976
[    0.000000] pcpu-alloc: s88232 r8192 d30552 u126976 alloc=3D31*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3=20
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: Spectre-v2
[    0.000000] CPU features: detected: Spectre-v3a
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] CPU features: detected: Spectre-BHB
[    0.000000] CPU features: kernel page table isolation forced ON by KASLR
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] CPU features: detected: ARM erratum 1742098
[    0.000000] CPU features: detected: ARM errata 1165522, 1319367, or 1530=
923
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Fallback order for Node 0: 0=20
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 20288=
48
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: video=3DHDMI-A-1:1920x1080M@60,margin_l=
eft=3D48,margin_right=3D48,margin_top=3D48,margin_bottom=3D48 dma.dmachans=
=3D0x37f5 bcm2709.boardrev=3D0xd03140 bcm2709.serial=3D0x751d0632 bcm2709.u=
art_clock=3D48000000 smsc95xx.macaddr=3DE4:5F:01:4D:5F:D7 vc_mem.mem_base=
=3D0x3ec00000 vc_mem.mem_size=3D0x40000000  console=3DttyS1,115200 root=3DL=
ABEL=3DRASPIROOT rw fsck.repair=3Dyes net.ifnames=3D0  rootwait earlycon
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608=
 bytes, linear)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.000000] software IO TLB: area num 4.
[    0.000000] software IO TLB: mapped [mem 0x0000000033400000-0x0000000037=
400000] (64MB)
[    0.000000] Memory: 3987300K/8245248K available (13440K kernel code, 277=
4K rwdata, 8248K rodata, 6528K init, 607K bss, 290288K reserved, 65536K cma=
-reserved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.000000] ftrace: allocating 43928 entries in 172 pages
[    0.000000] ftrace: allocated 172 pages with 4 groups
[    0.000000] trace event string verifier disabled
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=3D256 to nr_cpu_ids=
=3D4.
[    0.000000] 	Rude variant of Tasks RCU enabled.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.000000] arch_timer: cp15 timer(s) running at 54.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cy=
cles: 0xc743ce346, max_idle_ns: 440795203123 ns
[    0.000000] sched_clock: 56 bits at 54MHz, resolution 18ns, wraps every =
4398046511102ns
[    0.008293] Console: colour dummy device 80x25
[    0.012831] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 108.00 BogoMIPS (lpj=3D216000)
[    0.023383] pid_max: default: 32768 minimum: 301
[    0.028104] LSM: initializing lsm=3Dlockdown,capability,landlock,yama,in=
tegrity,apparmor,tomoyo,bpf
[    0.037094] landlock: Up and running.
[    0.040785] Yama: becoming mindful.
[    0.044391] AppArmor: AppArmor initialized
[    0.048529] TOMOYO Linux initialized
[    0.052150] LSM support for eBPF active
[    0.056115] Mount-cache hash table entries: 16384 (order: 5, 131072 byte=
s, linear)
[    0.063811] Mountpoint-cache hash table entries: 16384 (order: 5, 131072=
 bytes, linear)
[    0.073125] cblist_init_generic: Setting adjustable number of callback q=
ueues.
[    0.080449] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.086656] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.092943] rcu: Hierarchical SRCU implementation.
[    0.097782] rcu: 	Max phase no-delay instances is 1000.
[    0.104118] EFI services will not be available.
[    0.109030] smp: Bringing up secondary CPUs ...
[    0.113978] Detected PIPT I-cache on CPU1
[    0.114047] CPU1: Booted secondary processor 0x0000000001 [0x410fd083]
[    0.114421] Detected PIPT I-cache on CPU2
[    0.114457] CPU2: Booted secondary processor 0x0000000002 [0x410fd083]
[    0.114822] Detected PIPT I-cache on CPU3
[    0.114857] CPU3: Booted secondary processor 0x0000000003 [0x410fd083]
[    0.114898] smp: Brought up 1 node, 4 CPUs
[    0.150939] SMP: Total of 4 processors activated.
[    0.155688] CPU features: detected: 32-bit EL0 Support
[    0.160873] CPU features: detected: 32-bit EL1 Support
[    0.166062] CPU features: detected: CRC32 instructions
[    0.171305] CPU: All CPU(s) started at EL2
[    0.175448] alternatives: applying system-wide alternatives
[    0.258167] node 0 deferred pages initialised in 76ms
[    0.264630] devtmpfs: initialized
[    0.273248] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns
[    0.283148] futex hash table entries: 1024 (order: 4, 65536 bytes, linea=
r)
[    0.291457] pinctrl core: initialized pinctrl subsystem
[    0.297614] DMI not present or invalid.
[    0.301833] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.309143] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.316833] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.325692] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.333817] audit: initializing netlink subsys (disabled)
[    0.339412] audit: type=3D2000 audit(0.244:1): state=3Dinitialized audit=
_enabled=3D0 res=3D1
[    0.339957] thermal_sys: Registered thermal governor 'fair_share'
[    0.347244] thermal_sys: Registered thermal governor 'bang_bang'
[    0.353398] thermal_sys: Registered thermal governor 'step_wise'
[    0.359463] thermal_sys: Registered thermal governor 'user_space'
[    0.365528] thermal_sys: Registered thermal governor 'power_allocator'
[    0.371707] cpuidle: using governor ladder
[    0.382439] cpuidle: using governor menu
[    0.386517] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.393433] ASID allocator initialised with 32768 entries
[    0.399130] Serial: AMBA PL011 UART driver
[    0.410262] KASLR enabled
[    0.413665] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.420530] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
[    0.426862] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.433717] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
[    0.440046] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.446900] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.453229] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.460083] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.467546] ACPI: Interpreter disabled.
[    0.471664] iommu: Default domain type: Translated=20
[    0.476593] iommu: DMA domain TLB invalidation policy: strict mode=20
[    0.483082] EDAC MC: Ver: 3.0.0
[    0.486519] scmi_core: SCMI protocol bus registered
[    0.492029] NetLabel: Initializing
[    0.495466] NetLabel:  domain hash size =3D 128
[    0.499863] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.505611] NetLabel:  unlabeled traffic allowed by default
[    0.511374] vgaarb: loaded
[    0.514332] clocksource: Switched to clocksource arch_sys_counter
[    0.549785] VFS: Disk quotas dquot_6.6.0
[    0.553806] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.561228] AppArmor: AppArmor Filesystem Enabled
[    0.566034] pnp: PnP ACPI: disabled
[    0.573512] NET: Registered PF_INET protocol family
[    0.578927] IP idents hash table entries: 131072 (order: 8, 1048576 byte=
s, linear)
[    0.590470] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4,=
 65536 bytes, linear)
[    0.599270] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.607308] TCP established hash table entries: 65536 (order: 7, 524288 =
bytes, linear)
[    0.616322] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.626439] TCP: Hash tables configured (established 65536 bind 65536)
[    0.633407] MPTCP token hash table entries: 8192 (order: 5, 196608 bytes=
, linear)
[    0.641344] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.648308] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, l=
inear)
[    0.655786] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.661535] NET: Registered PF_XDP protocol family
[    0.666384] PCI: CLS 0 bytes, default 64
[    0.670609] Trying to unpack rootfs image as initramfs...
[    0.676170] hw perfevents: enabled with armv8_cortex_a72 PMU driver, 7 c=
ounters available
[    0.684669] kvm [1]: IPA Size Limit: 44 bits
[    0.690004] kvm [1]: vgic interrupt IRQ9
[    0.694037] kvm [1]: Hyp mode initialized successfully
[    0.700409] Initialise system trusted keyrings
[    0.704985] Key type blacklist registered
[    0.709327] workingset: timestamp_bits=3D42 max_order=3D21 bucket_order=
=3D0
[    0.716008] zbud: loaded
[    0.719171] integrity: Platform Keyring initialized
[    0.724197] integrity: Machine keyring initialized
[    0.729077] Key type asymmetric registered
[    0.733224] Asymmetric key parser 'x509' registered
[    1.675267] Freeing initrd memory: 31880K
[    1.692974] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 248)
[    1.700551] io scheduler mq-deadline registered
[    1.707175] irq_brcmstb_l2: registered L2 intc (/soc/interrupt-controlle=
r@7ef00100, parent irq: 18)
[    1.720146] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.727354] brcm-pcie fd500000.pcie: host bridge /scb/pcie@7d500000 rang=
es:
[    1.734395] brcm-pcie fd500000.pcie:   No bus range found for /scb/pcie@=
7d500000, using [bus 00-ff]
[    1.743554] brcm-pcie fd500000.pcie:      MEM 0x0600000000..0x0603ffffff=
 -> 0x00f8000000
[    1.751740] brcm-pcie fd500000.pcie:   IB MEM 0x0000000000..0x01ffffffff=
 -> 0x0400000000
[    1.760548] brcm-pcie fd500000.pcie: PCI host bridge to bus 0000:00
[    1.766887] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.772430] pci_bus 0000:00: root bus resource [mem 0x600000000-0x603fff=
fff] (bus address [0xf8000000-0xfbffffff])
[    1.782907] pci 0000:00:00.0: [14e4:2711] type 01 class 0x060400
[    1.789018] pci 0000:00:00.0: PME# supported from D0 D3hot
[    1.904371] brcm-pcie fd500000.pcie: link up, 5.0 GT/s PCIe x1 (SSC)
[    1.910823] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
[    1.916913] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
[    1.923886] pci 0000:01:00.0: PME# supported from D0 D3hot
[    1.938371] pci 0000:00:00.0: BAR 14: assigned [mem 0x600000000-0x6000ff=
fff]
[    1.945500] pci 0000:01:00.0: BAR 0: assigned [mem 0x600000000-0x600001f=
ff 64bit]
[    1.953074] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.958095] pci 0000:00:00.0:   bridge window [mem 0x600000000-0x6000fff=
ff]
[    1.965230] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
[    1.971458] pcieport 0000:00:00.0: PME: Signaling with IRQ 23
[    1.977465] pcieport 0000:00:00.0: AER: enabled with IRQ 23
[    1.983179] pci 0000:01:00.0: enabling device (0000 -> 0002)
[    6.988927] pci 0000:01:00.0: xHCI HW not ready after 5 sec (HC bug?) st=
atus =3D 0x1801
[    6.996862] pci 0000:01:00.0: quirk_usb_early_handoff+0x0/0x968 took 489=
6177 usecs
[    7.005184] simple-framebuffer 3e4e0000.framebuffer: framebuffer at 0x3e=
4e0000, 0x6e7000 bytes
[    7.013892] simple-framebuffer 3e4e0000.framebuffer: format=3Da8r8g8b8, =
mode=3D1824x984x32, linelength=3D7296
[    7.026754] Console: switching to colour frame buffer device 228x61
[    7.036135] simple-framebuffer 3e4e0000.framebuffer: fb0: simplefb regis=
tered!
[    7.048696] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    7.056025] printk: console [ttyS1] disabled
[    7.060403] fe215040.serial: ttyS1 at MMIO 0xfe215040 (irq =3D 31, base_=
baud =3D 62499999) is a 16550
[    7.069404] printk: console [ttyS1] enabled
[    7.077886] printk: bootconsole [bcm2835aux0] disabled
[    7.088802] Serial: AMBA driver
[    7.092199] msm_serial: driver initialized
[    7.097592] bcm2835-power bcm2835-power: Broadcom BCM2835 power domains =
driver
[    7.105367] mousedev: PS/2 mouse device common for all mice
[    7.111592] brcmstb-i2c fef04500.i2c:  @97500hz registered in polling mo=
de
[    7.118682] brcmstb-i2c fef09500.i2c:  @97500hz registered in polling mo=
de
[    7.126399] ledtrig-cpu: registered to indicate activity on CPUs
[    7.133020] bcm2835-mbox fe00b880.mailbox: mailbox enabled
[    7.156951] NET: Registered PF_INET6 protocol family
[    7.174534] Segment Routing with IPv6
[    7.178286] In-situ OAM (IOAM) with IPv6
[    7.182323] mip6: Mobile IPv6
[    7.185345] NET: Registered PF_PACKET protocol family
[    7.190549] mpls_gso: MPLS GSO support
[    7.197394] registered taskstats version 1
[    7.201792] Loading compiled-in X.509 certificates
[    7.244632] Loaded X.509 cert 'Build time autogenerated kernel key: 8398=
3db0a2e3422ed1c09ac9326e286f87dd9c0e'
[    7.256299] zswap: loaded using pool lzo/zbud
[    7.264462] Key type .fscrypt registered
[    7.268454] Key type fscrypt-provisioning registered
[    7.285473] Key type encrypted registered
[    7.289560] AppArmor: AppArmor sha1 policy hashing enabled
[    7.295146] ima: No TPM chip found, activating TPM-bypass!
[    7.300722] ima: Allocated hash algorithm: sha256
[    7.305517] ima: No architecture policies found
[    7.310133] evm: Initialising EVM extended attributes:
[    7.315340] evm: security.selinux
[    7.318697] evm: security.SMACK64 (disabled)
[    7.323022] evm: security.SMACK64EXEC (disabled)
[    7.327699] evm: security.SMACK64TRANSMUTE (disabled)
[    7.332818] evm: security.SMACK64MMAP (disabled)
[    7.337495] evm: security.apparmor
[    7.340939] evm: security.ima
[    7.343942] evm: security.capability
[    7.347562] evm: HMAC attrs: 0x1
[    7.556359] fe201000.serial: ttyAMA0 at MMIO 0xfe201000 (irq =3D 33, bas=
e_baud =3D 0) is a PL011 rev2
[    7.565687] serial serial0: tty port ttyAMA0 registered
[    7.571649] raspberrypi-firmware soc:firmware: Attached to firmware from=
 2022-08-26T14:03:16
[    7.581835] gpio-573 (ant1): hogged as output/high
[    7.587958] gpio-577 (ant2): hogged as output/low
[    7.605203] Freeing unused kernel memory: 6528K
[    7.660804] Checked W+X mappings: passed, no W+X pages found
[    7.666581] Run /init as init process
[    7.670288]   with arguments:
[    7.670292]     /init
[    7.670295]   with environment:
[    7.670298]     HOME=3D/
[    7.670301]     TERM=3Dlinux
[    7.940360] usb_phy_generic phy: dummy supplies not allowed for exclusiv=
e requests
[    7.957146] sdhci: Secure Digital Host Controller Interface driver
[    7.963452] sdhci: Copyright(c) Pierre Ossman
[    7.972361] usbcore: registered new interface driver usbfs
[    7.981134] usbcore: registered new interface driver hub
[    7.988461] bcmgenet fd580000.ethernet: GENET 5.0 EPHY: 0x0000
[    7.988739] usbcore: registered new device driver usb
[    7.989085] sdhci-pltfm: SDHCI platform and OF driver helper
[    8.002036] sdhci-iproc fe300000.mmc: allocated mmc-pwrseq
[    8.039280] pps_core: LinuxPPS API ver. 1 registered
[    8.042379] mmc1: SDHCI controller on fe300000.mmc [fe300000.mmc] using =
PIO
[    8.044401] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    8.051555] mmc0: SDHCI controller on fe340000.mmc [fe340000.mmc] using =
ADMA
[    8.072286] PTP clock support registered
[    8.113638] dwc2 fe980000.usb: supply vusb_d not found, using dummy regu=
lator
[    8.121016] dwc2 fe980000.usb: supply vusb_a not found, using dummy regu=
lator
[    8.180510] dwc2 fe980000.usb: DWC OTG Controller
[    8.185300] dwc2 fe980000.usb: new USB bus registered, assigned bus numb=
er 1
[    8.192464] dwc2 fe980000.usb: irq 38, io mem 0xfe980000
[    8.197962] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.03
[    8.206351] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    8.210412] unimac-mdio unimac-mdio.-19: Broadcom UniMAC MDIO bus
[    8.213675] usb usb1: Product: DWC OTG Controller
[    8.224619] usb usb1: Manufacturer: Linux 6.3.0-rc6+ dwc2_hsotg
[    8.230624] usb usb1: SerialNumber: fe980000.usb
[    8.235979] hub 1-0:1.0: USB hub found
[    8.239821] hub 1-0:1.0: 1 port detected
[    8.542339] usb 1-1: new high-speed USB device number 2 using dwc2
[    8.754442] usb 1-1: New USB device found, idVendor=3D0424, idProduct=3D=
2514, bcdDevice=3D b.b3
[    8.762741] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    8.770307] hub 1-1:1.0: USB hub found
[    8.774175] hub 1-1:1.0: 4 ports detected
[    9.822715] xhci_hcd 0000:01:00.0: Timeout for Set DATAX step: 34
[    9.828909] xhci_hcd 0000:01:00.0: ROM Download Step 34 failed at positi=
on 136 bytes with (-110)
[   10.188426] xhci_hcd 0000:01:00.0: xHCI Host Controller
[   10.193749] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus =
number 2
[   10.199301] mmc0: new HS200 MMC card at address 0001
[   10.207166] mmcblk0: mmc0:0001 BJTD4R 29.1 GiB=20
[   10.213627]  mmcblk0: p1 p2
[   10.217291] mmcblk0boot0: mmc0:0001 BJTD4R 4.00 MiB=20
[   10.225007] mmcblk0boot1: mmc0:0001 BJTD4R 4.00 MiB=20
[   10.232142] mmcblk0rpmb: mmc0:0001 BJTD4R 4.00 MiB, chardev (241:0)
[   10.315008] xhci_hcd 0000:01:00.0: hcc params 0x014051cf hci version 0x1=
00 quirks 0x0000001100000410
[   10.324800] xhci_hcd 0000:01:00.0: xHCI Host Controller
[   10.330118] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus =
number 3
[   10.337628] xhci_hcd 0000:01:00.0: Host supports USB 3.0 SuperSpeed
[   10.344165] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.03
[   10.352553] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   10.359932] usb usb2: Product: xHCI Host Controller
[   10.364877] usb usb2: Manufacturer: Linux 6.3.0-rc6+ xhci-hcd
[   10.370703] usb usb2: SerialNumber: 0000:01:00.0
[   10.375841] hub 2-0:1.0: USB hub found
[   10.379725] hub 2-0:1.0: 4 ports detected
[   10.384226] usb usb3: We don't know the algorithms for LPM for this host=
, disabling LPM.
[   10.392500] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.03
[   10.400886] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   10.408216] usb usb3: Product: xHCI Host Controller
[   10.413161] usb usb3: Manufacturer: Linux 6.3.0-rc6+ xhci-hcd
[   10.418988] usb usb3: SerialNumber: 0000:01:00.0
[   10.424074] hub 3-0:1.0: USB hub found
[   10.427948] hub 3-0:1.0: 4 ports detected
[   10.591348] EXT4-fs (mmcblk0p2): mounted filesystem 76e585ad-07e2-43e0-a=
ae7-43697734a9c4 with ordered data mode. Quota mode: none.
[   10.658391] usb 2-1: new high-speed USB device number 2 using xhci_hcd
[   10.717021] Not activating Mandatory Access Control as /sbin/tomoyo-init=
 does not exist.
[   10.823840] usb 2-1: New USB device found, idVendor=3D05e3, idProduct=3D=
0610, bcdDevice=3D 6.54
[   10.832181] usb 2-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[   10.839439] usb 2-1: Product: USB2.1 Hub
[   10.843422] usb 2-1: Manufacturer: GenesysLogic
[   10.851736] hub 2-1:1.0: USB hub found
[   10.856225] hub 2-1:1.0: 4 ports detected
[   10.909886] systemd[1]: System time before build time, advancing clock.
[   10.947056] usb 3-1: new SuperSpeed USB device number 2 using xhci_hcd
[   10.955466] systemd[1]: Inserted module 'autofs4'
[   10.975706] usb 3-1: New USB device found, idVendor=3D05e3, idProduct=3D=
0626, bcdDevice=3D 6.54
[   10.984029] usb 3-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[   10.991283] usb 3-1: Product: USB3.1 Hub
[   10.995270] usb 3-1: Manufacturer: GenesysLogic
[   11.004261] hub 3-1:1.0: USB hub found
[   11.008720] hub 3-1:1.0: 4 ports detected
[   11.013048] systemd[1]: systemd 252.5-2 running in system mode (+PAM +AU=
DIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +=
BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDIS=
K +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BP=
F_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=3Dunified)
[   11.045555] systemd[1]: Detected architecture arm64.
[   11.068093] systemd[1]: Hostname set to <rpi4-20230307>.
[   11.372962] systemd[1]: Queued start job for default target graphical.ta=
rget.
[   11.404694] systemd[1]: Created slice system-getty.slice - Slice /system=
/getty.
[   11.431376] systemd[1]: Created slice system-modprobe.slice - Slice /sys=
tem/modprobe.
[   11.459456] systemd[1]: Created slice system-serial\x2dgetty.slice - Sli=
ce /system/serial-getty.
[   11.487308] systemd[1]: Created slice system-systemd\x2dfsck.slice - Sli=
ce /system/systemd-fsck.
[   11.515115] systemd[1]: Created slice user.slice - User and Session Slic=
e.
[   11.538596] systemd[1]: Started systemd-ask-password-console.path - Disp=
atch Password Requests to Console Directory Watch.
[   11.566527] systemd[1]: Started systemd-ask-password-wall.path - Forward=
 Password Requests to Wall Directory Watch.
[   11.594854] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automou=
nt - Arbitrary Executable File Formats File System Automount Point.
[   11.626478] systemd[1]: Reached target cryptsetup.target - Local Encrypt=
ed Volumes.
[   11.650418] systemd[1]: Reached target integritysetup.target - Local Int=
egrity Protected Volumes.
[   11.678427] systemd[1]: Reached target paths.target - Path Units.
[   11.702417] systemd[1]: Reached target remote-fs.target - Remote File Sy=
stems.
[   11.726391] systemd[1]: Reached target slices.target - Slice Units.
[   11.750410] systemd[1]: Reached target swap.target - Swaps.
[   11.770407] systemd[1]: Reached target veritysetup.target - Local Verity=
 Protected Volumes.
[   11.798822] systemd[1]: Listening on systemd-fsckd.socket - fsck to fsck=
d communication Socket.
[   11.826561] systemd[1]: Listening on systemd-initctl.socket - initctl Co=
mpatibility Named Pipe.
[   11.854837] systemd[1]: Listening on systemd-journald-audit.socket - Jou=
rnal Audit Socket.
[   11.882732] systemd[1]: Listening on systemd-journald-dev-log.socket - J=
ournal Socket (/dev/log).
[   11.910746] systemd[1]: Listening on systemd-journald.socket - Journal S=
ocket.
[   11.935246] systemd[1]: Listening on systemd-udevd-control.socket - udev=
 Control Socket.
[   11.962692] systemd[1]: Listening on systemd-udevd-kernel.socket - udev =
Kernel Socket.
[   12.006600] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File S=
ystem...
[   12.033105] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue =
File System...
[   12.061091] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug F=
ile System...
[   12.088991] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace=
 File System...
[   12.117491] systemd[1]: Starting kmod-static-nodes.service - Create List=
 of Static Device Nodes...
[   12.145364] systemd[1]: Starting modprobe@configfs.service - Load Kernel=
 Module configfs...
[   12.173387] systemd[1]: Starting modprobe@drm.service - Load Kernel Modu=
le drm...
[   12.201603] systemd[1]: Starting modprobe@efi_pstore.service - Load Kern=
el Module efi_pstore...
[   12.229518] systemd[1]: Starting modprobe@fuse.service - Load Kernel Mod=
ule fuse...
[   12.248682] fuse: init (API version 7.38)
[   12.254624] systemd[1]: systemd-fsck-root.service - File System Check on=
 Root Device was skipped because of an unmet condition check (ConditionPath=
Exists=3D!/run/initramfs/fsck-root).
[   12.290806] systemd[1]: Starting systemd-journald.service - Journal Serv=
ice...
[   12.318928] systemd[1]: Starting systemd-modules-load.service - Load Ker=
nel Modules...
[   12.346941] systemd[1]: Starting systemd-remount-fs.service - Remount Ro=
ot and Kernel File Systems...
[   12.369881] EXT4-fs (mmcblk0p2): re-mounted 76e585ad-07e2-43e0-aae7-4369=
7734a9c4. Quota mode: none.
[   12.379420] systemd[1]: systemd-repart.service - Repartition Root Disk w=
as skipped because no trigger condition checks were met.
[   12.394204] systemd[1]: Starting systemd-udev-trigger.service - Coldplug=
 All udev Devices...
[   12.422815] systemd[1]: Started systemd-journald.service - Journal Servi=
ce.
[   12.825398] systemd-journald[222]: Received client request to flush runt=
ime journal.
[   12.836254] systemd-journald[222]: File /var/log/journal/04dbc87385f34b4=
9af5f5948a7d17809/system.journal corrupted or uncleanly shut down, renaming=
 and replacing.
[   13.546414] vchiq: module is from the staging directory, the quality is =
unknown, you have been warned.
[   13.559829] iproc-rng200 fe104000.rng: hwrng registered
[   13.613221] bcm2835-wdt bcm2835-wdt: Broadcom BCM2835 watchdog timer
[   13.710060] [drm] Initialized v3d 1.0.0 20180419 for fec00000.gpu on min=
or 0
[   13.739924] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
[   13.750638] mc: Linux media interface: v0.10
[   13.785003] snd_bcm2835: module is from the staging directory, the quali=
ty is unknown, you have been warned.
[   13.801798] videodev: Linux video capture interface: v2.00
[   13.811527] bcm2835_audio bcm2835_audio: card created with 8 channels
[   13.873899] bcm2835_mmal_vchiq: module is from the staging directory, th=
e quality is unknown, you have been warned.
[   13.898212] Console: switching to colour dummy device 80x25
[   13.898513] bcm2835_v4l2: module is from the staging directory, the qual=
ity is unknown, you have been warned.
[   13.935810] audit: type=3D1400 audit(1675040631.023:2): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"lsb_release" =
pid=3D346 comm=3D"apparmor_parser"
[   13.951158] audit: type=3D1400 audit(1675040631.027:3): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"nvidia_modpro=
be" pid=3D347 comm=3D"apparmor_parser"
[   13.951770] vc4-drm gpu: bound fe400000.hvs (ops vc4_hvs_ops [vc4])
[   13.968187] audit: type=3D1400 audit(1675040631.027:4): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"nvidia_modpro=
be//kmod" pid=3D347 comm=3D"apparmor_parser"
[   13.989368] audit: type=3D1400 audit(1675040631.039:5): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/lib/Netw=
orkManager/nm-dhcp-client.action" pid=3D349 comm=3D"apparmor_parser"
[   14.007674] audit: type=3D1400 audit(1675040631.039:6): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/lib/Netw=
orkManager/nm-dhcp-helper" pid=3D349 comm=3D"apparmor_parser"
[   14.025945] audit: type=3D1400 audit(1675040631.039:7): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/lib/conn=
man/scripts/dhclient-script" pid=3D349 comm=3D"apparmor_parser"
[   14.044325] audit: type=3D1400 audit(1675040631.039:8): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/{,usr/}sbin/=
dhclient" pid=3D349 comm=3D"apparmor_parser"
[   14.053979] Registered IR keymap rc-cec
[   14.065816] rc rc0: vc4-hdmi-0 as /devices/platform/soc/fef00700.hdmi/rc=
/rc0
[   14.073723] input: vc4-hdmi-0 as /devices/platform/soc/fef00700.hdmi/rc/=
rc0/input0
[   14.111139] vc4-drm gpu: bound fef00700.hdmi (ops vc4_hdmi_ops [vc4])
[   14.118921] Registered IR keymap rc-cec
[   14.122949] rc rc1: vc4-hdmi-1 as /devices/platform/soc/fef05700.hdmi/rc=
/rc1
[   14.130483] input: vc4-hdmi-1 as /devices/platform/soc/fef05700.hdmi/rc/=
rc1/input1
[   14.149200] vc4-drm gpu: bound fef05700.hdmi (ops vc4_hdmi_ops [vc4])
[   14.156226] vc4-drm gpu: bound fe004000.txp (ops vc4_txp_ops [vc4])
[   14.166016] vc4-drm gpu: bound fe206000.pixelvalve (ops vc4_crtc_ops [vc=
4])
[   14.174576] vc4-drm gpu: bound fe207000.pixelvalve (ops vc4_crtc_ops [vc=
4])
[   14.182578] vc4-drm gpu: bound fe20a000.pixelvalve (ops vc4_crtc_ops [vc=
4])
[   14.190243] vc4-drm gpu: bound fe216000.pixelvalve (ops vc4_crtc_ops [vc=
4])
[   14.199249] [drm] Initialized vc4 0.0.0 20140616 for gpu on minor 1
[   14.226017] Bluetooth: Core ver 2.22
[   14.229811] NET: Registered PF_BLUETOOTH protocol family
[   14.235247] Bluetooth: HCI device and connection manager initialized
[   14.242619] Bluetooth: HCI socket layer initialized
[   14.247632] Bluetooth: L2CAP socket layer initialized
[   14.252788] Bluetooth: SCO socket layer initialized
[   14.275535] systemd-journald[222]: Oldest entry in /var/log/journal/04db=
c87385f34b49af5f5948a7d17809/system.journal is older than the configured fi=
le retention duration (1month), suggesting rotation.
[   14.275550] systemd-journald[222]: /var/log/journal/04dbc87385f34b49af5f=
5948a7d17809/system.journal: Journal header limits reached or header out-of=
-date, rotating.
[   14.283240] Console: switching to colour frame buffer device 240x67
[   14.323550] Bluetooth: HCI UART driver ver 2.3
[   14.335320] vc4-drm gpu: [drm] fb0: vc4drmfb frame buffer device
[   14.341668] Bluetooth: HCI UART protocol H4 registered
[   14.357601] Bluetooth: HCI UART protocol LL registered
[   14.362846] Bluetooth: HCI UART protocol ATH3K registered
[   14.368456] Bluetooth: HCI UART protocol Three-wire (H5) registered
[   14.375594] Bluetooth: HCI UART protocol Intel registered
[   14.381875] Bluetooth: HCI UART protocol Broadcom registered
[   14.383301] hci_uart_bcm serial0-0: supply vbat not found, using dummy r=
egulator
[   14.388107] Bluetooth: HCI UART protocol QCA registered
[   14.396353] hci_uart_bcm serial0-0: supply vddio not found, using dummy =
regulator
[   14.402219] Bluetooth: HCI UART protocol AG6XX registered
[   14.402257] Bluetooth: HCI UART protocol Marvell registered
[   14.530445] uart-pl011 fe201000.serial: no DMA platform data
[   15.194826] bcmgenet fd580000.ethernet: configuring instance for externa=
l RGMII (RX delay)
[   15.263357] bcmgenet fd580000.ethernet eth0: Link is Down
[   16.674349] Bluetooth: hci0: command 0xfc18 tx timeout
[   19.362458] bcmgenet fd580000.ethernet eth0: Link is Up - 1Gbps/Full - f=
low control rx/tx
[   19.370808] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   24.674343] Bluetooth: hci0: BCM: failed to write update baudrate (-110)
[   24.681157] Bluetooth: hci0: Failed to set baudrate
[   26.690343] Bluetooth: hci0: command 0x0c03 tx timeout
[   30.517817] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=3D4=
81 'systemd'
[   34.914342] Bluetooth: hci0: BCM: Reset failed (-110)

--qxcrms5uunjosgsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-raspios.txt"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
[    0.000000] Linux version 5.15.84-v8+ (dom@buildbot) (aarch64-linux-gnu-=
gcc-8 (Ubuntu/Linaro 8.4.0-3ubuntu1) 8.4.0, GNU ld (GNU Binutils for Ubuntu=
) 2.34) #1613 SMP PREEMPT Thu Jan 5 12:03:08 GMT 2023
[    0.000000] random: crng init done
[    0.000000] Machine model: Raspberry Pi Compute Module 4 Rev 1.0
[    0.000000] efi: UEFI not found.
[    0.000000] Reserved memory: created CMA memory pool at 0x000000001ac000=
00, size 320 MiB
[    0.000000] OF: reserved mem: initialized node linux,cma, compatible id =
shared-dma-pool
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000]   DMA32    [mem 0x0000000040000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000001ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000003b3fffff]
[    0.000000]   node   0: [mem 0x0000000040000000-0x00000000fbffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x00000001ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000001fffff=
fff]
[    0.000000] On node 0, zone DMA32: 19456 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 16384 pages in unavailable ranges
[    0.000000] percpu: Embedded 28 pages/cpu s77336 r8192 d29160 u114688
[    0.000000] pcpu-alloc: s77336 r8192 d29160 u114688 alloc=3D28*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3=20
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: Spectre-v2
[    0.000000] CPU features: detected: Spectre-v3a
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] CPU features: detected: Spectre-BHB
[    0.000000] CPU features: kernel page table isolation forced ON by KASLR
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] CPU features: detected: ARM erratum 1742098
[    0.000000] CPU features: detected: ARM errata 1165522, 1319367, or 1530=
923
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 20288=
48
[    0.000000] Kernel command line: coherent_pool=3D1M 8250.nr_uarts=3D0 sn=
d_bcm2835.enable_compat_alsa=3D0 snd_bcm2835.enable_hdmi=3D1 video=3DHDMI-A=
-1:1920x1080M@60 smsc95xx.macaddr=3DE4:5F:01:4D:5F:D7 vc_mem.mem_base=3D0x3=
ec00000 vc_mem.mem_size=3D0x40000000  console=3DttyS0,115200 console=3Dtty1=
 root=3DPARTUUID=3D2633f715-02 rootfstype=3Dext4 fsck.repair=3Dyes rootwait
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608=
 bytes, linear)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x0000000037400000-0x000000003b=
400000] (64MB)
[    0.000000] Memory: 7668384K/8245248K available (11520K kernel code, 195=
6K rwdata, 4136K rodata, 3776K init, 975K bss, 249184K reserved, 327680K cm=
a-reserved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.000000] ftrace: allocating 38065 entries in 149 pages
[    0.000000] ftrace: allocated 149 pages with 4 groups
[    0.000000] trace event string verifier disabled
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=3D256 to nr_cpu_ids=
=3D4.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] 	Rude variant of Tasks RCU enabled.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] irq_brcmstb_l2: registered L2 intc (/soc/interrupt-controlle=
r@7ef00100, parent irq: 10)
[    0.000000] arch_timer: cp15 timer(s) running at 54.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cy=
cles: 0xc743ce346, max_idle_ns: 440795203123 ns
[    0.000001] sched_clock: 56 bits at 54MHz, resolution 18ns, wraps every =
4398046511102ns
[    0.000355] Console: colour dummy device 80x25
[    0.000966] printk: console [tty1] enabled
[    0.001048] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 108.00 BogoMIPS (lpj=3D216000)
[    0.001089] pid_max: default: 32768 minimum: 301
[    0.001248] LSM: Security Framework initializing
[    0.001546] Mount-cache hash table entries: 16384 (order: 5, 131072 byte=
s, linear)
[    0.001681] Mountpoint-cache hash table entries: 16384 (order: 5, 131072=
 bytes, linear)
[    0.003002] cgroup: Disabling memory control group subsystem
[    0.006038] rcu: Hierarchical SRCU implementation.
[    0.007234] EFI services will not be available.
[    0.007806] smp: Bringing up secondary CPUs ...
[    0.009038] Detected PIPT I-cache on CPU1
[    0.009125] CPU1: Booted secondary processor 0x0000000001 [0x410fd083]
[    0.010352] Detected PIPT I-cache on CPU2
[    0.010404] CPU2: Booted secondary processor 0x0000000002 [0x410fd083]
[    0.011592] Detected PIPT I-cache on CPU3
[    0.011642] CPU3: Booted secondary processor 0x0000000003 [0x410fd083]
[    0.011796] smp: Brought up 1 node, 4 CPUs
[    0.011893] SMP: Total of 4 processors activated.
[    0.011963] CPU features: detected: 32-bit EL0 Support
[    0.011986] CPU features: detected: 32-bit EL1 Support
[    0.012010] CPU features: detected: CRC32 instructions
[    0.045452] CPU: All CPU(s) started at EL2
[    0.045557] alternatives: patching kernel code
[    0.047483] devtmpfs: initialized
[    0.059212] Enabled cp15_barrier support
[    0.059287] Enabled setend support
[    0.059328] KASLR enabled
[    0.059550] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns
[    0.059602] futex hash table entries: 1024 (order: 4, 65536 bytes, linea=
r)
[    0.069809] pinctrl core: initialized pinctrl subsystem
[    0.070734] DMI not present or invalid.
[    0.071477] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.075331] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.075667] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.076633] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.076757] audit: initializing netlink subsys (disabled)
[    0.077092] audit: type=3D2000 audit(0.076:1): state=3Dinitialized audit=
_enabled=3D0 res=3D1
[    0.077702] thermal_sys: Registered thermal governor 'step_wise'
[    0.077948] cpuidle: using governor menu
[    0.078275] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.078489] ASID allocator initialised with 32768 entries
[    0.078673] Serial: AMBA PL011 UART driver
[    0.091640] bcm2835-mbox fe00b880.mailbox: mailbox enabled
[    0.116400] raspberrypi-firmware soc:firmware: Attached to firmware from=
 2023-01-05T10:46:54, variant start
[    0.120415] raspberrypi-firmware soc:firmware: Firmware hash is 8ba17717=
fbcedd4c3b6d4bce7e50c7af4155cba9
[    0.173306] bcm2835-dma fe007000.dma: DMA legacy API manager, dmachans=
=3D0x1
[    0.177690] vgaarb: loaded
[    0.178161] SCSI subsystem initialized
[    0.178406] usbcore: registered new interface driver usbfs
[    0.178475] usbcore: registered new interface driver hub
[    0.178555] usbcore: registered new device driver usb
[    0.178945] usb_phy_generic phy: supply vcc not found, using dummy regul=
ator
[    0.179178] usb_phy_generic phy: dummy supplies not allowed for exclusiv=
e requests
[    0.179503] pps_core: LinuxPPS API ver. 1 registered
[    0.179527] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.179566] PTP clock support registered
[    0.181225] clocksource: Switched to clocksource arch_sys_counter
[    0.273823] VFS: Disk quotas dquot_6.6.0
[    0.273976] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.274169] FS-Cache: Loaded
[    0.274443] CacheFiles: Loaded
[    0.275842] simple-framebuffer 3e3cf000.framebuffer: framebuffer at 0x3e=
3cf000, 0x7f8000 bytes
[    0.275880] simple-framebuffer 3e3cf000.framebuffer: format=3Da8r8g8b8, =
mode=3D1920x1080x32, linelength=3D7680
[    0.288079] Console: switching to colour frame buffer device 240x67
[    0.299085] simple-framebuffer 3e3cf000.framebuffer: fb0: simplefb regis=
tered!
[    0.309941] NET: Registered PF_INET protocol family
[    0.311043] IP idents hash table entries: 131072 (order: 8, 1048576 byte=
s, linear)
[    0.317271] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4,=
 65536 bytes, linear)
[    0.317476] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.317589] TCP established hash table entries: 65536 (order: 7, 524288 =
bytes, linear)
[    0.318158] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes,=
 linear)
[    0.319322] TCP: Hash tables configured (established 65536 bind 65536)
[    0.319726] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.319964] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, l=
inear)
[    0.320498] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.322192] RPC: Registered named UNIX socket transport module.
[    0.322286] RPC: Registered udp transport module.
[    0.322348] RPC: Registered tcp transport module.
[    0.322411] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.322500] PCI: CLS 0 bytes, default 64
[    0.325077] hw perfevents: enabled with armv8_cortex_a72 PMU driver, 7 c=
ounters available
[    0.325580] kvm [1]: IPA Size Limit: 44 bits
[    0.326840] kvm [1]: vgic interrupt IRQ9
[    0.327166] kvm [1]: Hyp mode initialized successfully
[    1.165639] Initialise system trusted keyrings
[    1.166141] workingset: timestamp_bits=3D46 max_order=3D21 bucket_order=
=3D0
[    1.173319] zbud: loaded
[    1.175334] FS-Cache: Netfs 'nfs' registered for caching
[    1.176145] NFS: Registering the id_resolver key type
[    1.176245] Key type id_resolver registered
[    1.176304] Key type id_legacy registered
[    1.176468] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.176553] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Regist=
ering...
[    1.177919] Key type asymmetric registered
[    1.177987] Asymmetric key parser 'x509' registered
[    1.178129] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 247)
[    1.178482] io scheduler mq-deadline registered
[    1.178549] io scheduler kyber registered
[    1.187178] gpio-507 (ant1): hogged as output/high
[    1.191521] gpio-511 (ant2): hogged as output/low
[    1.193106] brcm-pcie fd500000.pcie: host bridge /scb/pcie@7d500000 rang=
es:
[    1.196194] brcm-pcie fd500000.pcie:   No bus range found for /scb/pcie@=
7d500000, using [bus 00-ff]
[    1.199282] brcm-pcie fd500000.pcie:      MEM 0x0600000000..0x063fffffff=
 -> 0x00c0000000
[    1.202337] brcm-pcie fd500000.pcie:   IB MEM 0x0000000000..0x01ffffffff=
 -> 0x0400000000
[    1.239327] brcm-pcie fd500000.pcie: link up, 5.0 GT/s PCIe x1 (SSC)
[    1.242607] brcm-pcie fd500000.pcie: PCI host bridge to bus 0000:00
[    1.245566] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.248544] pci_bus 0000:00: root bus resource [mem 0x600000000-0x63ffff=
fff] (bus address [0xc0000000-0xffffffff])
[    1.251681] pci 0000:00:00.0: [14e4:2711] type 01 class 0x060400
[    1.254957] pci 0000:00:00.0: PME# supported from D0 D3hot
[    1.261935] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
[    1.265001] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
[    1.268294] pci 0000:01:00.0: PME# supported from D0 D3hot
[    1.274980] pci 0000:00:00.0: BAR 8: assigned [mem 0x600000000-0x6000fff=
ff]
[    1.277979] pci 0000:01:00.0: BAR 0: assigned [mem 0x600000000-0x600001f=
ff 64bit]
[    1.280967] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.283928] pci 0000:00:00.0:   bridge window [mem 0x600000000-0x6000fff=
ff]
[    1.286965] pci 0000:00:00.0: enabling device (0000 -> 0002)
[    1.289902] pci 0000:01:00.0: enabling device (0000 -> 0002)
[    6.292814] pci 0000:01:00.0: xHCI HW not ready after 5 sec (HC bug?) st=
atus =3D 0x1801
[    6.295779] pci 0000:01:00.0: quirk_usb_early_handoff+0x0/0x8b0 took 489=
1439 usecs
[    6.311060] iproc-rng200 fe104000.rng: hwrng registered
[    6.314534] vc-mem: phys_addr:0x00000000 mem_base=3D0x3ec00000 mem_size:=
0x40000000(1024 MiB)
[    6.319013] gpiomem-bcm2835 fe200000.gpiomem: Initialised: Registers at =
0xfe200000
[    6.335069] brd: module loaded
[    6.348156] loop: module loaded
[    6.351963] Loading iSCSI transport class v2.0-870.
[    6.360243] bcmgenet fd580000.ethernet: GENET 5.0 EPHY: 0x0000
[    6.421392] unimac-mdio unimac-mdio.-19: Broadcom UniMAC MDIO bus
[    6.425459] usbcore: registered new interface driver r8152
[    6.428322] usbcore: registered new interface driver lan78xx
[    6.431160] usbcore: registered new interface driver smsc95xx
[    6.434470] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    6.437182] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus =
number 1
[   16.439927] xhci_hcd 0000:01:00.0: can't setup: -110
[   16.442611] xhci_hcd 0000:01:00.0: USB bus 1 deregistered
[   16.445296] xhci_hcd 0000:01:00.0: init 0000:01:00.0 fail, -110
[   16.447938] xhci_hcd: probe of 0000:01:00.0 failed with error -110
[   16.476657] xhci-hcd fe9c0000.xhci: xHCI Host Controller
[   16.479403] xhci-hcd fe9c0000.xhci: new USB bus registered, assigned bus=
 number 1
[   16.482477] xhci-hcd fe9c0000.xhci: hcc params 0x0220fe65 hci version 0x=
110 quirks 0x0000000000010010
[   16.485318] xhci-hcd fe9c0000.xhci: irq 60, io mem 0xfe9c0000
[   16.488253] xhci-hcd fe9c0000.xhci: xHCI Host Controller
[   16.490882] xhci-hcd fe9c0000.xhci: new USB bus registered, assigned bus=
 number 2
[   16.493588] xhci-hcd fe9c0000.xhci: Host supports USB 3.0 SuperSpeed
[   16.496643] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.15
[   16.499387] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   16.502112] usb usb1: Product: xHCI Host Controller
[   16.504795] usb usb1: Manufacturer: Linux 5.15.84-v8+ xhci-hcd
[   16.507470] usb usb1: SerialNumber: fe9c0000.xhci
[   16.510874] hub 1-0:1.0: USB hub found
[   16.513639] hub 1-0:1.0: 1 port detected
[   16.516948] usb usb2: We don't know the algorithms for LPM for this host=
, disabling LPM.
[   16.519964] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.15
[   16.522732] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   16.525424] usb usb2: Product: xHCI Host Controller
[   16.528124] usb usb2: Manufacturer: Linux 5.15.84-v8+ xhci-hcd
[   16.530826] usb usb2: SerialNumber: fe9c0000.xhci
[   16.534135] hub 2-0:1.0: USB hub found
[   16.536843] hub 2-0:1.0: config failed, hub doesn't have any ports! (err=
 -19)
[   16.540215] dwc_otg: version 3.00a 10-AUG-2012 (platform bus)
[   16.543346] dwc_otg: FIQ enabled
[   16.543358] dwc_otg: NAK holdoff enabled
[   16.543367] dwc_otg: FIQ split-transaction FSM enabled
[   16.543381] Module dwc_common_port init
[   16.543991] usbcore: registered new interface driver uas
[   16.546859] usbcore: registered new interface driver usb-storage
[   16.549814] mousedev: PS/2 mouse device common for all mice
[   16.557943] sdhci: Secure Digital Host Controller Interface driver
[   16.560691] sdhci: Copyright(c) Pierre Ossman
[   16.564066] sdhci-pltfm: SDHCI platform and OF driver helper
[   16.570498] ledtrig-cpu: registered to indicate activity on CPUs
[   16.573830] hid: raw HID events driver (C) Jiri Kosina
[   16.576692] usbcore: registered new interface driver usbhid
[   16.579387] usbhid: USB HID core driver
[   16.582406] ashmem: initialized
[   16.594310] NET: Registered PF_PACKET protocol family
[   16.597253] Key type dns_resolver registered
[   16.601363] registered taskstats version 1
[   16.604033] Loading compiled-in X.509 certificates
[   16.607327] Key type .fscrypt registered
[   16.610011] Key type fscrypt-provisioning registered
[   16.624033] uart-pl011 fe201000.serial: there is not valid maps for stat=
e default
[   16.627121] uart-pl011 fe201000.serial: cts_event_workaround enabled
[   16.629994] fe201000.serial: ttyAMA0 at MMIO 0xfe201000 (irq =3D 19, bas=
e_baud =3D 0) is a PL011 rev2
[   16.644203] bcm2835-wdt bcm2835-wdt: Broadcom BCM2835 watchdog timer
[   16.647525] bcm2835-power bcm2835-power: Broadcom BCM2835 power domains =
driver
[   16.651495] mmc-bcm2835 fe300000.mmcnr: mmc_debug:0 mmc_debug2:0
[   16.654242] mmc-bcm2835 fe300000.mmcnr: DMA channel allocated
[   16.688803] of_cfs_init
[   16.691670] of_cfs_init: OK
[   16.722560] mmc0: SDHCI controller on fe340000.mmc [fe340000.mmc] using =
ADMA
[   16.725724] Waiting for root device PARTUUID=3D2633f715-02...
[   16.769309] usb 1-1: new high-speed USB device number 2 using xhci-hcd
[   16.796903] mmc0: new DDR MMC card at address 0001
[   16.800837] mmcblk0: mmc0:0001 BJTD4R 29.1 GiB=20
[   16.809033]  mmcblk0: p1 p2
[   16.812442] mmcblk0: mmc0:0001 BJTD4R 29.1 GiB
[   16.815836] mmcblk0boot0: mmc0:0001 BJTD4R 4.00 MiB=20
[   16.821551] mmcblk0boot1: mmc0:0001 BJTD4R 4.00 MiB=20
[   16.826723] mmcblk0rpmb: mmc0:0001 BJTD4R 4.00 MiB, chardev (242:0)
[   16.846435] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mo=
de. Opts: (null). Quota mode: none.
[   16.849554] VFS: Mounted root (ext4 filesystem) readonly on device 179:2.
[   16.856110] devtmpfs: mounted
[   16.867885] Freeing unused kernel memory: 3776K
[   16.871018] Run /sbin/init as init process
[   16.873799]   with arguments:
[   16.873812]     /sbin/init
[   16.873824]   with environment:
[   16.873834]     HOME=3D/
[   16.873844]     TERM=3Dlinux
[   16.917625] usb 1-1: New USB device found, idVendor=3D0424, idProduct=3D=
2514, bcdDevice=3D b.b3
[   16.920517] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[   16.976801] hub 1-1:1.0: USB hub found
[   16.979955] hub 1-1:1.0: 4 ports detected
[   17.115025] systemd[1]: System time before build time, advancing clock.
[   17.281006] NET: Registered PF_INET6 protocol family
[   17.285955] Segment Routing with IPv6
[   17.288759] In-situ OAM (IOAM) with IPv6
[   17.347801] systemd[1]: systemd 247.3-7+deb11u1 running in system mode. =
(+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP =
+GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -=
IDN +PCRE2 default-hierarchy=3Dunified)
[   17.355107] systemd[1]: Detected architecture arm64.
[   17.372826] systemd[1]: Set hostname to <raspberrypi>.
[   18.007461] systemd[1]: Queued start job for default target Multi-User S=
ystem.
[   18.015245] systemd[1]: Created slice system-getty.slice.
[   18.023361] systemd[1]: Created slice system-modprobe.slice.
[   18.031070] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   18.038628] systemd[1]: Created slice User and Session Slice.
[   18.045695] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[   18.052794] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[   18.060646] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[   18.067819] systemd[1]: Reached target Local Encrypted Volumes.
[   18.074931] systemd[1]: Reached target Paths.
[   18.081989] systemd[1]: Reached target Slices.
[   18.088999] systemd[1]: Reached target Swap.
[   18.098874] systemd[1]: Listening on Syslog Socket.
[   18.107183] systemd[1]: Listening on fsck to fsckd communication Socket.
[   18.114639] systemd[1]: Listening on initctl Compatibility Named Pipe.
[   18.123004] systemd[1]: Listening on Journal Audit Socket.
[   18.130947] systemd[1]: Listening on Journal Socket (/dev/log).
[   18.139130] systemd[1]: Listening on Journal Socket.
[   18.150293] systemd[1]: Listening on udev Control Socket.
[   18.158768] systemd[1]: Listening on udev Kernel Socket.
[   18.167005] systemd[1]: Condition check resulted in Huge Pages File Syst=
em being skipped.
[   18.174867] systemd[1]: Mounting POSIX Message Queue File System...
[   18.188259] systemd[1]: Mounting RPC Pipe File System...
[   18.203433] systemd[1]: Mounting Kernel Debug File System...
[   18.216228] systemd[1]: Mounting Kernel Trace File System...
[   18.224478] systemd[1]: Condition check resulted in Kernel Module suppor=
ting RPCSEC_GSS being skipped.
[   18.233963] systemd[1]: Starting Restore / save the current clock...
[   18.247761] systemd[1]: Starting Set the console keyboard layout...
[   18.263157] systemd[1]: Starting Create list of static device nodes for =
the current kernel...
[   18.277612] systemd[1]: Starting Load Kernel Module configfs...
[   18.292076] systemd[1]: Starting Load Kernel Module drm...
[   18.310158] systemd[1]: Starting Load Kernel Module fuse...
[   18.322455] systemd[1]: Condition check resulted in Set Up Additional Bi=
nary Formats being skipped.
[   18.332214] systemd[1]: Starting File System Check on Root Device...
[   18.351258] systemd[1]: Starting Journal Service...
[   18.366322] fuse: init (API version 7.34)
[   18.370518] systemd[1]: Starting Load Kernel Modules...
[   18.386246] systemd[1]: Starting Coldplug All udev Devices...
[   18.429542] systemd[1]: Mounted POSIX Message Queue File System.
[   18.445993] systemd[1]: Mounted RPC Pipe File System.
[   18.472913] systemd[1]: Mounted Kernel Debug File System.
[   18.480740] systemd[1]: Mounted Kernel Trace File System.
[   18.495347] systemd[1]: Finished Restore / save the current clock.
[   18.526563] systemd[1]: Finished Create list of static device nodes for =
the current kernel.
[   18.537341] systemd[1]: modprobe@configfs.service: Succeeded.
[   18.542775] systemd[1]: Finished Load Kernel Module configfs.
[   18.552696] systemd[1]: modprobe@drm.service: Succeeded.
[   18.558659] systemd[1]: Finished Load Kernel Module drm.
[   18.568541] systemd[1]: modprobe@fuse.service: Succeeded.
[   18.573880] systemd[1]: Finished Load Kernel Module fuse.
[   18.583801] systemd[1]: Finished File System Check on Root Device.
[   18.594209] systemd[1]: Finished Load Kernel Modules.
[   18.614455] systemd[1]: Mounting FUSE Control File System...
[   18.627736] systemd[1]: Mounting Kernel Configuration File System...
[   18.642651] systemd[1]: Started File System Check Daemon to report statu=
s.
[   18.665986] systemd[1]: Starting Remount Root and Kernel File Systems...
[   18.678575] systemd[1]: Starting Apply Kernel Variables...
[   18.693594] systemd[1]: Mounted FUSE Control File System.
[   18.717867] systemd[1]: Mounted Kernel Configuration File System.
[   18.737925] systemd[1]: Started Journal Service.
[   18.843553] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null). Quota mode: n=
one.
[   18.900078] systemd-journald[146]: Received client request to flush runt=
ime journal.
[   18.908223] systemd-journald[146]: File /var/log/journal/5c71b33d54d54b5=
6a83192f2a7dd0c26/system.journal corrupted or uncleanly shut down, renaming=
 and replacing.
[   19.868410] mc: Linux media interface: v0.10
[   20.022952] videodev: Linux video capture interface: v2.00
[   20.085706] vc_sm_cma: module is from the staging directory, the quality=
 is unknown, you have been warned.
[   20.116995] bcm2835_vc_sm_cma_probe: Videocore shared memory driver
[   20.117044] [vc_sm_connected_init]: start
[   20.126068] [vc_sm_connected_init]: installed successfully
[   20.165594] snd_bcm2835: module is from the staging directory, the quali=
ty is unknown, you have been warned.
[   20.178502] bcm2835_audio bcm2835_audio: there is not valid maps for sta=
te default
[   20.222178] bcm2835_mmal_vchiq: module is from the staging directory, th=
e quality is unknown, you have been warned.
[   20.231807] bcm2835_mmal_vchiq: module is from the staging directory, th=
e quality is unknown, you have been warned.
[   20.236649] brcmstb-i2c fef04500.i2c:  @97500hz registered in polling mo=
de
[   20.237863] brcmstb-i2c fef09500.i2c:  @97500hz registered in polling mo=
de
[   20.238268] bcm2835_v4l2: module is from the staging directory, the qual=
ity is unknown, you have been warned.
[   20.251942] bcm2835_isp: module is from the staging directory, the quali=
ty is unknown, you have been warned.
[   20.269008] bcm2835-isp bcm2835-isp: Device node output[0] registered as=
 /dev/video13
[   20.270311] bcm2835-isp bcm2835-isp: Device node capture[0] registered a=
s /dev/video14
[   20.296440] bcm2835-isp bcm2835-isp: Device node capture[1] registered a=
s /dev/video15
[   20.333534] rpivid_hevc: module is from the staging directory, the quali=
ty is unknown, you have been warned.
[   20.339814] bcm2835_codec: module is from the staging directory, the qua=
lity is unknown, you have been warned.
[   20.371042] rpivid feb10000.codec: Device registered as /dev/video19
[   20.383685] bcm2835-isp bcm2835-isp: Device node stats[2] registered as =
/dev/video16
[   20.383742] bcm2835-isp bcm2835-isp: Register output node 0 with media c=
ontroller
[   20.383765] bcm2835-isp bcm2835-isp: Register capture node 1 with media =
controller
[   20.383784] bcm2835-isp bcm2835-isp: Register capture node 2 with media =
controller
[   20.383826] bcm2835-isp bcm2835-isp: Register capture node 3 with media =
controller
[   20.425869] bcm2835-isp bcm2835-isp: Device node output[0] registered as=
 /dev/video20
[   20.426721] bcm2835-isp bcm2835-isp: Device node capture[0] registered a=
s /dev/video21
[   20.427593] bcm2835-isp bcm2835-isp: Device node capture[1] registered a=
s /dev/video22
[   20.427623] bcm2835-codec bcm2835-codec: Device registered as /dev/video=
10
[   20.427682] bcm2835-codec bcm2835-codec: Loaded V4L2 decode
[   20.435536] bcm2835-isp bcm2835-isp: Device node stats[2] registered as =
/dev/video23
[   20.435595] bcm2835-isp bcm2835-isp: Register output node 0 with media c=
ontroller
[   20.435638] bcm2835-isp bcm2835-isp: Register capture node 1 with media =
controller
[   20.435657] bcm2835-isp bcm2835-isp: Register capture node 2 with media =
controller
[   20.435674] bcm2835-isp bcm2835-isp: Register capture node 3 with media =
controller
[   20.436031] bcm2835-isp bcm2835-isp: Loaded V4L2 bcm2835-isp
[   20.555668] bcm2835-codec bcm2835-codec: Device registered as /dev/video=
11
[   20.558412] bcm2835-codec bcm2835-codec: Loaded V4L2 encode
[   20.572482] bcm2835-codec bcm2835-codec: Device registered as /dev/video=
12
[   20.572563] bcm2835-codec bcm2835-codec: Loaded V4L2 isp
[   20.609906] bcm2835-codec bcm2835-codec: Device registered as /dev/video=
18
[   20.609978] bcm2835-codec bcm2835-codec: Loaded V4L2 image_fx
[   20.617966] bcm2835-codec bcm2835-codec: Device registered as /dev/video=
31
[   20.618066] bcm2835-codec bcm2835-codec: Loaded V4L2 encode_image
[   20.700103] [drm] Initialized v3d 1.0.0 20180419 for fec00000.v3d on min=
or 0
[   21.480722] checking generic (3e3cf000 7f8000) vs hw (0 ffffffffffffffff)
[   21.480772] fb0: switching to vc4 from simple
[   21.490606] Console: switching to colour dummy device 80x25
[   21.538621] vc4-drm gpu: bound fe400000.hvs (ops vc4_hvs_ops [vc4])
[   21.541009] Registered IR keymap rc-cec
[   21.541283] rc rc0: vc4 as /devices/platform/soc/fef00700.hdmi/rc/rc0
[   21.541508] input: vc4 as /devices/platform/soc/fef00700.hdmi/rc/rc0/inp=
ut0
[   21.549809] vc4-drm gpu: bound fef00700.hdmi (ops vc4_hdmi_ops [vc4])
[   21.560367] Registered IR keymap rc-cec
[   21.560599] rc rc1: vc4 as /devices/platform/soc/fef05700.hdmi/rc/rc1
[   21.560831] input: vc4 as /devices/platform/soc/fef05700.hdmi/rc/rc1/inp=
ut1
[   21.567421] vc4-drm gpu: bound fef05700.hdmi (ops vc4_hdmi_ops [vc4])
[   21.567959] vc4-drm gpu: bound fe004000.txp (ops vc4_txp_ops [vc4])
[   21.568349] vc4-drm gpu: bound fe206000.pixelvalve (ops vc4_crtc_ops [vc=
4])
[   21.568694] vc4-drm gpu: bound fe207000.pixelvalve (ops vc4_crtc_ops [vc=
4])
[   21.569042] vc4-drm gpu: bound fe20a000.pixelvalve (ops vc4_crtc_ops [vc=
4])
[   21.569502] vc4-drm gpu: bound fe216000.pixelvalve (ops vc4_crtc_ops [vc=
4])
[   21.569876] vc4-drm gpu: bound fec12000.pixelvalve (ops vc4_crtc_ops [vc=
4])
[   21.586325] [drm] Initialized vc4 0.0.0 20140616 for gpu on minor 1
[   21.683816] Console: switching to colour frame buffer device 240x67
[   21.712387] vc4-drm gpu: [drm] fb0: vc4drmfb frame buffer device
[   22.009917] 8021q: 802.1Q VLAN Support v1.8
[   22.086183] uart-pl011 fe201000.serial: no DMA platform data
[   22.096980] Adding 102396k swap on /var/swap.  Priority:-2 extents:1 acr=
oss:102396k SSFS
[   22.360820] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[   22.389520] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   22.397905] cfg80211: loaded regulatory.db is malformed or signature is =
missing/invalid
[   22.488754] bcmgenet fd580000.ethernet: configuring instance for externa=
l RGMII (RX delay)
[   22.490537] bcmgenet fd580000.ethernet eth0: Link is Down
[   26.589395] bcmgenet fd580000.ethernet eth0: Link is Up - 1Gbps/Full - f=
low control rx/tx
[   26.589433] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

--qxcrms5uunjosgsi--

--gkufxfnhq527jljh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmQ5fPMACgkQ/5FK8MKz
VSDsZRAAtLzBGzlX9/Bqz7wX+ehGGKxckmNTskURYn+KokE0pO4ynvy06Oy6MYLd
jrPvz8aZ4dFIBbIvBvkyIwaEWNN3ourg5oatqZ+tT3M0HvT7gDOYZwtjBjYU7Vyr
Sh+H0tEZ0zo28xZ4s5z0XoJ9T6Z0LiRkXG7XT+CbCEK9pkOo0quEUebiXcJ5iE87
gW1l9BkqnRijB7TRvOTBsccdcHi4gGq2LzBARS2IGJwbFcAjUNFrJ2TSiuJJpcYF
WamFCeFgIQpLOfXnds/PJJSIVEgGtt5FNZdAcBNiaDTiaAagHbg7QEwwvVa2OjzY
xDsstMofy1X3vYQ1PQL8OS/vqfPidh1gVpU2tsRAEzSgwJAxdmO/uOC7hwBnbyC4
LA5qDbm5J2RJEcT9SK8fz8kTEbp1XigjkMxBpu2Xk5uwrb1KuLuH+1OIOL8BsUvO
ak4EqmonLbQQjgYWo9/3MtL8KYViERzljdS6pgCiUkA0OsptgNbqGZ+1TR1t+qo+
oyagRfYZOYmWcM08HNZQayyFpP561bXIxqE/AShGJoDDTkChhmB7sFrHeT3vaG9x
S/a+kHRnIqmVUW1KIxdzJbdOzZLd2Ew5dsWff5raqxr+e8ZMPtzsIsLkdBy4oaL/
n14uZXSi+pQEXRMzqrLs5UzDdufNPtTnzcd/lJ9TjaIG+yilPgk=
=SVqb
-----END PGP SIGNATURE-----

--gkufxfnhq527jljh--
