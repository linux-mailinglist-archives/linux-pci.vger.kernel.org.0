Return-Path: <linux-pci+bounces-4118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ED9868F8E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 12:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DCEC283595
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D3E54BC8;
	Tue, 27 Feb 2024 11:58:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC1355E63
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035084; cv=none; b=JAAFZ91WNakgAK30XxVoiKddDAHwD/ddPMcTznzo5tRuBdQmojhK7EaXWbTjcyI5JEh9ZUkFyf6C5UbTQR4bI+VesyfkL6eFjvkmzn8yziw8DJrRZWPurIvPh5YkNFTmQ3BOC/TfhZi7wbV3PTe9Lk48vH0W+6DIVgaVQ1npfiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035084; c=relaxed/simple;
	bh=ZnZr44qDBGYjZ2eUEfeVxJSCktVUkwBkEVQXETtb/Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbYywYdxL3jgpX/1mlwWsbgD5KDiy+ZVaBzrkGdktDLI8MjNQiv30b+XcTWyPqvdXOcwkZo8Or8zh/D+fVBHtlTU6l0jvbOV+4rokhdH30yg0JHrbE4otBdufnNh1QstPcxk2Q/wj8NMYGlG6g9L7wWC7wMoAYXG0XChKAMxaLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rew5R-0003lO-WA; Tue, 27 Feb 2024 12:57:30 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?utf-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Lei Chuanhua <lchuanhua@maxlinear.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Damien Le Moal <dlemoal@kernel.org>,
 Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <ukleinek@debian.org>
Cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH] PCI: dw-rockchip: Add error messages in .probe()s error paths
Date: Tue, 27 Feb 2024 12:57:28 +0100
Message-ID: <2949150.o0KrE1Onz3@diego>
In-Reply-To: <20240227111837.395422-2-ukleinek@debian.org>
References: <20240227111837.395422-2-ukleinek@debian.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Dienstag, 27. Februar 2024, 12:18:35 CET schrieb Uwe Kleine-K=F6nig:
> Drivers that silently fail to probe provide a bad user experience and
> make it unnecessarily hard to debug such a failure. Fix it by using
> dev_err_probe() instead of a plain return.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@debian.org>

Looks like a much better behavior this way

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 23 ++++++++++++-------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index d6842141d384..4c16d8d2e178 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -225,11 +225,17 @@ static int rockchip_pcie_clk_init(struct rockchip_p=
cie *rockchip)
> =20
>  	ret =3D devm_clk_bulk_get_all(dev, &rockchip->clks);
>  	if (ret < 0)
> -		return ret;
> +		return dev_err_probe(rockchip->pci.dev, ret,
> +				     "failed to get clocks\n");
> =20
>  	rockchip->clk_cnt =3D ret;
> =20
> -	return clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
> +	ret =3D clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
> +	if (ret)
> +		return dev_err_probe(rockchip->pci.dev, ret,
> +				     "failed to enable clocks\n");
> +
> +	return 0;
>  }
> =20
>  static int rockchip_pcie_resource_get(struct platform_device *pdev,
> @@ -237,12 +243,14 @@ static int rockchip_pcie_resource_get(struct platfo=
rm_device *pdev,
>  {
>  	rockchip->apb_base =3D devm_platform_ioremap_resource_byname(pdev, "apb=
");
>  	if (IS_ERR(rockchip->apb_base))
> -		return PTR_ERR(rockchip->apb_base);
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->apb_base),
> +				     "failed to map apb registers\n");
> =20
>  	rockchip->rst_gpio =3D devm_gpiod_get_optional(&pdev->dev, "reset",
>  						     GPIOD_OUT_HIGH);
>  	if (IS_ERR(rockchip->rst_gpio))
> -		return PTR_ERR(rockchip->rst_gpio);
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst_gpio),
> +				     "failed to get reset gpio\n");
> =20
>  	rockchip->rst =3D devm_reset_control_array_get_exclusive(&pdev->dev);
>  	if (IS_ERR(rockchip->rst))
> @@ -320,10 +328,9 @@ static int rockchip_pcie_probe(struct platform_devic=
e *pdev)
>  		rockchip->vpcie3v3 =3D NULL;
>  	} else {
>  		ret =3D regulator_enable(rockchip->vpcie3v3);
> -		if (ret) {
> -			dev_err(dev, "failed to enable vpcie3v3 regulator\n");
> -			return ret;
> -		}
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to enable vpcie3v3 regulator\n");
>  	}
> =20
>  	ret =3D rockchip_pcie_phy_init(rockchip);
>=20
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
>=20





