Return-Path: <linux-pci+bounces-10373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B799329C5
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 16:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107101F21092
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FE11990CF;
	Tue, 16 Jul 2024 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsRy29LJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54753198A3E;
	Tue, 16 Jul 2024 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721141610; cv=none; b=ib54rIGsmj+eSppD/DOEp9uaLA7IU1GXp3rMJQdO4R3V0YqQ5H9iJypHFAJJ6zNVLsqfyBCTjb+QkbrnEP0CB7UGNa27C4ukj4WSq4jr2Thg+T3muaIh+pBe1B5Ri32RdzF/wNO5l2Hp+Ronx944xZLsW5qyDtukwFQ02Nxoe7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721141610; c=relaxed/simple;
	bh=bbvpHxvxvWZpxLx/447Pfo7DJPV230th4g89I8p8jw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mk4+uwVEDcbUQb2vdYYebZQz6tFDDm0n2jcrgxw+ZXNd34si/W1b58VR8P9ecDL9kSn05KsG2cy9AA7ZDSZimmL8vF62HG5SXVrTJN1Ij0Ij0/FZAaiebXFNI5RQRYHvy5geWfd7Y+udVlan+4lo2I15EYtEAWqxtX9vfDNCigM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsRy29LJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2A9C116B1;
	Tue, 16 Jul 2024 14:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721141609;
	bh=bbvpHxvxvWZpxLx/447Pfo7DJPV230th4g89I8p8jw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tsRy29LJN46BlaAm8d6qHqxhYztrt36r6ibmGcq9s+rjXmgh8ndd1Y200MQd3De7Q
	 wpRXlBW7q8gvLQZt7MB2/CbE6kyHrA96mejIHOKMn5D9ALkYiRuJS02NZVVWym+UtE
	 T+V5KTJelZqS8FTbKIOdF/8qt6U84ualjNwNMt8BkZZZnAT/66uIF+TirX/DNdF4LJ
	 egzNOiGFaHLlFLCBXNYFjidhUL5LVHtBs1u9DSPQjHr71bpyuHvGd0jnwzRZdiTfF+
	 04oUHm8zW/c5wZC4544M10rTllGD+9FK/uUXaoQuHzb8MZCVw4RlFLcAqMP8mzqfnk
	 Jdsgkw+tjsPsA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sTjYW-000000003hI-3ht7;
	Tue, 16 Jul 2024 16:53:29 +0200
Date: Tue, 16 Jul 2024 16:53:28 +0200
From: Johan Hovold <johan@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	anna-maria@linutronix.de, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com,
	rdunlap@infradead.org, vidyas@nvidia.com,
	ilpo.jarvinen@linux.intel.com, apatel@ventanamicro.com,
	kevin.tian@intel.com, nipun.gupta@amd.com, den@valinux.co.jp,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org,
	rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org,
	lorenzo.pieralisi@arm.com, jgg@mellanox.com,
	ammarfaizi2@gnuweeb.org, robin.murphy@arm.com,
	lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org,
	vkoul@kernel.org, okaya@kernel.org, agross@kernel.org,
	andersson@kernel.org, mark.rutland@arm.com,
	shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com,
	shivamurthy.shastri@linutronix.de
Subject: Re: [patch V4 00/21] genirq, irqchip: Convert ARM MSI handling to
 per device MSI domains
Message-ID: <ZpaJaM1G721FdLFn@hovoldconsulting.com>
References: <20240623142137.448898081@linutronix.de>
 <ZpUFl4uMCT8YwkUE@hovoldconsulting.com>
 <878qy26cd6.wl-maz@kernel.org>
 <ZpUtuS65AQTJ0kPO@hovoldconsulting.com>
 <86r0bt39zm.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86r0bt39zm.wl-maz@kernel.org>

