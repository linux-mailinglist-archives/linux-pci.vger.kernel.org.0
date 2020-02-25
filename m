Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF6C116BFBD
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 12:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbgBYLkR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 06:40:17 -0500
Received: from foss.arm.com ([217.140.110.172]:49510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729178AbgBYLkR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Feb 2020 06:40:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54A471063;
        Tue, 25 Feb 2020 03:40:16 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A07B3F6CF;
        Tue, 25 Feb 2020 03:40:15 -0800 (PST)
Date:   Tue, 25 Feb 2020 11:40:13 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rgummal@xilinx.com
Subject: Re: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Message-ID: <20200225114013.GB6913@e121166-lin.cambridge.arm.com>
References: <1580400771-12382-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1580400771-12382-3-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580400771-12382-3-git-send-email-bharat.kumar.gogada@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 30, 2020 at 09:42:51PM +0530, Bharat Kumar Gogada wrote:
> - Add support for Versal CPM as Root Port.
> - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
>   block for CPM along with the integrated bridge can function
>   as PCIe Root Port.
> - CPM Versal uses GICv3 ITS feature for achieving assigning MSI/MSI-X
>   vectors and handling MSI/MSI-X interrupts.

This is not relevant information.

> - Bridge error and legacy interrupts in Versal CPM are handled using
>   Versal CPM specific MISC interrupt line.
> 
> Changes v5:
> - Removed xilinx_cpm_pcie_valid_device function

Remove Changes log from the commit log.

> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/controller/Kconfig           |   8 +
>  drivers/pci/controller/Makefile          |   1 +
>  drivers/pci/controller/pcie-xilinx-cpm.c | 491 +++++++++++++++++++++++++++++++
>  3 files changed, 500 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index c77069c..362f4db 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -81,6 +81,14 @@ config PCIE_XILINX
>  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
>  	  Host Bridge driver.
>  
> +config PCIE_XILINX_CPM
> +	bool "Xilinx Versal CPM host bridge support"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	help
> +	  Say 'Y' here if you want kernel support for the
> +	  Xilinx Versal CPM host bridge. The driver supports
> +	  MSI/MSI-X interrupts using GICv3 ITS feature.
> +
>  config PCI_XGENE
>  	bool "X-Gene PCIe controller"
>  	depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index 3d4f597..6c936e9 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
>  obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
>  obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
>  obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
> +obj-$(CONFIG_PCIE_XILINX_CPM) += pcie-xilinx-cpm.o
>  obj-$(CONFIG_PCI_V3_SEMI) += pci-v3-semi.o
>  obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
>  obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> new file mode 100644
> index 0000000..4e4c0f0
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -0,0 +1,491 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * PCIe host controller driver for Xilinx Versal CPM DMA Bridge
> + *
> + * (C) Copyright 2019 - 2020, Xilinx, Inc.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_irq.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +
> +#include "../pci.h"
> +
> +/* Register definitions */
> +#define XILINX_CPM_PCIE_REG_IDR		0x00000E10
> +#define XILINX_CPM_PCIE_REG_IMR		0x00000E14
> +#define XILINX_CPM_PCIE_REG_PSCR	0x00000E1C
> +#define XILINX_CPM_PCIE_REG_RPSC	0x00000E20
> +#define XILINX_CPM_PCIE_REG_RPEFR	0x00000E2C
> +#define XILINX_CPM_PCIE_REG_IDRN	0x00000E38
> +#define XILINX_CPM_PCIE_REG_IDRN_MASK	0x00000E3C
> +#define XILINX_CPM_PCIE_MISC_IR_STATUS	0x00000340
> +#define XILINX_CPM_PCIE_MISC_IR_ENABLE	0x00000348
> +#define XILINX_CPM_PCIE_MISC_IR_LOCAL	BIT(1)
> +
> +/* Interrupt registers definitions */
> +#define XILINX_CPM_PCIE_INTR_LINK_DOWN		BIT(0)
> +#define XILINX_CPM_PCIE_INTR_HOT_RESET		BIT(3)
> +#define XILINX_CPM_PCIE_INTR_CFG_TIMEOUT	BIT(8)
> +#define XILINX_CPM_PCIE_INTR_CORRECTABLE	BIT(9)
> +#define XILINX_CPM_PCIE_INTR_NONFATAL		BIT(10)
> +#define XILINX_CPM_PCIE_INTR_FATAL		BIT(11)
> +#define XILINX_CPM_PCIE_INTR_INTX		BIT(16)
> +#define XILINX_CPM_PCIE_INTR_MSI		BIT(17)
> +#define XILINX_CPM_PCIE_INTR_SLV_UNSUPP		BIT(20)
> +#define XILINX_CPM_PCIE_INTR_SLV_UNEXP		BIT(21)
> +#define XILINX_CPM_PCIE_INTR_SLV_COMPL		BIT(22)
> +#define XILINX_CPM_PCIE_INTR_SLV_ERRP		BIT(23)
> +#define XILINX_CPM_PCIE_INTR_SLV_CMPABT		BIT(24)
> +#define XILINX_CPM_PCIE_INTR_SLV_ILLBUR		BIT(25)
> +#define XILINX_CPM_PCIE_INTR_MST_DECERR		BIT(26)
> +#define XILINX_CPM_PCIE_INTR_MST_SLVERR		BIT(27)
> +#define XILINX_CPM_PCIE_IMR_ALL_MASK		0x1FF39FF9
> +#define XILINX_CPM_PCIE_IDR_ALL_MASK		0xFFFFFFFF
> +#define XILINX_CPM_PCIE_IDRN_MASK		GENMASK(19, 16)
> +#define XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT	BIT(4)
> +#define XILINX_CPM_PCIE_INTR_CFG_ERR_POISON	BIT(12)
> +#define XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD	BIT(15)
> +#define XILINX_CPM_PCIE_INTR_PM_PME_RCVD	BIT(17)
> +#define XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT	BIT(28)
> +#define XILINX_CPM_PCIE_IDRN_SHIFT		16
> +
> +/* Root Port Error FIFO Read Register definitions */
> +#define XILINX_CPM_PCIE_RPEFR_ERR_VALID		BIT(18)
> +#define XILINX_CPM_PCIE_RPEFR_REQ_ID		GENMASK(15, 0)
> +#define XILINX_CPM_PCIE_RPEFR_ALL_MASK		0xFFFFFFFF
> +
> +/* Root Port Status/control Register definitions */
> +#define XILINX_CPM_PCIE_REG_RPSC_BEN		BIT(0)
> +
> +/* Phy Status/Control Register definitions */
> +#define XILINX_CPM_PCIE_REG_PSCR_LNKUP		BIT(11)
> +
> +/* ECAM definitions */
> +#define ECAM_BUS_NUM_SHIFT		20
> +#define ECAM_DEV_NUM_SHIFT		12

You don't need these ECAM_* defines, you can use pci_generic_ecam_ops.

> +
> +/**
> + * struct xilinx_cpm_pcie_port - PCIe port information
> + * @reg_base: Bridge Register Base
> + * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
> + * @irq: Interrupt number
> + * @root_busno: Root Bus number
> + * @dev: Device pointer
> + * @leg_domain: Legacy IRQ domain pointer
> + * @irq_misc: Legacy and error interrupt number
> + */
> +struct xilinx_cpm_pcie_port {
> +	void __iomem *reg_base;
> +	void __iomem *cpm_base;
> +	u32 irq;
> +	u8 root_busno;
> +	struct device *dev;
> +	struct irq_domain *leg_domain;
> +	int irq_misc;
> +};
> +
> +static inline u32 pcie_read(struct xilinx_cpm_pcie_port *port, u32 reg)
> +{
> +	return readl(port->reg_base + reg);
> +}
> +
> +static inline void pcie_write(struct xilinx_cpm_pcie_port *port,
> +			      u32 val, u32 reg)
> +{
> +	writel(val, port->reg_base + reg);
> +}
> +
> +static inline bool cpm_pcie_link_up(struct xilinx_cpm_pcie_port *port)
> +{
> +	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
> +		XILINX_CPM_PCIE_REG_PSCR_LNKUP) ? 1 : 0;

	u32 val = pcie_read(port, XILINX_CPM_PCIE_REG_PSCR);

	return val & XILINX_CPM_PCIE_REG_PSCR_LNKUP;

And this function call is not that informative anyway - it is used just
to print a log whose usefulness is questionable.

> +}
> +
> +/**
> + * xilinx_cpm_pcie_clear_err_interrupts - Clear Error Interrupts
> + * @port: PCIe port information
> + */
> +static void cpm_pcie_clear_err_interrupts(struct xilinx_cpm_pcie_port *port)
> +{
> +	unsigned long val = pcie_read(port, XILINX_CPM_PCIE_REG_RPEFR);
> +
> +	if (val & XILINX_CPM_PCIE_RPEFR_ERR_VALID) {
> +		dev_dbg(port->dev, "Requester ID %lu\n",
> +			val & XILINX_CPM_PCIE_RPEFR_REQ_ID);
> +		pcie_write(port, XILINX_CPM_PCIE_RPEFR_ALL_MASK,
> +			   XILINX_CPM_PCIE_REG_RPEFR);
> +	}
> +}
> +
> +/**
> + * xilinx_cpm_pcie_map_bus - Get configuration base
> + * @bus: PCI Bus structure
> + * @devfn: Device/function
> + * @where: Offset from base
> + *
> + * Return: Base address of the configuration space needed to be
> + *	   accessed.
> + */
> +static void __iomem *xilinx_cpm_pcie_map_bus(struct pci_bus *bus,
> +					     unsigned int devfn, int where)
> +{
> +	struct xilinx_cpm_pcie_port *port = bus->sysdata;
> +	int relbus;
> +
> +	relbus = (bus->number << ECAM_BUS_NUM_SHIFT) |
> +		 (devfn << ECAM_DEV_NUM_SHIFT);
> +
> +	return port->reg_base + relbus + where;
> +}

