Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BF466BB0C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jan 2023 10:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjAPJ4t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Jan 2023 04:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjAPJ4b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2023 04:56:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD7A10F6;
        Mon, 16 Jan 2023 01:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sr1dLQ2DHrJOQsUjXblfDx9uh9Q4CaHpI+rB6T/J4gs=; b=rTw1x4d34v6J1knJy5sTd45Mpw
        v8ZusWXumaI2xklE1OnqvqHENTvoJnuOJjPRJHG/aoNYsbMO8DeukCeh6NwJJorL8crHkQIsLOEA3
        aedtDrCnJScFhlUkTVyTs2OGMMaviM35E8Z1H4MtGLT6sPa2WLJvhN85jb07Q5MStV4pmPcX11Rgh
        RmfxYPMWix9WSjrhK01wNxbmVQhGZpTG7B3n2ZIMLMNCAI7s731IIwwKC1WEPyc3QK92Id9QJyAgi
        MnF1XTb2Q0VNaKH49gRc2HNm06ex9/oSSJV+ujqmlH3yqtsOkgsu0K4Lc2TmCC6wWJ1MYBoA0iFfS
        u+z4mTuQ==;
Received: from [2001:8b0:10b:5::bb3] (helo=u3832b3a9db3152.ant.amazon.com)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHMED-008cuB-85; Mon, 16 Jan 2023 09:56:34 +0000
Message-ID: <1901d84f8f999ac6b2f067360f098828cb8c17cf.camel@infradead.org>
Subject: Re: [patch V3 16/22] genirq/msi: Provide new domain id based
 interfaces for freeing interrupts
From:   David Woodhouse <dwmw2@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xen.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Date:   Mon, 16 Jan 2023 09:56:18 +0000
In-Reply-To: <20221124230314.337844751@linutronix.de>
References: <20221124225331.464480443@linutronix.de>
         <20221124230314.337844751@linutronix.de>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
        boundary="=-nah1D/e0Pf0KPrv4hTl/"
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-nah1D/e0Pf0KPrv4hTl/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-11-25 at 00:24 +0100, Thomas Gleixner wrote:
> Provide two sorts of interfaces to handle the different use cases:
>=20
> =C2=A0 - msi_domain_free_irqs_range():
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Handles a caller defined =
precise range
>=20
> =C2=A0 - msi_domain_free_irqs_all():
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Frees all interrupts asso=
ciated to a domain
>=20
> The latter is useful for device teardown and to handle the legacy MSI sup=
port
> which does not have any range information available.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

...

> +static void msi_domain_free_locked(struct device *dev, struct msi_ctrl *=
ctrl)
> =C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct msi_domain_info *info;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct msi_domain_ops *ops;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct irq_domain *domain;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!msi_ctrl_valid(dev, ctrl)=
)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0domain =3D msi_get_device_doma=
in(dev, ctrl->domid);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!domain)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0info =3D domain->host_data;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ops =3D info->ops;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ops->domain_free_irqs)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0ops->domain_free_irqs(domain, dev);

Do you want a call to msi_free_dev_descs(dev) here? In the case where
the core code calls ops->domain_alloc_irqs() it *has* allocated the
descriptors first... but it's expecting the irqdomain to free them?

However, it's not quite as simple as adding msi_free_dev_descs()...

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0__msi_domain_free_irqs(dev, domain, ctrl);
> +

The igb driver seems to set up a single MSI-X in its setup, then tear
that down, then try again with more. Thus exercising the teardown path.

In 6.2-rc3 it fails under Xen (emulation in qemu) thus:

