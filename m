Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F99E1DEC74
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 17:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbgEVPvt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 11:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730180AbgEVPvs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 11:51:48 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1FC020663;
        Fri, 22 May 2020 15:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590162706;
        bh=H0BhjB3ZVneMchtL9kq65BkaNmdyuzNIdDJ/DmLg8O8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bKEzwKGL3qtVOGxmEDNKepQeXKeJmktIb5RQ0despCjckLNJyJk3bSsXlKN+gd8ay
         pYgSLCCZBuVcBiogvMqEzXoo7+EHynxY7x89yneEk7oAprT9vjvDPz/Uj6yk3Wyoy7
         1ivsDRjeN/pNotONxKIK6wLmKpp5XSjVsnRJvcOs=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jc9xX-00EYiF-W2; Fri, 22 May 2020 16:51:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 May 2020 16:51:43 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh@kernel.org,
        rgummal@xilinx.com
Subject: Re: [PATCH v7 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
In-Reply-To: <1588852716-23132-3-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1588852716-23132-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1588852716-23132-3-git-send-email-bharat.kumar.gogada@xilinx.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <07485a1859803d2e92b05a17835bd191@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: bharat.kumar.gogada@xilinx.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh@kernel.org, rgummal@xilinx.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bharat,

On 2020-05-07 12:58, Bharat Kumar Gogada wrote:
> - Add support for Versal CPM as Root Port.
> - The Versal ACAP devices include CCIX-PCIe Module (CPM). The 
> integrated
>   block for CPM along with the integrated bridge can function
>   as PCIe Root Port.
> - Bridge error and legacy interrupts in Versal CPM are handled using
>   Versal CPM specific interrupt line.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/controller/Kconfig           |   9 +
>  drivers/pci/controller/Makefile          |   1 +
>  drivers/pci/controller/pcie-xilinx-cpm.c | 506 
> +++++++++++++++++++++++++++++++
>  3 files changed, 516 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c
> 
> diff --git a/drivers/pci/controller/Kconfig 
> b/drivers/pci/controller/Kconfig
> index 20bf00f..ca0ae24 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -81,6 +81,15 @@ config PCIE_XILINX
>  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
>  	  Host Bridge driver.
> 
> +config PCIE_XILINX_CPM
> +	bool "Xilinx Versal CPM host bridge support"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	select PCI_HOST_COMMON
> +	help
> +	  Say 'Y' here if you want kernel support for the
> +	  Xilinx Versal CPM host bridge. The driver supports
> +	  MSI/MSI-X interrupts using GICv3 ITS feature.

I don't think this last sentense makes any sense here. We usually don't 
mention things that the driver *doesn't* implement.

> +
>  config PCI_XGENE
>  	bool "X-Gene PCIe controller"
>  	depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/pci/controller/Makefile 
> b/drivers/pci/controller/Makefile
> index 01b2502..78dabda 100644
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
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c
> b/drivers/pci/controller/pcie-xilinx-cpm.c
> new file mode 100644
> index 0000000..e8c0aa7
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -0,0 +1,506 @@
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
> +#include <linux/pci-ecam.h>
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

I assume that this is the logical OR of all the XILINX_CPM_PCIE_INTR_* 
bits. Please express it as such.

> +#define XILINX_CPM_PCIE_IDR_ALL_MASK		0xFFFFFFFF
> +#define XILINX_CPM_PCIE_IDRN_MASK		GENMASK(19, 16)
> +#define XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT	BIT(4)
> +#define XILINX_CPM_PCIE_INTR_CFG_ERR_POISON	BIT(12)
> +#define XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD	BIT(15)
> +#define XILINX_CPM_PCIE_INTR_PM_PME_RCVD	BIT(17)

So we have two definitions for bit 17... Given that nothing uses the MSI 
version, I assume it is useless...

> +#define XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT	BIT(28)

Please group all the XILINX_CPM_PCIE_INTR_* together.

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
> +/**
> + * struct xilinx_cpm_pcie_port - PCIe port information
> + * @reg_base: Bridge Register Base
> + * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
> + * @dev: Device pointer
> + * @leg_domain: Legacy IRQ domain pointer

leg, arm, thumb, limb... Given that oyu use the 'intx' description all 
over the driver, please be consistent and name this intx_domain.

> + * @cfg: Holds mappings of config space window
> + * @irq_misc: Legacy and error interrupt number

Let's face it, this is the *only* interrupt this thing as, so the 'misc' 
is supperfluous.

> + * @leg_mask_lock: lock for legacy interrupts
> + */
> +struct xilinx_cpm_pcie_port {
> +	void __iomem *reg_base;
> +	void __iomem *cpm_base;
> +	struct device *dev;
> +	struct irq_domain *leg_domain;
> +	struct pci_config_window *cfg;
> +	int irq_misc;
> +	raw_spinlock_t leg_mask_lock;
> +};
> +
> +static inline u32 pcie_read(struct xilinx_cpm_pcie_port *port, u32 
> reg)
> +{
> +	return readl(port->reg_base + reg);

There is no need for enforced ordering with non-device writes, so you 
can turn this into readl_relaxed. You can also drop the inline, as the 
compiler will do the right thing for you.

> +}
> +
> +static inline void pcie_write(struct xilinx_cpm_pcie_port *port,
> +			      u32 val, u32 reg)
> +{
> +	writel(val, port->reg_base + reg);

Same thing.

> +}
> +
> +static inline bool cpm_pcie_link_up(struct xilinx_cpm_pcie_port *port)
> +{
> +	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
> +		XILINX_CPM_PCIE_REG_PSCR_LNKUP) ? 1 : 0;

If you are making the return value a bool, you might as well return 
true/false. But that's a cumbersome way to write:

         return pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
                XILINX_CPM_PCIE_REG_PSCR_LNKUP;

> +}
> +
> +/**
> + * xilinx_cpm_pcie_clear_err_interrupts - Clear Error Interrupts
> + * @port: PCIe port information
> + */
> +static void cpm_pcie_clear_err_interrupts(struct xilinx_cpm_pcie_port 
> *port)
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
> +static void xilinx_cpm_mask_leg_irq(struct irq_data *data)
> +{
> +	struct irq_desc *desc = irq_to_desc(data->irq);
> +	struct xilinx_cpm_pcie_port *port;
> +	unsigned long flags;
> +	u32 mask;
> +	u32 val;
> +
> +	port = irq_desc_get_chip_data(desc);

port = irq_data_get_irq_chip_data(data);

You should never have to get the irq_desc (and using irq_to_desc() is a 
prettyodd way to get it when you already have the irq_data).

> +	mask = (1 << data->hwirq) << XILINX_CPM_PCIE_IDRN_SHIFT;

Also known as BIT(data->hwirq + XILINX_CPM_PCIE_IDRN_SHIFT).

> +	raw_spin_lock_irqsave(&port->leg_mask_lock, flags);
> +	val = pcie_read(port, XILINX_CPM_PCIE_REG_IDRN_MASK);
> +	pcie_write(port, (val & (~mask)), XILINX_CPM_PCIE_REG_IDRN_MASK);
> +	raw_spin_unlock_irqrestore(&port->leg_mask_lock, flags);
> +}
> +
> +static void xilinx_cpm_unmask_leg_irq(struct irq_data *data)
> +{
> +	struct irq_desc *desc = irq_to_desc(data->irq);
> +	struct xilinx_cpm_pcie_port *port;
> +	unsigned long flags;
> +	u32 mask;
> +	u32 val;
> +
> +	port = irq_desc_get_chip_data(desc);
> +	mask = (1 << data->hwirq) << XILINX_CPM_PCIE_IDRN_SHIFT;
> +	raw_spin_lock_irqsave(&port->leg_mask_lock, flags);
> +	val = pcie_read(port, XILINX_CPM_PCIE_REG_IDRN_MASK);
> +	pcie_write(port, (val | mask), XILINX_CPM_PCIE_REG_IDRN_MASK);
> +	raw_spin_unlock_irqrestore(&port->leg_mask_lock, flags);
> +}
> +
> +static struct irq_chip xilinx_cpm_leg_irq_chip = {
> +	.name = "xilinx_cpm_pcie:legacy",

"INTx" is a good enough description.

> +	.irq_enable = xilinx_cpm_unmask_leg_irq,
> +	.irq_disable = xilinx_cpm_mask_leg_irq,
> +	.irq_mask = xilinx_cpm_mask_leg_irq,
> +	.irq_unmask = xilinx_cpm_unmask_leg_irq,

This makes no sense. If enable/disable have the same implementation as 
unmask/mask, then enable/disable is pretty useless. Please drop them.

> +};
> +
> +/**
> + * xilinx_cpm_pcie_intx_map - Set the handler for the INTx and mark
> IRQ as valid
> + * @domain: IRQ domain
> + * @irq: Virtual IRQ number
> + * @hwirq: HW interrupt number
> + *
> + * Return: Always returns 0.
> + */
> +static int xilinx_cpm_pcie_intx_map(struct irq_domain *domain,
> +				    unsigned int irq, irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &xilinx_cpm_leg_irq_chip,
> +				 handle_level_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_status_flags(irq, IRQ_LEVEL);
> +
> +	return 0;
> +}
> +
> +/* INTx IRQ Domain operations */
> +static const struct irq_domain_ops intx_domain_ops = {
> +	.map = xilinx_cpm_pcie_intx_map,
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

There is a certain sense of repetition here. It really begs the question 
of *why* you want to take these interrupts if all you do is spam the 
console with warnings, not taking any action to potentially remedy the 
problem.

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

That's a firm no. We don't demux chained handlers in an interrupt 
handler. It may work for now, but it will eventually break. And to be 
clear, this whole function needs to die. By the look of it, this PCie 
controller implements *TWO* interrupt multiplexers:

- one that muxes all the ILINX_CPM_PCIE_INTR_* events onto a single 
top-level IRQ
- another one that muxes all INTX lines onto XILINX_CPM_PCIE_INTR_INTX

Please implement the whole thing as described above.

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

I'm pretty sure there is a slightly better way to write this...

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
> +static int xilinx_cpm_pcie_init_irq_domain(struct xilinx_cpm_pcie_port 
> *port)
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
> +	port->leg_domain = irq_domain_add_linear(pcie_intc_node, 
> PCI_NUM_INTX,
> +						 &intx_domain_ops,
> +						 port);
> +	of_node_put(pcie_intc_node);
> +	if (!port->leg_domain) {
> +		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	raw_spin_lock_init(&port->leg_mask_lock);
> +	return 0;
> +}
> +
> +/**
> + * xilinx_cpm_pcie_init_port - Initialize hardware
> + * @port: PCIe port information
> + */
> +static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie_port 
> *port)
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

