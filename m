Return-Path: <linux-pci+bounces-1128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 002228160B5
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 18:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AEACB210EF
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 17:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F5045C0C;
	Sun, 17 Dec 2023 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vKaydqxP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081B14643A
	for <linux-pci@vger.kernel.org>; Sun, 17 Dec 2023 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7b7d65d4eecso2790339f.0
        for <linux-pci@vger.kernel.org>; Sun, 17 Dec 2023 09:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702833501; x=1703438301; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yvzvPPOvURo9eUay1zjag8iF5jEJZnvBduw4ZeL4Nkg=;
        b=vKaydqxPH5eN5TDUVUldqnsWrWBSqc7lpcbdJJ3eBCo1mKHv6QBBqd4VE2w9ZmENPS
         1yl7wuauPNPCEPxAYfNafFobpMI9Uq8vkA56AOVXKQm+ro9uM59CKKxLTsfStZ7oNqcB
         cLkOMvp/ITOcBeIObfFBI/KcnylIK0l/QQh9FmA+LR/CTe45cgxf4GDTnWJG40vynpJj
         iSbfgfVfxUBwXTNApdlMhP+1X2+fgitUZ6vSwuVJgrkuK35seAnO1h5nWYaLIRGfVlOt
         Sp0z1bWi/gHw9UI8Ar38+4ZYFE3skS0cicrLQUDjOuyQq/BviDszpJ/wl57YN5sYFO+L
         35lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702833501; x=1703438301;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvzvPPOvURo9eUay1zjag8iF5jEJZnvBduw4ZeL4Nkg=;
        b=j8OkgoT5dSwX7uxvh0TRfFLWIkwWkP55eHIJs03Roc2y22N64JpREy4fSQBiDZrEAi
         nRl9cB9k/+L45n553RgKFYDgucS5fryIqhGOsjxgrcb/KYUAswZszKX0fssw3WpDbB2+
         OX62Zzi9Df0IXEsfzOLeOQGiaC1wanOehIyPiXjn4YMAv7fi4nDin4zkX6VhbhouG6eX
         3WKA+dkO/MJt9Dj3Yq35sRGCmMcuPb26iz6DxGdhUS/MqYfX3Q/WdEQRpEUEldqsEt2V
         yBhJylHfVf0o658dfDJ/XlDgCIKe2XJBQFHeRMRAXwteEj5PDFBdZNrQrJSf7WvcRZPb
         xN/Q==
X-Gm-Message-State: AOJu0Ywk52ZXOWmn5pSz+kWauga3jkVWGTBb4EIZ+yEkFh/ZqwS36ygG
	ZQtmbCM8QKfs2AMex1bozhHM
X-Google-Smtp-Source: AGHT+IG3iO9wwq2fHlKI2rNEIawMaBY13xkH+6DklBN+WvV2sdv33dbHZONs8rR6f4Lcf7btRm5LJw==
X-Received: by 2002:a05:6602:4902:b0:7b6:fc2d:6b52 with SMTP id ef2-20020a056602490200b007b6fc2d6b52mr17463986iob.4.1702833501039;
        Sun, 17 Dec 2023 09:18:21 -0800 (PST)
Received: from thinkpad ([103.28.246.178])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090311d200b001d3867b6424sm4383852plh.113.2023.12.17.09.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 09:18:20 -0800 (PST)
Date: Sun, 17 Dec 2023 22:48:11 +0530
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
Subject: Re: [PATCH v4 02/15] PCI: imx6: Simplify phy handling by using by
 using IMX6_PCIE_FLAG_HAS_PHY
Message-ID: <20231217171811.GD6748@thinkpad>
References: <20231217051210.754832-1-Frank.Li@nxp.com>
 <20231217051210.754832-3-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231217051210.754832-3-Frank.Li@nxp.com>

On Sun, Dec 17, 2023 at 12:11:57AM -0500, Frank Li wrote:
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
>     Change from v1 to v3:
>     - none
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 2086214345e9a..91ba26a4b4c3d 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -60,6 +60,9 @@ enum imx6_pcie_variants {
>  #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
>  #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
>  #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
> +#define IMX6_PCIE_FLAG_HAS_PHY			BIT(3)
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
> +		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");

Can't you use devm_phy_optional_get()? This will return NULL if the PHY is not
defined in DT. So you can use IS_ERR() to catch error if there are issues in
acquiring PHY if defined and NULL can be safely passed to other PHY APIs like
phy_init() as well.

With this, you won't need a flag in drv_data and can also get rid of the
condition around PHY APIs.

- Mani

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
> @@ -1447,13 +1452,15 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  	},
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
> -		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX6_PCIE_FLAG_HAS_PHY,
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
>  		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
>  	},
>  	[IMX8MP] = {
>  		.variant = IMX8MP,
> -		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX6_PCIE_FLAG_HAS_PHY,
>  		.gpr = "fsl,imx8mp-iomuxc-gpr",
>  		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
>  	},
> @@ -1465,12 +1472,14 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  	},
>  	[IMX8MM_EP] = {
>  		.variant = IMX8MM_EP,
> +		.flags = IMX6_PCIE_FLAG_HAS_PHY,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
>  		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
>  	},
>  	[IMX8MP_EP] = {
>  		.variant = IMX8MP_EP,
> +		.flags = IMX6_PCIE_FLAG_HAS_PHY,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mp-iomuxc-gpr",
>  		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

