Return-Path: <linux-pci+bounces-14766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50919A204D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 12:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102D51C208F2
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E431D4150;
	Thu, 17 Oct 2024 10:48:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3937C13B298;
	Thu, 17 Oct 2024 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162108; cv=none; b=nSibYiMel0mdAHQAASDrD7AKaqL5WQbY/rRwdpJzaNR8mNAHq19gypDUKtMn6yRJxrpn5NTqOsgDmbuCslrNsGvprBj94PnkFADecLy6cWK7q6AdJaNtz13pBjLFRt3rDqwNIwYSceBrh5XScMPTsRCYV9zOYHqYUKitE7g3jxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162108; c=relaxed/simple;
	bh=MCmUL7HlIvufNzWDKWiaA/5agSqHzOsXVJ3hCeZEIKI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twyDpvE/8KLFh55PBOFivsrLJyOpDVW/7AJkdbBQSP+KSusrA988iCcvcodFzmflZ/pes4Nf9NjXhOlWYrLj0leuNpIxHVvj8fPZ/mI7E5tmt0wC3mGZp1cyDCtPJFAwadjqd/q/DHId1d0tZMHb+VQTLoYb0cZW3LM0X0gN1fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTkzD1gtSz6FGq7;
	Thu, 17 Oct 2024 18:46:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 01CD71400F4;
	Thu, 17 Oct 2024 18:48:16 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 12:48:14 +0200
Date: Thu, 17 Oct 2024 11:48:12 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lorenzo
 Pieralisi" <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, "Maciej W. Rozycki"
	<macro@orcam.me.uk>, Lukas Wunner <lukas@wunner.de>, Alexandru Gagniuc
	<mr.nuke.me@gmail.com>, Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-kernel@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v8 5/8] PCI/bwctrl: Re-add BW notification portdrv as
 PCIe BW controller
Message-ID: <20241017114812.00005e67@Huawei.com>
In-Reply-To: <20241009095223.7093-6-ilpo.jarvinen@linux.intel.com>
References: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com>
	<20241009095223.7093-6-ilpo.jarvinen@linux.intel.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed,  9 Oct 2024 12:52:20 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> This mostly reverts the commit b4c7d2076b4e ("PCI/LINK: Remove
> bandwidth notification"). An upcoming commit extends this driver
> building PCIe bandwidth controller on top of it.
>=20
> The PCIe bandwidth notification were first added in the commit
> e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth
> notification") but later had to be removed. The significant changes
> compared with the old bandwidth notification driver include:
>=20
> 1) Don't print the notifications into kernel log, just keep the Link
>    Speed cached into the struct pci_bus updated. While somewhat

cached in struct pci_bus updated.

>    unfortunate, the log spam was the source of complaints that
>    eventually lead to the removal of the bandwidth notifications driver
>    (see the links below for further information).
>=20
> Link: https://lore.kernel.org/all/20190429185611.121751-1-helgaas@kernel.=
org/
> Link: https://lore.kernel.org/linux-pci/20190501142942.26972-1-keith.busc=
h@intel.com/
> Link: https://lore.kernel.org/linux-pci/20200115221008.GA191037@google.co=
m/
> Suggested-by: Lukas Wunner <lukas@wunner.de> # Building bwctrl on top of =
bwnotif
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A couple of comments inline, but they are things that I plan
to tackle for other service drivers as part of the first stage
of the rework discussed at LPC.

I don't mind just including patches for this code in there
it you'd prefer to minimize changes at this point.

Jonathan

> +static int pcie_bwnotif_probe(struct pcie_device *srv)
> +{
> +	struct pci_dev *port =3D srv->port;
> +	int ret;
> +
> +	struct pcie_bwctrl_data *data __free(kfree) =3D
> +				kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	set_service_data(srv, data);
> +
> +	ret =3D request_threaded_irq(srv->irq, NULL, pcie_bwnotif_irq_thread,
> +				   IRQF_SHARED | IRQF_ONESHOT, "PCIe bwctrl", srv);
> +	if (ret)
> +		return ret;
> +
> +	port->link_bwctrl =3D no_free_ptr(data);
> +	pcie_bwnotif_enable(srv);
> +
> +	pci_dbg(port, "enabled with IRQ %d\n", srv->irq);
> +
> +	return 0;
> +}
> +
> +static void pcie_bwnotif_remove(struct pcie_device *srv)
> +{
> +	struct pcie_bwctrl_data *data =3D get_service_data(srv);

this is the same as srv->port->link_bwctrl I think
Can we kill of the service data use?  That's one of the early
changes I have in cleaning up portdrv in general.  Aim
is to make it all look much more like you have here with
explicit pointers in port.

If not I'll just sweep that up in the same cleanup set.
(I'm hoping this merges soon to make that exercise easier!)

> +
> +	pcie_bwnotif_disable(srv->port);
> +	scoped_guard(rwsem_write, &pcie_bwctrl_remove_rwsem)
> +		srv->port->link_bwctrl =3D NULL;
> +
> +	free_irq(srv->irq, srv);
> +	kfree(data);

Also on that cleanup plan is using devm_ for all this
stuff in the portdrv service drivers (squashing them
into one driver at the same time).
Maybe worth doing at least the data and irq handling now
but I'm also fine just rolling it into that mega exercise.


> +}


