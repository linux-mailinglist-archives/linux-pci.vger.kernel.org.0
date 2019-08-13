Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00B248B603
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 12:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfHMK5q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 06:57:46 -0400
Received: from foss.arm.com ([217.140.110.172]:33888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbfHMK5q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Aug 2019 06:57:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88BA3344;
        Tue, 13 Aug 2019 03:57:44 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F27DC3F694;
        Tue, 13 Aug 2019 03:57:41 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:57:39 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V15 13/13] PCI: tegra: Add Tegra194 PCIe support
Message-ID: <20190813105739.GC14977@e121166-lin.cambridge.arm.com>
References: <20190809044609.20401-1-vidyas@nvidia.com>
 <20190809044609.20401-14-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809044609.20401-14-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some style comments - we have time to fix them.

On Fri, Aug 09, 2019 at 10:16:09AM +0530, Vidya Sagar wrote:

[...]

I do not know why up to here the line spacing is OK and here
you started cramming code all together :)

Just a matter of consistency, thanks for fixing them up.

> +static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
> +{
> +	struct pcie_port *pp = &pcie->pci.pp;
> +	struct pci_bus *child;
> +	struct pci_dev *pdev;
> +
> +	/*
> +	 * link doesn't go into L2 state with some of the endpoints with Tegra
> +	 * if they are not in D0 state. So, need to make sure that immediate
> +	 * downstream devices are in D0 state before sending PME_TurnOff to put
> +	 * link into L2 state.
> +	 * This is as per PCI Express Base r4.0 v1.0 September 27-2017,
> +	 * 5.2 Link State Power Management (Page #428).
> +	 */
> +
> +	list_for_each_entry(child, &pp->root_bus->children, node) {
> +		/* Bring downstream devices to D0 if they are not already in */
> +		if (child->parent == pp->root_bus)
> +			break;
> +	}

Add empty line.

> +	list_for_each_entry(pdev, &child->devices, bus_list) {
> +		if (PCI_SLOT(pdev->devfn) == 0) {
> +			if (pci_set_power_state(pdev, PCI_D0))
> +				dev_err(pcie->dev,
> +					"Failed to transition %s to D0 state\n",
> +					dev_name(&pdev->dev));
> +		}
> +	}
> +}
> +
> +static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
> +					bool en_hw_hot_rst)
> +{
> +	int ret;
> +	u32 val;
> +
> +	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, true);
> +	if (ret) {
> +		dev_err(pcie->dev,
> +			"Failed to enable controller %u: %d\n", pcie->cid, ret);
> +		return ret;
> +	}
> +
> +	ret = regulator_enable(pcie->pex_ctl_supply);
> +	if (ret < 0) {
> +		dev_err(pcie->dev, "Failed to enable regulator: %d\n", ret);
> +		goto fail_reg_en;
> +	}
> +
> +	ret = clk_prepare_enable(pcie->core_clk);
> +	if (ret) {
> +		dev_err(pcie->dev, "Failed to enable core clock: %d\n", ret);
> +		goto fail_core_clk;
> +	}
> +
> +	ret = reset_control_deassert(pcie->core_apb_rst);
> +	if (ret) {
> +		dev_err(pcie->dev, "Failed to deassert core APB reset: %d\n",
> +			ret);
> +		goto fail_core_apb_rst;
> +	}
> +
> +	if (en_hw_hot_rst) {
> +		/* Enable HW_HOT_RST mode */
> +		val = appl_readl(pcie, APPL_CTRL);
> +		val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
> +			 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
> +		val |= APPL_CTRL_HW_HOT_RST_EN;
> +		appl_writel(pcie, val, APPL_CTRL);
> +	}
> +
> +	ret = tegra_pcie_enable_phy(pcie);
> +	if (ret) {
> +		dev_err(pcie->dev, "Failed to enable PHY: %d\n", ret);
> +		goto fail_phy;
> +	}
> +
> +	/* Update CFG base address */
> +	appl_writel(pcie, pcie->dbi_res->start & APPL_CFG_BASE_ADDR_MASK,
> +		    APPL_CFG_BASE_ADDR);
> +
> +	/* Configure this core for RP mode operation */
> +	appl_writel(pcie, APPL_DM_TYPE_RP, APPL_DM_TYPE);
> +
> +	appl_writel(pcie, 0x0, APPL_CFG_SLCG_OVERRIDE);
> +
> +	val = appl_readl(pcie, APPL_CTRL);
> +	appl_writel(pcie, val | APPL_CTRL_SYS_PRE_DET_STATE, APPL_CTRL);
> +
> +	val = appl_readl(pcie, APPL_CFG_MISC);
> +	val |= (APPL_CFG_MISC_ARCACHE_VAL << APPL_CFG_MISC_ARCACHE_SHIFT);
> +	appl_writel(pcie, val, APPL_CFG_MISC);
> +
> +	if (!pcie->supports_clkreq) {
> +		val = appl_readl(pcie, APPL_PINMUX);
> +		val |= APPL_PINMUX_CLKREQ_OUT_OVRD_EN;
> +		val |= APPL_PINMUX_CLKREQ_OUT_OVRD;
> +		appl_writel(pcie, val, APPL_PINMUX);
> +	}
> +
> +	/* Update iATU_DMA base address */
> +	appl_writel(pcie,
> +		    pcie->atu_dma_res->start & APPL_CFG_IATU_DMA_BASE_ADDR_MASK,
> +		    APPL_CFG_IATU_DMA_BASE_ADDR);
> +
> +	reset_control_deassert(pcie->core_rst);
> +
> +	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
> +						      PCI_CAP_ID_EXP);
> +
> +	/* Disable ASPM-L1SS advertisement as there is no CLKREQ routing */
> +	if (!pcie->supports_clkreq) {
> +		disable_aspm_l11(pcie);
> +		disable_aspm_l12(pcie);
> +	}
> +
> +	return ret;
> +
> +fail_phy:
> +	reset_control_assert(pcie->core_apb_rst);
> +fail_core_apb_rst:
> +	clk_disable_unprepare(pcie->core_clk);
> +fail_core_clk:
> +	regulator_disable(pcie->pex_ctl_supply);
> +fail_reg_en:
> +	tegra_pcie_bpmp_set_ctrl_state(pcie, false);
> +
> +	return ret;
> +}
> +
> +static int __deinit_controller(struct tegra_pcie_dw *pcie)
> +{
> +	int ret;
> +
> +	ret = reset_control_assert(pcie->core_rst);
> +	if (ret) {
> +		dev_err(pcie->dev, "Failed to assert \"core\" reset: %d\n",
> +			ret);
> +		return ret;
> +	}

Add empty line.

> +	tegra_pcie_disable_phy(pcie);

Add empty line.

> +	ret = reset_control_assert(pcie->core_apb_rst);
> +	if (ret) {
> +		dev_err(pcie->dev, "Failed to assert APB reset: %d\n", ret);
> +		return ret;
> +	}

Add empty line.

> +	clk_disable_unprepare(pcie->core_clk);

Add empty line.

> +	ret = regulator_disable(pcie->pex_ctl_supply);
> +	if (ret) {
> +		dev_err(pcie->dev, "Failed to disable regulator: %d\n", ret);
> +		return ret;
> +	}

Add empty line.

> +	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, false);
> +	if (ret) {
> +		dev_err(pcie->dev, "Failed to disable controller %d: %d\n",
> +			pcie->cid, ret);
> +		return ret;
> +	}

