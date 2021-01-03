Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5892E8C41
	for <lists+linux-pci@lfdr.de>; Sun,  3 Jan 2021 14:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbhACNKy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Jan 2021 08:10:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:46563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbhACNKw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 3 Jan 2021 08:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609679328;
        bh=oMr1UiVpyl19HlZUfahdVovI0N9bYyAD0KPthy7OE58=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XVCkIsAsZ5045sRzx79XEYhN88Cva+MQLh08CwAjV4QZosrN5+M/LrZW5tod1FMb3
         DPtEoVo04QHtDOjutseTwZ3MGMaG8ypa/iDmZ2PFF7d+yLpXhniF4eeks1Mk9FqblN
         EgJOgyjHuy5oFlATIifNqzV6azKHX25ByGgA68yY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [37.60.0.25] ([37.60.0.25]) by web-mail.gmx.net
 (3c-app-gmx-bs25.server.lan [172.19.170.77]) (via HTTP); Sun, 3 Jan 2021
 14:08:48 +0100
MIME-Version: 1.0
Message-ID: <trinity-cf22a881-6ffd-4493-a536-5b28bf685b3e-1609679328200@3c-app-gmx-bs25>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ryder Lee <ryder.lee@mediatek.com>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Aw: Re:  Re:  Re: [PATCH] pci: mediatek: fix warning in msi.h
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 3 Jan 2021 14:08:48 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <trinity-79472418-bec7-4097-9612-fa7a79c27620-1605975168396@3c-app-gmx-bs42>
References: <20201031140330.83768-1-linux@fw-web.de>
 <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08>
 <87k0v4u4uq.wl-maz@kernel.org> <87pn4w90hm.fsf@nanos.tec.linutronix.de>
 <df5565a2f1e821041c7c531ad52a3344@kernel.org>
 <87h7q791j8.fsf@nanos.tec.linutronix.de>
 <877dr38kt8.fsf@nanos.tec.linutronix.de>
 <901c5eb8bbaa3fe53ddc8f65917e48ef@kernel.org>
 <87o8ke7njb.fsf@nanos.tec.linutronix.de>
 <trinity-1d7f8900-10db-40c0-a0aa-47bb99ed84cd-1604508571909@3c-app-gmx-bs02>
 <87h7q4lnoz.fsf@nanos.tec.linutronix.de>
 <074d057910c3e834f4bd58821e8583b1@kernel.org>
 <87blgbl887.fsf@nanos.tec.linutronix.de>
 <c63d8d7d966c1dda82884f361d4691c3@kernel.org>
 <trinity-79472418-bec7-4097-9612-fa7a79c27620-1605975168396@3c-app-gmx-bs42>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:J48wtdsm07XMDPp5d2vD3ZinBgTIrZNvTEDy1RDlf7YJK4WgCuHyKiJcCT+3fs/aHVr3U
 OZYr6E1cJnVNTIppmSzsbIXxW4D5+GyDaF9VU/Ig7DDyYTTZOyNRsPWz6taIGLPiFvkN39Ph8/Az
 +d3NIQwDcx7DVoSaeYwqCsQ/XuNFEBDglhY/SpcK1SWXm7KvMqM2jHf2ULt1FQavXTgakKjvNiwy
 vNNP1AFvbugSRtjcGqYFu0Si0EnllLMDanVyEO9+nItBS20JuSSS/9iilaT6iQMDaXSxWmFaA0cF
 +k=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3IjPHSWw2kc=:KQS8VlTbW6vT49NEERNQ5Q
 1CKPcuz2ZrM1h4osOB2YZLiq6XOrfWhQhbCQA3HBH+stgYBzocnleXbDZdnNMNccVozt1STZ5
 rOyR2dCpsVVZItUyAgUhDuzn4gSgSHebCxjuLE4yeBqQ+vKGCX4byR2OjwXTbBUMJ8hH7edPl
 XArYkjLp47ObXtK9NL6OUzqC5wM9+0eF0zaX0/+auJff/kteI2qDarU1XYxCL0ZTsucVAzuR7
 demRjBO89VACHu/PaskNFINPMsZOYxtK1WWG+dkMKs/JFA3srVjJgY1toScvOqZruPsgzrdy8
 aQ3c0WaxyeNDIq38Z66yF0zM0L8pvcmuaBQisbirRQA3jCP1OIKOsTxdIffgw3QMe0iBCLObG
 tSfrd4l78GUb2kSEqfByjZP9PVv/+pV5hoB/Ee6a75EWLLPUET2do+fragZdr9ru69grKyDMZ
 XXQk9DdvY7v2exLzjeNdhxMFExEaOqb2IuBFPAmXsviwrKt3W9+YvgcyI5lax4zWn/CAZ3w3U
 b2kn9qKV+TBTqAc6TP0/59DV6m/7U384COmFvbEHoZv5yGq1IwtohnndZljvX1k+5jBBojKi0
 8NTrKtz3jKQL0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

