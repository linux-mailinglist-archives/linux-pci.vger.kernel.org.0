Return-Path: <linux-pci+bounces-42801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22329CAE72B
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 01:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C42F03012BED
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 00:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE3F19C540;
	Tue,  9 Dec 2025 00:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nzqe2YsL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B23B86331;
	Tue,  9 Dec 2025 00:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239069; cv=none; b=bK/v/1+18+kD3p2yoqyXV+K5dBNVXu/680o3m2dIAIABerlAomFKo+aYs+GJ6Iz+G7DyS1X5bZkC8agS7r+BvaV63454b1q353va8hrUGe/yGyPQ0hl3Qu8S+6BBbCXqFdKqLcSfjnzkUrynVJIETqk911Y6HVGk5eCKwdmxprQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239069; c=relaxed/simple;
	bh=7ptARhGnIW0rweJs/X7vTtC/SQB8ulRmWeebM2Urvl0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YkM/SLsGggLsP0L5dzLPV9QMZGF39wqTfyJgFi0RkLmYxTysujzDJxj7SszGLMrOSx94ILGYSZ2Bo7KztLSOefs2GEYeWvRW2ARUj6WStV/rx+J7Yu7q82oFgWe/PheLG1oXjybtte43bkcDqi1fYF/cdwQsl1HZDVNcykAmSKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nzqe2YsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF78BC4CEF1;
	Tue,  9 Dec 2025 00:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765239068;
	bh=7ptARhGnIW0rweJs/X7vTtC/SQB8ulRmWeebM2Urvl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Nzqe2YsLmvHdUUpvvSUvm6rLElIkqyZsP8E7UC7VgLN1jMvslaQaB65EuuR2M3tQD
	 ++rs5KQFBsdOe7SSQ8hVf+DJAugUoPM5Mqrfs69Wm5NDb1BwhrWGYUAduiY2Yokwcw
	 UnX/Dznj2igM6Bvu9sfjXeM7bTJaA4vS7oKDjiqP6a78W6GKZiw//u+Q7WQb61e+KS
	 HRkk6gQ/8ovRTrwFr5gibfZmzjuyR5eHFLZzYqvj1cKSwTFL0LbWpbU7omxzWiVhGp
	 mAEOHH5Lmz7F8T0wk0TahZiroHww1QftElDdmGAe4Dk+Qfg0wy4JVD6zQ794GMZXJu
	 /flhU9gTQ0Z9A==
Date: Mon, 8 Dec 2025 18:11:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v6 6/7] PCI: aspeed: Add ASPEED PCIe RC driver
Message-ID: <20251209001107.GA3430423@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201-upstream_pcie_rc-v6-6-8c8800c56b16@aspeedtech.com>

On Mon, Dec 01, 2025 at 02:29:16PM +0800, Jacky Chou wrote:
> Introduce PCIe Root Complex driver for ASPEED SoCs. Support RC
> initialization, reset, clock, IRQ domain, and MSI domain setup.
> Implement platform-specific setup and register configuration for
> ASPEED. And provide PCI config space read/write and INTx/MSI
> interrupt handling.
> ...

