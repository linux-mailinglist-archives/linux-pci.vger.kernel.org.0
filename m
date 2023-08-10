Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886EB776EC7
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 05:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjHJDx0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 23:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHJDxZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 23:53:25 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C47FE5F
        for <linux-pci@vger.kernel.org>; Wed,  9 Aug 2023 20:53:24 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76cab6fe9c0so44586485a.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Aug 2023 20:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691639604; x=1692244404;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fO3snZ0j+ZerYThE6XXcjk368nRvCkMCzZgkN4oW5Sg=;
        b=Cn+TXqk26iOqHjHmgHF2M4tqX+T6/j8m5eaPQlcjyGLWXfFWVF5u7+7CADX6ijuL8s
         32ggVl/P6qwg6u2XPiYeKJfbwmf++B00FLnUx/2nKd1Pb3KxhpiZl1s993oL/pgZ4N35
         YvUuiyzzqR4fOpylbc5v+hE7O31eEwRUaPS27yfPUItP4/zJr1TQpdxnrwu80WZ9hx9D
         izPeS5sDOen+R6rTOBEZHz4aZ6043I9klndRHJi+xrFYwku73AIf7tFOm3QAUEe5e+PH
         FfY+/SJEdRQZiDNArtMiUfaaoUAzt7OOs8sFJet2mizf1i7xAuvtaU9F+Snf/KQlNZEV
         ifcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691639604; x=1692244404;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fO3snZ0j+ZerYThE6XXcjk368nRvCkMCzZgkN4oW5Sg=;
        b=Kj47K/JXywYLCifS1RGjLycwFUA416kKAhz9jHfrt7IEiJPqNdOQgQohtHbP2usGhN
         9YBOrq58pgL2GGfuinrJYPuJ3q4u0UcPPRDiDr44/dh5p8C3vnxHNGGv23IVbaLXKc72
         fZfDymmdnmusPSZ9hqwHPGanv+kEelrcDd9y2s0xpX4UskyCWI4H5Z52x7df7JAjL5ax
         vEi6b/3EL9357vpPUNmgLgDnNu9yeAANmpULkUUj+yZdIF9+E+aXcYmgEOYqBkj3B1OC
         qjmz2KGJqaAmQfH6ofeMeK/ZaFRomU2Lu8K9BTE550we2x6hv01v6lccFoCh20WUnHPv
         eF3w==
X-Gm-Message-State: AOJu0Yzj5X2RGLFfKiR0QkT2FK+JxQULtDoYSJLa1pPrtoJPMxH85MS6
        gR70TlagHQSVzFXF02Q9r64U
X-Google-Smtp-Source: AGHT+IE9i7rsJcbWS+SePYteL7ORhxk57VuJI7b1mvod/4YNXMo/lJCWGcUTjoHKjgbxh4xMu13IZg==
X-Received: by 2002:a05:620a:913:b0:76c:6f89:fea7 with SMTP id v19-20020a05620a091300b0076c6f89fea7mr1035742qkv.23.1691639603720;
        Wed, 09 Aug 2023 20:53:23 -0700 (PDT)
Received: from thinkpad ([117.193.214.179])
        by smtp.gmail.com with ESMTPSA id q24-20020a62e118000000b006873aa079aasm394319pfh.171.2023.08.09.20.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 20:53:23 -0700 (PDT)
Date:   Thu, 10 Aug 2023 09:23:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     frank.li@nxp.com, l.stach@pengutronix.de, shawnguo@kernel.org,
        lpieralisi@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v3 8/9] PCI: imx6: Add i.MX6SX PCIe EP support
Message-ID: <20230810035314.GB4860@thinkpad>
References: <1691472858-9383-1-git-send-email-hongxing.zhu@nxp.com>
 <1691472858-9383-9-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1691472858-9383-9-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 08, 2023 at 01:34:17PM +0800, Richard Zhu wrote:
> Add the i.MX6SX PCIe EP support.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 9a6531ddfef2..43c5251f5160 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -48,6 +48,7 @@ enum imx6_pcie_variants {
>  	IMX6Q,
>  	IMX6Q_EP,
>  	IMX6SX,
> +	IMX6SX_EP,
>  	IMX6QP,
>  	IMX6QP_EP,
>  	IMX7D,
> @@ -362,6 +363,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
>  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
>  		break;
>  	case IMX6SX:
> +	case IMX6SX_EP:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
>  				   IMX6SX_GPR12_PCIE_RX_EQ_2);
> @@ -560,6 +562,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX6SX:
> +	case IMX6SX_EP:
>  		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
>  		if (ret) {
>  			dev_err(dev, "unable to enable pcie_axi clock\n");
> @@ -621,6 +624,7 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
>  {
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX6SX:
> +	case IMX6SX_EP:
>  		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
>  		break;
>  	case IMX6QP:
> @@ -718,6 +722,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  		reset_control_assert(imx6_pcie->apps_reset);
>  		break;
>  	case IMX6SX:
> +	case IMX6SX_EP:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
>  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> @@ -782,6 +787,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
>  		break;
>  	case IMX6SX:
> +	case IMX6SX_EP:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
>  				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
>  		break;
> @@ -840,6 +846,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
>  	case IMX6Q:
>  	case IMX6Q_EP:
>  	case IMX6SX:
> +	case IMX6SX_EP:
>  	case IMX6QP:
>  	case IMX6QP_EP:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> @@ -866,6 +873,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
>  	case IMX6Q:
>  	case IMX6Q_EP:
>  	case IMX6SX:
> +	case IMX6SX_EP:
>  	case IMX6QP:
>  	case IMX6QP_EP:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> @@ -1198,6 +1206,7 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
>  	/* Others poke directly at IOMUXC registers */
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX6SX:
> +	case IMX6SX_EP:
>  	case IMX6QP:
>  	case IMX6QP_EP:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> @@ -1361,6 +1370,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX6SX:
> +	case IMX6SX_EP:
>  		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
>  							   "pcie_inbound_axi");
>  		if (IS_ERR(imx6_pcie->pcie_inbound_axi))
> @@ -1535,6 +1545,13 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>  	},
> +	[IMX6SX_EP] = {
> +		.variant = IMX6SX_EP,
> +		.mode = DW_PCIE_EP_TYPE,
> +		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
> +		.gpr = "fsl,imx6q-iomuxc-gpr",
> +		.epc_features = &imx6q_pcie_epc_features,
> +	},
>  	[IMX6QP] = {
>  		.variant = IMX6QP,
>  		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
> @@ -1590,6 +1607,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
>  	{ .compatible = "fsl,imx6q-pcie",  .data = &drvdata[IMX6Q],  },
>  	{ .compatible = "fsl,imx6q-pcie-ep", .data = &drvdata[IMX6Q_EP], },
>  	{ .compatible = "fsl,imx6sx-pcie", .data = &drvdata[IMX6SX], },
> +	{ .compatible = "fsl,imx6sx-pcie-ep", .data = &drvdata[IMX6SX_EP], },
>  	{ .compatible = "fsl,imx6qp-pcie", .data = &drvdata[IMX6QP], },
>  	{ .compatible = "fsl,imx6qp-pcie-ep", .data = &drvdata[IMX6QP_EP], },
>  	{ .compatible = "fsl,imx7d-pcie",  .data = &drvdata[IMX7D],  },
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
