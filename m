Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8CC4A83D0
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 13:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242406AbiBCM0r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 07:26:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35820 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiBCM0r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 07:26:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE3BB61783
        for <linux-pci@vger.kernel.org>; Thu,  3 Feb 2022 12:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06BDC340E4;
        Thu,  3 Feb 2022 12:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643891206;
        bh=MrlxLk566glzVXTPQC5/PCjv0qCR71V7IKm+4uieN0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IIXRfqpbFh+/fPOgbfpTg1nuYKmr75s6CgRtfK8uv5M7RMtzycCvo0hb1AaW5l2lL
         ePk27afqc9lZ9ZnwatkdEOz1NX52q9olR7P714xaA+aytoRLpqN7ZP0l/2FHm0rhxO
         nhIPGJjQAvgeTf52mimgF1i9mCU3eyEHODuUyW96SBgMkiejlMq/+pNn8tG8xbnhH6
         hjbJeM6rgixZLN0GH7IVe+4Wfbljlu8C+uRQH4cm7ylnJdjIHG1uN17oBWMiqh1h4W
         vQHSr5ykSj2+RMoNgkSiEzviUeL4AW+KJ1/1e4E3P/D7WsCCs851AsLW/OHemClbK7
         k+V+Ggt1cujKA==
Received: by pali.im (Postfix)
        id C0F37889; Thu,  3 Feb 2022 13:26:42 +0100 (CET)
Date:   Thu, 3 Feb 2022 13:26:42 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Jan Palus <jpalus@fastmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [Bug 215540] New: mvebu: no pcie devices detected on turris
 omnia (5.16.3 regression)
Message-ID: <20220203122642.o3xlndouz46hewef@pali>
References: <bug-215540-41252@https.bugzilla.kernel.org/>
 <20220127234917.GA150851@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127234917.GA150851@bhelgaas>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

[+ Marek]

On Thursday 27 January 2022 17:49:17 Bjorn Helgaas wrote:
> [+cc Thomas, Pali]
> 
> On Thu, Jan 27, 2022 at 10:52:43PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=215540
> > 
> >             Bug ID: 215540
> >            Summary: mvebu: no pcie devices detected on turris omnia
> >                     (5.16.3 regression)
> >            Product: Drivers
> >            Version: 2.5
> >     Kernel Version: 5.16.3
> >           Hardware: ARM
> >                 OS: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: PCI
> >           Assignee: drivers_pci@kernel-bugs.osdl.org
> >           Reporter: jpalus@fastmail.com
> >         Regression: No
> > 
> > After kernel upgrade from 5.16.1 to 5.16.3 Turris Omnia (Armada 385)
> > no longer detects pcie devices (wifi/msata). Haven't tried 5.16.2
> > but it doesn't seem to have any relevant changes, while 5.16.3
> > carries a few.

I was trying to reproduce this issue on Turris Omnia but it looks like
that kernel v5.16.3 is totally broken and I'm not able to boot it. It
crashes somewhere in non-pci related code.

