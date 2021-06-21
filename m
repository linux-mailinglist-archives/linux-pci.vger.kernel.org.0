Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDED3AF10B
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 18:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhFUQ5L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 12:57:11 -0400
Received: from foss.arm.com ([217.140.110.172]:37818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233109AbhFUQzi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 12:55:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B8811042;
        Mon, 21 Jun 2021 09:53:24 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB9A13F694;
        Mon, 21 Jun 2021 09:53:22 -0700 (PDT)
Date:   Mon, 21 Jun 2021 17:53:12 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     srikanth.thokala@intel.com, maz@kernel.org
Cc:     robh+dt@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, kw@linux.com
Subject: Re: [PATCH v10 2/2] PCI: keembay: Add support for Intel Keem Bay
Message-ID: <20210621162506.GA31511@lpieralisi>
References: <20210607154044.26074-1-srikanth.thokala@intel.com>
 <20210607154044.26074-3-srikanth.thokala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607154044.26074-3-srikanth.thokala@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Marc]

On Mon, Jun 07, 2021 at 09:10:44PM +0530, srikanth.thokala@intel.com wrote:
[...]

> +static void keembay_pcie_msi_irq_handler(struct irq_desc *desc)
> +{
> +	struct keembay_pcie *pcie = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	u32 val, mask, status;
> +	struct pcie_port *pp;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	pp = &pcie->pci.pp;
> +	val = readl(pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
> +	mask = readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> +
> +	status = val & mask;
> +
> +	if (status & MSI_CTRL_INT) {
> +		dw_handle_msi_irq(pp);
> +		writel(status, pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static int keembay_pcie_setup_msi_irq(struct keembay_pcie *pcie)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct device *dev = pci->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int irq;
> +
> +	irq = platform_get_irq_byname(pdev, "pcie");
> +	if (irq < 0)
> +		return irq;
> +
> +	irq_set_chained_handler_and_data(irq, keembay_pcie_msi_irq_handler,
> +					 pcie);
> +

Ok this is yet another DWC MSI incantation and given that Marc worked
hard consolidating them let's have a look before we merge it.

IIUC - this IP relies on the DWC logic to handle MSIs + custom
registers to detect a pending MSI IRQ because the logic in
dw_chained_msi_irq() is *not* enough so you have to register
a driver specific chained handler. This looks similar to the dra7xx
driver MSI handling but I am not entirely convinced it is needed.

I assume this code in keembay_pcie_msi_irq_handler() is required
owing to additional IP logic on top of the standard DWC IP, in
particular the PCIE_REGS_INTERRUPT_STATUS write to "clear" the
IRQ.

We need more insights before merging it so please provide them.

pp = &pcie->pci.pp;
val = readl(pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
mask = readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);

status = val & mask;

if (status & MSI_CTRL_INT) {
	dw_handle_msi_irq(pp);
	writel(status, pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
}

Thanks,
Lorenzo

> +static void keembay_pcie_ep_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct keembay_pcie *pcie = dev_get_drvdata(pci->dev);
> +
> +	writel(EDMA_INT_EN, pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> +}
> +
> +static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> +				     enum pci_epc_irq_type type,
> +				     u16 interrupt_num)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_EPC_IRQ_LEGACY:
> +		/* Legacy interrupts are not supported in Keem Bay */
> +		dev_err(pci->dev, "Legacy IRQ is not supported\n");
> +		return -EINVAL;
> +	case PCI_EPC_IRQ_MSI:
> +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> +	case PCI_EPC_IRQ_MSIX:
> +		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
> +	default:
> +		dev_err(pci->dev, "Unknown IRQ type %d\n", type);
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct pci_epc_features keembay_pcie_epc_features = {
> +	.linkup_notifier	= false,
> +	.msi_capable		= true,
> +	.msix_capable		= true,
> +	.reserved_bar		= BIT(BAR_1) | BIT(BAR_3) | BIT(BAR_5),
> +	.bar_fixed_64bit	= BIT(BAR_0) | BIT(BAR_2) | BIT(BAR_4),
> +	.align			= SZ_16K,
> +};
> +
> +static const struct pci_epc_features *
> +keembay_pcie_get_features(struct dw_pcie_ep *ep)
> +{
> +	return &keembay_pcie_epc_features;
> +}
> +
> +static const struct dw_pcie_ep_ops keembay_pcie_ep_ops = {
> +	.ep_init	= keembay_pcie_ep_init,
> +	.raise_irq	= keembay_pcie_ep_raise_irq,
> +	.get_features	= keembay_pcie_get_features,
> +};
> +
> +static const struct dw_pcie_host_ops keembay_pcie_host_ops = {
> +};
> +
> +static int keembay_pcie_add_pcie_port(struct keembay_pcie *pcie,
> +				      struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct pcie_port *pp = &pci->pp;
> +	struct device *dev = &pdev->dev;
> +	u32 val;
> +	int ret;
> +
> +	pp->ops = &keembay_pcie_host_ops;
> +	pp->msi_irq = -ENODEV;
> +
> +	ret = keembay_pcie_setup_msi_irq(pcie);
> +	if (ret)
> +		return ret;
> +
> +	pcie->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(pcie->reset))
> +		return PTR_ERR(pcie->reset);
> +
> +	ret = keembay_pcie_probe_clocks(pcie);
> +	if (ret)
> +		return ret;
> +
> +	val = readl(pcie->apb_base + PCIE_REGS_PCIE_PHY_CNTL);
> +	val |= PHY0_SRAM_BYPASS;
> +	writel(val, pcie->apb_base + PCIE_REGS_PCIE_PHY_CNTL);
> +
> +	writel(PCIE_DEVICE_TYPE, pcie->apb_base + PCIE_REGS_PCIE_CFG);
> +
> +	ret = keembay_pcie_pll_init(pcie);
> +	if (ret)
> +		return ret;
> +
> +	val = readl(pcie->apb_base + PCIE_REGS_PCIE_CFG);
> +	writel(val | PCIE_RSTN, pcie->apb_base + PCIE_REGS_PCIE_CFG);
> +	keembay_ep_reset_deassert(pcie);
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		keembay_ep_reset_assert(pcie);
> +		dev_err(dev, "Failed to initialize host: %d\n", ret);
> +		return ret;
> +	}
> +
> +	val = readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		val |= MSI_CTRL_INT_EN;
> +	writel(val, pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> +
> +	return 0;
> +}
> +
> +static int keembay_pcie_probe(struct platform_device *pdev)
> +{
> +	const struct keembay_pcie_of_data *data;
> +	struct device *dev = &pdev->dev;
> +	struct keembay_pcie *pcie;
> +	struct dw_pcie *pci;
> +	enum dw_pcie_device_mode mode;
> +
> +	data = device_get_match_data(dev);
> +	if (!data)
> +		return -ENODEV;
> +
> +	mode = (enum dw_pcie_device_mode)data->mode;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pci = &pcie->pci;
> +	pci->dev = dev;
> +	pci->ops = &keembay_pcie_ops;
> +
> +	pcie->mode = mode;
> +
> +	pcie->apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
> +	if (IS_ERR(pcie->apb_base))
> +		return PTR_ERR(pcie->apb_base);
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	switch (pcie->mode) {
> +	case DW_PCIE_RC_TYPE:
> +		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_HOST))
> +			return -ENODEV;
> +
> +		return keembay_pcie_add_pcie_port(pcie, pdev);
> +	case DW_PCIE_EP_TYPE:
> +		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_EP))
> +			return -ENODEV;
> +
> +		pci->ep.ops = &keembay_pcie_ep_ops;
> +		return dw_pcie_ep_init(&pci->ep);
> +	default:
> +		dev_err(dev, "Invalid device type %d\n", pcie->mode);
> +		return -ENODEV;
> +	}
> +}
> +
> +static const struct keembay_pcie_of_data keembay_pcie_rc_of_data = {
> +	.mode = DW_PCIE_RC_TYPE,
> +};
> +
> +static const struct keembay_pcie_of_data keembay_pcie_ep_of_data = {
> +	.mode = DW_PCIE_EP_TYPE,
> +};
> +
> +static const struct of_device_id keembay_pcie_of_match[] = {
> +	{
> +		.compatible = "intel,keembay-pcie",
> +		.data = &keembay_pcie_rc_of_data,
> +	},
> +	{
> +		.compatible = "intel,keembay-pcie-ep",
> +		.data = &keembay_pcie_ep_of_data,
> +	},
> +	{}
> +};
> +
> +static struct platform_driver keembay_pcie_driver = {
> +	.driver = {
> +		.name = "keembay-pcie",
> +		.of_match_table = keembay_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe  = keembay_pcie_probe,
> +};
> +builtin_platform_driver(keembay_pcie_driver);
> -- 
> 2.17.1
> 
