Return-Path: <linux-pci+bounces-10367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BB19323E3
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 12:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C151C20D58
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 10:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387B913D601;
	Tue, 16 Jul 2024 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqyuFhOD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E43B143875;
	Tue, 16 Jul 2024 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721125809; cv=none; b=RCjk4jERu26Qc7/UfmV+pHcfeh36BCfmyrLjaeRWAQEM/F0cX0NDif9UPJqv8rXNRcA/jBA2rsDo29HnkE2wdYUl/AVVOtQ18sUmQnQCc3HIbmaCA2Y532VDoxfs0QA0Li+RQ57emsZGkW9rGa8xevzd0xmIc9KRCavx7qpgmk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721125809; c=relaxed/simple;
	bh=QysKPyiFau2fw2f0p+pSgBtnoBOL8OjYbm8noFYeFeY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFTS3DC5wxGLP/owk20ka8CW5GT8eKTgpe5Dq1nKQRWNqL0BOBCRJsLDm16D0RphJE5U1vJZ4jF8R2zk8MvRjM3Ys+lnCiamzt0J6SM1EGYYCv1TGBJXVv8J4yf/K82vdr8byKRQANJdCzZ0/RZKZ5640bHn0Qc9dG1NnYEyNvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqyuFhOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E84AC116B1;
	Tue, 16 Jul 2024 10:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721125808;
	bh=QysKPyiFau2fw2f0p+pSgBtnoBOL8OjYbm8noFYeFeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rqyuFhODQa3Qr5Fjyld3vuMaw73GnEGfh7LiSlIU39EKJ6H6OuvH7DpkPRCVmIO2D
	 fnSFR9X3Zd3yFE7NAMVIM+2zmmZsGd1KsjQp6yCBL3xqSVCTEDihI/N5+A7RUF6s3+
	 uEnXbXRkSpNlv8ngsrYtTQ1gXPRYCPKIAc+DnsxuVrWdRPgV4xz+ArhaF4bXvuOjLY
	 bv5phdTOyK3wSd0wgm8N3BrCTJappg15Km3/XMLexZn8BOqN3HVoD5UUo/CpPrjCwT
	 6ZBAL7iRhgoDMIjI1yqvEGsLJELRBHmbW7ay/1NLHoCAK/tyaYw4EyEV26WZuuZRhk
	 Lrq9p3Bow9nCw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sTfRd-00ClkI-MZ;
	Tue, 16 Jul 2024 11:30:05 +0100
