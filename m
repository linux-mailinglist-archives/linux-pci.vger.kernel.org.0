Return-Path: <linux-pci+bounces-14771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7499A2106
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 13:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731D12833D2
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 11:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF2C1DA112;
	Thu, 17 Oct 2024 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="deDZggwY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E507D134A8;
	Thu, 17 Oct 2024 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164964; cv=none; b=o7ieE4lllITPtpXYd1jG/D+G95g4DaQ1i56LFodoqTs9MTFo9zFZI/ve0V0YhUfhQIr7ymXcFD4w/pQFwnX+Us260Uc3Rh9OsYCtHN0IoJt6faPSdMAEAtc2j9lJMWZf3Xdtvq3MaDiEhhp1b+BR/ojV2VxIll2GVZPuvYNpdu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164964; c=relaxed/simple;
	bh=rx2LhkOe+vRW2KC7KPp9XrTuc6Gp6pOZKZMW2wBtoXc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TJDMur5XuPfINOPmIiq73c6Tswzz6gypT8srHoaevzJs3mvIB+P3bojDdIcTuoC/qNxRNK9LtX1nMxNFi076QDvRO2DdgHB1PwfJd4CILL7PzVMXm6s3xO6SlMYhD7DSshrQAEdz6snNeqC+15tk3BX6jyw9M9HtsUffSne8GKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=deDZggwY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729164961; x=1760700961;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rx2LhkOe+vRW2KC7KPp9XrTuc6Gp6pOZKZMW2wBtoXc=;
  b=deDZggwYnKtc07sBe1vXiObgZcWdLz4qSA03gCMBQHPVeU4Iit8UE2Tx
   LGIhPUxhenCiLgokQBcN8UgC4upenYQNguPDz8/YrI8BXJ6Qd8gAMYM2B
   13xjWl/i7StcMPtAJKKZwYX8dZAMPJKUk46z9bXXmhOEjnM6nVV/kaVlh
   UcnEzPWuu3I9mpibB7K4iVXQUozH7IjwF1FcwUWp98biOPpD0jCrrp+4p
   EYVhnEAjYqrE57R1ECHJHHeEvIbCGoM65AFBzSMTEn8pz6ETmybUPBUVH
   Cu7/89F9ZXD3GZZWigMORM7Sh3PCMWfdfA398KEwyBKsx+tjwJOvFiT7V
   g==;
X-CSE-ConnectionGUID: +zfoPzhiSbyV/p56MFwx3A==
X-CSE-MsgGUID: xQkcmtz3Tv+JcnHnK6LWIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="16263926"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="16263926"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 04:36:00 -0700
X-CSE-ConnectionGUID: cSOlrV4FQVmiP0FKzdMoew==
X-CSE-MsgGUID: 7sMao99TQBSUyyIBIhfYnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78671017"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 04:35:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 17 Oct 2024 14:35:55 +0300 (EEST)
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
cc: Philipp Stanner <pstanner@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: Improve printout in pdev_sort_resources()
In-Reply-To: <20241017121203.000003d8@Huawei.com>
Message-ID: <8b9f3fab-bfeb-5aa7-fc6a-26b9faa89417@linux.intel.com>
References: <20241017095545.1424-1-ilpo.jarvinen@linux.intel.com> <20241017121203.000003d8@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-707330423-1729164955=:929"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-707330423-1729164955=:929
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 17 Oct 2024, Jonathan Cameron wrote:

> On Thu, 17 Oct 2024 12:55:45 +0300
> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > Use pci_resource_name() helper in pdev_sort_resources() to print
> > resources in user-friendly format. Also replace the vague "bogus
> > alignment" with a more precise explanation of the problem.
> >=20
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >=20
> > v2:
> > - Place colon after %s %pR to be consistent with other printouts
> > - Replace vague "bogus alignment" with the exact cause
> >=20
> >  drivers/pci/setup-bus.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 23082bc0ca37..0fd286f79674 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -134,6 +134,7 @@ static void pdev_sort_resources(struct pci_dev *dev=
, struct list_head *head)
> >  =09int i;
> > =20
> >  =09pci_dev_for_each_resource(dev, r, i) {
> > +=09=09const char *r_name =3D pci_resource_name(dev, i);
> >  =09=09struct pci_dev_resource *dev_res, *tmp;
> >  =09=09resource_size_t r_align;
> >  =09=09struct list_head *n;
> > @@ -146,8 +147,8 @@ static void pdev_sort_resources(struct pci_dev *dev=
, struct list_head *head)
> > =20
> >  =09=09r_align =3D pci_resource_alignment(dev, r);
> >  =09=09if (!r_align) {
> > -=09=09=09pci_warn(dev, "BAR %d: %pR has bogus alignment\n",
> > -=09=09=09=09 i, r);
> > +=09=09=09pci_warn(dev, "%s %pR: alignment must not be zero\n",
> > +=09=09=09=09 r_name, r);
>
> Why bother with local variable if only used here?

No other reason than it seems to always be a local variable in the other=20
places too regardless the number of uses.

> Absolutely fine if you have more code coming that uses it again though!
>=20
> Otherwise seems sensible change.

--=20
 i.

--8323328-707330423-1729164955=:929--

