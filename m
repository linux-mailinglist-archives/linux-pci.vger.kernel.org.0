Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2559127F121
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 20:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgI3SNo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 14:13:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46052 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3SNo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 14:13:44 -0400
Received: by mail-ot1-f68.google.com with SMTP id g96so2724540otb.12;
        Wed, 30 Sep 2020 11:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i7Rz2d8gVR1T6SwhNwU6baK7Jm6glW6uyHVpoiXxGZs=;
        b=Pp1EK2uOAB8jLYdjHquSOBiwiTxHjhYe66DN7l5AvXE+tMHDtpMvWz7Bp3RBeVNDgR
         AUxQ6Md/lDHUc3vYdEvFvQqAN2+hIMvYBG9Zn9ZHnezIeZ9qOj81DK8+RMGk1kualYdp
         Js/RmLGASBOkpIgxD7AdPlG/0kdfVkb8hmg4sfcKYtYcfXUujp80f45QhM7L1VnkZuMp
         WftuwdtO6WYtUuiHWrgppqmzr1L0O1D0hVqbg0Vz0VaTaHewMRXHycjcBXn7qMi/qOOv
         mrTueShupNMriTfA//BGX3FKY6ifQFboMLs01W04mVXHiVy+F+IHtSHVsz2QgeVqgEMl
         Ymzg==
X-Gm-Message-State: AOAM530WKg0zDwXA7J0+Z5mJqDtebuJtia0jEYoiKpdSOFvuyIlzEfVf
        /sf6r+cB348epeFCRffMpg==
X-Google-Smtp-Source: ABdhPJxTngenbazL2rVxbL+GzbV909tMNuoJtVKpi3Ma+apKhgBvMf+3gOMo+UyfEnz/x4V/GY8L6g==
X-Received: by 2002:a9d:71ca:: with SMTP id z10mr2290167otj.307.1601489622994;
        Wed, 30 Sep 2020 11:13:42 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g3sm548147otp.14.2020.09.30.11.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 11:13:42 -0700 (PDT)
Received: (nullmailer pid 3163460 invoked by uid 1000);
        Wed, 30 Sep 2020 18:13:40 -0000
Date:   Wed, 30 Sep 2020 13:13:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        kishon@ti.com, vkoul@kernel.org, svarbanov@mm-sol.com,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        mgautam@codeaurora.org, smuthayy@codeaurora.org,
        varada@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 6/7] PCI: qcom: Add ipq8074 PCIe controller support
Message-ID: <20200930181340.GA3059567@bogus>
References: <1596036607-11877-1-git-send-email-sivaprak@codeaurora.org>
 <1596036607-11877-7-git-send-email-sivaprak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596036607-11877-7-git-send-email-sivaprak@codeaurora.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 29, 2020 at 09:00:06PM +0530, Sivaprakash Murugesan wrote:
> Add support for PCIe Gen3 port found in ipq8074 devices.
> 
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 177 ++++++++++++++++++++++++++++++++-
>  1 file changed, 176 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index e1b5651..3bddfcff 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -40,6 +40,14 @@
>  #define L23_CLK_RMV_DIS				BIT(2)
>  #define L1_CLK_RMV_DIS				BIT(1)
>  
> +#define PCIE_ATU_CR1_OUTBOUND_6_GEN3		0xC00
> +#define PCIE_ATU_CR2_OUTBOUND_6_GEN3		0xC04
> +#define PCIE_ATU_LIMIT_OUTBOUND_6_GEN3		0xC10
> +#define PCIE_ATU_CR1_OUTBOUND_7_GEN3		0xE00
> +#define PCIE_ATU_CR2_OUTBOUND_7_GEN3		0xE04
> +#define PCIE_ATU_LOWER_BASE_OUTBOUND_7_GEN3	0xE08
> +#define PCIE_ATU_LIMIT_OUTBOUND_7_GEN3		0xE10

Looks like standard DWC ATU registers.

