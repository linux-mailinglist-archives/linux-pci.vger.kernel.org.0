Return-Path: <linux-pci+bounces-19424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E1CA04294
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11483A1A2C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D7C1F0E51;
	Tue,  7 Jan 2025 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcQlbRnE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652CF1E47DB
	for <linux-pci@vger.kernel.org>; Tue,  7 Jan 2025 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260168; cv=none; b=Mqzrckjb1D+uC6hiEggurMSA5Lq/YsU3swFrpUOjN7PmB4IgBzgDhLmvBeT4teQE2Fcf/Ww1QifehjE1fBVSOlel/C3mroUVL2BS7/i+afdVH7V08KKaBugSBEdRDZo4o6DQZjqpmJ1kvT3UymfrGAwI93vGiqfMkszrWsW1iJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260168; c=relaxed/simple;
	bh=rP4UWAe4JOsyEV7aa5ctI9aZUeKZJpJAcsN65riTZDU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PY0JgusMRKoVYUG7KMUOd3zhoX7Vf1gcBJXTrESgmBBd0PESI7hzZJpStSz4TjujBYH7kLC+cL3BGMavOnAf1D/bE346mzZrq8OwKCnDrkLT3q5QKjkjxeBnvyquwbDtrcklZoGyv5IEbBoIlp0VCDa5b8SYHgVieVQjEO3WRPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcQlbRnE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736260167; x=1767796167;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rP4UWAe4JOsyEV7aa5ctI9aZUeKZJpJAcsN65riTZDU=;
  b=QcQlbRnEzI0FDx8a0NCrSAP/MZH60EzWg7UYb7yV0uTOUxKRVwekgeoF
   bA28xA5M1DEb32A6r0s5JPqaUNRTvAFCDIHEZ5+cAaMqGsSvK8iEd4hKV
   wG3vpXQPff8v5Dkewq4jwv5HaRT30QKj578pPrMw47oPWHT6Vq/7Uedtg
   /YWFsZS9P1jPNqTGBCjXp03QmkTkg8IfK9QqXYiwwQ3fK0LeLPWLagC6C
   17xZnAPlVTnN94wDmq3vS3ZY/LSaFTnzwQmUAf2V0DxtubsSHYW+QL6Lk
   CK51So/Ysys0jSN+q81RJ6CCAf2X8vGxtqE0ByA9bhfsOCMNadAcWZUrT
   w==;
X-CSE-ConnectionGUID: ONAGwRXvQcqswgm41QYXpg==
X-CSE-MsgGUID: /Un+eh8eSzy7SZsB3WswJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="40115615"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="40115615"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 06:29:26 -0800
X-CSE-ConnectionGUID: HB10+epBR1q1NJcGo9AYwg==
X-CSE-MsgGUID: kRVTqs3NSJGjp/HrijWUpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="107657574"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.206])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 06:29:21 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 7 Jan 2025 16:29:18 +0200 (EET)
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
In-Reply-To: <Z3ytsSBP3FzuFLRj@wunner.de>
Message-ID: <ad5154b6-0e7c-ab80-fd96-c3f6418f20e5@linux.intel.com>
References: <0ee5faf5395cad8d29fb66e1ec444c8d882a4201.1735852688.git.lukas@wunner.de> <e08d30b5-50e0-4381-d2e7-61c2da12966f@linux.intel.com> <Z3ytsSBP3FzuFLRj@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-778893945-1736260158=:1001"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-778893945-1736260158=:1001
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 7 Jan 2025, Lukas Wunner wrote:

> On Sun, Jan 05, 2025 at 06:54:24PM +0200, Ilpo J=E4rvinen wrote:
> > Indeed, it certainly didn't occur to me while arranging the code the wa=
y=20
> > it is that there are other sources for the same irq. However, there is =
a=20
> > reason those lines where within the same critical section (I also reali=
zed=20
> > it's not documented anywhere):
> >=20
> > As bwctrl has two operating modes, one with BW notifications and the ot=
her=20
> > without them, there are races when switching between those modes during=
=20
> > probe wrt. call to lbms counting accessor, and I reused those rw=20
> > semaphores to prevent those race (the race fixes were noted only in a=
=20
> > history bullet of the bwctrl series).
>=20
> Could you add code comment(s) to document this?

Sure, I'll do that once I've been able to clear the holiday-induced logjam
on pdx86 maintainership front. :-) (For now, I added a bullet to my todo=20
list to not forget it).

