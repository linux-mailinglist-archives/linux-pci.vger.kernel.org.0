Return-Path: <linux-pci+bounces-1760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02901826322
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 07:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B473282990
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 06:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54A8125D1;
	Sun,  7 Jan 2024 06:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zA9CRdIX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109CF125BB
	for <linux-pci@vger.kernel.org>; Sun,  7 Jan 2024 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d4c3393f99so6501175ad.0
        for <linux-pci@vger.kernel.org>; Sat, 06 Jan 2024 22:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704608823; x=1705213623; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iW5VT/4eLpp7PKquWlruWMTFNJDHZ9lSGytu3Jmlq4E=;
        b=zA9CRdIXn+ZYSXunSBqQhUiccYwFAQOTHKctUCKlHRm1K1xqpH2ejGm+Y0eeTJN6YJ
         7WXeZK1RXn/gLGVQBYldbYrVhw2KciSqqo5j4BasF8+bRd6F5EMNSW0bRAX7dkgKvk34
         2KMeCtVeMaMU4Us/BT8TkZaPF82TihdQGHccZVU+18URwkoN6XQNT/eTFh9I/UEdf6+/
         16cm/1G9xNq8ckB1LygB6oAHBsq9YlxC/E8YORpweja32z+LmMltkRi7k++L76fjz2qw
         Qc4DBdKlePrQraXcCRCHqQcnL4p9M00mWzScC0cOwzoU6hZfGN/tbDy7TDIybJ/1/RBW
         wjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704608823; x=1705213623;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iW5VT/4eLpp7PKquWlruWMTFNJDHZ9lSGytu3Jmlq4E=;
        b=JlswnQcHyaa/k0JCMkx2SHs/22xTJ++2jChSIsXBZvr97iKqJTDp83aZyp0TIgNWy8
         BWT5alD2+22Inte8wy27qzJo2wIBPYo4dCDn01VpP8Pk10sCaimDPsftlQ+duZdRMH2P
         IokwYxnh7DK4lz66RuFgCg19rwBKuzbmdG4ceG+WEnxqeUM+a9hgKKeLiTEO6VxialNU
         q93GHHtMKLi2XMTGKoToS08t5vsJYIYvQ7MKFhLa+jAmzKZXmUGsQJQv7LkITq/Y5vAt
         M4cUsSK+Rlm+r9c6yVODrvkvAb12DeDjYNiqO+aC8TwjbGa072S9xRwRSiHFwLZ6aALB
         FpQQ==
X-Gm-Message-State: AOJu0YzkSPEkgfDT5ZgbTGetatM5pBYx0FobKmJ1LIuHu32cP+BRbPcw
	xSJSWcB920F2zGsC2LUhNXz++EOmnAoL
X-Google-Smtp-Source: AGHT+IF9EIsAdvfe7SNGb3Xs8d3OsvAgoF/ITk2xEdFgJKxUc+1zTbZHj5eHo35V0G3bc6Ra+uzqcw==
X-Received: by 2002:a17:902:b70f:b0:1d4:e2bc:88f2 with SMTP id d15-20020a170902b70f00b001d4e2bc88f2mr2077033pls.88.1704608823306;
        Sat, 06 Jan 2024 22:27:03 -0800 (PST)
Received: from thinkpad ([103.197.115.97])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902b60900b001d4c984e02bsm3906425pls.11.2024.01.06.22.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 22:27:02 -0800 (PST)
Date: Sun, 7 Jan 2024 11:56:54 +0530
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
Subject: Re: [PATCH v7 16/16] PCI: imx6: Add iMX95 Endpoint (EP) function
 support
Message-ID: <20240107062654.GO3416@thinkpad>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-17-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231227182727.1747435-17-Frank.Li@nxp.com>

On Wed, Dec 27, 2023 at 01:27:27PM -0500, Frank Li wrote:

Subject: PCI: imx6: Add iMX95 Endpoint (EP) support

> Add iMX95 EP function support and add 64bit address support. Internal bus

Remove 'function' as that refers to endpoint function.

> bridge for PCI support 64bit dma address in iMX95. So set call
> dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)).
> 

'Hence, call dma_set_mask_and_coherent() to set 64 bit DMA mask.'

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v3 to v4
>     - change align to 4k for imx95
>     Change from v1 to v3
>     - new patches at v3
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 45 +++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 6a58fd63a9dd2..00ec59867c17b 100644
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
> @@ -620,6 +622,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  		break;
>  	case IMX7D:
>  	case IMX95:
> +	case IMX95_EP:
>  		break;
>  	case IMX8MM:
>  	case IMX8MM_EP:
> @@ -1063,6 +1066,23 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
>  	.align = SZ_64K,
>  };
>  
> +/*
> + * BAR#	| Default BAR enable	| Default BAR Type	| Default BAR Size	| BAR Sizing Scheme
> + * ================================================================================================
> + * BAR0	| Enable		| 64-bit		| 1 MB			| Programmable Size
> + * BAR1	| Disable		| 32-bit		| 64 KB			| Fixed Size
> + *	| (BAR0 is 64-bit)	| if BAR0 is 32-bit	|			| As Bar0 is 64bit

I couldn't understand above. And not aligned properly.

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
> @@ -1105,6 +1125,14 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
>  
>  	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
>  
> +	/*

Use FIXME here.

- Mani

> +	 * db2 information should fetch from dtb file. dw_pcie_ep_init() can get dbi_base2 from
> +	 * "dbi2" if pci->dbi_base2 is NULL. All code related pcie_dbi2_offset should be removed
> +	 * after all dts added "dbi2" reg.
> +	 */
> +	if (imx6_pcie->drvdata->variant == IMX95_EP)
> +		pci->dbi_base2 = NULL;
> +
>  	ret = dw_pcie_ep_init(ep);
>  	if (ret) {
>  		dev_err(dev, "failed to initialize endpoint\n");
> @@ -1355,6 +1383,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  					     "unable to find iomuxc registers\n");
>  	}
>  
> +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
> +		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +
>  	/* Grab PCIe PHY Tx Settings */
>  	if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
>  				 &imx6_pcie->tx_deemph_gen1))
> @@ -1557,6 +1588,19 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.epc_features = &imx8m_pcie_epc_features,
>  	},
> +	[IMX95_EP] = {
> +		.variant = IMX95_EP,
> +		.flags = IMX6_PCIE_FLAG_HAS_SERDES |
> +			 IMX6_PCIE_FLAG_SUPPORT_64BIT,
> +		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
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
> @@ -1571,6 +1615,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
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

