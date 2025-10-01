Return-Path: <linux-pci+bounces-37339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28551BB0117
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 12:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2787C7A8A36
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 10:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D04C2C0F81;
	Wed,  1 Oct 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MpHk2GRo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309A727D771;
	Wed,  1 Oct 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759316162; cv=none; b=mI5kNrFu8FwsPDmKvt0qjjMY2QVWBpvVmm4Ry6FC4mh+DJynciBQa7/oYPsIV8TY7iNfQr39LT2WWFPF6FsM8uyDGaEFPHjzETQv9+d3/bn3dlMGSCMzYCbO0LOMCFLbPoa34uqUS/xYPazWT3XCc+n7mOKA6wHIUZAP+BJdQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759316162; c=relaxed/simple;
	bh=/cW6k727QVf0vtuGeGln5O6rogt5i5bXTUrItaPcGpU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZNfSS5cdbQBfWUYRRxMYSls7tzaqR9P91n3zPCHhKLHfk6qNfhQ9s8fwfR5bDWwDkuflL8S7o4gfaMxzwawiNSP+hqVf1wsJLm9LgiY+yV4Z6XfBLOmDjLzH8JRELHql17anFsL59aLRZTBS0/PRuOA0VfNKgTjUsOlbj3vg26A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MpHk2GRo; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759316160; x=1790852160;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=/cW6k727QVf0vtuGeGln5O6rogt5i5bXTUrItaPcGpU=;
  b=MpHk2GRoTphbnN4ORNSlZcZJ1QAGQ5jf/2u1Qf4ApuzW/tqnFlYGuizG
   i+gIFHNIE1uxYBKBz1YU2ldSXu/q/zw5m50YIP407uauboHRMJkEt+a+M
   KjmgvvsgI46EQtk/zyr/QdA5hzDcqsS/5yao199ZZmtLFaDRSdJokrAMy
   Jm0AsHPFf77Yk21ABhvfbeAl+73YCny3ZIAHThc+7dcYsdZfb9CjwoAdr
   ZfLAfcL84IiVLwpl1wuK42kZ0a4qEcNmGwgOalf/oLK8yVxBjJ+rVkZTb
   KK3h3OfqFhbxjz7ZZg965YbonGCjROlCF4+BqBQNvosnVN8tcFWQe50Xg
   A==;
X-CSE-ConnectionGUID: lw3JDr3LTFuWFzgT/PIupA==
X-CSE-MsgGUID: BSUFU4kDTYmCMBQmIR4c1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61295173"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="61295173"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 03:56:00 -0700
X-CSE-ConnectionGUID: MtDxMKnGS9iKrb7vW46/1g==
X-CSE-MsgGUID: i1kxk438T3uxURhjwE/Umg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="178362295"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.85])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 03:55:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 1 Oct 2025 13:55:51 +0300 (EEST)
To: dan.j.williams@intel.com
cc: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev, 
    linux-pci@vger.kernel.org, yilun.xu@intel.com, baolu.lu@linux.intel.com, 
    zhenzhong.duan@intel.com, aneesh.kumar@kernel.org, bhelgaas@google.com, 
    aik@amd.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI/IDE: Add Address Association Register setup for
 RP
In-Reply-To: <68dc7b5389621_1fa210090@dwillia2-mobl4.notmuch>
Message-ID: <2b9f7f7b-d6a4-be59-14d4-7b4ffccfe373@linux.intel.com>
References: <20250928062756.2188329-1-yilun.xu@linux.intel.com> <20250928062756.2188329-3-yilun.xu@linux.intel.com> <d58dfdf5-0058-a03f-dd75-5afb8ae69e04@linux.intel.com> <68dc7b5389621_1fa210090@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1805926643-1759314304=:982"
Content-ID: <55b4f511-a8eb-d042-1770-c1924665519f@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1805926643-1759314304=:982
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <7a251bc9-21ea-ac94-b6ce-874cd737972c@linux.intel.com>

