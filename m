Return-Path: <linux-pci+bounces-1737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED8E826034
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 16:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183F8283844
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 15:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7E68485;
	Sat,  6 Jan 2024 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="swOYAxVZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4971F8479
	for <linux-pci@vger.kernel.org>; Sat,  6 Jan 2024 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbbf5a59b7so550282b6e.3
        for <linux-pci@vger.kernel.org>; Sat, 06 Jan 2024 07:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704555210; x=1705160010; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q3T5wprtApMiWljw88MpGG732frIyOF5occnfpC34xI=;
        b=swOYAxVZGoc+1KxQMWz6HJDQrJJD3+s+aElYfHkT0oTJNlYXp6L/bhFBk0hWQXMBaL
         rk+T+EaZ657bEvbk7blgnm/kFYVzMFFDDhu8XlxkYOUf191vtbKQHxHOkdroWY7y/JHi
         i/tqqai4uexrSKJKkudLdCScINA9znt1e2zhYGz/azo06t1JLU0czpFEPVjCbx0fDxr+
         VTVBYwswVed5YzjlJSSg4VHsQ9HdxxhSkztRAd/tqoSSwHj9AV9mr/zyI7zgIYd1aIIK
         bwrIjYDl6VQhW5h+14bYDlT3eP3/UmWNDJyC6AC+QOVtFPUZ+/0by0NCcaF1H8EDJ+aw
         bCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704555210; x=1705160010;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3T5wprtApMiWljw88MpGG732frIyOF5occnfpC34xI=;
        b=s5g59CRn2IMgDVFsfQwgSIxrjUd3eqo1qNW1Ghts2kvPzcJDRxd/JS4uIMzcv+oTi7
         GKm6Rr2xMO3Lxk3pioKtYiY8ky2hMXzFJ/kd3Bmt/uXHn+IuycQpO+C4clYjitkTTJ80
         npzsilX3U7LccYugyCs3GIPwaOHq+ovWdsAWsBEMoXDoQ+kCKYKtiY9e+2C2qypydu87
         JipxHu8iKv50sr4q0LAIN+eayI/Aa1m+cwtbUgChWTXBgjoFL4fu6tRVh62zu5zQfRRT
         Qslg/797CJcTqo2HlXjtPvl1NGC57eAZ1NQhhYb0r8edKuOMriQ9nLtFfsN8j18xDhCW
         KuDQ==
X-Gm-Message-State: AOJu0YxVRq/O2Y35JxXZiSuxAWF9qLpdjjRsVpaASzQuyIfL4Kkotbpv
	VhbGDoAXoufekR204vFwK6HFXJKUUuam
X-Google-Smtp-Source: AGHT+IE48HfYCoztai176Dl774YuvL1b4vOUtB7GUGBwrM5/DUhrnjx+9q3v/swZZE7n5JBxBFc8wg==
X-Received: by 2002:a05:6808:1286:b0:3bb:e0dc:bef8 with SMTP id a6-20020a056808128600b003bbe0dcbef8mr1483126oiw.87.1704555210246;
        Sat, 06 Jan 2024 07:33:30 -0800 (PST)
Received: from thinkpad ([103.197.115.97])
        by smtp.gmail.com with ESMTPSA id ey1-20020a056a0038c100b006d9a6039745sm3210137pfb.40.2024.01.06.07.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 07:33:29 -0800 (PST)
Date: Sat, 6 Jan 2024 21:03:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: krzysztof.kozlowski@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v7 02/16] PCI: imx6: Simplify phy handling by using by
 using IMX6_PCIE_FLAG_HAS_PHY
Message-ID: <20240106153323.GE2512@thinkpad>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-3-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231227182727.1747435-3-Frank.Li@nxp.com>

On Wed, Dec 27, 2023 at 01:27:13PM -0500, Frank Li wrote:
> Refactors the phy handling logic in the imx6 PCI driver by adding
> IMX6_PCIE_FLAG_HAS_PHY bitmask define for drvdata::flags.
> 
> The drvdata::flags and a bitmask ensures a cleaner and more scalable
> switch-case structure for handling phy.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v4 to v5:
>     - none, Keep IMX6_PCIE_FLAG_HAS_PHY to indicate dts mismatch when platform
>     require phy suppport.
>     
>     Change from v1 to v3:
>     - none
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 50d9faaa17f71..4d620249f3d52 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -60,6 +60,9 @@ enum imx6_pcie_variants {
>  #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
>  #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
>  #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
> +#define IMX6_PCIE_FLAG_HAS_PHY			BIT(3)

Every PCIe setup requires PHY for its operation. Perhaps you are referring to
external PHY? If so, please rename this to IMX6_PCIE_FLAG_HAS_EXT_PHY.

> +
> +#define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
>  
>  #define IMX6_PCIE_MAX_CLKS       6
>  
> @@ -1277,6 +1280,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY)) {

IMO, we would not need these kind of checks in the driver if the DT binding is
properly validated using schema. But folks always want to validate "broken DT"
in the drivers :(

But I'm fine with this check for now since not everyone agree with above.

- Mani

> +		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
> +		if (IS_ERR(imx6_pcie->phy))
> +			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
> +					     "failed to get pcie phy\n");
> +	}
> +
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX7D:
>  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> @@ -1306,11 +1316,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
>  					     "failed to get pcie apps reset control\n");
>  
> -		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
> -		if (IS_ERR(imx6_pcie->phy))
> -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
> -					     "failed to get pcie phy\n");
> -
>  		break;
>  	default:
>  		break;
> @@ -1444,13 +1449,15 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  	},
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
> -		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX6_PCIE_FLAG_HAS_PHY,
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
>  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
>  	},
>  	[IMX8MP] = {
>  		.variant = IMX8MP,
> -		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX6_PCIE_FLAG_HAS_PHY,
>  		.gpr = "fsl,imx8mp-iomuxc-gpr",
>  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
>  	},
> @@ -1462,12 +1469,14 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  	},
>  	[IMX8MM_EP] = {
>  		.variant = IMX8MM_EP,
> +		.flags = IMX6_PCIE_FLAG_HAS_PHY,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
>  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
>  	},
>  	[IMX8MP_EP] = {
>  		.variant = IMX8MP_EP,
> +		.flags = IMX6_PCIE_FLAG_HAS_PHY,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mp-iomuxc-gpr",
>  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

