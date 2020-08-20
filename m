Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC2F24C518
	for <lists+linux-pci@lfdr.de>; Thu, 20 Aug 2020 20:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHTSKX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 14:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgHTSKV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Aug 2020 14:10:21 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2827120758;
        Thu, 20 Aug 2020 18:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597947020;
        bh=Xz7+J4YXfIOcYj9qIJqviJzqUAQn9cy7fLC4U9Dy87o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H8PQZ0ggSnM9fon3QHenKERbysvEgkei4OOjundnwg6vvABTV5ymF65Gus0H75yhB
         K5IwahiB5V1R9130f9+JW/oLLlzVmGwRaPqm9l1a5GqC60bo4ag6CvkapofNFjvusw
         J0Bi98zS86W/Pdxn7b2fFlwdOZ+SznYaCJJ8Ms8o=
Date:   Thu, 20 Aug 2020 13:10:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daire.McNamara@microchip.com
Cc:     robh@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, david.abdurachmanov@gmail.com
Subject: Re: [PATCH v15 2/2] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20200820181018.GA1551400@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d007193ce73677713436c39684602f679d7623e4.camel@microchip.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 19, 2020 at 04:33:10PM +0000, Daire.McNamara@microchip.com wrote:

> + *	pcie-altera.c
> + */

Add a blank line here.

> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/module.h>

> +static struct mc_port *port;

This file scope item is not ideal.  It might work in your situation if
you can never have more than one device, but it's not a pattern we
want other people to copy.

I think I sort of see how it works:

  mc_pci_host_probe
    pci_host_common_probe
      ops = of_device_get_match_data()              # mc_ecam_ops
      gen_pci_init(..., ops)
        pci_ecam_create(..., ops)
	  ops->init                                 # mc_ecam_ops.init
	    mc_platform_init(pci_config_window *)
	      port = devm_kzalloc(...)              # initialized
    mc_setup_windows
      bridge_base_addr = port->axi_base_addr + ...  # used

And you're using the file scope "port" because mc_platform_init()
doesn't have a pointer to the platform_device.  But I think this
abuses the pci_ecam_ops design to do host bridge initialization that
it is not intended for.

I'd suggest copying the host bridge init design from somewhere else.
tango_pcie_probe() also calls pci_host_common_probe(), so maybe that's
a good place.  But the fact that it's the *only* such caller makes me
think it might not be the best thing to copy.

Rob has been working in this area and probably has better insight.

> +static void mc_pcie_isr(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct mc_port *port = irq_desc_get_handler_data(desc);
> +	struct device *dev = port->dev;
> +	struct mc_msi *msi = &port->msi;
> +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
> +	unsigned long status;
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
> +	status = readl_relaxed(bridge_base_addr + MC_ISTATUS_LOCAL);

readl_relaxed() is defined to return a u32, so you might as well
declare "status" and related things as u32 instead of "unsigned long".

> +static void mc_pcie_enable_msi(struct mc_port *port, void __iomem *base)
> +{
> +	struct mc_msi *msi = &port->msi;
> +	u32 cap_offset = MC_MSI_CAP_CTRL_OFFSET;
> +

Remove this blank line.  We usually just separate the automatic
variables from the code with a blank line.

> +	u16 msg_ctrl = readw_relaxed(base + cap_offset + PCI_MSI_FLAGS);

> +static void mc_mask_intx_irq(struct irq_data *data)
> +{
> +	struct mc_port *port = irq_data_get_irq_chip_data(data);
> +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
> +	unsigned long flags;
> +	u32 mask, val;
> +
> +	mask = PCIE_LOCAL_INT_ENABLE;
> +	raw_spin_lock_irqsave(&port->intx_mask_lock, flags);
> +	val = readl_relaxed(bridge_base_addr + MC_IMASK_LOCAL);
> +	val &= ~mask;

Why bother with "mask" here?  It's only used once; just use
PCIE_LOCAL_INT_ENABLE directly.

> +	writel_relaxed(val, bridge_base_addr + MC_IMASK_LOCAL);
> +	raw_spin_unlock_irqrestore(&port->intx_mask_lock, flags);
> +}
> +
> +static void mc_unmask_intx_irq(struct irq_data *data)
> +{
> +	struct mc_port *port = irq_data_get_irq_chip_data(data);
> +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
> +	unsigned long flags;
> +	u32 mask, val;
> +
> +	mask = PCIE_LOCAL_INT_ENABLE;
> +	raw_spin_lock_irqsave(&port->intx_mask_lock, flags);
> +	val = readl_relaxed(bridge_base_addr + MC_IMASK_LOCAL);
> +	val |= mask;

Here also.

> +static int mc_platform_init(struct pci_config_window *cfg)
> +{
> +	struct device *dev = cfg->parent;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	void __iomem *bridge_base_addr;
> +	void __iomem *ctrl_base_addr;
> +	int ret;
> +	u32 irq;
> +	u32 val;
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +	port->dev = dev;
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

platform_get_irq() returns "int".  You declared "irq" as "u32" above,
so this check for failure won't work correctly.

> +		dev_err(dev, "unable to request IRQ%d\n", irq);
> +		return -ENODEV;
> +	}

