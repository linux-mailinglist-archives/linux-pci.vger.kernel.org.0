Return-Path: <linux-pci+bounces-32179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C06EB06434
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 18:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF0317DBCD
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEFD25B2E3;
	Tue, 15 Jul 2025 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR3VD95Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4D824A046;
	Tue, 15 Jul 2025 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596524; cv=none; b=eB/HMd+UfD199pRpkKZmKMewZO+SX1kmxp+o6xFSgxgPw310zhRtP3Q+x4F8Ydf8C0svT/P7OQGf1u05qf3faoMdcsDAlqS7vdiAJVE392jY5ZIXkwAha671Q+GEM9flJMyr9lYrH9Hf1FZRUxlBVdvw4xHV1Gc1arcLCkM4xn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596524; c=relaxed/simple;
	bh=u310Nv0TTSmrAw9bDnhIdTxtEajmYNZCrXPY9pUor00=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=diZHi4rtIQbLKAA28F5S0/xjgwQRZ81TTiS5PPqDUjJzvvfTdjL8JcyF65g0q2S4n7swVQNLaSwTvFrb2ftDm5alp9eYUAUok4ELMNlIRIqjjrHRy9qjG/xqOQF4fE11FZh3qQ0RISQYVqpW3oEtHcLiYXerGrCYIPTjCzQRX+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR3VD95Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0366C4CEE3;
	Tue, 15 Jul 2025 16:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752596524;
	bh=u310Nv0TTSmrAw9bDnhIdTxtEajmYNZCrXPY9pUor00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NR3VD95Yvb+09l1Ono8RstxamEHXjlq3aGDgKaXLwqP0oCSvWazeEmmZW8tG0uFPH
	 vhsc47LI1FF2JV/K/oc5O6quY/FsfzPr7whmtlG72L8cdqJI5//jW5EqXDuO4RRQ/F
	 85b++WpUVacJAQI+v/nQEGUNTJwEe4xvWw0McaMMgyArXEwihKQVaHdHC/1GNgg50V
	 TjeV0X+ydV458EzA+sDNDX/8GWeONddySKj8wbI6krCTz29QeJ6WrUbWLlFKYAVcWZ
	 Il8LD2vy1NP1r1lWBi0XJYYfrALS7coodOIJbutrTjHCmTk1mGqrG6/8AqOddkUmuG
	 DqENOqX8Ph4Dg==
Date: Tue, 15 Jul 2025 11:22:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
	p.zabel@pengutronix.de, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2 09/10] PCI: aspeed: Add ASPEED PCIe RC driver
Message-ID: <20250715162202.GA2461591@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715034320.2553837-10-jacky_chou@aspeedtech.com>

v1 posting was
https://lore.kernel.org/r/20250613033001.3153637-1-jacky_chou@aspeedtech.com
Links to previous postings are helpful in the cover letter.

On Tue, Jul 15, 2025 at 11:43:19AM +0800, Jacky Chou wrote:
> Introduce PCIe Root Complex driver for ASPEED SoCs. Support RC
> initialization, reset, clock, IRQ domain, and MSI domain setup.
> Implement platform-specific setup and register configuration for
> ASPEED. And provide PCI config space read/write and INTx/MSI
> interrupt handling.

> +config PCIE_ASPEED
> +	bool "ASPEED PCIe controller"
> +	depends on ARCH_ASPEED || COMPILE_TEST
> +	depends on OF
> +	select PCI_MSI_ARCH_FALLBACKS
> +	help
> +	  Enable this option to add support for the PCIe controller
> +	  found on ASPEED SoCs.
> +	  This driver provides initialization and management for PCIe
> +	  Root Complex functionality, including interrupt and MSI support.
> +	  Select Y if your platform uses an ASPEED SoC and requires PCIe
> +	  connectivity.

Add blank line between paragraphs or reflow into single paragraph
(mentioned before).

Alphabetize this entry by the menu item ("ASPEED PCIe controller",
"ARM Versatile PB PCI controller").

>  config PCI_VERSATILE
>  	bool "ARM Versatile PB PCI controller"
>  	depends on ARCH_VERSATILE || COMPILE_TEST

> +#define MAX_MSI_HOST_IRQS	64
> +#define PCIE_RESET_CONFIG_DEVICE_WAIT_MS	500

