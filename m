Return-Path: <linux-pci+bounces-28812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025B9ACB79E
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 17:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3064C79EB
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E693C22579E;
	Mon,  2 Jun 2025 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UqoM80dH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027BF225775;
	Mon,  2 Jun 2025 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877113; cv=none; b=ELBvI2FPGh1Sk+QgSomOayrSGuqNB80FuSLvfDLsAuF91AUkD5WZ9yM748W47gceEyvRT+fAJh/m/BWG9jbR2r5/17rT4p+6HgDhR7eNSgR+jdptKr/w7bDQXuQcbmOI66QN2yN6MWfTFD5NEOmYf2l7ENsHyxcRp6cnRUbrcPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877113; c=relaxed/simple;
	bh=gOC2oQ++Swveh6brUl7iUTCyEWI+ofh0dQSLOoBJnw4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gohJ104lXecEbH6OgqY8QXRo6Obm45s/eqMK5w0UZi209o76hO7IewYSNJ1xvuQcTn8OYbm7pgdYJaXCOkGxFvD+T1SrYlDqVpPs+7gADX95SpN1QZDvxPGKSkZRzCyk1OAq4rZRBqsZ0zYdydTLAceP1O/k9F6APcsSj6Q/tWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UqoM80dH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748877112; x=1780413112;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=gOC2oQ++Swveh6brUl7iUTCyEWI+ofh0dQSLOoBJnw4=;
  b=UqoM80dHqbWkujwN+jgPVIssMCI34WqO0f3vxg6udu3aGLt+red9s0e9
   AYknydxSnbXCa6SvX47cQ/X1agDW2klUtYA9maWj1kh6K5VnXaJTcH5qm
   2Fhn8XYzpZw6oclyYKCLYNnFdHezRTZf9Rf/htWSJx43mTtpAOeAe1dqD
   2IKfz4BrCvk6gIedrsneTiNJMJOe9pNqXHQMMg0XfRqgoRaJaKaex9kb8
   VyfUhQWONLFwxQDwVoNHMO7/kz2tqjOEydoFiBI2VXrEpWutrzcBJB9LN
   yJXwg0M06o6i9yEFoRCLaaE0b5goYL+hCkT5xOjqMINLLMX3rZ8vD0Y9G
   g==;
X-CSE-ConnectionGUID: LAbF9qfbTZSF83WNWATLHw==
X-CSE-MsgGUID: t0VLIX9kRh6CVfxV72Agmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="54684113"
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="54684113"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 08:11:51 -0700
X-CSE-ConnectionGUID: peeS8xo4RwK9GtFPtfZYjA==
X-CSE-MsgGUID: arKZnO/9TtiHykYN7+Ldpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="144396599"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.134])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 08:08:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 2 Jun 2025 18:08:40 +0300 (EEST)
To: Tudor Ambarus <tudor.ambarus@linaro.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    William McVicker <willmcvicker@google.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <a56284a4-755d-4eb4-ba77-9ea30e18d08f@linaro.org>
Message-ID: <7e882cfb-a35a-bab0-c333-76a4e79243b6@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com> <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com> <5f103643-5e1c-43c6-b8fe-9617d3b5447c@linaro.org> <8f281667-b4ef-9385-868f-93893b9d6611@linux.intel.com> <3a47fc82-dc21-46c3-873d-68e713304af3@linaro.org>
 <f6ee05f7-174b-76d4-3dbe-12473f676e4d@linux.intel.com> <867e47dc-9454-c00f-6d80-9718e5705480@linux.intel.com> <a56284a4-755d-4eb4-ba77-9ea30e18d08f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-355235006-1748875598=:1043"
Content-ID: <e205ed44-c96b-ccf5-666f-4f2120125496@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-355235006-1748875598=:1043
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <b63b28f9-f1f1-8cb0-5842-49ba9210c574@linux.intel.com>

