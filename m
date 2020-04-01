Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A885219B724
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 22:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbgDAUkO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 16:40:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39899 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgDAUkO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Apr 2020 16:40:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id k18so449611pll.6
        for <linux-pci@vger.kernel.org>; Wed, 01 Apr 2020 13:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v9Vka5QMn/XO/UM8b8k78cglitDzsEXJjHSdkOZb/q0=;
        b=kfetSDeBgwtJwdcBDWNtAFEB3mWOU3uOo7ZKw/rliseEH8MwNWgyOQFwVOGViQW5v8
         cQHhp2H1rR/iXHTnfLCzbKHmDYZG8lNCe92U6VwwTpmM06W3YBuAGseTiVct062ZHYWE
         q1hcB4HUUPGtUuAew3XrPXlmPlqBtUuV396Afp4x7ipO/RvrtqF4cZE76xXSkWpbOoIk
         GyDnDOZP0ZEvvi9TqAcX9olTL4xpzHu8PxzONGGt6GIOQr7pHoQSXtDg2VdWlCi9MEFn
         qFRWFBBAfP9FHGey09SvI3AARj9VU1D8JtKpBwwW07d+N9wOFUy5uv0qm/D66QBWKfxG
         rBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v9Vka5QMn/XO/UM8b8k78cglitDzsEXJjHSdkOZb/q0=;
        b=CWlqXTOwdCf82guxVgXap40bfC0rn+k5cvGQlPSPYZhhF4sXk4NlK4aaZqWqKX06Fm
         +tKb8/55h/gclyFTcs3LSzQz/fmNZy7hlKjulCpvOjyk2/rBvx/J+TU5a0xNTkNyYFP4
         cm4e6sMu50IxkrMq7tPWSi03MXHG/CD/usGSNxlNn0L1I6gLicMyAAWiFW9uZGbfXngg
         KntJMwGng3UVGNdjaWNkM++FTZiYwrgL0DxMH/gOfKpEWTMCwF5cgWCQtCn3SkIBT2KR
         EuIX9iw9HPqfVAd195pxjSvzfNP8s6/MvAfPPfn+hJr8F+tPwFT6SmIaFKQvLEVF87/9
         k1ew==
X-Gm-Message-State: AGi0Pub904Dm2n2LEVrbtUqYl91ndTAfHLozbREPdQsJfIr97/ltF8+s
        pR+CRg0bHG6CeZ1jSZxhsAvZ4w==
X-Google-Smtp-Source: APiQypL1nBe7sE+Co1U36LDRm5wknOP+L/1oBikK/k8Bv88DatK1zXkG4ztAPqWBILluLhCQX4huMw==
X-Received: by 2002:a17:90a:21ac:: with SMTP id q41mr7152193pjc.41.1585773613353;
        Wed, 01 Apr 2020 13:40:13 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a185sm2265354pfa.27.2020.04.01.13.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 13:40:09 -0700 (PDT)
Date:   Wed, 1 Apr 2020 13:40:07 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Sham Muthayyan <smuthayy@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] pcie: qcom: add tx term offset support
Message-ID: <20200401204007.GG254911@minitux>
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
 <20200320183455.21311-7-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320183455.21311-7-ansuelsmth@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri 20 Mar 11:34 PDT 2020, Ansuel Smith wrote:

