Return-Path: <linux-pci+bounces-2345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5255E8325D1
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 09:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAFB4B21F04
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 08:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62A61E497;
	Fri, 19 Jan 2024 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r7/jEw35"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D0A241EC
	for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705653416; cv=none; b=qIAHkGIPa5q9pSDQR/VRGutDtllUr8hK7gFV05HICEULWB3zWSLaxwXfm7ptnuxAKHts82Fmv4r6Os2SPpAx5/dk2uEerB32jXmaTHknHppfQSkrLGh29AvB6X2fjWStka6als3ULOV1sd5bITQ3U1Hhwo+BcMgnZgPMMvDOShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705653416; c=relaxed/simple;
	bh=An74sy0Qj9Fshhiuou7kSc+ngOIXJBHat6su2pQipds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1QY95doB5ibW0grtiavEMhP+lLUVPX6O4D/90TfGJ2ZXHsUxTjrLkmJV1aHjRNr2vPcwiPOiMr/Oyu4ZfgBA2wu5Q96L3XXNWjclDjVl/RaKU4SEgxmGJAQd/I5V/QxkIqSpEz24RMvtFq9oz0TkI2+Z+5ENxPze7isYJKTdvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r7/jEw35; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6818a9fe380so3167366d6.2
        for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 00:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705653412; x=1706258212; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/m9Dn2s7DAcJl6iK8lEgisV9JoAgGh1R4B8Dzyz9OsA=;
        b=r7/jEw35f+IAuaSsB3Hk1+tFN43DA2nC4db/PKpoVoOtSq9UNDmF10jEU+OEntx2Ba
         43cLkjkbqUW7Z1MsVsewA4I5/BV0oA3g9Bgv5TTpjstKpv6jjIqefOFNimdacNItTRRt
         4WnRDS77LbqDTYsCMRRdPg++MKe7ToB0yBEb4ff8qkMMfYdZ9wQX3ke03gM5f/TjFBzY
         hCCWu9SchwMCY2v2Iy7zqFcwQnLMXsHnduUwBr3cKhsFDRvKf8/MVfPgfw2BEcrwF/Kp
         kMpt5IG+CDr1172KE+THbk2MEATseC0pB+C7+HfVKlaVS83ayYmpz4cMGa6/JuGjHC1e
         /b1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705653412; x=1706258212;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/m9Dn2s7DAcJl6iK8lEgisV9JoAgGh1R4B8Dzyz9OsA=;
        b=uSOvCW1Dyop9M89jzSPe0e3obXEBvAHBbI/tA6QcSo93huCfj/lfbGNr3q0v2NFQ8Q
         xmoR1AVTP0iviJRBwsTBvsp7flH+bRtdvT7LR+0ijK5g5NHY3Skh1CJ488DnhelfSciI
         rkjGqXAgBmlBkJUsdMM8e4XvQEhfqXgIq23eVgy+XVNMRfRAlI1p5KCf3VXvF3TSMFo5
         lDknqJFTOPqY71bbQapGv38Pjge2KK/YKRomCFZlJEGwcGUXzRhN/DGbAYhGCQa6Ng+5
         7zJg9cJ/JmCe2WnrYnR8bpJ8Q7F71Gdzg8LkmzhEM07FzTY1ep2GSpR6CczAYYEAKqOG
         x6JQ==
X-Gm-Message-State: AOJu0YyLcxYg145PlQleSUlOYxrL6ImSfVesHHTKQ3hBNltNi+baQaeM
	XKECC9OcV7JDaKvh6jYXpoqmL7Cy9/A58Ta22XoV/DbHjy8KzKfTvsAFmv7SzQ==
X-Google-Smtp-Source: AGHT+IGlb7Np49bNK6MfN45X9m/DEmw7SZ2hsGwQDKQU1UGOoLwHr2Rse3cZQJORbM9zYpOtddks/w==
X-Received: by 2002:a05:6214:440a:b0:683:29e6:d696 with SMTP id oj10-20020a056214440a00b0068329e6d696mr680148qvb.102.1705653412167;
        Fri, 19 Jan 2024 00:36:52 -0800 (PST)
Received: from thinkpad ([117.248.2.56])
        by smtp.gmail.com with ESMTPSA id lu19-20020a0562145a1300b0068200592351sm498483qvb.89.2024.01.19.00.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 00:36:51 -0800 (PST)
Date: Fri, 19 Jan 2024 14:06:39 +0530
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
Subject: Re: [PATCH v8 16/16] PCI: imx6: Add iMX95 Endpoint (EP) support
Message-ID: <20240119083639.GI2866@thinkpad>
References: <20240108232145.2116455-1-Frank.Li@nxp.com>
 <20240108232145.2116455-17-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240108232145.2116455-17-Frank.Li@nxp.com>