[    1.491207] igb: Intel(R) Gigabit Ethernet Network Driver
[    1.494003] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.664907] ACPI: \_SB_.LNKA: Enabled at IRQ 10
[    1.670837] ------------[ cut here ]------------
[    1.672644] WARNING: CPU: 1 PID: 1 at drivers/xen/events/events_base.c:7=
93 xen_free_irq+0x156/0x170
[    1.676202] Modules linked in:
[    1.677638] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc3+ #1059
[    1.680134] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
[    1.684484] RIP: 0010:xen_free_irq+0x156/0x170
[    1.686240] Code: 5c 41 5d 41 5e 41 5f e9 08 03 95 ff e8 a3 5b 95 ff 48 =
85 c0 74 14 48 8b 58 30 e9 df fe ff ff 31 f6 89 ef e8 6c 59 95 ff eb 94 <0f=
> 0b 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 0f 0b eb 86 0f
[    1.692888] RSP: 0000:ffffc90000013ac8 EFLAGS: 00010246
[    1.694705] RAX: 0000000000000000 RBX: 0000000000000026 RCX: 00000000000=
00000
[    1.697113] RDX: 0000000000000028 RSI: ffff888001400490 RDI: 00000000000=
00026
[    1.699498] RBP: 0000000000000026 R08: ffff8880014005e8 R09: ffffffff89c=
00240
[    1.701917] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000fff=
ffffe
[    1.704520] R13: ffffffff89de6880 R14: 0000000000000000 R15: 00000000000=
00005
[    1.707202] FS:  0000000000000000(0000) GS:ffff88803ed00000(0000) knlGS:=
0000000000000000
[    1.709974] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.711867] CR2: 0000000000000000 CR3: 000000003c812001 CR4: 00000000001=
70ee0
[    1.714260] Call Trace:
[    1.715145]  <TASK>
[    1.715897]  xen_destroy_irq+0x64/0x120
[    1.717181]  ? msi_find_desc+0x41/0xb0
[    1.718552]  xen_teardown_msi_irqs+0x3d/0x70
[    1.720064]  msi_domain_free_locked.part.0+0x58/0x1c0
[    1.721791]  msi_domain_free_irqs_all_locked+0x6a/0x90
[    1.723551]  __pci_enable_msix_range+0x353/0x590
[    1.725159]  igb_set_interrupt_capability+0x90/0x1c0
[    1.726879]  igb_init_interrupt_scheme+0x2d/0x230
[    1.728494]  ? rcu_read_lock_sched_held+0x3f/0x80
[    1.730361]  igb_sw_init+0x1b3/0x260
[    1.731797]  igb_probe+0x3b6/0xf00
[    1.733146]  ? _raw_spin_unlock_irqrestore+0x40/0x60
[    1.734834]  local_pci_probe+0x41/0x80
[    1.736164]  pci_call_probe+0x54/0x160
[    1.737441]  pci_device_probe+0x7c/0x100
[    1.738828]  ? driver_sysfs_add+0x71/0xd0
[    1.740229]  really_probe+0xde/0x380
[    1.741434]  ? pm_runtime_barrier+0x50/0x90
[    1.742873]  __driver_probe_device+0x78/0x170
[    1.744314]  driver_probe_device+0x1f/0x90
[    1.745689]  __driver_attach+0xd2/0x1c0
[    1.747035]  ? __pfx___driver_attach+0x10/0x10
[    1.748518]  bus_for_each_dev+0x79/0xc0
[    1.749859]  bus_add_driver+0x1b1/0x200
[    1.751182]  driver_register+0x89/0xe0
[    1.752472]  ? __pfx_igb_init_module+0x10/0x10
[    1.754054]  do_one_initcall+0x5b/0x320
[    1.755573]  ? rcu_read_lock_sched_held+0x3f/0x80
[    1.757375]  kernel_init_freeable+0x1a6/0x1ec
[    1.759005]  ? __pfx_kernel_init+0x10/0x10
[    1.760375]  kernel_init+0x16/0x130
[    1.761554]  ret_from_fork+0x2c/0x50
[    1.762797]  </TASK>
[    1.763590] irq event stamp: 1798623
[    1.764869] hardirqs last  enabled at (1798633): [<ffffffff8814aa8e>] __=
up_console_sem+0x5e/0x70
[    1.767762] hardirqs last disabled at (1798642): [<ffffffff8814aa73>] __=
up_console_sem+0x43/0x70
[    1.770715] softirqs last  enabled at (1798570): [<ffffffff88d91f76>] __=
do_softirq+0x356/0x4da
[    1.773576] softirqs last disabled at (1798565): [<ffffffff880bb83d>] __=
irq_exit_rcu+0xdd/0x150
[    1.776492] ---[ end trace 0000000000000000 ]---
[    1.839462] igb 0000:00:04.0: added PHC on eth0
[    1.843531] igb 0000:00:04.0: Intel(R) Gigabit Ethernet Network Connecti=
on
[    1.843541] igb 0000:00:04.0: eth0: (PCIe:5.0Gb/s:Width x4) 00:1e:67:cb:=
7a:93
[    1.843620] igb 0000:00:04.0: eth0: PBA No: 006000-000
[    1.849237] igb 0000:00:04.0: Using legacy interrupts. 1 rx queue(s), 1 =
tx queue(s)


