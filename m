Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF75947A77A
	for <lists+linux-pci@lfdr.de>; Mon, 20 Dec 2021 10:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhLTJyy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Dec 2021 04:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhLTJyx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Dec 2021 04:54:53 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D81BC061574
        for <linux-pci@vger.kernel.org>; Mon, 20 Dec 2021 01:54:53 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id v138so27005827ybb.8
        for <linux-pci@vger.kernel.org>; Mon, 20 Dec 2021 01:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DOEffxDiMPiZsrxjI4BpP5OXuT1IUxxWnfr4s9Dkx+o=;
        b=fPsxKdpLk0KmPCBhXzk0Qtp1Dj0dpn1Q14V17QgxdoiVAmO6QRby+aeM+VV0Wt/r/e
         4LfnAMDSdo1Y0pt/RcrAHNoQWS71KuyCAaxYRJMbr3qyMrd9lDP1XOhuYx/HykTR/Uwu
         rZ22NCw3aL0u3DBsZMN+4+IQhWPfTiGZj55qASQmz3Mck3ni4L3Ckzghk5kluuAIwU2G
         Q19Z6hcFC6haMh8Q8SosNldN1zf2XnBpr7dXZ1HbFzoIHcMjkkau+6wBze448qVJoLcv
         QY/wjfD921nmO0ygzvQKAyGyDEUkfC4bVkMiA0uKcBkH0tuj9kRQgLqXTdnGRq/eGh8t
         cZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DOEffxDiMPiZsrxjI4BpP5OXuT1IUxxWnfr4s9Dkx+o=;
        b=Si/7J/MD64A0WwE6pth91IEACT9CjarLRrFIoV7EB9wgKYiqabShCBSjyr75rTeivn
         MDKw2WsgSQ3YtzLVcV9y7gm79n+Nbnffdw5rSzElEy0vB4mCW3VCX6Yeqa2fyzyGwW36
         EF8RUyvwPfwm/w+Aye9lwm/u7RTrj84ZtdCbctIJzYzcN4n6lZYJDWAfguXHBaWJZBbL
         SbamB8JMH6cBTgXMj3NC23qD8cTiITK29Buzpjp0M+ab0XAtaiyNK62kp2jkB+Xf4+d0
         6QwIL9xrjz6QDrIu0KCyKsJKdEjBLvSpidjsgF1EylQRTgTVTPgqaywJPR5BbHMbkVsA
         b0Kw==
X-Gm-Message-State: AOAM531DbELwG0QRIo+igHfQdNZwo6/VHDySwuj1VdUwL7bys8zEv4PF
        R5xDUR5TcV+FayJDj0V9kPl7Yv3VLlwFJZ3f6FshOY7boi5xtQ==
X-Google-Smtp-Source: ABdhPJyUE10RPFvuUSmkQrnrlwpgUmOJ+X2l+vtOi3Wbw61xtukD8QUmv5O7h9+J8qlifYx75J3gMyWwsQk4yXFx6qA=
X-Received: by 2002:a25:db0c:: with SMTP id g12mr21017924ybf.684.1639994091435;
 Mon, 20 Dec 2021 01:54:51 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 20 Dec 2021 15:24:40 +0530
Message-ID: <CA+G9fYtyCY2m+C+Ee+eoehGjtfo+8-vcj3qgcmNh73hrKkaHXA@mail.gmail.com>
Subject: [next] arm64: juno-r2: BUG: KASAN: use-after-free in __pci_enable_msi_range
To:     PCI <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Jason Gunthorpe <jgg@nvidia.com>, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

While booting Linux next 20211215 and next 20211217 on arm64 juno-r2 device
the following kernel crash reported and several LTP syscalls test cases,

Only noticed on juno-r2 whereas dragonboard-410c and hikey-hi6220 tests pass.

Test case failure:
add_key05.c:207: TBROK: Failed to open FILE
'/proc/sys/kernel/keys/gc_delay' for writing: ENOENT (2)
tst_taint.c:15: TBROK: Failed to open FILE '/proc/sys/kernel/tainted'
for reading: ENOENT (2)
tst_pid.c:43: TBROK: Failed to open FILE '/proc/sys/kernel/pid_max'
for reading: ENOENT (2)