> I've respun the patch, but of course yesterday was a holiday in Finland.
> So I'm hoping you get a chance to review the v2 patch today.

Done.

> It seems pcie_bwctrl_setspeed_rwsem is only needed because
> pcie_retrain_link() calls pcie_reset_lbms_count(), which
> would recursively acquire pcie_bwctrl_lbms_rwsem.
>
> There are only two callers of pcie_retrain_link(), so I'm
> wondering if the invocation of pcie_reset_lbms_count()
> can be moved to them, thus avoiding the recursive lock
> acquisition and allowing to get rid of pcie_bwctrl_setspeed_rwsem.
>
> An alternative would be to have a __pcie_retrain_link() helper
> which doesn't call pcie_reset_lbms_count().
>
> Right now there are no less than three locks used by bwctrl
> (the two global rwsem plus the per-port mutex).  That doesn't
> look elegant and makes it difficult to reason about the code,
> so simplifying the locking would be desirable I think.

I considered __pcie_retrain_link() variant but it felt like locking=20
details that are internal to bwctrl would be leaking into elsewhere in the=
=20
code so I had some level of dislike towards this solution, but I'm not=20
strictly against it.

It would seem most straightforward approach that wouldn't force=20
moving LBMS reset to callers which feels even less elegant/obvious.
I just previously chose to keep that to complexity internal to bwctrl
but if you think adding __pcie_retrain_link() would be more elegant,
we can certainly move to that direction.

> I'm also wondering if the IRQ handler really needs to run in
> hardirq context.  Is there a reason it can't run in thread
> context?  Note that CONFIG_PREEMPT_RT=3Dy (as well as the
> "threadirqs" command line option) cause the handler to be run
> in thread context, so it must work properly in that situation
> as well.

If thread context would work now, why was the fix in the commit=20
3e82a7f9031f ("PCI/LINK: Supply IRQ handler so level-triggered IRQs are=20
acked")) needed (the commit is from the bwnotif era)? What has changed=20
since that fix?

I'm open to our suggestion but that existence of that fix is keeping me=20
back. I just don't understand why it would work now when it didn't back=20
then.

> Another oddity that caught my eye is the counting of the
> interrupts.  It seems the only place where lbms_count is read
> is the pcie_failed_link_retrain() quirk, and it only cares
> about the count being non-zero.  So this could be a bit in
> pci_dev->priv_flags that's accessed with set_bit() / test_bit()
> similar to pci_dev_assign_added() / pci_dev_is_added().
>=20
> Are you planning on using the count for something else in the
> future?  If not, using a flag would be simpler and more economical
> memory-wise.

Somebody requested having the count exposed. For troubleshooting HW=20
problems (IIRC), it was privately asked from me when I posted one of=20
the early versions of the bwctrl series (so quite long time ago). I've
just not created that change yet to put it under sysfs.

> I'm also worried about the lbms_count overflowing.

Should I perhaps simply do pci_warn() if it happens?

> Because there's hardware which signals an interrupt before actually
> setting one of the two bits in the Link Status Register, I'm
> wondering if it would make sense to poll the register a couple
> of times in the irq handler.  Obviously this is only an option
> if the handler is running in thread context.  What was the maximum
> time you saw during testing that it took to set the LBMS bit belatedly?

Is there some misunderstanding here between us because I don't think I've=
=20
noticed delayed LBMS assertion? What I saw was the new Link Speed not yet=
=20
updated when Link Training was already 0. In that case, the Link Status=20
register was read inside the handler so I'd assume LBMS was set to=20
actually trigger the interrupt, thus, not set belatedly.

I only recall testing with reading the value again inside set speed=20
functions and the Link Speed was always correct by then. I might have also=
=20
tried polling it inside the handler but I'm sorry don't recall anymore if=
=20
I did and what was the end result.

> If you don't poll for the LBMS bit, then you definitely should clear
> it on unbind in case it contains a stale 1.  Or probably clear it in
> any case.



--=20
 i.

--8323328-778893945-1736260158=:1001--

