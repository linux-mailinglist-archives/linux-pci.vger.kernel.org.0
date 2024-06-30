Return-Path: <linux-pci+bounces-9462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C19791D292
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 18:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2938B281540
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 16:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C4A15383F;
	Sun, 30 Jun 2024 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w9lJumr7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3611613DBBE
	for <linux-pci@vger.kernel.org>; Sun, 30 Jun 2024 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719763455; cv=none; b=gEXgoD1RsOd3CNFlBKXVGCbt0bq6sdLuD8DduUQ+Zt8WF/kknHWaNkwz4EIYgMqhsa6lWejnCrPIQnE7q6DU2P5HYHQk6NWpB33A23N5A9WbxX0+NMBo3Kx0CWyoSSpweWCN20e08aaSHySixCtL6rO7NDLF/0AEItDjLbpkkT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719763455; c=relaxed/simple;
	bh=QSk3MLBFWYxdS1lyWaKLPfiq8c0bClBAB0cXLtw3hkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXR9/oKjIbhaiG+V6G3p8Q2HtE8kJofgPWbWsKbw937roHmKNSFA5uc2Ne+pdSlwpgXWM78cU03eq8JatSbpwTa79yyMoEGxHOHnMmTZIPx+rvnlJg6L43MCbUFtZ7rtNRvDP3qL/ioqQHSH+qUt/gTj3DflOxbUekUbWJy5Uu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w9lJumr7; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-72ed1fbc5d9so1438740a12.0
        for <linux-pci@vger.kernel.org>; Sun, 30 Jun 2024 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719763453; x=1720368253; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AvsobNNphpX1qA8jM6UiYbgsCJI9R8gZdoYIohlPvoU=;
        b=w9lJumr7mv+smZSeD2wj3/xUCqWTjmmljai1URmwp0UwayqlaAP8CpesTMsnGri9wL
         bIIfxc1PY9QgBaI66TYPReEZdXQeTpcA3YQBJjZAP8uQniGzCkZ0QMGb42eUCY90h1qZ
         mzozSI52ZGmoEmVZVL8baRk7hIzWtdSFif3YPN56cHYIQCSvDWQIj+I54C0QU+2uEtAU
         Sn2+WZo7GO4JwBYDIv9Px2iVHhAvKTKolNrMH5NkAG4nedbOdAl2t7YXW7BT3muXcKeE
         lDcn5l5eUxy9nnUtD4uiYMYy+1jNoh+EEQJyOGti5pExZdI3FBF3HE6TOGm80Q4ERkEw
         3Y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719763453; x=1720368253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvsobNNphpX1qA8jM6UiYbgsCJI9R8gZdoYIohlPvoU=;
        b=WXYLCyWJZqTKhgB6ydFFJR+VLG/AvkugHLxQCpLeO/3blUC6SJdN1Q/J6j1oZBMW/s
         IKYbaIneH+1TasC9xbv4zugSup7B6Sl0nBE8XFbZ0uYt8wZh9OQJ/JdQn7yoKVVsfa+H
         Wkas2zMYb8ASRVuUh3OlkLoA5jsbVNMXw7eTsSoQTU0Gu6xF0fDSKn+KK13esE5ACtjr
         2rVTLnEfS5tHc3ZDbFU5952k1UN5wcWcQFmHdGutqZzQEfhxcOkE/jIdJbauK2q/Nq+x
         xTOvaDUhygVpnWlkVbMCe9CgWcUFrZy4SlE2pSBCOCRHeevzdF6Rg5Jg0UTJCgUyn4po
         4GKg==
X-Forwarded-Encrypted: i=1; AJvYcCUEcDoDr7/KYRSjRMgpqahnp50zVqdJLw+Ce30byIvPAkt4WTthZyR/n/KWOX02XZf3aiWdqPotpsfg2RG7H7P0eP4mBaRTVLjq
X-Gm-Message-State: AOJu0Yx9W0ZZU0QlEIv66OrTGJU6U8B9zOKV91fC0kcD+NLZCDMbnESU
	HF6jR+kcLnmU9SRZV1a6OX4J7Zht+eWmiTOZsUr6dtvyehxaVCvMrzEmJMhVXg==