> +
>  #define PCIE20_PARF_PHY_CTRL			0x40
>  #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
>  #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
> @@ -58,6 +66,13 @@
>  #define PCIE20_PARF_BDF_TRANSLATE_CFG		0x24C
>  #define PCIE20_PARF_DEVICE_TYPE			0x1000
>  
> +#define AHB_CLK_EN				BIT(0)
> +#define MSTR_AXI_CLK_EN				BIT(1)
> +#define BYPASS					BIT(4)
> +
> +#define PCIE20_PARF_BDF_TO_SID_TABLE		0x2000
> +#define BDF_TO_SID_TABLE_SIZE			0x100
> +
>  #define PCIE20_ELBI_SYS_CTRL			0x04
>  #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
>  
> @@ -68,11 +83,13 @@
>  #define CFG_BRIDGE_SB_INIT			BIT(0)
>  
>  #define PCIE20_CAP				0x70
> -#define PCIE20_DEVICE_CONTROL2_STATUS2		(PCIE20_CAP + PCI_EXP_DEVCTL2)
>  #define PCIE20_CAP_LINK_CAPABILITIES		(PCIE20_CAP + PCI_EXP_LNKCAP)
>  #define PCIE20_CAP_LINK_1			(PCIE20_CAP + 0x14)
>  #define PCIE_CAP_LINK1_VAL			0x2FD7F
>  
> +#define PCIE20_DEVICE_CONTROL2_STATUS2		(PCIE20_CAP + PCI_EXP_DEVCTL2)
> +#define PCIE_CAP_CPL_TIMEOUT_DISABLE           0x10

Gone now in Lorenzo's pci/dwc branch.

