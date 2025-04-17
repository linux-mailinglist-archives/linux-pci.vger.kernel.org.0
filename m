Return-Path: <linux-pci+bounces-26074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1759DA91650
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 10:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261B917E7DB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 08:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21642192E3;
	Thu, 17 Apr 2025 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="ypmOsvMa"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B82DFA4E
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877859; cv=none; b=sat0ZVz8q8sToUNiJUXQYuQwuDcFqmFzSlSUmkdO65XVnMT6fr/7DYJ7Imj2Vy5ewTdRDpHPxKm+PAG/idl0W7ncHEOKA5VMn2hkq/nfT4iLXaDtFIjB3H+u872getX7fgX+HhSTOKJ1BYAkpQjO+mgmavCPBV0FzsEjK0I5Abg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877859; c=relaxed/simple;
	bh=vyfv5uDFesZcrAllaBn0OZ4VwrlUj+P98dNMmR/LkKc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jV+OXaVaSoHxFNd0OCsb31QScSTXtZMoMKN04PIhI5AuIL6Kn2xXxvnIdLWFXP5N6V5dlG5gaHzw90qnV98EpYvJMNmvu56v+0j5hMJ59ZmpMUFLyt14muR9F725Pl6BF51S211o4Kcs5mirCT8c+4wypDulc3eEME7ZHBXiorI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=ypmOsvMa; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1744877853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wHCWyLOw/2Wsq89rjMWyjH4MzPbVSwCwU1jjVX3VbRQ=;
	b=ypmOsvMaUafpvd5eWmKEvJwYHiXQIdLqQiv0+Ev6Xgn8RI9JEbZbvJkWXxeASxnZrSSQxK
	dux5TjY+RkeTON4aZq7OaBTeIQ8Loz65VK2Cno/krrcZhxdbseFT+SBVAxyCTJSERth3Wd
	Qunqcwan7mdBOkLvEvNbx8K0w6eI6E+w+wMLO2077rRgzKEZ0NiJ12B41T91yf92hQmsQb
	810Rtr2Ta1RGQdD/e+M7zT0woBXUgemXOomE7XK9RW68vYEbzOZpleaPDAilPVnUVfUmh6
	8RXikR19BV3AOHwkGTvkt65GtWBZAFv6nR5DGTXh+miORbBa2szilO60yKh4Pw==
Content-Type: multipart/signed;
 boundary=77376431c399ca9f2570bed1ad7af9fd48ef8140982d7c520b5c570e21a3;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 17 Apr 2025 10:17:25 +0200
Message-Id: <D98RKO927TBG.8ZRWD3GCLSXH@cknow.org>
Cc: <linux-pci@vger.kernel.org>, <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v2] PCI: dw-rockchip: Add system PM support
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Shawn Lin" <shawn.lin@rock-chips.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
References: <1744352048-178994-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1744352048-178994-1-git-send-email-shawn.lin@rock-chips.com>
X-Migadu-Flow: FLOW_OUT

--77376431c399ca9f2570bed1ad7af9fd48ef8140982d7c520b5c570e21a3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri Apr 11, 2025 at 8:14 AM CEST, Shawn Lin wrote:
> This patch adds system PM support for Rockchip platforms by adding .pme_t=
urn_off
> and .get_ltssm hook and tries to reuse possible exist code.

s/exist/existing/ ?

> ...
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
> Changes in v2:
> - Use NOIRQ_SYSTEM_SLEEP_PM_OPS
>
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 185 ++++++++++++++++++++=
+++---
>  1 file changed, 169 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index 56acfea..7246a49 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -21,6 +21,7 @@
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
> =20
> +#include "../../pci.h"
>  #include "pcie-designware.h"
>  ...
> =20
> +static int rockchip_pcie_suspend(struct device *dev)
> +{
> +	struct rockchip_pcie *rockchip =3D dev_get_drvdata(dev);
> +	struct dw_pcie *pci =3D &rockchip->pci;
> +	int ret;
> +
> +	rockchip->intx =3D rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_M=
ASK_LEGACY);
> +
> +	ret =3D dw_pcie_suspend_noirq(pci);
> +	if (ret) {
> +		dev_err(dev, "failed to suspend\n");
> +		return ret;
> +	}
> +
> +	rockchip_pcie_phy_deinit(rockchip);

