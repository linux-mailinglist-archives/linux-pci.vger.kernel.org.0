Return-Path: <linux-pci+bounces-34754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ED8B35FCC
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 14:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1C67C73FA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 12:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF361F0E29;
	Tue, 26 Aug 2025 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6vZpFPH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C29186E40;
	Tue, 26 Aug 2025 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212696; cv=none; b=eFO+9ZoZ+SxhbhdoZUhHanPQOEy3hp3b70bi8d1daNDsiJ3+el6xPgaQE90JAAUFkiezKGBZU+jP4u0n1lJVGHO5Mm9nuLX2Psok3zgN7W6p16H5j3IVoTegNUUzNwliYv/hFEsDitwLJYmTpiQMyrq4pVQlxIZvLIL/iYT+hro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212696; c=relaxed/simple;
	bh=4H3MA6lIMwhYVib91YvG/XzOhID2JXqhV62RwWLjZK4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=O3qiFflRINmeEdiU6qYT3yRwtEonUqSMkxQiNhyTsv1/CgdlVMjserS4Ee1y2b3HniJafKtju7rrtev+ufoErY/6HvDkXwuREdcQFrxm5tD/cPw9JySG/CuBRF9kGWWzwogx9Cm/hcD4r945qkdwYjdmpapLbj6SeDs63p2M78I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P6vZpFPH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756212695; x=1787748695;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4H3MA6lIMwhYVib91YvG/XzOhID2JXqhV62RwWLjZK4=;
  b=P6vZpFPH5ErWdsRuBX3xC0p0/uzctYzwJ+Jt+dPnzt6BLXt6lAJJgQXW
   aCwLBA5Mq8d6fCwNmGIef2AnVN2S8WervfWcCXj72GDk0Y9NA3YDd9fat
   ebg1N7L1zZMAtu6ZEUk9k+XfB+YM9oaVVvwZTj0S7XxjOdQwPMGsJS0ir
   d1pYz76cF7gv2YzKmjo5NgWc8F6LTmOXImOXGI4tOUGnDJ/e73H/v+/CX
   8zier0ZqJvw48B23krzIxHMIsvSitHdATY9aME5fpcdcHiURsoEXzwsMv
   +fDha7UPx0YNgZEv1JVj15FowKdxh0Tj+ejo6ouUicwzlDqgdiywrzqsl
   w==;
X-CSE-ConnectionGUID: v3tgHt++RiuyLTXhauxzDQ==
X-CSE-MsgGUID: f1o8U2wzQ9GB0x5O7ZkYSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58543749"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="58543749"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 05:51:34 -0700
X-CSE-ConnectionGUID: HjCzMjvOQ367tPXwccDK3w==
X-CSE-MsgGUID: EA1F1pqwSPymlY1wJ3yENg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169496117"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.4])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 05:51:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 26 Aug 2025 15:51:25 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>, 
    Alex Deucher <alexander.deucher@amd.com>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    D Scott Phillips <scott@os.amperecomputing.com>, Rio Liu <rio@r26.me>, 
    Tudor Ambarus <tudor.ambarus@linaro.org>, 
    Markus Elfring <Markus.Elfring@web.de>, 
    LKML <linux-kernel@vger.kernel.org>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI: Fix failure detection during resource
 resize
In-Reply-To: <20250825222134.GA802347@bhelgaas>
Message-ID: <a821c043-a07f-5727-938a-c32a7efb671a@linux.intel.com>
References: <20250825222134.GA802347@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-169580405-1756212685=:934"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-169580405-1756212685=:934
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Adding Alex & Christian as they might be able to shed light on the amdgpu=
=20
side, but I think the problem still starts from=20
pci_reassign_bridge_resources().