You don't need this function, you can rely on pci_generic_ecam_ops.

> +/* PCIe operations */
> +static struct pci_ops xilinx_cpm_pcie_ops = {
> +	.map_bus = xilinx_cpm_pcie_map_bus,
> +	.read	= pci_generic_config_read,
> +	.write	= pci_generic_config_write,
> +};

See above.

> +
> +/**
> + * xilinx_cpm_pcie_intx_map - Set the handler for the INTx and mark IRQ as valid
> + * @domain: IRQ domain
> + * @irq: Virtual IRQ number
> + * @hwirq: HW interrupt number
> + *
> + * Return: Always returns 0.
> + */
> +static int xilinx_cpm_pcie_intx_map(struct irq_domain *domain,
> +				    unsigned int irq, irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);

INTX are level IRQs, the flow handler must be handle_level_irq.

> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_status_flags(irq, IRQ_LEVEL);

The way INTX are handled in this patch is wrong. You must set-up
a chained IRQ with the appropriate flow handler, current code
uses an IRQ action and that's an IRQ layer violation and it goes
without saying that it is almost certainly broken.

Please read drivers/pci/controller/pci-ft100.c code, that's the
way INTX must be handled; I planned to take that code and make
it a library, please use the same IRQ domain set-up.

> +	return 0;
> +}
> +
> +/* INTx IRQ Domain operations */
> +static const struct irq_domain_ops intx_domain_ops = {
> +	.map = xilinx_cpm_pcie_intx_map,
> +	.xlate = pci_irqd_intx_xlate,

This is wrong, wrong, wrong. There is no need for xlat'ing anything
see my reply on the DT bindings.

> +};
> +
> +/**
> + * xilinx_cpm_pcie_intr_handler - Interrupt Service Handler
> + * @irq: IRQ number
> + * @data: PCIe port information
> + *
> + * Return: IRQ_HANDLED on success and IRQ_NONE on failure
> + */
> +static irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void *data)

