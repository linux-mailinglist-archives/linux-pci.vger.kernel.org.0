Return-Path: <linux-pci+bounces-8834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C61C3908C66
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 15:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510F61F27366
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 13:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A0C1991DB;
	Fri, 14 Jun 2024 13:21:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1910118C05;
	Fri, 14 Jun 2024 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718371268; cv=none; b=iEKM0V2DKd9p69Um898LfZNS/woltlu5BnuriFYKKScEuowNuwd6o52v/QdE9Apz7r7D6ZSEhFQmISDAORxVLVSA524ZvdQ6XPS8Q6NMucUCEubr0e2lEhMF8rq0ynSZLvHsvS7lzDi4awF841yoh5YXn+R3o+SSKHJz20IYo4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718371268; c=relaxed/simple;
	bh=ou/cy8webUO2LUuAJn1cCuLj0aG/ygD5a3fmqVfG9Us=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eplevOP5cLjGULVUTMQ5XzGFYor2npeMA5Fn5t8+YuVnuBbycfVP2TJ2+bbD9qQ5sBp/14OPrF0lCjaBRj0scrFwcC/RhNEQSZUOkbzfC2XkzVUavHrIY/MC1K2PwlNrMk3uTP2lULCkvhdJotr9Mb7J53CSsl8eCfLQVDWi+9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W10HR1GPdz6J7wS;
	Fri, 14 Jun 2024 21:19:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B6BA140B54;
	Fri, 14 Jun 2024 21:20:55 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Jun
 2024 14:20:54 +0100
Date: Fri, 14 Jun 2024 14:20:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Philipp
 Stanner" <pstanner@redhat.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>, <linux-kernel@vger.kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, Robert Richter <rric@kernel.org>, "Thierry
 Reding" <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 4/4] PCI: Introduce ALIGN_DOWN_IF_NONZERO() helper
 locally
Message-ID: <20240614142053.00005a9c@Huawei.com>
In-Reply-To: <20240614100606.15830-5-ilpo.jarvinen@linux.intel.com>
References: <20240614100606.15830-1-ilpo.jarvinen@linux.intel.com>
	<20240614100606.15830-5-ilpo.jarvinen@linux.intel.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 14 Jun 2024 13:06:06 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> pci_bus_distribute_available_resources() performs alignment in case of
> non-zero alignment requirement on 3 occasions. Introduce
> ALIGN_DOWN_IF_NONZERO() helper to avoid coding the non-zero check 3
> times.
>=20
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>=20
> I tried to look other similar cases for both ALIGN() and ALIGN_DOWN()
> kernel-wide but it seems this is not very common so I did not put
> ALIGN_DOWN_IF_NONZERO() into the generic header.
Makes sense. It's a weird quirk of the return value of
pci_resource_alignement() to return 0 when it really means 1.

LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/setup-bus.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 004405edf290..39552d1a1793 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1819,6 +1819,9 @@ static void remove_dev_resources(struct pci_dev *de=
v, struct resource *io,
>  	}
>  }
> =20
> +#define ALIGN_DOWN_IF_NONZERO(addr, align) \
> +			((align) ? ALIGN_DOWN((addr), (align)) : (addr))
> +
>  /*
>   * io, mmio and mmio_pref contain the total amount of bridge window space
>   * available. This includes the minimal space needed to cover all the
> @@ -1930,8 +1933,7 @@ static void pci_bus_distribute_available_resources(=
struct pci_bus *bus,
>  		 * what is available).
>  		 */
>  		align =3D pci_resource_alignment(dev, res);
> -		resource_set_size(&io, align ? ALIGN_DOWN(io_per_b, align)
> -					     : io_per_b);
> +		resource_set_size(&io, ALIGN_DOWN_IF_NONZERO(io_per_b, align));
> =20
>  		/*
>  		 * The x_per_b holds the extra resource space that can be
> @@ -1943,15 +1945,13 @@ static void pci_bus_distribute_available_resource=
s(struct pci_bus *bus,
> =20
>  		res =3D &dev->resource[PCI_BRIDGE_MEM_WINDOW];
>  		align =3D pci_resource_alignment(dev, res);
> -		resource_set_size(&mmio, align ? ALIGN_DOWN(mmio_per_b, align)
> -					       : mmio_per_b);
> +		resource_set_size(&mmio, ALIGN_DOWN_IF_NONZERO(mmio_per_b, align));
>  		mmio.start -=3D resource_size(res);
> =20
>  		res =3D &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
>  		align =3D pci_resource_alignment(dev, res);
>  		resource_set_size(&mmio_pref,
> -				  align ? ALIGN_DOWN(mmio_pref_per_b, align)
> -					: mmio_pref_per_b);
> +				  ALIGN_DOWN_IF_NONZERO(mmio_pref_per_b, align));
>  		mmio_pref.start -=3D resource_size(res);
> =20
>  		pci_bus_distribute_available_resources(b, add_list, io, mmio,