On Tue, 30 Sep 2025, dan.j.williams@intel.com wrote:
> Ilpo J=E4rvinen wrote:
> > On Sun, 28 Sep 2025, Xu Yilun wrote:
> >=20
> > > Add Address Association Register setup for Root Ports.
> > >=20
> > > The address ranges for RP side Address Association Registers should
> > > cover memory addresses for all PFs/VFs/downstream devices of the DSM
> > > device. A simple solution is to get the aggregated 32-bit and 64-bit
> > > address ranges from directly connected downstream port (either an RP =
or
> > > a switch port) and set into 2 Address Association Register blocks.
> > >=20
> > > There is a case the platform doesn't require Address Association
> > > Registers setup and provides no register block for RP (AMD). Will ski=
p
> > > the setup in pci_ide_stream_setup().
> > >=20
> > > Also imaging another case where there is only one block for RP.
> > > Prioritize 64-bit address ranges setup for it. No strong reason for t=
he
> > > preference until a real use case comes.
> > >=20
> > > The Address Association Register setup for Endpoint Side is still
> > > uncertain so isn't supported in this patch.
> > >=20
> > > Take the oppotunity to export some mini helpers for Address Associati=
on
> > > Registers setup. TDX Connect needs the provided aggregated address
> > > ranges but will use specific firmware calls for actual setup instead =
of
> > > pci_ide_stream_setup().
> > >=20
> > > Co-developed-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> > > Co-developed-by: Arto Merilainen <amerilainen@nvidia.com>
> > > Signed-off-by: Arto Merilainen <amerilainen@nvidia.com>
> > > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > > ---
> > >  include/linux/pci-ide.h | 11 +++++++
> > >  drivers/pci/ide.c       | 64 +++++++++++++++++++++++++++++++++++++++=
+-
> > >  2 files changed, 74 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> > > index 5adbd8b81f65..ac84fb611963 100644
> > > --- a/include/linux/pci-ide.h
> > > +++ b/include/linux/pci-ide.h
> > > @@ -6,6 +6,15 @@
> > >  #ifndef __PCI_IDE_H__
> > >  #define __PCI_IDE_H__
> > > =20
> > > +#define SEL_ADDR1_LOWER GENMASK(31, 20)
> > > +#define SEL_ADDR_UPPER GENMASK_ULL(63, 32)
> > > +#define PREP_PCI_IDE_SEL_ADDR1(base, limit)                    \
> > > +=09(FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |             \
> > > +=09 FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW,          \
> > > +=09=09    FIELD_GET(SEL_ADDR1_LOWER, (base))) | \
> > > +=09 FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW,         \
> > > +=09=09    FIELD_GET(SEL_ADDR1_LOWER, (limit))))
> > > +
> > >  #define PREP_PCI_IDE_SEL_RID_2(base, domain)               \
> > >  =09(FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |          \
> > >  =09 FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, (base)) | \
> > > @@ -42,6 +51,8 @@ struct pci_ide_partner {
> > >  =09unsigned int default_stream:1;
> > >  =09unsigned int setup:1;
> > >  =09unsigned int enable:1;
> > > +=09struct range mem32;
> > > +=09struct range mem64;
> > >  };
> > > =20
> > >  /**
> > > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > > index 7633b8e52399..8db1163737e5 100644
> > > --- a/drivers/pci/ide.c
> > > +++ b/drivers/pci/ide.c
> > > @@ -159,7 +159,11 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_=
dev *pdev)
> > >  =09struct stream_index __stream[PCI_IDE_HB + 1];
> > >  =09struct pci_host_bridge *hb;
> > >  =09struct pci_dev *rp;
> > > +=09struct pci_dev *br;
> >=20
> > Why not join with the previous line?
> >=20
> > >  =09int num_vf, rid_end;
> > > +=09struct range mem32 =3D {}, mem64 =3D {};
> > > +=09struct pci_bus_region region;
> > > +=09struct resource *res;
> > > =20
> > >  =09if (!pci_is_pcie(pdev))
> > >  =09=09return NULL;
> > > @@ -206,6 +210,24 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_=
dev *pdev)
> > >  =09else
> > >  =09=09rid_end =3D pci_dev_id(pdev);
> > > =20
> > > +=09br =3D pci_upstream_bridge(pdev);
> > > +=09if (!br)
> > > +=09=09return NULL;
> > > +
> > > +=09res =3D &br->resource[PCI_BRIDGE_MEM_WINDOW];
> >=20
> > pci_resource_n()
> >=20
> > > +=09if (res->flags & IORESOURCE_MEM) {
> > > +=09=09pcibios_resource_to_bus(br->bus, &region, res);
> > > +=09=09mem32.start =3D region.start;
> > > +=09=09mem32.end =3D region.end;
> > > +=09}
> > > +
> > > +=09res =3D &br->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> >=20
> > Ditto.
> >=20
> > > +=09if (res->flags & IORESOURCE_PREFETCH) {
> >=20
> > While I don't know much about what's going on here, is this assuming th=
e=20
> > bridge window is not disabled solely based on this flag check?
>=20
> Indeed it does seem to be assumining that the flag is only set when the
> resource is valid and active.
>=20
> > Previously inactive bridge window flags were reset but that's no longer=
=20
> > the case after the commit 8278c6914306 ("PCI: Preserve bridge window=20
> > resource type flags") (currently in pci/resource)?
>=20
> Thanks for the heads up. It does seem odd that both IORESOURCE_UNSET and
> IORESOURCE_DISABLED are both being set and the check allows for either.

I'm a bit lost on what check you're referring to.

If you refer to the check in pci_bus_alloc_from_region() added by that=20
commit, now that I relook at it, it would probably be better written as=20
!r->parent (a TODO entry added to verify it).

> Is that assuming that other call paths not touched in that set may only
> set one of those flags?

Presence of either of those flags indicates the bridge window resource is=
=20
not usable "normally". There's also res->parent which directly tells if=20
the resource is assigned. Out of those three, res->parent is the preferred=
=20
way to know if the resource is usable normally (aka. "assigned"), however,=
=20
res->parent check can only be used if this code runs late enough.

To me IORESOURCE_UNSET looks unnecessary flag and would want to get rid of=
=20
it entirely as res->parent mostly tells the same information. But I don't=
=20
expect that to be an easy change, and there's also the init transient=20
where res->parent is not yet set which complicates things.

But until IORESOURCE_UNSET is gone, it alone can indicate the resource is=
=20
not in usable state. And so can IORESOURCE_DISABLED.

The resource fitting code clears DISABLED (while sizing bridge windows)=20
before UNSET (on assignment), so they have different meaning even if=20
there's overlap on the consumer side depending on use case. The resource=20
fitting/assignment code cares for this distinction, see e.g.=20
pdev_resource_assignable() which only checks for DISABLED because, well,=20
we're about to attempt to turn UNSET into !UNSET.

> Otherwise, the change to mark the resource as zero-sized feels a better
> / more explicit protocol than checking for flags. IDE setup only cares
> that any downstream MMIO get included in the stream.

If this particular code here runs after resources have been assigned by=20
the kernel, please check res->parent to know if the resource is assigned=20
or not.

I'm considering adding resource_assigned() helper for this purpose as=20
res->parent check looks too odd and may alienate developers from using it=
=20
if they don't know about the internals of the resource management.

If the bridge window resource is assigned, it should have the expected=20
flags and IMO it's useless to check for the flags (if flags are not right=
=20
for the bridge window resources that is assigned, we've a bug elsewhere in=
=20
the code).


As a sidenote, there are lots of !res->flags and !pci_resource_len(...),=20
etc. checks which are often custom implementations resource_assigned(),=20
they all are landmines that make my life harder as I'd want to make=20
further improvements to resource behavior.

--=20
 i.
--8323328-1805926643-1759314304=:982--