> From: Sham Muthayyan <smuthayy@codeaurora.org>
> 
> Add tx term offset support to pcie qcom driver
> need in some revision of the ipq806x soc
> 
> Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 61 ++++++++++++++++++++++----
>  1 file changed, 52 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ecc22fd27ea6..8009e3117765 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -45,7 +45,13 @@
>  #define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
>  
>  #define PCIE20_PARF_PHY_CTRL			0x40
> +#define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	(0x1f << 16)
> +#define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		(x << 16)
> +
>  #define PCIE20_PARF_PHY_REFCLK			0x4C
> +#define REF_SSP_EN				BIT(16)
> +#define REF_USE_PAD				BIT(12)
> +
>  #define PCIE20_PARF_DBI_BASE_ADDR		0x168
>  #define PCIE20_PARF_SLV_ADDR_SPACE_SIZE		0x16C
>  #define PCIE20_PARF_MHI_CLOCK_RESET_CTRL	0x174
> @@ -77,6 +83,18 @@
>  #define DBI_RO_WR_EN				1
>  
>  #define PERST_DELAY_US				1000
> +/* PARF registers */
> +#define PCIE20_PARF_PCS_DEEMPH			0x34
> +#define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		(x << 16)
> +#define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)	(x << 8)
> +#define PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(x)	(x << 0)
> +
> +#define PCIE20_PARF_PCS_SWING			0x38
> +#define PCS_SWING_TX_SWING_FULL(x)		(x << 8)
> +#define PCS_SWING_TX_SWING_LOW(x)		(x << 0)
> +
> +#define PCIE20_PARF_CONFIG_BITS			0x50
> +#define PHY_RX0_EQ(x)				(x << 24)
>  
>  #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
>  #define SLV_ADDR_SPACE_SZ			0x10000000
> @@ -97,6 +115,7 @@ struct qcom_pcie_resources_2_1_0 {
>  	struct reset_control *phy_reset;
>  	struct reset_control *ext_reset;
>  	struct regulator_bulk_data supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
> +	uint8_t phy_tx0_term_offset;
>  };
>  
>  struct qcom_pcie_resources_1_0_0 {
> @@ -184,6 +203,16 @@ struct qcom_pcie {
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
>  
> +static inline void
> +writel_masked(void __iomem *addr, u32 clear_mask, u32 set_mask)
> +{
> +	u32 val = readl(addr);
> +
> +	val &= ~clear_mask;
> +	val |= set_mask;
> +	writel(val, addr);
> +}
> +
>  static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
>  {
>  	gpiod_set_value_cansleep(pcie->reset, 1);
> @@ -277,6 +306,10 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
>  	if (IS_ERR(res->ext_reset))
>  		return PTR_ERR(res->ext_reset);
>  
> +	if (of_property_read_u8(dev->of_node, "phy-tx0-term-offset",
> +				&res->phy_tx0_term_offset))
> +		res->phy_tx0_term_offset = 0;

The appropriate way is to encode differences in hardware is to use
different compatibles for the two different versions of the hardware.

Regards,
Bjorn

> +
>  	res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
>  	return PTR_ERR_OR_ZERO(res->phy_reset);
>  }
> @@ -304,7 +337,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> -	u32 val;
>  	int ret;
>  
>  	ret = reset_control_assert(res->ahb_reset);
> @@ -355,15 +387,26 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
>  		goto err_deassert_ahb;
>  	}
>  
> -	/* enable PCIe clocks and resets */
> -	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> -	val &= ~BIT(0);
> -	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +	writel_masked(pcie->parf + PCIE20_PARF_PHY_CTRL, BIT(0), 0);
> +
> +	/* Set Tx termination offset */
> +	writel_masked(pcie->parf + PCIE20_PARF_PHY_CTRL,
> +		      PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK,
> +		      PHY_CTRL_PHY_TX0_TERM_OFFSET(res->phy_tx0_term_offset));
> +
> +	/* PARF programming */
> +	writel(PCS_DEEMPH_TX_DEEMPH_GEN1(0x18) |
> +	       PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(0x18) |
> +	       PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(0x22),
> +	       pcie->parf + PCIE20_PARF_PCS_DEEMPH);
> +	writel(PCS_SWING_TX_SWING_FULL(0x78) |
> +	       PCS_SWING_TX_SWING_LOW(0x78),
> +	       pcie->parf + PCIE20_PARF_PCS_SWING);
> +	writel(PHY_RX0_EQ(0x4), pcie->parf + PCIE20_PARF_CONFIG_BITS);
>  
> -	/* enable external reference clock */
> -	val = readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
> -	val |= BIT(16);
> -	writel(val, pcie->parf + PCIE20_PARF_PHY_REFCLK);
> +	/* Enable reference clock */
> +	writel_masked(pcie->parf + PCIE20_PARF_PHY_REFCLK,
> +		      REF_USE_PAD, REF_SSP_EN);
>  
>  	ret = reset_control_deassert(res->phy_reset);
>  	if (ret) {
> -- 
> 2.25.1
> 
