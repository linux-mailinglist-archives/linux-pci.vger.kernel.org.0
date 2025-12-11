Return-Path: <linux-pci+bounces-42972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BCFCB6BAA
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 18:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E17530111AC
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 17:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6112826CE25;
	Thu, 11 Dec 2025 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVMefzDn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2899264F9C
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765474138; cv=none; b=F684hzByJTxN+Br731DshYke6hv7xkHBrJH7/n22TEg6lZA93cRSS6ZqwGbT8fpHdKhLlOHBNK9+fw80ClJWrCJ3i+ReOLZYPpqQ2C81MnExp5mDthmmUt6/MUFlUAWND2zlsB2bcwi2yTAWko9eKMrJYj6BVEMx2HrgGD8PoaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765474138; c=relaxed/simple;
	bh=snh5KcpmwnY9PjOyoQ0WVpjEErkUklDcDxheyFpIAxc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=orLFFuWIPkcNDqymTZChhELuMJbXFayRNL+zmx7bZwNLshNaMOMYSE17eZDBg2Pfk6TbI/BGwA3hPhdIifvz7Duyv5RfIbqJmH4apSijG5qdoagfvmizb7JUHxeDsrfrCagDS8fzvFpqn6CUo153driBRUXbKuVc3xGFhwAp4e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVMefzDn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765474134; x=1797010134;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=snh5KcpmwnY9PjOyoQ0WVpjEErkUklDcDxheyFpIAxc=;
  b=CVMefzDn8pUzK+e1MzYmEo98Aj4y1UTlLwNfmJpYZNJ5Ssr+vDsHqOsQ
   R/oLp+EeqZvbtY83kLtneeGp8CeAFrZGY0k3V8X8Wv2CmXNdShK5NNpIo
   gOQV0r8TtdQyWWJoHHFJjYQG0SxVa624eyHSoH2RwVVvS125pzvOsf0Dl
   rh7aY+WVCNzC7dNbQqVlmrLi7rjMNJdz2cT9BH+psRbzFHARWDV5ksrla
   egW8+5cXXnS8zo9MDxY+YwJmD2xOmPDAljz9YLcHx6f5Nn+IKxRKWROXN
   l4ARTChZGYCtJQqo2as/KgQJI4fBtcl3xHI7hapO/3EKxxPPZypWuphvx
   A==;
X-CSE-ConnectionGUID: 5msr1rMuREuhuyDSRV6bGg==
X-CSE-MsgGUID: qhE5d8PPQ16R1QLoTrbWJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="84873647"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="84873647"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 09:28:52 -0800
X-CSE-ConnectionGUID: RLwcIKn4RuKkZDLGtZ56Uw==
X-CSE-MsgGUID: 2bD8wwHbRHWrtheG1Mh0YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="227915018"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.219])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 09:28:49 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Dec 2025 19:28:45 +0200 (EET)
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    Feng Tang <feng.tang@linux.alibaba.com>, 
    Jonathan Cameron <Jonthan.Cameron@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/6] PCI/portdrv: Move pcie_port_bus_type to pcie source
 file
In-Reply-To: <420d771f0091dea7cf18f445b94301576dcee4c8.1764688034.git.u.kleine-koenig@baylibre.com>
Message-ID: <df1810e3-6c16-0534-9042-f04dbf123e33@linux.intel.com>
References: <cover.1764688034.git.u.kleine-koenig@baylibre.com> <420d771f0091dea7cf18f445b94301576dcee4c8.1764688034.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1495651493-1765474125=:8649"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1495651493-1765474125=:8649
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 2 Dec 2025, Uwe Kleine-K=C3=B6nig wrote:

> Conceptually the pci_express bus doesn't belong in generic pci code.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/pci/pci-driver.c   | 22 ----------------------
>  drivers/pci/pcie/portdrv.c | 20 ++++++++++++++++++++
>  2 files changed, 20 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 2b6a628fc7d0..addb1d226a25 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1699,28 +1699,6 @@ const struct bus_type pci_bus_type =3D {
>  };
>  EXPORT_SYMBOL(pci_bus_type);
> =20
> -#ifdef CONFIG_PCIEPORTBUS
> -static int pcie_port_bus_match(struct device *dev, const struct device_d=
river *drv)
> -{
> -=09struct pcie_device *pciedev =3D to_pcie_device(dev);
> -=09const struct pcie_port_service_driver *driver =3D to_service_driver(d=
rv);
> -
> -=09if (driver->service !=3D pciedev->service)
> -=09=09return 0;
> -
> -=09if (driver->port_type !=3D PCIE_ANY_PORT &&
> -=09    driver->port_type !=3D pci_pcie_type(pciedev->port))
> -=09=09return 0;
> -
> -=09return 1;
> -}
> -
> -const struct bus_type pcie_port_bus_type =3D {
> -=09.name=09=09=3D "pci_express",
> -=09.match=09=09=3D pcie_port_bus_match,
> -};
> -#endif
> -
>  static int __init pci_driver_init(void)
>  {
>  =09int ret;
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 63492c3d3565..5cb0daf6781b 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -508,6 +508,21 @@ static void pcie_port_device_remove(struct pci_dev *=
dev)
>  =09pci_free_irq_vectors(dev);
>  }
> =20
> +static int pcie_port_bus_match(struct device *dev, const struct device_d=
river *drv)
> +{
> +=09struct pcie_device *pciedev =3D to_pcie_device(dev);
> +=09const struct pcie_port_service_driver *driver =3D to_service_driver(d=
rv);
> +
> +=09if (driver->service !=3D pciedev->service)
> +=09=09return 0;
> +
> +=09if (driver->port_type !=3D PCIE_ANY_PORT &&
> +=09    driver->port_type !=3D pci_pcie_type(pciedev->port))
> +=09=09return 0;
> +
> +=09return 1;
> +}
> +
>  /**
>   * pcie_port_probe_service - probe driver for given PCI Express port ser=
vice
>   * @dev: PCI Express port service device to probe against
> @@ -564,6 +579,11 @@ static int pcie_port_remove_service(struct device *d=
ev)
>  =09return 0;
>  }
> =20
> +const struct bus_type pcie_port_bus_type =3D {
> +=09.name =3D "pci_express",
> +=09.match =3D pcie_port_bus_match,
> +};
> +
>  /**
>   * pcie_port_service_register - register PCI Express port service driver
>   * @new: PCI Express port service driver to register

I wonder if you should also relocate that #ifdef region=20
bus_register(&pcie_port_bus_type); is in and make pcie_port_bus_type=20
static? As is, this move feels somewhat incomplete.

--=20
 i.

--8323328-1495651493-1765474125=:8649--

