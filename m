Return-Path: <linux-pci+bounces-10431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF233933D33
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 14:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AEBB1C2386B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 12:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7038B1802DF;
	Wed, 17 Jul 2024 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFJEEjiF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D161802D9;
	Wed, 17 Jul 2024 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721220885; cv=none; b=Iyxs91TsiDTuG1azXo+w3hGY0FySvOEc1/YQDy9mCgxeO/1YCQWCrsSeMaeYDpDmiNSITyw7soMRfaBiiSuCK+eNMOG6TRsCa1Ffjl2tfLX3V8LtRPh+xpkwadwKxEzKBCgao2msYpiVMcbhM/qVvOHQ8Sw+MnkU/pNqs/5zHVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721220885; c=relaxed/simple;
	bh=nnLLfbV9bwYftssLu+xiTYTnLCBIkXFWNZcnmK8diPE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwTbAJ0/Z3Vhz7VSqnKpOA5rMrliz5nalzzhOwUhpSoML3y3CECx++SlK8vJCK0o7bX7oIvOeHAVEJKQrOTo1DV1aSqguW0/AYNSAJjjAJDVYUe0RjZXCOfxsHBYjEiqoXvauKNrRvdfSrxG5895W+APpYJyht2S6JCiQWzwbAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFJEEjiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C34C4AF12;
	Wed, 17 Jul 2024 12:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721220884;
	bh=nnLLfbV9bwYftssLu+xiTYTnLCBIkXFWNZcnmK8diPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qFJEEjiFB9PLxkGvActSwDja52iQ32LqLf9iMA5pR8YpE/pGPtekwG/17YorYqb8F
	 hJvdqt3vie1x/pRr/MU9YKmFgBQBGTCUe7Oyl2VMY2hFqPRhj+PIVsvqMR5vs2kQCm
	 W3V0oW5141aXkXyR6+bC35FQqk54wa2Sd0J86pbji831Okc3K89jCAgJDN53YfSt/t
	 hC2NBDx1P85GXKrgNVUzQRdeB99VSGgJ+yeCf8Zr/CSoIYalZP/sTgV5Sk51DGA2R5
	 Ti2empTA9I96Wki+x0wIoao/r+uyHvvdhCaF7+6ueedpIqXuQ0+usFkok9ndR89lmJ
	 C42JZSkj+xCOg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sU4B7-00D8zo-GU;
	Wed, 17 Jul 2024 13:54:41 +0100
Date: Wed, 17 Jul 2024 13:54:40 +0100
Message-ID: <86msmg2n73.wl-maz@kernel.org>
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
In-Reply-To: <Zpdxe4ce-XwDEods@hovoldconsulting.com>
References: <20240623142137.448898081@linutronix.de>
	<ZpUFl4uMCT8YwkUE@hovoldconsulting.com>
	<878qy26cd6.wl-maz@kernel.org>
	<ZpUtuS65AQTJ0kPO@hovoldconsulting.com>
	<86r0bt39zm.wl-maz@kernel.org>
	<ZpaJaM1G721FdLFn@hovoldconsulting.com>
	<86plrd2o5o.wl-maz@kernel.org>
	<Zpdxe4ce-XwDEods@hovoldconsulting.com>
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

