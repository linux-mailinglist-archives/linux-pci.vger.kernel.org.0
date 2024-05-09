Return-Path: <linux-pci+bounces-7291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC8D8C0F11
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 13:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83181C21258
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 11:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39401149E0B;
	Thu,  9 May 2024 11:59:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E8114A90;
	Thu,  9 May 2024 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715255982; cv=none; b=qmFfW5+7X/mjV5dvrfgyVLwja8eNAdJPJL3fTeL62NG2w2Fi6g50bN16HF0T0LZ9+lYR/KUruT/N/NKrCNM+QkfQ8i0FaQMj933ItSMYLsaaXvokI4blBvhdAQPVQ1pqLjaYZ0/9ZL36pc9bGTcba3OMSD1OvJzcIOjFhpHN4e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715255982; c=relaxed/simple;
	bh=mp0XnEHDdveQrBOElZTs+sn0NECWxieR3o11rrV8l0E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0HTidQH4f17+G+KUkORmvf5ig5R9CuZ88R3aTBn0dLKRCc50moi49lgh4X3qArmPH1vxB0k7trEobZTry3e48b9zpev/gdrx6MffXapn+nDNT4ITNVRnXtolFoOo0xJz2avevzkdTDNhp56Eyqo5fkgnyI/JceiGfO6oTlFmNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VZr8D70jmz6K6yB;
	Thu,  9 May 2024 19:56:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A979F1400D9;
	Thu,  9 May 2024 19:59:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 9 May
 2024 12:59:37 +0100
Date: Thu, 9 May 2024 12:59:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lorenzo
 Pieralisi" <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Lukas Wunner
	<lukas@wunner.de>, Alexandru Gagniuc <mr.nuke.me@gmail.com>, "Krishna
 chaitanya chundru" <quic_krichai@quicinc.com>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, <linux-pm@vger.kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, <linux-kernel@vger.kernel.org>, Amit Kucheria
	<amitk@kernel.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v5 7/8] thermal: Add PCIe cooling driver
Message-ID: <20240509125936.00004f30@Huawei.com>
In-Reply-To: <20240508134744.52134-8-ilpo.jarvinen@linux.intel.com>
References: <20240508134744.52134-1-ilpo.jarvinen@linux.intel.com>
	<20240508134744.52134-8-ilpo.jarvinen@linux.intel.com>
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

On Wed,  8 May 2024 16:47:43 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Add a thermal cooling driver to provide path to access PCIe bandwidth
> controller using the usual thermal interfaces.
>=20
> A cooling device is instantiated for controllable PCIe Ports from the
> bwctrl service driver.
>=20
> The thermal side state 0 means no throttling, i.e., maximum supported
> PCIe Link Speed.
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org> # From the cooling device=
 interface perspective

> +struct thermal_cooling_device *pcie_cooling_device_register(struct pci_d=
ev *port)
> +{
> +	struct thermal_cooling_device *cdev;
> +	char *name;
> +
> +	name =3D kasprintf(GFP_KERNEL, COOLING_DEV_TYPE_PREFIX "%s", pci_name(p=
ort));
> +	if (!name)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cdev =3D thermal_cooling_device_register(name, port, &pcie_cooling_ops);
> +	kfree(name);

__free?  Only small saving, but I think it's just about worth it to
give you
	return thermal_cooling_device_register()
and drop the local cdev variable.


> +
> +	return cdev;
> +}

Otherwise LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