Where does this value come from?  Is there a generic value from
drivers/pci/pci.h you can use?

> +#define PCIE_RESET_CONFIG_RC_WAIT_MS		10

Ditto.  If it's an Aspeed-specific value, can you point to the source
in the Aspeed datasheet?

> +#define CRG0_READ_FMTTYPE                                                      \
> +	FIELD_PREP(GENMASK(31, 24), PCIE_TLP_FMT_TYPE(PCI_TLP_FMT_3DW_NO_DATA, \
> +						      PCI_TLP_TYPE_CFG0_RD))
> +#define CRG0_WRITE_FMTTYPE                                                  \
> +	FIELD_PREP(GENMASK(31, 24), PCIE_TLP_FMT_TYPE(PCI_TLP_FMT_3DW_DATA, \
> +						      PCI_TLP_TYPE_CFG0_WR))
> +#define CRG1_READ_FMTTYPE                                                      \
> +	FIELD_PREP(GENMASK(31, 24), PCIE_TLP_FMT_TYPE(PCI_TLP_FMT_3DW_NO_DATA, \
> +						      PCI_TLP_TYPE_CFG1_RD))
> +#define CRG1_WRITE_FMTTYPE                                                  \
> +	FIELD_PREP(GENMASK(31, 24), PCIE_TLP_FMT_TYPE(PCI_TLP_FMT_3DW_DATA, \
> +						      PCI_TLP_TYPE_CFG1_WR))

Looks like a #define for GENMASK(31, 24) might make sense?

> + * struct aspeed_pcie_port - PCIe port information
> + * @list: port list
> + * @pcie: pointer to PCIe host info
> + * @clk: pointer to the port clock gate
> + * @phy: pointer to PHY control block
> + * @perst: pointer to port reset control
> + * @slot: port slot
> + */
> +struct aspeed_pcie_port {
> +	struct list_head list;
> +	struct aspeed_pcie *pcie;
> +	struct clk *clk;
> +	struct regmap *pciephy;
> +	struct reset_control *perst;
> +	u32 slot;
> +};
> +
> +/**
> + * struct aspeed_pcie - PCIe port information

I think aspeed_pcie_port is for a Root Port; this looks like it might
be for the Root Complex as a whole.

> + * @host: pointer to pcie host bridge

s/pcie/PCIe/

> + * @dev: pointer to device structure
> + * @reg: PCIe Host register base address
> + * @ahbc: pointer to AHHC register map
> + * @cfg: pointer to Aspeed PCIe configuration register map
> + * @platform: platform specific information
> + * @ports: list of PCIe ports
> + * @domain: PCI domain number
> + * @tx_tag: current TX tag for the port
> + * @h2xrst: pointer to H2X reset control
> + * @irq_domain: IRQ domain for INTx interrupts
> + * @dev_domain: IRQ domain for device interrupts
> + * @msi_domain: IRQ domain for MSI interrupts
> + * @lock: mutex to protect MSI bitmap variable
> + * @msi_irq_in_use: bitmap to track used MSI host IRQs
> + */
> +struct aspeed_pcie {
> +	struct pci_host_bridge *host;
> +	struct device *dev;
> +	void __iomem *reg;
> +	struct regmap *ahbc;
> +	struct regmap *cfg;
> +	const struct aspeed_pcie_rc_platform *platform;
> +	struct list_head ports;
> +
> +	int domain;
> +	u8 tx_tag;
> +
> +	struct reset_control *h2xrst;
> +
> +	struct irq_domain *irq_domain;

Name "intx_domain" to remove ambiguity.

> +	struct irq_domain *dev_domain;
> +	struct irq_domain *msi_domain;
> +	struct mutex lock;		/* Protect MSI bitmap variable */
> +	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_HOST_IRQS);
> +};

