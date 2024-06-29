Return-Path: <linux-pci+bounces-9434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EE791CBDA
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 11:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FE41C21231
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 09:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1BB38DD1;
	Sat, 29 Jun 2024 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cD0UhejH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613B93BBC5;
	Sat, 29 Jun 2024 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719652738; cv=none; b=AtjFV9Kd7o8dlzkuxlofwXX65J/8B8ozyMHq6lZ1+vPGLbytRFje4IswM7pZOR3rasQeDy4LigD0gd1GcRS12DAeNz+lo9F1a5uSiG1dzYP1Xq5T5Tfx9/bWasLd9fjp/uwFH5DdQszMY0OjsEvP1ziE6XRi2OPIkEnK1l0cIDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719652738; c=relaxed/simple;
	bh=j0D4aM0HPc9hn8KU2KMSVB0fUvC5FVvdEkb1od0ha9Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3n4Eakz7ukoNvCZ3vZcC7aFeY7/Z/uCFxTvKtk5hvHQG+C3RVVcUWV/yV0OS9rgxaLH8pW73IWJOD23QQjQt/RP1cZ7m/FYm9QP6e4t0B7pXDhcdf/BEsqhNMqDxDFLhchQlpN+KjZW1a5euXPg0qRbPrO6Q4piKBZDn4sxlVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cD0UhejH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B891DC2BBFC;
	Sat, 29 Jun 2024 09:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719652737;
	bh=j0D4aM0HPc9hn8KU2KMSVB0fUvC5FVvdEkb1od0ha9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cD0UhejHsdlBZZ3E3eAHSL8Un4GVWpUBluJ1RvU7gYspHeTFjW15HtYYj45XD2MzC
	 SXCp1vENFFCX7mR+KpW1g1x20TOiEuPVhW8GsM9eVgw1s5x093wMmzIpoY0cS0fj07
	 IRiIsuxdySegvLIF5B9j89do6+hpD6KfcGBkFYRWYc/0gJmlz07fj8LD2BR77G++hB
	 X/CG2pnH0mBmstXtBezVMjg3+n2w2TmQNqOO8EQG9ibkjHrK45siiWV6PVG8feFIqD
	 7ICHFhjt7uI01eryAuq806z2SRRLHAz0fYO28syLEngonpkS5HeeSEtAOZeCdGtnXs
	 NJY1agnLr6+cA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sNUER-008Mh4-6l;
	Sat, 29 Jun 2024 10:18:55 +0100
Date: Sat, 29 Jun 2024 10:18:54 +0100
Message-ID: <86frswhzsx.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
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
Subject: Re: [patch V4 05/21] irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]
In-Reply-To: <Zn84OIS0zLWASKr2@arm.com>
References: <20240623142137.448898081@linutronix.de>
	<20240623142235.024567623@linutronix.de>
	<Zn84OIS0zLWASKr2@arm.com>
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
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com, rdunlap@infradead.org, vidyas@nvidia.com, ilpo.jarvinen@linux.intel.com, apatel@ventanamicro.com, kevin.tian@intel.com, nipun.gupta@amd.com, den@valinux.co.jp, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org, rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org, lorenzo.pieralisi@arm.com, jgg@mellanox.com, ammarfaizi2@gnuweeb.org, robin.murphy@arm.com, lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org, vkoul@kernel.org, okaya@kernel.org, agross@kernel.org, andersson@kernel.org, mark.rutland@arm.com, shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com, shivamurthy.shastri@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Fri, 28 Jun 2024 23:24:56 +0100,
Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> Hi Thomas,
> 
> On Sun, Jun 23, 2024 at 05:18:39PM +0200, Thomas Gleixner wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > The its_pci_msi_prepare() function from the ITS-PCI/MSI code provides the
> > 'global' PCI/MSI domains. Move this function to the ITS-MSI parent code and
> > amend the function to use the domain hardware size, which is the MSI[X]
> > vector count, for allocating the ITS slots for the PCI device.
> > 
> > Enable PCI matching in msi_parent_ops and provide the necessary update to
> > the ITS specific child domain initialization function so that the prepare
> > callback gets invoked on allocations.
> > 
> > The latter might be optimized to do the allocation right at the point where
> > the child domain is initialized, but keep it simple for now.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> I just noticed guests (under KVM) failing to boot on my TX2 with your
> latest branch. I bisected to this patch as the first bad commit.

Reproduced here on a different host (M1), so this is not specific to
TX2 (which would have been odd since KVM emulates the ITS entirely).

I'll start digging.

	M.

-- 
Without deviation from the norm, progress is not possible.

