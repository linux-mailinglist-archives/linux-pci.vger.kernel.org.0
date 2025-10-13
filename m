Return-Path: <linux-pci+bounces-37892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28516BD2BD0
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 13:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB03B4E6B4A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 11:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A182472AA;
	Mon, 13 Oct 2025 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HuXZx5OY"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9197A4C85;
	Mon, 13 Oct 2025 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760354009; cv=none; b=V00cLP+X+62oPjkSkdowlaD73YIzhrmPts7Dbds4b0Owd8YdwGiLzt6g/dWA3jU0sZwLDG6qIqSouA+Jb1V8YYPiz93Ll7DpGhVgE70gVoHn79B3ANehHGbiNHFGKTjwBugBQNhibAOk1bFl2ovEGo5qBnDKHjqw9c4YiIPrPJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760354009; c=relaxed/simple;
	bh=8BinWCUKE7Euf76twaynN5NmIUe06f/cJGlS8pwQ08s=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DvoZDUpz9UPCQRY/xgWSpjx0iHX4ngye/swVSLkUijWePX/tFygHI1jfDRClBD8Kbvl0LfvhgdKqPlYPLqSUIA1MTH92sIXxLkkezcMaWOrD8AvAAfSrSEBQfbZY95w6TZPFj7Oovplf//RLy+3YxK+eC1Oe+NAR57YH1iqwTRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HuXZx5OY; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59DBDHAJ808399;
	Mon, 13 Oct 2025 06:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760353997;
	bh=czAFqwUxu1RRvsaEwmwAhemzu37izgwHbHusC3tw3xY=;
	h=Subject:From:To:CC:Date:In-Reply-To:References;
	b=HuXZx5OYB3ddlEdZPRO4NTYU+0xRZ26O5qAyPPbwmnOohhT1mNgNjwJE4BEpEmqC9
	 6CPCUGJzCgmE/HsidzKd6bRPWqcMOn5gfGlFk2KjV02e16thXrCkE/2RT/xMNPOiYW
	 OPHcUOuRCCAbsaehysxKvqFEapg/DIlySP6+hs/8=
Received: from DLEE204.ent.ti.com (dlee204.ent.ti.com [157.170.170.84])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59DBDHvH2918415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Oct 2025 06:13:17 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Oct
 2025 06:13:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Oct 2025 06:13:17 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59DBDDct1726378;
	Mon, 13 Oct 2025 06:13:14 -0500
Message-ID: <11a8783345566d5ea6c696ecd007490289ba0b5f.camel@ti.com>
Subject: Re: [RFC v1 1/2] PCI: j721e: Use devm_clk_get_optional_enabled() to
 get the clock
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Anand Moon <linux.amoon@gmail.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "open
 list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-omap@vger.kernel.org>,
        "open
 list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-pci@vger.kernel.org>,
        "moderated
 list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>
Date: Mon, 13 Oct 2025 16:43:19 +0530
In-Reply-To: <20251013101727.129260-2-linux.amoon@gmail.com>
References: <20251013101727.129260-1-linux.amoon@gmail.com>
	 <20251013101727.129260-2-linux.amoon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Mon, 2025-10-13 at 15:47 +0530, Anand Moon wrote:
> Use devm_clk_get_optional_enabled() helper instead of calling
> devm_clk_get_optional() and then clk_prepare_enable(). It simplifies
> the error handling and makes the code more compact. This changes removes
> the unnecessary clk variable and assigns the result of the
> devm_clk_get_optional_enabled() call directly to pcie->refclk.
> This makes the code more concise and readable without changing the
> behavior.
>=20
> Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/con=
troller/cadence/pci-j721e.c
> index 5bc5ab20aa6d..d6bbd04c615b 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -479,7 +479,6 @@ static int j721e_pcie_probe(struct platform_device *p=
dev)
>  	struct cdns_pcie_ep *ep =3D NULL;
>  	struct gpio_desc *gpiod;
>  	void __iomem *base;
> -	struct clk *clk;
>  	u32 num_lanes;
>  	u32 mode;
>  	int ret;
> @@ -603,18 +602,11 @@ static int j721e_pcie_probe(struct platform_device =
*pdev)
>  			goto err_get_sync;
>  		}
> =20
> -		clk =3D devm_clk_get_optional(dev, "pcie_refclk");
> -		if (IS_ERR(clk)) {
> -			ret =3D dev_err_probe(dev, PTR_ERR(clk), "failed to get pcie_refclk\n=
");
> -			goto err_pcie_setup;
> -		}
> -
> -		ret =3D clk_prepare_enable(clk);
> -		if (ret) {
> +		pcie->refclk =3D devm_clk_get_optional_enabled(dev, "pcie_refclk");
> +		if (IS_ERR(pcie->refclk)) {
>  			dev_err_probe(dev, ret, "failed to enable pcie_refclk\n");
>  			goto err_pcie_setup;

'err_pcie_setup' returns 'ret' which isn't being updated above.
Maybe add:
		ret =3D pcie->refclk;
above dev_err_probe(...

>  		}
> -		pcie->refclk =3D clk;
> =20
>  		/*
>  		 * Section 2.2 of the PCI Express Card Electromechanical

Regards,
Siddharth.