X-Google-Smtp-Source: AGHT+IGyfue7LPLZ7LilRGBZbjr/2wxVRS0FTY7k1T7f6sAuKaMo1GK7re9KdEfypZs3yJjqAb56XQ==
X-Received: by 2002:a05:6a21:18d:b0:1be:bff2:b1b0 with SMTP id adf61e73a8af0-1bef620cb64mr6541664637.40.1719763453270;
        Sun, 30 Jun 2024 09:04:13 -0700 (PDT)
Received: from thinkpad ([220.158.156.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d8b18sm47987155ad.99.2024.06.30.09.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 09:04:12 -0700 (PDT)
Date: Sun, 30 Jun 2024 21:34:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 04/10] PCI: imx6: Introduce SoC specific callbacks for
 controlling REFCLK
Message-ID: <20240630160404.GA5264@thinkpad>
References: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
 <20240617-pci2_upstream-v6-4-e0821238f997@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617-pci2_upstream-v6-4-e0821238f997@nxp.com>

On Mon, Jun 17, 2024 at 04:16:40PM -0400, Frank Li wrote:
> Instead of using the switch case statement to enable/disable the reference
> clock handled by this driver itself, let's introduce a new callback
> set_ref_clk() and define it for platforms that require it. This simplifies

Should this be called 'enable_ref_clk' since the callback is supposed to enable
REFCLK?

> the code.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 112 ++++++++++++++++------------------
>  1 file changed, 52 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 47134e2dfecf2..ff9d0098294fa 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -103,6 +103,7 @@ struct imx_pcie_drvdata {
>  	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
>  	const struct pci_epc_features *epc_features;
>  	int (*init_phy)(struct imx_pcie *pcie);
> +	int (*set_ref_clk)(struct imx_pcie *pcie, bool enable);
>  };
>  
>  struct imx_pcie {
> @@ -585,21 +586,19 @@ static int imx_pcie_attach_pd(struct device *dev)
>  	return 0;
>  }
>  
> -static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
> +static int imx6sx_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
> -	unsigned int offset;
> -	int ret = 0;
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
> +			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
>  
> -	switch (imx_pcie->drvdata->variant) {
> -	case IMX6SX:
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
> -		break;
> -	case IMX6QP:
> -	case IMX6Q:
> +	return 0;
> +}
> +
> +static int imx6q_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> +{
> +	if (enable) {
>  		/* power up core phy and enable ref clock */
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> +		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD, 0);
>  		/*
>  		 * the async reset input need ref clock to sync internally,
>  		 * when the ref clock comes after reset, internal synced
> @@ -608,54 +607,34 @@ static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
>  		 */
>  		usleep_range(10, 100);
>  		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> -		break;
> -	case IMX7D:
> -	case IMX95:
> -	case IMX95_EP:
> -		break;
> -	case IMX8MM:
> -	case IMX8MM_EP:
> -	case IMX8MQ:
> -	case IMX8MQ_EP:
> -	case IMX8MP:
> -	case IMX8MP_EP:
> -		offset = imx_pcie_grp_offset(imx_pcie);
> -		/*
> -		 * Set the over ride low and enabled
> -		 * make sure that REF_CLK is turned on.
> -		 */
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
> -				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
> -				   0);
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
> -				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
> -				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
> -		break;
> +				   IMX6Q_GPR1_PCIE_REF_CLK_EN, IMX6Q_GPR1_PCIE_REF_CLK_EN);
> +	} else {
> +		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
> +		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				   IMX6Q_GPR1_PCIE_TEST_PD, IMX6Q_GPR1_PCIE_TEST_PD);
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
> -static void imx_pcie_disable_ref_clk(struct imx_pcie *imx_pcie)
> +static int imx8mm_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
> -	switch (imx_pcie->drvdata->variant) {
> -	case IMX6QP:
> -	case IMX6Q:
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				IMX6Q_GPR1_PCIE_TEST_PD,
> -				IMX6Q_GPR1_PCIE_TEST_PD);
> -		break;
> -	case IMX7D:
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> -		break;
> -	default:
> -		break;
> -	}
> +	int offset = imx_pcie_grp_offset(imx_pcie);
> +
> +	/* Set the over ride low and enabled make sure that REF_CLK is turned on.*/

This comment provides no useful info. So please remove it.

> +	regmap_update_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
> +			   enable ? 0 : IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
> +			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN : 0);
> +	return 0;
> +}
> +
> +static int imx7d_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> +{
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> +			    enable ? 0 : IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> +	return 0;

Previously imx6_pcie_enable_ref_clk() was bailing out for IMX7D. But now you are
explicitly enabling it. What is the reason?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