If I add the missing call to msi_free_msi_descs() then it does work,
but complains differently:

[    1.563055] igb: Intel(R) Gigabit Ethernet Network Driver
[    1.566442] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.737236] ACPI: \_SB_.LNKA: Enabled at IRQ 10
[    1.742162] ------------[ cut here ]------------
[    1.744393] WARNING: CPU: 0 PID: 1 at kernel/irq/msi.c:196 msi_domain_fr=
ee_descs+0xe1/0x110
[    1.748248] Modules linked in:
[    1.749289] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc3+ #1057
[    1.751466] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
[    1.755187] RIP: 0010:msi_domain_free_descs+0xe1/0x110
[    1.756875] Code: 00 48 89 e6 4c 89 e7 e8 ed f4 ba 00 48 89 c3 48 85 c0 =
0f 84 71 ff ff ff 48 8b 34 24 4c 89 e7 e8 a5 01 bb 00 8b 03 85 c0 74 be <0f=
> 0b eb cb 48 8b 87 70 03 00 00 be ff ff ff ff 48 8d 78 78 e8 26
[    1.763060] RSP: 0000:ffffc90000013b78 EFLAGS: 00010202
[    1.764804] RAX: 0000000000000026 RBX: ffff888001ac5f00 RCX: 00000000000=
00000
[    1.767155] RDX: 0000000000000001 RSI: ffffffffa649808a RDI: 00000000fff=
fffff
[    1.769462] RBP: ffffc90000013ba8 R08: 0000000000000001 R09: 00000000000=
00000
[    1.771934] R10: 000000006ac46bb1 R11: 00000000aee0433d R12: ffff888001a=
238c8
[    1.774695] R13: ffffffffa6de6880 R14: ffff888001a51218 R15: ffff888001a=
50000
[    1.777081] FS:  0000000000000000(0000) GS:ffff88803ec00000(0000) knlGS:=
0000000000000000
[    1.779754] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.781681] CR2: ffff888010801000 CR3: 000000000e812001 CR4: 00000000001=
70ef0
[    1.784093] Call Trace:
[    1.784880]  <TASK>
[    1.785640]  msi_domain_free_msi_descs_range+0x34/0x60
[    1.787370]  msi_domain_free_locked.part.0+0x58/0x1c0
[    1.789034]  msi_domain_free_irqs_all_locked+0x6a/0x90
[    1.790815]  pci_free_msi_irqs+0xe/0x30
[    1.792157]  pci_disable_msix+0x48/0x60
[    1.793413]  igb_reset_interrupt_capability+0xa4/0xb0
[    1.795077]  igb_sw_init+0x13f/0x260
[    1.796281]  igb_probe+0x3b6/0xf00
[    1.797421]  ? _raw_spin_unlock_irqrestore+0x40/0x60
[    1.799050]  local_pci_probe+0x41/0x80
[    1.800282]  pci_call_probe+0x54/0x160
[    1.801543]  pci_device_probe+0x7c/0x100
[    1.803393]  ? driver_sysfs_add+0x71/0xd0
[    1.804761]  really_probe+0xde/0x380
[    1.806021]  ? pm_runtime_barrier+0x50/0x90
[    1.807395]  __driver_probe_device+0x78/0x170
[    1.808877]  driver_probe_device+0x1f/0x90
[    1.810257]  __driver_attach+0xd2/0x1c0
[    1.811529]  ? __pfx___driver_attach+0x10/0x10
[    1.813251]  bus_for_each_dev+0x79/0xc0
[    1.814534]  bus_add_driver+0x1b1/0x200
[    1.816058]  driver_register+0x89/0xe0
[    1.817291]  ? __pfx_igb_init_module+0x10/0x10
[    1.818821]  do_one_initcall+0x5b/0x320
[    1.820133]  ? rcu_read_lock_sched_held+0x3f/0x80
[    1.821697]  kernel_init_freeable+0x1a6/0x1ec
[    1.823150]  ? __pfx_kernel_init+0x10/0x10
[    1.824484]  kernel_init+0x16/0x130
[    1.825990]  ret_from_fork+0x2c/0x50
[    1.827757]  </TASK>
[    1.828865] irq event stamp: 1797845
[    1.830573] hardirqs last  enabled at (1797855): [<ffffffffa514aa8e>] __=
up_console_sem+0x5e/0x70
[    1.834809] hardirqs last disabled at (1797864): [<ffffffffa514aa73>] __=
up_console_sem+0x43/0x70
[    1.838915] softirqs last  enabled at (1797742): [<ffffffffa5d91f76>] __=
do_softirq+0x356/0x4da
[    1.842442] softirqs last disabled at (1797737): [<ffffffffa50bb83d>] __=
irq_exit_rcu+0xdd/0x150
[    1.846094] ---[ end trace 0000000000000000 ]---


