Return-Path: <linux-pci+bounces-18496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D176D9F2E95
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 11:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8851C1886259
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27128203D46;
	Mon, 16 Dec 2024 10:53:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F630203D48
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346390; cv=none; b=Ajp0kQiz0SqjUZISIPU49uWJma/FcDAwzDWEY3ZclyxXGGItzLuXsf1bd4KXaEyjDlHDjBTNcx+hj2higuvLuC8FNIpF0vJf0ZDRG2mLMXuLzNCCIc6DRvwPFZBvf71LJgh5f0lsTghaMcGsTHCMxSITmwlne/dlZkmChAJkwVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346390; c=relaxed/simple;
	bh=fyNLlV4eIMC1JtGYKB0OMeY6VIMYk6XkOS0n1H7Hpng=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ovGOmM3dDpx4wxw2o9pZa35DinY3fFAa2eF3l+oJ+kxxbKNUBbziiPq5x8c+GUqhBf2IpiWkM0U8jRQEiCpNheBcz6+Y5ZFH+cD7sUQkFvNfpyprv6PnKf8d57pUoSaVIXkKSXEwoHeQniRBK1Lq/U2KL3yzuuNo0IA1EDkcRMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YBcFw5wrlz6LDGS;
	Mon, 16 Dec 2024 18:52:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 96803140CB9;
	Mon, 16 Dec 2024 18:53:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Dec
 2024 11:53:06 +0100
Date: Mon, 16 Dec 2024 10:53:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>, "Niklas
 Schnelle" <niks@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Maciej W. Rozycki"
	<macro@orcam.me.uk>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH for-linus v2 2/3] PCI: Honor Max Link Speed when
 determining supported speeds
Message-ID: <20241216105304.00003b47@huawei.com>
In-Reply-To: <0044d6cd05ad20ec3a6ec5a8a22b6ab652e251fe.1734257330.git.lukas@wunner.de>
References: <cover.1734257330.git.lukas@wunner.de>
	<0044d6cd05ad20ec3a6ec5a8a22b6ab652e251fe.1734257330.git.lukas@wunner.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
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

On Sun, 15 Dec 2024 11:20:52 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> The Supported Link Speeds Vector in the Link Capabilities 2 Register
> indicates the *supported* link speeds.  The Max Link Speed field in
> the Link Capabilities Register indicates the *maximum* of those speeds.
>=20
> pcie_get_supported_speeds() neglects to honor the Max Link Speed field
> and will thus incorrectly deem higher speeds as supported.  Fix it.
>=20
> One user-visible issue addressed here is an incorrect value in the sysfs
> attribute "max_link_speed".
>=20
> But the main motivation is a boot hang reported by Niklas:  Intel JHL7540
> "Titan Ridge 2018" Thunderbolt controllers supports 2.5-8 GT/s speeds,
> but indicate 2.5 GT/s as maximum.  Ilpo recalls seeing this on more
> devices.  It can be explained by the controller's Downstream Ports
> supporting 8 GT/s if an Endpoint is attached, but limiting to 2.5 GT/s
> if the port interfaces to a PCIe Adapter, in accordance with USB4 v2
> sec 11.2.1:
>=20
>    "This section defines the functionality of an Internal PCIe Port that
>     interfaces to a PCIe Adapter. [...]
>     The Logical sub-block shall update the PCIe configuration registers
>     with the following characteristics: [...]
>     Max Link Speed field in the Link Capabilities Register set to 0001b
>     (data rate of 2.5 GT/s only).
>     Note: These settings do not represent actual throughput. Throughput
>     is implementation specific and based on the USB4 Fabric performance."
>=20
> The present commit is not sufficient on its own to fix Niklas' boot hang,
> but it is a prerequisite.
>=20
> Fixes: d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds")
> Reported-by: Niklas Schnelle <niks@kernel.org>
> Closes: https://lore.kernel.org/r/70829798889c6d779ca0f6cd3260a765780d136=
9.camel@kernel.org/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

Makes sense as a hardening step, even without the oddity of thunderbolt.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

