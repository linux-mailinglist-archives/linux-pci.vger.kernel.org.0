Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AE5776EC4
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 05:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjHJDwg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 23:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjHJDwf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 23:52:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BC02106
        for <linux-pci@vger.kernel.org>; Wed,  9 Aug 2023 20:52:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bbc87ded50so3953425ad.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Aug 2023 20:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691639554; x=1692244354;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=106oaHzVENljB1r9Ilco+nVkcPBz4ynGwBuHp2G7PlU=;
        b=vNPPS41gfiEpcUheQlMW5O8HFgjVprYn1GQtVU2G6nJ5+KpOWMX2hAkmhyXIVklOqH
         kdqyfrWASBG2iaw/3xIX4ziTcTRtAUeS09VQeIfzAGjTsl4LqOA8sp+tYf8Z3trRpumv
         OAOtvh9a71IEiJMP0kLRKvnp7kV/Qv6PVf5QL0mIr2ghGmtx/nBitvHxmFlOL+QLvdna
         nJdGO1wOeruACvSoBwUMBwo7rtpl4QqIdT+QIcYYBdgz/kksmaFJTP6BS1MIvr7/NvNS
         x6agBb8UmMtXFSBrWyVV46zmDM27CJ0Ro4EdYipcRieMiwlzqiAB/Vrd6rYsshIzeGl4
         Uxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691639554; x=1692244354;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=106oaHzVENljB1r9Ilco+nVkcPBz4ynGwBuHp2G7PlU=;
        b=EgX+j93J6yPBgoWk77tYAXQzJGBzJJKlNc0g7T43vK54PlIflP3+k0Z/fBLxynEA5k
         LKKmk4NK992IznqZyznlitFBzi1nnci+4KLEyLjnFuzKFZ4hLggGsX5UyVfZje36COtY
         lfUvjHXsxszPtVXDRBiqacEZn3ubq3lRhAn1iutPHaDRsFI3Ede5s1cH2MroFt5sF3bp
         BS5nLaXWpHwwgPJiEC8CgipNhwpOUGIHPhpw64aBsSeG62Ao+M7RTHkriML5Tlx9ciJ6
         NGJFSmxW7KyqoFqZw0j+2UyNCjNf2yIESKQEuMn17wDm25hUVesRNrJJWFk+rBZNiOx+
         6vFw==
X-Gm-Message-State: AOJu0Yy2fQczdEczOO2h/2QEbgRzSQpTGDv7Rlp85DyNZi1dxoi3EqbF
        Rcy8+4skNJaTeaV/2lU/ttlB/eJgAbIhJO/G/A==
X-Google-Smtp-Source: AGHT+IGOtHExmj+iyXe1gx7sSoFJUWIPig5WfmekAfRO6OdAUNTyLvG2sO0jGlxS8WXSFjE4/02n3g==
X-Received: by 2002:a17:902:ee94:b0:1bb:a125:f831 with SMTP id a20-20020a170902ee9400b001bba125f831mr1047717pld.58.1691639554235;
        Wed, 09 Aug 2023 20:52:34 -0700 (PDT)
Received: from thinkpad ([117.193.214.179])
        by smtp.gmail.com with ESMTPSA id j16-20020a170902da9000b001b8a1a25e6asm373199plx.128.2023.08.09.20.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 20:52:33 -0700 (PDT)
Date:   Thu, 10 Aug 2023 09:22:24 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     frank.li@nxp.com, l.stach@pengutronix.de, shawnguo@kernel.org,
        lpieralisi@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v3 9/9] PCI: imx6: Add i.MX7D PCIe EP support
Message-ID: <20230810035224.GA4860@thinkpad>
References: <1691472858-9383-1-git-send-email-hongxing.zhu@nxp.com>
 <1691472858-9383-10-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1691472858-9383-10-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 08, 2023 at 01:34:18PM +0800, Richard Zhu wrote:
> Add the i.MX7D PCIe EP mode support.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 43c5251f5160..af7659712537 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -52,6 +52,7 @@ enum imx6_pcie_variants {
>  	IMX6QP,
>  	IMX6QP_EP,
>  	IMX7D,
> +	IMX7D_EP,
>  	IMX8MQ,
>  	IMX8MM,
>  	IMX8MP,
> @@ -359,6 +360,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
>  					   0);
>  		break;
>  	case IMX7D:
> +	case IMX7D_EP:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
>  		break;
> @@ -590,6 +592,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
>  		break;
>  	case IMX7D:
> +	case IMX7D_EP:
>  		break;
>  	case IMX8MM:
>  	case IMX8MM_EP:
> @@ -638,6 +641,7 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
>  				IMX6Q_GPR1_PCIE_TEST_PD);
>  		break;
>  	case IMX7D:
> +	case IMX7D_EP:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
>  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> @@ -711,6 +715,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  {
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX7D:
> +	case IMX7D_EP:
>  	case IMX8MQ:
>  	case IMX8MQ_EP:
>  		reset_control_assert(imx6_pcie->pciephy_reset);
> @@ -763,6 +768,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  		reset_control_deassert(imx6_pcie->pciephy_reset);
>  		break;
>  	case IMX7D:
> +	case IMX7D_EP:
>  		reset_control_deassert(imx6_pcie->pciephy_reset);
>  
>  		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
> @@ -854,6 +860,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
>  				   IMX6Q_GPR12_PCIE_CTL_2);
>  		break;
>  	case IMX7D:
> +	case IMX7D_EP:
>  	case IMX8MQ:
>  	case IMX8MQ_EP:
>  	case IMX8MM:
> @@ -880,6 +887,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
>  				   IMX6Q_GPR12_PCIE_CTL_2, 0);
>  		break;
>  	case IMX7D:
> +	case IMX7D_EP:
>  	case IMX8MQ:
>  	case IMX8MQ_EP:
>  	case IMX8MM:
> @@ -1385,6 +1393,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  					     "pcie_aux clock source missing or invalid\n");
>  		fallthrough;
>  	case IMX7D:
> +	case IMX7D_EP:
>  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
>  			imx6_pcie->controller_id = 1;
>  
> @@ -1572,6 +1581,12 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx7d-iomuxc-gpr",
>  	},
> +	[IMX7D_EP] = {
> +		.variant = IMX7D_EP,
> +		.mode = DW_PCIE_EP_TYPE,
> +		.gpr = "fsl,imx7d-iomuxc-gpr",
> +		.epc_features = &imx6q_pcie_epc_features,
> +	},
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
>  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> @@ -1611,6 +1626,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
>  	{ .compatible = "fsl,imx6qp-pcie", .data = &drvdata[IMX6QP], },
>  	{ .compatible = "fsl,imx6qp-pcie-ep", .data = &drvdata[IMX6QP_EP], },
>  	{ .compatible = "fsl,imx7d-pcie",  .data = &drvdata[IMX7D],  },
> +	{ .compatible = "fsl,imx7d-pcie-ep", .data = &drvdata[IMX7D_EP], },
>  	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
>  	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
>  	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
