Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9BC2D180E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 19:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgLGSAB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 13:00:01 -0500
Received: from foss.arm.com ([217.140.110.172]:56974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgLGSAB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 13:00:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F1CC1042;
        Mon,  7 Dec 2020 09:59:14 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEEFE3F66B;
        Mon,  7 Dec 2020 09:59:07 -0800 (PST)
Date:   Mon, 7 Dec 2020 17:59:03 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     daire.mcnamara@microchip.com
Cc:     bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        david.abdurachmanov@gmail.com, cyril.jean@microchip.com,
        ben.dooks@codethink.co.uk
Subject: Re: [PATCH v18 3/4] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20201207175902.GA18363@e121166-lin.cambridge.arm.com>
References: <20201203121018.16432-1-daire.mcnamara@microchip.com>
 <20201203121018.16432-4-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203121018.16432-4-daire.mcnamara@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 03, 2020 at 12:10:17PM +0000, daire.mcnamara@microchip.com wrote:

[...]

> +static void mc_pcie_isr(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct mc_port *port = irq_desc_get_handler_data(desc);
> +	struct device *dev = port->dev;
> +	struct mc_msi *msi = &port->msi;
> +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
> +	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE1_CTRL_ADDR;
> +	u32 status;
> +	unsigned long intx_status;
> +	unsigned long msi_status;
> +	u32 bit;
> +	u32 virq;
> +
> +	/*
> +	 * The core provides a single interrupt for both INTx/MSI messages.
> +	 * So we'll read both INTx and MSI status.
> +	 */
> +	chained_irq_enter(chip, desc);
> +
> +	status = readl_relaxed(ctrl_base_addr + MC_SEC_ERROR_INT);
> +	if (status)
> +		writel_relaxed(status, ctrl_base_addr + MC_SEC_ERROR_INT);
> +
> +	status = readl_relaxed(ctrl_base_addr + MC_DED_ERROR_INT);
> +	if (status)
> +		writel_relaxed(status, ctrl_base_addr + MC_DED_ERROR_INT);
> +

This error management needs another level of multiplexing, see:

drivers/pci/controller/pcie-xilinx-cpm.c

to understand how to do it.

> +	/* Acknowledge L2 exit, hot reset exit, and DLUp exit interrrupts */
> +	status = readl_relaxed(ctrl_base_addr + MC_PCIE_EVENT_INT);
> +	if (status & GENMASK(15, 0))
> +		writel_relaxed(status, ctrl_base_addr + MC_PCIE_EVENT_INT);
> +
> +	status = readl_relaxed(bridge_base_addr + MC_ISTATUS_HOST);
> +	if (status)
> +		writel_relaxed(status, ctrl_base_addr + MC_ISTATUS_HOST);
> +
> +	status = readl_relaxed(bridge_base_addr + MC_ISTATUS_LOCAL);
> +	while (status & (PCI_INTS | MSI_INT)) {
> +		intx_status = (status & PCI_INTS) >> PM_MSI_INT_SHIFT;
> +		for_each_set_bit(bit, &intx_status, PCI_NUM_INTX) {
> +			virq = irq_find_mapping(port->intx_domain, bit + 1);
> +			if (virq)
> +				generic_handle_irq(virq);
> +			else
> +				dev_err_ratelimited(dev, "bad INTx IRQ %d\n", bit);
> +
> +			/* Clear that interrupt bit */
> +			writel_relaxed(1 << (bit + PM_MSI_INT_SHIFT), bridge_base_addr +
> +				       MC_ISTATUS_LOCAL);

This should be part of the INTX irq_chip.ack method.

> +		}
> +
> +		msi_status = (status & MSI_INT);
> +		if (msi_status) {
> +			msi_status = readl_relaxed(bridge_base_addr + MC_ISTATUS_MSI);
> +			for_each_set_bit(bit, &msi_status, msi->num_vectors) {
> +				virq = irq_find_mapping(msi->dev_domain, bit);
> +				if (virq)
> +					generic_handle_irq(virq);
> +				else
> +					dev_err_ratelimited(dev, "bad MSI IRQ %d\n", bit);
> +
> +				/* Clear that MSI interrupt bit */
> +				writel_relaxed((1 << bit), bridge_base_addr + MC_ISTATUS_MSI);

This should be part of the MSI irq_chip.ack method.

> +			}
> +			/* Clear the ISTATUS MSI bit */
> +			writel_relaxed(1 << MSI_INT_SHIFT, bridge_base_addr + MC_ISTATUS_LOCAL);
> +		}
> +
> +		status = readl_relaxed(bridge_base_addr + MC_ISTATUS_LOCAL);
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void mc_pcie_enable_msi(struct mc_port *port, void __iomem *base)
> +{
> +	struct mc_msi *msi = &port->msi;
> +	u32 cap_offset = MC_MSI_CAP_CTRL_OFFSET;
> +	u16 msg_ctrl = readw_relaxed(base + cap_offset + PCI_MSI_FLAGS);
> +
> +	msg_ctrl |= PCI_MSI_FLAGS_ENABLE;
> +	msg_ctrl &= ~PCI_MSI_FLAGS_QMASK;
> +	msg_ctrl |= MC_MSI_MAX_Q_AVAIL;
> +	msg_ctrl &= ~PCI_MSI_FLAGS_QSIZE;
> +	msg_ctrl |= MC_MSI_Q_SIZE;
> +	msg_ctrl |= PCI_MSI_FLAGS_64BIT;
> +
> +	writew_relaxed(msg_ctrl, base + cap_offset + PCI_MSI_FLAGS);
> +
> +	writel_relaxed(lower_32_bits(msi->vector_phy), base + cap_offset + PCI_MSI_ADDRESS_LO);
> +	writel_relaxed(upper_32_bits(msi->vector_phy), base + cap_offset + PCI_MSI_ADDRESS_HI);
> +}
> +
> +static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	struct mc_port *port = irq_data_get_irq_chip_data(data);
> +	phys_addr_t addr = port->msi.vector_phy;
> +
> +	msg->address_lo = lower_32_bits(addr);
> +	msg->address_hi = upper_32_bits(addr);
> +	msg->data = data->hwirq;
> +
> +	dev_dbg(port->dev, "msi#%x address_hi %#x address_lo %#x\n", (int)data->hwirq,
> +		msg->address_hi, msg->address_lo);
> +}
> +
> +static int mc_msi_set_affinity(struct irq_data *irq_data, const struct cpumask *mask, bool force)
> +{
> +	return -EINVAL;
> +}
> +
> +static struct irq_chip mc_msi_bottom_irq_chip = {
> +	.name = "Microchip MSI",
> +	.irq_compose_msi_msg = mc_compose_msi_msg,
> +	.irq_set_affinity = mc_msi_set_affinity,
> +};
> +
> +static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				   unsigned int nr_irqs, void *args)
> +{
> +	struct mc_port *port = domain->host_data;
> +	struct mc_msi *msi = &port->msi;
> +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
> +	unsigned long bit;
> +	u32 reg;
> +
> +	WARN_ON(nr_irqs != 1);

Explain why this WARN_ON is needed.

> +	mutex_lock(&msi->lock);
> +	bit = find_first_zero_bit(msi->used, msi->num_vectors);
> +	if (bit >= msi->num_vectors) {
> +		mutex_unlock(&msi->lock);
> +		return -ENOSPC;
> +	}
> +
> +	set_bit(bit, msi->used);
> +
> +	irq_domain_set_info(domain, virq, bit, &mc_msi_bottom_irq_chip, domain->host_data,
> +			    handle_simple_irq, NULL, NULL);

handle_edge_irq

> +
> +	/* Enable MSI interrupts */
> +	reg = readl_relaxed(bridge_base_addr + MC_IMASK_LOCAL);
> +	reg |= PCIE_ENABLE_MSI;
> +	writel_relaxed(reg, bridge_base_addr + MC_IMASK_LOCAL);
> +
> +	mutex_unlock(&msi->lock);
> +
> +	return 0;
> +}
> +
> +static void mc_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
> +				   unsigned int nr_irqs)
> +{
> +	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +	struct mc_port *port = irq_data_get_irq_chip_data(d);
> +	struct mc_msi *msi = &port->msi;
> +
> +	mutex_lock(&msi->lock);
> +
> +	if (test_bit(d->hwirq, msi->used))
> +		__clear_bit(d->hwirq, msi->used);
> +	else
> +		dev_err(port->dev, "trying to free unused MSI%lu\n", d->hwirq);
> +
> +	mutex_unlock(&msi->lock);
> +}
> +
> +static const struct irq_domain_ops msi_domain_ops = {
> +	.alloc	= mc_irq_msi_domain_alloc,
> +	.free	= mc_irq_msi_domain_free,
> +};
> +
> +static struct irq_chip mc_msi_irq_chip = {
> +	.name = "Microchip PCIe MSI",
> +	.irq_mask = pci_msi_mask_irq,
> +	.irq_unmask = pci_msi_unmask_irq,
> +};
> +
> +static struct msi_domain_info mc_msi_domain_info = {
> +	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_PCI_MSIX),
> +	.chip = &mc_msi_irq_chip,
> +};
> +
> +static int mc_allocate_msi_domains(struct mc_port *port)
> +{
> +	struct device *dev = port->dev;
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> +	struct mc_msi *msi = &port->msi;
> +
> +	mutex_init(&port->msi.lock);
> +
> +	msi->dev_domain = irq_domain_add_linear(NULL, msi->num_vectors, &msi_domain_ops, port);
> +	if (!msi->dev_domain) {
> +		dev_err(dev, "failed to create IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	msi->msi_domain = pci_msi_create_irq_domain(fwnode, &mc_msi_domain_info, msi->dev_domain);
> +	if (!msi->msi_domain) {
> +		dev_err(dev, "failed to create MSI domain\n");
> +		irq_domain_remove(msi->dev_domain);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void mc_mask_intx_irq(struct irq_data *data)
> +{
> +	struct mc_port *port = irq_data_get_irq_chip_data(data);
> +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
> +	unsigned long flags;
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&port->intx_mask_lock, flags);
> +	val = readl_relaxed(bridge_base_addr + MC_IMASK_LOCAL);
> +	val &= ~PCIE_LOCAL_INT_ENABLE;
> +	writel_relaxed(val, bridge_base_addr + MC_IMASK_LOCAL);
> +	raw_spin_unlock_irqrestore(&port->intx_mask_lock, flags);
> +}
> +
> +static void mc_unmask_intx_irq(struct irq_data *data)
> +{
> +	struct mc_port *port = irq_data_get_irq_chip_data(data);
> +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
> +	unsigned long flags;
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&port->intx_mask_lock, flags);
> +	val = readl_relaxed(bridge_base_addr + MC_IMASK_LOCAL);
> +	val |= PCIE_LOCAL_INT_ENABLE;
> +	writel_relaxed(val, bridge_base_addr + MC_IMASK_LOCAL);
> +	raw_spin_unlock_irqrestore(&port->intx_mask_lock, flags);
> +}
> +
> +static struct irq_chip mc_intx_irq_chip = {
> +	.name = "Microchip PCIe INTx",
> +	.irq_mask = mc_mask_intx_irq,
> +	.irq_unmask = mc_unmask_intx_irq,
> +};
> +
> +static int mc_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> +			    irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &mc_intx_irq_chip, handle_simple_irq);

handle_level_irq

Thanks,
Lorenzo

> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops intx_domain_ops = {
> +	.map = mc_pcie_intx_map,
> +};
> +
> +static int mc_pcie_init_irq_domains(struct mc_port *port)
> +{
> +	struct device *dev = port->dev;
> +	struct device_node *node = dev->of_node;
> +
> +	port->intx_domain = irq_domain_add_linear(node, PCI_NUM_INTX, &intx_domain_ops, port);
> +	if (!port->intx_domain) {
> +		dev_err(dev, "failed to get an INTx IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +	raw_spin_lock_init(&port->intx_mask_lock);
> +
> +	return mc_allocate_msi_domains(port);
> +}
> +
> +static void mc_setup_window(void __iomem *bridge_base_addr, u32 index, phys_addr_t axi_addr,
> +			    phys_addr_t pci_addr, size_t size)
> +{
> +	u32 atr_sz = ilog2(size) - 1;
> +	u32 val;
> +
> +	if (index == 0)
> +		val = PCIE_CONFIG_INTERFACE;
> +	else
> +		val = PCIE_TX_RX_INTERFACE;
> +
> +	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) + MC_ATR0_AXI4_SLV0_TRSL_PARAM);
> +
> +	val = lower_32_bits(axi_addr) | (atr_sz << ATR_SIZE_SHIFT) | ATR_IMPL_ENABLE;
> +	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
> +	       MC_ATR0_AXI4_SLV0_SRCADDR_PARAM);
> +
> +	val = upper_32_bits(axi_addr);
> +
> +	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
> +	       MC_ATR0_AXI4_SLV0_SRC_ADDR);
> +
> +	val = lower_32_bits(pci_addr);
> +	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
> +	       MC_ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
> +
> +	val = upper_32_bits(pci_addr);
> +	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
> +	       MC_ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
> +
> +	val = readl(bridge_base_addr + MC_ATR0_PCIE_WIN0_SRCADDR_PARAM);
> +	val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
> +	writel(val, bridge_base_addr + MC_ATR0_PCIE_WIN0_SRCADDR_PARAM);
> +	writel(0, bridge_base_addr + MC_ATR0_PCIE_WIN0_SRC_ADDR);
> +}
> +
> +static int mc_setup_windows(struct platform_device *pdev, struct mc_port *port)
> +{
> +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
> +	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
> +	struct resource_entry *entry;
> +	u64 pci_addr;
> +	u32 index = 1;
> +
> +	resource_list_for_each_entry(entry, &bridge->windows) {
> +		if (resource_type(entry->res) == IORESOURCE_MEM) {
> +			pci_addr = entry->res->start - entry->offset;
> +			mc_setup_window(bridge_base_addr, index, entry->res->start,
> +					pci_addr, resource_size(entry->res));
> +			index++;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static inline struct clk *mc_pcie_init_clk(struct device *dev, const char *id)
> +{
> +	struct clk *clk;
> +	int ret;
> +
> +	clk = devm_clk_get_optional(dev, id);
> +	if (IS_ERR(clk))
> +		return clk;
> +	if (!clk)
> +		return clk;
> +
> +	ret = clk_prepare_enable(clk);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare, clk);
> +
> +	return clk;
> +}
> +
> +static int mc_pcie_init_clks(struct device *dev)
> +{
> +	struct clk *fic;
> +	int i;
> +
> +	/*
> +	 * PCIe may be clocked via Fabric Interface
> +	 * using between 1 and 4 clocks. Scan DT for
> +	 * clocks and enable them if present
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(poss_clks); i++) {
> +		fic = mc_pcie_init_clk(dev, poss_clks[i]);
> +		if (IS_ERR(fic))
> +			return PTR_ERR(fic);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mc_platform_init(struct pci_config_window *cfg)
> +{
> +	struct device *dev = cfg->parent;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct mc_port *port;
> +	void __iomem *bridge_base_addr;
> +	void __iomem *ctrl_base_addr;
> +	int ret;
> +	int irq;
> +	u32 val;
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +	port->dev = dev;
> +
> +	ret = mc_pcie_init_clks(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to get clock resources, error %d\n", ret);
> +		return -ENODEV;
> +	}
> +
> +	port->axi_base_addr = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(port->axi_base_addr))
> +		return PTR_ERR(port->axi_base_addr);
> +
> +	bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
> +	ctrl_base_addr = port->axi_base_addr + MC_PCIE1_CTRL_ADDR;
> +
> +	port->msi.vector_phy = MC_MSI_ADDR;
> +	port->msi.num_vectors = MC_NUM_MSI_IRQS;
> +	ret = mc_pcie_init_irq_domains(port);
> +	if (ret) {
> +		dev_err(dev, "failed creating IRQ domains\n");
> +		return ret;
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "unable to request IRQ%d\n", irq);
> +		return -ENODEV;
> +	}
> +
> +	irq_set_chained_handler_and_data(irq, mc_pcie_isr, port);
> +
> +	/* Hardware doesn't setup MSI by default */
> +	mc_pcie_enable_msi(port, cfg->win);
> +
> +	val = PCIE_ENABLE_MSI | PCIE_LOCAL_INT_ENABLE;
> +	writel_relaxed(val, bridge_base_addr + MC_IMASK_LOCAL);
> +
> +	val = readl_relaxed(bridge_base_addr + MC_LTSSM_STATE);
> +	val |= LTSSM_L0_STATE;
> +	writel_relaxed(val, bridge_base_addr + MC_LTSSM_STATE);
> +
> +	val = ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS | ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS |
> +	      ECC_CONTROL_RX_RAM_ECC_BYPASS | ECC_CONTROL_TX_RAM_ECC_BYPASS;
> +	writel_relaxed(val, ctrl_base_addr + MC_ECC_CONTROL);
> +
> +	val = PCIE_EVENT_INT_L2_EXIT_INT | PCIE_EVENT_INT_HOTRST_EXIT_INT |
> +	      PCIE_EVENT_INT_DLUP_EXIT_INT | PCIE_EVENT_INT_L2_EXIT_INT_MASK |
> +	      PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK | PCIE_EVENT_INT_DLUP_EXIT_INT_MASK;
> +	writel_relaxed(val, ctrl_base_addr + MC_PCIE_EVENT_INT);
> +
> +	val = SEC_ERROR_INT_TX_RAM_SEC_ERR_INT | SEC_ERROR_INT_RX_RAM_SEC_ERR_INT |
> +	      SEC_ERROR_INT_PCIE2AXI_RAM_SEC_ERR_INT | SEC_ERROR_INT_AXI2PCIE_RAM_SEC_ERR_INT;
> +	writel_relaxed(val, ctrl_base_addr + MC_SEC_ERROR_INT);
> +	writel_relaxed(val, ctrl_base_addr + MC_SEC_ERROR_INT_MASK);
> +
> +	val = DED_ERROR_INT_TX_RAM_DED_ERR_INT | DED_ERROR_INT_RX_RAM_DED_ERR_INT |
> +	      DED_ERROR_INT_PCIE2AXI_RAM_DED_ERR_INT | DED_ERROR_INT_AXI2PCIE_RAM_DED_ERR_INT;
> +	writel_relaxed(val, ctrl_base_addr + MC_DED_ERROR_INT);
> +	writel_relaxed(val, ctrl_base_addr + MC_DED_ERROR_INT_MASK);
> +
> +	writel_relaxed(0, bridge_base_addr + MC_IMASK_LOCAL);
> +	writel_relaxed(GENMASK(31, 0), bridge_base_addr + MC_ISTATUS_LOCAL);
> +	writel_relaxed(0, bridge_base_addr + MC_IMASK_HOST);
> +	writel_relaxed(GENMASK(31, 0), bridge_base_addr + MC_ISTATUS_HOST);
> +
> +	/* Configure Address Translation Table 0 for PCIe config space */
> +	mc_setup_window(bridge_base_addr, 0, cfg->res.start & 0xffffffff, cfg->res.start,
> +			resource_size(&cfg->res));
> +
> +	return mc_setup_windows(pdev, port);
> +}
> +
> +static const struct pci_ecam_ops mc_ecam_ops = {
> +	.bus_shift = 20,
> +	.init = mc_platform_init,
> +	.pci_ops = {
> +		.map_bus = pci_ecam_map_bus,
> +		.read = pci_generic_config_read,
> +		.write = pci_generic_config_write,
> +	}
> +};
> +
> +static const struct of_device_id mc_pcie_of_match[] = {
> +	{
> +		.compatible = "microchip,pcie-host-1.0",
> +		.data = &mc_ecam_ops,
> +	},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, mc_pcie_of_match)
> +
> +static struct platform_driver mc_pcie_driver = {
> +	.probe = pci_host_common_probe,
> +	.driver = {
> +		.name = "microchip-pcie",
> +		.of_match_table = mc_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +
> +builtin_platform_driver(mc_pcie_driver);
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Microchip PCIe host controller driver");
> +MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
> -- 
> 2.25.1
> 
