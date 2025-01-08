Return-Path: <linux-pci+bounces-19537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF7AA05C28
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 13:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25AA67A01D0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D791F942F;
	Wed,  8 Jan 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntV+OGu5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7991ABECA
	for <linux-pci@vger.kernel.org>; Wed,  8 Jan 2025 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736340923; cv=none; b=LO0OvywUqvUrn+8oL3QS19opZSchcVn4/s+10356qWMRzPomujLqFNiwpXdGc1bohKKAjRvKHtyckPiJXZc/exFVCHz0SF8+MgtQlaILYBPD9H5MyXPj7hnoKQMD2H9lm19rEESYoFCnYKxhJTreL1H+d+8DirZqFTVJLBH7woc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736340923; c=relaxed/simple;
	bh=pIyNoK1Ji+9gN6h0twjFK9XwCUvUdZ5bIgS+UjHi2pg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rIDuq8nHe+bPFYygCfSRMu6DmjiFUHgri0u985KEzuNrIu9lPUZb5rDo5bCwUD+Cbtsq+P3qauXXsQGtuZ2/79U/w42CNx1SDQnOKDb9QOgVRac3b1yh/NpqX7gMxqMzSuMoeNlFjUKqTw0K0KVvNRQqeXlDrEW/lElYTptQhwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntV+OGu5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736340921; x=1767876921;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pIyNoK1Ji+9gN6h0twjFK9XwCUvUdZ5bIgS+UjHi2pg=;
  b=ntV+OGu5bEfcOFu1JXxtZN+bnrjO/FyM8kFRwLSjYsPehxduQnFjQ4kc
   349YZkww3h/fj1vLgf2XnlVcbLCAJrUjNTdU+75w3TJzHNm6ykld9uTP2
   QcfTgao0DVJCYcNlfMdv6tDsnL5wZY/t2mFIry6km5giF0lnfhb56W2RR
   X9cxQkO+5ESaHZyE2UUcp4bhIuOvOglP+Ap3sePzOjqKuBCbPS7yXWAOW
   890esb/367Lab6tFO0a9CS4N0Z4X50OqqxvorJdv1FT5qc3iooz/WpJy8
   +yaCGqKwtfXHetacu+YkJLF4pbdcO8qbDkMWKhZwoDy4ocSjluZ1jdGNb
   g==;
X-CSE-ConnectionGUID: Oqkq0He1SF+NUWbBKlhPew==
X-CSE-MsgGUID: 1o3Nt2GiRC2KNBhTSi0KBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="24168489"
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="24168489"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 04:55:21 -0800
X-CSE-ConnectionGUID: t0IabEpJRf+DXmu0S/WfqQ==
X-CSE-MsgGUID: 1EIRcUduQHyI5Wn8qr05qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102953375"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.87])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 04:55:18 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 8 Jan 2025 14:55:14 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, 
    Krzysztof Wilczynski <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, 
    Niklas Schnelle <niks@kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Evert Vorster <evorster@gmail.com>
Subject: Re: [PATCH for-linus] PCI/bwctrl: Fix NULL pointer deref on unbind
 and bind
In-Reply-To: <Z35qJ3H_8u5LQDJ6@wunner.de>
Message-ID: <60f0479e-7aac-1f6e-b667-605e283244e4@linux.intel.com>
References: <0ee5faf5395cad8d29fb66e1ec444c8d882a4201.1735852688.git.lukas@wunner.de> <e08d30b5-50e0-4381-d2e7-61c2da12966f@linux.intel.com> <Z3ytsSBP3FzuFLRj@wunner.de> <ad5154b6-0e7c-ab80-fd96-c3f6418f20e5@linux.intel.com> <Z35qJ3H_8u5LQDJ6@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1163775918-1736340914=:1082"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1163775918-1736340914=:1082
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 8 Jan 2025, Lukas Wunner wrote:
> On Tue, Jan 07, 2025 at 04:29:18PM +0200, Ilpo J=E4rvinen wrote:
> > On Tue, 7 Jan 2025, Lukas Wunner wrote:
> > > It seems pcie_bwctrl_setspeed_rwsem is only needed because
> > > pcie_retrain_link() calls pcie_reset_lbms_count(), which
> > > would recursively acquire pcie_bwctrl_lbms_rwsem.
> > >
> > > There are only two callers of pcie_retrain_link(), so I'm
> > > wondering if the invocation of pcie_reset_lbms_count()
> > > can be moved to them, thus avoiding the recursive lock
> > > acquisition and allowing to get rid of pcie_bwctrl_setspeed_rwsem.
> > >
> > > An alternative would be to have a __pcie_retrain_link() helper
> > > which doesn't call pcie_reset_lbms_count().
> >=20
> > I considered __pcie_retrain_link() variant but it felt like locking=20
> > details that are internal to bwctrl would be leaking into elsewhere in =
the=20
> > code so I had some level of dislike towards this solution, but I'm not=
=20
> > strictly against it.
>=20
> That's a fair argument.
>=20
> It seems the reason you're acquiring pcie_bwctrl_lbms_rwsem in
> pcie_reset_lbms_count() is because you need to dereference
> port->link_bwctrl so that you can access port->link_bwctrl->lbms_count.
>=20
> If you get rid of lbms_count and instead use a flag in pci_dev->priv_flag=
s,
> then it seems you won't need to acquire the lock and this problem
> solves itself.

Agreed on both points.

