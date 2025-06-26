Return-Path: <linux-pci+bounces-30694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D775AE99D7
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 11:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF3617FB07
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904F225C70D;
	Thu, 26 Jun 2025 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJ1AYg1L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871F9299937;
	Thu, 26 Jun 2025 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750929772; cv=none; b=kcxu9aEp3ePxeKroZbIW697HJUh0RKnfshwin28OE08IjH0l2s8p8WpE2c2FC3kjagDcNqFvWy4E+/GwR73CIkaiUykDbj2Alh9Pmzouykl4K0yV14mMqIXYxsTSgVp0Ncdi25OOcVjNhpS03sMF5exNkUSQ1CoKLG+LSmZZqW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750929772; c=relaxed/simple;
	bh=ddGGzGpYLlRuCDvqVCcNOvCnXRCFwC+8YXTk6irxDck=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cFsYu+6e1/s5mb50bxDVzYPqUd4JTWkq7I6SP5GwWmRWsvp8awWDSgdUwwE8zMhYusUzdIggrbmwf85EzRWcOFEW8nc5Ggmb/JcuUq/JparDMX5cDIzmIa9EXZsvpHRdALr9NEArjPvG8q9pQWfQOE0NN8j8iY1yHMctPEYnS0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJ1AYg1L; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750929771; x=1782465771;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ddGGzGpYLlRuCDvqVCcNOvCnXRCFwC+8YXTk6irxDck=;
  b=JJ1AYg1LiqQEgYDvt1+jLxWujnSdrLl5xuMO3fCMgoLkblvvzANxD3is
   KV292A706YkjOvFS75jo9+4fHs5/yqTbN/zhbai264RnVOfdTVq5y1pwo
   wAGWRJu9VtCN8/L+yuThV/GDJtETxUQDSeV9TWbl2meej4YutgBPuADZq
   EuBxoURZUh/N14okkKecCyJh6GF5ZY4Q1MVC4PflnS/RjgN4BLOwJezXb
   q/NDS3JgCAHwqpGhQOwHr+Bc0glXmW+6Y7PCdwBdTjlwnH3FBv+H9kST4
   ZmfuYxiFrdK7ikKWUwVm1o6sBLYZWgywhjX09wMNQXbmzu3srotytP5BM
   Q==;
X-CSE-ConnectionGUID: qL723f4rSQCJ5RKjNQ7brA==
X-CSE-MsgGUID: tgCFo470T2S53/1fGC9v4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="75760139"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="75760139"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 02:22:50 -0700
X-CSE-ConnectionGUID: wY2AZvnbTj2WvT0omS9X5g==
X-CSE-MsgGUID: MqIYRcf2QnyZUIbPDYq7KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="152226117"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 02:22:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 26 Jun 2025 12:22:43 +0300 (EEST)
To: D Scott Phillips <scott@os.amperecomputing.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <86ms9vlfxr.fsf@scott-ph-mail.amperecomputing.com>
Message-ID: <8f5e28dd-9e21-0381-5b32-0850f9f039ca@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com> <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com> <86plf0lgit.fsf@scott-ph-mail.amperecomputing.com> <e20e3171-7aa5-0646-7934-e6b10cdefc4e@linux.intel.com>
 <86ms9vlfxr.fsf@scott-ph-mail.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-120266576-1750929763=:930"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-120266576-1750929763=:930
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 25 Jun 2025, D Scott Phillips wrote:

> Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:
>=20
> > On Wed, 18 Jun 2025, D Scott Phillips wrote:
> >
> >> Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:
> >>=20
> >> > Resetting resource is problematic as it prevent attempting to alloca=
te
> >> > the resource later, unless something in between restores the resourc=
e.
> >> > Similarly, if fail_head does not contain all resources that were res=
et,
> >> > those resource cannot be restored later.
> >> >
> >> > The entire reset/restore cycle adds complexity and leaving resources
> >> > into reseted state causes issues to other code such as for checks do=
ne
> >> > in pci_enable_resources(). Take a small step towards not resetting
> >> > resources by delaying reset until the end of resource assignment and
> >> > build failure list (fail_head) in sync with the reset to avoid leavi=
ng
> >> > behind resources that cannot be restored (for the case where the cal=
ler
> >> > provides fail_head in the first place to allow restore somewhere in =
the
> >> > callchain, as is not all callers pass non-NULL fail_head).
> >> >
> >> > The Expansion ROM check is temporarily left in place while building =
the
> >> > failure list until the upcoming change which reworks optional resour=
ce
> >> > handling.
> >> >
> >> > Ideally, whole resource reset could be removed but doing that in a b=
ig
> >> > step would make the impact non-tractable due to complexity of all
> >> > related code.
> >> >
> >> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> >>=20
> >> Hi Ilpo, I'm seeing a crash on arm64 at boot that I bisected to this
> >> change. I don't think it's the same as the other issues reported. I've
> >> confirmed the crash is still there after your follow up patches.  The
> >> crash itself is below[1].
> >>=20
> >> It looks like the problem begins when:
> >>=20
> >> amdgpu_device_resize_fb_bar()
> >>  pci_resize_resource()
> >>   pci_reassign_bridge_resources()
> >>    __pci_bus_size_bridges()
> >>=20
> >> adds pci_hotplug_io_size to `realloc_head`. The io resource allocation
> >> has failed earlier because the root port doesn't have an io window[2].
> >>=20
> >> Then with this patch, pci_reassign_bridge_resources()'s call to
> >> __pci_bridge_assign_resources() now returns the io added space for
> >> hotplug in the `failed` list where the old code dropped it and did not=
=2E
> >>=20
> >> That sends pci_reassign_bridge_resources() into the `cleanup:` path,
> >> where I think the cleanup code doesn't properly release the resources
> >> that were assigned by __pci_bridge_assign_resources() and there's a
> >> conflict reported in pci_claim_resource() where a restored resource is
> >> found as conflicting with itself:
> >>=20
> >> > pcieport 000d:00:01.0: bridge window [mem 0x340000000000-0x340017fff=
fff 64bit pref]: can't claim; address conflict with PCI Bus 000d:01 [mem 0x=
340000000000-0x340017ffffff 64bit pref]
> >>=20
> >> Setting `pci=3Dhpiosize=3D0` avoids this crash, as does this change:
> >>=20
> >> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> >> index 16d5d390599a..59ece11702da 100644
> >> --- a/drivers/pci/setup-bus.c
> >> +++ b/drivers/pci/setup-bus.c
> >> @@ -2442,7 +2442,7 @@ int pci_reassign_bridge_resources(struct pci_dev=
 *bridge, unsigned long type)
