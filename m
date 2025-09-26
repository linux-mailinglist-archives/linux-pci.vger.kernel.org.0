Return-Path: <linux-pci+bounces-37090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA07FBA3978
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 14:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6399B386927
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 12:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344E725F988;
	Fri, 26 Sep 2025 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bC2Qg0Af"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB0D2E8DFD;
	Fri, 26 Sep 2025 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889287; cv=none; b=hAclej8R8auWKnD8QDtbiFGcO+1eTglkZVx0LuvAsNY8u690UL71rE5M28bwzf4zSqQSh8BOCYvir9iQZtMdJmc+9pLIgyYa8bBpiwz0x4vdy6/rzId/nKyAFpmk0iwTXcoRU7fsra6GlJXNQG/qONG9JZGN7NknfZgIVuXKbvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889287; c=relaxed/simple;
	bh=K/5HPL+5ayVEnB87pTvcPZqRUxBIyyaiU+PXUKcbFRI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NgOKFT5JVhdVtIUsPjIBiZnMQYaRgS5v8S0RQlOHRuiN02wSG4N/NXMKnpbK7wsCexzIjI9sfHOG80pd1EoBiq9UlSq2SkiOOnFs7SLpidPV2arywwLRe5Y5251HU97cSDBNj6VCNn2hHRWF64f+gD4bL6QjotiZazk9vN/I1bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bC2Qg0Af; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758889285; x=1790425285;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=K/5HPL+5ayVEnB87pTvcPZqRUxBIyyaiU+PXUKcbFRI=;
  b=bC2Qg0Afe3sB5AtoomhedMJFl7fs8XZ22bAdRa0aFmBmqccJ0MJSe+GX
   HgpDvXp+hG3ieBsCED9W5clFcxRbERjYYvxa/5E1TaSWSKH0MwfZp4AqR
   s07smGuaKdDvClp1KuPZTxq0T/Pucn1E2TusEHFIGHEFFKmCzXHQQQt05
   wN1FU+Y5qj+FzMaPx1gBN6jFlqckXFvZSVs15hdHjrSMOtDjf35KwsCdI
   euVa+uaQC/BHbzEy8yebiTndkNGnOAFeo+4s6aqkN7bKiO2qnJ+WgexSl
   RCf9Fa9O7u3mcZ1+IUP0Dv+mTdRKjFPdgUtvfkN1XZxxWUoaNtcsESFFD
   Q==;
X-CSE-ConnectionGUID: MitN4dvBTGCZJHChxwJcxA==
X-CSE-MsgGUID: BU09111bTh2kXwe+TXFZdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61329892"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="61329892"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 05:21:24 -0700
X-CSE-ConnectionGUID: N5rL4Gm4Rmq9MiaSn3AgTQ==
X-CSE-MsgGUID: mKUbrb14QYGsYB7v7WMhcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="178054596"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.23])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 05:21:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 26 Sep 2025 15:21:17 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 2/2] PCI: Resources outside their window must set
 IORESOURCE_UNSET
In-Reply-To: <20250925212117.GA2204498@bhelgaas>
Message-ID: <2493cba7-151d-5ce6-5f33-e56966baac7a@linux.intel.com>
References: <20250925212117.GA2204498@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1704151486-1758884017=:1234"
Content-ID: <c113df49-e69e-7a89-850a-fb22c6576160@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1704151486-1758884017=:1234
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <1660701b-a548-f72f-2d3e-ba84fd9ae2be@linux.intel.com>

