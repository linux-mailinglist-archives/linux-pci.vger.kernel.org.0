Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CA654CF07
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 18:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346327AbiFOQsy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 12:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiFOQsx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 12:48:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEB435A87;
        Wed, 15 Jun 2022 09:48:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A44861993;
        Wed, 15 Jun 2022 16:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FB7C3411C;
        Wed, 15 Jun 2022 16:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655311730;
        bh=tfjNFMPCs10Bny/GBV+7WSJMt7Iv5feJl3eEVXBaZtY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YXRrLmmEwSB+kNYMq/S/2EeQQHF4xW3tICr4Mnj3w30HYP9yRmJbMRTEswUz5fbGl
         LN9jWOx79c7bQCjPXCVeZG80aqQ1EmWR+iY2O5vfHmtQOR64oPJt9b0Q1JP5CoxHfw
         n5/DLJIhT/iXuQHDg4utIUkLQkUZTk01TNS9spUC1K56OHa44ROb5nVq+DBgIROgXw
         Y0nTwuIaY/NeHpV+3w+VmnoYJH9nbhLHKPZlyVLB+tHQ9jMEL5J9F+iyCpmL77TUDa
         VVLOFmlII/SAOzKa1t5kvwC4oYK3fIsJyRLoC+CsL+JqUadzg/xydew/e8SwFaQBdu
         q/Kr7HV20CDsg==
Date:   Wed, 15 Jun 2022 11:48:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/17] PCI: dwc: Add Baikal-T1 PCIe controller support
Message-ID: <20220615164848.GA941930@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610085706.15741-18-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 10, 2022 at 11:57:05AM +0300, Serge Semin wrote:
> Baikal-T1 SoC is equipped with DWC PCIe v4.60a host controller. It can be
> trained to work up to Gen.3 speed over up to x4 lanes. The host controller
> is attached to the DW PCIe 3.0 PCS via the PIPE-4 interface, which in its
> turn is connected to the DWC 10G PHY. The whole system is supposed to be
> fed up with four clock sources: DBI peripheral clock, AXI application
> clocks and external PHY/core reference clock generating the 100MHz signal.
> In addition to that the platform provide a way to reset each part of the
> controller: sticky/non-sticky bits, host controller core, PIPE interface,
> PCS/PHY and Hot/Power reset signal. The driver also provides a way to
> handle the GPIO-based PERST# signal.
> 
> Note due to the Baikal-T1 MMIO peculiarity we have to implement the DBI
> interface accessors which make sure the IO operations are dword-aligned.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

> +static int bt1_pcie_start_ltssm(struct dw_pcie *pci)
> +{
> +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> +	u32 val;
> +	int ret;
> +
> +	/*
> +	 * Enable LTSSM and make sure it was able to establish both PHY and
> +	 * data links. This procedure shall work fine to reach 2.5 GT/s speed.
> +	 */
> +	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
> +			   BT1_CCU_PCIE_LTSSM_EN, BT1_CCU_PCIE_LTSSM_EN);
> +
> +	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_PMSC, val,
> +				       (val & BT1_CCU_PCIE_SMLH_LINKUP),
> +				       1000, 1000000);
> +	if (ret) {
> +		dev_err(pci->dev, "LTSSM failed to set PHY link up\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_PMSC, val,
> +				       (val & BT1_CCU_PCIE_RDLH_LINKUP),
> +				       1000, 1000000);
> +	if (ret) {
> +		dev_err(pci->dev, "LTSSM failed to set data link up\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Activate direct speed change after the link is established in an
> +	 * attempt to reach a higher bus performance (up to Gen.3 - 8.0 GT/s).
> +	 * This is required at least to get 8.0 GT/s speed.
> +	 */
> +	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> +	val |= PORT_LOGIC_SPEED_CHANGE;
> +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> +
> +	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_PMSC, val,
> +				       BT1_CCU_PCIE_LTSSM_LINKUP(val),
> +				       1000, 1000000);
> +	if (ret)
> +		dev_err(pci->dev, "LTSSM failed to get into L0 state\n");
> +
> +	return ret;
> +}
> +
> +static void bt1_pcie_stop_ltssm(struct dw_pcie *pci)
> +{
> +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> +
> +	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
> +			   BT1_CCU_PCIE_LTSSM_EN, 0);
> +}
> +
> +struct dw_pcie_ops bt1_pcie_dw_ops = {
> +	.read_dbi = bt1_pcie_read_dbi,
> +	.write_dbi = bt1_pcie_write_dbi,
> +	.write_dbi2 = bt1_pcie_write_dbi2,
> +	.start_link = bt1_pcie_start_ltssm,
> +	.stop_link = bt1_pcie_stop_ltssm,
> +};

