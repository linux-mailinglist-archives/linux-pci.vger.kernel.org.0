Return-Path: <linux-pci+bounces-7108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5B58BCD35
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 13:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6654FB23550
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 11:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3B2142640;
	Mon,  6 May 2024 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOuIyq96"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394481428FC;
	Mon,  6 May 2024 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714996545; cv=none; b=cyCIUw1aC14dM/xNM1vJJ5Y7JbEHJJ5OwYd/dZaLHqMT37IN4AmEw59j2pc+0kuHlMHYkVEPGfcXOSpKgwNtR+IGmDoQG/pPVWtBB91FaBeatKf4Wq8LrbEAUgR72os2ze4ap/XW01++EsJnXnpCeGBabF9XrzksLfMu4/z6zZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714996545; c=relaxed/simple;
	bh=9NTvU7mlrOoPEdhmWp3HvyNW7fjbGYtdpvHKn8GqkPY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d8H0pSQkqC3QfMm2VYBxNwwG1wxP4sJ9lEh40D1JYPhpvU2ZsWRbNqvmRSLBWhBRqcvFaWqiXYng/2dgSXyC8sc1r+CVl4FIWiLjtFOY6ZytPUZMGfkxhefpKWTTHGB/AY65HcaW64Zm0fB3quNeldngCOftahqD2jeChVfkgAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOuIyq96; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714996544; x=1746532544;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=9NTvU7mlrOoPEdhmWp3HvyNW7fjbGYtdpvHKn8GqkPY=;
  b=kOuIyq96i7bpiEknWU2bMNeIwjsfmbp+mPyxUqFrvg6SwrZ8KIaZxCZJ
   IagjysPK9hhFX2U5aeC7YCPYMkZot9+QMuWVhD/hSvYwuSqT22TkTJO55
   5ibQdN24cKNp51n9H4V9LMn2ifXxMTuM0ISiyo2fpymNFoaluPj+b6nXi
   dqQbfEsFigh5o4R5l6qokByJLG6CSyKSgxeS69fdT2ukdbyT0AxP6QlPH
   8kxSOCGXU9Jvqiy2ZGHFlKFzqnfExlpIWoyFQ/aQR0G3522ufEp2BLuWR
   GP7M6wtJBf1nBip2ar3dWnzu7Fz1G0Ry5tOhRmkGQOMPmx7+IM/srGZrI
   Q==;
X-CSE-ConnectionGUID: vp4HvGh0RdOP2+BnVWs5sA==
X-CSE-MsgGUID: DYw88TlFREGQKkoblPyycQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10860220"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="10860220"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 04:55:43 -0700
X-CSE-ConnectionGUID: TuC/UpNcTIeNVx9s8GOtPQ==
X-CSE-MsgGUID: sRW8x/SmSa+7FC3ec4QHFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="59329693"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.68])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 04:55:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 6 May 2024 14:55:32 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Igor Mammedov <imammedo@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] PCI: Relax bridge window tail sizing rules
In-Reply-To: <20240503204344.GA1600219@bhelgaas>
Message-ID: <ad7b90e5-c995-2a1d-4d30-1026bf8abe69@linux.intel.com>
References: <20240503204344.GA1600219@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-193508166-1714992777=:1111"
Content-ID: <995c4e7e-25e3-a943-30d9-535698dd1501@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-193508166-1714992777=:1111
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <778e4794-77f8-2106-6726-a596118654aa@linux.intel.com>

On Fri, 3 May 2024, Bjorn Helgaas wrote:

> On Thu, Dec 28, 2023 at 06:57:07PM +0200, Ilpo J=E4rvinen wrote:
> > During remove & rescan cycle, PCI subsystem will recalculate and adjust
> > the bridge window sizing that was initially done by "BIOS". The size
> > calculation is based on the required alignment of the largest resource
> > among the downstream resources as per pbus_size_mem() (unimportant or
> > zero parameters marked with "..."):
> >=20
> > =09min_align =3D calculate_mem_align(aligns, max_order);
> > =09size0 =3D calculate_memsize(size, ..., min_align);
> >=20
> > and then in calculate_memsize():
> > =09size =3D ALIGN(max(size, ...) + ..., align);
> >=20
> > If the original bridge window sizing tried to conserve space, this will
> > lead to massive increase of the required bridge window size when the
> > downstream has a large disparity in BAR sizes. E.g., with 16MiB and
> > 16GiB BARs this results in 32GiB bridge window size even if 16MiB BAR
> > does not require gigabytes of space to fit.
>=20
> Trying to understand exactly what "relaxed window tail sizing rules"
> means.
>
> Previous calculation "based on the required alignment of the largest
> resource among downstream resources."  If a 16GiB BAR and a 16MiB BAR
> leads to a 32GiB window, obviously we need a 16GiB-aligned area.  Are
> you saying we also require the *size* to be 16GiB aligned?  So we add
> 16GiB + 16MiB to get the required size, then round it up to a 16GiB
> multiple?