> +struct aspeed_pcie {
> +	struct pci_host_bridge *host;
> +	struct device *dev;
> +	void __iomem *reg;
> +	struct regmap *ahbc;
> +	struct regmap *cfg;
> +	const struct aspeed_pcie_rc_platform *platform;
> +	struct list_head ports;
> +
> +	u8 tx_tag;
> +	int host_bus_num;

Only needs a u8.

> +static int aspeed_pcie_port_init(struct aspeed_pcie_port *port)
> +{
> +	struct aspeed_pcie *pcie = port->pcie;
> +	struct device *dev = pcie->dev;
> +	int ret;
> +
> +	ret = clk_prepare_enable(port->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to set clock for slot (%d)\n",
> +				     port->slot);
> +
> +	ret = phy_init(port->phy);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to init phy pcie for slot (%d)\n",
> +				     port->slot);
> +
> +	ret = phy_set_mode_ext(port->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to set phy mode for slot (%d)\n",
> +				     port->slot);
> +
> +	reset_control_deassert(port->perst);
> +	mdelay(PCIE_RESET_CONFIG_WAIT_MS);

I think this should use msleep().

> +static int aspeed_ast2600_setup(struct platform_device *pdev)
> +{
> +	struct aspeed_pcie *pcie = platform_get_drvdata(pdev);
> +	struct device *dev = pcie->dev;
> +
> +	pcie->ahbc = syscon_regmap_lookup_by_phandle(dev->of_node,
> +						     "aspeed,ahbc");
> +	if (IS_ERR(pcie->ahbc))
> +		return dev_err_probe(dev, PTR_ERR(pcie->ahbc),
> +				     "failed to map ahbc base\n");
> +
> +	aspeed_host_reset(pcie);
> +
> +	regmap_write(pcie->ahbc, ASPEED_AHBC_KEY, ASPEED_AHBC_UNLOCK_KEY);
> +	regmap_update_bits(pcie->ahbc, ASPEED_AHBC_ADDR_MAPPING,
> +			   ASPEED_PCIE_RC_MEMORY_EN, ASPEED_PCIE_RC_MEMORY_EN);
> +	regmap_write(pcie->ahbc, ASPEED_AHBC_KEY, ASPEED_AHBC_UNLOCK);
> +
> +	/* Due to the BAR assignment is fixed mapping on 0x6000_0000.*/
> +	writel(ASPEED_AHB_REMAP_LO_ADDR(0x600) | ASPEED_AHB_MASK_LO_ADDR(0xe00),
> +	       pcie->reg + ASPEED_H2X_AHB_ADDR_CONFIG0);
> +	writel(ASPEED_AHB_REMAP_HI_ADDR(0),
> +	       pcie->reg + ASPEED_H2X_AHB_ADDR_CONFIG1);

I assume this ASPEED_H2X_AHB_ADDR_CONFIG is doing basically the same
thing as aspeed_ast2700_remap_pci_addr() below, so see the comments
there.

> +	writel(ASPEED_AHB_MASK_HI_ADDR(~0),
> +	       pcie->reg + ASPEED_H2X_AHB_ADDR_CONFIG2);
> +	writel(ASPEED_H2X_BRIDGE_EN, pcie->reg + ASPEED_H2X_CTRL);
> +
> +	writel(ASPEED_PCIE_RX_DMA_EN | ASPEED_PCIE_RX_LINEAR |
> +	       ASPEED_PCIE_RX_MSI_SEL | ASPEED_PCIE_RX_MSI_EN |
> +	       ASPEED_PCIE_WAIT_RX_TLP_CLR | ASPEED_PCIE_RC_RX_ENABLE |
> +	       ASPEED_PCIE_RC_ENABLE,
> +	       pcie->reg + ASPEED_H2X_DEV_CTRL);
> +
> +	writel(ASPEED_RC_TLP_TX_TAG_NUM, pcie->reg + ASPEED_H2X_DEV_TX_TAG);
> +
> +	pcie->host->ops = &aspeed_ast2600_pcie_ops;
> +	pcie->host->child_ops = &aspeed_ast2600_pcie_child_ops;
> +
> +	return 0;
> +}
> +
> +static int aspeed_ast2700_remap_pci_addr(struct aspeed_pcie *pcie)
> +{
> +	struct device_node *dev_node = pcie->dev->of_node;
> +	struct of_pci_range range;
> +	struct of_pci_range_parser parser;
> +	int ret;
> +
> +	ret = of_pci_range_parser_init(&parser, dev_node);
> +	if (ret)
> +		return ret;
> +
> +	for_each_of_pci_range(&parser, &range) {
> +		if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_MEM) {
> +			writel(ASPEED_REMAP_PCI_ADDR_31_12(range.pci_addr),
> +			       pcie->reg + ASPEED_H2X_REMAP_PCI_ADDR_LO);
> +			writel(ASPEED_REMAP_PCI_ADDR_63_32(range.pci_addr),
> +			       pcie->reg + ASPEED_H2X_REMAP_PCI_ADDR_HI);
> +			return 0;

It looks like this is essentially hardcoding the offset between the
parent-bus-address and the child-bus-address in the DT 'ranges'
property.  Since ASPEED_REMAP_PCI_ADDR_31_12() and
ASPEED_REMAP_PCI_ADDR_63_32() do nothing except mask out the low 12
bits, I assume that offset is zero.

But this should not be hard-coded at all; it should be extracted from
'ranges'.  I don't think we really have a consistent way of doing
this, but you can take a look at how these other drivers program
"outbound" mappings like this using bridge->windows:

  cdns_pcie_hpa_host_init_address_translation()
  dw_pcie_iatu_setup()
  mobiveil_host_init()
  xgene_pcie_map_ranges()
  iproc_pcie_map_ranges()
  rzg3s_pcie_parse_map_ranges()

> +static int aspeed_pcie_parse_dt(struct aspeed_pcie *pcie)
> +{
> +	struct device *dev = pcie->dev;
> +	struct device_node *node = dev->of_node;
> +	int ret;
> +
> +	for_each_available_child_of_node_scoped(node, child) {
> +		int slot;
> +		const char *type;
> +
> +		ret = of_property_read_string(child, "device_type", &type);
> +		if (ret || strcmp(type, "pci"))
> +			continue;
> +
> +		ret = of_pci_get_devfn(child);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "failed to parse devfn\n");
> +
> +		slot = PCI_SLOT(ret);
> +
> +		ret = aspeed_pcie_parse_port(pcie, child, slot);
> +		if (ret)
> +			return ret;

It looks unnecessarily complicated to put each port on a list in
aspeed_pcie_parse_port() and then iterate over that list in
aspeed_pcie_init_ports().

I think you could just do something like:

  aspeed_pcie_parse_port();
  aspeed_pcie_port_init();

and get rid of the list completely.

> +	}
> +
> +	if (list_empty(&pcie->ports))
> +		return dev_err_probe(dev, -ENODEV,
> +				     "No PCIe port found in DT\n");
> +
> +	return 0;
> +}
> +
> +static int aspeed_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *host;
> +	struct aspeed_pcie *pcie;
> +	struct resource_entry *entry;
> +	const struct aspeed_pcie_rc_platform *md;
> +	int irq, ret;
> +
> +	md = of_device_get_match_data(dev);
> +	if (!md)
> +		return -ENODEV;
> +
> +	host = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> +	if (!host)
> +		return -ENOMEM;
> +
> +	pcie = pci_host_bridge_priv(host);
> +	pcie->dev = dev;
> +	pcie->tx_tag = 0;
> +	platform_set_drvdata(pdev, pcie);
> +
> +	pcie->platform = md;
> +	pcie->host = host;
> +	INIT_LIST_HEAD(&pcie->ports);
> +
> +	/* Get root bus num for cfg command to decide tlp type 0 or type 1 */
> +	entry = resource_list_first_type(&host->windows, IORESOURCE_BUS);
> +	if (entry)
> +		pcie->host_bus_num = entry->res->start;

s/host_bus_num/root_bus_nr/   to match struct altera_pcie