Should be static and const.  Please rename to "dw_pcie_ops" as most
drivers use.  Please rename bt1_pcie_start_ltssm() and
bt1_pcie_stop_ltssm() to bt1_pcie_start_link() and
bt1_pcie_stop_link() for consistency with other drivers to make
maintenance easier.

> +static struct pci_ops bt1_pcie_ops = {
> +	.map_bus = dw_pcie_own_conf_map_bus,
> +	.read = pci_generic_config_read32,
> +	.write = pci_generic_config_write32,
> +};
> +
> +static int bt1_pcie_get_res(struct bt1_pcie *btpci)

Can you name this something similar to what other drivers use?  There
are a couple *_pcie_get_resources() functions (normally called from
*_pcie_probe()), but no *_get_res() yet.

> +{
> +	struct device *dev = btpci->dw.dev;
> +	int i, ret;
> +
> +	/* DBI access is supposed to be performed by the dword-aligned IOs */
> +	btpci->dw.pp.bridge->ops = &bt1_pcie_ops;
> +
> +	/* AXI-interface is configured with 64-bit address bus width */
> +	ret = dma_coerce_mask_and_coherent(&btpci->dw.pp.bridge->dev,
> +					   DMA_BIT_MASK(64));

Just to double-check since this is the first instance of
dma_coerce_mask_and_coherent() in drivers/pci -- I guess Baikal-T1 is
unique in needing this?

> +	if (ret) {
> +		ret = dma_set_mask_and_coherent(&btpci->dw.pp.bridge->dev,
> +						DMA_BIT_MASK(32));

Also the first instance of dma_set_mask_and_coherent() in dwc-based
drivers, so double-checking here, too.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* These CSRs are in MMIO so we won't check the regmap-methods status */
> +	btpci->sys_regs =
> +		syscon_regmap_lookup_by_phandle(dev->of_node, "baikal,bt1-syscon");
> +	if (IS_ERR(btpci->sys_regs))
> +		return dev_err_probe(dev, PTR_ERR(btpci->sys_regs),
> +				     "Failed to get syscon\n");
> +
> +	/* Make sure all the required resources have been specified */
> +	for (i = 0; i < BT1_PCIE_NUM_APP_CLKS; i++) {
> +		if (!btpci->dw.app_clks[bt1_pcie_app_clks[i]].clk) {
> +			dev_err(dev, "App clocks set is incomplete\n");
> +			return -ENOENT;
> +		}
> +	}
> +
> +	for (i = 0; i < BT1_PCIE_NUM_CORE_CLKS; i++) {
> +		if (!btpci->dw.core_clks[bt1_pcie_core_clks[i]].clk) {
> +			dev_err(dev, "Core clocks set is incomplete\n");
> +			return -ENOENT;
> +		}
> +	}
> +
> +	for (i = 0; i < BT1_PCIE_NUM_APP_RSTS; i++) {
> +		if (!btpci->dw.app_rsts[bt1_pcie_app_rsts[i]].rstc) {
> +			dev_err(dev, "App resets set is incomplete\n");
> +			return -ENOENT;
> +		}
> +	}
> +
> +	for (i = 0; i < BT1_PCIE_NUM_CORE_RSTS; i++) {
> +		if (!btpci->dw.core_rsts[bt1_pcie_core_rsts[i]].rstc) {
> +			dev_err(dev, "Core resets set is incomplete\n");
> +			return -ENOENT;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void bt1_pcie_full_stop_bus(struct bt1_pcie *btpci, bool init)

Can you name this something similar to what other drivers use?

> +{
> +	struct device *dev = btpci->dw.dev;
> +	struct dw_pcie *pci = &btpci->dw;
> +	int ret;
> +
> +	/* Disable LTSSM for sure */
> +	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
> +			   BT1_CCU_PCIE_LTSSM_EN, 0);
> +
> +	/*
> +	 * Application reset controls are trigger-based so de-assert the core
> +	 * resets only.
> +	 */
> +	ret = reset_control_bulk_assert(DW_PCIE_NUM_CORE_RSTS, pci->core_rsts);
> +	if (ret)
> +		dev_err(dev, "Failed to assert core resets\n");
> +
> +	/*
> +	 * Clocks are disabled by default at least in accordance with the clk
> +	 * enable counter value on init stage.
> +	 */
> +	if (!init) {
> +		clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, pci->core_clks);
> +
> +		clk_bulk_disable_unprepare(DW_PCIE_NUM_APP_CLKS, pci->app_clks);
> +	}
> +
> +	/* The peripheral devices are unavailable anyway so reset them too */
> +	gpiod_set_value_cansleep(pci->pe_rst, 1);
> +
> +	/* Make sure the reset is settled */
> +	usleep_range(1, 10);

Is this duration related to something in the PCIe spec?  Or the DWC
spec?  I'd really like to use named constants when possible, although
we have a ton of bare magic numbers currently.

Similar for the poll timeouts and the "state settled" sleep below.

> +}
> +
> +/*
> + * Implements the cold reset procedure in accordance with the reference manual
> + * and available PM signals.
> + */
> +static int bt1_pcie_cold_start_bus(struct bt1_pcie *btpci)
> +{
> +	struct device *dev = btpci->dw.dev;
> +	struct dw_pcie *pci = &btpci->dw;
> +	u32 val;
> +	int ret;
> +
> +	/* First get out of the Power/Hot reset state */
> +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_PWR_RST].rstc);
> +	if (ret) {
> +		dev_err(dev, "Failed to deassert PHY reset\n");
> +		return ret;
> +	}
> +
> +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_HOT_RST].rstc);
> +	if (ret) {
> +		dev_err(dev, "Failed to deassert hot reset\n");
> +		goto err_assert_pwr_rst;
> +	}
> +
> +	/* Wait for the PM-core to stop requesting the PHY reset */
> +	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_RSTC, val,
> +				       !(val & BT1_CCU_PCIE_REQ_PHY_RST), 1, 1000);
> +	if (ret) {
> +		dev_err(dev, "Timed out waiting for PM to stop PHY resetting\n");
> +		goto err_assert_hot_rst;
> +	}
> +
> +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_PHY_RST].rstc);
> +	if (ret) {
> +		dev_err(dev, "Failed to deassert PHY reset\n");
> +		goto err_assert_hot_rst;
> +	}
> +
> +	/* Clocks can be now enabled, but the ref one is crucial at this stage */
> +	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_APP_CLKS, pci->app_clks);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable app clocks\n");
> +		goto err_assert_phy_rst;
> +	}
> +
> +	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, pci->core_clks);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable ref clocks\n");
> +		goto err_disable_app_clk;
> +	}
> +
> +	/* Wait for the PM to stop requesting the controller core reset */
> +	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_RSTC, val,
> +				       !(val & BT1_CCU_PCIE_REQ_CORE_RST), 1, 1000);
> +	if (ret) {
> +		dev_err(dev, "Timed out waiting for PM to stop core resetting\n");
> +		goto err_disable_core_clk;
> +	}
> +
> +	/* PCS-PIPE interface and controller core can be now activated */
> +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_PIPE_RST].rstc);
> +	if (ret) {
> +		dev_err(dev, "Failed to deassert PIPE reset\n");
> +		goto err_disable_core_clk;
> +	}
> +
> +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_CORE_RST].rstc);
> +	if (ret) {
> +		dev_err(dev, "Failed to deassert core reset\n");
> +		goto err_assert_pipe_rst;
> +	}
> +
> +	/* It's recommended to reset the core and application logic together */
> +	ret = reset_control_bulk_reset(DW_PCIE_NUM_APP_RSTS, pci->app_rsts);
> +	if (ret) {
> +		dev_err(dev, "Failed to reset app domain\n");
> +		goto err_assert_core_rst;
> +	}
> +
> +	/* Sticky/Non-sticky CSR flags can be now unreset too */
> +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_STICKY_RST].rstc);
> +	if (ret) {
> +		dev_err(dev, "Failed to deassert sticky reset\n");
> +		goto err_assert_core_rst;
> +	}
> +
> +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_NON_STICKY_RST].rstc);
> +	if (ret) {
> +		dev_err(dev, "Failed to deassert non-sticky reset\n");
> +		goto err_assert_sticky_rst;
> +	}
> +
> +	/* Activate the PCIe bus peripheral devices */
> +	gpiod_set_value_cansleep(pci->pe_rst, 0);
> +
> +	/* Make sure the state is settled (LTSSM is still disabled though) */
> +	usleep_range(1, 10);
> +
> +	return 0;
> +
> +err_assert_sticky_rst:
> +	reset_control_assert(pci->core_rsts[DW_PCIE_STICKY_RST].rstc);
> +
> +err_assert_core_rst:
> +	reset_control_assert(pci->core_rsts[DW_PCIE_CORE_RST].rstc);
> +
> +err_assert_pipe_rst:
> +	reset_control_assert(pci->core_rsts[DW_PCIE_PIPE_RST].rstc);
> +
> +err_disable_core_clk:
> +	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, pci->core_clks);
> +
> +err_disable_app_clk:
> +	clk_bulk_disable_unprepare(DW_PCIE_NUM_APP_CLKS, pci->app_clks);
> +
> +err_assert_phy_rst:
> +	reset_control_assert(pci->core_rsts[DW_PCIE_PHY_RST].rstc);
> +
> +err_assert_hot_rst:
> +	reset_control_assert(pci->core_rsts[DW_PCIE_HOT_RST].rstc);
> +
> +err_assert_pwr_rst:
> +	reset_control_assert(pci->core_rsts[DW_PCIE_PWR_RST].rstc);
> +
> +	return ret;
> +}
> +
> +static int bt1_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> +	int ret;
> +
> +	ret = bt1_pcie_get_res(btpci);
> +	if (ret)
> +		return ret;
> +
> +	bt1_pcie_full_stop_bus(btpci, true);
> +
> +	return bt1_pcie_cold_start_bus(btpci);