[    1.848417] ip_gre: GRE over IPv4 tunneling driver
[    1.849114] NET: Registered PF_INET6 protocol family
[    1.866501] Segment Routing with IPv6
[    1.870185] In-situ OAM (IOAM) with IPv6
[    1.874201] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.880680] ip6_gre: GRE over IPv6 tunneling driver
[    1.885860] NET: Registered PF_PACKET protocol family
[    1.891012] 8021q: 802.1Q VLAN Support v1.8
[    1.895348] Registering SWP/SWPB emulation handler
[    1.900560] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
[    1.907282] Modules linked in:
[    1.910346] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.3 #124
[    1.916455] Hardware name: Marvell Armada 380/385 (Device Tree)
[    1.922387] PC is at crypto_unregister_alg+0xf4/0xfc
[    1.927370] LR is at 0x0
[    1.929909] pc : [<c04e1a6c>]    lr : [<00000000>]    psr: 20000013
[    1.936190] sp : c1863ea0  ip : 00000000  fp : c10b0000
[    1.941425] r10: c0f49838  r9 : c0f49858  r8 : c18b0000
[    1.946660] r7 : c10b0484  r6 : c1863eac  r5 : c1004f48  r4 : c2311280
[    1.953201] r3 : 00000002  r2 : ffffffff  r1 : 00000001  r0 : c1082c70
[    1.959743] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    1.966896] Control: 10c5387d  Table: 0000404a  DAC: 00000051
[    1.972654] Register r0 information: non-slab/vmalloc memory
[    1.978328] Register r1 information: non-paged memory
[    1.983391] Register r2 information: non-paged memory
[    1.988453] Register r3 information: non-paged memory
[    1.993516] Register r4 information: slab kmalloc-512 start c2311200 pointer offset 128 size 512
[    2.002329] Register r5 information: non-slab/vmalloc memory
[    2.008000] Register r6 information: non-slab/vmalloc memory
[    2.013672] Register r7 information: non-slab/vmalloc memory
[    2.019343] Register r8 information: slab task_struct start c18b0000 pointer offset 0
[    2.027196] Register r9 information: non-slab/vmalloc memory
[    2.032867] Register r10 information: non-slab/vmalloc memory
[    2.038626] Register r11 information: non-slab/vmalloc memory
[    2.044384] Register r12 information: NULL pointer
[    2.049185] Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
[    2.055205] Stack: (0xc1863ea0 to 0xc1864000)
[    2.059573] 3ea0: c18b0000 c100c66a c0f49838 c1863eac c1863eac 72a9cbca c2311200 c10b0498
[    2.067772] 3ec0: 00000001 c04fd268 c10b0488 c011ee7c c100c740 fffffffe 00000001 c0f09218
[    2.075968] 3ee0: c10b0000 c1004f48 c0f091a0 00000000 c18b0000 c0101720 c1823444 c014f9dc
[    2.084164] 3f00: c0e9480c c0d90300 00000000 00000007 00000007 c0d97860 00000000 c1004f48
[    2.092362] 3f20: c0da2044 c0d978d4 37320000 c1823434 c1823442 72a9cbca c10dd7d4 00000008
[    2.100558] 3f40: c0e9480c 72a9cbca c0f5a0e8 c0e9480c 00000008 c18233c0 00000125 c0f01298
[    2.108754] 3f60: 00000007 00000007 00000000 c0f003fc 00000001 c0f003fc 00000000 c1004f40
[    2.116950] 3f80: c0b91d40 00000000 00000000 00000000 00000000 00000000 00000000 c0b91d58
[    2.125147] 3fa0: 00000000 c0b91d40 00000000 c0100148 00000000 00000000 00000000 00000000
[    2.133344] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.141541] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    2.149740] [<c04e1a6c>] (crypto_unregister_alg) from [<c04fd268>] (simd_skcipher_free+0x10/0x1c)
[    2.158645] [<c04fd268>] (simd_skcipher_free) from [<c011ee7c>] (aes_exit+0x20/0x3c)
[    2.166413] [<c011ee7c>] (aes_exit) from [<c0f09218>] (aes_init+0x78/0x94)
[    2.173309] [<c0f09218>] (aes_init) from [<c0101720>] (do_one_initcall+0x64/0x1ac)
[    2.180902] [<c0101720>] (do_one_initcall) from [<c0f01298>] (kernel_init_freeable+0x210/0x274)
[    2.189629] [<c0f01298>] (kernel_init_freeable) from [<c0b91d58>] (kernel_init+0x18/0x12c)
[    2.197923] [<c0b91d58>] (kernel_init) from [<c0100148>] (ret_from_fork+0x14/0x2c)
[    2.205513] Exception stack(0xc1863fb0 to 0xc1863ff8)
[    2.210577] 3fa0:                                     00000000 00000000 00000000 00000000
[    2.218773] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.226968] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.233599] Code: e30011ca e58d4000 eb1a86bd eaffffec (e7f001f2)
[    2.239709] ---[ end trace 36f3af5192e0cf87 ]---
[    2.244337] Kernel panic - not syncing: Fatal exception
[    2.249573] CPU1: stopping
[    2.252289] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D           5.16.3 #124
[    2.259792] Hardware name: Marvell Armada 380/385 (Device Tree)
[    2.265725] [<c010e120>] (unwind_backtrace) from [<c010a170>] (show_stack+0x10/0x14)
[    2.273496] [<c010a170>] (show_stack) from [<c0b89fa8>] (dump_stack_lvl+0x40/0x4c)
[    2.281087] [<c0b89fa8>] (dump_stack_lvl) from [<c010c3f8>] (do_handle_IPI+0xf4/0x128)
[    2.289026] [<c010c3f8>] (do_handle_IPI) from [<c010c444>] (ipi_handler+0x18/0x20)
[    2.296616] [<c010c444>] (ipi_handler) from [<c0187de4>] (handle_percpu_devid_irq+0x78/0x124)
[    2.305167] [<c0187de4>] (handle_percpu_devid_irq) from [<c0182208>] (generic_handle_domain_irq+0x44/0x88)
[    2.314851] [<c0182208>] (generic_handle_domain_irq) from [<c05bde1c>] (gic_handle_irq+0x74/0x88)
[    2.323751] [<c05bde1c>] (gic_handle_irq) from [<c0b91950>] (generic_handle_arch_irq+0x34/0x44)
[    2.332475] [<c0b91950>] (generic_handle_arch_irq) from [<c0100b10>] (__irq_svc+0x50/0x68)
[    2.340763] Exception stack(0xc187df50 to 0xc187df98)
[    2.345826] df40:                                     00000dd0 00000000 00000001 c0116ba0
[    2.354023] df60: c1004f90 c1004fd4 00000002 00000000 c1004f48 c0f5d268 c18b6900 00000000
[    2.362219] df80: 00000000 c187dfa0 c01076f4 c01076f8 60000013 ffffffff
[    2.368847] [<c0100b10>] (__irq_svc) from [<c01076f8>] (arch_cpu_idle+0x38/0x3c)
[    2.376265] [<c01076f8>] (arch_cpu_idle) from [<c0b98df8>] (default_idle_call+0x1c/0x2c)
[    2.384379] [<c0b98df8>] (default_idle_call) from [<c015fc74>] (do_idle+0x1c8/0x218)
[    2.392147] [<c015fc74>] (do_idle) from [<c015ff80>] (cpu_startup_entry+0x18/0x20)
[    2.399739] [<c015ff80>] (cpu_startup_entry) from [<001014b4>] (0x1014b4)
[    2.406549] Rebooting in 1 seconds..

