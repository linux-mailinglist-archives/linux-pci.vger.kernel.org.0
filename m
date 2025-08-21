Return-Path: <linux-pci+bounces-34471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5FAB2FE89
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 17:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC987B01088
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 15:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221A4285C8D;
	Thu, 21 Aug 2025 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRMivByi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B38272811;
	Thu, 21 Aug 2025 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789788; cv=none; b=pZk3IyBqOB9X2mX8L1s/Hx6FABOfZACR/lOxZB8eCWgz6ao84lP19B3sBEV+43FlVSEnq66fyaE4Ues4Dm7JxToepumYy8SaGAtAh8UCsItczpkpCz4lMkvVUMEkT+ybe2kll7RuH7Ipo0UVun9WiRKvxLVb4aEw/a1HG+EWMmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789788; c=relaxed/simple;
	bh=tJCT2Tv2rsnR+elP2MDgDezCXgl0iUYyhaj0V30RHH4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oDUS5wIqKFUwowclzbjSDJ5s6LzKbWpVrRLT4mzONHqrR0T6Zn6abBs98fludMmpjMYnPQ7tLjCLM6a/+TMRJmLycdGmdoQOtuMNMkpy4IMu8spLUS8vO8PZz0hvkSMxqyU2dF+10ARWckgv0sniIy+J95R7YUbDCaaoJo+YTB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRMivByi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755789786; x=1787325786;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tJCT2Tv2rsnR+elP2MDgDezCXgl0iUYyhaj0V30RHH4=;
  b=IRMivByiGgf7+Wx/pwws/Ba2U7JH/zp9/1ixTOq7NN8gMa0dvyHuLTGQ
   1o/pzY+kHXpmO2UKOU5Ua4YxjvEYJEMJFOiqknDeZH1izJkS2Sg4CsYU8
   VavVSC21w0bqsYkx04o5x5Q5wuXrI281G75ULikwxmCVy8j7bZiU7cPKz
   8hJTrERjP0vFo0IXGQgFLvdiP8ExEn1vF8x1jJMYtPNjfgsqjgGyMPneh
   72GCDHEOlCfXAaf5/C8DtIOr0FjybdkrX/6P9LVSCDjSPRcYYlSFEy0EP
   jYRf5RzA7mZ7PhoDyEPC1OfxicG0rx4vHYGBFGV1A51f3AANBbDmEoKYa
   A==;
X-CSE-ConnectionGUID: FZzAHwBrSZ6AsE4gXh9Irw==
X-CSE-MsgGUID: lruv8KeFSauY5j0OTLeW3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68790157"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="68790157"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:23:05 -0700
X-CSE-ConnectionGUID: 8XGK7D9gSayGGZrknd0c+g==
X-CSE-MsgGUID: ZXNIDUhORFaUleygoFeKWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="167653769"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.192])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:23:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 21 Aug 2025 18:22:58 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Tudor Ambarus <tudor.ambarus@linaro.org>, Rio <rio@r26.me>, 
    D Scott Phillips <scott@os.amperecomputing.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] PCI: Fix failure detection during resource
 resize
In-Reply-To: <20250821151444.GA674725@bhelgaas>
Message-ID: <422340e7-8016-866d-5e49-e6ea48db1683@linux.intel.com>
References: <20250821151444.GA674725@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1617396853-1755789778=:933"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1617396853-1755789778=:933
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 21 Aug 2025, Bjorn Helgaas wrote:
> On Mon, Jun 30, 2025 at 05:26:41PM +0300, Ilpo J=C3=A4rvinen wrote:
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
>=20
> Any URL we can include here?

Again, it'sin the thread of the original patch:

Link: https://lore.kernel.org/all/86plf0lgit.fsf@scott-ph-mail.amperecomput=
ing.com/

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
> > index 24863d8d0053..dbbd80d78d3d 100644
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
> > @@ -2449,8 +2455,12 @@ int pci_reassign_bridge_resources(struct pci_dev=
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
--8323328-1617396853-1755789778=:933--