On Tue, Jul 16, 2024 at 11:30:05AM +0100, Marc Zyngier wrote:
> On Mon, 15 Jul 2024 15:10:01 +0100,
> Johan Hovold <johan@kernel.org> wrote:
> > On Mon, Jul 15, 2024 at 01:58:13PM +0100, Marc Zyngier wrote:
> > > On Mon, 15 Jul 2024 12:18:47 +0100,
> > > Johan Hovold <johan@kernel.org> wrote:
> > > > On Sun, Jun 23, 2024 at 05:18:31PM +0200, Thomas Gleixner wrote:
> > > > > This is version 4 of the series to convert ARM MSI handling over to
> > > > > per device MSI domains.
> > 
> > > > This series only showed up in linux-next last Friday and broke interrupt
> > > > handling on Qualcomm platforms like sc8280xp (e.g. Lenovo ThinkPad X13s)
> > > > and x1e80100 that use the GIC ITS for PCIe MSIs.
> > > > 
> > > > I've applied the series (21 commits from linux-next) on top of 6.10 and
> > > > can confirm that the breakage is caused by commits:
> > > > 
> > > > 	3d1c927c08fc ("irqchip/gic-v3-its: Switch platform MSI to MSI parent")
> > > > 	233db05bc37f ("irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]")
> > > > 
> > > > Applying the series up until the change before 3d1c927c08fc unbreaks the
> > > > wifi on one machine:
> > > > 
> > > > 	ath11k_pci 0006:01:00.0: failed to enable msi: -22
> > > > 	ath11k_pci 0006:01:00.0: probe with driver ath11k_pci failed with error -22

Correction, this doesn't fix the wifi, but I'm not seeing these errors
with the commit before cc23d1dfc959 as the ath11k driver doesn't get
this far (or doesn't probe at all).

> > > > and backing up until the commit before 233db05bc37f makes the NVMe come
> > > > up again during boot on another.
> > > > 
> > > > I have not tried to debug this further.
> > > 
> > > I need a few things from you though, because you're not giving much to
> > > help you (and I'm travelling, which doesn't help).
> > 
> > Yeah, this was just an early heads up.
> > 
> > > Can you at least investigate what in ath11k_pci_alloc_msi() causes the
> > > wifi driver to be upset? Does it normally use a single MSI vector or
> > > MSI-X? How about your nVME device?
> > 
> > It uses multiple vectors, but now it falls back to trying to allocate a
> > single one and even that fails with -ENOSPC:
> > 
> > 	ath11k_pci 0006:01:00.0: ath11k_pci_alloc_msi - requesting one vector failed: -28
> > 
> > Similar for the NVMe, it uses multiple vectors normally, but now only
> > the AER interrupts appears to be allocated for each controller and there
> > is a GICv3 interrupt for the NVMe:
> > 
> > 208:          0          0          0          0          0          0          0          0  ITS-PCI-MSI-0006:00:00.0   0 Edge      PCIe PME, aerdrv
> > 212:          0          0          0          0          0          0          0          0  ITS-PCI-MSI-0004:00:00.0   0 Edge      PCIe PME, aerdrv
> > 214:        161          0          0          0          0          0          0          0     GICv3 562 Level     nvme0q0, nvme0q1
> > 215:          0          0          0          0          0          0          0          0  ITS-PCI-MSI-0002:00:00.0   0 Edge      PCIe PME, aerdrv
> >
> 
> That's an indication of the driver having failed its MSI allocation
> and gone back to INTx signalling.
> 
> > Next boot, after disabling PCIe controller async probing, it's an MSI-X?!:
> > 
> > 201:          0          0          0          0          0          0          0          0  ITS-PCI-MSI-0006:00:00.0   0 Edge      PCIe PME, aerdrv
> > 203:          0          0          0          0          0          0          0          0  ITS-PCI-MSI-0004:00:00.0   0 Edge      PCIe PME, aerdrv
> > 205:          0          0          0          0          0          0          0          0  ITS-PCI-MSI-0002:00:00.0   0 Edge      PCIe PME, aerdrv
> > 206:          0          0          0          0          0          0          0          0  ITS-PCI-MSIX-0002:01:00.0   0 Edge      nvme0q0
> >
> 
> So is this issue actually tied to the async probing? Does it always
> work if you disable it?

There seem to multiple issues here.

With the full series applied and normal async (i.e. parallel) probing of
the PCIe controllers I sometimes see allocation failing with -ENOSPC
(e.g. the above ath11k errors). This seems to indicate broken locking
somewhere.

With synchronous probing, allocation always seems to succeed but the
ath11k (and modem) drivers time out as no interrupts are received.

The NVMe driver sometimes falls back to INTx signalling and can access
the drive, but often end up with an MSIX (?!) allocation and then fails
to probe:

	[  132.084740] nvme nvme0: I/O tag 17 (1011) QID 0 timeout, completion polled

Johan

