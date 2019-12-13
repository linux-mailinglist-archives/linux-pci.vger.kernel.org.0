Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0C911E31D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 13:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfLMMCc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 07:02:32 -0500
Received: from foss.arm.com ([217.140.110.172]:56690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfLMMCc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 07:02:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30E1A30E;
        Fri, 13 Dec 2019 04:02:31 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B8623F718;
        Fri, 13 Dec 2019 04:02:30 -0800 (PST)
Date:   Fri, 13 Dec 2019 12:02:28 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 2/2] PCI: qcom: Add support for SDM845 PCIe controller
Message-ID: <20191213120227.GN24359@e119886-lin.cambridge.arm.com>
References: <20191107001642.1127561-1-bjorn.andersson@linaro.org>
 <20191107001642.1127561-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107001642.1127561-3-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 04:16:42PM -0800, Bjorn Andersson wrote:
> The SDM845 has one Gen2 and one Gen3 controller, add support for these.
> 
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Don't assert the reset in the failure path
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 150 +++++++++++++++++++++++++
>  1 file changed, 150 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 7e581748ee9f..5ea527a6bd9f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -54,6 +54,7 @@
>  #define PCIE20_PARF_LTSSM			0x1B0
>  #define PCIE20_PARF_SID_OFFSET			0x234
>  #define PCIE20_PARF_BDF_TRANSLATE_CFG		0x24C
> +#define PCIE20_PARF_DEVICE_TYPE			0x1000
>  
>  #define PCIE20_ELBI_SYS_CTRL			0x04
>  #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
> @@ -80,6 +81,8 @@
>  #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
>  #define SLV_ADDR_SPACE_SZ			0x10000000
>  
> +#define DEVICE_TYPE_RC				0x4
> +
>  #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
>  struct qcom_pcie_resources_2_1_0 {
>  	struct clk *iface_clk;
> @@ -139,12 +142,20 @@ struct qcom_pcie_resources_2_3_3 {
>  	struct reset_control *rst[7];
>  };
>  
> +struct qcom_pcie_resources_2_7_0 {
> +	struct clk_bulk_data clks[6];
> +	struct regulator_bulk_data supplies[2];
> +	struct reset_control *pci_reset;
> +	struct clk *pipe_clk;
> +};
> +
>  union qcom_pcie_resources {
>  	struct qcom_pcie_resources_1_0_0 v1_0_0;
>  	struct qcom_pcie_resources_2_1_0 v2_1_0;
>  	struct qcom_pcie_resources_2_3_2 v2_3_2;
>  	struct qcom_pcie_resources_2_3_3 v2_3_3;
>  	struct qcom_pcie_resources_2_4_0 v2_4_0;
> +	struct qcom_pcie_resources_2_7_0 v2_7_0;
>  };
>  
>  struct qcom_pcie;
> @@ -1068,6 +1079,134 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
>  	return ret;
>  }
>  
> +static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +	int ret;
> +
> +	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
> +	if (IS_ERR(res->pci_reset))
> +		return PTR_ERR(res->pci_reset);
> +
> +	res->supplies[0].supply = "vdda";
> +	res->supplies[1].supply = "vddpe-3v3";
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(res->supplies),
> +				      res->supplies);
> +	if (ret)
> +		return ret;
> +
> +	res->clks[0].id = "aux";
> +	res->clks[1].id = "cfg";
> +	res->clks[2].id = "bus_master";
> +	res->clks[3].id = "bus_slave";
> +	res->clks[4].id = "slave_q2a";
> +	res->clks[5].id = "tbu";
> +
> +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> +	if (ret < 0)
> +		return ret;
> +
> +	res->pipe_clk = devm_clk_get(dev, "pipe");
> +	return PTR_ERR_OR_ZERO(res->pipe_clk);

We tend to discourage people on the list from using PTR_ERR_OR_ZERO, however
this usage is consistent with the rest of the file - so let's leave it.

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> +}
> +
> +static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +	u32 val;
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
> +	if (ret < 0) {
> +		dev_err(dev, "cannot enable regulators\n");
> +		return ret;
> +	}
> +
> +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> +	if (ret < 0)
> +		goto err_disable_regulators;
> +
> +	ret = reset_control_assert(res->pci_reset);
> +	if (ret < 0) {
> +		dev_err(dev, "cannot deassert pci reset\n");
> +		goto err_disable_clocks;
> +	}
> +
> +	usleep_range(1000, 1500);
> +
> +	ret = reset_control_deassert(res->pci_reset);
> +	if (ret < 0) {
> +		dev_err(dev, "cannot deassert pci reset\n");
> +		goto err_disable_clocks;
> +	}
> +
> +	ret = clk_prepare_enable(res->pipe_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable pipe clock\n");
> +		goto err_disable_clocks;
> +	}
> +
> +	/* configure PCIe to RC mode */
> +	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
> +
> +	/* enable PCIe clocks and resets */
> +	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> +	val &= ~BIT(0);
> +	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +
> +	/* change DBI base address */
> +	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> +
> +	/* MAC PHY_POWERDOWN MUX DISABLE  */
> +	val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
> +	val &= ~BIT(29);
> +	writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
> +
> +	val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> +	val |= BIT(4);
> +	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> +		val |= BIT(31);
> +		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> +	}
> +
> +	return 0;
> +err_disable_clocks:
> +	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
> +err_disable_regulators:
> +	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> +
> +	return ret;
> +}
> +
> +static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +
> +	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
> +	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> +}
> +
> +static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +
> +	return clk_prepare_enable(res->pipe_clk);
> +}
> +
> +static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +
> +	clk_disable_unprepare(res->pipe_clk);
> +}
> +
>  static int qcom_pcie_link_up(struct dw_pcie *pci)
>  {
>  	u16 val = readw(pci->dbi_base + PCIE20_CAP + PCI_EXP_LNKSTA);
> @@ -1167,6 +1306,16 @@ static const struct qcom_pcie_ops ops_2_3_3 = {
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  };
>  
> +/* Qcom IP rev.: 2.7.0	Synopsys IP rev.: 4.30a */
> +static const struct qcom_pcie_ops ops_2_7_0 = {
> +	.get_resources = qcom_pcie_get_resources_2_7_0,
> +	.init = qcom_pcie_init_2_7_0,
> +	.deinit = qcom_pcie_deinit_2_7_0,
> +	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> +	.post_init = qcom_pcie_post_init_2_7_0,
> +	.post_deinit = qcom_pcie_post_deinit_2_7_0,
> +};
> +
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  };
> @@ -1282,6 +1431,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_2_3_3 },
>  	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
> +	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
>  	{ }
>  };
>  
> -- 
> 2.23.0
> 
