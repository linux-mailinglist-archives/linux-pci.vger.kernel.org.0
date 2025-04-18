Return-Path: <linux-pci+bounces-26222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBA9A938C9
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 16:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9158E0641
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 14:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277DC1C1ADB;
	Fri, 18 Apr 2025 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJ1v0weN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347501B5EB5;
	Fri, 18 Apr 2025 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744987283; cv=none; b=Xd4sMrAqT60hqBK8wQPu4r2cGZs9JZdI+q2LdahlhWnEpIvz6qfPPoKqJBL1QTKfvwp5XmQvVgqjGQ5twyYddd5LRNaBpinqmPQn7YnY2q9EcmWA6My6y3tBeDEG6q4RfQAzQT3kjLt9jTbwKlWfBccaSgnVHFoKtHa7Ua39iSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744987283; c=relaxed/simple;
	bh=rgXIMKi6/tSfxkwtq9konCyEV8MeAup7artQDX39SBM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EqyucM8aDx+vlBowMUwgKJA3XgyRkwtEwDtNaIAkt9LbnHglTtHI07e98F6RtPSs9nLUK1UlMCe2X+e25Of7GvdnDaxmuFPc8zyaZ0Lm58PVxJ+3yvU2aAzF873vxi6hw+YXqnvoFBWA8fVM2EfTsZsh7mIRxOyL4AOq1IO5KT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJ1v0weN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744987281; x=1776523281;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=rgXIMKi6/tSfxkwtq9konCyEV8MeAup7artQDX39SBM=;
  b=oJ1v0weN9wfK3J9LBfx4naZYcpcq6kqZJ2aClO2KOIhEmA+s7vHKXWhw
   27N0ZBEvB4KGbI486WuCyAIu4UaXepQeudr8fdFN2Bls6ZyzzBi2up0q5
   49GuavpCPSr+OaIalR1hnscRDeLWF/GpGEhPTijND7/AGv/DAa9DgRSsn
   IfWuOxGvEifwFXAnGfIyDoTT8TKQ4IyjFrFobQ4WJiu6XBJV8rDipie8e
   2oYV8oNkahns/geXU0lYnAF3PBPKOlTAP6T+OQg0zLmV4c54GQlNbmM5u
   nahW0SjRoryd+OthN9Io4TA8FqkS75CwpyFgaON2aaoBA6OJrRqzynSjl
   w==;
X-CSE-ConnectionGUID: V6UHsIm6RGqOe0DACczh2g==
X-CSE-MsgGUID: Q46ZCCLtT/6Q17NwmnMVVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="46779766"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="46779766"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 07:41:20 -0700
X-CSE-ConnectionGUID: Feijuyr6QDqu36tmlU8dnA==
X-CSE-MsgGUID: yM7YjnaBQX6hY7bh5vrsKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="131075726"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.4])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 07:41:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 18 Apr 2025 17:41:13 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Guenter Roeck <linux@roeck-us.net>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Igor Mammedov <imammedo@redhat.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>
Subject: Re: [PATCH 1/1] PCI: Restore assigned resources fully after
 release
In-Reply-To: <20250417163904.GA114476@bhelgaas>
Message-ID: <f3e94bb7-ae6a-724a-107a-29889acc3642@linux.intel.com>
References: <20250417163904.GA114476@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-578828975-1744986899=:948"
Content-ID: <7811f86b-fa44-22a9-ae95-f3be0f1c46a9@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-578828975-1744986899=:948
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <e87ceb53-e39a-ffd4-2057-6c41ae845227@linux.intel.com>

On Thu, 17 Apr 2025, Bjorn Helgaas wrote:

> On Thu, Apr 03, 2025 at 12:31:37PM +0300, Ilpo J=E4rvinen wrote:
> > PCI resource fitting code in __assign_resources_sorted() runs in
> > multiple steps. A resource that was successfully assigned may have to
> > be released before the next step attempts assignment again. The
> > assign+release cycle is destructive to a start-aligned struct resource
> > (bridge window or IOV resource) because the start field is overwritten
> > with the real address when the resource got assigned.
> >=20
> > Properly restore the resource after releasing it. The start, end, and
> > flags fields must be stored into the related struct pci_dev_resource in
> > order to be able to restore the resource to its original state.
> >=20
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list=
 in sync")
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> Applied to pci/for-linus for v6.15, thanks!
>=20
> I'd like to add the following to the commit log if it's accurate:
>=20
>   + One symptom:
>=20
>   +   pci 0002:00:00.0: bridge window [mem size 0x00100000]: can't assign=
; bogus alignment

Yes, that is a good addition.

--=20
 i.

>     Reported-by: Guenter Roeck <linux@roeck-us.net>
>   + Closes: https://lore.kernel.org/r/01eb7d40-f5b5-4ec5-b390-a5c042c30af=
f@roeck-us.net/
>   + Reported-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>   + Closes: https://lore.kernel.org/r/3578030.5fSG56mABF@workhorse
>=20
> Let me know if that's wrong or there are additional reports.
>=20
> > ---
> >  drivers/pci/setup-bus.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 54d6f4fa3ce1..e994c546422c 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -187,6 +187,9 @@ static void pdev_sort_resources(struct pci_dev *dev=
, struct list_head *head)
> >  =09=09=09panic("%s: kzalloc() failed!\n", __func__);
> >  =09=09tmp->res =3D r;
> >  =09=09tmp->dev =3D dev;
> > +=09=09tmp->start =3D r->start;
> > +=09=09tmp->end =3D r->end;
> > +=09=09tmp->flags =3D r->flags;
> > =20
> >  =09=09/* Fallback is smallest one or list is empty */
> >  =09=09n =3D head;
> > @@ -545,6 +548,7 @@ static void __assign_resources_sorted(struct list_h=
ead *head,
> >  =09=09pci_dbg(dev, "%s %pR: releasing\n", res_name, res);
> > =20
> >  =09=09release_resource(res);
> > +=09=09restore_dev_resource(dev_res);
> >  =09}
> >  =09/* Restore start/end/flags from saved list */
> >  =09list_for_each_entry(save_res, &save_head, list)
> >=20
> > base-commit: 7d06015d936c861160803e020f68f413b5c3cd9d
> > --=20
> > 2.39.5
> >=20
>=20
--8323328-578828975-1744986899=:948--