No. We don't enable interrupts randomly. They need a handler registered 
with the core IRq subsystem *first*, which is why this needs to be 
hooked in as a proper irqchip, and each event handled individualy.

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
> +static int xilinx_cpm_request_misc_irq(struct xilinx_cpm_pcie_port 
> *port)
> +{
> +	struct device *dev = port->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int err;
> +
> +	port->irq_misc = platform_get_irq(pdev, 0);
> +	if (port->irq_misc <= 0) {

If 0 is an error, how do you distinguish it from the non-error case?

> +		dev_err(dev, "Unable to find misc IRQ line\n");
> +		return port->irq_misc;
> +	}
> +
> +	err = devm_request_irq(dev, port->irq_misc,
> +			       xilinx_cpm_pcie_intr_handler,
> +			       IRQF_SHARED | IRQF_NO_THREAD,
> +			       "xilinx-pcie", port);
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
> + * @bus_range: Bus resource
> + *
> + * Return: '0' on success and error value on failure
> + */
> +static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie_port *port,
> +				    struct resource *bus_range)
> +{
> +	struct device *dev = port->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct resource *res;
> +	int err;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> +	if (!res)
> +		return -ENXIO;
> +
> +	port->cfg = pci_ecam_create(dev, res, bus_range,
> +				    &pci_generic_ecam_ops);
> +	if (IS_ERR(port->cfg))
> +		return PTR_ERR(port->cfg);
> +
> +	port->reg_base = port->cfg->win;
> +
> +	port->cpm_base = devm_platform_ioremap_resource_byname(pdev,
> +							       "cpm_slcr");
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
> +	struct pci_host_bridge *bridge;
> +	struct resource *bus_range;
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
> +	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
> +					      &bridge->dma_ranges, &bus_range);
> +	if (err) {
> +		dev_err(dev, "Getting bridge resources failed\n");
> +		return err;
> +	}
> +
> +	err = xilinx_cpm_pcie_parse_dt(port, bus_range);
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
> +
> +	bridge->dev.parent = dev;
> +	bridge->sysdata = port->cfg;
> +	bridge->busnr = port->cfg->busr.start;
> +	bridge->ops = &pci_generic_ecam_ops.pci_ops;
> +	bridge->map_irq = of_irq_parse_and_map_pci;
> +	bridge->swizzle_irq = pci_common_swizzle;
> +
> +	err = pci_host_probe(bridge);
> +	if (err < 0) {
> +		irq_domain_remove(port->leg_domain);
> +		devm_free_irq(dev, port->irq_misc, port);

Why calling dem_free_irq()? The whole point of using devm* is not to 
have to manage the error handling.

> +		return err;
> +	}
> +
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

