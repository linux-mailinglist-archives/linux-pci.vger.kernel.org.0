Return-Path: <linux-pci+bounces-14768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0F79A208A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 13:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FB01F26ECF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 11:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8CC1DB375;
	Thu, 17 Oct 2024 11:05:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07256259C;
	Thu, 17 Oct 2024 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163105; cv=none; b=srpTh2Y1xltb/xXG4akgGb/ON3XtMtLaCUnqfIYT5VBUomtvgBaCS0USQ2QJPtZZRbAZrGOjYYycVO/yyGDyz4/bapjwh7kZv6ItrE88ji7Ly/I65sQhwLv5RKmliLjKID5d1DnxbjvfhF5bb342EctmzuBc3IRyMMCwBCvC0eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163105; c=relaxed/simple;
	bh=jEeOGKsEWcwjZnI/On0ISkALOsW6ASw+8Llo1EFKORE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJOQBV8ctL6S2N5i6QjOGIeRKK0b4RjGmBqx/m6rIA6LYDh3Jr6Y3f6FpM+OV7Ibl1tXsHZKLPYrHK1p9AzVYj8VwD2khq1jht9Qs93gaa/ZR8ym7lX4PSuITf0o24tXkctGNhQ2LJl0wOwtmxHqUw13TweinjM46SH9zjhz1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTlLX3cbHz6FH4h;
	Thu, 17 Oct 2024 19:03:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3727E1400DB;
	Thu, 17 Oct 2024 19:05:00 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 13:04:58 +0200
Date: Thu, 17 Oct 2024 12:04:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lorenzo
 Pieralisi" <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, "Maciej W. Rozycki"
	<macro@orcam.me.uk>, Lukas Wunner <lukas@wunner.de>, Alexandru Gagniuc
	<mr.nuke.me@gmail.com>, Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, <linux-kernel@vger.kernel.org>, Amit Kucheria
	<amitk@kernel.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v8 7/8] thermal: Add PCIe cooling driver
Message-ID: <20241017120456.00006023@Huawei.com>
In-Reply-To: <20241009095223.7093-8-ilpo.jarvinen@linux.intel.com>
References: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com>
	<20241009095223.7093-8-ilpo.jarvinen@linux.intel.com>
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

On Wed,  9 Oct 2024 12:52:22 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Add a thermal cooling driver to provide path to access PCIe bandwidth
> controller using the usual thermal interfaces.
>=20
> A cooling device is instantiated for controllable PCIe Ports from the
> bwctrl service driver.
>=20
> If registering the cooling device fails, allow bwctrl's probe to
> succeed regardless. As cdev in that case contains IS_ERR() pseudo
> "pointer", clean that up inside the probe function so the remove side
> doesn't need to suddenly make an odd looking IS_ERR() check.
>=20
> The thermal side state 0 means no throttling, i.e., maximum supported
> PCIe Link Speed.
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org> # From the cooling device=
 interface perspective

Trivial thing noticed on a reread.


> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 61e7ae524b1f..d3f9686e26e7 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -220,6 +220,15 @@ config DEVFREQ_THERMAL
> =20
>  	  If you want this support, you should say Y here.
> =20
> +config PCIE_THERMAL
> +	bool "PCIe cooling support"
> +	depends on PCIEPORTBUS
> +	help
> +	  This implements PCIe cooling mechanism through bandwidth reduction
> +	  for PCIe devices.

Technically links not devices, but don't think that matters much