> > > I'm also wondering if the IRQ handler really needs to run in
> > > hardirq context.  Is there a reason it can't run in thread
> > > context?  Note that CONFIG_PREEMPT_RT=3Dy (as well as the
> > > "threadirqs" command line option) cause the handler to be run
> > > in thread context, so it must work properly in that situation
> > > as well.
> >=20
> > If thread context would work now, why was the fix in the commit=20
> > 3e82a7f9031f ("PCI/LINK: Supply IRQ handler so level-triggered IRQs are=
=20
> > acked")) needed (the commit is from the bwnotif era)? What has changed=
=20
> > since that fix?
>=20
> Nothing has changed, I had forgotten about that commit.
>=20
> Basically you could move everything in pcie_bwnotif_irq() after clearing
> the interrupt into an IRQ thread, but that would just be the access to th=
e
> atomic variable and the pcie_update_link_speed() call.  That's not worth =
it
> because the overhead to wake the IRQ thread is bigger than just executing
> those things in the hardirq handler.
>=20
> So please ignore my comment.
>=20
>=20
> > > Another oddity that caught my eye is the counting of the
> > > interrupts.  It seems the only place where lbms_count is read
> > > is the pcie_failed_link_retrain() quirk, and it only cares
> > > about the count being non-zero.  So this could be a bit in
> > > pci_dev->priv_flags that's accessed with set_bit() / test_bit()
> > > similar to pci_dev_assign_added() / pci_dev_is_added().
> > >=20
> > > Are you planning on using the count for something else in the
> > > future?  If not, using a flag would be simpler and more economical
> > > memory-wise.
> >=20
> > Somebody requested having the count exposed. For troubleshooting HW=20
> > problems (IIRC), it was privately asked from me when I posted one of=20
> > the early versions of the bwctrl series (so quite long time ago). I've
> > just not created that change yet to put it under sysfs.
>=20
> There's a patch pending to add trace events support to native PCIe hotplu=
g:
>=20
> https://lore.kernel.org/all/20241123113108.29722-1-xueshuai@linux.alibaba=
=2Ecom/
>=20
> If that somebody thinks they need to know how often LBMS triggered,
> we could just add similar trace events for bandwidth notifications.
> That gives us not only the count but also the precise time when the
> bandwidth change happened, so it's arguably more useful for debugging.
>=20
> Trace points are patched in and out of the code path at runtime,
> so they have basically zero cost when not enabled (which would be the
> default).
>=20
>=20
> > > I'm also worried about the lbms_count overflowing.
> >
> > Should I perhaps simply do pci_warn() if it happens?
>=20
> I'd prefere getting rid of the counter altogether. :)

Okay, it's a good suggestion. Trace events seem like a much better=20
approach to the problem.

> > > Because there's hardware which signals an interrupt before actually
> > > setting one of the two bits in the Link Status Register, I'm
> > > wondering if it would make sense to poll the register a couple
> > > of times in the irq handler.  Obviously this is only an option
> > > if the handler is running in thread context.  What was the maximum
> > > time you saw during testing that it took to set the LBMS bit belatedl=
y?
> >=20
> > Is there some misunderstanding here between us because I don't think I'=
ve=20
> > noticed delayed LBMS assertion? What I saw was the new Link Speed not y=
et=20
> > updated when Link Training was already 0. In that case, the Link Status=
=20
> > register was read inside the handler so I'd assume LBMS was set to=20
> > actually trigger the interrupt, thus, not set belatedly.
>=20
> Evert's laptop has BWMgmt+ ABWMgmt+ bits set on Root Port 00:02.1
> in this lspci dump:
>=20
> https://bugzilla.kernel.org/attachment.cgi?id=3D307419&action=3Dedit
>=20
> 00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ri=
dge GPP Bridge (prog-if 00 [Normal decode])
>                 LnkSta: Speed 8GT/s, Width x4
>                         TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt+
>=20
> How can it be that BWMgmt+ is set?  I would have expected the bandwidth
> controller to clear that interrupt.  I can only think of two explanations=
:
> Either BWMgmt+ was set but no interrupt was signaled.  Or the interrupt
> was signaled and handled before BWMgmt+ was set.

Either one of those, or third alternative that it's set more than once=20
and no interrupt occurs on the second assertion (could be e.g. some race=20
due to write-1-to-clear and reasserting LBMS).

But, I've not seen this behavior before that report so I cannot answer to=
=20
your question about how long it took for LBMS to get asserted.

This misbehavior is a bit problematic because those same bits are used to=
=20
identify if the interrupt belongs for bwctrl or not. So if they're not=20
set by the time the handler runs, I don't have a way to identify I'd need=
=20
to poll those bits in the first place (and it's also known the interrupt=20
is shared with other stuff :-().

> I'm guessing the latter is the case because /proc/irq/33/spurious
> indicates 1 unhandled interrupt.
>=20
> Back in March 2023 when you showed me your results with various Intel
> chipsets, I thought you mentioned that you witnessed this too-early
> interrupt situation a couple of times.  But I may be misremembering.

I've seen interrupts occur before the new Link Speed has been updated but=
=20
those still had LT=3D1 and there was _another_ interrupt later. Handling
that later interrupt read the new Link Speed and LT=3D0 so effectively=20
there was just one extra interrupt. I assume it's because LBMS is simply=20
asserted twice and the extra interrupt seemed harmless (no idea why HW=20
ends up doing it though).

The other case, which is a real problem, had LT=3D0 but no new link speed=
=20
in the Current Link Speed field. So it is "premature" in a sense but=20
seemingly the training had completed. In that case, there was no second=20
interrupt so the handler could not acquire the new link speed.

bwctrl does read the new link speed outside the handler by calling=20
pcie_update_link_speed() which is mainly to handle misbehaviors where
BW notifications are not coming at all (if the link speed changes=20
outside of bwctrl setting speed, those changes won't be detected). It will=
=20
still be racy though if LT is deasserted before the Current Link Speed is=
=20
set (I've not seen it to fail to get the new speed but I've not tried to=20
stress test it either).

--=20
 i.

--8323328-1163775918-1736340914=:1082--

