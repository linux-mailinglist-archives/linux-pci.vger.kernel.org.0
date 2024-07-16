Return-Path: <linux-pci+bounces-10385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 845DB932FDA
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 20:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17AC61F22C8B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 18:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBAE1A00F7;
	Tue, 16 Jul 2024 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Moe6rkWH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68801C6B7;
	Tue, 16 Jul 2024 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154102; cv=none; b=B7NVmwOos10NXDIkFs5CCTGjQJJ/lpdMEXiKoGPh0zJrM22k5yy/gvGTgBOKJU1ofQOYesWYXzPeaqFShCJ/gNCqklgx4u+59WMJbwVtFPhDvyqrWtVohkuGiCx3v7cHQEAorQ2xjSqoRLPsfq3BuzZUhnVQ7Ix7mYi1zuYdnf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154102; c=relaxed/simple;
	bh=ntHqDMyy/4I/yJt5qk7IPvkZsikYxf20GiACJzvxlp8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLDGYLNhiSOtp11+ExQvAEymh5YKV8nAVsjD0OfSTLFApW0gbKHNYrd/B3Gy6OdcXu0Mx07/a3HIbtXUmbaSer7b+dtffhA7DDs6BnlV33YNSc1czrmIvmdmrB/m7PJwBoOSIvYExteKlvbDJAkY51t1Idfl1lwCAaFCZE9qA3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Moe6rkWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA22C116B1;
	Tue, 16 Jul 2024 18:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154102;
	bh=ntHqDMyy/4I/yJt5qk7IPvkZsikYxf20GiACJzvxlp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Moe6rkWHIpcISLL9Bdv+AIX3fWvauZDaxK6/G/uXTLrViAMp3gu2NAEKxY4bWa8i9
	 HZFVra7oHheW9IwUVFEW1rh9y359eLgJ9RHkS1GIjBCIKNAn01u8ggLgsF/HhKJDQZ
	 rFRO/WiIos5YcA9ANiZte57+IW6XZ2Ucb+Y+itOtIr7c3A/HWlVYt5/W+117hS2tMf
	 bXimsSdEXKKaTPeTGBf2slLCFtN16gvfzj3CRdNxIPDjL6BFLgsGW8Ncz2etBTHUUG
	 Cfl9iyyV+XSvFOjNNLgkTBu4CySnCGMHoFG75PeFjRuFl4wFzo4zC7E6wV1iMUYiNV
	 Z3Rxh5xR7VO9w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sTmnz-00Cu51-NC;
	Tue, 16 Jul 2024 19:21:39 +0100
Date: Tue, 16 Jul 2024 19:21:39 +0100
Message-ID: <86plrd2o5o.wl-maz@kernel.org>
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
	yuzenghui@huawei.com
Subject: Re: [patch V4 00/21] genirq, irqchip: Convert ARM MSI handling to per device MSI domains
In-Reply-To: <ZpaJaM1G721FdLFn@hovoldconsulting.com>
References: <20240623142137.448898081@linutronix.de>
	<ZpUFl4uMCT8YwkUE@hovoldconsulting.com>
	<878qy26cd6.wl-maz@kernel.org>
	<ZpUtuS65AQTJ0kPO@hovoldconsulting.com>
	<86r0bt39zm.wl-maz@kernel.org>
	<ZpaJaM1G721FdLFn@hovoldconsulting.com>
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
X-SA-Exim-Rcpt-To: johan@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com, rdunlap@infradead.org, vidyas@nvidia.com, ilpo.jarvinen@linux.intel.com, apatel@ventanamicro.com, kevin.tian@intel.com, nipun.gupta@amd.com, den@valinux.co.jp, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org, rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org, lorenzo.pieralisi@arm.com, jgg@mellanox.com, ammarfaizi2@gnuweeb.org, robin.murphy@arm.com, lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org, vkoul@kernel.org, okaya@kernel.org, agross@kernel.org, andersson@kernel.org, mark.rutland@arm.com, shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

[Dropping shivamurthy.shastri@linutronix.de who is now bouncing...]

On Tue, 16 Jul 2024 15:53:28 +0100,
Johan Hovold <johan@kernel.org> wrote:
> 
> On Tue, Jul 16, 2024 at 11:30:05AM +0100, Marc Zyngier wrote:
> > On Mon, 15 Jul 2024 15:10:01 +0100,
> > Johan Hovold <johan@kernel.org> wrote:
> > > On Mon, Jul 15, 2024 at 01:58:13PM +0100, Marc Zyngier wrote:
> > > > On Mon, 15 Jul 2024 12:18:47 +0100,
> > > > Johan Hovold <johan@kernel.org> wrote:
> > > > > On Sun, Jun 23, 2024 at 05:18:31PM +0200, Thomas Gleixner wrote:
> > > > > > This is version 4 of the series to convert ARM MSI handling over to
> > > > > > per device MSI domains.
> > > 
> > > > > This series only showed up in linux-next last Friday and broke interrupt
> > > > > handling on Qualcomm platforms like sc8280xp (e.g. Lenovo ThinkPad X13s)
> > > > > and x1e80100 that use the GIC ITS for PCIe MSIs.
> > > > > 
> > > > > I've applied the series (21 commits from linux-next) on top of 6.10 and
> > > > > can confirm that the breakage is caused by commits:
> > > > > 
> > > > > 	3d1c927c08fc ("irqchip/gic-v3-its: Switch platform MSI to MSI parent")
> > > > > 	233db05bc37f ("irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]")
> > > > > 
> > > > > Applying the series up until the change before 3d1c927c08fc unbreaks the
> > > > > wifi on one machine:
> > > > > 
> > > > > 	ath11k_pci 0006:01:00.0: failed to enable msi: -22
> > > > > 	ath11k_pci 0006:01:00.0: probe with driver ath11k_pci failed with error -22
> 
> Correction, this doesn't fix the wifi, but I'm not seeing these errors
> with the commit before cc23d1dfc959 as the ath11k driver doesn't get
> this far (or doesn't probe at all).

I think we need to track one thing at a time. The wifi and nvme
problems seem subtly different... Which is the exact commit that
breaks nvme on your machine?

[...]

> > So is this issue actually tied to the async probing? Does it always
> > work if you disable it?
> 
> There seem to multiple issues here.
> 
> With the full series applied and normal async (i.e. parallel) probing of
> the PCIe controllers I sometimes see allocation failing with -ENOSPC
> (e.g. the above ath11k errors). This seems to indicate broken locking
> somewhere.

Your log doesn't support this theory. At least not from an ITS
perspective, as it keeps dishing out INTIDs (and it is very hard to
run out of IRQs with the ITS).

>
> With synchronous probing, allocation always seems to succeed but the
> ath11k (and modem) drivers time out as no interrupts are received.
> 
> The NVMe driver sometimes falls back to INTx signalling and can access
> the drive, but often end up with an MSIX (?!) allocation and then fails
> to probe:
> 
> 	[  132.084740] nvme nvme0: I/O tag 17 (1011) QID 0 timeout, completion polled

So one of my test boxes (ThunderX) fails this exact way, while another
(Synquacer) is pretty happy. Still trying to understand the difference
in behaviour.

How do you enforce synchronous probing?

	M.

-- 
Without deviation from the norm, progress is not possible.