Add empty line.

> +	return ret;
> +}
> +
> +static int tegra_pcie_init_controller(struct tegra_pcie_dw *pcie)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct pcie_port *pp = &pci->pp;
> +	int ret;
> +
> +	ret = tegra_pcie_config_controller(pcie, false);
> +	if (ret < 0)
> +		return ret;
> +
> +	pp->ops = &tegra_pcie_dw_host_ops;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret < 0) {
> +		dev_err(pcie->dev, "Failed to add PCIe port: %d\n", ret);
> +		goto fail_host_init;
> +	}
> +
> +	return 0;
> +
> +fail_host_init:
> +	return __deinit_controller(pcie);
> +}
> +
> +static int tegra_pcie_try_link_l2(struct tegra_pcie_dw *pcie)
> +{
> +	u32 val;
> +
> +	if (!tegra_pcie_dw_link_up(&pcie->pci))
> +		return 0;
> +
> +	val = appl_readl(pcie, APPL_RADM_STATUS);
> +	val |= APPL_PM_XMT_TURNOFF_STATE;
> +	appl_writel(pcie, val, APPL_RADM_STATUS);
> +
> +	return readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG, val,
> +				 val & APPL_DEBUG_PM_LINKST_IN_L2_LAT,
> +				 1, PME_ACK_TIMEOUT);
> +}
> +
> +static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
> +{
> +	u32 data;
> +	int err;
> +
> +	if (!tegra_pcie_dw_link_up(&pcie->pci)) {
> +		dev_dbg(pcie->dev, "PCIe link is not up...!\n");
> +		return;
> +	}
> +
> +	if (tegra_pcie_try_link_l2(pcie)) {
> +		dev_info(pcie->dev, "Link didn't transition to L2 state\n");
> +		/*
> +		 * TX lane clock freq will reset to Gen1 only if link is in L2
> +		 * or detect state.
> +		 * So apply pex_rst to end point to force RP to go into detect
> +		 * state
> +		 */
> +		data = appl_readl(pcie, APPL_PINMUX);
> +		data &= ~APPL_PINMUX_PEX_RST;
> +		appl_writel(pcie, data, APPL_PINMUX);
> +
> +		err = readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG,
> +						data,
> +						((data &
> +						APPL_DEBUG_LTSSM_STATE_MASK) >>
> +						APPL_DEBUG_LTSSM_STATE_SHIFT) ==
> +						LTSSM_STATE_PRE_DETECT,
> +						1, LTSSM_TIMEOUT);
> +		if (err) {
> +			dev_info(pcie->dev, "Link didn't go to detect state\n");
> +		} else {
> +			/* Disable LTSSM after link is in detect state */
> +			data = appl_readl(pcie, APPL_CTRL);
> +			data &= ~APPL_CTRL_LTSSM_EN;
> +			appl_writel(pcie, data, APPL_CTRL);
> +		}
> +	}
> +	/*
> +	 * DBI registers may not be accessible after this as PLL-E would be
> +	 * down depending on how CLKREQ is pulled by end point
> +	 */
> +	data = appl_readl(pcie, APPL_PINMUX);
> +	data |= (APPL_PINMUX_CLKREQ_OVERRIDE_EN | APPL_PINMUX_CLKREQ_OVERRIDE);
> +	/* Cut REFCLK to slot */
> +	data |= APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE_EN;
> +	data &= ~APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE;
> +	appl_writel(pcie, data, APPL_PINMUX);
> +}
> +
> +static int tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
> +{
> +	tegra_pcie_downstream_dev_to_D0(pcie);
> +	dw_pcie_host_deinit(&pcie->pci.pp);
> +	tegra_pcie_dw_pme_turnoff(pcie);

Add empty line.

> +	return __deinit_controller(pcie);
> +}
> +
> +static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
> +{
> +	struct pcie_port *pp = &pcie->pci.pp;
> +	struct device *dev = pcie->dev;
> +	char *name;
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pp->msi_irq = of_irq_get_byname(dev->of_node, "msi");
> +		if (!pp->msi_irq) {
> +			dev_err(dev, "Failed to get MSI interrupt\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get runtime sync for PCIe dev: %d\n",
> +			ret);
> +		pm_runtime_disable(dev);
> +		return ret;
> +	}
> +
> +	tegra_pcie_init_controller(pcie);
> +
> +	pcie->link_state = tegra_pcie_dw_link_up(&pcie->pci);
> +
> +	if (!pcie->link_state) {
> +		ret = -ENOMEDIUM;
> +		goto fail_host_init;
> +	}
> +
> +	name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
> +	if (!name) {
> +		ret = -ENOMEM;
> +		goto fail_host_init;
> +	}
> +
> +	pcie->debugfs = debugfs_create_dir(name, NULL);
> +	if (!pcie->debugfs)
> +		dev_err(dev, "Failed to create debugfs\n");
> +	else
> +		init_debugfs(pcie);
> +
> +	return ret;
> +
> +fail_host_init:
> +	tegra_pcie_deinit_controller(pcie);
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +	return ret;
> +}
> +
> +static int tegra_pcie_dw_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *atu_dma_res;
> +	struct tegra_pcie_dw *pcie;
> +	struct resource *dbi_res;
> +	struct pcie_port *pp;
> +	struct dw_pcie *pci;
> +	struct phy **phys;
> +	char *name;
> +	int ret;
> +	u32 i;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pci = &pcie->pci;
> +	pci->dev = &pdev->dev;
> +	pci->ops = &tegra_dw_pcie_ops;
> +	pp = &pci->pp;
> +	pcie->dev = &pdev->dev;
> +
> +	ret = tegra_pcie_dw_parse_dt(pcie);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to parse device tree: %d\n", ret);
> +		return ret;
> +	}
> +
> +	pcie->pex_ctl_supply = devm_regulator_get(dev, "vddio-pex-ctl");
> +	if (IS_ERR(pcie->pex_ctl_supply)) {
> +		dev_err(dev, "Failed to get regulator: %ld\n",
> +			PTR_ERR(pcie->pex_ctl_supply));
> +		return PTR_ERR(pcie->pex_ctl_supply);
> +	}
> +
> +	pcie->core_clk = devm_clk_get(dev, "core");
> +	if (IS_ERR(pcie->core_clk)) {
> +		dev_err(dev, "Failed to get core clock: %ld\n",
> +			PTR_ERR(pcie->core_clk));
> +		return PTR_ERR(pcie->core_clk);
> +	}
> +
> +	pcie->appl_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						      "appl");
> +	if (!pcie->appl_res) {
> +		dev_err(dev, "Failed to find \"appl\" region\n");
> +		return PTR_ERR(pcie->appl_res);
> +	}
> +
> +	pcie->appl_base = devm_ioremap_resource(dev, pcie->appl_res);
> +	if (IS_ERR(pcie->appl_base))
> +		return PTR_ERR(pcie->appl_base);
> +
> +	pcie->core_apb_rst = devm_reset_control_get(dev, "apb");
> +	if (IS_ERR(pcie->core_apb_rst)) {
> +		dev_err(dev, "Failed to get APB reset: %ld\n",
> +			PTR_ERR(pcie->core_apb_rst));
> +		return PTR_ERR(pcie->core_apb_rst);
> +	}
> +
> +	phys = devm_kcalloc(dev, pcie->phy_count, sizeof(*phys), GFP_KERNEL);
> +	if (!phys)
> +		return PTR_ERR(phys);
> +
> +	for (i = 0; i < pcie->phy_count; i++) {
> +		name = kasprintf(GFP_KERNEL, "p2u-%u", i);
> +		if (!name) {
> +			dev_err(dev, "Failed to create P2U string\n");
> +			return -ENOMEM;
> +		}
> +		phys[i] = devm_phy_get(dev, name);
> +		kfree(name);
> +		if (IS_ERR(phys[i])) {
> +			ret = PTR_ERR(phys[i]);
> +			dev_err(dev, "Failed to get PHY: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	pcie->phys = phys;
> +
> +	dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	if (!dbi_res) {
> +		dev_err(dev, "Failed to find \"dbi\" region\n");
> +		return PTR_ERR(dbi_res);
> +	}
> +	pcie->dbi_res = dbi_res;
> +
> +	pci->dbi_base = devm_ioremap_resource(dev, dbi_res);
> +	if (IS_ERR(pci->dbi_base))
> +		return PTR_ERR(pci->dbi_base);
> +
> +	/* Tegra HW locates DBI2 at a fixed offset from DBI */
> +	pci->dbi_base2 = pci->dbi_base + 0x1000;
> +
> +	atu_dma_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						   "atu_dma");
> +	if (!atu_dma_res) {
> +		dev_err(dev, "Failed to find \"atu_dma\" region\n");
> +		return PTR_ERR(atu_dma_res);
> +	}
> +	pcie->atu_dma_res = atu_dma_res;
> +
> +	pci->atu_base = devm_ioremap_resource(dev, atu_dma_res);
> +	if (IS_ERR(pci->atu_base))
> +		return PTR_ERR(pci->atu_base);
> +
> +	pcie->core_rst = devm_reset_control_get(dev, "core");
> +	if (IS_ERR(pcie->core_rst)) {
> +		dev_err(dev, "Failed to get core reset: %ld\n",
> +			PTR_ERR(pcie->core_rst));
> +		return PTR_ERR(pcie->core_rst);
> +	}
> +
> +	pp->irq = platform_get_irq_byname(pdev, "intr");
> +	if (!pp->irq) {
> +		dev_err(dev, "Failed to get \"intr\" interrupt\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = devm_request_irq(dev, pp->irq, tegra_pcie_irq_handler,
> +			       IRQF_SHARED, "tegra-pcie-intr", pcie);
> +	if (ret) {
> +		dev_err(dev, "Failed to request IRQ %d: %d\n", pp->irq, ret);
> +		return ret;
> +	}
> +
> +	pcie->bpmp = tegra_bpmp_get(dev);
> +	if (IS_ERR(pcie->bpmp))
> +		return PTR_ERR(pcie->bpmp);
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	ret = tegra_pcie_config_rp(pcie);
> +	if (ret && ret != -ENOMEDIUM)
> +		goto fail;
> +	else
> +		return 0;
> +
> +fail:
> +	tegra_bpmp_put(pcie->bpmp);
> +	return ret;
> +}
> +
> +static int tegra_pcie_dw_remove(struct platform_device *pdev)
> +{
> +	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
> +
> +	if (!pcie->link_state)
> +		return 0;
> +
> +	debugfs_remove_recursive(pcie->debugfs);
> +	tegra_pcie_deinit_controller(pcie);
> +	pm_runtime_put_sync(pcie->dev);
> +	pm_runtime_disable(pcie->dev);
> +	tegra_bpmp_put(pcie->bpmp);
> +
> +	return 0;
> +}
> +
> +static int tegra_pcie_dw_suspend_late(struct device *dev)
> +{
> +	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> +	u32 val;
> +
> +	if (!pcie->link_state)
> +		return 0;
> +
> +	/* Enable HW_HOT_RST mode */
> +	val = appl_readl(pcie, APPL_CTRL);
> +	val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
> +		 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
> +	val |= APPL_CTRL_HW_HOT_RST_EN;
> +	appl_writel(pcie, val, APPL_CTRL);
> +
> +	return 0;
> +}
> +
> +static int tegra_pcie_dw_suspend_noirq(struct device *dev)
> +{
> +	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> +
> +	if (!pcie->link_state)
> +		return 0;
> +
> +	/* Save MSI interrupt vector */
> +	pcie->msi_ctrl_int = dw_pcie_readl_dbi(&pcie->pci,
> +					       PORT_LOGIC_MSI_CTRL_INT_0_EN);
> +	tegra_pcie_downstream_dev_to_D0(pcie);
> +	tegra_pcie_dw_pme_turnoff(pcie);

Add empty line.

> +	return __deinit_controller(pcie);
> +}
> +
> +static int tegra_pcie_dw_resume_noirq(struct device *dev)
> +{
> +	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!pcie->link_state)
> +		return 0;
> +
> +	ret = tegra_pcie_config_controller(pcie, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = tegra_pcie_dw_host_init(&pcie->pci.pp);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to init host: %d\n", ret);
> +		goto fail_host_init;
> +	}
> +
> +	/* Restore MSI interrupt vector */
> +	dw_pcie_writel_dbi(&pcie->pci, PORT_LOGIC_MSI_CTRL_INT_0_EN,
> +			   pcie->msi_ctrl_int);
> +
> +	return 0;

Add empty line.

Thanks,
Lorenzo

> +fail_host_init:
> +	return __deinit_controller(pcie);
> +}
> +
> +static int tegra_pcie_dw_resume_early(struct device *dev)
> +{
> +	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> +	u32 val;
> +
> +	if (!pcie->link_state)
> +		return 0;
> +
> +	/* Disable HW_HOT_RST mode */
> +	val = appl_readl(pcie, APPL_CTRL);
> +	val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
> +		 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
> +	val |= APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST <<
> +	       APPL_CTRL_HW_HOT_RST_MODE_SHIFT;
> +	val &= ~APPL_CTRL_HW_HOT_RST_EN;
> +	appl_writel(pcie, val, APPL_CTRL);
> +
> +	return 0;
> +}
> +
> +static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
> +{
> +	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
> +
> +	if (!pcie->link_state)
> +		return;
> +
> +	debugfs_remove_recursive(pcie->debugfs);
> +	tegra_pcie_downstream_dev_to_D0(pcie);
> +
> +	disable_irq(pcie->pci.pp.irq);
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		disable_irq(pcie->pci.pp.msi_irq);
> +
> +	tegra_pcie_dw_pme_turnoff(pcie);
> +	__deinit_controller(pcie);
> +}
> +
> +static const struct of_device_id tegra_pcie_dw_of_match[] = {
> +	{
> +		.compatible = "nvidia,tegra194-pcie",
> +	},
> +	{},
> +};
> +
> +static const struct dev_pm_ops tegra_pcie_dw_pm_ops = {
> +	.suspend_late = tegra_pcie_dw_suspend_late,
> +	.suspend_noirq = tegra_pcie_dw_suspend_noirq,
> +	.resume_noirq = tegra_pcie_dw_resume_noirq,
> +	.resume_early = tegra_pcie_dw_resume_early,
> +};
> +
> +static struct platform_driver tegra_pcie_dw_driver = {
> +	.probe = tegra_pcie_dw_probe,
> +	.remove = tegra_pcie_dw_remove,
> +	.shutdown = tegra_pcie_dw_shutdown,
> +	.driver = {
> +		.name	= "tegra194-pcie",
> +		.pm = &tegra_pcie_dw_pm_ops,
> +		.of_match_table = tegra_pcie_dw_of_match,
> +	},
> +};
> +module_platform_driver(tegra_pcie_dw_driver);
> +
> +MODULE_DEVICE_TABLE(of, tegra_pcie_dw_of_match);
> +
> +MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
> +MODULE_DESCRIPTION("NVIDIA PCIe host controller driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1
> 