On Mon, 2 Jun 2025, Tudor Ambarus wrote:
> On 5/30/25 3:48 PM, Ilpo J=E4rvinen wrote:
> >>> I added the suggested prints
> >>> (https://paste.ofcode.org/DgmZGGgS6D36nWEzmfCqMm) on top of v6.15 wit=
h
> >>> the downstream PCIe pixel driver and I obtain the following. Note tha=
t
> >>> all added prints contain "tudor" for differentiation.
> >>>
> >>> [   15.211179][ T1107] pci 0001:01:00.0: [144d:a5a5] type 00 class
> >>> 0x000000 PCIe Endpoint
> >>> [   15.212248][ T1107] pci 0001:01:00.0: BAR 0 [mem
> >>> 0x00000000-0x000fffff 64bit]
> >>> [   15.212775][ T1107] pci 0001:01:00.0: ROM [mem 0x00000000-0x0000ff=
ff
> >>> pref]
> >>> [   15.213195][ T1107] pci 0001:01:00.0: enabling Extended Tags
> >>> [   15.213720][ T1107] pci 0001:01:00.0: PME# supported from D0 D3hot
> >>> D3cold
> >>> [   15.214035][ T1107] pci 0001:01:00.0: 15.752 Gb/s available PCIe
> >>> bandwidth, limited by 8.0 GT/s PCIe x2 link at 0001:00:00.0 (capable =
of
> >>> 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
> >>> [   15.222286][ T1107] pci 0001:01:00.0: tudor: 1: pbus_size_mem: BAR=
 0
> >>> [mem 0x00000000-0x000fffff 64bit] list empty? 1
> >>> [   15.222813][ T1107] pci 0001:01:00.0: tudor: 1: pbus_size_mem: ROM
> >>> [mem 0x00000000-0x0000ffff pref] list empty? 1
> >>> [   15.224429][ T1107] pci 0001:01:00.0: tudor: 2: pbus_size_mem: ROM
> >>> [mem 0x00000000-0x0000ffff pref] list empty? 0
> >>> [   15.224750][ T1107] pcieport 0001:00:00.0: bridge window [mem
> >>> 0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 10000=
0
> >>>
> >>> [   15.225393][ T1107] tudor : pci_assign_unassigned_bus_resources:
> >>> before __pci_bus_assign_resources -> list empty? 0
> >>> [   15.225594][ T1107] pcieport 0001:00:00.0: tudor:
> >>> pdev_sort_resources: bridge window [mem 0x00100000-0x001fffff] resour=
ce
> >>> added in head list
> >>> [   15.226078][ T1107] pcieport 0001:00:00.0: bridge window [mem
> >>> 0x40000000-0x401fffff]: assigned
> >> So here it ends up assigning the resource here I think.
> >>
> >>
> >> That print isn't one of yours in reassign_resources_sorted() so the=20
> >> assignment must have been made in assign_requested_resources_sorted().=
 But=20
> >> then nothing is printed out from reassign_resources_sorted() so I susp=
ect=20
> >> __assign_resources_sorted() has short-circuited.
> >>
> >> We know that realloc_head is not empty, so that leaves the goto out fr=
om=20
> >> if (list_empty(&local_fail_head)), which kind of makes sense, all=20
> >> entries on the head list were assigned. But the code there tries to re=
move=20
> >> all head list resources from realloc_head so why it doesn't get remove=
d is=20
> >> still a mystery. assign_requested_resources_sorted() doesn't seem to=
=20
> >> remove anything from the head list so that resource should still be on=
 the=20
> >> head list AFAICT so it should call that remove_from_list(realloc_head,=
=20
> >> dev_res->res) for it.
> >>
> >> So can you see if that theory holds water and it short-circuits withou=
t=20
> >> removing the entry from realloc_head?
> > I think I figured out more about the reason. It's not related to that=
=20
> > bridge window resource.
> >=20
> > pbus_size_mem() will add also that ROM resource into realloc_head=20
> > as it is considered (intentionally) optional after the optional change
> > (as per "tudor: 2:" line). And that resource is never assigned because=
=20
>=20
> right, the ROM resource is added into realloc_head here:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/t=
ree/drivers/pci/setup-bus.c#n1202
>=20
> Then in the failing case, and extra resource is added:
> [   15.224750][ T1107] pcieport 0001:00:00.0: bridge window [mem
> 0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 100000
> The above extra print happens just in the failing case. Here's where the
> extra resource is added:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/t=
ree/drivers/pci/setup-bus.c#n1285
>=20
> It seems that in the failing case 2 resources are added into
> realloc_head at the pbus_size_mem() time, whereas with the patch
> reverted - none.
>=20
> Also, in the failing case a smaller resource is added into the list:
> pdev_sort_resources: bridge window [mem 0x00100000-0x001fffff]
> compared to the working case:
> pdev_sort_resources: bridge window [mem 0x00100000-0x002fffff]
>=20
> Can this make a difference?

I don't think the bridge window resource different matters, that bridge=20
resource got assigned just fine so it is a red herring. The code just=20
calculates optional sizes in different place after the rework than before=
=20
it. The successful assignment itself is for the same size so there's=20
nothing wrong there AFAICT.

> > pdev_sort_resources() didn't pick it up into the head list. The next=20
> > question is why the ROM resource isn't in the head list.
> >=20
>=20
> It seems the ROM resource is skipped at:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/t=
ree/drivers/pci/setup-bus.c#n175
>=20
> tudor: pdev_sort_resources: ROM [??? 0x00000000 flags 0x0] resource
> skipped due to !(r->flags) || r->parent

I don't see the device in this print, hope it is for the same device.

In any case, I don't understand what reset resource's flags in between=20
pbus_size_mem() and pdev_sort_resources(), or alternative, why type=20
checking in pbus_size_mem() matches if flags =3D=3D 0 at that point.

Those two functions should work on the same resources, if one skips=20
something, the other should too. Disparity between them can cause issues,=
=20
but despite reading the code multiple times, I couldn't figure out how=20
that disparity occurs (except for the !pdev_resources_assignable() case).

> > While it is not necessarily related to issue, I think the bridge sizing=
=20
> > functions too should consider pdev_resources_assignable() so that it
> > won't ever add resources from such devices onto the realloc_head. This =
is=20
> > yet another small inconsistency within all this fitting/assignment logi=
c.
> >=20
> > pbus_size_mem() seems to consider IORESOURCE_PCI_FIXED so that cannot=
=20
> > explain it as the ROM resource wouldn't be on the realloc_head list in=
=20
> > that case.
> >=20
> >=20
> > Just wanted to let you know early even if I don't fully understand=20
> > everything so you can hopefully avoid unnecessary debugging.
>=20
> Thanks! Would adding some prints in pbus_size_mem() to describe the code
> paths in the working and non-working case help?

It is of interest to know why the same resource is treated differently.
So what were the resource flags, type* args when it's processed by
pbus_size_mem()? If resource's flags are zero at that point but it matches=
=20
one of the types, that would be a bug.

--=20
 i.
--8323328-355235006-1748875598=:1043--