I don't think this driver is in a state where it can be merged. Given 
that we're already at v7 and to save everyone a bit of time, I've 
written the patch that implements the above comments. It compiles, but 
is probably broken. Hopefully you can test it and figure things out.

         M.

 From 8b5d158374e59edf26e61c512eeb00ca7c9d891d Mon Sep 17 00:00:00 2001
 From: Marc Zyngier <maz@kernel.org>
Date: Fri, 22 May 2020 16:33:32 +0100
Subject: [PATCH] PCI: xilinx-cpm: Revamp irq handling

The xilinx-cpm driver missuses the IRQ layer in creative ways.
It implements a chained interrupt demultiplexer inside a normal
handler, enables interrupts randomly, and could overall do with
a good cleanup.

Instead, implement the IRQ support as two nested chained irqchips,
the outer one dealing with all the PCIe events, the inner one
namaging the INTx signals.

Additionally, the whole driver is cleanup-up so that it can make
a bit more sense to me. YMMV.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
  drivers/pci/controller/Kconfig           |   3 +-
  drivers/pci/controller/pcie-xilinx-cpm.c | 427 ++++++++++++++---------
  2 files changed, 263 insertions(+), 167 deletions(-)

diff --git a/drivers/pci/controller/Kconfig 
b/drivers/pci/controller/Kconfig
index 1e0f63865775..d0abd671a7b6 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -87,8 +87,7 @@ config PCIE_XILINX_CPM
  	select PCI_HOST_COMMON
  	help
  	  Say 'Y' here if you want kernel support for the
-	  Xilinx Versal CPM host bridge. The driver supports
-	  MSI/MSI-X interrupts using GICv3 ITS feature.
+	  Xilinx Versal CPM host bridge.

  config PCI_XGENE
  	bool "X-Gene PCIe controller"
diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c 
b/drivers/pci/controller/pcie-xilinx-cpm.c
index e8c0aa757f72..32ed9e7e2676 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -5,8 +5,11 @@
   * (C) Copyright 2019 - 2020, Xilinx, Inc.
   */