If I zero msidesc->irq in the loop in xen_teardown_msi_irqs(), *then*
it both works and stops complaining. But I'm mostly just tampering
empirically now...

I can provide a qemu tree which will let you test this easily with just
`qemu-system-x86_64 -kernel ...` but you have to promise not to look at
the way I've fixed some qemu deadlocks just by commenting out the lock
on MSI delivery/translation :)

You'd also have to provide your own igb device as qemu doesn't emulate
those; I'm testing it in passthrough. Or hack the e1000e driver to do a
setup/teardown/setup... or perhaps just unload and reload its module?

I'll provide a SoB just in case it's actually the right way to fix it=E2=80=
=A6

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 790550479831..293e23b7229a 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -390,8 +390,10 @@ static void xen_teardown_msi_irqs(struct pci_dev *dev)
 	int i;
=20
 	msi_for_each_desc(msidesc, &dev->dev, MSI_DESC_ASSOCIATED) {
-		for (i =3D 0; i < msidesc->nvec_used; i++)
+		for (i =3D 0; i < msidesc->nvec_used; i++) {
 			xen_destroy_irq(msidesc->irq + i);
+			msidesc->irq =3D 0;
+		}
 	}
 }
=20

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 955267bbc2be..812e1ec1a633 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1533,9 +1533,10 @@ static void msi_domain_free_locked(struct device *de=
v, struct msi_ctrl *ctrl)
 	info =3D domain->host_data;
 	ops =3D info->ops;
=20
-	if (ops->domain_free_irqs)
+	if (ops->domain_free_irqs) {
 		ops->domain_free_irqs(domain, dev);
-	else
+		msi_free_msi_descs(dev);
+	} else
 		__msi_domain_free_irqs(dev, domain, ctrl);
=20
 	if (ops->msi_post_free)



--=-nah1D/e0Pf0KPrv4hTl/
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjMwMTE2MDk1NjE4WjAvBgkqhkiG9w0BCQQxIgQgsRUQ5NvJ
kq/bzgisun4qMnwYRB1eiBFypoKU56ZSGrwwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgCBl7M4X85P8yzR8UicvngbrfZ11eqNafgF
P6nh07J2nOp6OsfQJYOurZidF6fjCaH5vd0Wg2dUWql6DLA/vuiF3BtoLprhx2623vkA3LI3hXYK
XJqG5C6/LOwW7U++p3mueGEwlUMXSvLMqt2b06fQVSTJIV58nm75z4mKugNUKzDFtQ2ehHl5p7P+
ELDAvSo7+qnxtUWbe2yGdXFafNBIMMnW+1NNZ9xg2pzNKh8jeXcMdf7ftyfrSVbMST/b2NEqVI7u
cgd8Y+01KuLx+aU72lhzfhVNIWZCbn/49AJYVHqG7T15xEup5bJe2pO+Qrw2dswQE0zXkhrQTy0P
htRR5pVeblXN6/4htWqqws4U7FRg3EjzEDdkDfAC4RTDnLs5fU9KH50BfX4CWp4l919AFFfS+UtE
xldDz/uvX7qhOBSSvnCbrfq/jpzVtElxBPCYsLbZ6Gzv9mjcVp3l0VI4tlb+KQTkbeJpNWF8efDB
KH0qD9z4rJJy6leVyvrzpCTJJROoTiUzDaEgcYOj8Vj/Y02JeEivIrgMS/53H7o4CaIPlYre242b
Nkegv7X3sHHT3B6mwk+b/kyTDqnYg+tmPr93eleaTZbJiT14EPBoPPlXeb9Rplft0wUMO5NfdK0v
0AZmk/RljO7Vy7SfXTnvoreA18P6owtiVD9aIA/QzQAAAAAAAA==


--=-nah1D/e0Pf0KPrv4hTl/--