On Thu, 25 Sep 2025, Bjorn Helgaas wrote:
> On Wed, Sep 24, 2025 at 04:42:28PM +0300, Ilpo J=E4rvinen wrote:
> > PNP resources are checked for conflicts with the other resource in the
> > system by quirk_system_pci_resources() that walks through all PCI
> > resources. quirk_system_pci_resources() correctly filters out resource
> > with IORESOURCE_UNSET.
> >=20
> > Resources that do not reside within their bridge window, however, are
> > not properly initialized with IORESOURCE_UNSET resulting in bogus
> > conflicts detected in quirk_system_pci_resources():
> >=20
> > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit pref]
> > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit pref]: cont=
ains BAR 2 for 7 VFs
> > ...
> > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x1ffffffff 64bit pref]
> > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x3dffffffff 64bit pref]: co=
ntains BAR 2 for 31 VFs
> > ...
> > pnp 00:04: disabling [mem 0xfc000000-0xfc00ffff] because it overlaps 00=
00:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 00=
00:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
> > pnp 00:05: disabling [mem 0xfedc0000-0xfedc7fff] because it overlaps 00=
00:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > pnp 00:05: disabling [mem 0xfeda0000-0xfeda0fff] because it overlaps 00=
00:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > pnp 00:05: disabling [mem 0xfeda1000-0xfeda1fff] because it overlaps 00=
00:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff disabled] because it ov=
erlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > pnp 00:05: disabling [mem 0xfed20000-0xfed7ffff] because it overlaps 00=
00:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > pnp 00:05: disabling [mem 0xfed90000-0xfed93fff] because it overlaps 00=
00:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > pnp 00:05: disabling [mem 0xfed45000-0xfed8ffff] because it overlaps 00=
00:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > pnp 00:05: disabling [mem 0xfee00000-0xfeefffff] because it overlaps 00=
00:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> >=20
> > Mark resources that are not contained within their bridge window with
> > IORESOURCE_UNSET in __pci_read_base() which resolves the false
> > positives for the overlap check in quirk_system_pci_resources().
> >=20
> > Fixes: f7834c092c42 ("PNP: Don't check for overlaps with unassigned PCI=
 BARs")
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >=20
> > This change uses resource_contains() which will reject partial overlaps=
=2E
> > I don't know for sure if partial overlaps should be allowed or not (but
> > they feel as something FW didn't set things up properly so I chose to
> > mark them UNSET as well).
> >=20
> >  drivers/pci/probe.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >=20
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 7f9da8c41620..097389f25853 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -205,6 +205,26 @@ static void __pci_size_rom(struct pci_dev *dev, un=
signed int pos, u32 *sizes)
> >  =09__pci_size_bars(dev, 1, pos, sizes, true);
> >  }
> > =20
> > +static struct resource *pbus_select_window_for_res_addr(
> > +=09=09=09=09=09const struct pci_bus *bus,
> > +=09=09=09=09=09const struct resource *res)
> > +{
> > +=09unsigned long type =3D res->flags & IORESOURCE_TYPE_BITS;
> > +=09struct resource *r;
> > +
> > +=09pci_bus_for_each_resource(bus, r) {
> > +=09=09if (!r || r =3D=3D &ioport_resource || r =3D=3D &iomem_resource)

I started to wonder if those two parent "anchor" resource can ever appear=
=20
in resources returned by pci_bus_for_each_resource()?

I've just copied those check from find_bus_resource_of_type() but it could=
=20
be snake oil there as well.

At least I don't see them ever in my quick tests, they only appeared as=20
parents of the resources this loop iterates over. But again I'm limited to=
=20
x86 systems so not sure if my testing yields universally true answers.

> > +=09=09=09continue;
> > +
> > +=09=09if ((r->flags & IORESOURCE_TYPE_BITS) !=3D type)
> > +=09=09=09continue;
> > +
> > +=09=09if (resource_contains(r, res))
> > +=09=09=09return r;
> > +=09}
> > +=09return NULL;
> > +}
> > +
> >  /**
> >   * __pci_read_base - Read a PCI BAR
> >   * @dev: the PCI device
> > @@ -329,6 +349,18 @@ int __pci_read_base(struct pci_dev *dev, enum pci_=
bar_type type,
> >  =09=09=09 res_name, (unsigned long long)region.start);
> >  =09}
> > =20
> > +=09if (!(res->flags & IORESOURCE_UNSET)) {
> > +=09=09struct resource *b_res;
> > +
> > +=09=09b_res =3D pbus_select_window_for_res_addr(dev->bus, res);
> > +=09=09if (!b_res ||
> > +=09=09    b_res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED)) {
> > +=09=09=09pci_dbg(dev, "%s %pR: no initial claim (no window)\n",
> > +=09=09=09=09res_name, res);
>=20
> Should this be pci_info()?  Or is there somewhere else that we
> complain about a child resource that's not contained in a bridge
> window?

AFAIK, there's no other print. The kernel didn't even recognize this case=
=20
until now so how could there have been one?!

They'd generally show up as failures later in resource assignment if the=20
resource doesn't fit to the bridge window [1], which should also set=20
IORESOURCE_UNSET, but good luck for inferring things from that. It's=20
tedious, I know. :-) If the bridge window is large enough, the base=20
address would just change where the resource fits (I think).

It can be pci_info() if you think that's better. I just picked the level=20
which is the least noisy. We can go with pci_info() now and if the logging=
=20
turns out excessive when we start to see dmesgs with it, we can of course=
=20
adjust it later so it's not permanent either way.

In any case, there's not much user can do for these as it's the setup FW=20
gave us.

> I recently got an internal report of child BARs being reassigned, I
> think because they weren't inside a bridge window, and the dmesg log
> (from an older kernel) showed the BAR reassignments, but didn't say
> anything about the *reason* for the reassignment.

Resource reassignment is only done after the resource was initially=20
assigned so I'm not sure if that inferring chain is sound.

Admittedly, you didn't exactly specify how you picked up that it was=20
"reassigned" so it could be just terminology that doesn't match what=20
setup-bus/res.c considers as resource reassignment. That is, if BAR's=20
address was simply changed from the initial, that's not "reassignment" in=
=20
the sense used by the kernel.


I see these for ROM resource and uninitialized (0-based) resources but=20
that isn't to say there couldn't be a case where the non-ROM resource was=
=20
an invalid non-zero base address.


[footnote 1]

Some code uses IORESOURCE_UNSET where as others use ->parent to=20
determine of the resource is not yet assigned. pdev_sort_resources() picks=
=20
them based on ->parent so the resource fitting algorith tries to assign=20
also resource that do not have IORESOURCE_UNSET. This entire ->parent and=
=20
IORESOURCE_UNSET handling has lots of overlap and likely some remaining=20
inconsistencies as well.

I initially thought I could entirely drop IORESOURCE_UNSET and base=20
everything on ->parent but I've now changed my mind because of this=20
series. We need this flag between initial reading of BARs/windows and=20
running the resource fitting/assignment algorithm.

I could see some benefit from altering the meaning to something along the=
=20
lines of IORESOURCE_INITIALLY_UNSET which is permanent flag. That=20
information could then be used to determine we don't produce worse=20
resource fits than what FW did. But it might be too hard to make such
change to IORESOURCE_UNSET and there are not extra bits available in=20
->flags for realizing it parallel to existing flags.

It may be useful to add some warnings if UNSET and ->parent are in=20
disagreement to ensure consistent state for any resource. But those=20
checks would need to cope the initial transient when windows are not yet=20
claimed from the resource tree which makes it harder to find good spots=20
for such checks.

I generally dislike IORESOURCE_UNSET because it's semantics are not very=20
clear and not properly enforced.


--=20
 i.
--8323328-1704151486-1758884017=:1234--

