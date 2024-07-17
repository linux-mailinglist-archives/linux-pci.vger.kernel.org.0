Return-Path: <linux-pci+bounces-10456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 934AF9341D0
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 20:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148151F2271C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 18:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097261822EB;
	Wed, 17 Jul 2024 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHMWdR4Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E61180A9E;
	Wed, 17 Jul 2024 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721239639; cv=none; b=kqX7gvkPuTeiY4d2aaxiOiQMVwZxMx4KxLBTgnJlK3SiaFQX+L8OY3d/X89JeHleMjfbuXh3fFQLLKkm6kXikQFyY9dywdaQKLnZHLdoxa2JjJWomUGLLV/Rkxkle/JdLrwBCbKnoHiP/Pi5JPKrCWkR4ppTDfdjxV/JWtXyOU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721239639; c=relaxed/simple;
	bh=jlQGj+y5xWjWBac1NDIXq5sTb3PhV8K7u2hVU+hdMbQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKaaD+jAUUtu4oY14iapivYZ1RiW+MHvKBecZW5l1nfQmilNgozFE1GyTfzgD0zuE5fd4v7rCKiZA8MVarSkDQZk64xt/CfcRxg7bfxzmzoDgqlw+AFzX9M0ZL0llvOXqysR6TByl6ied8x1pvQYMSdhJqnryfSDIig+rOpwZQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHMWdR4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5437FC2BD10;
	Wed, 17 Jul 2024 18:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721239639;
	bh=jlQGj+y5xWjWBac1NDIXq5sTb3PhV8K7u2hVU+hdMbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iHMWdR4QtDHjNb6qgyX5cSH0r8cdiH4JIcMRiOab4qdxMLQTj2x72M0L2NJcri1bW
	 BdE8DN/dSAGnaAk+lhisCcnYW2c/i/ZACZp/D5TcAQQb7iLZDM6DC25k4Z2PNDea0M
	 5wFEVDGuaLNZ7qnxns4D4K9P1yGM27AzEkDzQTgS+fPP9mUIcN06iyTLXhYKPsoQkS
	 Xfz4GgZs+zvmJb8Isdt31wmEddpwt1syyrtwPf5RCNRtHTrxeC/4F1n7d3i4n45jHk
	 17vKjtS/WUXXwHr4NjsrQRYqF1HXb73CrmvVcPR375CDPfeywpegjK1oy+vumUYqPG
	 8tImRDDHkUuaA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sU93c-00DDwI-F9;
	Wed, 17 Jul 2024 19:07:16 +0100
Date: Wed, 17 Jul 2024 19:07:15 +0100
Message-ID: <86le1z3nak.wl-maz@kernel.org>
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
In-Reply-To: <ZpfJc80IInRLbRs5@hovoldconsulting.com>
References: <20240623142137.448898081@linutronix.de>
	<ZpUFl4uMCT8YwkUE@hovoldconsulting.com>
	<878qy26cd6.wl-maz@kernel.org>
	<ZpUtuS65AQTJ0kPO@hovoldconsulting.com>
	<86r0bt39zm.wl-maz@kernel.org>
	<ZpaJaM1G721FdLFn@hovoldconsulting.com>
	<86plrd2o5o.wl-maz@kernel.org>
	<Zpdxe4ce-XwDEods@hovoldconsulting.com>
	<86msmg2n73.wl-maz@kernel.org>
	<ZpfJc80IInRLbRs5@hovoldconsulting.com>
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

On Wed, 17 Jul 2024 14:38:59 +0100,
Johan Hovold <johan@kernel.org> wrote:
> 
> On Wed, Jul 17, 2024 at 01:54:40PM +0100, Marc Zyngier wrote:
> > On Wed, 17 Jul 2024 08:23:39 +0100,
> > Johan Hovold <johan@kernel.org> wrote:
> 
> > > I believe there is a kernel parameter for this (e.g.
> > > module.async_probe), but I just disable async probing for the Qualcomm
> > > PCIe driver I'm using:
> > 
> > I had tried this module parameter, but it didn't change anything on my
> > end.
> 
> > I'll have a look whether the TX1 PCIe driver uses this. It's
> > positively ancient, so I wouldn't bet that it has been touched
> > significantly in the past 5 years.
> 
> Perhaps async probing just changes the symptoms, the NVMe and wifi
> doesn't work in either case.

Yeah, my impression is that this changes the order in which LPIs get
allocated, but the core symptom is the same.

> 
> > > [    8.692011] Reusing ITT for devID 0
> > > [    8.693668] Reusing ITT for devID 0
> > 
> > This is really odd. It indicates that you have several devices sharing
> > the same DeviceID, which I seriously doubt it is the case in a
> > laptop. Do you have any non-transparent bridge here? lspci would help.
> 
> Yeah, and these messages do not show up without the series (see log
> below). They are there in the previous synchronous log however.
> 
> 0002:00:00.0 PCI bridge: Qualcomm Technologies, Inc SC8280XP PCI Express Root Port
> 0002:01:00.0 Non-Volatile memory controller: KIOXIA Corporation NVMe SSD Controller BG4 (DRAM-less)
> 0004:00:00.0 PCI bridge: Qualcomm Technologies, Inc SC8280XP PCI Express Root Port
> 0004:01:00.0 Unassigned class [ff00]: Qualcomm Technologies, Inc SDX55 [Snapdragon X55 5G]
> 0006:00:00.0 PCI bridge: Qualcomm Technologies, Inc SC8280XP PCI Express Root Port
> 0006:01:00.0 Network controller: Qualcomm Technologies, Inc QCNFA765 Wireless Network Adapter (rev 01)

Right, this is a very straightforward setup, Design-crap-ware-style.
Nothing that would alias any device.

>
> > I'm starting to suspect that the new code doesn't carry all the
> > required bits for the DevID, and that we end-up trying to allocated
> > interrupts from the pool allocated to another device, which can never
> > be a good thing, and would explain why everything dies a painful
> > death.
> > 
> > Can you run the same trace with the whole thing reverted? I think
> > we're on something here.
> 
> See below, using normal asynchronous probing like the previous log.

And as expected, no aliasing showing up in this log. Somehow, we're
not able to distinguish between the different PCI domains anymore,
leading to all sorts of funnies.

For the record, I've added some extra debug in the its driver and ran
the result on TX1, old and new kernels.

Before this series:

[   10.139806] nvme nvme0: pci function 0006:58:00.0
[   10.158599] nvme 0006:58:00.0: devid = 35800


With this series:

[   10.143729] nvme nvme0: pci function 0006:58:00.0
[   10.181775] nvme 0006:58:00.0: devid = 5800

Clearly, we've lost something in the battle. I'll keep digging.

	M.

-- 
Without deviation from the norm, progress is not possible.