Generally I think the get_res-type stuff happens elsewhere.  I'm not
an expert in that, but this doesn't look much like other
*_pcie_host_init() functions, which mainly deal with enabling clocks,
reset assertion/deassertion, PHY init, interrupt enable, etc.

Maybe this is connected with your new common clocks/resets properties.
I'm certainly in favor of making as much of that common as is
practical!  I hope we can take advantage of that and make more
consistency across the dwc-based drivers as well.

> +}
> +
> +static void bt1_pcie_host_deinit(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> +
> +	bt1_pcie_full_stop_bus(btpci, false);
> +}
> +
> +struct dw_pcie_host_ops bt1_pcie_host_ops = {
> +	.host_init = bt1_pcie_host_init,
> +	.host_deinit = bt1_pcie_host_deinit,
> +};
> +
> +static struct bt1_pcie *bt1_pcie_create_data(struct platform_device *pdev)
> +{
> +	struct bt1_pcie *btpci;
> +
> +	btpci = devm_kzalloc(&pdev->dev, sizeof(*btpci), GFP_KERNEL);
> +	if (!btpci)
> +		return ERR_PTR(-ENOMEM);
> +
> +	btpci->pdev = pdev;
> +
> +	platform_set_drvdata(pdev, btpci);
> +
> +	return btpci;

I don't think it's worth splitting this into a separate function.  I
think it would be better to use the same structure as other dwc-based
drivers and keep this in bt1_pcie_probe().

> +}
> +
> +static int bt1_pcie_add_dw_port(struct bt1_pcie *btpci)

