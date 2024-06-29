Return-Path: <linux-pci+bounces-9438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D8E91CC0D
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 12:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD63B21E0F
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 10:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2293CF6A;
	Sat, 29 Jun 2024 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8Z+GxAg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F772E3EE;
	Sat, 29 Jun 2024 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719655874; cv=none; b=EIlVZQBaNdSyT6oKdK4Ku5nOoE6F7NEoYBFOMjCdd7frlEoNJRrEp+LQmNeT1Ds3RQ9xqo4s67C2BgbmKv+o8BG4E09TWOSFOtwSh9QBdaLA0E0/JsSEhf/6eAYDj8bjuAxbcHGaKx3HIC0zo/lV+PKjOyETtpbdYHOqvz8q4ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719655874; c=relaxed/simple;
	bh=FnIL5yyt+lay07WZTdrkwW99UN6S/7QLQv1aXmRY8oA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBaFY2TvQjr1eldjnCnveoKZyUcAAPa47F48D1FF40OiISvuMfr/gbGVInMOE1ujLAi2R2LD+qSMPfK8TexHnPGFrSqCsG/1bEI4KjZKXijiet0XjIXw2+Gp088KzKXD6ECMxyL9XQtgPvGChM/t8iF+iy6SPixwctu5TEXFJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8Z+GxAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5164C2BBFC;
	Sat, 29 Jun 2024 10:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719655873;
	bh=FnIL5yyt+lay07WZTdrkwW99UN6S/7QLQv1aXmRY8oA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J8Z+GxAgG7bZ/af/qv3F1wtxXLfJuFAn8pHXyW04lmthoJULG1oemLUJPVRGOFZOL
	 9Dv3YRyYsXLOT2v3Y2YxVg389rhFIv8AyPHct74RGK4FGZQZu9tIFEj9m6bJD/IvNy
	 CrztD+SgeDll30W7C5ZfjudGZj0Qi26n84eJtaUL27FBhrxZlilH6QoD3YNTkLBXfQ
	 INl9IwZQwfly+vX+KUQ5SZHVPZWdaMzbj15qnzQ03+AP+Ksj2Bspv4PwVhD9UwooGI
	 vJIU3+92Vq8iHaigvq1wnxxy2Z2kuD0leqRc1QU/NHlNJT670cqqca7DFUfUbCq6Pt
	 65eN5n7IVDGYg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sNV31-008N1i-9T;
	Sat, 29 Jun 2024 11:11:11 +0100
Date: Sat, 29 Jun 2024 11:11:10 +0100
Message-ID: <86bk3khxdt.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	anna-maria@linutronix.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	bhelgaas@google.com,
	rdunlap@infradead.org,
	vidyas@nvidia.com,
	ilpo.jarvinen@linux.intel.com,
	apatel@ventanamicro.com,
	kevin.tian@intel.com,
	nipun.gupta@amd.com,
	den@valinux.co.jp,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	alex.williamson@redhat.com,
	will@kernel.org,
	lorenzo.pieralisi@arm.com,
	jgg@mellanox.com,
	ammarfaizi2@gnuweeb.org,
	robin.murphy@arm.com,
	lpieralisi@kernel.org,
	nm@ti.com,
	kristo@kernel.org,
	vkoul@kernel.org,
	okaya@kernel.org,
	agross@kernel.org,
	andersson@kernel.org,
	mark.rutland@arm.com,
	shameerali.kolothum.thodi@huawei.com,
	yuzenghui@huawei.com,
	shivamurthy.shastri@linutronix.de
Subject: Re: [patch V4 05/21] irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]
In-Reply-To: <86cyo0hyc6.wl-maz@kernel.org>
References: <20240623142137.448898081@linutronix.de>
	<20240623142235.024567623@linutronix.de>
	<Zn84OIS0zLWASKr2@arm.com>
	<87h6dcxhy0.ffs@tglx>
	<86ed8ghypg.wl-maz@kernel.org>
	<86cyo0hyc6.wl-maz@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com, rdunlap@infradead.org, vidyas@nvidia.com, ilpo.jarvinen@linux.intel.com, apatel@ventanamicro.com, kevin.tian@intel.com, nipun.gupta@amd.com, den@valinux.co.jp, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org, rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org, lorenzo.pieralisi@arm.com, jgg@mellanox.com, ammarfaizi2@gnuweeb.org, robin.murphy@arm.com, lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org, vkoul@kernel.org, okaya@kernel.org, agross@kernel.org, andersson@kernel.org, mark.rutland@arm.com, shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com, shivamurthy.shastri@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Sat, 29 Jun 2024 10:50:33 +0100,