You're using ``rockchip_pcie_phy_deinit(rockchip)`` here ...

> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> +	reset_control_assert(rockchip->rst);
> +	if (rockchip->vpcie3v3)
> +		regulator_disable(rockchip->vpcie3v3);
> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> +
> +	return 0;
> +}
> +
> +static int rockchip_pcie_resume(struct device *dev)
> +{
> +	struct rockchip_pcie *rockchip =3D dev_get_drvdata(dev);
> +	struct dw_pcie *pci =3D &rockchip->pci;
> +	int ret;
> +
> +	reset_control_assert(rockchip->rst);
> +
> +	ret =3D clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
> +	if (ret) {
> +		dev_err(dev, "clock init failed\n");
> +		goto err_clk;
> +	}
> +
> +	if (rockchip->vpcie3v3) {
> +		ret =3D regulator_enable(rockchip->vpcie3v3);
> +		if (ret)
> +			goto err_power;
> +	}
> +
> +	ret =3D phy_init(rockchip->phy);
> +	if (ret) {
> +		dev_err(dev, "fail to init phy\n");
> +		goto err_phy_init;
> +	}
> +
> +	ret =3D phy_power_on(rockchip->phy);
> +	if (ret) {
> +		dev_err(dev, "fail to power on phy\n");
> +		goto err_phy_on;
> +	}

... would it be possible to reuse ``rockchip_pcie_phy_init(rockchip)``
here ?

otherwise, ``s/fail/failed/`` in the error messages

> +
> +	reset_control_deassert(rockchip->rst);
> +
> +	rockchip_pcie_writel_apb(rockchip, HIWORD_UPDATE(0xffff, rockchip->intx=
),
> +				 PCIE_CLIENT_INTR_MASK_LEGACY);
> +
> +	rockchip_pcie_ltssm_enable_control_mode(rockchip, PCIE_CLIENT_RC_MODE);
> +	rockchip_pcie_unmask_dll_indicator(rockchip);
> +
> +	ret =3D dw_pcie_resume_noirq(pci);
> +	if (ret) {
> +		dev_err(dev, "fail to resume\n");
> +		goto err_resume;
> +	}
> +
> +	return 0;
> +
> +err_resume:
> +	phy_power_off(rockchip->phy);
> +err_phy_on:
> +	phy_exit(rockchip->phy);

I initially thought this sequence was incorrect as I looked at the
``rockchip_pcie_phy_deinit`` function:

	phy_exit(rockchip->phy);
	phy_power_off(rockchip->phy);

https://elixir.bootlin.com/linux/v6.15-rc1/source/drivers/pci/controller/dw=
c/pcie-dw-rockchip.c#L411

But the ``phy_exit`` function docs says "Must be called after phy_power_off=
()."
https://elixir.bootlin.com/linux/v6.15-rc1/source/drivers/phy/phy-core.c#L2=
64

So it seems the code/sequence in this patch is correct, but
``rockchip_pcie_phy_deinit`` has it wrong?

> +err_phy_init:
> +	if (rockchip->vpcie3v3)
> +		regulator_disable(rockchip->vpcie3v3);
> +err_power:
> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> +err_clk:
> +	reset_control_deassert(rockchip->rst);
> +	return ret;
> +}
> +
>  static const struct rockchip_pcie_of_data rockchip_pcie_rc_of_data_rk356=
8 =3D {
>  	.mode =3D DW_PCIE_RC_TYPE,
>  };

Cheers,
  Diederik

--77376431c399ca9f2570bed1ad7af9fd48ef8140982d7c520b5c570e21a3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaAC5FwAKCRDXblvOeH7b
bgxeAQD5QYNSvXPr1J7diAdHDzgCAtqrKYmuRaEnPEeHtNvanAD6AxEEsfdK21iJ
I1+nNmwB0KLtQD8AyjsjZt5yoMGprwQ=
=bwym
-----END PGP SIGNATURE-----

--77376431c399ca9f2570bed1ad7af9fd48ef8140982d7c520b5c570e21a3--