Date: Tue, 16 Jul 2024 11:30:05 +0100
Message-ID: <86r0bt39zm.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [patch V4 00/21] genirq, irqchip: Convert ARM MSI handling to per device MSI domains
In-Reply-To: <ZpUtuS65AQTJ0kPO@hovoldconsulting.com>
References: <20240623142137.448898081@linutronix.de>
	<ZpUFl4uMCT8YwkUE@hovoldconsulting.com>
	<878qy26cd6.wl-maz@kernel.org>
	<ZpUtuS65AQTJ0kPO@hovoldconsulting.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.3
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: johan@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com, rdunlap@infradead.org, vidyas@nvidia.com, ilpo.jarvinen@linux.intel.com, apatel@ventanamicro.com, kevin.tian@intel.com, nipun.gupta@amd.com, den@valinux.co.jp, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org, rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org, lorenzo.pieralisi@arm.com, jgg@mellanox.com, ammarfaizi2@gnuweeb.org, robin.murphy@arm.com, lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org, vkoul@kernel.org, okaya@kernel.org, agross@kernel.org, andersson@kernel.org, mark.rutland@arm.com, shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com, shivamurthy.shastri@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 15 Jul 2024 15:10:01 +0100,
Johan Hovold <johan@kernel.org> wrote:
> 
> On Mon, Jul 15, 2024 at 01:58:13PM +0100, Marc Zyngier wrote:
> > On Mon, 15 Jul 2024 12:18:47 +0100,
> > Johan Hovold <johan@kernel.org> wrote:
> > > On Sun, Jun 23, 2024 at 05:18:31PM +0200, Thomas Gleixner wrote:
> > > > This is version 4 of the series to convert ARM MSI handling over to
> > > > per device MSI domains.
> 
> > > This series only showed up in linux-next last Friday and broke interrupt
> > > handling on Qualcomm platforms like sc8280xp (e.g. Lenovo ThinkPad X13s)
> > > and x1e80100 that use the GIC ITS for PCIe MSIs.
> > > 
> > > I've applied the series (21 commits from linux-next) on top of 6.10 and
> > > can confirm that the breakage is caused by commits:
> > > 
> > > 	3d1c927c08fc ("irqchip/gic-v3-its: Switch platform MSI to MSI parent")
> > > 	233db05bc37f ("irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]")
> > > 
> > > Applying the series up until the change before 3d1c927c08fc unbreaks the
> > > wifi on one machine:
> > > 
> > > 	ath11k_pci 0006:01:00.0: failed to enable msi: -22
> > > 	ath11k_pci 0006:01:00.0: probe with driver ath11k_pci failed with error -22
> > >
> > > and backing up until the commit before 233db05bc37f makes the NVMe come
> > > up again during boot on another.
> > > 
> > > I have not tried to debug this further.
> > 
> > I need a few things from you though, because you're not giving much to
> > help you (and I'm travelling, which doesn't help).
> 
> Yeah, this was just an early heads up.
> 
> > Can you at least investigate what in ath11k_pci_alloc_msi() causes the
> > wifi driver to be upset? Does it normally use a single MSI vector or
> > MSI-X? How about your nVME device?
> 
> It uses multiple vectors, but now it falls back to trying to allocate a
> single one and even that fails with -ENOSPC:
> 
> 	ath11k_pci 0006:01:00.0: ath11k_pci_alloc_msi - requesting one vector failed: -28
> 
> Similar for the NVMe, it uses multiple vectors normally, but now only
> the AER interrupts appears to be allocated for each controller and there
> is a GICv3 interrupt for the NVMe:
> 
> 208:          0          0          0          0          0          0          0          0  ITS-PCI-MSI-0006:00:00.0   0 Edge      PCIe PME, aerdrv
> 212:          0          0          0          0          0          0          0          0  ITS-PCI-MSI-0004:00:00.0   0 Edge      PCIe PME, aerdrv
> 214:        161          0          0          0          0          0          0          0     GICv3 562 Level     nvme0q0, nvme0q1
> 215:          0          0          0          0          0          0          0          0  ITS-PCI-MSI-0002:00:00.0   0 Edge      PCIe PME, aerdrv
>

That's an indication of the driver having failed its MSI allocation
and gone back to INTx signalling.

> Next boot, after disabling PCIe controller async probing, it's an MSI-X?!:
> 
> 201:          0          0          0          0          0          0          0          0  ITS-PCI-MSI-0006:00:00.0   0 Edge      PCIe PME, aerdrv
> 203:          0          0          0          0          0          0          0          0  ITS-PCI-MSI-0004:00:00.0   0 Edge      PCIe PME, aerdrv
> 205:          0          0          0          0          0          0          0          0  ITS-PCI-MSI-0002:00:00.0   0 Edge      PCIe PME, aerdrv
> 206:          0          0          0          0          0          0          0          0  ITS-PCI-MSIX-0002:01:00.0   0 Edge      nvme0q0
>

So is this issue actually tied to the async probing? Does it always
work if you disable it?

> This time ath11k vector allocation succeeded, but the driver times out
> eventually:
> 
> [    8.984619] ath11k_pci 0006:01:00.0: MSI vectors: 32
> [   29.690841] ath11k_pci 0006:01:00.0: failed to power up mhi: -110
> [   29.697136] ath11k_pci 0006:01:00.0: failed to start mhi: -110
> [   29.703153] ath11k_pci 0006:01:00.0: failed to power up :-110
> [   29.732144] ath11k_pci 0006:01:00.0: failed to create soc core: -110
> [   29.738694] ath11k_pci 0006:01:00.0: failed to init core: -110
> [   32.841758] ath11k_pci 0006:01:00.0: probe with driver ath11k_pci failed with error -110
> 
> > It would also help if you could define the DEBUG symbol at the very
> > top of irq-gic-v3-its.c and report the debug information that the ITS
> > driver dumps.
> 
> See below (with synchronous probing of the pcie controllers).

I don't see much going wrong there, and the ITS driver correctly
dishes out interrupts. I'll take the current -next for a ride on my
own HW and see what happens.

	M.

-- 
Without deviation from the norm, progress is not possible.

