Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D61A1F1E9E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jun 2020 19:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgFHR6s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jun 2020 13:58:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgFHR6s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Jun 2020 13:58:48 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C726820760;
        Mon,  8 Jun 2020 17:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591639126;
        bh=/01VxRlupY9gEKxBoDnrP4bB7UEhbNoqOPe8p5gtWUM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=y1xBofL4f9WdGHyzGZbtxiqFMhyOL4LetO7bPe27slvsr1Y4b3MquaFhJdaL2t3k2
         79mtV8lRoxcA/3ZN85dPLLTysdqBzOQWcZfwHknWH78FbQcFBnijlvxgEpUDwASdPO
         ko+EphP/WqV1fLgAuGCwInIDcsePE9xbt9zajOSQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jiM2m-001BUO-93; Mon, 08 Jun 2020 18:58:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Jun 2020 18:58:44 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org
Subject: Re: [PATCH v8 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
In-Reply-To: <1591622338-22652-3-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1591622338-22652-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1591622338-22652-3-git-send-email-bharat.kumar.gogada@xilinx.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <c2e4b1288ce454c6ae2b2c02946d084f@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: bharat.kumar.gogada@xilinx.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bharat,

On 2020-06-08 14:18, Bharat Kumar Gogada wrote:
> - Add support for Versal CPM as Root Port.
> - The Versal ACAP devices include CCIX-PCIe Module (CPM). The 
> integrated
>   block for CPM along with the integrated bridge can function
>   as PCIe Root Port.
> - Bridge error and legacy interrupts in Versal CPM are handled using
>   Versal CPM specific interrupt line.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Please don't. Either you take my initial patch as is (potentially
with reworks that we discuss on the list), or you add a note
saying that I suggested some of the changes. But do not add my Sob
without me agreeing to it, specially when there are changes that
I object to (see below).

> ---
>  drivers/pci/controller/Kconfig           |   8 +
>  drivers/pci/controller/Makefile          |   1 +
>  drivers/pci/controller/pcie-xilinx-cpm.c | 621 
> +++++++++++++++++++++++++++++++
>  3 files changed, 630 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c
> 
> diff --git a/drivers/pci/controller/Kconfig 
> b/drivers/pci/controller/Kconfig
> index 20bf00f..d9e393a 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -81,6 +81,14 @@ config PCIE_XILINX
>  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
>  	  Host Bridge driver.
> 
> +config PCIE_XILINX_CPM
> +	bool "Xilinx Versal CPM host bridge support"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	select PCI_HOST_COMMON
> +	help
> +	  Say 'Y' here if you want kernel support for the
> +	  Xilinx Versal CPM host bridge.
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
> index 0000000..5bc481e
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -0,0 +1,621 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * PCIe host controller driver for Xilinx Versal CPM DMA Bridge
> + *
> + * (C) Copyright 2019 - 2020, Xilinx, Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
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
> +#define XILINX_CPM_PCIE_INTR_LINK_DOWN		0
> +#define XILINX_CPM_PCIE_INTR_HOT_RESET		3
> +#define XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT	4
> +#define XILINX_CPM_PCIE_INTR_CFG_TIMEOUT	8
> +#define XILINX_CPM_PCIE_INTR_CORRECTABLE	9
> +#define XILINX_CPM_PCIE_INTR_NONFATAL		10
> +#define XILINX_CPM_PCIE_INTR_FATAL		11
> +#define XILINX_CPM_PCIE_INTR_CFG_ERR_POISON	12
> +#define XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD	15
> +#define XILINX_CPM_PCIE_INTR_INTX		16
> +#define XILINX_CPM_PCIE_INTR_PM_PME_RCVD	17
> +#define XILINX_CPM_PCIE_INTR_SLV_UNSUPP		20
> +#define XILINX_CPM_PCIE_INTR_SLV_UNEXP		21
> +#define XILINX_CPM_PCIE_INTR_SLV_COMPL		22
> +#define XILINX_CPM_PCIE_INTR_SLV_ERRP		23
> +#define XILINX_CPM_PCIE_INTR_SLV_CMPABT		24
> +#define XILINX_CPM_PCIE_INTR_SLV_ILLBUR		25
> +#define XILINX_CPM_PCIE_INTR_MST_DECERR		26
> +#define XILINX_CPM_PCIE_INTR_MST_SLVERR		27
> +#define XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT	28
> +
> +#define IMR(x) BIT(XILINX_CPM_PCIE_INTR_ ##x)
> +
> +#define IMR(x) BIT(XILINX_CPM_PCIE_INTR_ ##x)