5.11-rc1 is also affected, here is the relevant part of trace from my bana=
napi-r2:

[    5.792659] mtk-pcie 1a140000.pcie: PCI host bridge to bus 0000:00
[    5.798879] pci_bus 0000:00: root bus resource [bus 00-ff]
[    5.804412] pci_bus 0000:00: root bus resource [io  0x0000-0xffff] (bus=
 address [0x1a160000-0x1a16ffff])
[    5.813928] pci_bus 0000:00: root bus resource [mem 0x60000000-0x6fffff=
ff]
[    5.820876] pci 0000:00:00.0: [14c3:0801] type 01 class 0x060400
[    5.826915] pci 0000:00:00.0: reg 0x14: [mem 0x00000000-0x0000ffff]
[    5.833294] pci 0000:00:00.0: supports D1
[    5.837315] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    5.843550] pci 0000:00:01.0: [14c3:0801] type 01 class 0x060400
[    5.849598] pci 0000:00:01.0: reg 0x14: [mem 0x00000000-0x0000ffff]
[    5.855995] pci 0000:00:01.0: supports D1
[    5.860016] pci 0000:00:01.0: PME# supported from D0 D1 D3hot
[    5.868688] PCI: bus0: Fast back to back transfers disabled
[    5.874325] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]=
), reconfiguring
[    5.882392] pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]=
), reconfiguring
[    5.890648] pci 0000:01:00.0: [14c3:7615] type 00 class 0x000280
[    5.896700] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x000fffff 64bi=
t]
[    5.933326] PCI: bus1: Fast back to back transfers disabled
[    5.938930] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    5.945814] pci 0000:02:00.0: [1b21:0611] type 00 class 0x010185
[    5.951889] pci 0000:02:00.0: reg 0x10: initial BAR value 0x00000000 in=
valid
[    5.958949] pci 0000:02:00.0: reg 0x10: [io  size 0x0008]
[    5.964382] pci 0000:02:00.0: reg 0x14: initial BAR value 0x00000000 in=
valid
[    5.971454] pci 0000:02:00.0: reg 0x14: [io  size 0x0004]
[    5.976869] pci 0000:02:00.0: reg 0x18: initial BAR value 0x00000000 in=
valid
[    5.983938] pci 0000:02:00.0: reg 0x18: [io  size 0x0008]
[    5.989352] pci 0000:02:00.0: reg 0x1c: initial BAR value 0x00000000 in=
valid
[    5.996424] pci 0000:02:00.0: reg 0x1c: [io  size 0x0004]
[    6.001854] pci 0000:02:00.0: reg 0x20: initial BAR value 0x00000000 in=
valid
[    6.008910] pci 0000:02:00.0: reg 0x20: [io  size 0x0010]
[    6.014337] pci 0000:02:00.0: reg 0x24: [mem 0x00000000-0x000001ff]
[    6.020635] pci 0000:02:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref=
]
[    6.053312] PCI: bus2: Fast back to back transfers disabled
[    6.058912] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
[    6.065622] pci 0000:00:00.0: BAR 8: assigned [mem 0x60000000-0x600ffff=
f]
[    6.072448] pci 0000:00:01.0: BAR 8: assigned [mem 0x60100000-0x601ffff=
f]
[    6.079248] pci 0000:00:01.0: BAR 9: assigned [mem 0x60200000-0x602ffff=
f pref]
[    6.086500] pci 0000:00:00.0: BAR 1: assigned [mem 0x60300000-0x6030fff=
f]
[    6.093318] pci 0000:00:01.0: BAR 1: assigned [mem 0x60310000-0x6031fff=
f]
[    6.100120] pci 0000:00:01.0: BAR 7: assigned [io  0x1000-0x1fff]
[    6.106255] pci 0000:01:00.0: BAR 0: assigned [mem 0x60000000-0x600ffff=
f 64bit]
[    6.113609] pci 0000:00:00.0: PCI bridge to [bus 01]
[    6.118585] pci 0000:00:00.0:   bridge window [mem 0x60000000-0x600ffff=
f]
[    6.125405] pci 0000:02:00.0: BAR 6: assigned [mem 0x60200000-0x6020fff=
f pref]
[    6.132656] pci 0000:02:00.0: BAR 5: assigned [mem 0x60100000-0x601001f=
f]
[    6.139458] pci 0000:02:00.0: BAR 4: assigned [io  0x1000-0x100f]
[    6.145579] pci 0000:02:00.0: BAR 0: assigned [io  0x1010-0x1017]
[    6.151699] pci 0000:02:00.0: BAR 2: assigned [io  0x1018-0x101f]
[    6.157807] pci 0000:02:00.0: BAR 1: assigned [io  0x1020-0x1023]
[    6.163927] pci 0000:02:00.0: BAR 3: assigned [io  0x1024-0x1027]
[    6.170034] pci 0000:00:01.0: PCI bridge to [bus 02]
[    6.175035] pci 0000:00:01.0:   bridge window [io  0x1000-0x1fff]
[    6.181153] pci 0000:00:01.0:   bridge window [mem 0x60100000-0x601ffff=
f]
[    6.187951] pci 0000:00:01.0:   bridge window [mem 0x60200000-0x602ffff=
f pref]
[    6.195427] pcieport 0000:00:00.0: enabling device (0140 -> 0142)
[    6.201795] pcieport 0000:00:00.0: PME: Signaling with IRQ 258
[    6.208053] pcieport 0000:00:01.0: enabling device (0140 -> 0143)
[    6.214395] pcieport 0000:00:01.0: PME: Signaling with IRQ 252
[    6.220784] ahci 0000:02:00.0: version 3.0
[    6.220814] ahci 0000:02:00.0: enabling device (0140 -> 0143)
[    6.226705] ------------[ cut here ]------------
[    6.231380] WARNING: CPU: 0 PID: 33 at include/linux/msi.h:252 pci_msi_=
setup_msi_irqs.constprop.0+0x78/0x80
[    6.241167] Modules linked in:
[    6.244235] CPU: 0 PID: 33 Comm: kworker/0:1 Not tainted 5.11.0-rc1-bpi=
-r2-wifi #1
[    6.251816] Hardware name: Mediatek Cortex-A7 (Device Tree)
[    6.257395] Workqueue: events deferred_probe_work_func
[    6.262549] Backtrace:
[    6.264999] [<c0deb91c>] (dump_backtrace) from [<c0debce0>] (show_stack=
+0x20/0x24)
[    6.272598]  r7:000000fc r6:60000013 r5:00000000 r4:c15eff8c
[    6.278258] [<c0debcc0>] (show_stack) from [<c0def924>] (dump_stack+0xc=
c/0xe0)
[    6.285499] [<c0def858>] (dump_stack) from [<c0126c40>] (__warn+0xfc/0x=
114)
[    6.292477]  r7:000000fc r6:c061e14c r5:00000009 r4:c129b5b0
[    6.298137] [<c0126b44>] (__warn) from [<c0dec3a8>] (warn_slowpath_fmt+=
0x74/0xd0)
[    6.305641]  r7:c061e14c r6:000000fc r5:c129b5b0 r4:00000000
[    6.311301] [<c0dec338>] (warn_slowpath_fmt) from [<c061e14c>] (pci_msi=
_setup_msi_irqs.constprop.0+0x78/0x80)
[    6.321241]  r8:00000001 r7:00000000 r6:00000001 r5:c30f1800 r4:c318f80=
0
[    6.327944] [<c061e0d4>] (pci_msi_setup_msi_irqs.constprop.0) from [<c0=
61e7c8>] (__pci_enable_msi_range+0x224/0x39c)
[    6.338483] [<c061e5a4>] (__pci_enable_msi_range) from [<c061f218>] (pc=
i_alloc_irq_vectors_affinity+0x114/0x158)
[    6.348680]  r10:c16815f8 r9:c23b1ae0 r8:00000001 r7:00000000 r6:c30f18=
00 r5:00000001
[    6.356515]  r4:00000002
[    6.359048] [<c061f104>] (pci_alloc_irq_vectors_affinity) from [<c08819=
5c>] (ahci_init_one+0x500/0x958)
[    6.368468]  r9:00000000 r8:c318e200 r7:00000005 r6:c308c940 r5:c30f180=
0 r4:00000000
[    6.376215] [<c088145c>] (ahci_init_one) from [<c0614d70>] (pci_device_=
probe+0xb8/0x14c)
[    6.384331]  r10:c16815f8 r9:c1611408 r8:c1611438 r7:00000000 r6:c30f18=
00 r5:c0fb66a8
[    6.392166]  r4:c30f1880
[    6.394699] [<c0614cb8>] (pci_device_probe) from [<c07176e4>] (really_p=
robe+0x220/0x50c)
[    6.402813]  r9:c1611438 r8:00000000 r7:c16f9ec0 r6:00000000 r5:c16f9eb=
8 r4:c30f1880
[    6.410560] [<c07174c4>] (really_probe) from [<c0717a58>] (driver_probe=
_device+0x88/0x1fc)
[    6.418849]  r10:00000000 r9:c31790c0 r8:c16815f8 r7:c30f1880 r6:c23b1c=
ac r5:c1611438
[    6.426684]  r4:c30f1880
[    6.429217] [<c07179d0>] (driver_probe_device) from [<c0717f58>] (__dev=
ice_attach_driver+0xa8/0x114)
[    6.438374]  r9:c31790c0 r8:c2336410 r7:c30f1880 r6:c23b1cac r5:c161143=
8 r4:00000001
[    6.446121] [<c0717eb0>] (__device_attach_driver) from [<c07151ac>] (bu=
s_for_each_drv+0x94/0xe4)
[    6.454928]  r7:c30efa40 r6:c0717eb0 r5:c23b1cac r4:00000000
[    6.460589] [<c0715118>] (bus_for_each_drv) from [<c071740c>] (__device=
_attach+0x104/0x19c)
[    6.468960]  r6:00000000 r5:c30f18c4 r4:c30f1880
[    6.473577] [<c0717308>] (__device_attach) from [<c07174c0>] (device_at=
tach+0x1c/0x20)
[    6.481515]  r6:c238d000 r5:c30f1880 r4:c30f1800
[    6.486132] [<c07174a4>] (device_attach) from [<c0606300>] (pci_bus_add=
_device+0x54/0x94)
[    6.494326] [<c06062ac>] (pci_bus_add_device) from [<c060637c>] (pci_bu=
s_add_devices+0x3c/0x80)
[    6.503042]  r5:c238d014 r4:c30f1800
[    6.506617] [<c0606340>] (pci_bus_add_devices) from [<c06063b0>] (pci_b=
us_add_devices+0x70/0x80)
[    6.515422]  r7:c30efa40 r6:c238ec00 r5:c238ec14 r4:c30f0800
[    6.521082] [<c0606340>] (pci_bus_add_devices) from [<c060a5a4>] (pci_h=
ost_probe+0x50/0xa0)
[    6.529454]  r7:c30efa40 r6:c238ec00 r5:c238ec0c r4:00000000
[    6.535114] [<c060a554>] (pci_host_probe) from [<c062d234>] (mtk_pcie_p=
robe+0x188/0x250)
[    6.543228]  r7:c30efa40 r6:c30efa4c r5:c30ef800 r4:c30d4b80
[    6.548889] [<c062d0ac>] (mtk_pcie_probe) from [<c071a7b4>] (platform_p=
robe+0x6c/0xc8)
[    6.556830]  r10:c16815f8 r9:c15f8c9c r8:00000000 r7:c16f9ec0 r6:c15f8c=
9c r5:c2336410
[    6.564667]  r4:00000000 r3:c062d0ac
[    6.568242] [<c071a748>] (platform_probe) from [<c07176e4>] (really_pro=
be+0x220/0x50c)
[    6.576181]  r7:c16f9ec0 r6:00000000 r5:c16f9eb8 r4:c2336410
[    6.581842] [<c07174c4>] (really_probe) from [<c0717a58>] (driver_probe=
_device+0x88/0x1fc)
[    6.590130]  r10:c2336410 r9:c12b6910 r8:c16815f8 r7:c2336410 r6:c23b1e=
7c r5:c15f8c9c
[    6.597965]  r4:c2336410
[    6.600498] [<c07179d0>] (driver_probe_device) from [<c0717f58>] (__dev=
ice_attach_driver+0xa8/0x114)
[    6.609655]  r9:c12b6910 r8:c16815f8 r7:c2336410 r6:c23b1e7c r5:c15f8c9=
c r4:00000001
[    6.617401] [<c0717eb0>] (__device_attach_driver) from [<c07151ac>] (bu=
s_for_each_drv+0x94/0xe4)
[    6.626209]  r7:c1606130 r6:c0717eb0 r5:c23b1e7c r4:00000000
[    6.631870] [<c0715118>] (bus_for_each_drv) from [<c071740c>] (__device=
_attach+0x104/0x19c)
[    6.640241]  r6:00000001 r5:c2336454 r4:c2336410
[    6.644859] [<c0717308>] (__device_attach) from [<c0717fe0>] (device_in=
itial_probe+0x1c/0x20)
[    6.653405]  r6:c2336410 r5:c16063d8 r4:c2315e54
[    6.658022] [<c0717fc4>] (device_initial_probe) from [<c071635c>] (bus_=
probe_device+0x94/0x9c)
[    6.666652] [<c07162c8>] (bus_probe_device) from [<c0716924>] (deferred=
_probe_work_func+0x9c/0xe0)
[    6.675633]  r7:c1606130 r6:c160611c r5:c160611c r4:c2315e54
[    6.681294] [<c0716888>] (deferred_probe_work_func) from [<c0144ec0>] (=
process_one_work+0x1c8/0x530)
[    6.690452]  r10:00000000 r9:c1673d00 r8:00000000 r7:df59b900 r6:df5987=
40 r5:c2383a80
[    6.698287]  r4:c160615c r3:c0716888
[    6.701862] [<c0144cf8>] (process_one_work) from [<c014545c>] (worker_t=
hread+0x234/0x534)
[    6.710062]  r10:df598740 r9:00000008 r8:c1503d00 r7:df598758 r6:c2383a=
94 r5:df598740
[    6.717897]  r4:c2383a80
[    6.720430] [<c0145228>] (worker_thread) from [<c014d8dc>] (kthread+0x1=
30/0x158)
[    6.727847]  r10:c22410a4 r9:c2383a80 r8:c0145228 r7:c23b0000 r6:c214de=
8c r5:c23995c0
[    6.735682]  r4:c2241080
[    6.738216] [<c014d7ac>] (kthread) from [<c0100150>] (ret_from_fork+0x1=
4/0x24)
[    6.745453] Exception stack(0xc23b1fb0 to 0xc23b1ff8)
[    6.750512] 1fa0:                                     00000000 00000000=
 00000000 00000000
