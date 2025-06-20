Return-Path: <linux-pci+bounces-30276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53877AE22E4
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 21:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E344A09E6
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 19:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF791221273;
	Fri, 20 Jun 2025 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a86iKB2M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CA430E82F;
	Fri, 20 Jun 2025 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750448133; cv=none; b=b27djDL7C1RHkUd2rl9uoC+01cdVrRcXQMIyPT75x4BR48BivKFkih9ncVPtnahigQc1XvDQx5TZPiJXiwSLiaFgi6Cfjs6KUzm5zh6RdF669OPLbnr2WFoioPLHb02F4jGwPA62CJ8whpancc1rqHKWOX/ySWwOWD6vF9wz4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750448133; c=relaxed/simple;
	bh=66fn9HVkApU3iF680tkkXdzVYX3EDaTH1IPNsA4xYo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1rCiEaRwJfRRbL+RkLKeWwaE3m5/0+S2BRI0DHpZj+397QHMSignhLWpVLjym6N1PBByu1pRcmb4S/hYeWGkRzqgGitYsnp/CxRJiEXaJ1Na/dw0vDOepFzcbiFCcRyvoGHR5OMm8rtdhAEy/wfZJ4pUkrSLz4e7My+8NXH96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a86iKB2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1C6C4CEE3;
	Fri, 20 Jun 2025 19:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750448133;
	bh=66fn9HVkApU3iF680tkkXdzVYX3EDaTH1IPNsA4xYo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a86iKB2MRIz4v9m6LsFIb8ONcnhcuTQPxRZKu0C5BUOgErlz1OXiJ2JOEMYDoRSzE
	 kCuWGO/SbX/Voecf3TOeXzitec/I7AGaxYd6ECLTwTWcJyr5vVTcX8fcWbMgLMZ58F
	 iRRYPb4b+DlERg5W8rFWyYViYCEDVDFPptfqPqBkAgojjEDzcdrRF9QdSvq516HHz9
	 LXigkFexulhuoDD5a+ubrUdwIbgfZzWSub2NNStB9yPmfxIBZlQyzZKEtQR7EDBsyF
	 alZS71MD635veIDrmg8NX+RPs8us103R992X09tzJGsK2Q7bV7c+AohIAUfFbs4IJP
	 UCTzRJJi73nsQ==
Date: Sat, 21 Jun 2025 01:05:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	p.zabel@pengutronix.de, linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, john.madieu.xa@bp.renesas.com, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 4/8] PCI: rzg3s-host: Add Initial PCIe Host Driver for
 Renesas RZ/G3S SoC
Message-ID: <z7o26wizu5j3sft67yjbe2hgvqz7lqtsimgklzrvvwytahrhrd@rquvx32ctqtc>
References: <20250530111917.1495023-1-claudiu.beznea.uj@bp.renesas.com>
 <20250530111917.1495023-5-claudiu.beznea.uj@bp.renesas.com>
 <764d3uocv4kj6mrciaumoazwnquxhtn7u33u6v3a7tjwqhiyxf@2rtfsjyzny37>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <764d3uocv4kj6mrciaumoazwnquxhtn7u33u6v3a7tjwqhiyxf@2rtfsjyzny37>

On Wed, Jun 18, 2025 at 11:12:28PM +0530, Manivannan Sadhasivam wrote:
> On Fri, May 30, 2025 at 02:19:13PM +0300, Claudiu wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > 
> > The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> > Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> > only as a root complex, with a single-lane (x1) configuration. The
> > controller includes Type 1 configuration registers, as well as IP
> > specific registers (called AXI registers) required for various adjustments.
> > 
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > ---

[...]

