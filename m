Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C45756ABFB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 21:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbiGGTls (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 15:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiGGTlr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 15:41:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A994D14F;
        Thu,  7 Jul 2022 12:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B449B823D4;
        Thu,  7 Jul 2022 19:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BE2C3411E;
        Thu,  7 Jul 2022 19:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657222903;
        bh=Xhs0d0x98JP2BUHK1bC1nzzACGGqy94P++Xtefpe9vA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=buehOgBgvddwYJl7FNey1gi1uvnfqZtEh1ynsvyWZxYXtFRqxljyM25P/sD2xAAMa
         /RJ4QeOSkWgUQcmjTbhOMtezQnOPXESyWJ3ys4c+DPaN4qwGP94ogKybbATcyZd19I
         zU3Kb+Jcg5lbnaDmyCWT/per809TRGjEITau89IBQu1nlcs1ibLKDj/oCG7DaT1UqH
         OTUERrlXpbW++V/GADIjjQxXdNBa+xkn8gYve0Xa997iMTWMvgVwR/BrKrJGFPP5em
         nUiES9ZqlrdpE6PVfstse0axgQQE9s9kqdBnvOWi+6SplcR2B2TrljNI3ZZ4iDEH11
         IYyU2Pr58HrOQ==
Date:   Thu, 7 Jul 2022 14:41:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     svarbanov@mm-sol.com, agross@kernel.org,
        bjorn.andersson@linaro.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v4 2/2] PCI: qcom: Move all DBI register accesses after
 phy_power_on()
Message-ID: <20220707194139.GA328930@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624104420.257368-2-robimarko@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 12:44:20PM +0200, Robert Marko wrote:
> IPQ8074 requires the PHY to be powered on before accessing DBI registers.
> It's not clear whether other variants have the same dependency, but there
> seems to be no reason for them to be different, so move all the DBI
> accesses from .init() to .post_init() so they are all after phy_power_on().
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Would any of the qcom driver folks care to review and ack this?
Stanimir, Andy, Bjorn A (from get_maintainer.pl)?