[    6.758699] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000=
 00000000 00000000
[    6.766885] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    6.773508]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:000000=
00 r5:c014d7ac
[    6.781344]  r4:c23995c0 r3:00000001
[    6.784944] ---[ end trace b6842aa211313a7f ]---
[    6.789572] ------------[ cut here ]------------
[    6.794205] WARNING: CPU: 0 PID: 33 at include/linux/msi.h:258 free_msi=
_irqs+0x1c8/0x1cc
[    6.802327] Modules linked in:
[    6.805388] CPU: 0 PID: 33 Comm: kworker/0:1 Tainted: G        W       =
  5.11.0-rc1-bpi-r2-wifi #1
[    6.814358] Hardware name: Mediatek Cortex-A7 (Device Tree)
[    6.819935] Workqueue: events deferred_probe_work_func
[    6.825085] Backtrace:
[    6.827534] [<c0deb91c>] (dump_backtrace) from [<c0debce0>] (show_stack=
+0x20/0x24)
[    6.835130]  r7:00000102 r6:60000013 r5:00000000 r4:c15eff8c
[    6.840790] [<c0debcc0>] (show_stack) from [<c0def924>] (dump_stack+0xc=
c/0xe0)
[    6.848030] [<c0def858>] (dump_stack) from [<c0126c40>] (__warn+0xfc/0x=
114)
[    6.855008]  r7:00000102 r6:c061e31c r5:00000009 r4:c129b5b0
[    6.860668] [<c0126b44>] (__warn) from [<c0dec3a8>] (warn_slowpath_fmt+=
0x74/0xd0)
[    6.868171]  r7:c061e31c r6:00000102 r5:c129b5b0 r4:00000000
[    6.873831] [<c0dec338>] (warn_slowpath_fmt) from [<c061e31c>] (free_ms=
i_irqs+0x1c8/0x1cc)
[    6.882119]  r8:00000001 r7:c30f1800 r6:c30f19dc r5:c30f1800 r4:c30f19d=
c
[    6.888821] [<c061e154>] (free_msi_irqs) from [<c061e870>] (__pci_enabl=
e_msi_range+0x2cc/0x39c)
[    6.897541]  r10:00000001 r9:ffffffed r8:00000001 r7:00000000 r6:000000=
01 r5:c30f1800
[    6.905377]  r4:c318f800 r3:00000000
[    6.908951] [<c061e5a4>] (__pci_enable_msi_range) from [<c061f218>] (pc=
i_alloc_irq_vectors_affinity+0x114/0x158)
[    6.919149]  r10:c16815f8 r9:c23b1ae0 r8:00000001 r7:00000000 r6:c30f18=
00 r5:00000001
[    6.926984]  r4:00000002
[    6.929517] [<c061f104>] (pci_alloc_irq_vectors_affinity) from [<c08819=
5c>] (ahci_init_one+0x500/0x958)
[    6.938936]  r9:00000000 r8:c318e200 r7:00000005 r6:c308c940 r5:c30f180=
0 r4:00000000
[    6.946683] [<c088145c>] (ahci_init_one) from [<c0614d70>] (pci_device_=
probe+0xb8/0x14c)
[    6.954798]  r10:c16815f8 r9:c1611408 r8:c1611438 r7:00000000 r6:c30f18=
00 r5:c0fb66a8
[    6.962634]  r4:c30f1880
[    6.965166] [<c0614cb8>] (pci_device_probe) from [<c07176e4>] (really_p=
robe+0x220/0x50c)
[    6.973280]  r9:c1611438 r8:00000000 r7:c16f9ec0 r6:00000000 r5:c16f9eb=
8 r4:c30f1880
[    6.981027] [<c07174c4>] (really_probe) from [<c0717a58>] (driver_probe=
_device+0x88/0x1fc)
[    6.989316]  r10:00000000 r9:c31790c0 r8:c16815f8 r7:c30f1880 r6:c23b1c=
ac r5:c1611438
[    6.997151]  r4:c30f1880
[    6.999683] [<c07179d0>] (driver_probe_device) from [<c0717f58>] (__dev=
ice_attach_driver+0xa8/0x114)
[    7.008840]  r9:c31790c0 r8:c2336410 r7:c30f1880 r6:c23b1cac r5:c161143=
8 r4:00000001
[    7.016587] [<c0717eb0>] (__device_attach_driver) from [<c07151ac>] (bu=
s_for_each_drv+0x94/0xe4)
[    7.025395]  r7:c30efa40 r6:c0717eb0 r5:c23b1cac r4:00000000
[    7.031055] [<c0715118>] (bus_for_each_drv) from [<c071740c>] (__device=
_attach+0x104/0x19c)
[    7.039427]  r6:00000000 r5:c30f18c4 r4:c30f1880
[    7.044043] [<c0717308>] (__device_attach) from [<c07174c0>] (device_at=
tach+0x1c/0x20)
[    7.051980]  r6:c238d000 r5:c30f1880 r4:c30f1800
[    7.056598] [<c07174a4>] (device_attach) from [<c0606300>] (pci_bus_add=
_device+0x54/0x94)
[    7.064793] [<c06062ac>] (pci_bus_add_device) from [<c060637c>] (pci_bu=
s_add_devices+0x3c/0x80)
[    7.073509]  r5:c238d014 r4:c30f1800
[    7.077084] [<c0606340>] (pci_bus_add_devices) from [<c06063b0>] (pci_b=
us_add_devices+0x70/0x80)
[    7.085889]  r7:c30efa40 r6:c238ec00 r5:c238ec14 r4:c30f0800
[    7.091549] [<c0606340>] (pci_bus_add_devices) from [<c060a5a4>] (pci_h=
ost_probe+0x50/0xa0)
[    7.099920]  r7:c30efa40 r6:c238ec00 r5:c238ec0c r4:00000000
[    7.105581] [<c060a554>] (pci_host_probe) from [<c062d234>] (mtk_pcie_p=
robe+0x188/0x250)
[    7.113694]  r7:c30efa40 r6:c30efa4c r5:c30ef800 r4:c30d4b80
[    7.119354] [<c062d0ac>] (mtk_pcie_probe) from [<c071a7b4>] (platform_p=
robe+0x6c/0xc8)
[    7.127296]  r10:c16815f8 r9:c15f8c9c r8:00000000 r7:c16f9ec0 r6:c15f8c=
9c r5:c2336410
[    7.135132]  r4:00000000 r3:c062d0ac
[    7.138706] [<c071a748>] (platform_probe) from [<c07176e4>] (really_pro=
be+0x220/0x50c)
[    7.146646]  r7:c16f9ec0 r6:00000000 r5:c16f9eb8 r4:c2336410
[    7.152306] [<c07174c4>] (really_probe) from [<c0717a58>] (driver_probe=
_device+0x88/0x1fc)
[    7.160594]  r10:c2336410 r9:c12b6910 r8:c16815f8 r7:c2336410 r6:c23b1e=
7c r5:c15f8c9c
[    7.168430]  r4:c2336410
[    7.170962] [<c07179d0>] (driver_probe_device) from [<c0717f58>] (__dev=
ice_attach_driver+0xa8/0x114)
[    7.180119]  r9:c12b6910 r8:c16815f8 r7:c2336410 r6:c23b1e7c r5:c15f8c9=
c r4:00000001
[    7.187866] [<c0717eb0>] (__device_attach_driver) from [<c07151ac>] (bu=
s_for_each_drv+0x94/0xe4)
[    7.196672]  r7:c1606130 r6:c0717eb0 r5:c23b1e7c r4:00000000
[    7.202333] [<c0715118>] (bus_for_each_drv) from [<c071740c>] (__device=
_attach+0x104/0x19c)
[    7.210704]  r6:00000001 r5:c2336454 r4:c2336410
[    7.215321] [<c0717308>] (__device_attach) from [<c0717fe0>] (device_in=
itial_probe+0x1c/0x20)
[    7.223867]  r6:c2336410 r5:c16063d8 r4:c2315e54
[    7.228484] [<c0717fc4>] (device_initial_probe) from [<c071635c>] (bus_=
probe_device+0x94/0x9c)
[    7.237114] [<c07162c8>] (bus_probe_device) from [<c0716924>] (deferred=
_probe_work_func+0x9c/0xe0)
[    7.246095]  r7:c1606130 r6:c160611c r5:c160611c r4:c2315e54
[    7.251756] [<c0716888>] (deferred_probe_work_func) from [<c0144ec0>] (=
process_one_work+0x1c8/0x530)
[    7.260912]  r10:00000000 r9:c1673d00 r8:00000000 r7:df59b900 r6:df5987=
40 r5:c2383a80
[    7.268748]  r4:c160615c r3:c0716888
[    7.272323] [<c0144cf8>] (process_one_work) from [<c014545c>] (worker_t=
hread+0x234/0x534)
[    7.280523]  r10:df598740 r9:00000008 r8:c1503d00 r7:df598758 r6:c2383a=
94 r5:df598740
[    7.288358]  r4:c2383a80
[    7.290890] [<c0145228>] (worker_thread) from [<c014d8dc>] (kthread+0x1=
30/0x158)
[    7.298306]  r10:c22410a4 r9:c2383a80 r8:c0145228 r7:c23b0000 r6:c214de=
8c r5:c23995c0
[    7.306141]  r4:c2241080
[    7.308674] [<c014d7ac>] (kthread) from [<c0100150>] (ret_from_fork+0x1=
4/0x24)
[    7.315910] Exception stack(0xc23b1fb0 to 0xc23b1ff8)
[    7.320968] 1fa0:                                     00000000 00000000=
 00000000 00000000
[    7.329155] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000=
 00000000 00000000
[    7.337341] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    7.343964]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:000000=
00 r5:c014d7ac
[    7.351799]  r4:c23995c0 r3:00000001
[    7.355410] ---[ end trace b6842aa211313a80 ]---

regards Frank
