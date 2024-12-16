Return-Path: <linux-pci+bounces-18499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5147B9F2F95
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 12:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA7516B6CC
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 11:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72678204577;
	Mon, 16 Dec 2024 11:32:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA6C205AA1
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 11:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348752; cv=none; b=TWFErgqF1+Qz8LIwAZDqlOIHjn6fucgtrFaLUALyC9fYQMHHeMp1usY253lNYfdgT5iJx5qj6oyWLTXQeOPBo9z56OT7mKD4l8ti9X0B5JWhdtDeWvpjXwH9M8NR2GJs9YS3Y+uM46eXuGw4YtSzZpbBxnO32upRBh97K5KPgc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348752; c=relaxed/simple;
	bh=6F/dKESo9Rnl+mBkKU9jJXcwhXkBqB/yPx6OfJHEhO8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVa9vLuRqY+g64z4M1Q3mB5iGo7r8heH7ttC+vbVlUHoR1j3sXY7zEJ0CoIxgBKFCxisfaX1dbdXDv4u84FipGbU+F5orAtIyokXDZn4sIniHfPtOOu7BeOQ2LrJrw+stOm3Q9AxBMDNpzADeFebVq3lGhUw858kMOOrQpOOhfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YBd7H2j7Vz6LDJ3;
	Mon, 16 Dec 2024 19:31:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FF581408F9;
	Mon, 16 Dec 2024 19:32:25 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Dec
 2024 12:32:24 +0100
Date: Mon, 16 Dec 2024 11:32:22 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>, "Niklas
 Schnelle" <niks@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Maciej W. Rozycki"
	<macro@orcam.me.uk>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH for-linus v2 3/3] PCI/bwctrl: Enable only if more than
 one speed is supported
Message-ID: <20241216113222.000033a4@huawei.com>
In-Reply-To: <2292e75dcf26f1c6d7c1f715edfe0e49f079149d.1734257330.git.lukas@wunner.de>
References: <cover.1734257330.git.lukas@wunner.de>
	<2292e75dcf26f1c6d7c1f715edfe0e49f079149d.1734257330.git.lukas@wunner.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sun, 15 Dec 2024 11:20:53 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> If a PCIe port only supports a single speed, enabling bandwidth control
> is pointless:  There's no need to monitor autonomous speed changes, nor
> can the speed be changed.
>=20
> Not enabling it saves a small amount of memory and compute resources,
> but also fixes a boot hang reported by Niklas:  It occurs when enabling
> bandwidth control on Downstream Ports of Intel JHL7540 "Titan Ridge 2018"
> Thunderbolt controllers.  The ports only support 2.5 GT/s in accordance
> with USB4 v2 sec 11.2.1, so the present commit works around the issue.
>=20
> PCIe r6.2 sec 8.2.1 prescribes that:
>=20
>    "A device must support 2.5 GT/s and is not permitted to skip support
>     for any data rates between 2.5 GT/s and the highest supported rate."
>=20
> Consequently, bandwidth control is currently only disabled if a port
> doesn't support higher speeds than 2.5 GT/s.  However the Implementation
> Note in PCIe r6.2 sec 7.5.3.18 cautions:
>=20
>    "It is strongly encouraged that software primarily utilize the
>     Supported Link Speeds Vector instead of the Max Link Speed field,
>     so that software can determine the exact set of supported speeds on
>     current and future hardware.  This can avoid software being confused
>     if a future specification defines Links that do not require support
>     for all slower speeds."
>=20
> In other words, future revisions of the PCIe Base Spec may allow gaps
> in the Supported Link Speeds Vector.  To be future-proof, don't just
> check whether speeds above 2.5 GT/s are supported, but rather check
> whether *more than one* speed is supported.

It has long felt like the need for the very low speeds will become optional
eventually, though the challenges of getting a backwards compatibility
change into the specification may make that take a while.  Hence
I agree this approach makes sense.

Reviewed-by: Jonathan Cameron <Jonthan.Cameron@huawei.com>

>=20
> Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe =
BW controller")
> Reported-by: Niklas Schnelle <niks@kernel.org>
> Closes: https://lore.kernel.org/r/db8e457fcd155436449b035e8791a8241b0df40=
0.camel@kernel.org/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/pcie/portdrv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 5e10306b6308..02e73099bad0 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -265,12 +265,14 @@ static int get_port_device_capability(struct pci_de=
v *dev)
>  	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
>  		services |=3D PCIE_PORT_SERVICE_DPC;
> =20
> +	/* Enable bandwidth control if more than one speed is supported. */
>  	if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM ||
>  	    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT) {
>  		u32 linkcap;
> =20
>  		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
> -		if (linkcap & PCI_EXP_LNKCAP_LBNC)
> +		if (linkcap & PCI_EXP_LNKCAP_LBNC &&
> +		    hweight8(dev->supported_speeds) > 1)
>  			services |=3D PCIE_PORT_SERVICE_BWCTRL;
>  	}
> =20


