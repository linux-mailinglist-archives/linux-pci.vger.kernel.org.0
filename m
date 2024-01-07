Return-Path: <linux-pci+bounces-1757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D80B0826313
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 06:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748DC282AEE
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 05:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEBD8BFE;
	Sun,  7 Jan 2024 05:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVFCHCKR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7858C15
	for <linux-pci@vger.kernel.org>; Sun,  7 Jan 2024 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28bf1410e37so782737a91.2
        for <linux-pci@vger.kernel.org>; Sat, 06 Jan 2024 21:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704606673; x=1705211473; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7eAcb8U/Xr8Afw7sKhM8tyCYADsawYa0chI/2tUTwyk=;
        b=sVFCHCKRMN19zJwxsPsAv5adID2Zkgkjy5MzrPgRV1igje5sHwz28Vm+8zWLbX1Wo0
         RO1RX0U8P4Y4qRUHGvqIlCpC9P5JRa1iBhvbSg67b+PebP+aN5Klpo21LYYqjkcreg69
         XW9FEV8SYxGg4dlKajcUSt1287VrrRxiM0dSP/BY0qykMnSYjNKBeyu7rbBdcapNAUfi
         lgjW08WUPMJXHT/LZ5wbU1obx13OrBW6fxaTqAfgBZtFa1KbWPtdm2zTqRZhhzCrkDkY
         amrtntCNRzpvuBIEzsyT+CRKObL7SkTxDJbIg06XBcyPm0FusWV8LwWlNwdOwMkLTjaV
         mh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704606673; x=1705211473;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eAcb8U/Xr8Afw7sKhM8tyCYADsawYa0chI/2tUTwyk=;
        b=EVWchMwC63/BAiGF2Eb0exlAiNr8F0kARO1SajKsTVbmB50+AXttaRZg8lZN8mNzAw
         z9pKejkvz8LIoa8zi+oeP6HaqNmlBQ8syGwzfz2DMGCAVZSJ0Xu5PJJm+zXdvpOgvdZC
         rsr1skfijoPY7z45iHvzwb2gbbJs6yKSjmQ3liDsaRP0ZZHcDDgdAD6RUcfjTvE5AWus
         9ZxdD03tzXtvYt6cG7u0MEUHvpL/AB6WQ0GlZTeE6EWdksesPT+dZF5y0MTPlq3MXsYc
         aDL0mMyL0fcRZuMLj7Mp8E71x5FB5XBRF38jSXMUVEgah10SdZ1weGEDuxc28a20v5Ug
         gKBw==
X-Gm-Message-State: AOJu0Yw5aRQdnyfXqyt1ysqZrm4kOd9IpE/vqNOJEZgDhI6X/kTZ5za5
	Iko3LFZso28l5KZLdkdj+1Jt106rB0mn
X-Google-Smtp-Source: AGHT+IGj5EZz0+/fbauC6AN45sMZrVe29Er1ZlBQrJrIMByIAuVk+Xns2TcTYLTphPA7A9ofGaCdPA==
X-Received: by 2002:a17:902:f54f:b0:1d3:c942:144c with SMTP id h15-20020a170902f54f00b001d3c942144cmr2692451plf.80.1704606673385;
        Sat, 06 Jan 2024 21:51:13 -0800 (PST)
Received: from thinkpad ([103.197.115.97])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b001d4e05828a9sm3874717plx.260.2024.01.06.21.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 21:51:12 -0800 (PST)
Date: Sun, 7 Jan 2024 11:21:06 +0530
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
Subject: Re: [PATCH v7 12/16] PCI: imx6: Add iMX95 PCIe support
Message-ID: <20240107055106.GL3416@thinkpad>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-13-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231227182727.1747435-13-Frank.Li@nxp.com>

On Wed, Dec 27, 2023 at 01:27:23PM -0500, Frank Li wrote:

Mention 'RC' in subject.

> Add iMX95 PCIe basic root complex function support.
> 