> +
>  #define PCIE20_PARF_Q2A_FLUSH			0x1AC
>  
>  #define PCIE20_MISC_CONTROL_1_REG		0x8BC
> @@ -96,9 +113,15 @@
>  #define SLV_ADDR_SPACE_SZ			0x10000000
>  
>  #define PCIE20_LNK_CONTROL2_LINK_STATUS2	0xa0
> +#define PCIE_CAP_CURR_DEEMPHASIS		BIT(16)
> +#define SPEED_GEN3				0x3
>  
>  #define DEVICE_TYPE_RC				0x4
>  
> +#define PCIE30_GEN3_RELATED_OFF			0x890
> +#define RXEQ_RGRDLESS_RXTS			BIT(13)
> +#define GEN3_ZRXDC_NONCOMPL			BIT(0)
> +
>  #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
>  #define QCOM_PCIE_2_1_0_MAX_CLOCKS	5
>  struct qcom_pcie_resources_2_1_0 {
> @@ -165,6 +188,11 @@ struct qcom_pcie_resources_2_7_0 {
>  	struct clk *pipe_clk;
>  };
>  
> +struct qcom_pcie_resources_2_9_0 {
> +	struct clk_bulk_data clks[7];
> +	struct reset_control *rst[8];
> +};
> +
>  union qcom_pcie_resources {
>  	struct qcom_pcie_resources_1_0_0 v1_0_0;
>  	struct qcom_pcie_resources_2_1_0 v2_1_0;
> @@ -172,6 +200,7 @@ union qcom_pcie_resources {
>  	struct qcom_pcie_resources_2_3_3 v2_3_3;
>  	struct qcom_pcie_resources_2_4_0 v2_4_0;
>  	struct qcom_pcie_resources_2_7_0 v2_7_0;
> +	struct qcom_pcie_resources_2_9_0 v2_9_0;
>  };
>  
>  struct qcom_pcie;
> @@ -1250,6 +1279,134 @@ static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
>  	clk_disable_unprepare(res->pipe_clk);
>  }
>  
> +static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +	int ret, i;
> +	const char *rst_names[] = { "pipe", "sleep", "sticky", "axi_m",
> +				    "axi_s", "ahb", "axi_m_sticky",
> +				    "axi_s_sticky" };
> +
> +	res->clks[0].id = "iface";
> +	res->clks[1].id = "axi_m";
> +	res->clks[2].id = "axi_s";
> +	res->clks[3].id = "ahb";
> +	res->clks[4].id = "aux";
> +	res->clks[5].id = "axi_bridge";
> +	res->clks[6].id = "rchng";
> +
> +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(rst_names); i++) {
> +		res->rst[i] = devm_reset_control_get(dev, rst_names[i]);
> +		if (IS_ERR(res->rst[i]))
> +			return PTR_ERR(res->rst[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +	int i, ret;
> +	u32 val;
> +	u32 bus_master_en = PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
> +
> +	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
> +		ret = reset_control_assert(res->rst[i]);
> +		if (ret) {
> +			dev_err(dev, "reset #%d assert failed (%d)\n", i, ret);
> +			return ret;
> +		}
> +	}
> +
> +	usleep_range(2000, 2500);
> +
> +	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
> +		ret = reset_control_deassert(res->rst[i]);
> +		if (ret) {
> +			dev_err(dev, "reset #%d deassert failed (%d)\n", i,
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	/*
> +	 * Don't have a way to see if the reset has completed.
> +	 * Wait for some time.
> +	 */
> +	usleep_range(2000, 2500);
> +
> +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> +	if (ret)
> +		return ret;
> +
> +	/* Parf config */
> +	writel(SLV_ADDR_SPACE_SZ,
> +	       pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);

relaxed variants should work here, right?

> +
> +	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> +	val &= ~BIT(0);

A define for bit 0 needed.

> +	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +
> +	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> +	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
> +	writel(BYPASS | MSTR_AXI_CLK_EN | AHB_CLK_EN,
> +	       pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> +
> +	writel(RXEQ_RGRDLESS_RXTS | GEN3_ZRXDC_NONCOMPL,
> +	       pci->dbi_base + PCIE30_GEN3_RELATED_OFF);
> +	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
> +		| SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
> +		AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
> +		pcie->parf + PCIE20_PARF_SYS_CTRL);
> +	writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
> +
> +	/* DBI config */
> +	writel(bus_master_en, pci->dbi_base + PCI_COMMAND);

The core does this.

> +	writel(DBI_RO_WR_EN, pci->dbi_base + PCIE20_MISC_CONTROL_1_REG);
> +	writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + PCIE20_CAP_LINK_1);
> +
> +	/* Configure PCIe link capabilities for ASPM */
> +	val = readl(pci->dbi_base + PCIE20_CAP_LINK_CAPABILITIES);
> +	val &= ~PCI_EXP_LNKCAP_ASPMS;
> +	writel(val, pci->dbi_base + PCIE20_CAP_LINK_CAPABILITIES);
> +
> +	writel(PCIE_CAP_CPL_TIMEOUT_DISABLE, pci->dbi_base +
> +		PCIE20_DEVICE_CONTROL2_STATUS2);
> +
> +	writel(PCIE_CAP_CURR_DEEMPHASIS | SPEED_GEN3,
> +	       pci->dbi_base + PCIE20_LNK_CONTROL2_LINK_STATUS2);
> +
> +	for (i = 0 ; i < BDF_TO_SID_TABLE_SIZE ; i++)
> +		writel(0x0, pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE + (4 * i));
> +
> +	writel(0x4, pci->atu_base + PCIE_ATU_CR1_OUTBOUND_6_GEN3);
> +	writel(0x90000000, pci->atu_base + PCIE_ATU_CR2_OUTBOUND_6_GEN3);
> +	writel(0x00107FFFF, pci->atu_base + PCIE_ATU_LIMIT_OUTBOUND_6_GEN3);
> +	writel(0x5, pci->atu_base + PCIE_ATU_CR1_OUTBOUND_7_GEN3);
> +	writel(0x90000000, pci->atu_base + PCIE_ATU_CR2_OUTBOUND_7_GEN3);
> +	writel(0x200000, pci->atu_base + PCIE_ATU_LOWER_BASE_OUTBOUND_7_GEN3);
> +	writel(0x7FFFFF, pci->atu_base + PCIE_ATU_LIMIT_OUTBOUND_7_GEN3);

No, this should all come from 'ranges'.

> +
> +	return 0;
> +}
> +
> +static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> +
> +	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
> +}
> +
>  static int qcom_pcie_link_up(struct dw_pcie *pci)
>  {
>  	u16 val = readw(pci->dbi_base + PCIE20_CAP + PCI_EXP_LNKSTA);
> @@ -1359,6 +1516,14 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
>  	.post_deinit = qcom_pcie_post_deinit_2_7_0,
>  };
>  
> +/* Qcom IP rev.: 2.9.0	Synopsys IP rev.: 5.00a */
> +static const struct qcom_pcie_ops ops_2_9_0 = {
> +	.get_resources = qcom_pcie_get_resources_2_9_0,
> +	.init = qcom_pcie_init_2_9_0,
> +	.deinit = qcom_pcie_deinit_2_9_0,
> +	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> +};
> +
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  };
> @@ -1399,6 +1564,15 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_pm_runtime_put;
>  	}
>  
> +	if (pcie->ops == &ops_2_9_0) {
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");

There's a patch in flight to do this in the DWC common code.

> +		pci->atu_base = devm_pci_remap_cfg_resource(dev, res);
> +		if (IS_ERR(pci->atu_base)) {
> +			ret = PTR_ERR(pci->atu_base);
> +			goto err_pm_runtime_put;
> +		}
> +	}
> +
>  	pcie->gen = of_pci_get_max_link_speed(pdev->dev.of_node);
>  	if (pcie->gen < 0)
>  		pcie->gen = 2;
> @@ -1476,6 +1650,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
>  	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
> +	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &ops_2_9_0 },

Is there a non gen3 PCIe host in ipq8074?

Rob