+#include <linux/bitfield.h>
  #include <linux/interrupt.h>
  #include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
  #include <linux/irqdomain.h>
  #include <linux/kernel.h>
  #include <linux/module.h>
@@ -33,30 +36,55 @@
  #define XILINX_CPM_PCIE_MISC_IR_LOCAL	BIT(1)

  /* Interrupt registers definitions */
-#define XILINX_CPM_PCIE_INTR_LINK_DOWN		BIT(0)
-#define XILINX_CPM_PCIE_INTR_HOT_RESET		BIT(3)
-#define XILINX_CPM_PCIE_INTR_CFG_TIMEOUT	BIT(8)
-#define XILINX_CPM_PCIE_INTR_CORRECTABLE	BIT(9)
-#define XILINX_CPM_PCIE_INTR_NONFATAL		BIT(10)
-#define XILINX_CPM_PCIE_INTR_FATAL		BIT(11)
-#define XILINX_CPM_PCIE_INTR_INTX		BIT(16)
-#define XILINX_CPM_PCIE_INTR_MSI		BIT(17)
-#define XILINX_CPM_PCIE_INTR_SLV_UNSUPP		BIT(20)
-#define XILINX_CPM_PCIE_INTR_SLV_UNEXP		BIT(21)
-#define XILINX_CPM_PCIE_INTR_SLV_COMPL		BIT(22)
-#define XILINX_CPM_PCIE_INTR_SLV_ERRP		BIT(23)
-#define XILINX_CPM_PCIE_INTR_SLV_CMPABT		BIT(24)
-#define XILINX_CPM_PCIE_INTR_SLV_ILLBUR		BIT(25)
-#define XILINX_CPM_PCIE_INTR_MST_DECERR		BIT(26)
-#define XILINX_CPM_PCIE_INTR_MST_SLVERR		BIT(27)
-#define XILINX_CPM_PCIE_IMR_ALL_MASK		0x1FF39FF9
+#define XILINX_CPM_PCIE_INTR_LINK_DOWN		0
+#define XILINX_CPM_PCIE_INTR_HOT_RESET		3
+#define XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT	4
+#define XILINX_CPM_PCIE_INTR_CFG_TIMEOUT	8
+#define XILINX_CPM_PCIE_INTR_CORRECTABLE	9
+#define XILINX_CPM_PCIE_INTR_NONFATAL		10
+#define XILINX_CPM_PCIE_INTR_FATAL		11
+#define XILINX_CPM_PCIE_INTR_CFG_ERR_POISON	12
+#define XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD	15
+#define XILINX_CPM_PCIE_INTR_INTX		16
+#define XILINX_CPM_PCIE_INTR_PM_PME_RCVD	17
+#define XILINX_CPM_PCIE_INTR_SLV_UNSUPP		20
+#define XILINX_CPM_PCIE_INTR_SLV_UNEXP		21
+#define XILINX_CPM_PCIE_INTR_SLV_COMPL		22
+#define XILINX_CPM_PCIE_INTR_SLV_ERRP		23
+#define XILINX_CPM_PCIE_INTR_SLV_CMPABT		24
+#define XILINX_CPM_PCIE_INTR_SLV_ILLBUR		25
+#define XILINX_CPM_PCIE_INTR_MST_DECERR		26
+#define XILINX_CPM_PCIE_INTR_MST_SLVERR		27
+#define XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT	28
+
+#define IMR(x)	BIT(XILINX_CPM_PCIE_INTR_ ##x)
+
+#define XILINX_CPM_PCIE_IMR_ALL_MASK			\
+	(						\
+		IMR(LINK_DOWN)		|		\
+		IMR(HOT_RESET)		|		\
+		IMR(CFG_PCIE_TIMEOUT)	|		\
+		IMR(CFG_TIMEOUT)	|		\
+		IMR(CORRECTABLE)	|		\
+		IMR(NONFATAL)		|		\
+		IMR(FATAL)		|		\
+		IMR(CFG_ERR_POISON)	|		\
+		IMR(PME_TO_ACK_RCVD)	|		\
+		IMR(INTX)		|		\
+		IMR(PM_PME_RCVD)	|		\
+		IMR(SLV_UNSUPP)		|		\
+		IMR(SLV_UNEXP)		|		\
+		IMR(SLV_COMPL)		|		\
+		IMR(SLV_ERRP)		|		\
+		IMR(SLV_CMPABT)		|		\
+		IMR(SLV_ILLBUR)		|		\
+		IMR(MST_DECERR)		|		\
+		IMR(MST_SLVERR)		|		\
+		IMR(SLV_PCIE_TIMEOUT)			\
+	)
+
  #define XILINX_CPM_PCIE_IDR_ALL_MASK		0xFFFFFFFF
  #define XILINX_CPM_PCIE_IDRN_MASK		GENMASK(19, 16)
-#define XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT	BIT(4)
-#define XILINX_CPM_PCIE_INTR_CFG_ERR_POISON	BIT(12)
-#define XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD	BIT(15)
-#define XILINX_CPM_PCIE_INTR_PM_PME_RCVD	BIT(17)
-#define XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT	BIT(28)
  #define XILINX_CPM_PCIE_IDRN_SHIFT		16

  /* Root Port Error FIFO Read Register definitions */
