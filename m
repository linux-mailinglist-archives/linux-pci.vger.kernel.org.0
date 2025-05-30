Return-Path: <linux-pci+bounces-28721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9D5AC91CB
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 16:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B153E4E2BF5
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 14:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A4722D9E4;
	Fri, 30 May 2025 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7mcnJQf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5334E22D782;
	Fri, 30 May 2025 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748616540; cv=none; b=aqx1rE3OIGtBwsgwnndaSdKShMMgnusVVhAlAXoj2NNwT4hPCFrAu9Vt677KSAfnUHL0JxQHInxPs9SsT6vikGPSfelNI+Mc1x07hH28WA61OzBPh1lxX48GxA1TDVZ5L8aIgUG1lnTW2NBmjH4YMUf75rjZKYxZYm45UeV0jzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748616540; c=relaxed/simple;
	bh=l1t2lbZkIgJk2YWm78fuWpLoXURes3FURx6seZJlXE4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z/vTIYM52Fo8zKYQpxA1OE0co7SAVo9wfD/9NNRH+IsBExE2LPjOy6LMZDk2i2VDzfxbpWzHooKvGidyk+dnjrOroq7eEvPzw1hZHsi3KQ0VsUd07lgWvNenGdYJP/WDAgeXzEazAbHl4OGy+xNlgIKxCKWdkOu1EiVD2Wu0aUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7mcnJQf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748616538; x=1780152538;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=l1t2lbZkIgJk2YWm78fuWpLoXURes3FURx6seZJlXE4=;
  b=Z7mcnJQfmrFrQPvT997nZuzp87I3JRVxh8oY/zz7Xn7w+Cl1Ncm418Sg
   lk6ebVQyRnXE7R4CH6qWiqGdprIvqFO3gwv40bJM2vQq0/52sphLLIKYr
   tgQxT07WvUr46R/mN6Wg9QT5+nEoNkfEhx1iKpJeeKTKimOejtt9olL7j
   ZxbkvaaBnnZ77Lq66GxPl3rVaJ+Bpy6uejcNpaq4ub9HrYh04Jyax+p5Q
   Wdv59MLxUYkClG8iOkk9eVcfDcjloK9sYWfncQp6pPv91tEnCMGLE9qxd
   zZZYjwIqqLL2Vzp09/vRufLEDSevyMFNMJe0aEuS72J9Y7Wow7lg/Yaa+
   g==;
X-CSE-ConnectionGUID: A2dW07wwThaXianv5CcYSQ==
X-CSE-MsgGUID: muacGA7qRMy5rYzEiq05xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="54509278"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="54509278"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 07:48:58 -0700
X-CSE-ConnectionGUID: RweaZ+RPTZyoPhIBT7/gSQ==
X-CSE-MsgGUID: MGS2NSGXT+Kp5/4KP+axSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="144872548"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 07:48:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 May 2025 17:48:32 +0300 (EEST)
To: Tudor Ambarus <tudor.ambarus@linaro.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    William McVicker <willmcvicker@google.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <f6ee05f7-174b-76d4-3dbe-12473f676e4d@linux.intel.com>
Message-ID: <867e47dc-9454-c00f-6d80-9718e5705480@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com> <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com> <5f103643-5e1c-43c6-b8fe-9617d3b5447c@linaro.org> <8f281667-b4ef-9385-868f-93893b9d6611@linux.intel.com> <3a47fc82-dc21-46c3-873d-68e713304af3@linaro.org>
 <f6ee05f7-174b-76d4-3dbe-12473f676e4d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-152047510-1748616512=:1000"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-152047510-1748616512=:1000
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 30 May 2025, Ilpo J=E4rvinen wrote:

> On Wed, 28 May 2025, Tudor Ambarus wrote:
> > On 5/6/25 4:53 PM, Ilpo J=E4rvinen wrote:
> > > On Tue, 6 May 2025, Tudor Ambarus wrote:
> > >> On 12/16/24 5:56 PM, Ilpo J=E4rvinen wrote:
> > >>> Resetting resource is problematic as it prevent attempting to alloc=
ate
> > >>> the resource later, unless something in between restores the resour=
ce.
> > >>> Similarly, if fail_head does not contain all resources that were re=
set,
> > >>> those resource cannot be restored later.
> > >>>
> > >>> The entire reset/restore cycle adds complexity and leaving resource=
s
> > >>> into reseted state causes issues to other code such as for checks d=
one
> > >>> in pci_enable_resources(). Take a small step towards not resetting
> > >>> resources by delaying reset until the end of resource assignment an=
d
> > >>> build failure list (fail_head) in sync with the reset to avoid leav=
ing
> > >>> behind resources that cannot be restored (for the case where the ca=
ller
> > >>> provides fail_head in the first place to allow restore somewhere in=
 the
> > >>> callchain, as is not all callers pass non-NULL fail_head).
> > >>>
> > >>> The Expansion ROM check is temporarily left in place while building=
 the