> > +static int rzg3s_pcie_msi_setup(struct rzg3s_pcie_host *host)
> > +{
> > +	size_t size = RZG3S_PCI_MSI_INT_NR * sizeof(u32);
> > +	struct rzg3s_pcie_msi *msi = &host->msi;
> > +	struct device *dev = host->dev;
> > +	int id, ret;
> > +
> > +	msi->pages = __get_free_pages(GFP_KERNEL | GFP_DMA, 0);
> > +	if (!msi->pages)
> > +		return -ENOMEM;
> > +
> > +	msi->dma_addr = dma_map_single(dev, (void *)msi->pages, size * 2,
> > +				       DMA_BIDIRECTIONAL);
> > +	if (dma_mapping_error(dev, msi->dma_addr)) {
> > +		ret = -ENOMEM;
> > +		goto free_pages;
> > +	}

Why can't you use dma_alloc_coherent()?

> > +
> > +	/*
> > +	 * According to the RZ/G3S HW manual (Rev.1.10, section 34.4.5.2 Setting
> > +	 * the MSI Window) the MSI window need to be within any AXI window. Find
> > +	 * an AXI window to setup the MSI window.
> > +	 */
> > +	for (id = 0; id < RZG3S_MAX_WINDOWS; id++) {
> > +		u64 base, basel, baseu;
> > +		u64 mask, maskl, masku;
> > +
> > +		basel = readl(host->axi + RZG3S_PCI_AWBASEL(id));
> > +		/* Skip checking this AXI window if it's not enabled */
> > +		if (!(basel & RZG3S_PCI_AWBASEL_WIN_ENA))
> > +			continue;
> > +
> > +		baseu = readl(host->axi + RZG3S_PCI_AWBASEU(id));
> > +		base = baseu << 32 | basel;
> > +
> > +		maskl = readl(host->axi + RZG3S_PCI_AWMASKL(id));
> > +		masku = readl(host->axi + RZG3S_PCI_AWMASKU(id));
> > +		mask = masku << 32 | maskl;
> > +
> > +		if (msi->dma_addr < base || msi->dma_addr > base + mask)
> > +			continue;
> > +
> > +		break;
> > +	}
> > +
> > +	if (id == RZG3S_MAX_WINDOWS) {
> > +		ret = -EINVAL;
> > +		goto dma_unmap;
> > +	}
> > +
> > +	/* The MSI base address need to be aligned to the MSI size */
> > +	msi->window_base = ALIGN(msi->dma_addr, size);
> > +	if (msi->window_base < msi->dma_addr) {
> > +		ret = -EINVAL;
> > +		goto dma_unmap;
> > +	}
> > +
> > +	rzg3s_pcie_msi_hw_setup(host);
> > +
> > +	return 0;
> > +
> > +dma_unmap:
> > +	dma_unmap_single(dev, msi->dma_addr, size * 2, DMA_BIDIRECTIONAL);
> > +free_pages:
> > +	free_pages(msi->pages, 0);
> > +	return ret;
> > +}
> > +
> > +static int rzg3s_pcie_msi_enable(struct rzg3s_pcie_host *host)
> > +{
> > +	struct platform_device *pdev = to_platform_device(host->dev);
> > +	struct rzg3s_pcie_msi *msi = &host->msi;
> > +	struct device *dev = host->dev;
> > +	const char *devname;
> > +	int irq, ret;
> > +
> > +	mutex_init(&msi->map_lock);
> > +
> > +	irq = platform_get_irq_byname(pdev, "msi");
> > +	if (irq < 0)
> > +		return dev_err_probe(dev, irq ? irq : -EINVAL,
> > +				     "Failed to get MSI IRQ!\n");
> > +
> > +	devname = devm_kasprintf(dev, GFP_KERNEL, "%s-msi", dev_name(dev));
> > +	if (!devname)
> > +		return -ENOMEM;
> > +
> > +	ret = rzg3s_pcie_msi_allocate_domains(msi);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_request_irq(dev, irq, rzg3s_pcie_msi_irq, 0, devname, host);
> > +	if (ret) {
> > +		dev_err_probe(dev, ret, "Failed to request IRQ: %d\n", ret);
> > +		goto free_domains;
> > +	}
> > +

So you've modelled INTx as hierarchial IRQ domain, but not MSI. May I know why?
Both are chained to GIC, isn't it?

> > +	ret = rzg3s_pcie_msi_setup(host);
> > +	if (ret) {
> > +		dev_err_probe(dev, ret, "Failed to setup MSI!\n");
> > +		goto free_domains;
> > +	}
> > +
> > +	return 0;
> > +
> > +free_domains:
> > +	rzg3s_pcie_msi_free_domains(msi);
> > +	return ret;
> > +}
> > +

