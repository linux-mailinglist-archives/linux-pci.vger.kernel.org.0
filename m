Return-Path: <linux-pci+bounces-7290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EE68C0F06
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 13:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5056B216E5
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 11:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924DA131735;
	Thu,  9 May 2024 11:54:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D84312FF8E;
	Thu,  9 May 2024 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715255646; cv=none; b=AmPMl+uTwUAF8RXqG4U10TGmM4/7v9VNPW+TypjZehstWQ9qUTyYWqWqnaUyp1MiMRPshqUWvVfscYK9lr/Q/BhJA7rEcjMR7pEWSYOYkda+VUH/wbtGbnTHUl+9iIFpgrEUfsm46Vt0iAu5Ml39lpxl1CiNN+H7PRj5r/7DmlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715255646; c=relaxed/simple;
	bh=xO5f8wq/0P5imNfCwCvl1FvQaw5qFdKKDOFvrT8KFfw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/CxQAM244jZmr02h42lrLq+3loMFyjt2lfNZzpObyZLmnMo/Va6gwfN4qIGGxy00d3vY5gEVQuAoeOQ6dVGmJe8FvJOjA5P9ACKBj0DBOAXwqZ9y7u+gZiuYVP5sgvHdooTOTO2uZGUByaEiishZVx6br8HTL9CySfO3RIfnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VZr1l70Dvz6K6vN;
	Thu,  9 May 2024 19:50:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A0E39140B33;
	Thu,  9 May 2024 19:54:00 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 9 May
 2024 12:53:59 +0100
Date: Thu, 9 May 2024 12:53:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lorenzo
 Pieralisi" <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Lukas Wunner
	<lukas@wunner.de>, Alexandru Gagniuc <mr.nuke.me@gmail.com>, "Krishna
 chaitanya chundru" <quic_krichai@quicinc.com>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v5 6/8] PCI/bwctrl: Add API to set PCIe Link Speed
Message-ID: <20240509125358.00004c55@Huawei.com>
In-Reply-To: <20240508134744.52134-7-ilpo.jarvinen@linux.intel.com>
References: <20240508134744.52134-1-ilpo.jarvinen@linux.intel.com>
	<20240508134744.52134-7-ilpo.jarvinen@linux.intel.com>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed,  8 May 2024 16:47:42 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Currently, PCIe Link Speeds are adjusted by custom code rather than in
> a common function provided in PCI core. PCIe bandwidth controller
> (bwctrl) introduces an in-kernel API to set PCIe Link Speed. Convert
> Target Speed quirk to use the new API.
>=20
> The new API is also intended to be used in an upcoming commit that adds
> a thermal cooling device to throttle PCIe bandwidth when thermal
> thresholds are reached.
>=20
> The PCIe bandwidth control procedure is as follows. The highest speed
> supported by the Port and the PCIe device which is not higher than the
> requested speed is selected and written into the Target Link Speed in
> the Link Control 2 Register. Then bandwidth controller retrains the
> PCIe Link.
>=20
> Bandwidth Notifications enable the cur_bus_speed in the struct pci_bus
> to keep track PCIe Link Speed changes. While Bandwidth Notifications
> should also be generated when bandwidth controller alters the PCIe Link
> Speed, a few platforms do not deliver LMBS interrupt after Link
> Training as expected. Thus, after changing the Link Speed, bandwidth
> controller makes additional read for the Link Status Register to ensure
> cur_bus_speed is consistent with the new PCIe Link Speed.
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/pci.h         |  13 ++++
>  drivers/pci/pcie/Makefile |   2 +-
>  drivers/pci/pcie/bwctrl.c | 147 ++++++++++++++++++++++++++++++++++++++
>  drivers/pci/quirks.c      |  12 +---
>  include/linux/pci.h       |   3 +
>  5 files changed, 166 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 416540baf27b..324899fbad0a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -270,6 +270,19 @@ void pci_disable_bridge_window(struct pci_dev *dev);
>  struct pci_bus *pci_bus_get(struct pci_bus *bus);
>  void pci_bus_put(struct pci_bus *bus);
> =20
> +#define PCIE_LNKCAP_SLS2SPEED(lnkcap)					\
> +({									\
> +	u32 _lnkcap =3D (lnkcap) & PCI_EXP_LNKCAP_SLS;			\

Why the inconsistency wrt to PCIE_LNKCAP2_SLS2SPEED which doesn't bother wi=
th
this initial mask. It's not needed afterall as the bits checked are all in =
the
mask anyway?

I don't really mind which form but they should look the same.

> +									\
> +	(_lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
> +	 _lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
> +	 _lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
> +	 _lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
> +	 _lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :	\
> +	 _lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :	\
> +	 PCI_SPEED_UNKNOWN);						\
> +})
> +




