Return-Path: <linux-pci+bounces-9460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBFA91D0F9
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 11:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDCEB1C20B24
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4B313BAE3;
	Sun, 30 Jun 2024 09:55:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D237613B59F;
	Sun, 30 Jun 2024 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719741309; cv=none; b=dAK/uaTUUYz7a9kEOz86/tCc9xSO8wrbr0WJJ0FpHK2kFaP0IfyCOIkVRnudXTWrcDAbgdospgMWbSSseJ7f58jAR0eXZJ6ACNbm+Ve5dIkeDLqPJbwQ5ldW/pmCm7pkDTEsqE3yYUIol5TWgGFGORZwMqVg+GqfpnjFI1M8V4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719741309; c=relaxed/simple;
	bh=fuxnL+aQeCHl/5KZ+QrG1S6By2DKSJ7silQc/vmoXTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlg5eF8fm6sJumzfcrnlLbRnvxXkQ3/GMA5KySbgE8lKDJwr+bRHmTCPaiNqHvr6qDfZpRK/rKJdMOq3fiDWCFT/RGmL+7WpL9rwm5n6WDfG9DvLh3Of7kAQ4HC9hwob5ivwOkLZzgLJ8Rni0urwnpz7ai6ZZhKJlDEkXIzw8mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EA4C32781;
	Sun, 30 Jun 2024 09:55:02 +0000 (UTC)
Date: Sun, 30 Jun 2024 10:55:00 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
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
	shivamurthy.shastri@linutronix.de, Rob Herring <robh@kernel.org>
Subject: Re: [patch V4 05/21] irqchip/gic-v3-its: Provide MSI parent for
 PCI/MSI[-X]
Message-ID: <ZoErdNIuRYD3oEww@arm.com>
References: <20240623142137.448898081@linutronix.de>
 <20240623142235.024567623@linutronix.de>
 <Zn84OIS0zLWASKr2@arm.com>
 <87h6dcxhy0.ffs@tglx>
 <86ed8ghypg.wl-maz@kernel.org>
 <86cyo0hyc6.wl-maz@kernel.org>
 <86bk3khxdt.wl-maz@kernel.org>
 <87ed8gxc2u.ffs@tglx>
 <87a5j3y1cj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5j3y1cj.ffs@tglx>

On Sat, Jun 29, 2024 at 09:51:08PM +0200, Thomas Gleixner wrote:
> On Sat, Jun 29 2024 at 12:44, Thomas Gleixner wrote:
> >> With this hack, I can boot a GICv3+ITS guest as usual.
> >
> > It's not a hack. It's the proper solution. Let me fold that back and
> > look at the other PCI conversions which probably have the same issue.
> >
> > Thanks for digging into this. This help is truly welcome right now.
> 
> So while I pondered to do it slightly differently for a moment I went
> back to this approach and fixed up the other affected ones too. Full
> delta vs. devmsi-arm-v4-1 below.
> 
> Updated branch:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-arm-v4-2

This seems to work for me as well. I re-added this branch to arm64
for-kernelci for wider exposure.

Thanks.

-- 
Catalin

