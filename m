Return-Path: <linux-pci+bounces-8734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515579073AD
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 15:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6002E1C225AD
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 13:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0862143C50;
	Thu, 13 Jun 2024 13:28:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6302FA94D;
	Thu, 13 Jun 2024 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285309; cv=none; b=n4nkD/hEd3RN446Sp3jxZbf/qiLaRTrwDIkzLYoGAfDWRH9w8vzQj7qPJAdB+trvkPEv2Wh0bk8Ditkw42UWfyrm4OtzqUgDw2HQvOQDxDmq3EyzFEm0GkVfRujHUeirDk8S7zTGsmzczT10nm/gc45krZU9TvNwCAk1B/n5by0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285309; c=relaxed/simple;
	bh=nubk0vDKJgXmfA6FYE1ih30ymCkvILrmzKak/wr6a/c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSZAphWaer0ypPhSa7LL/whayIodIMCcBvC3vpZ+4FmWfmlEf71Hj4K9h442gEo4k34WhV3Osf21Ls6OivB/fqz/f4pbDQ/CwJf4S7KgDMwCtwosU7WbeOjABahYNoPTDJcoOOx1a4rtVEw5F7mSuIR0eFe1I9pXc5RQPLKsXEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0NX544XTz6K6CM;
	Thu, 13 Jun 2024 21:28:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0ECCB140A70;
	Thu, 13 Jun 2024 21:28:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Jun
 2024 14:28:22 +0100
Date: Thu, 13 Jun 2024 14:28:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, <linux-kernel@vger.kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	"Robert Richter" <rric@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] resource: Add resource set range and size helpers
Message-ID: <20240613142820.00005c77@Huawei.com>
In-Reply-To: <20240612085629.5015-2-ilpo.jarvinen@linux.intel.com>
References: <20240612085629.5015-1-ilpo.jarvinen@linux.intel.com>
	<20240612085629.5015-2-ilpo.jarvinen@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 12 Jun 2024 11:56:27 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Setting the end address for a resource with a given size lacks a helper
> and is therefore open coded unlike the getter side which has a helper
> for resource size calculation. Also, almost all callsites that
> calculate end address for a resource also set the start address right
> before it like this:
>=20
> 	res->start =3D start_addr;
> 	res->end =3D res->start + size - 1;
>=20
> Thus, add resource_set_range(res, start_addr, size) that sets the start
> address and calculates the end address to simplify this often repeated
> fragment. In addition, introduce resource_set_size() for the cases
> where setting the start address of the resource is not necessary but
> note resource_set_range() is preferred.
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

We have a bunch of cases of this in CXL. Adding this helper seems like
a good idea to me.

I'm not sure the odd semantics of resource_set_size() are a good idea.
Maybe it could by naming hint that it's relying internally on
size already being set.

resource_update_size() for instance might make people think or perhaps
that's just more obscure.  Meh, I've argued myself around to there
not being a better name.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>`


> ---
>  include/linux/ioport.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index db7fe25f3370..2a1d33ad151c 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -216,6 +216,38 @@ struct resource *lookup_resource(struct resource *ro=
ot, resource_size_t start);
>  int adjust_resource(struct resource *res, resource_size_t start,
>  		    resource_size_t size);
>  resource_size_t resource_alignment(struct resource *res);
> +
> +/**
> + * resource_set_size - Calculates resource end address from size and sta=
rt address
> + * @res: The resource descriptor
> + * @size: The size of the resource
> + *
> + * Calculates the end address for @res based on @size.
> + *
> + * Note: The start address of @res must be set when calling this functio=
n.
> + * Use resource_set_range() if setting both the start address and @size.
> + */
> +static inline void resource_set_size(struct resource *res, resource_size=
_t size)
> +{
> +	res->end =3D res->start + size - 1;
> +}
> +
> +/**
> + * resource_set_range - Sets resource start and end addresses
> + * @res: The resource descriptor
> + * @start: The start address for the resource
> + * @size: The size of the resource
> + *
> + * Sets @res start address and calculates the end address based on @size.
> + */
> +static inline void resource_set_range(struct resource *res,
> +				      resource_size_t start,
> +				      resource_size_t size)
> +{
> +	res->start =3D start;
> +	resource_set_size(res, size);
> +}
> +
>  static inline resource_size_t resource_size(const struct resource *res)
>  {
>  	return res->end - res->start + 1;


