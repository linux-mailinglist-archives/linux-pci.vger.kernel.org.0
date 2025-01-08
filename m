Return-Path: <linux-pci+bounces-19536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D16E5A05B01
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 13:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654E01887C29
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 12:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039C41F758A;
	Wed,  8 Jan 2025 12:06:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA731F8ADB
	for <linux-pci@vger.kernel.org>; Wed,  8 Jan 2025 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337972; cv=none; b=rlJVyKkFH3JSxrf3gZ4Tm6G5pAsT66H5icXSUhNZFoOBEQr9q/WnqgWoHqOkQ9ZzaXLGbzvY0a+KQiG/ZA5EpwxwXmsyHWEw4r8xeJOkWCapAqbnhFZOQuUNG4zhSc7KgyY+fJ4DUr0azMYPY6sBQEQSJiHP0TSM1otbk6gODZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337972; c=relaxed/simple;
	bh=rgrx5WRswJp2QxQVNwmR4C2ijm2tcxlE9LB0plXrdlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXEBrP2oTiZEjeavyuoaLxdhljtxrVli04gtT8clpk2sxlVdzLbjMM+QtJyOPuFtcFtQrqwCweErcUxFdZCCLnz7ceug135PNx69laT+HWUFuWV6znKprIg93VUVzV9hNlhyQ7sTpqpveztRNtIaXweD7FioSJ8x+QTvOSIAhx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id BB09E2800B745;
	Wed,  8 Jan 2025 13:05:59 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A39874E617; Wed,  8 Jan 2025 13:05:59 +0100 (CET)
Date: Wed, 8 Jan 2025 13:05:59 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, Niklas Schnelle <niks@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Evert Vorster <evorster@gmail.com>
Subject: Re: [PATCH for-linus] PCI/bwctrl: Fix NULL pointer deref on unbind
 and bind
Message-ID: <Z35qJ3H_8u5LQDJ6@wunner.de>
References: <0ee5faf5395cad8d29fb66e1ec444c8d882a4201.1735852688.git.lukas@wunner.de>
 <e08d30b5-50e0-4381-d2e7-61c2da12966f@linux.intel.com>
 <Z3ytsSBP3FzuFLRj@wunner.de>
 <ad5154b6-0e7c-ab80-fd96-c3f6418f20e5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad5154b6-0e7c-ab80-fd96-c3f6418f20e5@linux.intel.com>

On Tue, Jan 07, 2025 at 04:29:18PM +0200, Ilpo Järvinen wrote:
> On Tue, 7 Jan 2025, Lukas Wunner wrote:
> > It seems pcie_bwctrl_setspeed_rwsem is only needed because
> > pcie_retrain_link() calls pcie_reset_lbms_count(), which
> > would recursively acquire pcie_bwctrl_lbms_rwsem.
> >
> > There are only two callers of pcie_retrain_link(), so I'm
> > wondering if the invocation of pcie_reset_lbms_count()
> > can be moved to them, thus avoiding the recursive lock
> > acquisition and allowing to get rid of pcie_bwctrl_setspeed_rwsem.
> >
> > An alternative would be to have a __pcie_retrain_link() helper
> > which doesn't call pcie_reset_lbms_count().
> 
> I considered __pcie_retrain_link() variant but it felt like locking 
> details that are internal to bwctrl would be leaking into elsewhere in the 
> code so I had some level of dislike towards this solution, but I'm not 
> strictly against it.

That's a fair argument.

It seems the reason you're acquiring pcie_bwctrl_lbms_rwsem in
pcie_reset_lbms_count() is because you need to dereference
port->link_bwctrl so that you can access port->link_bwctrl->lbms_count.

If you get rid of lbms_count and instead use a flag in pci_dev->priv_flags,
then it seems you won't need to acquire the lock and this problem
solves itself.


> > I'm also wondering if the IRQ handler really needs to run in
> > hardirq context.  Is there a reason it can't run in thread
> > context?  Note that CONFIG_PREEMPT_RT=y (as well as the
> > "threadirqs" command line option) cause the handler to be run
> > in thread context, so it must work properly in that situation
> > as well.
> 
> If thread context would work now, why was the fix in the commit 
> 3e82a7f9031f ("PCI/LINK: Supply IRQ handler so level-triggered IRQs are 
> acked")) needed (the commit is from the bwnotif era)? What has changed 
> since that fix?

Nothing has changed, I had forgotten about that commit.

Basically you could move everything in pcie_bwnotif_irq() after clearing
the interrupt into an IRQ thread, but that would just be the access to the
atomic variable and the pcie_update_link_speed() call.  That's not worth it
because the overhead to wake the IRQ thread is bigger than just executing
those things in the hardirq handler.

So please ignore my comment.


> > Another oddity that caught my eye is the counting of the
> > interrupts.  It seems the only place where lbms_count is read
> > is the pcie_failed_link_retrain() quirk, and it only cares
> > about the count being non-zero.  So this could be a bit in
> > pci_dev->priv_flags that's accessed with set_bit() / test_bit()
> > similar to pci_dev_assign_added() / pci_dev_is_added().
> > 
> > Are you planning on using the count for something else in the
> > future?  If not, using a flag would be simpler and more economical
> > memory-wise.
> 
> Somebody requested having the count exposed. For troubleshooting HW 
> problems (IIRC), it was privately asked from me when I posted one of 
> the early versions of the bwctrl series (so quite long time ago). I've
> just not created that change yet to put it under sysfs.

There's a patch pending to add trace events support to native PCIe hotplug:

https://lore.kernel.org/all/20241123113108.29722-1-xueshuai@linux.alibaba.com/

If that somebody thinks they need to know how often LBMS triggered,
we could just add similar trace events for bandwidth notifications.
That gives us not only the count but also the precise time when the
bandwidth change happened, so it's arguably more useful for debugging.

Trace points are patched in and out of the code path at runtime,
so they have basically zero cost when not enabled (which would be the
default).


> > I'm also worried about the lbms_count overflowing.
>
> Should I perhaps simply do pci_warn() if it happens?

I'd prefere getting rid of the counter altogether. :)


> > Because there's hardware which signals an interrupt before actually
> > setting one of the two bits in the Link Status Register, I'm
> > wondering if it would make sense to poll the register a couple
> > of times in the irq handler.  Obviously this is only an option
> > if the handler is running in thread context.  What was the maximum
> > time you saw during testing that it took to set the LBMS bit belatedly?
> 
> Is there some misunderstanding here between us because I don't think I've 
> noticed delayed LBMS assertion? What I saw was the new Link Speed not yet 
> updated when Link Training was already 0. In that case, the Link Status 
> register was read inside the handler so I'd assume LBMS was set to 
> actually trigger the interrupt, thus, not set belatedly.

Evert's laptop has BWMgmt+ ABWMgmt+ bits set on Root Port 00:02.1
in this lspci dump:

https://bugzilla.kernel.org/attachment.cgi?id=307419&action=edit

00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge GPP Bridge (prog-if 00 [Normal decode])
                LnkSta: Speed 8GT/s, Width x4
                        TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt+

How can it be that BWMgmt+ is set?  I would have expected the bandwidth
controller to clear that interrupt.  I can only think of two explanations:
Either BWMgmt+ was set but no interrupt was signaled.  Or the interrupt
was signaled and handled before BWMgmt+ was set.

I'm guessing the latter is the case because /proc/irq/33/spurious
indicates 1 unhandled interrupt.

Back in March 2023 when you showed me your results with various Intel
chipsets, I thought you mentioned that you witnessed this too-early
interrupt situation a couple of times.  But I may be misremembering.

Thanks,

Lukas

