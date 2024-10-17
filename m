Return-Path: <linux-pci+bounces-14762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8539A1FA8
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 12:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F51B287CA7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0B21D432D;
	Thu, 17 Oct 2024 10:25:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797D41DA10A;
	Thu, 17 Oct 2024 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729160721; cv=none; b=XYkVdhFrMMRwomLk6krbYvEu+3uSrp3GouF9A0Tej/RNrZO1A80UIVGP+xZWeVwFxmD6pV9iP8iFSQWHkh89YEi+7HO8gIy5HQKmthw7a9uoCKCqBbDEZ5JhAxykaNSsnYo7tc0ZFB0zr7ir+noWJBxUOaVxwwj9XyBFAttrIeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729160721; c=relaxed/simple;
	bh=EYl/cHPpZN7OruifUisCUZoCbYXtsoZnOBtL3FBCq9M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObAKIqLnP5nCluFpvaxqFCczXMLr3X0gsgvGK5H8z1qjG9/QXhfh45xRX66yKYxyY32mBjLXsENc60XJhQ9NwjilkCkgG7SCfjfpeCwY8sUkMhQWU9SPdq6acilNKZNULhFAzrwSe4o6qpUkqzIjfBqaCXHZn/Xeigtxe+9ySDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTkPQ6Skcz6LDCG;
	Thu, 17 Oct 2024 18:20:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 51086140C98;
	Thu, 17 Oct 2024 18:25:14 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 12:25:13 +0200
Date: Thu, 17 Oct 2024 11:25:11 +0100
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
Subject: Re: [PATCH v8 2/8] PCI: Store all PCIe Supported Link Speeds
Message-ID: <20241017112511.0000503b@Huawei.com>
In-Reply-To: <20241009095223.7093-3-ilpo.jarvinen@linux.intel.com>
References: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com>
	<20241009095223.7093-3-ilpo.jarvinen@linux.intel.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed,  9 Oct 2024 12:52:17 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:


>=20
> supported_speeds field keeps the extra reserved zero at the least
> significant bit to match the Link Capabilities 2 Register layouting.
layout.

>=20
> An attempt was made to store supported_speeds field into the struct
> pci_bus as an intersection of the both ends of the Link, however, the
> subordinate struct pci_bus is not available early enough. The Target
> Speed quirk (in pcie_failed_link_retrain()) can run either during
> initial scan or later requiring it to use the API PCIe bandwidth
> controller provides to set the Target Link Speed in order to co-exist
> with the bandwidth controller. When the Target Speed quirk is calling
> the bandwidth controller during initial scan, the struct pci_bus is not
> yet initialized. As such, storing supported_speeds into the struct
> pci_bus is not viable.

Excellent detailed description!

>=20
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
One trivial request inline.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/pci.c             | 58 ++++++++++++++++++++++++-----------
>  drivers/pci/probe.c           |  3 ++
>  include/linux/pci.h           | 11 ++++++-
>  include/uapi/linux/pci_regs.h |  1 +
>  4 files changed, 54 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7d85c04fbba2..b28ab4761b18 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

> -enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
> +u8 pcie_get_supported_speeds(struct pci_dev *dev)
>  {
>  	u32 lnkcap2, lnkcap;
> +	u8 speeds;
> =20
> -	/*
> -	 * Link Capabilities 2 was added in PCIe r3.0, sec 7.8.18.  The
> -	 * implementation note there recommends using the Supported Link
> -	 * Speeds Vector in Link Capabilities 2 when supported.
> -	 *
> -	 * Without Link Capabilities 2, i.e., prior to PCIe r3.0, software
> -	 * should use the Supported Link Speeds field in Link Capabilities,
> -	 * where only 2.5 GT/s and 5.0 GT/s speeds were defined.
> -	 */
>  	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
> +	speeds =3D lnkcap2 & PCI_EXP_LNKCAP2_SLS;

I'd be tempted to leave a breadcrumb here in the form of a comment
to stop the obviously 'correct' but totally wrong FIELD_GET()
being used to replace this because of that LSB 0.
You have it well commented elsewhere but anyone editing this
code might not look at where it is written to.

(I'd written that feedback before realizing my error ;)
> =20


