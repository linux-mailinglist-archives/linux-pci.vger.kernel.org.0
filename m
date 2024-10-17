Return-Path: <linux-pci+bounces-14767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FFF9A2072
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 13:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE299B23928
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 11:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078751D8E16;
	Thu, 17 Oct 2024 11:02:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A110E259C;
	Thu, 17 Oct 2024 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162939; cv=none; b=EfwN+QQ1+VJQY5jh7q5Enq72oVIxhbzKENgr+VrvWD40RuyTrZfFBaodkPr08yQKpUEgRtkCsciAJTqSG60Ulsk094o1/XKtE2kr2HJyicxBmxUCHdW1EwHtSl0CZoMaEciSFJQrjSjxFxmW6cgCDRVz1DyOATUNhK2ckkUP5Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162939; c=relaxed/simple;
	bh=gHvkkRQKd0KU3aP2/Gj51PALd37c2yik7+Xwflenyuw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtJFpNNpwwudDAj7Y8zVSa961bQS8CF6MUnPisZr8Hm6qVqdh89IEkYMSQacnKxH97GK8NZ3x1nCbava4fQ2B18dZZpDROTcC8L0i8Y3owxL+Z3o+WVTYjY5ebZU4IfJbi9NG7VMdYXJslsJ57t3JtHCWA+1wSUz8zn5DQ5w2uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTlHL3Xrfz6FH5m;
	Thu, 17 Oct 2024 19:00:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 501571404F4;
	Thu, 17 Oct 2024 19:02:14 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 13:02:13 +0200
Date: Thu, 17 Oct 2024 12:02:11 +0100
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
Subject: Re: [PATCH v8 6/8] PCI/bwctrl: Add API to set PCIe Link Speed
Message-ID: <20241017120211.00005b1e@Huawei.com>
In-Reply-To: <20241009095223.7093-7-ilpo.jarvinen@linux.intel.com>
References: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com>
	<20241009095223.7093-7-ilpo.jarvinen@linux.intel.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed,  9 Oct 2024 12:52:21 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Currently, PCIe Link Speeds are adjusted by custom code rather than in
> a common function provided in PCI core. PCIe bandwidth controller
> (bwctrl) introduces an in-kernel API to set PCIe Link Speed.
>=20
> Convert Target Speed quirk to use the new API. The Target Speed quirk
> runs very early when bwctrl is not yet probed for a Port and can also
> run later when bwctrl is already setup for the Port, which requires the
> per port mutex (set_speed_mutex) to be only taken if the bwctrl setup
> is already complete.
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

Trivial stuff inline.  The mutex_destroy discussion is a just a consistency
thing given that call is rarely bothered with but here it might help with
debug.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Jonathan

> ---
>  drivers/pci/pci.h         |  20 +++++
>  drivers/pci/pcie/bwctrl.c | 161 +++++++++++++++++++++++++++++++++++++-
>  drivers/pci/quirks.c      |  17 +---
>  include/linux/pci.h       |  10 +++
>  4 files changed, 193 insertions(+), 15 deletions(-)
>=20



> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index 1b11b5da79d4..1d3680ea8e06 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -7,6 +7,11 @@






>  static void pcie_bwnotif_enable(struct pcie_device *srv)
>  {
>  	struct pcie_bwctrl_data *data =3D get_service_data(srv);
> @@ -135,6 +288,7 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
>  	if (!data)
>  		return -ENOMEM;
> =20
> +	mutex_init(&data->set_speed_mutex);
>  	set_service_data(srv, data);
> =20
>  	ret =3D request_threaded_irq(srv->irq, NULL, pcie_bwnotif_irq_thread,
> @@ -142,8 +296,10 @@ static int pcie_bwnotif_probe(struct pcie_device *sr=
v)
>  	if (ret)
>  		return ret;
> =20
> -	port->link_bwctrl =3D no_free_ptr(data);
> -	pcie_bwnotif_enable(srv);
> +	scoped_guard(rwsem_write, &pcie_bwctrl_remove_rwsem) {

Calling it remove_rwsem and using it to protect against not yet
present seems odd. Maybe rename, pcie_bwctrl_bound_rswem or something like =
that?

> +		port->link_bwctrl =3D no_free_ptr(data);
> +		pcie_bwnotif_enable(srv);
> +	}
> =20
>  	pci_dbg(port, "enabled with IRQ %d\n", srv->irq);
> =20
> @@ -159,6 +315,7 @@ static void pcie_bwnotif_remove(struct pcie_device *s=
rv)
>  		srv->port->link_bwctrl =3D NULL;
> =20
>  	free_irq(srv->irq, srv);
> +	mutex_destroy(&data->set_speed_mutex);
Probably not worth doing.  Also you don't do error handling for this above.
Ideal is use devm_ for data and then devm_mutex_init()


>  	kfree(data);
>  }
> =20


