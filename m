Return-Path: <linux-pci+bounces-23977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 033A1A65BF0
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 19:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58403BEBB6
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 18:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600DC1ACEDE;
	Mon, 17 Mar 2025 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cEQXogVo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C619F420;
	Mon, 17 Mar 2025 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234902; cv=none; b=N3mt5rS+B0bwhG4u+5yOW+Y8kntQahFHT2I8c73LITd5DhPhhQA3vGbc0ypcnwtss2IIed2qSkQUXE7fXUGfIgFk1QXoKhDcvxWvEK0Ix8tHpOS40cUgq4sIh3ro9nlHRCm25xJRQclXkfa6uOXgdl8eBgqk/UMHfjR96VJU7nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234902; c=relaxed/simple;
	bh=Mu7m47kKBA0YhW5neOWnvRRU9TV9xE/f1KoAz4j7z80=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V3gKShhvLAm/Uo/3+YKSGdP/uc0VR+gsGti1jjcRfCgMh1TZE59mFBrBVja23Npc2uE3wn80aPqOm3VSnLzBVsVZqB20HEvewrcYkYouGZ+nDPHQxKKrxXzD5PSKpbeizNc3oZ6KdC3uck1E4xs7xAF56FYk7wjcTfDr7Gt9Frw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cEQXogVo; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742234901; x=1773770901;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Mu7m47kKBA0YhW5neOWnvRRU9TV9xE/f1KoAz4j7z80=;
  b=cEQXogVoI/93v3JjG60AL3KN47IyjT09dE667TlaNqGcLjbUfpZBItQw
   LKc8Xtn5SIEP1Mfz7o3Ll/fSvKGR+vmAZQAdeTQ27Wq/XDflcNUo/5hYO
   vNT2e2RzU6yd1IOg4WOjfDArTjaUu3YlnVJxbcHs0fPnVy4Wi0djFWWJg
   oQAce3rMcXEPxvG2/WxE33xOSNbu/7mkcmh7B1TcExzYvzO+izYNNhh6F
   nBiIi3plDQmY9xNcAORPdBwRCZvh23KuaH4vimfDMPmJv7kxUcEc5O28x
   pSpY3CSVCwNCj39PHFrKCVryUt7vBz+8aXOFQ2H7iEBQPfX5tX/tQPd0c
   A==;
X-CSE-ConnectionGUID: NhF3RMfoRmaX4piChoRCjw==
X-CSE-MsgGUID: cfIPq2HqQbW3U9NCeL4ZZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43258658"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="43258658"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:08:20 -0700
X-CSE-ConnectionGUID: /lAY/v6iTu2NXtbhs97EQw==
X-CSE-MsgGUID: DGuQfm/TTQe10ci770s4iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="153007123"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.60])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:08:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 17 Mar 2025 20:08:12 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    Guenter Roeck <groeck@juniper.net>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    Rajat Jain <rajatxjain@gmail.com>, 
    Joel Mathew Thomas <proxy0@tutamail.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI/hotplug: Disable HPIE over reset
In-Reply-To: <Z9Wjk2GzrSURZoTG@wunner.de>
Message-ID: <a18432fc-a9ff-0435-cd94-912bf2dcb4b3@linux.intel.com>
References: <20250313142333.5792-1-ilpo.jarvinen@linux.intel.com> <20250313142333.5792-2-ilpo.jarvinen@linux.intel.com> <Z9Wjk2GzrSURZoTG@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-233792055-1742232008=:944"
Content-ID: <2adfc975-5a6a-f98c-67a2-8b6bd7590068@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-233792055-1742232008=:944
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <84f24538-a527-e2dd-d7ca-4ecf85be92af@linux.intel.com>

On Sat, 15 Mar 2025, Lukas Wunner wrote:

> On Thu, Mar 13, 2025 at 04:23:30PM +0200, Ilpo J=E4rvinen wrote:
> > pciehp_reset_slot() disables PDCE (Presence Detect Changed Enable) and
> > DLLSCE (Data Link Layer State Changed Enable) for the duration of reset
> > and clears the related status bits PDC and DLLSC from the Slot Status
> > register after the reset to avoid hotplug incorrectly assuming the card
> > was removed.
> >=20
> > However, hotplug shares interrupt with PME and BW notifications both of
> > which can make pciehp_isr() to run despite PDCE and DLLSCE bits being
> > off. pciehp_isr() then picks PDC or DLLSC bits from the Slot Status
> > register due to the events that occur during reset and caches them into
> > ->pending_events. Later, the IRQ thread in pciehp_ist() will process
> > the ->pending_events and will assume the Link went Down due to a card
> > change (in pciehp_handle_presence_or_link_change()).
> >=20
> > Change pciehp_reset_slot() to also clear HPIE (Hot-Plug Interrupt
> > Enable) as pciehp_isr() will first check HPIE to see if the interrupt
> > is not for it. Then synchronize with the IRQ handling to ensure no
> > events are pending, before invoking the reset.
>=20
> After dwelling on this for a while, I'm thinking that it may re-introduce
> the issue fixed by commit f5eff5591b8f ("PCI: pciehp: Fix AB-BA deadlock
> between reset_lock and device_lock"):
>=20
> Looking at the second and third stack trace in its commit message,
> down_write(reset_lock) in pciehp_reset_slot() is basically equivalent
> to synchronize_irq() and we're holding device_lock() at that point,
> hindering progress of pciehp_ist().

This description was somewhat confusing but what I can see, now that you=20
mentioned this, is that if pciehp_reset_slot() calls synchronize_irq(), it=
=20
can result in trying to acquire device_lock() again while trying to drain=
=20
the pending events. ->reset_lock seems irrelevant to that problem.

Thus, pciehp_reset_slot() cannot ever rely on completing the processing of=
=20
all pending events before it invokes the reset as long as any of its=20
callers is holding device_lock().

It's a bit sad, because removing most of the reset_lock complexity would=20
have been nice simplification in locking, effectively it would have=20
reverted f5eff5591b8f too.

> So I think I have guided you in the wrong direction and I apologize
> for that.
>=20
> However it seems to me that this should be solvable with the small
> patch below.  Am I missing something?
>=20
> @Joel Mathew Thomas, could you give the below patch a spin and see
> if it helps?
>=20
> Thanks!
>=20
> -- >8 --
>=20
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pcieh=
p_hpc.c
> index bb5a8d9f03ad..99a2ac13a3d1 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -688,6 +688,11 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  =09=09return IRQ_HANDLED;
>  =09}
> =20
> +=09/* Ignore events masked by pciehp_reset_slot(). */
> +=09events &=3D ctrl->slot_ctrl;
> +=09if (!events)
> +=09=09return IRQ_HANDLED;
> +
>  =09/* Save pending events for consumption by IRQ thread. */
>  =09atomic_or(events, &ctrl->pending_events);
>  =09return IRQ_WAKE_THREAD;

Yes, this should work, I think.

I'm not entirely sure though how reading ->slot_ctrl here synchronizes=20
wrt. pciehp_reset_slot() invoking reset. What guarantees pciehp_isr() sees=
=20
the updated ->slot_ctrl when pciehp_reset_slot() has proceeded to invoke=20
the reset? (I'm in general very hesitant about lockless and barrierless=20
reader being race free, I might be just paranoid about it.)

--=20
 i.
--8323328-233792055-1742232008=:944--