Why do we have this twice?

> +
> +#define XILINX_CPM_PCIE_IMR_ALL_MASK			\
> +	(						\
> +		IMR(LINK_DOWN)		|               \

nit: Please use tabs between | and \.

> +		IMR(HOT_RESET)		|               \
> +		IMR(CFG_PCIE_TIMEOUT)	|               \
> +		IMR(CFG_TIMEOUT)	|               \
> +		IMR(CORRECTABLE)	|               \
> +		IMR(NONFATAL)		|               \
> +		IMR(FATAL)		|               \
> +		IMR(CFG_ERR_POISON)	|               \
> +		IMR(PME_TO_ACK_RCVD)	|               \
> +		IMR(INTX)		|               \
> +		IMR(PM_PME_RCVD)	|               \
> +		IMR(SLV_UNSUPP)		|               \
> +		IMR(SLV_UNEXP)		|               \
> +		IMR(SLV_COMPL)		|               \
> +		IMR(SLV_ERRP)		|               \
> +		IMR(SLV_CMPABT)		|               \
> +		IMR(SLV_ILLBUR)		|               \
> +		IMR(MST_DECERR)		|               \
> +		IMR(MST_SLVERR)		|               \
> +		IMR(SLV_PCIE_TIMEOUT)			\
> +	)
> +
> +#define XILINX_CPM_PCIE_IDR_ALL_MASK		0xFFFFFFFF
> +#define XILINX_CPM_PCIE_IDRN_MASK		GENMASK(19, 16)
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
> + * @intx_domain: Legacy IRQ domain pointer
> + * @cfg: Holds mappings of config space window
> + * @intx_irq: legacy interrupt number
> + * @irq: Error interrupt number
> + * @lock: lock protecting shared register access
> + */
> +struct xilinx_cpm_pcie_port {
> +	void __iomem			*reg_base;
> +	void __iomem			*cpm_base;
> +	struct device			*dev;
> +	struct irq_domain		*intx_domain;
> +	struct irq_domain		*cpm_domain;
> +	struct pci_config_window	*cfg;
> +	int				intx_irq;
> +	int				irq;
> +	raw_spinlock_t			lock;
> +};
> +
> +static u32 pcie_read(struct xilinx_cpm_pcie_port *port, u32 reg)
> +{
> +	return readl_relaxed(port->reg_base + reg);
> +}
> +
> +static void pcie_write(struct xilinx_cpm_pcie_port *port,
> +		       u32 val, u32 reg)
> +{
> +	writel_relaxed(val, port->reg_base + reg);
> +}
> +
> +static bool cpm_pcie_link_up(struct xilinx_cpm_pcie_port *port)
> +{
> +	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
> +		XILINX_CPM_PCIE_REG_PSCR_LNKUP);
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
> +	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(data);
> +	unsigned long flags;
> +	u32 mask;
> +	u32 val;
> +
> +	mask = BIT(data->hwirq + XILINX_CPM_PCIE_IDRN_SHIFT);
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val = pcie_read(port, XILINX_CPM_PCIE_REG_IDRN_MASK);
> +	pcie_write(port, (val & (~mask)), XILINX_CPM_PCIE_REG_IDRN_MASK);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static void xilinx_cpm_unmask_leg_irq(struct irq_data *data)
> +{
> +	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(data);
> +	unsigned long flags;
> +	u32 mask;
> +	u32 val;
> +
> +	mask = BIT(data->hwirq + XILINX_CPM_PCIE_IDRN_SHIFT);
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val = pcie_read(port, XILINX_CPM_PCIE_REG_IDRN_MASK);
> +	pcie_write(port, (val | mask), XILINX_CPM_PCIE_REG_IDRN_MASK);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static struct irq_chip xilinx_cpm_leg_irq_chip = {
> +	.name = "INTx",
> +	.irq_mask = xilinx_cpm_mask_leg_irq,
> +	.irq_unmask = xilinx_cpm_unmask_leg_irq,

nit: Please align the assignments vertically:

static struct irq_chip xilinx_cpm_leg_irq_chip = {
	.name		= "INTx",
	.irq_mask	= xilinx_cpm_mask_leg_irq,
	.irq_unmask	= xilinx_cpm_unmask_leg_irq,
};


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
> +static void xilinx_cpm_pcie_intx_flow(struct irq_desc *desc)
> +{
> +	struct xilinx_cpm_pcie_port *port = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned long val;
> +	int i;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	val = FIELD_GET(XILINX_CPM_PCIE_IDRN_MASK,
> +			pcie_read(port, XILINX_CPM_PCIE_REG_IDRN));
> +
> +	for_each_set_bit(i, &val, PCI_NUM_INTX)
> +		generic_handle_irq(irq_find_mapping(port->intx_domain, i));
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void xilinx_cpm_mask_event_irq(struct irq_data *d)
> +{
> +	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(d);
> +	u32 val;
> +
> +	raw_spin_lock(&port->lock);
> +	val = pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
> +	val &= ~d->hwirq;
> +	pcie_write(port, val, XILINX_CPM_PCIE_REG_IMR);
> +	raw_spin_unlock(&port->lock);
> +}
> +
> +static void xilinx_cpm_unmask_event_irq(struct irq_data *d)
> +{
> +	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(d);
> +	u32 val;
> +
> +	raw_spin_lock(&port->lock);
> +	val = pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
> +	val |= d->hwirq;
> +	pcie_write(port, val, XILINX_CPM_PCIE_REG_IMR);
> +	raw_spin_unlock(&port->lock);
> +}
> +
> +static struct irq_chip xilinx_cpm_event_irq_chip = {
> +	.name           = "RC-Event",
> +	.irq_mask       = xilinx_cpm_mask_event_irq,
> +	.irq_unmask     = xilinx_cpm_unmask_event_irq,

nit: Please use tabs between the field name and the = sign.

> +};
> +
> +static int xilinx_cpm_pcie_event_map(struct irq_domain *domain,
> +				     unsigned int irq, irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &xilinx_cpm_event_irq_chip,
> +				 handle_level_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_status_flags(irq, IRQ_LEVEL);
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops event_domain_ops = {
> +	.map = xilinx_cpm_pcie_event_map,
> +};
> +
> +static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
> +{
> +	struct xilinx_cpm_pcie_port *port = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned long val;
> +	int i;
> +
> +	chained_irq_enter(chip, desc);
> +	val =  pcie_read(port, XILINX_CPM_PCIE_REG_IDR);
> +	val &= pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
> +	for_each_set_bit(i, &val, 32)
> +		generic_handle_irq(irq_find_mapping(port->cpm_domain, i));
> +	pcie_write(port, val, XILINX_CPM_PCIE_REG_IDR);
> +
> +	/*
> +	 * XILINX_CPM_PCIE_MISC_IR_STATUS register is mapped to
> +	 * CPM SLCR block.
> +	 */
> +	val = readl_relaxed(port->cpm_base + XILINX_CPM_PCIE_MISC_IR_STATUS);
> +	if (val)
> +		writel_relaxed(val,
> +			       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_STATUS);

The write_relaxed() call would be more readable on a single line.

> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +#define _IC(x, s)                              \
> +	[XILINX_CPM_PCIE_INTR_ ## x] = { __stringify(x), s }
> +
> +static const struct {
> +	const char      *sym;
> +	const char      *str;
> +} intr_cause[32] = {
> +	_IC(LINK_DOWN,		"Link Down"),
> +	_IC(HOT_RESET,		"Hot reset"),
> +	_IC(CFG_TIMEOUT,	"ECAM access timeout"),
> +	_IC(CORRECTABLE,	"Correctable error message"),
> +	_IC(NONFATAL,		"Non fatal error message"),
> +	_IC(FATAL,		"Fatal error message"),
> +	_IC(SLV_UNSUPP,		"Slave unsupported request"),
> +	_IC(SLV_UNEXP,		"Slave unexpected completion"),
> +	_IC(SLV_COMPL,		"Slave completion timeout"),
> +	_IC(SLV_ERRP,		"Slave Error Poison"),
> +	_IC(SLV_CMPABT,		"Slave Completer Abort"),
> +	_IC(SLV_ILLBUR,		"Slave Illegal Burst"),
> +	_IC(MST_DECERR,		"Master decode error"),
> +	_IC(MST_SLVERR,		"Master slave error"),
> +	_IC(CFG_PCIE_TIMEOUT,	"PCIe ECAM access timeout"),
> +	_IC(CFG_ERR_POISON,	"ECAM poisoned completion received"),
> +	_IC(PME_TO_ACK_RCVD,	"PME_TO_ACK message received"),
> +	_IC(PM_PME_RCVD,	"PM_PME message received"),
> +	_IC(SLV_PCIE_TIMEOUT,	"PCIe completion timeout received"),
> +};
> +
> +static irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void *dev_id)
> +{
> +	struct xilinx_cpm_pcie_port *port = dev_id;
> +	struct device *dev = port->dev;
> +	struct irq_data *d;
> +
> +	d = irq_domain_get_irq_data(port->cpm_domain, irq);
> +
> +	switch (d->hwirq) {
> +	case XILINX_CPM_PCIE_INTR_CORRECTABLE:
> +	case XILINX_CPM_PCIE_INTR_NONFATAL:
> +	case XILINX_CPM_PCIE_INTR_FATAL:
> +		cpm_pcie_clear_err_interrupts(port);
> +		fallthrough;
> +
> +	default:
> +		if (intr_cause[d->hwirq].str)
> +			dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> +		else
> +			dev_warn(dev, "Unknown interrupt\n");
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void xilinx_cpm_free_irq_domains(struct xilinx_cpm_pcie_port 
> *port)
> +{
> +	if (port->intx_domain) {
> +		irq_domain_remove(port->intx_domain);
> +		port->intx_domain = NULL;
> +	}
> +
> +	if (port->cpm_domain) {
> +		irq_domain_remove(port->cpm_domain);
> +		port->cpm_domain = NULL;
> +	}
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
> +	port->cpm_domain = irq_domain_add_linear(node, 32,

No. The domain must be attached to the intc node, not to the RC.
Why would you have this intc node otherwise?

> +						 &event_domain_ops,
> +						 port);
> +	if (!port->cpm_domain)
> +		goto out;
> +
> +	irq_domain_update_bus_token(port->cpm_domain, DOMAIN_BUS_NEXUS);
> +
> +	port->intx_domain = irq_domain_add_linear(pcie_intc_node, 
> PCI_NUM_INTX,
> +						  &intx_domain_ops,
> +						  port);
> +	if (!port->intx_domain)
> +		goto out;
> +
> +	irq_domain_update_bus_token(port->intx_domain, DOMAIN_BUS_WIRED);
> +
> +	of_node_put(pcie_intc_node);
> +	raw_spin_lock_init(&port->lock);
> +
> +	return 0;
> +out:
> +	xilinx_cpm_free_irq_domains(port);
> +	dev_err(dev, "Failed to allocate IRQ domains\n");
> +
> +	return -ENOMEM;
> +}
> +
> +static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie_port *port)
> +{
> +	struct device *dev = port->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int i, irq;
> +
> +	port->irq = platform_get_irq(pdev, 0);
> +	if (port->irq < 0) {
> +		dev_err(dev, "Unable to find misc IRQ line\n");
> +		return port->irq;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(intr_cause); i++) {
> +		int err;
> +
> +		if (!intr_cause[i].str)
> +			continue;
> +
> +		irq = irq_create_mapping(port->cpm_domain, i);
> +		if (WARN_ON(irq <= 0))
> +			return -ENXIO;
> +
> +		err = devm_request_irq(dev, irq, xilinx_cpm_pcie_intr_handler,
> +				       0, intr_cause[i].sym, port);
> +		if (WARN_ON(err))
> +			return err;
> +	}
> +
> +	port->intx_irq = irq_create_mapping(port->cpm_domain,
> +					    XILINX_CPM_PCIE_INTR_INTX);
> +	if (WARN_ON(port->intx_irq <= 0))
> +		return -ENXIO;
> +
> +	/* Plug the INTx chained handler */
> +	irq_set_chained_handler_and_data(port->intx_irq,
> +					 xilinx_cpm_pcie_intx_flow, port);
> +
> +	/* Plug the main event chained handler */
> +	irq_set_chained_handler_and_data(port->irq,
> +					 xilinx_cpm_pcie_event_flow, port);
> +
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

No. I've explained in the previous review why this was a terrible thing
to do, and my patch got rid of it for a good reason.

If the mask/unmask calls do not work, please explain what is wrong, and
let's fix them. But we DO NOT enable interrupts outside of an irqchip
callback, full stop.

         M.
-- 
Jazz is not dead. It just smells funny...