> > >>> failure list until the upcoming change which reworks optional resou=
rce
> > >>> handling.
> > >>>
> > >>> Ideally, whole resource reset could be removed but doing that in a =
big
> > >>> step would make the impact non-tractable due to complexity of all
> > >>> related code.
> > >>>
> > >>> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > >>
> > >> I'm hitting the BUG_ON(!list_empty(&add_list)); in
> > >> pci_assign_unassigned_bus_resources() [1] with 6.15-rc5 and the the
> > >> pixel6 downstream pcie driver.
> > >>
> > >> I saw the thread where "a34d74877c66 PCI: Restore assigned resources
> > >> fully after release" fixes things for some other cases, but it's not=
 the
> > >> case here.
> > >>
> > >> Reverting the following patches fixes the problem:
> > >> a34d74877c66 PCI: Restore assigned resources fully after release
> > >> 2499f5348431 PCI: Rework optional resource handling
> > >> 96336ec70264 PCI: Perform reset_resource() and build fail list in sy=
nc
> > >=20
> > > So it's confirmed that you needed to revert also this last commit=20
> > > 96336ec70264, not just the rework change?
> >=20
> > I needed to revert 96336ec70264 as well otherwise the build fails.
>=20
> Hi again,
>=20
> That's news to me... I seem to have botched the resource assignment rewor=
k=20
> series at some point when I reordered patches and dropped that helper as =
a=20
> result. And it seems the intermediate build fail wasn't caught by LKP :-(=
=2E=20
> (Pretty annoying as I intentionally separated these two to make them=20
> bisectable but not it isn't without amends.)
>=20
> The missing helper is basically this:
>=20
> static bool pci_resource_is_disabled_rom(const struct pci_dev *dev, int r=
esno)
> {
> =09const struct resource *res =3D pci_resource_n(dev, resno);
>=20
> =09return resno =3D=3D PCI_ROM_RESOURCE && !(res->flags & IORESOURCE_ROM_=
ENABLE)
> }
>=20
> (I didn't build test that.)
>=20
> Because of this, the actual culprit could be in 2499f5348431, not it=20
> 96336ec70264 (which would make more sense as it does significant rework=
=20
> on the assignment algorithm).
>=20
> > >> In the working case the add_list list is empty throughout the entire
> > >> body of pci_assign_unassigned_bus_resources().
> > >>
> > >> In the failing case __pci_bus_size_bridges() leaves the add_list not
> > >> empty and __pci_bus_assign_resources() does not consume the list, th=
us
> > >> the BUG_ON. The failing case contains an extra print that's not show=
n
> > >> when reverting the blamed commits:
> > >> [   13.951185][ T1101] pcieport 0000:00:00.0: bridge window [mem
> > >> 0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 1000=
00
> > >>
> > >> I've added some prints trying to describe the code path, see
> > >> https://paste.ofcode.org/Aeu2YBpLztc49ZDw3uUJmd#
> > >>
> > >> Failing case:
> > >> [   13.944231][ T1101] pci 0000:01:00.0: [144d:a5a5] type 00 class
> > >> 0x000000 PCIe Endpoint
> > >> [   13.944412][ T1101] pci 0000:01:00.0: BAR 0 [mem
> > >> 0x00000000-0x000fffff 64bit]
> > >> [   13.944532][ T1101] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000f=
fff
> > >> pref]
> > >> [   13.944649][ T1101] pci 0000:01:00.0: enabling Extended Tags
> > >> [   13.944844][ T1101] pci 0000:01:00.0: PME# supported from D0 D3ho=
t D3cold
> > >> [   13.945015][ T1101] pci 0000:01:00.0: 15.752 Gb/s available PCIe
> > >> bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:00.0 (capable=
 of
> > >> 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
> > >> [   13.950616][ T1101] __pci_bus_size_bridges: before pbus_size_mem.
> > >> list empty? 1
> > >> [   13.950784][ T1101] pbus_size_mem: 2. list empty? 1
> > >> [   13.950886][ T1101] pbus_size_mem: 1 list empty? 0
> > >> [   13.950982][ T1101] pbus_size_mem: 3. list empty? 0
> > >> [   13.951082][ T1101] pbus_size_mem: 4. list empty? 0
> > >> [   13.951185][ T1101] pcieport 0000:00:00.0: bridge window [mem
> > >> 0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 1000=
00
> > >> [   13.951448][ T1101] __pci_bus_size_bridges: after pbus_size_mem. =
list
> > >> empty? 0
> > >> [   13.951643][ T1101] pci_assign_unassigned_bus_resources: before
> > >> __pci_bus_assign_resources -> list empty? 0
> > >> [   13.951924][ T1101] pcieport 0000:00:00.0: bridge window [mem
> > >> 0x40000000-0x401fffff]: assigned
> > >> [   13.952248][ T1101] pci_assign_unassigned_bus_resources: after
> > >> __pci_bus_assign_resources -> list empty? 0
> > >> [   13.952634][ T1101] ------------[ cut here ]------------
> > >> [   13.952818][ T1101] kernel BUG at drivers/pci/setup-bus.c:2514!
> > >> [   13.953045][ T1101] Internal error: Oops - BUG: 00000000f2000800 =
[#1]
> > >>  SMP
> > >> ...
> > >> [   13.976086][ T1101] Call trace:
> > >> [   13.976206][ T1101]  pci_assign_unassigned_bus_resources+0x110/0x=
114 (P)
> > >> [   13.976462][ T1101]  pci_rescan_bus+0x28/0x48
> > >> [   13.976628][ T1101]  exynos_pcie_rc_poweron
> > >>
> > >> Working case:
> > >> [   13.786961][ T1120] pci 0000:01:00.0: [144d:a5a5] type 00 class
> > >> 0x000000 PCIe Endpoint
> > >> [   13.787136][ T1120] pci 0000:01:00.0: BAR 0 [mem
> > >> 0x00000000-0x000fffff 64bit]
> > >> [   13.787280][ T1120] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000f=
fff
> > >> pref]
> > >> [   13.787541][ T1120] pci 0000:01:00.0: enabling Extended Tags
> > >> [   13.787808][ T1120] pci 0000:01:00.0: PME# supported from D0 D3ho=
t D3cold
> > >> [   13.787988][ T1120] pci 0000:01:00.0: 15.752 Gb/s available PCIe
> > >> bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:00.0 (capable=
 of
> > >> 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
> > >> [   13.795279][ T1120] __pci_bus_size_bridges: before pbus_size_mem.
> > >> list empty? 1
> > >> [   13.795408][ T1120] pbus_size_mem: 2. list empty? 1
> > >> [   13.795495][ T1120] pbus_size_mem: 2. list empty? 1
> > >> [   13.795577][ T1120] __pci_bus_size_bridges: after pbus_size_mem. =
list
> > >> empty? 1
> > >> [   13.795692][ T1120] pci_assign_unassigned_bus_resources: before
> > >> __pci_bus_assign_resources -> list empty? 1
> > >> [   13.795849][ T1120] pcieport 0000:00:00.0: bridge window [mem
> > >> 0x40000000-0x401fffff]: assigned
> > >> [   13.796072][ T1120] pci_assign_unassigned_bus_resources: after
> > >> __pci_bus_assign_resources -> list empty? 1
> > >> [   13.796662][ T1120] cpif: s5100_poweron_pcie: DBG: MSI sfr not se=
t
> > >> up, yet(s5100_pdev is NULL)
> > >> [   13.796666][ T1120] cpif: register_pcie: s51xx_pcie_init start
> > >>
> > >>
> > >> Any hints are welcomed. Thanks,
> > >> ta
> > >=20
> > > Hi and thanks for the report.
> >=20
> > Hi! Thanks for the help. I've been out of office for the last 2 weeks,
> > sorry for the delayed reply.
>=20
> Np.
>=20
> > > The interesting part occurs inside reassign_resources_sorted() where =
most=20
> > > items are eliminated from realloc_head by the list_del().
> > >=20
> > > My guess is that somehow, the change in 96336ec70264 from !res->flags
> > > to the more complicated check somehow causes this. If the new check=
=20
> > > doesn't match and subsequently, no match is found from the head list,=
 the=20
> > > loop will do continue and not remove the entry from realloc_head.
> >=20
> > I added a print right there and it seems it's something else. See below=
=2E
> > >=20
> > > But it's hard to confirm without knowing what that resources realloc_=
head=20
> > > contains. Perhaps if you print the resources that are processed aroun=
d=20
> > > that part of the code in reassign_resources_sorted(), comparing the l=
og=20
> > > from the reverted code with the non-working case might help to unders=
tand=20
> > > what is different there and why. To understand better what is in the =
head=20
> > > list, it would be also useful to know from which device the resources=
 were=20
> > > added into the head list in pdev_sort_resources().
> > >=20
> >=20
> > I added the suggested prints
> > (https://paste.ofcode.org/DgmZGGgS6D36nWEzmfCqMm) on top of v6.15 with
> > the downstream PCIe pixel driver and I obtain the following. Note that
> > all added prints contain "tudor" for differentiation.
> >=20
> > [   15.211179][ T1107] pci 0001:01:00.0: [144d:a5a5] type 00 class
> > 0x000000 PCIe Endpoint
> > [   15.212248][ T1107] pci 0001:01:00.0: BAR 0 [mem
> > 0x00000000-0x000fffff 64bit]
> > [   15.212775][ T1107] pci 0001:01:00.0: ROM [mem 0x00000000-0x0000ffff
> > pref]
> > [   15.213195][ T1107] pci 0001:01:00.0: enabling Extended Tags
> > [   15.213720][ T1107] pci 0001:01:00.0: PME# supported from D0 D3hot
> > D3cold
> > [   15.214035][ T1107] pci 0001:01:00.0: 15.752 Gb/s available PCIe
> > bandwidth, limited by 8.0 GT/s PCIe x2 link at 0001:00:00.0 (capable of
> > 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
> > [   15.222286][ T1107] pci 0001:01:00.0: tudor: 1: pbus_size_mem: BAR 0
> > [mem 0x00000000-0x000fffff 64bit] list empty? 1
> > [   15.222813][ T1107] pci 0001:01:00.0: tudor: 1: pbus_size_mem: ROM
> > [mem 0x00000000-0x0000ffff pref] list empty? 1
> > [   15.224429][ T1107] pci 0001:01:00.0: tudor: 2: pbus_size_mem: ROM
> > [mem 0x00000000-0x0000ffff pref] list empty? 0
> > [   15.224750][ T1107] pcieport 0001:00:00.0: bridge window [mem
> > 0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 100000
> >=20
> > [   15.225393][ T1107] tudor : pci_assign_unassigned_bus_resources:
> > before __pci_bus_assign_resources -> list empty? 0
> > [   15.225594][ T1107] pcieport 0001:00:00.0: tudor:
> > pdev_sort_resources: bridge window [mem 0x00100000-0x001fffff] resource
> > added in head list
> > [   15.226078][ T1107] pcieport 0001:00:00.0: bridge window [mem
> > 0x40000000-0x401fffff]: assigned
>=20
> So here it ends up assigning the resource here I think.
>=20
>=20
> That print isn't one of yours in reassign_resources_sorted() so the=20
> assignment must have been made in assign_requested_resources_sorted(). Bu=
t=20
> then nothing is printed out from reassign_resources_sorted() so I suspect=
=20
> __assign_resources_sorted() has short-circuited.
>=20
> We know that realloc_head is not empty, so that leaves the goto out from=
=20
> if (list_empty(&local_fail_head)), which kind of makes sense, all=20
> entries on the head list were assigned. But the code there tries to remov=
e=20
> all head list resources from realloc_head so why it doesn't get removed i=
s=20
> still a mystery. assign_requested_resources_sorted() doesn't seem to=20
> remove anything from the head list so that resource should still be on th=
e=20
> head list AFAICT so it should call that remove_from_list(realloc_head,=20
> dev_res->res) for it.
>=20
> So can you see if that theory holds water and it short-circuits without=
=20
> removing the entry from realloc_head?

I think I figured out more about the reason. It's not related to that=20
bridge window resource.

pbus_size_mem() will add also that ROM resource into realloc_head=20
as it is considered (intentionally) optional after the optional change
(as per "tudor: 2:" line). And that resource is never assigned because=20
pdev_sort_resources() didn't pick it up into the head list. The next=20
question is why the ROM resource isn't in the head list.


While it is not necessarily related to issue, I think the bridge sizing=20
functions too should consider pdev_resources_assignable() so that it
won't ever add resources from such devices onto the realloc_head. This is=
=20
yet another small inconsistency within all this fitting/assignment logic.

pbus_size_mem() seems to consider IORESOURCE_PCI_FIXED so that cannot=20
explain it as the ROM resource wouldn't be on the realloc_head list in=20
that case.


Just wanted to let you know early even if I don't fully understand=20
everything so you can hopefully avoid unnecessary debugging.

> > [   15.226419][ T1107] tudor : pci_assign_unassigned_bus_resources:
> > after __pci_bus_assign_resources -> list empty? 0
> > [   15.226442][ T1107] ------------[ cut here ]------------
> > [   15.227587][ T1107] kernel BUG at drivers/pci/setup-bus.c:2522!
> > [   15.227813][ T1107] Internal error: Oops - BUG: 00000000f2000800 [#1=
]
> >  SMP
> > ...
> > [   15.251570][ T1107] Call trace:
> > [   15.251690][ T1107]  pci_assign_unassigned_bus_resources+0x110/0x114=
 (P)
> > [   15.251945][ T1107]  pci_rescan_bus+0x28/0x48
> >=20
> > I obtain the following output when using the same prints adapted
> > (https://paste.ofcode.org/37w7RnKkPaCxyNhi5yhZPbZ) and with the blamed
> > commits reverted:
> > a34d74877c66 PCI: Restore assigned resources fully after release
> > 2499f5348431 PCI: Rework optional resource handling
> > 96336ec70264 PCI: Perform reset_resource() and build fail list in sync
> >=20
> > [   15.200456][ T1102] pci 0000:01:00.0: [144d:a5a5] type 00 class
> > 0x000000 PCIe Endpoint
> > [   15.200632][ T1102] pci 0000:01:00.0: BAR 0 [mem
> > 0x00000000-0x000fffff 64bit]
> > [   15.200755][ T1102] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff
> > pref]
> > [   15.200876][ T1102] pci 0000:01:00.0: enabling Extended Tags
> > [   15.201075][ T1102] pci 0000:01:00.0: PME# supported from D0 D3hot D=
3cold
> > [   15.201254][ T1102] pci 0000:01:00.0: 15.752 Gb/s available PCIe
> > bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:00.0 (capable of
> > 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
> > [   15.206555][ T1102] pci 0000:01:00.0: tudor: 1: pbus_size_mem: BAR 0
> > [mem 0x00000000-0x000fffff 64bit] list empty? 1
> > [   15.206737][ T1102] pci 0000:01:00.0: tudor: 1: pbus_size_mem: ROM
> > [mem 0x00000000-0x0000ffff pref] list empty? 1
> > [   15.206901][ T1102] tudor : pci_assign_unassigned_bus_resources:
> > before __pci_bus_assign_resources -> list empty? 1
> > [   15.207072][ T1102] pcieport 0000:00:00.0: tudor:
> > pdev_sort_resources: bridge window [mem 0x00100000-0x002fffff] resource
> > added in head list
> > [   15.207396][ T1102] pcieport 0000:00:00.0: bridge window [mem
> > 0x40000000-0x401fffff]: assigned
> > [   15.208165][ T1102] tudor : pci_assign_unassigned_bus_resources:
> > after __pci_bus_assign_resources -> list empty? 1
> > [   15.208783][ T1102] cpif: s5100_poweron_pcie: DBG: MSI sfr not set
> > up, yet(s5100_pdev is NULL)
> > [   15.208786][ T1102] cpif: register_pcie: s51xx_pcie_init start
> >=20
> > > In any case, that BUG_ON() seems a bit drastic action for what might =
be=20
> > > just a single resource allocation failure so it should be downgraded =
to:
> > >=20
> > > if (WARN_ON(!list_empty(&add_list))
> > > =09free_list(&add_list);
> > > =09
> > > ... or WARN_ON_ONCE().
> >=20
> > I saw your patch doing this, the phone now boots, but obviously I still
> > see the WARN, so maybe there's still something to be fixed.
>=20
> Yes, I don't expect BUG_ON() -> WARN "fix" anything, it just downgrades=
=20
> the severity so that the system can still try to boot, which can often=20
> succeed as this tends to be non-critical failure in many cases so it's=20
> useful change to have regardless despite the splat.
>=20
> Now that it boots, can you please check if /proc/iomem is the same both i=
n=20
> the non-working and working config. If that resource got assigned=20
> successfully, it might well be there is no actual differences in the=20
> assigned resources (which again doesn't mean there wouldn't be a bug in=
=20
> the logic as discussed above).
>=20
>=20
>=20

--=20
 i.

--8323328-152047510-1748616512=:1000--