Add iMX95 PCIe Root Complex support.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v1 to v3
>     - none
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 90 +++++++++++++++++++++++++--
>  1 file changed, 85 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index d66a2db53bdb7..9e60ab6f1885a 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -42,6 +42,25 @@
>  #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
>  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
>  
> +#define IMX95_PCIE_PHY_GEN_CTRL			0x0
> +#define IMX95_PCIE_REF_USE_PAD			BIT(17)
> +
> +#define IMX95_PCIE_PHY_MPLLA_CTRL		0x10
> +#define IMX95_PCIE_PHY_MPLL_STATE		BIT(30)
> +
> +#define IMX95_PCIE_SS_RW_REG_0			0xf0
> +#define IMX95_PCIE_REF_CLKEN			BIT(23)
> +#define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
> +
> +#define IMX95_PE0_GEN_CTRL_1			0x1050
> +#define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
> +
> +#define IMX95_PE0_GEN_CTRL_3			0x1058
> +#define IMX95_PCIE_LTSSM_EN			BIT(0)
> +
> +#define IMX95_PE0_PM_STS			0x1064
> +#define IMX95_PCIE_PM_LINKST_IN_L2		BIT(14)
> +
>  #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
>  
>  enum imx6_pcie_variants {
> @@ -52,6 +71,7 @@ enum imx6_pcie_variants {
>  	IMX8MQ,
>  	IMX8MM,
>  	IMX8MP,
> +	IMX95,
>  	IMX8MQ_EP,
>  	IMX8MM_EP,
>  	IMX8MP_EP,
> @@ -63,6 +83,7 @@ enum imx6_pcie_variants {
>  #define IMX6_PCIE_FLAG_HAS_PHY			BIT(3)
>  #define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(4)
>  #define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
> +#define IMX6_PCIE_FLAG_HAS_SERDES		BIT(6)
>  
>  #define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
>  
> @@ -179,6 +200,24 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
>  	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
>  }
>  
> +static int imx95_pcie_init_phy(struct imx6_pcie *imx6_pcie)
> +{
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +			IMX95_PCIE_SS_RW_REG_0,
> +			IMX95_PCIE_PHY_CR_PARA_SEL,
> +			IMX95_PCIE_PHY_CR_PARA_SEL);
> +
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +			   IMX95_PCIE_PHY_GEN_CTRL,
> +			   IMX95_PCIE_REF_USE_PAD, 0);
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +			   IMX95_PCIE_SS_RW_REG_0,
> +			   IMX95_PCIE_REF_CLKEN,
> +			   IMX95_PCIE_REF_CLKEN);
> +
> +	return 0;
> +}
> +
>  static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
>  {
>  	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
> @@ -579,6 +618,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
>  		break;
>  	case IMX7D:
> +	case IMX95:
>  		break;
>  	case IMX8MM:
>  	case IMX8MM_EP:
> @@ -696,10 +736,19 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  {
>  	struct dw_pcie *pci = imx6_pcie->pci;
>  	struct device *dev = pci->dev;
> +	u32 val;
>  
>  	reset_control_deassert(imx6_pcie->pciephy_reset);
>  
>  	switch (imx6_pcie->drvdata->variant) {
> +	case IMX95:
> +		/* Polling the MPLL_STATE */
> +		if (regmap_read_poll_timeout(imx6_pcie->iomuxc_gpr,
> +					IMX95_PCIE_PHY_MPLLA_CTRL, val,
> +					val & IMX95_PCIE_PHY_MPLL_STATE,
> +					10, 10000))
> +			dev_err(dev, "PCIe PLL lock timeout\n");

You should return err here because, if core deassert is not performed then the
core itself cannot be used.

> +		break;
>  	case IMX7D:
>  		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
>  		 * oscillate, especially when cold.  This turns off "Duty-cycle
> @@ -1281,12 +1330,32 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(imx6_pcie->turnoff_reset);
>  	}
>  
> +	if (imx6_pcie->drvdata->gpr) {
>  	/* Grab GPR config register range */
> -	imx6_pcie->iomuxc_gpr =
> -		 syscon_regmap_lookup_by_compatible(imx6_pcie->drvdata->gpr);
> -	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
> -		dev_err(dev, "unable to find iomuxc registers\n");
> -		return PTR_ERR(imx6_pcie->iomuxc_gpr);
> +		imx6_pcie->iomuxc_gpr =
> +			 syscon_regmap_lookup_by_compatible(imx6_pcie->drvdata->gpr);
> +		if (IS_ERR(imx6_pcie->iomuxc_gpr))
> +			return dev_err_probe(dev, PTR_ERR(imx6_pcie->iomuxc_gpr),
> +					     "unable to find iomuxc registers\n");
> +	}
> +
> +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_SERDES)) {
> +		void __iomem *off = devm_platform_ioremap_resource_byname(pdev, "app");
> +
> +		if (IS_ERR(off))
> +			return dev_err_probe(dev, PTR_ERR(off),
> +					     "unable to find serdes registers\n");
> +
> +		static struct regmap_config regmap_config = {

const

- Mani

-- 
மணிவண்ணன் சதாசிவம்