On Mon, 25 Aug 2025, Bjorn Helgaas wrote:
> On Fri, Aug 22, 2025 at 03:33:59PM +0300, Ilpo J=C3=A4rvinen wrote:
> > Since the commit 96336ec70264 ("PCI: Perform reset_resource() and build
> > fail list in sync") the failed list is always built and returned to let
> > the caller decide what to do with the failures. The caller may want to
> > retry resource fitting and assignment and before that can happen, the
> > resources should be restored to their original state (a reset
> > effectively clears the struct resource), which requires returning them
> > on the failed list so that the original state remains stored in the
> > associated struct pci_dev_resource.
> >=20
> > Resource resizing is different from the ordinary resource fitting and
> > assignment in that it only considers part of the resources. This means
> > failures for other resource types are not relevant at all and should be
> > ignored. As resize doesn't unassign such unrelated resources, those
> > resource ending up into the failed list implies assignment of that
> > resource must have failed before resize too. The check in
> > pci_reassign_bridge_resources() to decide if the whole assignment is
> > successful, however, is based on list emptiness which will cause false
> > negatives when the failed list has resources with an unrelated type.
> >=20
> > If the failed list is not empty, call pci_required_resource_failed()
> > and extend it to be able to filter on specific resource types too (if
> > provided).
> >=20
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
> >=20
> > Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list=
 in sync")
> > Link: https://lore.kernel.org/all/c5d1b5d8-8669-5572-75a7-0b480f581ac1@=
linux.intel.com/
> > Reported-by: D Scott Phillips <scott@os.amperecomputing.com>
> > Closes: https://lore.kernel.org/all/86plf0lgit.fsf@scott-ph-mail.ampere=
computing.com/
>=20
> I'm trying to connect this fix with the Asynchronous SError Interrupt
> crash that Scott reported here.  From the call trace:
>=20
>   ...
>   arm64_serror_panic+0x6c/0x90
>   do_serror+0x58/0x60
>   el1h_64_error_handler+0x38/0x60
>   el1h_64_error+0x84/0x88
>   _raw_spin_lock_irqsave+0x34/0xb0 (P)
>   amdgpu_ih_process+0xf0/0x150 [amdgpu]
>   amdgpu_irq_handler+0x34/0xa0 [amdgpu]
>   __handle_irq_event_percpu+0x60/0x248
>   handle_irq_event+0x4c/0xc0
>   handle_fasteoi_irq+0xa0/0x1c8
>   handle_irq_desc+0x3c/0x68
>   generic_handle_domain_irq+0x24/0x40
>   __gic_handle_irq_from_irqson.isra.0+0x15c/0x260
>   gic_handle_irq+0x28/0x80
>   call_on_irq_stack+0x24/0x30
>   do_interrupt_handler+0x88/0xa0
>   el1_interrupt+0x44/0xd0
>   el1h_64_irq_handler+0x18/0x28
>   el1h_64_irq+0x84/0x88
>   amdgpu_device_rreg.part.0+0x4c/0x190 [amdgpu] (P)
>   amdgpu_device_rreg+0x24/0x40 [amdgpu]
>=20
> I guess something happened in amdgpu_device_rreg() that caused an
> interrupt, maybe a bogus virtual address for a register?

I think that the bogosity starts within pci_reassign_bridge_resources().
I've very recently come to realize the entire BAR resize operation is=20
quite fragile as is and can fail to restore the original BARs as they were=
=20
when the resize fails (even if it tries to restore things as they were). To=
=20
fix that, I'll likely need to rework the entire structure of the resize=20
related functions so that the saved list can hold resources beyond just=20
the bridge windows that were released. I plan to eventually look at it but=
=20
the rebar max size thing seems way more urgent than this atm.

It also looks pci_reassign_bridge_resources() can leave resources in=20
non-resetted state for unassigned resources such as in this case=20
(the non-resize side of the fitting algorithm resets resources that it=20
failed to assign). For such resources, also IORESOURCE_UNSET gets=20
overwritten by restore_dev_resource() which is even worse. My guess is=20
that something in amdgpu assumes that, e.g., non-zero resource len implies=
=20
the resource is assigned, or it could be that this IORESOURCE_UNSET=20
problem make the amdgpu checks for it to not work as intended.

While I cannot pinpoint what ultimately causes the crash within amdgpu, it=
=20
seems that some code there takes pci_resource_start/len() without checking
first if the resource is assigned (admittedly, that check could be=20
somewhere else in the call chain, I only grepped for -A20 -B20 'resource'=
=20
which had lots of noise to comb through, using 'pci_resource' too should=20
find the interesting bits I think).

I'd actually want to add pci_resource_assigned() which checks only=20
res->parent as that seems the most robust check to tell if the resource=20
has been truly assigned. Endpoint drivers should then check a resource=20
with pci_resource_assigned() before using other resource getters on it.

I could say much more about how I think IORESOURCE_UNSET is entirely=20
redundant information and should be just dropped for simplicity's sake=20
(and current flags handling likely has many many corner cases which the=20
->parent check is entirely immune to) but it'd add to the length of an=20
already long reply. :-)

> And then amdgpu_ih_process() did something that caused the SError?  Or
> since it seems to be asynchronous, maybe the amdgpu_ih_process()
> connection is coincidental and the SError was a consequence of
> something else?
>=20
> I'd like to have a bread crumb here in the commit log that connects
> this fix with something a user might see, but I don't know what that
> would look like.

I'm sorry I don't know the answer, the amdgpu code is too unfamiliar=20
territory, maybe Alex or Christian has some idea and can pinpoint us to=20
what to look at.

--=20
 i.

> > Tested-by: D Scott Phillips <scott@os.amperecomputing.com>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Reviewed-by: D Scott Phillips <scott@os.amperecomputing.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  drivers/pci/setup-bus.c | 26 ++++++++++++++++++--------
> >  1 file changed, 18 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index df5aec46c29d..def29506700e 100644
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
> > +=09type &=3D PCI_RES_TYPE_MASK;
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
> > @@ -1708,10 +1718,6 @@ static void __pci_bridge_assign_resources(const =
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
> > @@ -2450,8 +2456,12 @@ int pci_reassign_bridge_resources(struct pci_dev=
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
> > --=20
> > 2.39.5
> >=20
>=20

--8323328-169580405-1756212685=:934--