I'm not sure where is the issue and why it crashes. But I tested all
sent pci patches on Turris Omnia in the past and they worked fine.

> Here are some of the dmesg diffs between v5.16.1 (good) and v5.16.3
> (bad):
> 
>    pci 0000:00:01.0: [11ab:6820] type 01 class 0x060400
>   -pci 0000:00:01.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
>    pci 0000:00:02.0: [11ab:6820] type 01 class 0x060400
>   -pci 0000:00:02.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
>    pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400
>   -pci 0000:00:03.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
> 
> That means both kernels *discovered* the devices, but v5.16.3 couldn't
> size the BARs.
> 
> Between v5.16.1 and v5.16.3, there were several changes to mvebu and
> the root port emulation it uses (though the devices above are on the
> root bus and shouldn't be below a root port):
> 
>   71ceae67ef9b ("PCI: pci-bridge-emul: Set PCI_STATUS_CAP_LIST for PCIe device")
>   2c8683fbf143 ("PCI: pci-bridge-emul: Correctly set PCIe capabilities")
>   6863f571a546 ("PCI: pci-bridge-emul: Fix definitions of reserved bits")
>   9e6e6e641f26 ("PCI: pci-bridge-emul: Properly mark reserved PCIe bits in PCI config space")
>   174a6ab8722e ("PCI: pci-bridge-emul: Make expansion ROM Base Address register read-only")
>   ce16d4b7e5f6 ("PCI: mvebu: Fix support for DEVCAP2, DEVCTL2 and LNKCTL2 registers on emulated bridge")
>   004408c5b7b4 ("PCI: mvebu: Fix support for PCI_EXP_RTSTA on emulated bridge")
>   e9dd0d0efece ("PCI: mvebu: Fix support for PCI_EXP_DEVCTL on emulated bridge")
>   802d9ee9cbd3 ("PCI: mvebu: Fix support for PCI_BRIDGE_CTL_BUS_RESET on emulated bridge")
>   4523e727c349 ("PCI: mvebu: Setup PCIe controller to Root Complex mode")
>   7cde9bf07316 ("PCI: mvebu: Fix configuring secondary bus of PCIe Root Port via emulated bridge")
>   3de91c80b70a ("PCI: mvebu: Fix support for bus mastering and PCI_COMMAND on emulated bridge")
>   d9bfeaab65b3 ("PCI: mvebu: Do not modify PCI IO type bits in conf_write")
>   e7e52bc07021 ("PCI: mvebu: Check for errors from pci_bridge_emul_init() call")
> 
> I think these are all from Pali (cc'd), so he'll likely see the
> problem.
> 
> > 5.16.3:
> > $ dmesg|grep -i pci 
> > [    0.075893] PCI: CLS 0 bytes, default 64
> > [    0.127393] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4 
> > [    0.127679] mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
> > [    0.127723] mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff ->
> > 0x0000080000
> > [    0.127743] mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff ->
> > 0x0000040000
> > [    0.127760] mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff ->
> > 0x0000044000
> > [    0.127775] mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff ->
> > 0x0000048000
> > [    0.127790] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe
> > -> 0x0100000000
> > [    0.127804] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe
> > -> 0x0100000000
> > [    0.127819] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe
> > -> 0x0200000000
> > [    0.127833] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe
> > -> 0x0200000000
> > [    0.127847] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe
> > -> 0x0300000000
> > [    0.127861] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe
> > -> 0x0300000000
> > [    0.127875] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe
> > -> 0x0400000000
> > [    0.127886] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe
> > -> 0x0400000000
> > [    0.128145] mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
> > [    0.128162] pci_bus 0000:00: root bus resource [bus 00-ff]
> > [    0.128174] pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081fff]
> > (bus address [0x00080000-0x00081fff])
> > [    0.128183] pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041fff]
> > (bus address [0x00040000-0x00041fff])
> > [    0.128191] pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045fff]
> > (bus address [0x00044000-0x00045fff])
> > [    0.128199] pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049fff]
> > (bus address [0x00048000-0x00049fff])
> > [    0.128206] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
> > [    0.128212] pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
> > [    0.128354] pci 0000:00:01.0: [11ab:6820] type 01 class 0x060400
> > [    0.128634] pci 0000:00:02.0: [11ab:6820] type 01 class 0x060400
> > [    0.128866] pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400
> > [    0.129958] PCI: bus0: Fast back to back transfers disabled
> > [    0.129979] pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]),
> > reconfiguring
> > [    0.129994] pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]),
> > reconfiguring
> > [    0.130004] pci 0000:00:03.0: bridge configuration invalid ([bus 01-00]),
> > reconfiguring
> > [    0.131172] PCI: bus1: Fast back to back transfers enabled
> > [    0.131198] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> > [    0.131363] pci 0000:02:00.0: [11ab:6820] type 00 class 0x058000
> > [    0.131386] pci 0000:02:00.0: reg 0x10: [mem 0xf1000000-0xf10fffff]
> > [    0.131401] pci 0000:02:00.0: reg 0x18: [mem 0x00000000-0x7fffffff]
> > [    0.131459] pci 0000:02:00.0: supports D1 D2
> > [    0.132655] PCI: bus2: Fast back to back transfers disabled
> > [    0.132681] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
> > [    0.132831] pci 0000:03:00.0: [11ab:6820] type 00 class 0x058000
> > [    0.132853] pci 0000:03:00.0: reg 0x10: [mem 0xf1000000-0xf10fffff]
> > [    0.132868] pci 0000:03:00.0: reg 0x18: [mem 0x00000000-0x7fffffff]
> > [    0.132926] pci 0000:03:00.0: supports D1 D2
> > [    0.134166] PCI: bus3: Fast back to back transfers disabled
> > [    0.134194] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
> > [    0.134303] pci 0000:00:02.0: BAR 14: no space for [mem size 0xc0000000]
> > [    0.134318] pci 0000:00:02.0: BAR 14: failed to assign [mem size 0xc0000000]
> > [    0.134329] pci 0000:00:03.0: BAR 14: no space for [mem size 0xc0000000]
> > [    0.134337] pci 0000:00:03.0: BAR 14: failed to assign [mem size 0xc0000000]
> > [    0.134348] pci 0000:00:01.0: PCI bridge to [bus 01] 
> > [    0.134364] pci 0000:02:00.0: BAR 2: no space for [mem size 0x80000000]
> > [    0.134372] pci 0000:02:00.0: BAR 2: failed to assign [mem size 0x80000000]
> > [    0.134379] pci 0000:02:00.0: BAR 0: no space for [mem size 0x00100000]
> > [    0.134385] pci 0000:02:00.0: BAR 0: failed to assign [mem size 0x00100000]
> > [    0.134393] pci 0000:00:02.0: PCI bridge to [bus 02] 
> > [    0.134406] pci 0000:03:00.0: BAR 2: no space for [mem size 0x80000000]
> > [    0.134413] pci 0000:03:00.0: BAR 2: failed to assign [mem size 0x80000000]
> > [    0.134420] pci 0000:03:00.0: BAR 0: no space for [mem size 0x00100000]
> > [    0.134426] pci 0000:03:00.0: BAR 0: failed to assign [mem size 0x00100000]
> > [    0.134433] pci 0000:00:03.0: PCI bridge to [bus 03] 
> > 
> > 5.16.1:
> > [    0.127673] mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
> > [    0.127717] mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff ->
> > 0x0000080000
> > [    0.127737] mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff ->
> > 0x0000040000
> > [    0.127753] mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff ->
> > 0x0000044000
> > [    0.127768] mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff ->
> > 0x0000048000
> > [    0.127783] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe
> > -> 0x0100000000
> > [    0.127798] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe
> > -> 0x0100000000
> > [    0.127812] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe
> > -> 0x0200000000
> > [    0.127826] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe
> > -> 0x0200000000
> > [    0.127839] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe
> > -> 0x0300000000
> > [    0.127853] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe
> > -> 0x0300000000
> > [    0.127867] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe
> > -> 0x0400000000
> > [    0.127877] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe
> > -> 0x0400000000
> > [    0.128140] mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
> > [    0.128157] pci_bus 0000:00: root bus resource [bus 00-ff]
> > [    0.128170] pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081fff]
> > (bus address [0x00080000-0x00081fff])
> > [    0.128179] pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041fff]
> > (bus address [0x00040000-0x00041fff])
> > [    0.128187] pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045fff]
> > (bus address [0x00044000-0x00045fff])
> > [    0.128196] pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049fff]
> > (bus address [0x00048000-0x00049fff])
> > [    0.128203] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
> > [    0.128210] pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
> > [    0.128341] pci 0000:00:01.0: [11ab:6820] type 01 class 0x060400
> > [    0.128362] pci 0000:00:01.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
> > [    0.128631] pci 0000:00:02.0: [11ab:6820] type 01 class 0x060400
> > [    0.128655] pci 0000:00:02.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
> > [    0.128871] pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400
> > [    0.128893] pci 0000:00:03.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
> > [    0.129975] pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]),
> > reconfiguring
> > [    0.129989] pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]),
> > reconfiguring
> > [    0.129999] pci 0000:00:03.0: bridge configuration invalid ([bus 00-00]),
> > reconfiguring
> > [    0.131184] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> > [    0.131344] pci 0000:02:00.0: [168c:003c] type 00 class 0x028000
> > [    0.131375] pci 0000:02:00.0: reg 0x10: [mem 0x00000000-0x001fffff 64bit]
> > [    0.131408] pci 0000:02:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
> > [    0.131507] pci 0000:02:00.0: supports D1
> > [    0.131515] pci 0000:02:00.0: PME# supported from D0 D1 D3hot
> > [    0.131734] pci 0000:00:02.0: ASPM: current common clock configuration is
> > inconsistent, reconfiguring
> > [    0.131753] pci 0000:00:02.0: ASPM: Bridge does not support changing Link
> > Speed to 2.5 GT/s
> > [    0.131759] pci 0000:00:02.0: ASPM: Retrain Link at higher speed is
> > disallowed by quirk
> > [    0.131765] pci 0000:00:02.0: ASPM: Could not configure common clock
> > [    0.132832] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
> > [    0.132993] pci 0000:03:00.0: [168c:002e] type 00 class 0x028000
> > [    0.133027] pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x0000ffff 64bit]
> > [    0.133152] pci 0000:03:00.0: supports D1
> > [    0.133161] pci 0000:03:00.0: PME# supported from D0 D1 D3hot
> > [    0.133396] pci 0000:00:03.0: ASPM: current common clock configuration is
> > inconsistent, reconfiguring
> > [    0.133413] pci 0000:00:03.0: ASPM: Bridge does not support changing Link
> > Speed to 2.5 GT/s
> > [    0.133421] pci 0000:00:03.0: ASPM: Retrain Link at higher speed is
> > disallowed by quirk
> > [    0.133427] pci 0000:00:03.0: ASPM: Could not configure common clock
> > [    0.134545] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
> > [    0.134655] pci 0000:00:02.0: BAR 14: assigned [mem 0xe0000000-0xe02fffff]
> > [    0.134673] pci 0000:00:03.0: BAR 14: assigned [mem 0xe0300000-0xe03fffff]
> > [    0.134685] pci 0000:00:01.0: BAR 6: assigned [mem 0xe0400000-0xe04007ff
> > pref]
> > [    0.134696] pci 0000:00:02.0: BAR 6: assigned [mem 0xe0500000-0xe05007ff
> > pref]
> > [    0.134706] pci 0000:00:03.0: BAR 6: assigned [mem 0xe0600000-0xe06007ff
> > pref]
> > [    0.134717] pci 0000:00:01.0: PCI bridge to [bus 01] 
> > [    0.134737] pci 0000:02:00.0: BAR 0: assigned [mem 0xe0000000-0xe01fffff
> > 64bit]
> > [    0.134755] pci 0000:02:00.0: BAR 6: assigned [mem 0xe0200000-0xe020ffff
> > pref]
> > [    0.134764] pci 0000:00:02.0: PCI bridge to [bus 02] 
> > [    0.134772] pci 0000:00:02.0:   bridge window [mem 0xe0000000-0xe02fffff]
> > [    0.134784] pci 0000:03:00.0: BAR 0: assigned [mem 0xe0300000-0xe030ffff
> > 64bit]
> > [    0.134798] pci 0000:00:03.0: PCI bridge to [bus 03] 
> > [    0.134806] pci 0000:00:03.0:   bridge window [mem 0xe0300000-0xe03fffff]
> > [    0.134997] pcieport 0000:00:02.0: enabling device (0140 -> 0142)
> > [    0.135084] pcieport 0000:00:03.0: enabling device (0140 -> 0142)
> > 
> > -- 
> > You may reply to this email to add a comment.
> > 
> > You are receiving this mail because:
> > You are watching the assignee of the bug.