arm64 juno-r2 kernel crash log while booting.

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000100 [0x410fd033]
[    0.000000] Linux version 5.16.0-rc5-next-20211217
(tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0, GNU
ld (GNU Binutils for Debian) 2.37) #1 SMP PREEMPT @1639749733
[    0.000000] Machine model: ARM Juno development board (r2)
<trim>
[    2.191774] hw perfevents: enabled with armv8_cortex_a72 PMU
driver, 7 counters available
[    2.201822] sysctl duplicate entry: /kernel//perf_user_access
[    2.207718] CPU: 2 PID: 1 Comm: swapper/0 Not tainted
5.16.0-rc5-next-20211217 #1
[    2.215235] Hardware name: ARM Juno development board (r2) (DT)
[    2.221175] Call trace:
[    2.223629]  dump_backtrace+0x228/0x240
[    2.227493]  show_stack+0x24/0x80
[    2.230827]  dump_stack_lvl+0x8c/0xb8
[    2.234515]  dump_stack+0x1c/0x38
[    2.237851]  __register_sysctl_table+0x520/0xa30
[    2.242499]  register_sysctl+0x2c/0x40
[    2.246273]  armv8_a53_pmu_init+0x21c/0x264
[    2.250481]  arm_pmu_device_probe+0x254/0x6e0
[    2.254867]  armv8_pmu_device_probe+0x28/0x34
[    2.259248]  platform_probe+0x98/0x120
[    2.263018]  really_probe+0x11c/0x684
[    2.266705]  __driver_probe_device+0x194/0x22c
[    2.271177]  driver_probe_device+0x68/0x150
[    2.275386]  __driver_attach+0x124/0x260
[    2.279335]  bus_for_each_dev+0xf0/0x160
[    2.283281]  driver_attach+0x40/0x50
[    2.286880]  bus_add_driver+0x20c/0x300
[    2.290739]  driver_register+0xf8/0x21c
[    2.294601]  __platform_driver_register+0x50/0x60
[    2.299328]  armv8_pmu_driver_init+0x40/0x60
[    2.303623]  do_one_initcall+0xa8/0x3ec
[    2.307480]  kernel_init_freeable+0x300/0x388
[    2.311864]  kernel_init+0x30/0x15c
[    2.315374]  ret_from_fork+0x10/0x20
[    2.320928] hw perfevents: enabled with armv8_cortex_a53 PMU
driver, 7 counters available
[    2.329472] kvm [1]: IPA Size Limit: 40 bits
[    2.342423] kvm [1]: vgic interrupt IRQ9
[    2.347393] kvm [1]: Hyp mode initialized successfully
[    2.362544] Initialise system trusted keyrings
[    2.368278] workingset: timestamp_bits=42 max_order=21 bucket_order=0
[    2.428029] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    2.439945] NFS: Registering the id_resolver key type
[    2.445176] Key type id_resolver registered
[    2.449411] Key type id_legacy registered
[    2.454010] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    2.460773] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver
Registering...
[    2.469105] 9p: Installing v9fs 9p2000 file system support
[    2.515228] NET: Registered PF_ALG protocol family
[    2.520108] Key type asymmetric registered
[    2.524277] Asymmetric key parser 'x509' registered
[    2.529923] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 244)
[    2.537382] io scheduler mq-deadline registered
[    2.541964] io scheduler kyber registered
[    2.631942] pl061_gpio 1c1d0000.gpio: PL061 GPIO chip registered
[    2.653688] pci-host-generic 40000000.pcie: host bridge
/pcie@40000000 ranges:
[    2.661162] pci-host-generic 40000000.pcie:       IO
0x005f800000..0x005fffffff -> 0x0000000000
[    2.670092] pci-host-generic 40000000.pcie:      MEM
0x0050000000..0x0057ffffff -> 0x0050000000
[    2.678953] pci-host-generic 40000000.pcie:      MEM
0x4000000000..0x40ffffffff -> 0x4000000000
[    2.687901] pci-host-generic 40000000.pcie:   IB MEM
0x002c1c0000..0x002c1fffff -> 0x002c1c0000
[    2.696819] pci-host-generic 40000000.pcie:   IB MEM
0x0080000000..0x00ffffffff -> 0x0080000000
[    2.705670] pci-host-generic 40000000.pcie:   IB MEM
0x0800000000..0x09ffffffff -> 0x0800000000
[    2.793723] pci-host-generic 40000000.pcie: ECAM at [mem
0x40000000-0x4fffffff] for [bus 00-ff]
[    2.803466] pci-host-generic 40000000.pcie: PCI host bridge to bus 0000:00
[    2.810427] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.816008] pci_bus 0000:00: root bus resource [io  0x0000-0x7fffff]
[    2.822435] pci_bus 0000:00: root bus resource [mem 0x50000000-0x57ffffff]
[    2.829384] pci_bus 0000:00: root bus resource [mem
0x4000000000-0x40ffffffff pref]
[    2.837252] pci 0000:00:00.0: [1556:1100] type 01 class 0x060400
[    2.843508] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00003fff
64bit pref]
[    2.851351] pci 0000:00:00.0: supports D1 D2
[    2.855676] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    2.868561] pci 0000:00:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    2.877468] pci 0000:01:00.0: [111d:8090] type 01 class 0x060400
[    2.883811] pci 0000:01:00.0: enabling Extended Tags
[    2.889300] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    2.912035] pci 0000:01:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    2.921096] pci 0000:02:01.0: [111d:8090] type 01 class 0x060400
[    2.927464] pci 0000:02:01.0: enabling Extended Tags
[    2.933019] pci 0000:02:01.0: PME# supported from D0 D3hot D3cold
[    2.940888] pci 0000:02:02.0: [111d:8090] type 01 class 0x060400
[    2.947239] pci 0000:02:02.0: enabling Extended Tags
[    2.952800] pci 0000:02:02.0: PME# supported from D0 D3hot D3cold
[    2.960528] pci 0000:02:03.0: [111d:8090] type 01 class 0x060400
[    2.966878] pci 0000:02:03.0: enabling Extended Tags
[    2.972510] pci 0000:02:03.0: PME# supported from D0 D3hot D3cold
[    2.981398] pci 0000:02:0c.0: [111d:8090] type 01 class 0x060400
[    2.987748] pci 0000:02:0c.0: enabling Extended Tags
[    2.993290] pci 0000:02:0c.0: PME# supported from D0 D3hot D3cold
[    3.001459] pci 0000:02:10.0: [111d:8090] type 01 class 0x060400
[    3.007800] pci 0000:02:10.0: enabling Extended Tags
[    3.013328] pci 0000:02:10.0: PME# supported from D0 D3hot D3cold
[    3.023092] pci 0000:02:1f.0: [111d:8090] type 01 class 0x060400
[    3.029441] pci 0000:02:1f.0: enabling Extended Tags
[    3.035006] pci 0000:02:1f.0: PME# supported from D0 D3hot D3cold
[    3.042616] pci 0000:02:01.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    3.050758] pci 0000:02:02.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    3.058875] pci 0000:02:03.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    3.066990] pci 0000:02:0c.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    3.075105] pci 0000:02:10.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    3.083220] pci 0000:02:1f.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    3.092250] pci 0000:03:00.0: [1095:3132] type 00 class 0x018000
[    3.098460] pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x0000007f 64bit]
[    3.105387] pci 0000:03:00.0: reg 0x18: [mem 0x00000000-0x00003fff 64bit]
[    3.112282] pci 0000:03:00.0: reg 0x20: [io  0x0000-0x007f]
[    3.117995] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    3.125153] pci 0000:03:00.0: supports D1 D2
[    3.130712] pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe
device.  You can enable it with 'pcie_aspm=force'
[    3.145388] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    3.157318] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    3.169246] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
[    3.181213] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 06
[    3.193081] pci_bus 0000:07: busn_res: [bus 07-ff] end is updated to 07
[    3.200561] pci 0000:08:00.0: [11ab:4380] type 00 class 0x020000
[    3.206755] pci 0000:08:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[    3.213669] pci 0000:08:00.0: reg 0x18: [io  0x0000-0x00ff]
[    3.219884] pci 0000:08:00.0: supports D1 D2
[    3.224209] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.237040] pci_bus 0000:08: busn_res: [bus 08-ff] end is updated to 08
[    3.243744] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 08
[    3.250445] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 08
[    3.257237] pci 0000:00:00.0: BAR 14: assigned [mem 0x50000000-0x501fffff]
[    3.264190] pci 0000:00:00.0: BAR 0: assigned [mem
0x4000000000-0x4000003fff 64bit pref]
[    3.272421] pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x2fff]
[    3.278807] pci 0000:01:00.0: BAR 14: assigned [mem 0x50000000-0x501fffff]
[    3.285768] pci 0000:01:00.0: BAR 13: assigned [io  0x1000-0x2fff]
[    3.292159] pci 0000:02:01.0: BAR 14: assigned [mem 0x50000000-0x500fffff]
[    3.299105] pci 0000:02:1f.0: BAR 14: assigned [mem 0x50100000-0x501fffff]
[    3.306048] pci 0000:02:01.0: BAR 13: assigned [io  0x1000-0x1fff]
[    3.312295] pci 0000:02:1f.0: BAR 13: assigned [io  0x2000-0x2fff]
[    3.318657] pci 0000:03:00.0: BAR 6: assigned [mem
0x50000000-0x5007ffff pref]
[    3.325957] pci 0000:03:00.0: BAR 2: assigned [mem
0x50080000-0x50083fff 64bit]
[    3.333419] pci 0000:03:00.0: BAR 0: assigned [mem
0x50084000-0x5008407f 64bit]
[    3.340857] pci 0000:03:00.0: BAR 4: assigned [io  0x1000-0x107f]
[    3.347089] pci 0000:02:01.0: PCI bridge to [bus 03]
[    3.352118] pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
[    3.358296] pci 0000:02:01.0:   bridge window [mem 0x50000000-0x500fffff]
[    3.365221] pci 0000:02:02.0: PCI bridge to [bus 04]
[    3.370319] pci 0000:02:03.0: PCI bridge to [bus 05]
[    3.375415] pci 0000:02:0c.0: PCI bridge to [bus 06]
[    3.380514] pci 0000:02:10.0: PCI bridge to [bus 07]
[    3.385703] pci 0000:08:00.0: BAR 0: assigned [mem
0x50100000-0x50103fff 64bit]
[    3.393160] pci 0000:08:00.0: BAR 2: assigned [io  0x2000-0x20ff]
[    3.399426] pci 0000:02:1f.0: PCI bridge to [bus 08]
[    3.404456] pci 0000:02:1f.0:   bridge window [io  0x2000-0x2fff]
[    3.410634] pci 0000:02:1f.0:   bridge window [mem 0x50100000-0x501fffff]
[    3.417533] pci 0000:01:00.0: PCI bridge to [bus 02-08]
[    3.422824] pci 0000:01:00.0:   bridge window [io  0x1000-0x2fff]
[    3.429001] pci 0000:01:00.0:   bridge window [mem 0x50000000-0x501fffff]
[    3.435901] pci 0000:00:00.0: PCI bridge to [bus 01-08]
[    3.441190] pci 0000:00:00.0:   bridge window [io  0x1000-0x2fff]
[    3.447362] pci 0000:00:00.0:   bridge window [mem 0x50000000-0x501fffff]
[    3.476228] EINJ: ACPI disabled.
[    3.623896] Serial: 8250/16550 driver, 16 ports, IRQ sharing enabled
[    3.665227] SuperH (H)SCI(F) driver initialized
[    3.673416] msm_serial: driver initialized
[    3.686482] arm-smmu 2b500000.iommu: probing hardware configuration...
[    3.693103] arm-smmu 2b500000.iommu: SMMUv1 with:
[    3.697866] arm-smmu 2b500000.iommu: stage 2 translation
[    3.703321] arm-smmu 2b500000.iommu: coherent table walk
[    3.708856] arm-smmu 2b500000.iommu: stream matching with 32 register groups
[    3.716063] arm-smmu 2b500000.iommu: 4 context banks (4 stage-2 only)
[    3.722660] arm-smmu 2b500000.iommu: Supported page sizes: 0x60211000
[    3.729248] arm-smmu 2b500000.iommu: Stage-2: 40-bit IPA -> 40-bit PA
[    3.739538] arm-smmu 7fb00000.iommu: probing hardware configuration...
[    3.746128] arm-smmu 7fb00000.iommu: SMMUv1 with:
[    3.750887] arm-smmu 7fb00000.iommu: stage 2 translation
[    3.756361] arm-smmu 7fb00000.iommu: coherent table walk
[    3.761824] arm-smmu 7fb00000.iommu: stream matching with 16 register groups
[    3.769028] arm-smmu 7fb00000.iommu: 4 context banks (4 stage-2 only)
[    3.775623] arm-smmu 7fb00000.iommu: Supported page sizes: 0x60211000
[    3.782233] arm-smmu 7fb00000.iommu: Stage-2: 40-bit IPA -> 40-bit PA
[    3.790366] arm-smmu 7fb10000.iommu: probing hardware configuration...
[    3.796958] arm-smmu 7fb10000.iommu: SMMUv1 with:
[    3.801717] arm-smmu 7fb10000.iommu: stage 2 translation
[    3.807170] arm-smmu 7fb10000.iommu: non-coherent table walk
[    3.812972] arm-smmu 7fb10000.iommu: (IDR0.CTTW overridden by FW
configuration)
[    3.820529] arm-smmu 7fb10000.iommu: stream matching with 2 register groups
[    3.827647] arm-smmu 7fb10000.iommu: 1 context banks (1 stage-2 only)
[    3.834326] arm-smmu 7fb10000.iommu: Supported page sizes: 0x60211000
[    3.840917] arm-smmu 7fb10000.iommu: Stage-2: 40-bit IPA -> 40-bit PA
[    3.849014] arm-smmu 7fb20000.iommu: probing hardware configuration...
[    3.855605] arm-smmu 7fb20000.iommu: SMMUv1 with:
[    3.860365] arm-smmu 7fb20000.iommu: stage 2 translation
[    3.865818] arm-smmu 7fb20000.iommu: non-coherent table walk
[    3.871620] arm-smmu 7fb20000.iommu: (IDR0.CTTW overridden by FW
configuration)
[    3.879099] arm-smmu 7fb20000.iommu: stream matching with 2 register groups
[    3.886253] arm-smmu 7fb20000.iommu: 1 context banks (1 stage-2 only)
[    3.892849] arm-smmu 7fb20000.iommu: Supported page sizes: 0x60211000
[    3.899436] arm-smmu 7fb20000.iommu: Stage-2: 40-bit IPA -> 40-bit PA
[    3.907530] arm-smmu 7fb30000.iommu: probing hardware configuration...
[    3.914119] arm-smmu 7fb30000.iommu: SMMUv1 with:
[    3.918878] arm-smmu 7fb30000.iommu: stage 2 translation
[    3.924331] arm-smmu 7fb30000.iommu: coherent table walk
[    3.929792] arm-smmu 7fb30000.iommu: stream matching with 2 register groups
[    3.936908] arm-smmu 7fb30000.iommu: 1 context banks (1 stage-2 only)
[    3.943523] arm-smmu 7fb30000.iommu: Supported page sizes: 0x60211000
[    3.950111] arm-smmu 7fb30000.iommu: Stage-2: 40-bit IPA -> 40-bit PA
[    4.004593] loop: module loaded
[    4.016062] megasas: 07.719.03.00-rc1
[    4.029694] sata_sil24 0000:03:00.0: Adding to iommu group 0
[    4.037159] pci 0000:00:00.0: enabling device (0000 -> 0003)
[    4.042945] pci 0000:01:00.0: enabling device (0000 -> 0003)
[    4.048726] pci 0000:02:01.0: enabling device (0000 -> 0003)
[    4.054489] sata_sil24 0000:03:00.0: enabling device (0000 -> 0003)
[    4.069542] scsi host0: sata_sil24
[    4.077595] scsi host1: sata_sil24
[    4.082454] ata1: SATA max UDMA/100 host m128@0x50084000 port
0x50080000 irq 53
[    4.089834] ata2: SATA max UDMA/100 host m128@0x50084000 port
0x50082000 irq 53
[    4.127375] libphy: Fixed MDIO Bus: probed
[    4.147584] thunder_xcv, ver 1.0
[    4.151216] thunder_bgx, ver 1.0
[    4.154892] nicpf, ver 1.0
[    4.167502] hclge is initializing
[    4.170980] hns3: Hisilicon Ethernet Network Driver for Hip08
Family - version
[    4.178262] hns3: Copyright (c) 2017 Huawei Corporation.
[    4.184055] e1000: Intel(R) PRO/1000 Network Driver
[    4.188985] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    4.195196] e1000e: Intel(R) PRO/1000 Network Driver
[    4.200212] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    4.206602] igb: Intel(R) Gigabit Ethernet Network Driver
[    4.212079] igb: Copyright (c) 2007-2014 Intel Corporation.
[    4.218093] igbvf: Intel(R) Gigabit Virtual Function Network Driver
[    4.224416] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    4.232850] sky2: driver version 1.30
[    4.238276] sky2 0000:08:00.0: Adding to iommu group 0
[    4.244144] pci 0000:02:1f.0: enabling device (0000 -> 0003)
[    4.249918] sky2 0000:08:00.0: enabling device (0000 -> 0003)
[    4.256092] sky2 0000:08:00.0: Yukon-2 UL 2 chip revision 0
[    4.261855] sky2 0000:08:00.0: Invalid MAC address, defaulting to random
[    4.272572] sky2 0000:08:00.0 eth0: addr ba:6d:65:73:db:e5
[    4.278606] QLogic FastLinQ 4xxxx Core Module qed
[    4.283375] qede init: QLogic FastLinQ 4xxxx Ethernet Driver qede
[    4.326539] libphy: smsc911x-mdio: probed
[    4.333293] smsc911x 18000000.ethernet eth1: MAC Address: 00:02:f7:00:66:df
[    4.344531] usbcore: registered new interface driver asix
[    4.350213] usbcore: registered new interface driver ax88179_178a
[    4.357666] VFIO - User Level meta-driver version: 0.3
[    4.376743] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.383410] ehci-pci: EHCI PCI platform driver
[    4.388190] ehci-platform: EHCI generic platform driver
[    4.395070] ehci-platform 7ffc0000.usb: Adding to iommu group 1
[    4.402738] ehci-platform 7ffc0000.usb: EHCI Host Controller
[    4.408554] ehci-platform 7ffc0000.usb: new USB bus registered,
assigned bus number 1
[    4.417545] ehci-platform 7ffc0000.usb: irq 44, io mem 0x7ffc0000
[    4.439375] ehci-platform 7ffc0000.usb: USB 2.0 started, EHCI 1.00
[    4.451188] hub 1-0:1.0: USB hub found
[    4.455356] hub 1-0:1.0: 1 port detected
[    4.462281] ehci-orion: EHCI orion driver
[    4.467189] ehci-exynos: EHCI Exynos driver
[    4.472157] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    4.478454] ohci-pci: OHCI PCI platform driver
[    4.483333] ohci-platform: OHCI generic platform driver
[    4.490060] ohci-platform 7ffb0000.usb: Adding to iommu group 1
[    4.496683] ohci-platform 7ffb0000.usb: Generic Platform OHCI controller
[    4.503532] ohci-platform 7ffb0000.usb: new USB bus registered,
assigned bus number 2
[    4.512246] ohci-platform 7ffb0000.usb: irq 43, io mem 0x7ffb0000
[    4.600271] hub 2-0:1.0: USB hub found
[    4.604395] hub 2-0:1.0: 1 port detected
[    4.611427] ohci-exynos: OHCI Exynos driver
[    4.619443] usbcore: registered new interface driver usb-storage
[    4.649441] rtc-pl031 1c170000.rtc: registered as rtc0
[    4.654710] rtc-pl031 1c170000.rtc: setting system clock to
2021-12-18T15:25:29 UTC (1639841129)
[    4.668155] i2c_dev: i2c /dev entries driver
[    4.705169] sp805-wdt 1c0f0000.watchdog: registration successful
[    4.715487] usb 1-1: new high-speed USB device number 2 using ehci-platform
[    4.739832] mmci-pl18x 1c050000.mmc: mmc0: PL180 manf 41 rev0 at
0x1c050000 irq 17,0 (pio)
[    4.775015] sdhci: Secure Digital Host Controller Interface driver
[    4.781367] sdhci: Copyright(c) Pierre Ossman
[    4.791511] Synopsys Designware Multimedia Card Interface Driver
[    4.805011] sdhci-pltfm: SDHCI platform and OF driver helper
[    4.822209] leds-syscon 1c010008.0.led: registered LED (null)
[    4.829674] leds-syscon 1c010008.1.led: registered LED (null)
[    4.836726] leds-syscon 1c010008.2.led: registered LED (null)
[    4.843752] leds-syscon 1c010008.3.led: registered LED (null)
[    4.850854] leds-syscon 1c010008.4.led: registered LED (null)
[    4.858314] leds-syscon 1c010008.5.led: registered LED (null)
[    4.865509] leds-syscon 1c010008.6.led: registered LED (null)
[    4.872520] leds-syscon 1c010008.7.led: registered LED (null)
[    4.882523] ledtrig-cpu: registered to indicate activity on CPUs
[    4.891915] hub 1-1:1.0: USB hub found
[    4.896529] hub 1-1:1.0: 4 ports detected
[    4.906827] usbcore: registered new interface driver usbhid
[    4.912467] usbhid: USB HID core driver
[    4.920845] mhu 2b1f0000.mhu: ARM MHU Mailbox registered
[    4.943934]  cs_system_cfg: CoreSight Configuration manager initialised
[    4.981366] NET: Registered PF_INET6 protocol family
[    4.995703] Segment Routing with IPv6
[    4.999593] In-situ OAM (IOAM) with IPv6
[    5.003834] NET: Registered PF_PACKET protocol family
[    5.009800] 9pnet: Installing 9P2000 support
[    5.014476] Key type dns_resolver registered
[    5.026562] registered taskstats version 1
[    5.030906] Loading compiled-in X.509 certificates
[    5.233983] pcieport 0000:00:00.0: Adding to iommu group 0
[    5.262137] sysfs: cannot create duplicate filename
'/devices/platform/40000000.pcie/pci0000:00/0000:00:00.0/msi_irqs/57'
[    5.273266] CPU: 0 PID: 81 Comm: kworker/u12:4 Not tainted
5.16.0-rc5-next-20211217 #1
[    5.281255] Hardware name: ARM Juno development board (r2) (DT)
[    5.287225] Workqueue: events_unbound deferred_probe_work_func
[    5.293171] Call trace:
[    5.295646]  dump_backtrace+0x228/0x240
[    5.299545]  show_stack+0x24/0x80
[    5.302913]  dump_stack_lvl+0x8c/0xb8
[    5.306650]  dump_stack+0x1c/0x38
[    5.310032]  sysfs_warn_dup+0x7c/0xa0
[    5.313765]  sysfs_add_file_mode_ns+0x1ac/0x1b4
[    5.318369]  sysfs_add_file_to_group+0xf0/0x160
[    5.322972]  __msi_domain_alloc_irqs+0x3f0/0x554
[    5.327662]  msi_domain_alloc_irqs_descs_locked+0x78/0x130
[    5.333225]  pci_msi_setup_msi_irqs+0x58/0x80
[    5.337656]  __pci_enable_msi_range+0x428/0x5f0
[    5.342257]  pci_alloc_irq_vectors_affinity+0x15c/0x1c0
[    5.347559]  pcie_port_device_register+0x1e0/0x564
[    5.352426]  pcie_portdrv_probe+0x5c/0x130
[    5.356593]  local_pci_probe+0x84/0x10c
[    5.360501]  pci_device_probe+0x284/0x300
[    5.364584]  really_probe+0x11c/0x684
[    5.368322]  __driver_probe_device+0x194/0x22c
[    5.372845]  driver_probe_device+0x68/0x150
[    5.377106]  __device_attach_driver+0xf8/0x180
[    5.381631]  bus_for_each_drv+0xf8/0x160
[    5.385625]  __device_attach+0x170/0x294
[    5.389624]  device_initial_probe+0x20/0x30
[    5.393886]  bus_probe_device+0xf4/0x104
[    5.397882]  deferred_probe_work_func+0x108/0x160
[    5.402667]  process_one_work+0x3c8/0x850
[    5.406745]  worker_thread+0x3d8/0x734
[    5.410559]  kthread+0x1fc/0x214
[    5.413861]  ret_from_fork+0x10/0x20
[    5.427632] ==================================================================
[    5.434888] BUG: KASAN: use-after-free in __pci_enable_msi_range+0x208/0x5f0
[    5.441983] Read of size 2 at addr ffff000826404554 by task kworker/u12:4/81
[    5.449059]
[    5.450557] CPU: 1 PID: 81 Comm: kworker/u12:4 Not tainted
5.16.0-rc5-next-20211217 #1
[    5.458507] Hardware name: ARM Juno development board (r2) (DT)
[    5.464446] Workqueue: events_unbound deferred_probe_work_func
[    5.470322] Call trace:
[    5.472776]  dump_backtrace+0x228/0x240
[    5.476635]  show_stack+0x24/0x80
[    5.479967]  dump_stack_lvl+0x8c/0xb8
[    5.483656]  print_address_description.constprop.0+0x74/0x2b8
[    5.489433]  kasan_report+0x1e8/0x250
[    5.493119]  __asan_load2+0x9c/0xc4
[    5.496629]  __pci_enable_msi_range+0x208/0x5f0
[    5.501184]  pci_alloc_irq_vectors_affinity+0x15c/0x1c0
[    5.506438]  pcie_port_device_register+0x1e0/0x564
[    5.511255]  pcie_portdrv_probe+0x5c/0x130
[    5.515376]  local_pci_probe+0x84/0x10c
[    5.519235]  pci_device_probe+0x284/0x300
[    5.523270]  really_probe+0x11c/0x684
[    5.526956]  __driver_probe_device+0x194/0x22c
[    5.531427]  driver_probe_device+0x68/0x150
[    5.535637]  __device_attach_driver+0xf8/0x180
[    5.540108]  bus_for_each_drv+0xf8/0x160
[    5.544054]  __device_attach+0x170/0x294
[    5.548002]  device_initial_probe+0x20/0x30
[    5.552212]  bus_probe_device+0xf4/0x104
[    5.556159]  deferred_probe_work_func+0x108/0x160
[    5.560890]  process_one_work+0x3c8/0x850
[    5.564923]  worker_thread+0x3d8/0x734
[    5.568693]  kthread+0x1fc/0x214
[    5.571944]  ret_from_fork+0x10/0x20
[    5.575543]
[    5.577038] Allocated by task 81:
[    5.580364]  kasan_save_stack+0x2c/0x54
[    5.584223]  __kasan_kmalloc+0xac/0x10c
[    5.588080]  kmem_cache_alloc_trace+0x220/0x3e0
[    5.592633]  msi_add_msi_desc+0x64/0x1a0
[    5.596577]  msi_setup_msi_desc+0x1b8/0x210
[    5.600782]  __pci_enable_msi_range+0x3c8/0x5f0
[    5.605337]  pci_alloc_irq_vectors_affinity+0x15c/0x1c0
[    5.610588]  pcie_port_device_register+0x1e0/0x564
[    5.615405]  pcie_portdrv_probe+0x5c/0x130
[    5.619524]  local_pci_probe+0x84/0x10c
[    5.623382]  pci_device_probe+0x284/0x300
[    5.627415]  really_probe+0x11c/0x684
[    5.631100]  __driver_probe_device+0x194/0x22c
[    5.635571]  driver_probe_device+0x68/0x150
[    5.639779]  __device_attach_driver+0xf8/0x180
[    5.644249]  bus_for_each_drv+0xf8/0x160
[    5.648194]  __device_attach+0x170/0x294
[    5.652141]  device_initial_probe+0x20/0x30
[    5.655485] atkbd serio0: keyboard reset failed on 1c060000.kmi
[    5.656348]  bus_probe_device+0xf4/0x104
[    5.666210]  deferred_probe_work_func+0x108/0x160
[    5.670941]  process_one_work+0x3c8/0x850
[    5.674971]  worker_thread+0x3d8/0x734
[    5.678740]  kthread+0x1fc/0x214
[    5.681991]  ret_from_fork+0x10/0x20
[    5.685586]
[    5.687081] Freed by task 81:
[    5.690058]  kasan_save_stack+0x2c/0x54
[    5.693915]  kasan_set_track+0x2c/0x40
[    5.697684]  kasan_set_free_info+0x28/0x50
[    5.701804]  __kasan_slab_free+0x108/0x15c
[    5.705923]  slab_free_freelist_hook+0xc0/0x220
[    5.710475]  kfree+0xe8/0x3e0
[    5.713459]  msi_free_msi_descs_range+0x12c/0x1a0
[    5.718186]  msi_domain_alloc_irqs_descs_locked+0xf0/0x130
[    5.723700]  pci_msi_setup_msi_irqs+0x58/0x80
[    5.728080]  __pci_enable_msi_range+0x428/0x5f0
[    5.732634]  pci_alloc_irq_vectors_affinity+0x15c/0x1c0
[    5.737885]  pcie_port_device_register+0x1e0/0x564
[    5.742702]  pcie_portdrv_probe+0x5c/0x130
[    5.746821]  local_pci_probe+0x84/0x10c
[    5.750679]  pci_device_probe+0x284/0x300
[    5.754712]  really_probe+0x11c/0x684
[    5.758397]  __driver_probe_device+0x194/0x22c
[    5.762867]  driver_probe_device+0x68/0x150
[    5.767076]  __device_attach_driver+0xf8/0x180
[    5.771545]  bus_for_each_drv+0xf8/0x160
[    5.775491]  __device_attach+0x170/0x294
[    5.779437]  device_initial_probe+0x20/0x30
[    5.783646]  bus_probe_device+0xf4/0x104
[    5.787592]  deferred_probe_work_func+0x108/0x160
[    5.792323]  process_one_work+0x3c8/0x850
[    5.796354]  worker_thread+0x3d8/0x734
[    5.800123]  kthread+0x1fc/0x214
[    5.803373]  ret_from_fork+0x10/0x20
[    5.806968]
[    5.808462] The buggy address belongs to the object at ffff000826404500
[    5.808462]  which belongs to the cache kmalloc-128 of size 128
[    5.821018] The buggy address is located 84 bytes inside of
[    5.821018]  128-byte region [ffff000826404500, ffff000826404580)
[    5.832708] The buggy address belongs to the page:
[    5.837513] page:(____ptrval____) refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x8a6404
[    5.846939] flags: 0xbfffc0000000200(slab|node=0|zone=2|lastcpupid=0xffff)
[    5.853852] raw: 0bfffc0000000200 0000000000000000 dead000000000122
ffff000800002300
[    5.861625] raw: 0000000000000000 0000000000100010 00000001ffffffff
0000000000000000
[    5.869390] page dumped because: kasan: bad access detected
[    5.874978]
[    5.876472] Memory state around the buggy address:
[    5.881279]  ffff000826404400: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00
[    5.888525]  ffff000826404480: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[    5.895771] >ffff000826404500: fa fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    5.903014]                                                  ^
[    5.908866]  ffff000826404580: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[    5.916112]  ffff000826404600: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00
[    5.923356] ==================================================================
[    5.930596] Disabling lock debugging due to kernel taint


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log link,
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211217/testrun/6919678/suite/ltp-syscalls-tests/test/add_key05/log

Test results comparison:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211217/testrun/6919678/suite/ltp-syscalls-tests/test/add_key05/history/


meta data:
-----------
    git describe: next-20211215 and next-20211217
    git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
    git_sha: 93bf6eee76c0e716f6b32de690b1c52991547bb4
    git_short_log: 93bf6eee76c0 (\"Add linux-next specific files for 20211215\")
    target_arch: arm64
    toolchain: gcc-10
    Kconfig: https://builds.tuxbuild.com/22LCvyVwJ8E7fRfLPA2BgPKnWiR/config
    vmlinux: https://builds.tuxbuild.com/22PqZcj0pMjg0qWW8Ilyx0MhKOH/vmlinux.xz
    System.map :
https://builds.tuxbuild.com/22PqZcj0pMjg0qWW8Ilyx0MhKOH/System.map
    build log: https://builds.tuxbuild.com/22LCvyVwJ8E7fRfLPA2BgPKnWiR/


--
Linaro LKFT
https://lkft.linaro.org