> ---
> Changes in v4:
> * Move 2.7.0 accesses as well
> * Correct title and description (Bjorn)
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 215 ++++++++++++++-----------
>  1 file changed, 119 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 24708d5d817d..f1a156052fe7 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -348,8 +348,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> -	struct device_node *node = dev->of_node;
> -	u32 val;
>  	int ret;
>  
>  	/* reset the PCIe interface as uboot can leave it undefined state */
> @@ -360,8 +358,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
>  	reset_control_assert(res->ext_reset);
>  	reset_control_assert(res->phy_reset);
>  
> -	writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> -
>  	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
>  	if (ret < 0) {
>  		dev_err(dev, "cannot enable regulators\n");
> @@ -408,6 +404,35 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
>  	if (ret)
>  		goto err_clks;
>  
> +	return 0;
> +
> +err_clks:
> +	reset_control_assert(res->axi_reset);
> +err_deassert_axi:
> +	reset_control_assert(res->por_reset);
> +err_deassert_por:
> +	reset_control_assert(res->pci_reset);
> +err_deassert_pci:
> +	reset_control_assert(res->phy_reset);
> +err_deassert_phy:
> +	reset_control_assert(res->ext_reset);
> +err_deassert_ext:
> +	reset_control_assert(res->ahb_reset);
> +err_deassert_ahb:
> +	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> +
> +	return ret;
> +}
> +
> +static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +	struct device_node *node = dev->of_node;
> +	u32 val;
> +
> +	writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +
>  	/* enable PCIe clocks and resets */
>  	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
>  	val &= ~BIT(0);
> @@ -451,23 +476,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
>  	       pci->dbi_base + PCIE20_AXI_MSTR_RESP_COMP_CTRL1);
>  
>  	return 0;
> -
> -err_clks:
> -	reset_control_assert(res->axi_reset);
> -err_deassert_axi:
> -	reset_control_assert(res->por_reset);
> -err_deassert_por:
> -	reset_control_assert(res->pci_reset);
> -err_deassert_pci:
> -	reset_control_assert(res->phy_reset);
> -err_deassert_phy:
> -	reset_control_assert(res->ext_reset);
> -err_deassert_ext:
> -	reset_control_assert(res->ahb_reset);
> -err_deassert_ahb:
> -	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> -
> -	return ret;
>  }
>  
>  static int qcom_pcie_get_resources_1_0_0(struct qcom_pcie *pcie)
> @@ -555,16 +563,6 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
>  		goto err_slave;
>  	}
>  
> -	/* change DBI base address */
> -	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> -
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		u32 val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> -
> -		val |= BIT(31);
> -		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> -	}
> -
>  	return 0;
>  err_slave:
>  	clk_disable_unprepare(res->slave_bus);
> @@ -580,6 +578,22 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
>  	return ret;
>  }
>  
> +static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
> +{
> +
> +	/* change DBI base address */
> +	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		u32 val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> +
> +		val |= BIT(31);
> +		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> +	}
> +
> +	return 0;
> +}
> +
>  static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
>  {
>  	u32 val;
> @@ -648,7 +662,6 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> -	u32 val;
>  	int ret;
>  
>  	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
> @@ -681,27 +694,6 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
>  		goto err_slave_clk;
>  	}
>  
> -	/* enable PCIe clocks and resets */
> -	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> -	val &= ~BIT(0);
> -	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> -
> -	/* change DBI base address */
> -	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> -
> -	/* MAC PHY_POWERDOWN MUX DISABLE  */
> -	val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
> -	val &= ~BIT(29);
> -	writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
> -
> -	val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> -	val |= BIT(4);
> -	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> -
> -	val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> -	val |= BIT(31);
> -	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> -
>  	return 0;
>  
>  err_slave_clk:
> @@ -722,8 +714,30 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> +	u32 val;
>  	int ret;
>  
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
> +	val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> +	val |= BIT(31);
> +	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> +
>  	ret = clk_prepare_enable(res->pipe_clk);
>  	if (ret) {
>  		dev_err(dev, "cannot prepare/enable pipe clock\n");
> @@ -837,7 +851,6 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> -	u32 val;
>  	int ret;
>  
>  	ret = reset_control_assert(res->axi_m_reset);
> @@ -962,6 +975,33 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
>  	if (ret)
>  		goto err_clks;
>  
> +	return 0;
> +
> +err_clks:
> +	reset_control_assert(res->ahb_reset);
> +err_rst_ahb:
> +	reset_control_assert(res->pwr_reset);
> +err_rst_pwr:
> +	reset_control_assert(res->axi_s_reset);
> +err_rst_axi_s:
> +	reset_control_assert(res->axi_m_sticky_reset);
> +err_rst_axi_m_sticky:
> +	reset_control_assert(res->axi_m_reset);
> +err_rst_axi_m:
> +	reset_control_assert(res->pipe_sticky_reset);
> +err_rst_pipe_sticky:
> +	reset_control_assert(res->pipe_reset);
> +err_rst_pipe:
> +	reset_control_assert(res->phy_reset);
> +err_rst_phy:
> +	reset_control_assert(res->phy_ahb_reset);
> +	return ret;
> +}
> +
> +static int qcom_pcie_post_init_2_4_0(struct qcom_pcie *pcie)
> +{
> +	u32 val;
> +
>  	/* enable PCIe clocks and resets */
>  	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
>  	val &= ~BIT(0);
> @@ -984,26 +1024,6 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
>  	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
>  
>  	return 0;
> -
> -err_clks:
> -	reset_control_assert(res->ahb_reset);
> -err_rst_ahb:
> -	reset_control_assert(res->pwr_reset);
> -err_rst_pwr:
> -	reset_control_assert(res->axi_s_reset);
> -err_rst_axi_s:
> -	reset_control_assert(res->axi_m_sticky_reset);
> -err_rst_axi_m_sticky:
> -	reset_control_assert(res->axi_m_reset);
> -err_rst_axi_m:
> -	reset_control_assert(res->pipe_sticky_reset);
> -err_rst_pipe_sticky:
> -	reset_control_assert(res->pipe_reset);
> -err_rst_pipe:
> -	reset_control_assert(res->phy_reset);
> -err_rst_phy:
> -	reset_control_assert(res->phy_ahb_reset);
> -	return ret;
>  }
>  
>  static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
> @@ -1237,7 +1257,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> -	u32 val;
>  	int ret;
>  
>  	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
> @@ -1271,6 +1290,28 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	/* Wait for reset to complete, required on SM8450 */
>  	usleep_range(1000, 1500);
>  
> +	return 0;
> +err_disable_clocks:
> +	clk_bulk_disable_unprepare(res->num_clks, res->clks);
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
> +	clk_bulk_disable_unprepare(res->num_clks, res->clks);
> +	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> +}
> +
> +static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +	u32 val;
> +
>  	/* configure PCIe to RC mode */
>  	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
>  
> @@ -1297,27 +1338,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
>  	}
>  
> -	return 0;
> -err_disable_clocks:
> -	clk_bulk_disable_unprepare(res->num_clks, res->clks);
> -err_disable_regulators:
> -	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> -
> -	return ret;
> -}
> -
> -static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
> -{
> -	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> -
> -	clk_bulk_disable_unprepare(res->num_clks, res->clks);
> -	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> -}
> -
> -static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
> -{
> -	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> -
>  	/* Set pipe clock as clock source for pcie_pipe_clk_src */
>  	if (pcie->cfg->pipe_clk_need_muxing)
>  		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
> @@ -1569,6 +1589,7 @@ static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
>  static const struct qcom_pcie_ops ops_2_1_0 = {
>  	.get_resources = qcom_pcie_get_resources_2_1_0,
>  	.init = qcom_pcie_init_2_1_0,
> +	.post_init = qcom_pcie_post_init_2_1_0,
>  	.deinit = qcom_pcie_deinit_2_1_0,
>  	.ltssm_enable = qcom_pcie_2_1_0_ltssm_enable,
>  };
> @@ -1577,6 +1598,7 @@ static const struct qcom_pcie_ops ops_2_1_0 = {
>  static const struct qcom_pcie_ops ops_1_0_0 = {
>  	.get_resources = qcom_pcie_get_resources_1_0_0,
>  	.init = qcom_pcie_init_1_0_0,
> +	.post_init = qcom_pcie_post_init_1_0_0,
>  	.deinit = qcom_pcie_deinit_1_0_0,
>  	.ltssm_enable = qcom_pcie_2_1_0_ltssm_enable,
>  };
> @@ -1595,6 +1617,7 @@ static const struct qcom_pcie_ops ops_2_3_2 = {
>  static const struct qcom_pcie_ops ops_2_4_0 = {
>  	.get_resources = qcom_pcie_get_resources_2_4_0,
>  	.init = qcom_pcie_init_2_4_0,
> +	.post_init = qcom_pcie_post_init_2_4_0,
>  	.deinit = qcom_pcie_deinit_2_4_0,
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  };
> -- 
> 2.36.1
> 