[...]

> > +static int rzg3s_soc_pcie_init_phy(struct rzg3s_pcie_host *host)
> > +{
> > +	static const u32 xcfgd_settings[RZG3S_PCI_PHY_XCFGD_NUM] = {
> > +		[8]  = 0xe0006801, 0x007f7e30, 0x183e0000, 0x978ff500,
> > +		       0xec000000, 0x009f1400, 0x0000d009,
> > +		[17] = 0x78000000,
> > +		[19] = 0x00880000, 0x000005c0, 0x07000000, 0x00780920,
> > +		       0xc9400ce2, 0x90000c0c, 0x000c1414, 0x00005034,
> > +		       0x00006000, 0x00000001,
> > +	};
> > +	static const u32 xcfga_cmn_settings[RZG3S_PCI_PHY_XCFGA_CMN_NUM] = {
> > +		0x00000d10, 0x08310100, 0x00c21404, 0x013c0010, 0x01874440,
> > +		0x1a216082, 0x00103440, 0x00000080, 0x00000010, 0x0c1000c1,
> > +		0x1000c100, 0x0222000c, 0x00640019, 0x00a00028, 0x01d11228,
> > +		0x0201001d,
> > +	};
> > +	static const u32 xcfga_rx_settings[RZG3S_PCI_PHY_XCFGA_RX_NUM] = {
> > +		0x07d55000, 0x030e3f00, 0x00000288, 0x102c5880, 0x0000000b,
> > +		0x04141441, 0x00641641, 0x00d63d63, 0x00641641, 0x01970377,
> > +		0x00190287, 0x00190028, 0x00000028,
> > +	};
> > +
> > +	writel(RZG3S_PCI_PERM_PIPE_PHY_REG_EN, host->axi + RZG3S_PCI_PERM);
> > +
> > +	for (u8 i = 0; i < RZG3S_PCI_PHY_XCFGD_NUM; i++)
> > +		writel(xcfgd_settings[i], host->axi + RZG3S_PCI_PHY_XCFGD(i));
> > +
> > +	for (u8 i = 0; i < RZG3S_PCI_PHY_XCFGA_CMN_NUM; i++) {
> > +		writel(xcfga_cmn_settings[i],
> > +		       host->axi + RZG3S_PCI_PHY_XCFGA_CMN(i));
> > +	}
> > +
> > +	for (u8 i = 0; i < RZG3S_PCI_PHY_XCFGA_RX_NUM; i++) {
> > +		writel(xcfga_rx_settings[i],
> > +		       host->axi + RZG3S_PCI_PHY_XCFGA_RX(i));
> > +	}
> > +
> > +	writel(0x107, host->axi + RZG3S_PCI_PHY_XCFGA_TX);
> > +
> > +	/* Select PHY settings values */
> > +	writel(RZG3S_PCI_PHY_XCFG_CTRL_PHYREG_SEL,
> > +	       host->axi + RZG3S_PCI_PHY_XCFG_CTRL);
> > +
> > +	writel(0, host->axi + RZG3S_PCI_PERM);
> > +
> > +	return 0;
> > +}

Why didn't these go into a PHY driver? Please provide justification.

> > +
> > +static void rzg3s_pcie_pm_runtime_put(void *data)
> > +{
> > +	pm_runtime_put_sync(data);
> > +}
> > +

[...]