All other dwc-based drivers call dw_pcie_host_init() from either
*_pcie_probe() or *_add_pcie_port().  Please use a similar convention.

> +{
> +	struct device *dev = &btpci->pdev->dev;
> +	int ret;
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));

Why do you need this when no other dwc-based drivers do?  Is Baikal-T1
different in this respect?

> +	if (ret)
> +		return ret;
> +
> +	btpci->dw.version = DW_PCIE_VER_460A;
> +	btpci->dw.dev = dev;
> +	btpci->dw.ops = &bt1_pcie_dw_ops;
> +
> +	btpci->dw.pp.num_vectors = MAX_MSI_IRQS;
> +	btpci->dw.pp.ops = &bt1_pcie_host_ops;
> +
> +	dw_pcie_cap_set(&btpci->dw, REQ_RES);
> +
> +	ret = dw_pcie_host_init(&btpci->dw.pp);
> +	if (ret)
> +		dev_err_probe(dev, ret, "Failed to initialize DWC PCIe host\n");
> +
> +	return ret;
> +}
> +
> +static void bt1_pcie_del_dw_port(struct bt1_pcie *btpci)

Can you call dw_pcie_host_deinit() from the same place as other
drivers?

  $ git grep -p dw_pcie_host_deinit drivers/pci/controller/dwc

> +{
> +	dw_pcie_host_deinit(&btpci->dw.pp);
> +}
> +
> +static int bt1_pcie_probe(struct platform_device *pdev)
> +{
> +	struct bt1_pcie *btpci;
> +
> +	btpci = bt1_pcie_create_data(pdev);
> +	if (IS_ERR(btpci))
> +		return PTR_ERR(btpci);
> +
> +	return bt1_pcie_add_dw_port(btpci);
> +}
> +
> +static int bt1_pcie_remove(struct platform_device *pdev)
> +{
> +	struct bt1_pcie *btpci = platform_get_drvdata(pdev);
> +
> +	bt1_pcie_del_dw_port(btpci);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id bt1_pcie_of_match[] = {
> +	{ .compatible = "baikal,bt1-pcie" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, bt1_pcie_of_match);
> +
> +static struct platform_driver bt1_pcie_driver = {
> +	.probe = bt1_pcie_probe,
> +	.remove = bt1_pcie_remove,
> +	.driver = {
> +		.name	= "bt1-pcie",
> +		.of_match_table = bt1_pcie_of_match,
> +	},
> +};
> +module_platform_driver(bt1_pcie_driver);
> +
> +MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
> +MODULE_DESCRIPTION("Baikal-T1 PCIe driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.35.1
> 