> >>  =09LIST_HEAD(saved);
> >>  =09LIST_HEAD(added);
> >>  =09LIST_HEAD(failed);
> >> -=09unsigned int i;
> >> +=09unsigned int i, relevant_fails;
> >>  =09int ret;
> >> =20
> >>  =09down_read(&pci_bus_sem);
> >> @@ -2490,7 +2490,16 @@ int pci_reassign_bridge_resources(struct pci_de=
v *bridge, unsigned long type)
> >>  =09__pci_bridge_assign_resources(bridge, &added, &failed);
> >>  =09BUG_ON(!list_empty(&added));
> >> =20
> >> -=09if (!list_empty(&failed)) {
> >> +=09relevant_fails =3D 0;
> >> +=09list_for_each_entry(dev_res, &failed, list) {
> >> +=09=09restore_dev_resource(dev_res);
> >> +=09=09if (((dev_res->res->flags ^ type) & PCI_RES_TYPE_MASK) =3D=3D 0=
)
> >> +=09=09=09relevant_fails++;
> >> +=09}
> >> +=09free_list(&failed);
> >> +
> >> +=09/* Cleanup if we had failures in resources of interest */
> >> +=09if (relevant_fails !=3D 0) {
> >>  =09=09ret =3D -ENOSPC;
> >>  =09=09goto cleanup;
> >>  =09}
> >> @@ -2509,11 +2518,6 @@ int pci_reassign_bridge_resources(struct pci_de=
v *bridge, unsigned long type)
> >>  =09return 0;
> >> =20
> >>  cleanup:
> >> -=09/* Restore size and flags */
> >> -=09list_for_each_entry(dev_res, &failed, list)
> >> -=09=09restore_dev_resource(dev_res);
> >> -=09free_list(&failed);
> >> -
> >>  =09/* Revert to the old configuration */
> >>  =09list_for_each_entry(dev_res, &saved, list) {
> >>  =09=09struct resource *res =3D dev_res->res;
> >>=20
> >> I don't know this code well enough to know if that changes is complete=
ly
> >> bonkers or what.
> >
> > Hi again,
> >
> > Thanks for all the details what you think went wrong, it was really=20
> > useful. I think you have it towards the right direction but a more=20
> > targetted seems enough to address this (this needs to be confirmed, ple=
ase
> > test the patch below).
> >
> > The most correct solution would be to make all the resource fitting cod=
e=20
> > to focus on the resources that match the type filter. However, that loo=
ks=20
> > way too scary change at the moment to implement, and especially, let it=
=20
> > end up into stable (to fix this issue). So it looks this somewhat band-=
aid=20
> > solution similar to your attempt might be better as a fix for now.
> >
> > In medium term, I'd want to avoid using type as a filter and base all=
=20
> > such decisions on matching the bridge window resource the dev resource=
=20
> > belongs to. I've some work towards that direction already which removes=
=20
> > lots of complexity in which bridge window is going to be selected as=20
> > there will be a single place to make always the same decision. That cha=
nge=20
> > is also going to simplify the internal interfaces between functions ver=
y=20
> > noticably (but the change require more testing before I've enough=20
> > confidence to submit it). That work doesn't cover this resize side yet =
but=20
> > it should be extended there as well.
> >
> > So please test this somewhat band-aid patch:
> >
> > From 971686ed85e341e7234f8fe8b666140187f63ad1 Mon Sep 17 00:00:00 2001
> > From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.i=
ntel.com>
> > Date: Wed, 25 Jun 2025 20:30:43 +0300
> > Subject: [PATCH 1/1] PCI: Fix failure detectiong during resource resize
>=20
> detection
>=20
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=3DUTF-8
> > Content-Transfer-Encoding: 8bit
> >
> > Since the commit 96336ec70264 ("PCI: Perform reset_resource() and build
> > fail list in sync") the failed list is always built and returned to let
> > the caller decide if what to do with the failures. The caller may want
> > to retry resource fitting and assignment and before that can happen,
> > the resources should be restored to their original state (a reset
> > effectively clears the struct resource), which requires returning them
> > on the failed list so that the original state remains stored in the
> > associated struct pci_dev_resource.
> >
> > Resource resizing is different from the ordinary resource fitting and
> > assignment in that it only considers part of the resources. This means
> > failures for other resource types are not relevant at all and should be
> > ignored. As resize doesn't unassign such unrelated resources, those
> > resource ending up into the failed list implies assignment of that
> > resource must have failed before resize too. The check in
> > pci_reassign_bridge_resources() to decide if the whole assignment is
> > successful, however, is based on list emptiness which may cause false
> > negatives when the failed list resources with unrelated type.
> >
> > If the failed list is not empty, call pci_required_resource_failed()
> > and extend it to be able to filter on specific resource types too (if
> > provided).
> >
> > Calling pci_required_resource_failed() at this point is slightly
> > problematic because the resource itself is reset when the failed list
> > is constructed in __assign_resources_sorted(). As a result,
> > pci_resource_is_optional() does not have access to the original
> > resource flags. This could be worked around by restoring and
> > re-reseting the resource around the call to pci_resource_is_optional(),
> > however, it shouldn't cause issue as resource resizing is meant for
> > 64-bit prefetchable resources according to Christian K=C3=B6nig (see th=
e
> > Link which unfortunately doesn't point directly to Christian's reply
> > because lore didn't store that email at all).
> >
> > Link: https://lore.kernel.org/all/c5d1b5d8-8669-5572-75a7-0b480f581ac1@=
linux.intel.com/
> > Reported-by: D Scott Phillips <scott@os.amperecomputing.com>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > ---
> >  drivers/pci/setup-bus.c | 26 ++++++++++++++++++--------
> >  1 file changed, 18 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 07c3d021a47e..8284bbdc44b4 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -28,6 +28,10 @@
> >  #include <linux/acpi.h>
> >  #include "pci.h"
> > =20
> > +#define PCI_RES_TYPE_MASK \
> > +=09(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
> > +=09 IORESOURCE_MEM_64)
> > +
> >  unsigned int pci_flags;
> >  EXPORT_SYMBOL_GPL(pci_flags);
> > =20
> > @@ -384,13 +388,19 @@ static bool pci_need_to_release(unsigned long mas=
k, struct resource *res)
> >  }
> > =20
> >  /* Return: @true if assignment of a required resource failed. */
> > -static bool pci_required_resource_failed(struct list_head *fail_head)
> > +static bool pci_required_resource_failed(struct list_head *fail_head,
> > +=09=09=09=09=09 unsigned long type)
> >  {
> >  =09struct pci_dev_resource *fail_res;
> > =20
> > +=09type &=3D ~PCI_RES_TYPE_MASK;
>=20
> Is this meant to be `type &=3D PCI_RES_TYPE_MASK`? If not, then I think
> the new `if` check below is effectively just `if (type)`.

Yes, it should have been without that ~. Can you test the change with=20
that changed? I'm sorry about the extra trouble.

> FWIW, the patch in the current state is fixing the problem that I've
> been hitting.
>=20
> > +
> >  =09list_for_each_entry(fail_res, fail_head, list) {
> >  =09=09int idx =3D pci_resource_num(fail_res->dev, fail_res->res);
> > =20
> > +=09=09if (type && (fail_res->flags & PCI_RES_TYPE_MASK) !=3D type)
> > +=09=09=09continue;
> > +
> >  =09=09if (!pci_resource_is_optional(fail_res->dev, idx))
> >  =09=09=09return true;
> >  =09}
> > @@ -504,7 +514,7 @@ static void __assign_resources_sorted(struct list_h=
ead *head,
> >  =09}
> > =20
> >  =09/* Without realloc_head and only optional fails, nothing more to do=
=2E */
> > -=09if (!pci_required_resource_failed(&local_fail_head) &&
> > +=09if (!pci_required_resource_failed(&local_fail_head, 0) &&
> >  =09    list_empty(realloc_head)) {
> >  =09=09list_for_each_entry(save_res, &save_head, list) {
> >  =09=09=09struct resource *res =3D save_res->res;
> > @@ -1704,10 +1714,6 @@ static void __pci_bridge_assign_resources(const =
struct pci_dev *bridge,
> >  =09}
> >  }
> > =20
> > -#define PCI_RES_TYPE_MASK \
> > -=09(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
> > -=09 IORESOURCE_MEM_64)
> > -
> >  static void pci_bridge_release_resources(struct pci_bus *bus,
> >  =09=09=09=09=09 unsigned long type)
> >  {
> > @@ -2445,8 +2451,12 @@ int pci_reassign_bridge_resources(struct pci_dev=
 *bridge, unsigned long type)
> >  =09=09free_list(&added);
> > =20
> >  =09if (!list_empty(&failed)) {
> > -=09=09ret =3D -ENOSPC;
> > -=09=09goto cleanup;
> > +=09=09if (pci_required_resource_failed(&failed, type)) {
> > +=09=09=09ret =3D -ENOSPC;
> > +=09=09=09goto cleanup;
> > +=09=09}
> > +=09=09/* Only resources with unrelated types failed (again) */
> > +=09=09free_list(&failed);
> >  =09}
> > =20
> >  =09list_for_each_entry(dev_res, &saved, list) {
> >
> > base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> > --=20
> > 2.39.5
>=20

--=20
 i.

--8323328-120266576-1750929763=:930--

