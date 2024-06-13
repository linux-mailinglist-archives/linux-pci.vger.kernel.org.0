Return-Path: <linux-pci+bounces-8737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B2090746D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 15:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22063285067
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 13:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F6B1448E6;
	Thu, 13 Jun 2024 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnyKaN3a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9619476;
	Thu, 13 Jun 2024 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286946; cv=none; b=MzNxSYWCFM5jfKf57yUc2c2EtGg3JcgK1a+PxJRsUDjQ+VYctjm9w5AYcVy9BDK0XV2MTj7kHjOfOQ5yFmS+1DSzmyTtr+9wMh7OzYTO+T9Wssadt27rTyLx2977yp7sJWB9Z4t7yUfjUjScNCQsZ/cog7W9VwAGDShqDyb9MyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286946; c=relaxed/simple;
	bh=u1DajbW7oUtOx74DBLX0ZPOjMtqIm5yVgGA3dX4bi0E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=g/RDWS6pdpHMoZ6xTmoix4f3Xq/xJ5jjYH4wjm54CheRjwmDP9D9I+J+EE3o6EyedFvMOJIZQMI+Kgftj1bZO4tYEMR5n8CQgCkRgDf3RxT3O+7jyWB5GrKKWrNCyf/USEahYGtM5xq4eWzDVmFta7PqGbSAe95nBI+WJo0KPxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZnyKaN3a; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718286944; x=1749822944;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=u1DajbW7oUtOx74DBLX0ZPOjMtqIm5yVgGA3dX4bi0E=;
  b=ZnyKaN3aA64F/9OKEiC10I539baswxjitM5sUuMYFVgq8iRg4uWWwGnH
   RBxAZ5WtoIJqdHYmK3K2NVgrzETQg/9piWdhc3NBqpLju7iAlbm9iMtyE
   qUiuqHFDZ2to8p0NxvnFC0oSgMITjOi/tPN0jJCrc4669s3yW/wdFT6L8
   sLwj5JMmHqYeGiOyBTU079N2jPgurQTHKUaLWYin9N5lUBLi6D82mThzg
   4UBKDpSJJiLLYbGa8YWv4dbPhhYoT9So27+mIp3e0xzK3BU3YVb97Vyd+
   fIuBMc6AmL1Hq8eCLng2c2+fX5kIl5CMfCoQrnNs69dbR9b/FntIEq4fw
   A==;
X-CSE-ConnectionGUID: QCdhTQI8RdWn3ddO2fENSQ==
X-CSE-MsgGUID: vF6Vnb9wTna4qg0hYrDmjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="18889941"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="18889941"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 06:55:43 -0700
X-CSE-ConnectionGUID: 8p2jxRSWQsSOquJyVui+vg==
X-CSE-MsgGUID: UkphOpaQTqCpQK01l29b8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="40791406"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.209])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 06:55:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 13 Jun 2024 16:55:35 +0300 (EEST)
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Jonathan Hunter <jonathanh@nvidia.com>, 
    linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, 
    Robert Richter <rric@kernel.org>, 
    Thierry Reding <thierry.reding@gmail.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] resource: Add resource set range and size helpers
In-Reply-To: <20240613142820.00005c77@Huawei.com>
Message-ID: <efab7a75-b01d-0649-dbbe-0154ab2b8587@linux.intel.com>
References: <20240612085629.5015-1-ilpo.jarvinen@linux.intel.com> <20240612085629.5015-2-ilpo.jarvinen@linux.intel.com> <20240613142820.00005c77@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1916017572-1718286144=:8853"
Content-ID: <e9c1c694-3b3b-4459-418d-34ff8f88abba@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1916017572-1718286144=:8853
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <0d32d090-d629-878a-fbd5-e965710d3b5a@linux.intel.com>

On Thu, 13 Jun 2024, Jonathan Cameron wrote:

> On Wed, 12 Jun 2024 11:56:27 +0300
> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > Setting the end address for a resource with a given size lacks a helper
> > and is therefore open coded unlike the getter side which has a helper
> > for resource size calculation. Also, almost all callsites that
> > calculate end address for a resource also set the start address right
> > before it like this:
> >=20
> > =09res->start =3D start_addr;
> > =09res->end =3D res->start + size - 1;
> >=20
> > Thus, add resource_set_range(res, start_addr, size) that sets the start
> > address and calculates the end address to simplify this often repeated
> > fragment. In addition, introduce resource_set_size() for the cases
> > where setting the start address of the resource is not necessary but
> > note resource_set_range() is preferred.
> >=20
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> We have a bunch of cases of this in CXL. Adding this helper seems like
> a good idea to me.

Sadly this won't help struct range cases which feature the same math.

> I'm not sure the odd semantics of resource_set_size() are a good idea.
> Maybe it could by naming hint that it's relying internally on
> size already being set.
>=20
> resource_update_size() for instance might make people think or perhaps
> that's just more obscure.  Meh, I've argued myself around to there
> not being a better name.

Yeah, I tried to figure out solution to this very challenge too, but alas,
couldn't really find any good solution to it.

__ prefix would have kind of conveyed the meaning that you better know=20
what you're doing but as some people oppose __ too, I didn't want to stir=
=20
that pot. So it is what it is.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>`

FYI, I dropped the extra ` from that (no need to reply because of it).

Thanks for the reviews.

--=20
 i.


> > ---
> >  include/linux/ioport.h | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >=20
> > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > index db7fe25f3370..2a1d33ad151c 100644
> > --- a/include/linux/ioport.h
> > +++ b/include/linux/ioport.h
> > @@ -216,6 +216,38 @@ struct resource *lookup_resource(struct resource *=
root, resource_size_t start);
> >  int adjust_resource(struct resource *res, resource_size_t start,
> >  =09=09    resource_size_t size);
> >  resource_size_t resource_alignment(struct resource *res);
> > +
> > +/**
> > + * resource_set_size - Calculates resource end address from size and s=
tart address
> > + * @res: The resource descriptor
> > + * @size: The size of the resource
> > + *
> > + * Calculates the end address for @res based on @size.
> > + *
> > + * Note: The start address of @res must be set when calling this funct=
ion.
> > + * Use resource_set_range() if setting both the start address and @siz=
e.
> > + */
> > +static inline void resource_set_size(struct resource *res, resource_si=
ze_t size)
> > +{
> > +=09res->end =3D res->start + size - 1;
> > +}
> > +
> > +/**
> > + * resource_set_range - Sets resource start and end addresses
> > + * @res: The resource descriptor
> > + * @start: The start address for the resource
> > + * @size: The size of the resource
> > + *
> > + * Sets @res start address and calculates the end address based on @si=
ze.
> > + */
> > +static inline void resource_set_range(struct resource *res,
> > +=09=09=09=09      resource_size_t start,
> > +=09=09=09=09      resource_size_t size)
> > +{
> > +=09res->start =3D start;
> > +=09resource_set_size(res, size);
> > +}
> > +
> >  static inline resource_size_t resource_size(const struct resource *res=
)
> >  {
> >  =09return res->end - res->start + 1;
>=20
--8323328-1916017572-1718286144=:8853--