Yes. That's what I meant above but now after rechecking because not all=20
numbers seemed match (I started to wonder why it's 0x600000000, not=20
0x800000000), I realize there's small twist in this I've missed in=20
this description:

calculate_mem_align() does min_align =3D align1 >> 1 so it's actually=20
aligning the size by half of the largest BAR so 8GiB, not by 16GiB. Thus,
without this series 16GiB + 8GiB =3D 24GiB is needed, not 32GiB as I=20
errornously write above. Nonetheless, it's still excessive and we hit the=
=20
same issue.

(I'll correct this part of the description in the next version of the=20
patch.)

> And "relaxed window tail" means what?  I guess we don't require as
> much alignment of the size?

Yes. There are two ways to align, one is for the start address, whereas=20
the "tail" refers to the size (or space), i.e., whether to leave extra=20
space or not beyond the minimum 1MiB alignment.

> Obviously we need at least 1MiB alignment because that's how bridge
> windows work.  If downstream resources could be packed, e.g., sort
> them into descending size, align window to size of largest downstream
> resource, assign smaller ones adjacent to preceding larger ones, it
> should be a minimal size.
>
> But I assume we have to do this individually for each bridge level,
> including any BARs at that level along with bridge windows to the next
> level downstream.
>=20
> Does "relaxed window tail sizing" mean we don't allocate any more
> space than is strictly required for the BARs currently present?

Yes. One important thing to consider in addition is that the reason we=20
have to do this is because of an upstream bridge window that is already=20
assigned, i.e., fixed in place and cannot be changed in general case by=20
releasing and moving it elsewhere. This condition happens, e.g., during=20
remove/rescan cycle of a device, the resources of the Root Port are
already assigned. If original resource allocation done by the BIOS did not=
=20
allocate for the extra space, the rescan ends up failing despite=20
everything working perfectly before the remove/rescan cycle.

I'm open to better wording/terminology, if you have a better suggestion
than "relaxed window tail sizing".