@@ -75,36 +103,37 @@
   * @reg_base: Bridge Register Base
   * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
   * @dev: Device pointer
- * @leg_domain: Legacy IRQ domain pointer
+ * @intx_domain: Legacy IRQ domain pointer
   * @cfg: Holds mappings of config space window
- * @irq_misc: Legacy and error interrupt number
- * @leg_mask_lock: lock for legacy interrupts
+ * @irq: INTx and error interrupt number
+ * @lock: lock protecting shared register access
   */
  struct xilinx_cpm_pcie_port {
-	void __iomem *reg_base;
-	void __iomem *cpm_base;
-	struct device *dev;
-	struct irq_domain *leg_domain;
-	struct pci_config_window *cfg;
-	int irq_misc;
-	raw_spinlock_t leg_mask_lock;
+	void __iomem			*reg_base;
+	void __iomem			*cpm_base;
+	struct device			*dev;
+	struct irq_domain		*intx_domain;
+	struct irq_domain		*cpm_domain;
+	struct pci_config_window	*cfg;
+	int				irq;
+	raw_spinlock_t			lock;
  };

  static inline u32 pcie_read(struct xilinx_cpm_pcie_port *port, u32 reg)
  {
-	return readl(port->reg_base + reg);
+	return readl_relaxed(port->reg_base + reg);
  }

  static inline void pcie_write(struct xilinx_cpm_pcie_port *port,
  			      u32 val, u32 reg)
  {
-	writel(val, port->reg_base + reg);
+	writel_relaxed(val, port->reg_base + reg);
  }

  static inline bool cpm_pcie_link_up(struct xilinx_cpm_pcie_port *port)
  {
  	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
-		XILINX_CPM_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
+		XILINX_CPM_PCIE_REG_PSCR_LNKUP);
  }

  /**
@@ -125,44 +154,56 @@ static void cpm_pcie_clear_err_interrupts(struct 
xilinx_cpm_pcie_port *port)

  static void xilinx_cpm_mask_leg_irq(struct irq_data *data)
  {
-	struct irq_desc *desc = irq_to_desc(data->irq);
-	struct xilinx_cpm_pcie_port *port;
+	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(data);
  	unsigned long flags;
  	u32 mask;
  	u32 val;

-	port = irq_desc_get_chip_data(desc);
-	mask = (1 << data->hwirq) << XILINX_CPM_PCIE_IDRN_SHIFT;
-	raw_spin_lock_irqsave(&port->leg_mask_lock, flags);
+	mask = BIT(data->hwirq + XILINX_CPM_PCIE_IDRN_SHIFT);
+	raw_spin_lock_irqsave(&port->lock, flags);
  	val = pcie_read(port, XILINX_CPM_PCIE_REG_IDRN_MASK);
  	pcie_write(port, (val & (~mask)), XILINX_CPM_PCIE_REG_IDRN_MASK);
-	raw_spin_unlock_irqrestore(&port->leg_mask_lock, flags);
+	raw_spin_unlock_irqrestore(&port->lock, flags);
  }

  static void xilinx_cpm_unmask_leg_irq(struct irq_data *data)
  {
-	struct irq_desc *desc = irq_to_desc(data->irq);
-	struct xilinx_cpm_pcie_port *port;
+	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(data);
  	unsigned long flags;
  	u32 mask;
  	u32 val;

-	port = irq_desc_get_chip_data(desc);
-	mask = (1 << data->hwirq) << XILINX_CPM_PCIE_IDRN_SHIFT;
-	raw_spin_lock_irqsave(&port->leg_mask_lock, flags);
+	mask = BIT(data->hwirq + XILINX_CPM_PCIE_IDRN_SHIFT);
+	raw_spin_lock_irqsave(&port->lock, flags);
  	val = pcie_read(port, XILINX_CPM_PCIE_REG_IDRN_MASK);
  	pcie_write(port, (val | mask), XILINX_CPM_PCIE_REG_IDRN_MASK);
-	raw_spin_unlock_irqrestore(&port->leg_mask_lock, flags);
+	raw_spin_unlock_irqrestore(&port->lock, flags);
  }

  static struct irq_chip xilinx_cpm_leg_irq_chip = {
-	.name = "xilinx_cpm_pcie:legacy",
-	.irq_enable = xilinx_cpm_unmask_leg_irq,
-	.irq_disable = xilinx_cpm_mask_leg_irq,
-	.irq_mask = xilinx_cpm_mask_leg_irq,
-	.irq_unmask = xilinx_cpm_unmask_leg_irq,
+	.name		= "INTx",
+	.irq_mask	= xilinx_cpm_mask_leg_irq,
+	.irq_unmask	= xilinx_cpm_unmask_leg_irq,
  };

+static void xilinx_cpm_pcie_intx_flow(struct irq_desc *desc)
+{
+	struct xilinx_cpm_pcie_port *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long val;
+	int i;
+
+	chained_irq_enter(chip, desc);
+
+	val = FIELD_GET(XILINX_CPM_PCIE_IDRN_MASK,
+			pcie_read(port, XILINX_CPM_PCIE_REG_IDRN));
+
+	for_each_set_bit(i, &val, PCI_NUM_INTX)
+		generic_handle_irq(irq_find_mapping(port->intx_domain, i));
+
+	chained_irq_exit(chip, desc);
+}
+
  /**
   * xilinx_cpm_pcie_intx_map - Set the handler for the INTx and mark IRQ 
as valid
   * @domain: IRQ domain
@@ -187,111 +228,130 @@ static const struct irq_domain_ops 
intx_domain_ops = {
  	.map = xilinx_cpm_pcie_intx_map,
  };

-/**
- * xilinx_cpm_pcie_intr_handler - Interrupt Service Handler
- * @irq: IRQ number
- * @data: PCIe port information
- *
- * Return: IRQ_HANDLED on success and IRQ_NONE on failure
- */
-static irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void *data)
+static void xilinx_cpm_mask_event_irq(struct irq_data *d)
  {
-	struct xilinx_cpm_pcie_port *port = data;
-	struct device *dev = port->dev;
-	u32 val, mask, status, bit;
-	unsigned long intr_val;
-
-	/* Read interrupt decode and mask registers */
-	val = pcie_read(port, XILINX_CPM_PCIE_REG_IDR);
-	mask = pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
-
-	status = val & mask;
-	if (!status)
-		return IRQ_NONE;
-
-	if (status & XILINX_CPM_PCIE_INTR_LINK_DOWN)
-		dev_warn(dev, "Link Down\n");
-
-	if (status & XILINX_CPM_PCIE_INTR_HOT_RESET)
-		dev_info(dev, "Hot reset\n");
-
-	if (status & XILINX_CPM_PCIE_INTR_CFG_TIMEOUT)
-		dev_warn(dev, "ECAM access timeout\n");
-
-	if (status & XILINX_CPM_PCIE_INTR_CORRECTABLE) {
-		dev_warn(dev, "Correctable error message\n");
-		cpm_pcie_clear_err_interrupts(port);
-	}
-
-	if (status & XILINX_CPM_PCIE_INTR_NONFATAL) {
-		dev_warn(dev, "Non fatal error message\n");
-		cpm_pcie_clear_err_interrupts(port);
-	}
-
-	if (status & XILINX_CPM_PCIE_INTR_FATAL) {
-		dev_warn(dev, "Fatal error message\n");
-		cpm_pcie_clear_err_interrupts(port);
-	}
-
-	if (status & XILINX_CPM_PCIE_INTR_INTX) {
-		/* Handle INTx Interrupt */
-		intr_val = pcie_read(port, XILINX_CPM_PCIE_REG_IDRN);
-		intr_val = intr_val >> XILINX_CPM_PCIE_IDRN_SHIFT;
-
-		for_each_set_bit(bit, &intr_val, PCI_NUM_INTX)
-			generic_handle_irq(irq_find_mapping(port->leg_domain,
-							    bit));
-	}
-
-	if (status & XILINX_CPM_PCIE_INTR_SLV_UNSUPP)
-		dev_warn(dev, "Slave unsupported request\n");

-	if (status & XILINX_CPM_PCIE_INTR_SLV_UNEXP)
-		dev_warn(dev, "Slave unexpected completion\n");
+	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(d);
+	u32 val;

-	if (status & XILINX_CPM_PCIE_INTR_SLV_COMPL)
-		dev_warn(dev, "Slave completion timeout\n");
+	raw_spin_lock(&port->lock);
+	val = pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
+	val &= ~d->hwirq;
+	pcie_write(port, val, XILINX_CPM_PCIE_REG_IMR);
+	raw_spin_unlock(&port->lock);
+}

