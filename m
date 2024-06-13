Return-Path: <linux-pci+bounces-8735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C78CA90740E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 15:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC41C1C23DD9
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 13:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE401448F1;
	Thu, 13 Jun 2024 13:41:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1703514430E;
	Thu, 13 Jun 2024 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286110; cv=none; b=BKYj/UbfUWnAvSiNOS92LniR+QoemAUC6vvOklu6qD0RSU9xc837j+ycFliX0wkYKrxg+IZTulpsLR2FfjYzooa2+z+ZQvhonNn+e3XllDNqMuTVU+5FZVyhZjzlaZkPHiJTdk7xFRRT7yTjcPrVuZVK/9wi4XVehbthWg5btZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286110; c=relaxed/simple;
	bh=jx457/uaxGwpvhxN2pJJYKqD9qofPcPGeZgog7s2H6M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rINwL9mlYe5jBGKnr1lE4Y8LEpurw63yH0NF/9uoC3oqfkBEgscENewdKKWyfjgYDO1L/OYJmM8O1X6Ti6RzrhBQ0VXXe9L+RpGZJJ92lhWYVftEcLjFvLzb2xu39ge1NmNyZEInganAyDC2uA1FX/cZXiML6sE6lqZ4awdTtX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0Nny0XJCz6H8Cr;
	Thu, 13 Jun 2024 21:40:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E5241140B2A;
	Thu, 13 Jun 2024 21:41:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Jun
 2024 14:41:44 +0100
Date: Thu, 13 Jun 2024 14:41:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Robert
 Richter" <rric@kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] PCI: Use resource_set_{range,size}() helpers
Message-ID: <20240613144143.00003ec9@Huawei.com>
In-Reply-To: <20240612085629.5015-3-ilpo.jarvinen@linux.intel.com>
References: <20240612085629.5015-1-ilpo.jarvinen@linux.intel.com>
	<20240612085629.5015-3-ilpo.jarvinen@linux.intel.com>
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

On Wed, 12 Jun 2024 11:56:28 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Convert open-coded resource size calculations to use
> resource_set_{range,size}() helpers.
>=20
> While at it, use SZ_* for size parameter where appropriate which makes
> the intent of code more obvious.
>=20
> Also, cast sizes to resource_size_t, not u64.
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

LGTM - one comment inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 909e6a7c3cc3..004405edf290 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c

> @@ -1948,15 +1943,15 @@ static void pci_bus_distribute_available_resource=
s(struct pci_bus *bus,

> =20
>  		res =3D &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
>  		align =3D pci_resource_alignment(dev, res);
> -		mmio_pref.end =3D align ? mmio_pref.start +
> -					ALIGN_DOWN(mmio_pref_per_b, align) - 1
> -				      : mmio_pref.start + mmio_pref_per_b - 1;
> +		resource_set_size(&mmio_pref,
> +				  align ? ALIGN_DOWN(mmio_pref_per_b, align)
> +					: mmio_pref_per_b);

I wonder.  Maybe it's worth defining an ALIGN_DOWN_IF_NON_ZERO() as locally
at least this pattern is annoying common and we can't just change
pci_resource_alignment() to return 1 in those cases because we want a
clean way to check it's not set in a lot of places.

Bikeshedding that name might take longer than it's worth though.




>  		mmio_pref.start -=3D resource_size(res);
> =20
>  		pci_bus_distribute_available_resources(b, add_list, io, mmio,