> > +static int rzg3s_pcie_probe(struct platform_device *pdev)
> > +{
> > +	struct pci_host_bridge *bridge;
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *np = dev->of_node;
> > +	struct device_node *sysc_np __free(device_node) =
> > +		of_parse_phandle(np, "renesas,sysc", 0);
> > +	struct rzg3s_pcie_host *host;
> > +	int ret;
> > +
> > +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*host));
> > +	if (!bridge)
> > +		return -ENOMEM;
> > +
> > +	host = pci_host_bridge_priv(bridge);
> > +	host->dev = dev;
> > +	host->data = device_get_match_data(dev);
> > +	platform_set_drvdata(pdev, host);
> > +
> > +	host->axi = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(host->axi))
> > +		return PTR_ERR(host->axi);
> > +	host->pcie = host->axi + RZG3S_PCI_CFG_BASE;
> > +
> > +	ret = of_property_read_u32(np, "vendor-id", &host->vendor_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = of_property_read_u32(np, "device-id", &host->device_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	host->sysc = syscon_node_to_regmap(sysc_np);
> > +	if (IS_ERR(host->sysc))
> > +		return PTR_ERR(host->sysc);
> > +
> > +	ret = regmap_update_bits(host->sysc, RZG3S_SYS_PCIE_RST_RSM_B,
> > +				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
> > +				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 1));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_add_action_or_reset(dev, rzg3s_pcie_sysc_signal_action,
> > +				       host->sysc);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = rzg3s_pcie_resets_prepare(host);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_pm_runtime_enable(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = pm_runtime_resume_and_get(dev);
> > +	if (ret)
> > +		return ret;

Why do you need runtime PM? Do you need to enable any parent domain before
intializing the controller?

> > +
> > +	ret = devm_add_action_or_reset(dev, rzg3s_pcie_pm_runtime_put, dev);
> > +	if (ret)
> > +		return ret;
> > +

Why is this needed?

> > +	raw_spin_lock_init(&host->hw_lock);
> > +
> > +	ret = rzg3s_pcie_host_setup(host, rzg3s_pcie_intx_setup,
> > +				    rzg3s_pcie_msi_enable, true);
> > +	if (ret)
> > +		return ret;
> > +
> > +	bridge->sysdata = host;
> > +	bridge->ops = &rzg3s_pcie_root_ops;
> > +	bridge->child_ops = &rzg3s_pcie_child_ops;
> > +	ret = pci_host_probe(bridge);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_add_action_or_reset(dev, rzg3s_pcie_host_remove_action,
> > +					host);

Is this a workaround for not having a .remove() callback?

> > +}
> > +
> > +static int rzg3s_pcie_suspend_noirq(struct device *dev)
> > +{
> > +	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
> > +	const struct rzg3s_pcie_soc_data *data = host->data;
> > +	struct regmap *sysc = host->sysc;
> > +	int ret;
> > +
> > +	ret = pm_runtime_put_sync(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = reset_control_bulk_assert(data->num_power_resets,
> > +					host->power_resets);
> > +	if (ret)
> > +		goto rpm_restore;
> > +
> > +	ret = reset_control_bulk_assert(data->num_cfg_resets,
> > +					host->cfg_resets);
> > +	if (ret)
> > +		goto power_resets_restore;
> > +
> > +	ret = regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
> > +				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
> > +				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 0));
> > +	if (ret)
> > +		goto cfg_resets_restore;

Don't you need to control the endpoint state here? Like putting it into D3Cold,
toggling PERST#, enabling wakeup etc...?

> > +
> > +	return 0;
> > +
> > +	/* Restore the previous state if any error happens */
> > +cfg_resets_restore:
> > +	reset_control_bulk_deassert(data->num_cfg_resets,
> > +				    host->cfg_resets);
> > +power_resets_restore:
> > +	reset_control_bulk_deassert(data->num_power_resets,
> > +				    host->power_resets);
> > +rpm_restore:
> > +	pm_runtime_resume_and_get(dev);
> > +	return ret;
> > +}
> > +
> > +static int rzg3s_pcie_resume_noirq(struct device *dev)
> > +{
> > +	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
> > +	const struct rzg3s_pcie_soc_data *data = host->data;
> > +	struct regmap *sysc = host->sysc;
> > +	int ret;
> > +
> > +	ret = regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
> > +				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
> > +				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 1));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * According to the RZ/G3S HW manual (Rev.1.10, section
> > +	 * 34.5.1.2 De-asserting the Reset) the PCIe IP needs to wait 5ms from
> > +	 * power on to the de-assertion of reset.
> > +	 */
> > +	usleep_range(5000, 5100);
> > +	ret = reset_control_bulk_deassert(data->num_power_resets,
> > +					  host->power_resets);
> > +	if (ret)
> > +		goto assert_rst_rsm_b;
> > +
> > +	ret = pm_runtime_resume_and_get(dev);
> > +	if (ret)
> > +		goto assert_power_resets;
> > +
> > +	ret = rzg3s_pcie_host_setup(host, NULL, rzg3s_pcie_msi_hw_setup, false);
> > +	if (ret)
> > +		goto rpm_put;
> > +
> > +	return 0;
> > +
> > +	/*
> > +	 * If any error happens there is no way to recover the IP. Put it in the
> > +	 * lowest possible power state.
> > +	 */
> > +rpm_put:
> > +	pm_runtime_put_sync(dev);
> > +assert_power_resets:
> > +	reset_control_bulk_assert(data->num_power_resets,
> > +				  host->power_resets);
> > +assert_rst_rsm_b:
> > +	regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
> > +			   RZG3S_SYS_PCIE_RST_RSM_B_MASK,
> > +			   FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 0));
> > +	return ret;
> > +}
> > +
> > +static const struct dev_pm_ops rzg3s_pcie_pm_ops = {
> > +	NOIRQ_SYSTEM_SLEEP_PM_OPS(rzg3s_pcie_suspend_noirq,
> > +				  rzg3s_pcie_resume_noirq)
> > +};
> > +
> > +const char * const rzg3s_soc_power_resets[] = {
> > +	"aresetn", "rst_cfg_b", "rst_load_b",
> > +};
> > +
> > +const char * const rzg3s_soc_cfg_resets[] = {
> > +	"rst_b", "rst_ps_b", "rst_gp_b", "rst_rsm_b",
> > +};
> > +
> > +static const struct rzg3s_pcie_soc_data rzg3s_soc_data = {
> > +	.power_resets = rzg3s_soc_power_resets,
> > +	.num_power_resets = ARRAY_SIZE(rzg3s_soc_power_resets),
> > +	.cfg_resets = rzg3s_soc_cfg_resets,
> > +	.num_cfg_resets = ARRAY_SIZE(rzg3s_soc_cfg_resets),
> > +	.init_phy = rzg3s_soc_pcie_init_phy,
> > +};

Are you expecting these callbacks to be different in next gen SoCs? I'd
recommend to get rid of callbacks until the support for newer SoCs get added.

> > +
> > +static const struct of_device_id rzg3s_pcie_of_match[] = {
> > +	{
> > +		.compatible = "renesas,r9a08g045s33-pcie",
> > +		.data = &rzg3s_soc_data,
> > +	},
> > +	{},
> > +};
> > +
> > +static struct platform_driver rzg3s_pcie_driver = {
> > +	.driver = {
> > +		.name = "rzg3s-pcie-host",
> > +		.of_match_table = rzg3s_pcie_of_match,
> > +		.pm = pm_ptr(&rzg3s_pcie_pm_ops),
> > +	},
> > +	.probe = rzg3s_pcie_probe,

You haven't implemented .remove(), but didn't set '.suppress_bind_attrs = true'.
PCI controller drivers acting as an IRQCHIP are not safe to be removed.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