On Mon, Jan 08, 2024 at 06:21:45PM -0500, Frank Li wrote:
> Add iMX95 EP support and add 64bit address support. Internal bus bridge for
> PCI support 64bit dma address in iMX95. Hence, call
> dma_set_mask_and_coherent() to set 64 bit DMA mask.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

One comment below. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
> 
> Notes:
>     Change from v7 to v8
>     - Update commit message
>     - Using Fixme
>     - Update clks_cnts by ARRAY_SIZE
>     
>     Change from v4 to v7
>     - none
>     Change from v3 to v4
>     - change align to 4k for imx95
>     Change from v1 to v3
>     - new patches at v3
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 46 +++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 3f474d4749dce..69ba72c3a9c9c 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -75,6 +75,7 @@ enum imx6_pcie_variants {
>  	IMX8MQ_EP,
>  	IMX8MM_EP,
>  	IMX8MP_EP,
> +	IMX95_EP,
>  };
>  
>  #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
> @@ -84,6 +85,7 @@ enum imx6_pcie_variants {
>  #define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(4)
>  #define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
>  #define IMX6_PCIE_FLAG_HAS_SERDES		BIT(6)
> +#define IMX6_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
>  
>  #define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
>  
> @@ -616,6 +618,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  		break;
>  	case IMX7D:
>  	case IMX95:
> +	case IMX95_EP:
>  		break;
>  	case IMX8MM:
>  	case IMX8MM_EP:
> @@ -1050,6 +1053,23 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
>  	.align = SZ_64K,
>  };
>  
> +/*
> + * BAR#	| Default BAR enable	| Default BAR Type	| Default BAR Size	| BAR Sizing Scheme
> + * ================================================================================================
> + * BAR0	| Enable		| 64-bit		| 1 MB			| Programmable Size
> + * BAR1	| Disable		| 32-bit		| 64 KB			| Fixed Size
> + *	| (If BAR0 is 64-bit)	| (if BAR0 is 32-bit)	| (if BAR0 is 32-bit)	| As Bar0 is 64bit

I think the above comment needs some fixup. I think you want to say that if BAR0
is 64bit then BAR1 should be disabled? If not, please clarify.

> + * BAR2	| Enable		| 32-bit		| 1 MB			| Programmable Size
> + * BAR3	| Enable		| 32-bit		| 64 KB			| Programmable Size
> + * BAR4	| Enable		| 32-bit		| 1M			| Programmable Size
> + * BAR5	| Enable		| 32-bit		| 64 KB			| Programmable Size
> + */
> +static const struct pci_epc_features imx95_pcie_epc_features = {
> +	.msi_capable = true,
> +	.bar_fixed_size[1] = SZ_64K,
> +	.align = SZ_4K,
> +};
> +
>  static const struct pci_epc_features*
>  imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
>  {
> @@ -1092,6 +1112,14 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
>  
>  	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
>  
> +	/*
> +	 * FIXME: dbi2 information should fetch from dtb file. dw_pcie_ep_init() can get dbi_base2
> +	 * from "dbi2" if pci->dbi_base2 is NULL. All code related pcie_dbi2_offset should be
> +	 * removed after all dts added "dbi2" reg.
> +	 */

	FIXME: Ideally, dbi2 base address should come from DT. But since only IMX95 is
	defining "dbi2" in DT, "dbi_base2" is set to NULL here for that platform alone
	so that the DWC core code can fetch that from DT. But once all platform
	DTs were fixed, this and the above "dbi_base2" setting should be removed.

- Mani

> +	if (imx6_pcie->drvdata->variant == IMX95_EP)
> +		pci->dbi_base2 = NULL;
> +
>  	ret = dw_pcie_ep_init(ep);
>  	if (ret) {
>  		dev_err(dev, "failed to initialize endpoint\n");
> @@ -1345,6 +1373,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  					     "unable to find iomuxc registers\n");
>  	}
>  
> +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
> +		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +
>  	/* Grab PCIe PHY Tx Settings */
>  	if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
>  				 &imx6_pcie->tx_deemph_gen1))
> @@ -1567,6 +1598,20 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.epc_features = &imx8m_pcie_epc_features,
>  	},
> +	[IMX95_EP] = {
> +		.variant = IMX95_EP,
> +		.flags = IMX6_PCIE_FLAG_HAS_SERDES |
> +			 IMX6_PCIE_FLAG_SUPPORT_64BIT,
> +		.clk_names = imx6_4clks_bus_pcie_phy_aux,
> +		.clks_cnt = ARRAY_SIZE(imx6_4clks_bus_pcie_phy_aux),
> +		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
> +		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
> +		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
> +		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
> +		.init_phy = imx95_pcie_init_phy,
> +		.epc_features = &imx95_pcie_epc_features,
> +		.mode = DW_PCIE_EP_TYPE,
> +	},
>  };
>  
>  static const struct of_device_id imx6_pcie_of_match[] = {
> @@ -1581,6 +1626,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
>  	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
>  	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
>  	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
> +	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
>  	{},
>  };
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