Bad. This must be a chained IRQ flow handler, not an IRQ action.

> +{
> +	struct xilinx_cpm_pcie_port *port = data;
> +	struct device *dev = port->dev;
> +	u32 val, mask, status, bit;
> +	unsigned long intr_val;
> +
> +	/* Read interrupt decode and mask registers */
> +	val = pcie_read(port, XILINX_CPM_PCIE_REG_IDR);
> +	mask = pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
> +
> +	status = val & mask;
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	if (status & XILINX_CPM_PCIE_INTR_LINK_DOWN)
> +		dev_warn(dev, "Link Down\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_HOT_RESET)
> +		dev_info(dev, "Hot reset\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_CFG_TIMEOUT)
> +		dev_warn(dev, "ECAM access timeout\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_CORRECTABLE) {
> +		dev_warn(dev, "Correctable error message\n");
> +		cpm_pcie_clear_err_interrupts(port);
> +	}
> +
> +	if (status & XILINX_CPM_PCIE_INTR_NONFATAL) {
> +		dev_warn(dev, "Non fatal error message\n");
> +		cpm_pcie_clear_err_interrupts(port);
> +	}
> +
> +	if (status & XILINX_CPM_PCIE_INTR_FATAL) {
> +		dev_warn(dev, "Fatal error message\n");
> +		cpm_pcie_clear_err_interrupts(port);
> +	}
> +
> +	if (status & XILINX_CPM_PCIE_INTR_INTX) {
> +		/* Handle INTx Interrupt */
> +		intr_val = pcie_read(port, XILINX_CPM_PCIE_REG_IDRN);
> +		intr_val = intr_val >> XILINX_CPM_PCIE_IDRN_SHIFT;
> +
> +		for_each_set_bit(bit, &intr_val, PCI_NUM_INTX)
> +			generic_handle_irq(irq_find_mapping(port->leg_domain,
> +							    bit));
> +	}
> +
> +	if (status & XILINX_CPM_PCIE_INTR_SLV_UNSUPP)
> +		dev_warn(dev, "Slave unsupported request\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_SLV_UNEXP)
> +		dev_warn(dev, "Slave unexpected completion\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_SLV_COMPL)
> +		dev_warn(dev, "Slave completion timeout\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_SLV_ERRP)
> +		dev_warn(dev, "Slave Error Poison\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_SLV_CMPABT)
> +		dev_warn(dev, "Slave Completer Abort\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_SLV_ILLBUR)
> +		dev_warn(dev, "Slave Illegal Burst\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_MST_DECERR)
> +		dev_warn(dev, "Master decode error\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_MST_SLVERR)
> +		dev_warn(dev, "Master slave error\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT)
> +		dev_warn(dev, "PCIe ECAM access timeout\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_CFG_ERR_POISON)
> +		dev_warn(dev, "ECAM poisoned completion received\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD)
> +		dev_warn(dev, "PME_TO_ACK message received\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_PM_PME_RCVD)
> +		dev_warn(dev, "PM_PME message received\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT)
> +		dev_warn(dev, "PCIe completion timeout received\n");
> +
> +	/* Clear the Interrupt Decode register */
> +	pcie_write(port, status, XILINX_CPM_PCIE_REG_IDR);
> +
> +	/*
> +	 * XILINX_CPM_PCIE_MISC_IR_STATUS register is mapped to
> +	 * CPM SLCR block.
> +	 */
> +	val = readl(port->cpm_base + XILINX_CPM_PCIE_MISC_IR_STATUS);
> +	if (val)
> +		writel(val, port->cpm_base + XILINX_CPM_PCIE_MISC_IR_STATUS);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * xilinx_cpm_pcie_init_irq_domain - Initialize IRQ domain
> + * @port: PCIe port information
> + *
> + * Return: '0' on success and error value on failure
> + */
> +static int xilinx_cpm_pcie_init_irq_domain(struct xilinx_cpm_pcie_port *port)
> +{
> +	struct device *dev = port->dev;
> +	struct device_node *node = dev->of_node;
> +	struct device_node *pcie_intc_node;
> +
> +	/* Setup INTx */
> +	pcie_intc_node = of_get_next_child(node, NULL);
> +	if (!pcie_intc_node) {
> +		dev_err(dev, "No PCIe Intc node found\n");
> +		return -EINVAL;
> +	}
> +
> +	port->leg_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
> +						 &intx_domain_ops,
> +						 port);
> +	if (!port->leg_domain) {
> +		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * xilinx_cpm_pcie_init_port - Initialize hardware
> + * @port: PCIe port information
> + */
> +static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie_port *port)
> +{
> +	if (cpm_pcie_link_up(port))
> +		dev_info(port->dev, "PCIe Link is UP\n");
> +	else
> +		dev_info(port->dev, "PCIe Link is DOWN\n");
> +
> +	/* Disable all interrupts */
> +	pcie_write(port, ~XILINX_CPM_PCIE_IDR_ALL_MASK,
> +		   XILINX_CPM_PCIE_REG_IMR);
> +
> +	/* Clear pending interrupts */
> +	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_IDR) &
> +		   XILINX_CPM_PCIE_IMR_ALL_MASK,
> +		   XILINX_CPM_PCIE_REG_IDR);
> +
> +	/* Enable all interrupts */
> +	pcie_write(port, XILINX_CPM_PCIE_IMR_ALL_MASK,
> +		   XILINX_CPM_PCIE_REG_IMR);
> +	pcie_write(port, XILINX_CPM_PCIE_IDRN_MASK,
> +		   XILINX_CPM_PCIE_REG_IDRN_MASK);
> +
> +	/*
> +	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
> +	 * CPM SLCR block.
> +	 */
> +	writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
> +	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
> +	/* Enable the Bridge enable bit */
> +	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
> +		   XILINX_CPM_PCIE_REG_RPSC_BEN,
> +		   XILINX_CPM_PCIE_REG_RPSC);
> +}
> +
> +static int xilinx_cpm_request_misc_irq(struct xilinx_cpm_pcie_port *port)
> +{
> +	struct device *dev = port->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int err;
> +
> +	port->irq_misc = platform_get_irq_byname(pdev, "misc");
> +	if (port->irq_misc <= 0) {
> +		dev_err(dev, "Unable to find misc IRQ line\n");
> +		return port->irq_misc;
> +	}
> +	err = devm_request_irq(dev, port->irq_misc,
> +			       xilinx_cpm_pcie_intr_handler,
> +			       IRQF_SHARED | IRQF_NO_THREAD,
> +			       "xilinx-pcie", port);

Nope. See above.

> +	if (err) {
> +		dev_err(dev, "unable to request misc IRQ line %d\n",
> +			port->irq_misc);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * xilinx_cpm_pcie_parse_dt - Parse Device tree
> + * @port: PCIe port information
> + *
> + * Return: '0' on success and error value on failure
> + */
> +static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie_port *port)
> +{
> +	struct device *dev = port->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct resource *res;
> +	int err;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> +	port->reg_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(port->reg_base))
> +		return PTR_ERR(port->reg_base);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +					   "cpm_slcr");
> +	port->cpm_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(port->cpm_base))
> +		return PTR_ERR(port->cpm_base);
> +
> +	err = xilinx_cpm_request_misc_irq(port);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +/**
> + * xilinx_cpm_pcie_probe - Probe function
> + * @pdev: Platform device pointer
> + *
> + * Return: '0' on success and error value on failure
> + */
> +static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
> +{
> +	struct xilinx_cpm_pcie_port *port;
> +	struct device *dev = &pdev->dev;
> +	struct pci_bus *bus;
> +	struct pci_bus *child;
> +	struct pci_host_bridge *bridge;
> +	int err;
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
> +	if (!bridge)
> +		return -ENODEV;
> +
> +	port = pci_host_bridge_priv(bridge);
> +
> +	port->dev = dev;
> +
> +	err = xilinx_cpm_pcie_parse_dt(port);
> +	if (err) {
> +		dev_err(dev, "Parsing DT failed\n");
> +		return err;
> +	}
> +
> +	xilinx_cpm_pcie_init_port(port);
> +
> +	err = xilinx_cpm_pcie_init_irq_domain(port);
> +	if (err) {
> +		dev_err(dev, "Failed creating IRQ Domain\n");
> +		return err;
> +	}

If subsequent calls fail from now onwards, there is work carried
out in this initialization to be undone, which isn't, please add
it.

Thanks,
Lorenzo

> +
> +	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
> +					      &bridge->dma_ranges, NULL);
> +	if (err) {
> +		dev_err(dev, "Getting bridge resources failed\n");
> +		return err;
> +	}
> +
> +	bridge->dev.parent = dev;
> +	bridge->sysdata = port;
> +	bridge->busnr = port->root_busno;
> +	bridge->ops = &xilinx_cpm_pcie_ops;
> +	bridge->map_irq = of_irq_parse_and_map_pci;
> +	bridge->swizzle_irq = pci_common_swizzle;
> +
> +	err = pci_scan_root_bus_bridge(bridge);
> +	if (err)
> +		return err;
> +
> +	bus = bridge->bus;
> +
> +	pci_assign_unassigned_bus_resources(bus);
> +	list_for_each_entry(child, &bus->children, node)
> +		pcie_bus_configure_settings(child);
> +	pci_bus_add_devices(bus);
> +	return 0;
> +}
> +
> +static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
> +	{ .compatible = "xlnx,versal-cpm-host-1.00", },
> +	{}
> +};
> +
> +static struct platform_driver xilinx_cpm_pcie_driver = {
> +	.driver = {
> +		.name = "xilinx-cpm-pcie",
> +		.of_match_table = xilinx_cpm_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe = xilinx_cpm_pcie_probe,
> +};
> +
> +builtin_platform_driver(xilinx_cpm_pcie_driver);
> -- 
> 2.7.4
> 