-	if (status & XILINX_CPM_PCIE_INTR_SLV_ERRP)
-		dev_warn(dev, "Slave Error Poison\n");
+static void xilinx_cpm_unmask_event_irq(struct irq_data *d)
+{
+	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(d);
+	u32 val;

-	if (status & XILINX_CPM_PCIE_INTR_SLV_CMPABT)
-		dev_warn(dev, "Slave Completer Abort\n");
+	raw_spin_lock(&port->lock);
+	val = pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
+	val |= d->hwirq;
+	pcie_write(port, val, XILINX_CPM_PCIE_REG_IMR);
+	raw_spin_unlock(&port->lock);
+}

-	if (status & XILINX_CPM_PCIE_INTR_SLV_ILLBUR)
-		dev_warn(dev, "Slave Illegal Burst\n");
+static struct irq_chip xilinx_cpm_event_irq_chip = {
+	.name		= "RC-Event",
+	.irq_mask	= xilinx_cpm_mask_event_irq,
+	.irq_unmask	= xilinx_cpm_unmask_event_irq,
+};

-	if (status & XILINX_CPM_PCIE_INTR_MST_DECERR)
-		dev_warn(dev, "Master decode error\n");
+static int xilinx_cpm_pcie_event_map(struct irq_domain *domain,
+				    unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &xilinx_cpm_event_irq_chip,
+				 handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+	irq_set_status_flags(irq, IRQ_LEVEL);

-	if (status & XILINX_CPM_PCIE_INTR_MST_SLVERR)
-		dev_warn(dev, "Master slave error\n");
+	return 0;
+}