> +static void aspeed_pcie_intx_irq_ack(struct irq_data *d)
> +{
> +	struct aspeed_pcie *pcie = irq_data_get_irq_chip_data(d);
> +	int intx_en = pcie->platform->reg_intx_en;
> +	u32 en;
> +
> +	en = readl(pcie->reg + intx_en);
> +	en |= BIT(d->hwirq);
> +	writel(en, pcie->reg + intx_en);
> +}
> +
> +static void aspeed_pcie_intx_irq_mask(struct irq_data *d)
> +{
> +	struct aspeed_pcie *pcie = irq_data_get_irq_chip_data(d);
> +	int intx_en = pcie->platform->reg_intx_en;
> +	u32 en;
> +
> +	en = readl(pcie->reg + intx_en);
> +	en |= BIT(d->hwirq);
> +	writel(en, pcie->reg + intx_en);
> +}
> +
> +static void aspeed_pcie_intx_irq_unmask(struct irq_data *d)
> +{
> +	struct aspeed_pcie *pcie = irq_data_get_irq_chip_data(d);
> +	int intx_en = pcie->platform->reg_intx_en;
> +	u32 en;
> +
> +	en = readl(pcie->reg + intx_en);
> +	en |= BIT(d->hwirq);
> +	writel(en, pcie->reg + intx_en);
> +}

aspeed_pcie_intx_irq_ack(), aspeed_pcie_intx_irq_mask(), and
aspeed_pcie_intx_irq_unmask() all look identical.  Am I missing
something?