> > When doing remove & rescan for a bus that contains such a PCI device, a
> > larger bridge window is suddenly required on rescan but when there is a
> > bridge window upstream that is already assigned based on the original
> > size, it cannot be enlarged to the new requirement. This causes the
> > allocation of the bridge window to fail (0x600000000 > 0x400ffffff):
> >=20
> > pci 0000:02:01.0: PCI bridge to [bus 03]
> > pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> > pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit =
pref]
> > pci 0000:01:00.0: PCI bridge to [bus 02-04]
> > pci 0000:01:00.0:   bridge window [mem 0x40400000-0x406fffff]
> > pci 0000:01:00.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit =
pref]
> > ...
> > pci_bus 0000:03: busn_res: [bus 03] is released
> > pci 0000:03:00.0: reg 0x10: [mem 0x6400000000-0x6400ffffff 64bit pref]
> > pci 0000:03:00.0: reg 0x18: [mem 0x6000000000-0x63ffffffff 64bit pref]
> > pci 0000:03:00.0: reg 0x30: [mem 0x40400000-0x405fffff pref]
> > pci 0000:02:01.0: PCI bridge to [bus 03]
> > pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> > pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit =
pref]
> > pci 0000:02:01.0: BAR 9: no space for [mem size 0x600000000 64bit pref]
> > pci 0000:02:01.0: BAR 9: failed to assign [mem size 0x600000000 64bit p=
ref]
> > pci 0000:02:01.0: BAR 8: assigned [mem 0x40400000-0x405fffff]
> > pci 0000:03:00.0: BAR 2: no space for [mem size 0x400000000 64bit pref]
> > pci 0000:03:00.0: BAR 2: failed to assign [mem size 0x400000000 64bit p=
ref]
> > pci 0000:03:00.0: BAR 0: no space for [mem size 0x01000000 64bit pref]
> > pci 0000:03:00.0: BAR 0: failed to assign [mem size 0x01000000 64bit pr=
ef]
> > pci 0000:03:00.0: BAR 6: assigned [mem 0x40400000-0x405fffff pref]
> > pci 0000:02:01.0: PCI bridge to [bus 03]
> > pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> >=20
> > This is a major surprise for users who are suddenly left with a PCIe
> > device that was working fine with the original bridge window sizing.
> >=20
> > Even if the already assigned bridge window could be enlarged by
> > reallocation in some cases (something the current code does not attempt
> > to do), it is not possible in general case and the large amount of
> > wasted space at the tail of the bridge window may lead to other
> > resource exhaustion problems on Root Complex level (think of multiple
> > PCIe cards with VFs and BAR size disparity in a single system).
> >=20
> > PCI specifications only expect natural alignment for BARs (PCI Express
> > Base Specification, rev. 6.1 sect. 7.5.1.2.1) and minimum of 1MiB
> > alignment for the bridge window (PCI Express Base Specification,
> > rev 6.1 sect. 7.5.1.3). The current bridge window tail alignment rule
> > was introduced in the commit 5d0a8965aea9 ("[PATCH] 2.5.14: New PCI
> > allocation code (alpha, arm, parisc) [2/2]") that only states:
> > "pbus_size_mem: core stuff; tested with randomly generated sets of
> > resources". It does not explain the motivation for the extra tail space
> > allocated that is not truly needed by the downstream resources. As
> > such, it is far from clear if it ever has been required by any HW.
> >=20
> > To prevent PCIe cards with BAR size disparity from becoming unusable
> > after remove & rescan cycle, attempt to do a truly minimal allocation
> > for memory resources if needed. First check if the normally calculated
> > bridge window will not fit into an already assigned upstream resource.
> > In such case, try with relaxed bridge window tail sizing rules instead
> > where no extra tail space is requested beyond what the downstream
> > resources require. Only enforce the alignment requirement of the bridge
> > window itself (normally 1MiB).
> >=20
> > With this patch, the resources are successfully allocated:
> >=20
> > pci 0000:02:01.0: PCI bridge to [bus 03]
> > pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> > pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit =
pref]
> > pci 0000:02:01.0: bridge window [mem 0x6000000000-0x6400ffffff 64bit pr=
ef] to [bus 03] requires relaxed alignment rules
>=20
> I guess the relaxed rules are required because this window doesn't fit
> inside some upstream window?  Maybe include the upstream window in the
> example here.  In the code, do we know the upstream window at this
> point?  If so, maybe the message could include it?

Okay, I changed the severity of the pci_dbg() inside=20
pbus_upstream_assigned_limit()? It reveals this very information:

pcieport 0000:01:00.0: Assigned bridge window [mem 0x6000000000-0x6400fffff=
f 64bit pref] to [bus 02-04] cannot fit 0x600000000 required for 0000:02:01=
=2E0 bridging to [bus 03]

> But I'm missing something because it looks like we assigned the same
> window (0x6000000000-0x6400ffffff) below.  What exactly is different?
> It looks like the 02:01.0 windows below are the same as the ones where
> it failed above.

Without this series, the tail aligned is taken from the largest resource=20
so as per 03:00.0 BAR 2's size so it would need 0x6000000000-0x65ffffffff
(min_align =3D align1 >> 1 inside calculate_mem_align()).
It would, of course, leave 0x6400ffffff-0x65ffffffff unused but since it=20
won't fit into this (from above):

> > pci 0000:01:00.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit =
pref]

it ends up failing without this series.

So effectively, this series just makes things work with the same sizes as=
=20
they did before the remove/rescan cycle, matching what you noticed!