-	if (status & XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT)
-		dev_warn(dev, "PCIe ECAM access timeout\n");
+static const struct irq_domain_ops event_domain_ops = {
+	.map = xilinx_cpm_pcie_event_map,
+};

-	if (status & XILINX_CPM_PCIE_INTR_CFG_ERR_POISON)
-		dev_warn(dev, "ECAM poisoned completion received\n");
+static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
+{
+	struct xilinx_cpm_pcie_port *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long val;
+	int i;

-	if (status & XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD)
-		dev_warn(dev, "PME_TO_ACK message received\n");
+	chained_irq_enter(chip, desc);

-	if (status & XILINX_CPM_PCIE_INTR_PM_PME_RCVD)
-		dev_warn(dev, "PM_PME message received\n");
+	val =  pcie_read(port, XILINX_CPM_PCIE_REG_IDR);
+	val &= pcie_read(port, XILINX_CPM_PCIE_REG_IMR);

-	if (status & XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT)
-		dev_warn(dev, "PCIe completion timeout received\n");
+	for_each_set_bit(i, &val, 32)
+		generic_handle_irq(irq_find_mapping(port->cpm_domain, i));

  	/* Clear the Interrupt Decode register */
-	pcie_write(port, status, XILINX_CPM_PCIE_REG_IDR);
+	pcie_write(port, val, XILINX_CPM_PCIE_REG_IDR);

  	/*
  	 * XILINX_CPM_PCIE_MISC_IR_STATUS register is mapped to
  	 * CPM SLCR block.
  	 */
-	val = readl(port->cpm_base + XILINX_CPM_PCIE_MISC_IR_STATUS);
+	val = readl_relaxed(port->cpm_base + XILINX_CPM_PCIE_MISC_IR_STATUS);
  	if (val)
-		writel(val, port->cpm_base + XILINX_CPM_PCIE_MISC_IR_STATUS);
+		writel_relaxed(val, port->cpm_base + XILINX_CPM_PCIE_MISC_IR_STATUS);
+
+	chained_irq_exit(chip, desc);
+}
+
+#define _IC(x, s)				\
+	[XILINX_CPM_PCIE_INTR_ ## x] = { __stringify(x), s }
+
+static const struct {
+	const char	*sym;
+	const char	*str;
+} intr_cause[32] = {
+	_IC(LINK_DOWN,		"Link Down"),
+	_IC(HOT_RESET,		"Hot reset"),
+	_IC(CFG_TIMEOUT,	"ECAM access timeout"),
+	_IC(CORRECTABLE,	"Correctable error message"),
+	_IC(NONFATAL,		"Non fatal error message"),
+	_IC(FATAL,		"Fatal error message"),
+	_IC(SLV_UNSUPP,		"Slave unsupported request"),
+	_IC(SLV_UNEXP,		"Slave unexpected completion"),
+	_IC(SLV_COMPL,		"Slave completion timeout"),
+	_IC(SLV_ERRP,		"Slave Error Poison"),
+	_IC(SLV_CMPABT,		"Slave Completer Abort"),
+	_IC(SLV_ILLBUR,		"Slave Illegal Burst"),
+	_IC(MST_DECERR,		"Master decode error"),
+	_IC(MST_SLVERR,		"Master slave error"),
+	_IC(CFG_PCIE_TIMEOUT,	"PCIe ECAM access timeout"),
+	_IC(CFG_ERR_POISON,	"ECAM poisoned completion received"),
+	_IC(PME_TO_ACK_RCVD,	"PME_TO_ACK message received"),
+	_IC(PM_PME_RCVD,	"PM_PME message received"),
+	_IC(SLV_PCIE_TIMEOUT,	"PCIe completion timeout received"),
+};
+
+static irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void *dev_id)
+{
+	struct xilinx_cpm_pcie_port *port = dev_id;
+	struct device *dev = port->dev;
+	struct irq_data *d;
+
+	d = irq_domain_get_irq_data(port->cpm_domain, irq);
+
+	switch(d->hwirq) {
+	case XILINX_CPM_PCIE_INTR_CORRECTABLE:
+	case XILINX_CPM_PCIE_INTR_NONFATAL:
+	case XILINX_CPM_PCIE_INTR_FATAL:
+		cpm_pcie_clear_err_interrupts(port);
+		fallthrough;
+
+	default:
+		if (intr_cause[d->hwirq].str)
+			dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
+		else
+			dev_warn(dev, "Unknown interrupt\n");
+	}

  	return IRQ_HANDLED;
  }
@@ -315,17 +375,41 @@ static int xilinx_cpm_pcie_init_irq_domain(struct 
xilinx_cpm_pcie_port *port)
  		return -EINVAL;
  	}

-	port->leg_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
+	port->cpm_domain = irq_domain_add_linear(pcie_intc_node, 32,
+						 &event_domain_ops,
+						 port);
+	if (!port->cpm_domain)
+		goto out;
+
+	irq_domain_update_bus_token(port->cpm_domain, DOMAIN_BUS_NEXUS);
+
+	port->intx_domain = irq_domain_add_linear(pcie_intc_node, 
PCI_NUM_INTX,
  						 &intx_domain_ops,
  						 port);
