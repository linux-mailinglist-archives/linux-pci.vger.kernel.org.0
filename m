Return-Path: <linux-pci+bounces-9505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A5591DBBA
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 11:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02116282B24
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 09:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1F12C859;
	Mon,  1 Jul 2024 09:48:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1C784E18
	for <linux-pci@vger.kernel.org>; Mon,  1 Jul 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719827326; cv=none; b=OMzBRVr75nIZhEbUkbYaAwNONnNk5nk283wm7PLe46jFDAT4fPFQ7oWkdA0ApgjKDaw4CRVT7axiZzse+FtHjpIs7ryEtwsvSMYMuGRFwLV6YMKzZ7V9+l14n6sBpm0KLgCLHBY3US9+Lvoq7nA04kxmAzl0JIsMlQ+Qyrdk+0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719827326; c=relaxed/simple;
	bh=Z09LYIfA/dfPotbWA569LzVRfGZJFnaGg2r3ovjw8dw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o4QoyTNhOXILO5wQau1CaPzSvP3gL7xKjy/EmIYZsFtHlZm0Xri8utFa8/osCxx6jyppVeZFSWKOJix4pd0P58+Tnjgzzu7uaiE+Vd0SLVWgrfWLofYzZ1O+URvZ/iMKupFGLIlkbfLXzxlQR4/q6xJTSnBcXkxrCZ4uXNfLoWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sODe1-0003y0-Fp; Mon, 01 Jul 2024 11:48:21 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sODe0-006LFX-4z; Mon, 01 Jul 2024 11:48:20 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sODe0-000QE4-0G;
	Mon, 01 Jul 2024 11:48:20 +0200
Message-ID: <9f87eba115b8cb3ef7499f8615ef5fc009a74f22.camel@pengutronix.de>
Subject: Re: [PATCH v1 4/8] PCI: brcmstb: Use swinit reset if available
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org, 
 Nicolas Saenz Julienne <nsaenz@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Cyril
 Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,  Rob Herring <robh@kernel.org>, "moderated list:BROADCOM
 BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Mon, 01 Jul 2024 11:48:19 +0200
In-Reply-To: <20240628205430.24775-5-james.quinlan@broadcom.com>
References: <20240628205430.24775-1-james.quinlan@broadcom.com>
	 <20240628205430.24775-5-james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org

Hi Jim,

On Fr, 2024-06-28 at 16:54 -0400, Jim Quinlan wrote:
> The 7712 SOC adds a software init reset device for the PCIe HW.
> If found in the DT node, use it.
>=20
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controll=
er/pcie-brcmstb.c
> index 4104c3668fdb..0f1c3e1effb1 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -266,6 +266,7 @@ struct brcm_pcie {
>  	struct reset_control	*rescal;
>  	struct reset_control	*perst_reset;
>  	struct reset_control	*bridge;
> +	struct reset_control	*swinit;
>  	int			num_memc;
>  	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>  	u32			hw_rev;
> @@ -1626,6 +1627,25 @@ static int brcm_pcie_probe(struct platform_device =
*pdev)
>  		dev_err(&pdev->dev, "could not enable clock\n");
>  		return ret;
>  	}
> +
> +	pcie->swinit =3D devm_reset_control_get_optional_exclusive(&pdev->dev, =
"swinit");
> +	if (IS_ERR(pcie->swinit)) {
> +		ret =3D dev_err_probe(&pdev->dev, PTR_ERR(pcie->swinit),
> +				    "failed to get 'swinit' reset\n");
> +		goto clk_out;
> +	}
> +
> +	ret =3D reset_control_assert(pcie->swinit);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "could not assert reset 'swinit'\n");
> +		goto clk_out;
> +	} else {

No need for an else branch here.

> +		ret =3D dev_err_probe(&pdev->dev, reset_control_deassert(pcie->swinit)=
,
> +				    "could not de-assert reset 'swinit' after asserting\n");

Please don't call dev_err_probe() when reset_control_deassert() returns
0.

> +		if (ret)
> +			goto clk_out;
> +	}
> +
>  	pcie->rescal =3D devm_reset_control_get_optional_shared(&pdev->dev, "re=
scal");
>  	if (IS_ERR(pcie->rescal)) {
>  		ret =3D PTR_ERR(pcie->rescal);

regards
Philipp