> +static struct irq_chip aspeed_intx_irq_chip = {
> +	.name = "IntX",

"INTx" (mentioned before).

> +static irqreturn_t aspeed_pcie_intr_handler(int irq, void *dev_id)
> +{
> +	struct aspeed_pcie *pcie = dev_id;
> +	const struct aspeed_pcie_rc_platform *platform = pcie->platform;
> +	unsigned long status;
> +	unsigned long intx;

Looks like status and intx should both be u32?

> +	u32 bit;
> +	int i;
> +
> +	intx = readl(pcie->reg + platform->reg_intx_sts) & PCIE_INTX_STS;

Use FIELD_GET() to avoid assumption that PCIE_INTX_STS starts at
bit 0.

> +	for_each_set_bit(bit, &intx, PCI_NUM_INTX)
> +		generic_handle_domain_irq(pcie->irq_domain, bit);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		for (i = 0; i < 2; i++) {
> +			status = readl(pcie->reg + platform->reg_msi_sts + (i * 4));
> +			writel(status, pcie->reg + platform->reg_msi_sts + (i * 4));
> +
> +			for_each_set_bit(bit, &status, 32) {
> +				bit += (i * 32);
> +				generic_handle_domain_irq(pcie->dev_domain, bit);
> +			}
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}

> +static int aspeed_ast2600_rd_conf(struct pci_bus *bus, unsigned int devfn,
> +				  int where, int size, u32 *val)
> +{
> +	int slot = PCI_SLOT(devfn);
> +
> +	if (slot != 0 && slot != 8)
> +		return PCIBIOS_DEVICE_NOT_FOUND;

I previously asked for a hint about why certain device addresses
aren't valid.  I meant a comment with a hint so the same question
doesn't arise every time.

> +	return aspeed_ast2600_conf(bus, devfn, where, size, val, CRG0_READ_FMTTYPE, false);
> +}

> +static bool aspeed_ast2700_get_link(struct aspeed_pcie_port *port)
> +{
> +	u32 reg;
> +
> +	/* AST2700 has Gen2 and Gen4 RCs.
> +	 * Read register to distinguish between Gen2 or Gen4.
> +	 * Then read the corresonding register that is from Aspeed
> +	 * design to get whether it linked up or not.
> +	 */

Comment style is:

  /*
   * Text ...
   */

Add blank line between paragraphs or reflow to a single paragraph.

s/corresonding/corresponding/

"that is from Aspeed design" seems unnecessary.

> +static int aspeed_ast2700_child_config(struct pci_bus *bus, unsigned int devfn,
> +				       int where, int size, u32 *val,
> +				       bool write)
> +{
> +	struct aspeed_pcie *pcie = bus->sysdata;
> +	u32 bdf_offset, status, cfg_val;
> +	int ret;
> +
> +	bdf_offset = aspeed_pcie_get_bdf_offset(bus, devfn, where);
> +
> +	cfg_val = CRG_PAYLOAD_SIZE;
> +	if (write)
> +		cfg_val |= (bus->number == 1) ? CRG0_WRITE_FMTTYPE : CRG1_WRITE_FMTTYPE;
> +	else
> +		cfg_val |= (bus->number == 1) ? CRG0_READ_FMTTYPE : CRG1_READ_FMTTYPE;

I don't think you should assume that bus 0 is the root bus.  The root
bus number should come from the DT bus-range.

> +static int aspeed_ast2700_rd_conf(struct pci_bus *bus, unsigned int devfn,
> +				  int where, int size, u32 *val)
> +{
> +	if (devfn != 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;

Another good place for a hint about why this restriction exists.

> +static int aspeed_pcie_msi_init(struct aspeed_pcie *pcie)
> +{
> +	int ret = 0;
> +
> +	writel(~0, pcie->reg + pcie->platform->reg_msi_en);
> +	writel(~0, pcie->reg + pcie->platform->reg_msi_en + 0x04);
> +	writel(~0, pcie->reg + pcie->platform->reg_msi_sts);
> +	writel(~0, pcie->reg + pcie->platform->reg_msi_sts + 0x04);
> +
> +	pcie->dev_domain =
> +		irq_domain_add_linear(NULL, MAX_MSI_HOST_IRQS, &aspeed_msi_domain_ops, pcie);
> +	if (!pcie->dev_domain)
> +		return dev_err_probe(pcie->dev, -ENOMEM, "failed to create IRQ domain\n");
> +
> +	pcie->msi_domain = pci_msi_create_irq_domain(dev_fwnode(pcie->dev), &aspeed_msi_domain_info,
> +						     pcie->dev_domain);
> +	if (!pcie->msi_domain)
> +		return dev_err_probe(pcie->dev, -ENOMEM, "failed to create MSI domain\n");

Can you please rework this to follow what Nam Cao is doing for
existing drivers:
https://lore.kernel.org/r/cover.1750858083.git.namcao@linutronix.de

> +static int aspeed_ast2700_setup(struct platform_device *pdev)
> +{
> +	struct aspeed_pcie *pcie = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	regmap_update_bits(pcie->cfg, SCU_60,
> +			   RC_E2M_PATH_EN | RC_H2XS_PATH_EN | RC_H2XD_PATH_EN | RC_H2XX_PATH_EN |
> +			   RC_UPSTREAM_MEM_EN,
> +			   RC_E2M_PATH_EN | RC_H2XS_PATH_EN | RC_H2XD_PATH_EN | RC_H2XX_PATH_EN |
> +			   RC_UPSTREAM_MEM_EN);
> +	regmap_write(pcie->cfg, SCU_64,
> +		     RC0_DECODE_DMA_BASE(0) | RC0_DECODE_DMA_LIMIT(0xFF) | RC1_DECODE_DMA_BASE(0) |
> +		     RC1_DECODE_DMA_LIMIT(0xFF));
> +	regmap_write(pcie->cfg, SCU_70, DISABLE_EP_FUNC);
> +
> +	aspeed_host_reset(pcie);
> +
> +	writel(0, pcie->reg + H2X_CTRL);
> +	writel(H2X_BRIDGE_EN | H2X_BRIDGE_DIRECT_EN, pcie->reg + H2X_CTRL);
> +
> +	ret = aspeed_ast2700_bar_assign(pcie);
> +	if (ret)
> +		return dev_err_probe(pcie->dev, ret, "Failed to assign bar\n");

s/bar/BAR/ in the message since it's an acronym.

> +	/* Prepare for 64-bit BAR pref */
> +	writel(REMAP_PREF_ADDR_63_32(0x3), pcie->reg + H2X_REMAP_PREF_ADDR);
> +
> +	pcie->host->ops = &aspeed_ast2700_pcie_ops;
> +	pcie->host->child_ops = &aspeed_ast2700_pcie_child_ops;
> +
> +	return 0;
> +}

> +static int aspeed_pcie_parse_port(struct aspeed_pcie *pcie,
> +				  struct device_node *node,
> +				  int slot)
> +{
> +	struct aspeed_pcie_port *port;
> +	struct device *dev = pcie->dev;
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->pciephy = syscon_regmap_lookup_by_phandle(node, "aspeed,pciephy");
> +	if (IS_ERR(port->pciephy))
> +		return dev_err_probe(dev, PTR_ERR(port->pciephy),
> +				     "Failed to map pcie%d pciephy base\n", slot);
> +
> +	port->clk = devm_get_clk_from_child(dev, node, NULL);
> +	if (IS_ERR(port->clk))
> +		return dev_err_probe(dev, PTR_ERR(port->clk),
> +				     "Failed to get pcie%d clock\n", slot);
> +
> +	port->perst = of_reset_control_get_exclusive(node, "perst");
> +	if (IS_ERR(port->perst))
> +		return dev_err_probe(dev, PTR_ERR(port->perst),
> +				     "Failed to get pcie%d reset control\n", slot);

Driver messages are inconsistently capitalized.

> +	reset_control_assert(port->perst);
> +
> +	port->slot = slot;
> +	port->pcie = pcie;
> +
> +	INIT_LIST_HEAD(&port->list);
> +	list_add_tail(&port->list, &pcie->ports);
> +
> +	return 0;
> +}

> +static int aspeed_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *host;
> +	struct aspeed_pcie *pcie;
> +	struct aspeed_pcie_port *port;
> +	struct device_node *node = dev->of_node;
> +	const struct aspeed_pcie_rc_platform *md = of_device_get_match_data(dev);
> +	int irq, ret;
> +
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
> +	pcie->reg = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pcie->reg))
> +		return PTR_ERR(pcie->reg);
> +
> +	of_property_read_u32(node, "linux,pci-domain", &pcie->domain);

Normally not needed in a controller driver.  See
of_get_pci_domain_nr() and related interfaces.

> +	pcie->cfg = syscon_regmap_lookup_by_phandle(dev->of_node, "aspeed,pciecfg");
> +	if (IS_ERR(pcie->cfg))
> +		return dev_err_probe(dev, PTR_ERR(pcie->cfg), "Failed to map pciecfg base\n");
> +
> +	pcie->h2xrst = devm_reset_control_get_exclusive(dev, "h2x");
> +	if (IS_ERR(pcie->h2xrst))
> +		return dev_err_probe(dev, PTR_ERR(pcie->h2xrst), "Failed to get h2x reset\n");
> +
> +	ret = devm_mutex_init(dev, &pcie->lock);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to init mutex\n");
> +
> +	ret = pcie->platform->setup(pdev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to setup PCIe RC\n");
> +
> +	ret = aspeed_pcie_parse_dt(pcie);
> +	if (ret)
> +		return ret;
> +
> +	ret = aspeed_pcie_init_ports(pcie);
> +	if (ret)
> +		goto err_remove_resets;
> +
> +	host->sysdata = pcie;
> +
> +	ret = aspeed_pcie_init_irq_domain(pcie);
> +	if (ret)
> +		goto err_irq_init;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		ret = irq;
> +		goto err_irq;
> +	}
> +
> +	ret = devm_request_irq(dev, irq, aspeed_pcie_intr_handler, IRQF_SHARED, dev_name(dev),
> +			       pcie);

Most of this file is formatted to fit in 80 columns; would be nice to
make the few outliers also fit.

> +	if (ret)
> +		goto err_irq;
> +
> +	ret = pci_host_probe(host);
> +	if (ret)
> +		goto err_irq;
> +
> +	return 0;
> +err_irq:
> +	aspeed_pcie_irq_domain_free(pcie);
> +err_irq_init:
> +err_remove_resets:
> +	list_for_each_entry(port, &pcie->ports, list)
> +		reset_control_put(port->perst);
> +	dev_err_probe(dev, ret, "Failed to initial RC\n");
> +	return ret;
> +}
> +
> +const struct aspeed_pcie_rc_platform pcie_rc_ast2600 = {
> +	.setup = aspeed_ast2600_setup,
> +	.get_link = aspeed_ast2600_get_link,
> +	.port_init = aspeed_ast2600_port_init,
> +	.reg_intx_en = 0x04,
> +	.reg_intx_sts = 0x08,
> +	.reg_msi_en = 0x20,
> +	.reg_msi_sts = 0x28,
> +	.msi_address = 0x1e77005c,

Capitalize hex numbers consistently.  It appears upper-case is the
convention in this file.

> +};
> +
> +const struct aspeed_pcie_rc_platform pcie_rc_ast2700 = {
> +	.setup = aspeed_ast2700_setup,
> +	.get_link = aspeed_ast2700_get_link,
> +	.port_init = aspeed_ast2700_port_init,
> +	.reg_intx_en = 0x40,
> +	.reg_intx_sts = 0x48,
> +	.reg_msi_en = 0x50,
> +	.reg_msi_sts = 0x58,
> +	.msi_address = 0x000000F0,
> +};

Bjorn