+	if (!port->intx_domain)
+		goto out;
+
+	irq_domain_update_bus_token(port->intx_domain, DOMAIN_BUS_WIRED);
+
  	of_node_put(pcie_intc_node);
-	if (!port->leg_domain) {
-		dev_err(dev, "Failed to get a INTx IRQ domain\n");
-		return -ENOMEM;
-	}
+	raw_spin_lock_init(&port->lock);

-	raw_spin_lock_init(&port->leg_mask_lock);
  	return 0;
+
+out:
+	of_node_put(pcie_intc_node);
+	if (port->intx_domain) {
+		irq_domain_remove(port->intx_domain);
+		port->intx_domain = NULL;
+	}
+
+	if (port->cpm_domain) {
+		irq_domain_remove(port->cpm_domain);
+		port->cpm_domain = NULL;
+	}
+
+	dev_err(dev, "Failed to allocate IRQ domains\n");
+	return -ENOMEM;
  }

  /**
@@ -348,12 +432,6 @@ static void xilinx_cpm_pcie_init_port(struct 
xilinx_cpm_pcie_port *port)
  		   XILINX_CPM_PCIE_IMR_ALL_MASK,
  		   XILINX_CPM_PCIE_REG_IDR);

-	/* Enable all interrupts */
-	pcie_write(port, XILINX_CPM_PCIE_IMR_ALL_MASK,
-		   XILINX_CPM_PCIE_REG_IMR);
-	pcie_write(port, XILINX_CPM_PCIE_IDRN_MASK,
-		   XILINX_CPM_PCIE_REG_IDRN_MASK);
-
  	/*
  	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
  	 * CPM SLCR block.
@@ -366,28 +444,45 @@ static void xilinx_cpm_pcie_init_port(struct 
xilinx_cpm_pcie_port *port)
  		   XILINX_CPM_PCIE_REG_RPSC);
  }

-static int xilinx_cpm_request_misc_irq(struct xilinx_cpm_pcie_port 
*port)
+static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie_port *port)
  {
  	struct device *dev = port->dev;
  	struct platform_device *pdev = to_platform_device(dev);
-	int err;
+	int i, irq;

-	port->irq_misc = platform_get_irq(pdev, 0);
-	if (port->irq_misc <= 0) {
-		dev_err(dev, "Unable to find misc IRQ line\n");
-		return port->irq_misc;
+	port->irq = platform_get_irq(pdev, 0);
+	if (port->irq < 0) {
+		dev_err(dev, "Unable to find IRQ line\n");
+		return port->irq;
  	}

-	err = devm_request_irq(dev, port->irq_misc,
-			       xilinx_cpm_pcie_intr_handler,
-			       IRQF_SHARED | IRQF_NO_THREAD,
-			       "xilinx-pcie", port);
-	if (err) {
-		dev_err(dev, "unable to request misc IRQ line %d\n",
-			port->irq_misc);
-		return err;
+	for (i = 0; i < ARRAY_SIZE(intr_cause); i++) {
+		int err;
+
+		if (!intr_cause[i].str)
+			continue;
+
+		irq = irq_create_mapping(port->cpm_domain, i);
+		if (WARN_ON(irq <= 0))
+			return -ENXIO;
+
+		err = devm_request_irq(dev, irq, xilinx_cpm_pcie_intr_handler,
+				       0, intr_cause[i].sym, port);
+		if (WARN_ON(err))
+			return err;
  	}

+	irq = irq_create_mapping(port->cpm_domain, XILINX_CPM_PCIE_INTR_INTX);
+	if (WARN_ON(irq <= 0))
+		return -ENXIO;
+
+	/* Plug the INTx chained handler */
+	irq_set_chained_handler_and_data(irq, xilinx_cpm_pcie_intx_flow, 
port);
+
+	/* Plug the main event chained handler */
+	irq_set_chained_handler_and_data(port->irq, 
xilinx_cpm_pcie_event_flow,
+					 port);
+
  	return 0;
  }

@@ -422,7 +517,7 @@ static int xilinx_cpm_pcie_parse_dt(struct 
xilinx_cpm_pcie_port *port,
  	if (IS_ERR(port->cpm_base))
  		return PTR_ERR(port->cpm_base);

-	err = xilinx_cpm_request_misc_irq(port);
+	err = xilinx_cpm_setup_irq(port);
  	if (err)
  		return err;

@@ -481,8 +576,10 @@ static int xilinx_cpm_pcie_probe(struct 
platform_device *pdev)

  	err = pci_host_probe(bridge);
  	if (err < 0) {
-		irq_domain_remove(port->leg_domain);
-		devm_free_irq(dev, port->irq_misc, port);
+		if (port->intx_domain)
+			irq_domain_remove(port->intx_domain);
+		if (port->cpm_domain)
+			irq_domain_remove(port->cpm_domain);
  		return err;
  	}

-- 
2.26.2


-- 
Jazz is not dead. It just smells funny...
