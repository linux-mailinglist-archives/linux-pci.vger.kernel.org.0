Return-Path: <linux-pci+bounces-7289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248C88C0EF0
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 13:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F45B210F8
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 11:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C4913172D;
	Thu,  9 May 2024 11:39:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CF71311B6;
	Thu,  9 May 2024 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715254783; cv=none; b=TDE5Z95wLkNDU0U8ks1gXXXTi8Bq1UqZFXneCGV0UTZRRjgTehiLfbEHlYF8o19nMmQ7jWbKpNoY1w1MHMmaQJO11jXCKj27wL0g7zUwbdg+5xz/mQ9CYoR82RFJbQjJwDJDEzmof/ZV7BwnieIYWFk77xY6nrpQUmPwkgszn+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715254783; c=relaxed/simple;
	bh=6Qz4bjICzh8uyecfY7r4wrMMeVHl212hxAyi45Z/xbU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujV1NUjwEpmXqJ5p9ougAE/bj/BAxWIUIduejl9epJgyqidR7CnSZB/y1hzStvLQvROw257f993nhb23JarAh2Zjp+QsSep/UgI9qPQCL+SIz6LPTpObpIu5vtRbk9i6TqAga63u4fNKwWHzQsM5BID1/JFFE8uFRLEGsSkvpbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VZqmB0G1rz6DBQ1;
	Thu,  9 May 2024 19:39:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id ACF4F1400D9;
	Thu,  9 May 2024 19:39:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 9 May
 2024 12:39:36 +0100
Date: Thu, 9 May 2024 12:39:34 +0100
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
Subject: Re: [PATCH v5 5/8] PCI/bwctrl: Re-add BW notification portdrv as
 PCIe BW controller
Message-ID: <20240509123934.0000496b@Huawei.com>
In-Reply-To: <20240508134744.52134-6-ilpo.jarvinen@linux.intel.com>
References: <20240508134744.52134-1-ilpo.jarvinen@linux.intel.com>
	<20240508134744.52134-6-ilpo.jarvinen@linux.intel.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed,  8 May 2024 16:47:41 +0300
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
>    unfortunate, the log spam was the source of complaints that
>    eventually lead to the removal of the bandwidth notifications driver
>    (see the links below for further information).
>=20
> 2) Besides the Link Bandwidth Management Interrupt, enable also Link
>    Autonomous Bandwidth Interrupt to cover the other source of
>    bandwidth changes.
>=20
> 3) Use threaded IRQ with IRQF_ONESHOT to handle Bandwidth Notification
>    Interrupts to address the problem fixed in the commit 3e82a7f9031f
>    ("PCI/LINK: Supply IRQ handler so level-triggered IRQs are acked")).
>=20
> 4) Handle Link Speed updates robustly. Refresh the cached Link Speed
>    when enabling Bandwidth Notification Interrupts, and solve the race
>    between Link Speed read and LBMS/LABS update in
>    pcie_bwnotif_irq_thread().
>=20
> 5) Use concurrency safe LNKCTL RMW operations.
>=20
> 6) The driver is now called PCIe bwctrl (bandwidth controller) instead
>    of just bandwidth notifications because of increased scope and
>    functionality within the driver.
>=20
> 7) Coexist with the Target Link Speed quirk in
>    pcie_failed_link_retrain(). Provide LBMS counting API for it.
>=20
> 8) Tweaks to variable/functions names for consistency and length
>    reasons.
>=20
> Bandwidth Notifications enable the cur_bus_speed in the struct pci_bus
> to keep track PCIe Link Speed changes.
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

A few trivial things inline. Either way LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index 6461aa93fe76..6357bc219632 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -12,4 +12,5 @@ obj-$(CONFIG_PCIEAER_INJECT)	+=3D aer_inject.o
>  obj-$(CONFIG_PCIE_PME)		+=3D pme.o
>  obj-$(CONFIG_PCIE_DPC)		+=3D dpc.o
>  obj-$(CONFIG_PCIE_PTM)		+=3D ptm.o
> +obj-$(CONFIG_PCIE_BWCTRL)	+=3D bwctrl.o
>  obj-$(CONFIG_PCIE_EDR)		+=3D edr.o
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> new file mode 100644
> index 000000000000..5afc533dd0a9
> --- /dev/null
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -0,0 +1,185 @@

> +
> +static irqreturn_t pcie_bwnotif_irq_thread(int irq, void *context)
> +{
> +	struct pcie_device *srv =3D context;
> +	struct pcie_bwctrl_data *data =3D get_service_data(srv);
> +	struct pci_dev *port =3D srv->port;
> +	u16 link_status, events;
> +	int ret;
> +
> +	ret =3D pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
> +	events =3D link_status & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS);
> +
> +	if (ret !=3D PCIBIOS_SUCCESSFUL || !events)
> +		return IRQ_NONE;

Trivial, but nicer to not use link_status if it is garbage (even briefly)
Only a couple of lines more to keep it clean.

	ret =3D pcie...
	if (ret !=3D PCI_BIOS_SUCCESSFUL)
		return IRQ_NONE;

	events =3D ...
	if (!events)
		return IRQ_NONE;

> +
> +	if (events & PCI_EXP_LNKSTA_LBMS)
> +		atomic_inc(&data->lbms_count);
> +
> +	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
> +
> +	/*
> +	 * Interrupts will not be triggered from any further Link Speed
> +	 * change until LBMS is cleared by the write. Therefore, re-read the
> +	 * speed (inside pcie_update_link_speed()) after LBMS has been
> +	 * cleared to avoid missing link speed changes.
> +	 */
> +	pcie_update_link_speed(port->subordinate);
> +
> +	return IRQ_HANDLED;
> +}

> +
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
> +	pci_info(port, "enabled with IRQ %d\n", srv->irq);

Rather noisy given this is easy enough to establish via other paths.
pci_dbg() maybe?

> +
> +	return 0;
> +}
> +
> +static void pcie_bwnotif_remove(struct pcie_device *srv)
> +{
> +	struct pcie_bwctrl_data *data =3D get_service_data(srv);
> +
> +	scoped_guard(rwsem_write, &pcie_bwctrl_remove_rwsem)
> +		srv->port->link_bwctrl =3D NULL;
> +
> +	pcie_bwnotif_disable(srv->port);

Trivial but I'd like a comment to say why this needs to be done after
the link_bwctrl =3D NULL above (or if not, move it before that.
That puts the tear down slightly out of order vs set up.

> +	free_irq(srv->irq, srv);
> +	kfree(data);
> +}
> +