On Wed, 17 Jul 2024 08:23:39 +0100,
Johan Hovold <johan@kernel.org> wrote:
> 
> On Tue, Jul 16, 2024 at 07:21:39PM +0100, Marc Zyngier wrote:
> > On Tue, 16 Jul 2024 15:53:28 +0100,
> > Johan Hovold <johan@kernel.org> wrote:
> > > On Tue, Jul 16, 2024 at 11:30:05AM +0100, Marc Zyngier wrote:
> > > > On Mon, 15 Jul 2024 15:10:01 +0100,
> > > > Johan Hovold <johan@kernel.org> wrote:
> > > > > On Mon, Jul 15, 2024 at 01:58:13PM +0100, Marc Zyngier wrote:
> > > > > > On Mon, 15 Jul 2024 12:18:47 +0100,
> > > > > > Johan Hovold <johan@kernel.org> wrote:
> 
> > > > > > > This series only showed up in linux-next last Friday and broke interrupt
> > > > > > > handling on Qualcomm platforms like sc8280xp (e.g. Lenovo ThinkPad X13s)
> > > > > > > and x1e80100 that use the GIC ITS for PCIe MSIs.
> > > > > > > 
> > > > > > > I've applied the series (21 commits from linux-next) on top of 6.10 and
> > > > > > > can confirm that the breakage is caused by commits:
> > > > > > > 
> > > > > > > 	3d1c927c08fc ("irqchip/gic-v3-its: Switch platform MSI to MSI parent")
> > > > > > > 	233db05bc37f ("irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]")
> > > > > > > 
> > > > > > > Applying the series up until the change before 3d1c927c08fc unbreaks the
> > > > > > > wifi on one machine:
> > > > > > > 
> > > > > > > 	ath11k_pci 0006:01:00.0: failed to enable msi: -22
> > > > > > > 	ath11k_pci 0006:01:00.0: probe with driver ath11k_pci failed with error -22
> > > 
> > > Correction, this doesn't fix the wifi, but I'm not seeing these errors
> > > with the commit before cc23d1dfc959 as the ath11k driver doesn't get
> 
> [ This was supposed to say 3d1c927c08fc, which is the mainline hash,
> sorry. ]
> 
> > > this far (or doesn't probe at all).
> > 
> > I think we need to track one thing at a time. The wifi and nvme
> > problems seem subtly different... Which is the exact commit that
> > breaks nvme on your machine?
> 
> Yeah, forget about 3d1c927c08fc for now, which may have been a red
> herring since we're also appear to be dealing with some sort of race and
> (some) symptoms keep changing from boot to boot. The only thing that for
> certain is that the series breaks MSI and that the NVMe breaks with
> commit 233db05bc37f ("irqchip/gic-v3-its: Provide MSI parent for
> PCI/MSI[-X]").
> 
> > > > So is this issue actually tied to the async probing? Does it always
> > > > work if you disable it?
> > > 
> > > There seem to multiple issues here.
> > > 
> > > With the full series applied and normal async (i.e. parallel) probing of
> > > the PCIe controllers I sometimes see allocation failing with -ENOSPC
> > > (e.g. the above ath11k errors). This seems to indicate broken locking
> > > somewhere.
> > 
> > Your log doesn't support this theory. At least not from an ITS
> > perspective, as it keeps dishing out INTIDs (and it is very hard to
> > run out of IRQs with the ITS).
> 
> The log I shared was with synchronous probing which takes parallel
> allocation out of the equation (and gives more readable logs) so that is
> expected. See below for a log with normal async probing that may give
> some more insight into the race as well (i.e. when ath11k allocation
> fails with -ENOSPC.)

Huh, this log is actually pointing at something very ugly. Not a race,
but some horrible ID confusion. See below.

> 
> > > With synchronous probing, allocation always seems to succeed but the
> > > ath11k (and modem) drivers time out as no interrupts are received.
> > > 
> > > The NVMe driver sometimes falls back to INTx signalling and can access
> > > the drive, but often end up with an MSIX (?!) allocation and then fails
> > > to probe:
> > > 
> > > 	[  132.084740] nvme nvme0: I/O tag 17 (1011) QID 0 timeout, completion polled
> > 
> > So one of my test boxes (ThunderX) fails this exact way, while another
> > (Synquacer) is pretty happy. Still trying to understand the difference
> > in behaviour.
> > 
> > How do you enforce synchronous probing?
> 
> I believe there is a kernel parameter for this (e.g.
> module.async_probe), but I just disable async probing for the Qualcomm
> PCIe driver I'm using:

I had tried this module parameter, but it didn't change anything on my
end.

> 
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1684,7 +1684,7 @@ static struct platform_driver qcom_pcie_driver = {
>                 .name = "qcom-pcie",
>                 .of_match_table = qcom_pcie_match,
>                 .pm = &qcom_pcie_pm_ops,
> -               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +               //.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>         },
>  };

I'll have a look whether the TX1 PCIe driver uses this. It's
positively ancient, so I wouldn't bet that it has been touched
significantly in the past 5 years.

[...]

> [    8.692011] Reusing ITT for devID 0
> [    8.693668] Reusing ITT for devID 0

This is really odd. It indicates that you have several devices sharing
the same DeviceID, which I seriously doubt it is the case in a
laptop. Do you have any non-transparent bridge here? lspci would help.

> [    8.693871] pcieport 0006:00:00.0: PME: Signaling with IRQ 228
> [    8.694116] pcieport 0006:00:00.0: AER: enabled with IRQ 228
> [    8.696453] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
> [    8.703760] IRQ206 -> 0-7 CPU2
> [    8.710986] pci 0004:00:00.0:   bridge window [mem 0x34300000-0x343fffff]
> [    8.711136] Reusing ITT for devID 0

Where is the bus number gone?

> [    8.717093] IRQ207 -> 0-7 CPU3
> [    8.723889] Reusing ITT for devID 0
> [    8.729600] IRQ208 -> 0-7 CPU4
> [    8.736507] pcieport 0004:00:00.0: PME: Signaling with IRQ 229
> [    8.744261] IRQ209 -> 0-7 CPU5
> [    8.750757] pcieport 0004:00:00.0: AER: enabled with IRQ 229
> [    8.758038] IRQ210 -> 0-7 CPU6
> [    9.071793] IRQ211 -> 0-7 CPU7
> [    9.071807] IRQ212 -> 0-7 CPU0
> [    9.071819] IRQ213 -> 0-7 CPU1
> [    9.071831] IRQ214 -> 0-7 CPU2
> [    9.071842] IRQ215 -> 0-7 CPU3
> [    9.071852] IRQ216 -> 0-7 CPU4
> [    9.071863] IRQ217 -> 0-7 CPU5
> [    9.071875] IRQ218 -> 0-7 CPU6
> [    9.071886] IRQ219 -> 0-7 CPU7
> [    9.071897] IRQ220 -> 0-7 CPU0
> [    9.071907] IRQ221 -> 0-7 CPU1
> [    9.071920] IRQ222 -> 0-7 CPU2
> [    9.071930] IRQ223 -> 0-7 CPU3
> [    9.071941] IRQ224 -> 0-7 CPU4
> [    9.071952] IRQ225 -> 0-7 CPU5
> [    9.071962] IRQ226 -> 0-7 CPU6
> [    9.071973] IRQ227 -> 0-7 CPU7
> [    9.073568] Reusing ITT for devID 0
> [    9.073607] ID:0 pID:8192 vID:196
> [    9.073618] IRQ196 -> 0-7 CPU0
> [    9.073717] IRQ196 -> 0-7 CPU0
> [    9.073737] pcieport 0002:00:00.0: PME: Signaling with IRQ 196
> [    9.086532] pcieport 0002:00:00.0: AER: enabled with IRQ 196
> [    9.102057] mhi-pci-generic 0004:01:00.0: MHI PCI device found: foxconn-sdx55
> [    9.109830] mhi-pci-generic 0004:01:00.0: BAR 0 [mem 0x34300000-0x34300fff 64bit]: assigned
> [    9.119027] mhi-pci-generic 0004:01:00.0: enabling device (0000 -> 0002)
> [    9.127271] ITS: alloc 8224:8
> [    9.141500] ITT 8 entries, 3 bits
> [    9.144502] ID:0 pID:8224 vID:198
> [    9.144597] ID:1 pID:8225 vID:199
> [    9.144605] ID:2 pID:8226 vID:200
> [    9.144612] ID:3 pID:8227 vID:201
> [    9.144619] ID:4 pID:8228 vID:202
> [    9.144689] IRQ198 -> 0-7 CPU1
> [    9.144888] IRQ199 -> 0-7 CPU2
> [    9.144901] IRQ200 -> 0-7 CPU3
> [    9.144914] IRQ201 -> 0-7 CPU4
> [    9.144927] IRQ202 -> 0-7 CPU5
> [    9.151264] IRQ198 -> 0-7 CPU1
> [    9.151479] IRQ199 -> 0-7 CPU2
> [    9.151673] IRQ200 -> 0-7 CPU3
> [    9.151849] IRQ201 -> 0-7 CPU4
> [    9.152056] IRQ202 -> 0-7 CPU5
> [    9.159972] mhi mhi0: Requested to power ON
> [    9.165275] mhi mhi0: Power on setup success
> [    9.279951] ath11k_pci 0006:01:00.0: BAR 0 [mem 0x30400000-0x305fffff 64bit]: assigned
> [    9.288208] ath11k_pci 0006:01:00.0: enabling device (0000 -> 0002)
> [    9.301708] nvme nvme0: pci function 0002:01:00.0
> [    9.307052] Reusing ITT for devID 100
> [    9.315457] nvme 0002:01:00.0: enabling device (0000 -> 0002)

This is device 0002:01:00.0...

> [    9.326554] Reusing ITT for devID 100

... seen as device 0000:01:00.0. WTF???

> [    9.336332] ath11k_pci 0006:01:00.0: ath11k_pci_alloc_msi - requesting one vector failed: -28

I'm starting to suspect that the new code doesn't carry all the
required bits for the DevID, and that we end-up trying to allocated
interrupts from the pool allocated to another device, which can never
be a good thing, and would explain why everything dies a painful
death.

Can you run the same trace with the whole thing reverted? I think
we're on something here.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