Marc Zyngier <maz@kernel.org> wrote:
> 
> On Sat, 29 Jun 2024 10:42:35 +0100,
> Marc Zyngier <maz@kernel.org> wrote:
> > 
> > On Sat, 29 Jun 2024 09:37:59 +0100,
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > > 
> > > On Fri, Jun 28 2024 at 23:24, Catalin Marinas wrote:
> > > > I just noticed guests (under KVM) failing to boot on my TX2 with your
> > > > latest branch. I bisected to this patch as the first bad commit.
> > > >
> > > > I'm away this weekend, so won't have time to dive deeper. It looks like
> > > > the CPU is stuck in do_idle() (no timer interrupts?). Also sysrq did not
> > > > seem able to get the stack trace on the other CPUs. It fails both with a
> > > > single or multiple CPUs in the same way place (shortly before mounting
> > > > the rootfs and starting user space).
> > > 
> > > From the RH log it's clear that PCI interrupts are not delivered.
> > > 
> > > > I'll drop your branch from the arm64 for-kernelci for now and have a
> > > > look again on Monday.
> > > 
> > > I stare too. Unfortunately I don't have access to such hardware :(
> > 
> > On the face of it, the LPIs are never unmasked (grepping in
> > /sys/kernel/debug/kvm/*/vgic-state):
> > 
> > Distributor
> > ===========
> > vgic_model:	GICv3
> > nr_spis:	32
> > nr_lpis:	7
> > enabled:	1
> > 
> > P=pending_latch, L=line_level, A=active
> > E=enabled, H=hw, C=config (level=1, edge=0)
> > G=group
> > 
> > VCPU 0 TYP   ID TGT_ID PLAEHCG     HWID   TARGET SRC PRI VCPU_ID
> > ----------------------------------------------------------------
> > [...]
> >        LPI 8192      0 1000001        0        0   0 160      -1 
> >        LPI 8193      1 0000001        0        0   0 160      -1 
> >        LPI 8194      2 0000001        0        0   0 160      -1 
> >        LPI 8256      3 0000001        0        0   0 160      -1 
> >        LPI 8257      4 0000001        0        0   0 160      -1 
> >        LPI 8320      5 0000001        0        0   0 160      -1 
> >        LPI 8321      6 1000001        0        0   0 160      -1
> > 
> > 8192 and 8321 are pending, but never enabled.
> > 
> > This is further confirmed by placing traces in the guest. Now trying
> > to find my way through the new maze of callbacks, because something is
> > clearly missing there.
> 
> This is clearly related to MSI_FLAG_PCI_MSI_MASK_PARENT which is not
> seen as being set from cond_unmask_parent(), and ignoring this
> condition results in a booting VM.
> 
> I have the ugly feeling that the flag is applied at the wrong level,
> or not propagated.

Here's a possible fix. Making the masking at the ITS level optional is
not an option (haha). It is the PCI masking that is totally
superfluous and that could completely be elided.

With this hack, I can boot a GICv3+ITS guest as usual.

	M.

diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index 21daa452ffa6d..b66e64eaae440 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -10,13 +10,13 @@
 #include "irq-gic-common.h"
 #include "irq-msi-lib.h"
 
-#define ITS_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
-				 MSI_FLAG_USE_DEF_CHIP_OPS)
+#define ITS_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS  |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS |	\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT)
 
 #define ITS_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
 				 MSI_FLAG_PCI_MSIX      |	\
-				 MSI_FLAG_MULTI_PCI_MSI |	\
-				 MSI_FLAG_PCI_MSI_MASK_PARENT)
+				 MSI_FLAG_MULTI_PCI_MSI)
 
 #ifdef CONFIG_PCI_MSI
 static int its_pci_msi_vec_count(struct pci_dev *pdev, void *data)


-- 
Without deviation from the norm, progress is not possible.