> > pci 0000:02:01.0: BAR 9: assigned [mem 0x6000000000-0x6400ffffff 64bit =
pref]
> > pci 0000:02:01.0: BAR 8: assigned [mem 0x40400000-0x405fffff]
> > pci 0000:03:00.0: BAR 2: assigned [mem 0x6000000000-0x63ffffffff 64bit =
pref]
> > pci 0000:03:00.0: BAR 0: assigned [mem 0x6400000000-0x6400ffffff 64bit =
pref]
> > pci 0000:03:00.0: BAR 6: assigned [mem 0x40400000-0x405fffff pref]
> > pci 0000:02:01.0: PCI bridge to [bus 03]
> > pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> > pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit =
pref]
>=20
> Nit, I think if these examples were collected from a newer kernel,
> "reg 0x10" would be replaced with "BAR 0" so the messages would be
> slightly easier to read.

Okay, I'll take the logs from a later kernel.

> > This patch draws inspiration from the initial investigations and work
> > by Mika Westerberg.
> >=20
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D216795
> > Link: https://lore.kernel.org/linux-pci/20190812144144.2646-1-mika.west=
erberg@linux.intel.com/
> > Fixes: 5d0a8965aea9 ("[PATCH] 2.5.14: New PCI allocation code (alpha, a=
rm, parisc) [2/2]")
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/pci/setup-bus.c | 74 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 72 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index e3e6ff8854a7..7a32283262c2 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/ioport.h>
> >  #include <linux/cache.h>
> > +#include <linux/limits.h>
> >  #include <linux/slab.h>
> >  #include <linux/acpi.h>
> >  #include "pci.h"
> > @@ -960,6 +961,62 @@ static inline resource_size_t calculate_mem_align(=
resource_size_t *aligns,
> >  =09return min_align;
> >  }
> > =20
> > +/**
> > + * pbus_upstream_assigned_limit - Check no upstream resource limits al=
location
> > + * @bus:=09The bus
> > + * @mask:=09Mask the resource flag, then compare it with type
> > + * @type:=09The type of resource from bridge
> > + * @size:=09The size required from the bridge window
> > + * @align:=09Required alignment for the resource
> > + *
> > + * Checks that @size can fit inside the upstream bridge resources that=
 are
> > + * already assigned.
> > + *
> > + * Return: -ENOSPC if @size cannot fit into an already assigned resour=
ce
> > + * upstream resource.
>=20
> I guess this returns 0 on success, right?  But more comments below.

Yes, 0 when size fits to upstream bridge windows.

> > + */
> > +static int pbus_upstream_assigned_limit(struct pci_bus *bus, unsigned =
long mask,
> > +=09=09=09=09=09unsigned long type, resource_size_t size,
> > +=09=09=09=09=09resource_size_t align)
> > +{
> > +=09struct resource_constraint constraint =3D {
> > +=09=09.max =3D RESOURCE_SIZE_MAX,
> > +=09=09.align =3D align,
> > +=09};
> > +=09struct pci_bus *downstream =3D bus;
> > +=09struct resource *r;
> > +
> > +=09while ((bus =3D bus->parent)) {
> > +=09=09if (pci_is_root_bus(bus))
> > +=09=09=09break;
> > +
> > +=09=09pci_bus_for_each_resource(bus, r) {
> > +=09=09=09if (!r || !r->parent || (r->flags & mask) !=3D type)
> > +=09=09=09=09continue;
> > +
> > +=09=09=09if (resource_size(r) >=3D size) {
> > +=09=09=09=09struct resource gap =3D {};
> > +
> > +=09=09=09=09if (!find_empty_resource_slot(r, &gap, size, &constraint))
>=20
> I would test "find_empty_resource_slot(...) =3D=3D 0" since it doesn't
> return a boolean.

Okay.

> IIUC, when find_empty_resource_slot() returns 0, it fills in
> gap.start/end/flags.  Is there anything useful we can do with that
> information, e.g., a dbg log message?

Log something for success? I suppose it could be done but I don't expect=20
it to be that valuable since the expected behavior is the alloc will then=
=20
succeed too.

For the case where relaxed tail sizing is required, I made the pci_dbg()=20
into pci_info()

> I think find_empty_resource_slot() doesn't actually *allocate* the
> space, right?

Yes, the calculation and allocation for these resources is like this.=20
Things are first calculated and only allocated by the later stage.

> So there would be a race between this and the
> allocation in pci_claim_resource(), except that there's nobody else
> allocating in this hierarchy because ...?

Rescanning is protected by pci_rescan_remove_lock, no?

> > +=09=09=09=09=09return 0;
> > +=09=09=09}
> > +
> > +=09=09=09if (bus->self) {
> > +=09=09=09=09pci_dbg(bus->self,
> > +=09=09=09=09=09"Assigned bridge window %pR to %pR cannot fit 0x%llx re=
quired for %s bridging to %pR\n",
> > +=09=09=09=09=09r, &bus->busn_res,
> > +=09=09=09=09=09(unsigned long long)size,
> > +=09=09=09=09=09pci_name(downstream->self),
> > +=09=09=09=09=09&downstream->busn_res);
> > +=09=09=09}
> > +
> > +=09=09=09return -ENOSPC;
> > +=09=09}
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> >  /**
> >   * pbus_size_mem() - Size the memory window of a given bus
> >   *
> > @@ -986,7 +1043,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsi=
gned long mask,
> >  =09=09=09 struct list_head *realloc_head)
> >  {
> >  =09struct pci_dev *dev;
> > -=09resource_size_t min_align, align, size, size0, size1;
> > +=09resource_size_t min_align, win_align, align, size, size0, size1;
> >  =09resource_size_t aligns[24]; /* Alignments from 1MB to 8TB */
> >  =09int order, max_order;
> >  =09struct resource *b_res =3D find_bus_resource_of_type(bus,
> > @@ -1064,10 +1121,23 @@ static int pbus_size_mem(struct pci_bus *bus, u=
nsigned long mask,
> >  =09=09}
> >  =09}
> > =20
> > +=09win_align =3D window_alignment(bus, b_res->flags);
> >  =09min_align =3D calculate_mem_align(aligns, max_order);
> > -=09min_align =3D max(min_align, window_alignment(bus, b_res->flags));
> > +=09min_align =3D max(min_align, win_align);
> >  =09size0 =3D calculate_memsize(size, min_size, 0, 0, resource_size(b_r=
es), min_align);
> >  =09add_align =3D max(min_align, add_align);
> > +
> > +=09if (bus->self && size0 &&
> > +=09    pbus_upstream_assigned_limit(bus, mask | IORESOURCE_PREFETCH, t=
ype,
> > +=09=09=09=09=09 size0, add_align)) {
>=20
> The IORESOURCE_PREFETCH here -- does that just mean that "type" must
> match exactly, including whether IORESOURCE_PREFETCH is set or not?

This just matches what the other calculation in pbus_size_mem() does:

        struct resource *b_res =3D find_bus_resource_of_type(bus,
                                        mask | IORESOURCE_PREFETCH, type);

Do you think it's wrong?

> I guess pbus_upstream_assigned_limit() being true (-ENOSPC) basically
> means there's no available space for "size0, add_align" in the
> upstream window?
>=20
> Since it's used as a predicate, I wonder if it could return true/false
> and be named something like "pbus_upstream_space_available()" and test
> it with "!pbus_upstream_space_available()" here?

I'll make this change.

> > +=09=09min_align =3D 1ULL << (max_order + 20);
>=20
> We never had any comments about what "max_order" means.  I vaguely
> remember it's basically in 1MB units because of these:
>=20
>   resource_size_t aligns[24]; /* Alignments from 1MB to 8TB */
>=20
>   * aligns[0] is for 1MB (since bridge memory
>   * windows are always at least 1MB aligned), so
>   * keep "order" from being negative for smaller
>   * resources.

I was considering replacing those literal 20s with __ffs(SZ_1M) to make=20
it less magic but I don't now recall why I ended up not pursuing that.
I'm sure I even looked if there were changes on assembly level (which=20
unfortunately happened even if it seemed something that should not produce=
=20
binary changes at all) but now I cannot even seem to find where that=20
patch has gone and even less to remember why I put it into backburner...=20
I'll look into it again.

> > +=09=09min_align =3D max(min_align, win_align);
> > +=09=09size0 =3D calculate_memsize(size, min_size, 0, 0, resource_size(=
b_res), win_align);
> > +=09=09add_align =3D win_align;
> > +=09=09pci_info(bus->self, "bridge window %pR to %pR requires relaxed a=
lignment rules\n",
> > +=09=09=09 b_res, &bus->busn_res);
>=20
> Is there any hint we can give in the message about what "relaxed
> alignment rules" means, or how we decided we needed them?

The extra information would be given by the pci_dbg() whose severity now
upped from dbg to info level.


--=20
 i.
--8323328-193508166-1714992777=:1111--

