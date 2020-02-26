Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 466871705FC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 18:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgBZRY0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 12:24:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgBZRYZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Feb 2020 12:24:25 -0500
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D8CA20838;
        Wed, 26 Feb 2020 17:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582737863;
        bh=T4BeqlHcZvpMqbx/pla6s01//ZojrIz8xMxtkTecplM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jTPZGF6lM6TP3lOQ45cZdpn6QCitERJzM9/iaFm/IdqQU1COCOP78cLZ/dfViuQkp
         5lCCv29CMcsHxaUEmOt81W+PS6q3iP7QCP0d0qZTt32H3CEx1K0GRJNH9v2sYU4QC1
         fA4I8kSiV43XcEnJqUzgBA6TEGU3evRWEz5KqIgg=
Date:   Wed, 26 Feb 2020 11:24:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daire McNamara <daire.mcnamara@microchip.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI: Microchip: Add host driver for Microchip PCIe
 controller
Message-ID: <20200226172422.GA120511@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226131230.GA8160@IRD-LT-X61553B.mchp-main.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

FYI, saving this message and applying with "git am" fails:

  08:38:22 ~/linux (review/02-26-daire-microchip)$ git am m/02-26-daire-microchip
  Patch is empty.
  When you have resolved this problem, run "git am --continue".
  If you prefer to skip this patch, run "git am --skip" instead.
  To restore the original branch and stop patching, run "git am --abort".

Probably easy for Lorenzo to fix, but even easier if it applies
cleanly.

On Wed, Feb 26, 2020 at 01:12:31PM +0000, Daire McNamara wrote:
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> --
> This v4 patch series adds support for PCIe IP block on Microchip PolarFire SoC.
> 
> Updates since v3:
> * Update all references to Microsemi to Microchip
> * Separate MSI functionality from legacy PCIe interrupt handling functionality
> 
> Updates since v2:
> * Split out DT bindings and Vendor ID updates into their own patch
>   from PCIe driver.
> * Updated Change Log
> 
> Updates since v1:
> * Incorporate feedback from Bjorn Helgaas
> 
> 
> Daire McNamara (1):
>   PCI: microchip: Add host driver for Microchip PCIe controller
> 
>  .../bindings/pci/microchip-pcie.txt           |  64 ++
>  drivers/pci/controller/Kconfig                |   7 +
>  drivers/pci/controller/Makefile               |   1 +
>  drivers/pci/controller/pcie-microchip.c       | 789 ++++++++++++++++++
>  4 files changed, 861 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/microchip-pcie.txt
>  create mode 100644 drivers/pci/controller/pcie-microchip.c
> 
> -- 
> 2.17.1
> 
> From 6d51fe16aeb7dac00b55b99724eaf738d9a144b9 Mon Sep 17 00:00:00 2001
> From: Daire McNamara <daire.mcnamara@microchip.com>
> Date: Thu, 13 Feb 2020 16:57:14 +0000
> Subject: [PATCH v4] PCI: microchip: Add host driver for Microchip PCIe controller
> 
> This patch adds support for the Microchip PolarFire PCIe
> controller when configured in host (Root Complex) mode.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  .../bindings/pci/microchip-pcie.txt           |  64 ++
>  drivers/pci/controller/Kconfig                |   7 +
>  drivers/pci/controller/Makefile               |   1 +
>  drivers/pci/controller/pcie-microchip.c       | 789 ++++++++++++++++++
>  4 files changed, 861 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/microchip-pcie.txt
>  create mode 100644 drivers/pci/controller/pcie-microchip.c
> 
> diff --git a/Documentation/devicetree/bindings/pci/microchip-pcie.txt b/Documentation/devicetree/bindings/pci/microchip-pcie.txt
> new file mode 100644
> index 000000000000..4e226545d3f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/microchip-pcie.txt
> @@ -0,0 +1,64 @@
> +* Microchip AXI PCIe Root Port Bridge DT description
> +
> +Required properties:
> +- #address-cells: Address representation for root ports, set to <3>
> +- #size-cells: Size representation for root ports, set to <2>
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +	interrupt source. The value must be 1.
> +- compatible: Should contain "microchip,pf-axi-pcie-host"
> +- reg: Should contain two address length tuples. 
> +	The first is for the internal PCI bridge registers
> +	The second is for the PCI config space access registers
> +- device_type: must be "pci"
> +- interrupts: Should contain AXI PCIe interrupt
> +- interrupt-map-mask,
> +- interrupt-map: standard PCI properties to define the mapping of the
> +	PCI interface to interrupt numbers.
> +- ranges: ranges for the PCI memory regions (I/O space region is not
> +	supported by hardware)
> +	Please refer to the standard PCI bus binding document for a more
> +	detailed explanation
> +
> +Optional properties for PolarFire:
> +- bus-range: PCI bus numbers covered
> +
> +Interrupt controller child node
> ++++++++++++++++++++++++++++++++
> +Required properties:
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #address-cells: specifies the number of cells needed to encode an
> +	address. The value must be 0.
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +	interrupt source. The value must be 1.
> +
> +NOTE:
> +The core provides a single interrupt for both INTx/MSI messages. So,
> +create an interrupt controller node to support 'interrupt-map' DT
> +functionality.  The driver will create an IRQ domain for this map, decode
> +the four INTx interrupts in ISR and route them to this domain.
> +
> +
> +Example:
> +++++++++
> +AloeVera:
> +
> +	pcie: pcie@2030000000 {
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		#interrupt-cells = <1>;
> +		compatible = "microchip,pf-axi-pcie-host-1.0";
> +		device_type = "pci";
> +		bus-range = <0x01 0x7f>;
> +		interrupt-map = <0 0 0 1 &pcie 1>,
> +				<0 0 0 2 &pcie 2>,
> +				<0 0 0 3 &pcie 3>,
> +				<0 0 0 4 &pcie 4>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-parent = <&L4>;
> +		interrupts = <32>;
> +		ranges = <0x3000000 0 0x40000000 0x0 0x40000000 0x0 0x20000000>;
> +		reg = <0x20 0x30000000 0x0 0x4000000>,	/* internal registers */
> +			<0x20 0x0 0x0 0x100000>;	/* config space access registers */
> +		reg-names = "control", "apb";
> +		interrupt-controller;
> +	};
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 6671946dbf66..4e1585be3208 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -280,5 +280,12 @@ config VMD
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called vmd.
>  
> +config PCIE_MICROCHIP

Consider using PCIE_MICROCHIP_HOST.  We've had many cases lately where
the device can operate either as a host or an endpoint, so including
"_HOST" is a nice hint.

> +	bool "Microchip AXI PCIe host bridge support"
> +	depends on PCI_MSI && OF
> +	help
> +	  Say Y here if you want kernel to support the Microchip AXI PCIe
> +	  Host Bridge driver.
> +
>  source "drivers/pci/controller/dwc/Kconfig"
>  endmenu
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index d56a507495c5..cb5ef5ccf1f6 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
>  obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
>  obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
>  obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
> +obj-$(CONFIG_PCIE_MICROCHIP) += pcie-microchip.o
>  obj-$(CONFIG_VMD) += vmd.o
>  # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
>  obj-y				+= dwc/
> diff --git a/drivers/pci/controller/pcie-microchip.c b/drivers/pci/controller/pcie-microchip.c
> new file mode 100644
> index 000000000000..75725cf63b68
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-microchip.c
> @@ -0,0 +1,789 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Microchip AXI PCIe Bridge host controller driver
> + *
> + * Copyright (c) 2018 - 2019 Microchip Corporation. All rights reserved.
> + *
> + * Author: Daire McNamara <daire.mcnamara@microchip.com>
> + *
> + * Based on:
> + *	pcie-rcar.c
> + *	pcie-xilinx.c
> + *	pcie-altera.c
> + */
> +
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/module.h>
> +#include <linux/of_pci.h>

Looks like of_pci.h *could* go with the other of_*.h includes.

> +#include <linux/platform_device.h>
> +
> +#include "../pci.h"
> +
> +/* ECAM definitions */
> +#define ECAM_BUS_NUM_SHIFT			20
> +#define ECAM_DEV_NUM_SHIFT			12
> +
> +/* Number of MSI IRQs */
> +#define MICROCHIP_NUM_MSI_IRQS			32
> +#define MICROCHIP_NUM_MSI_IRQS_CODED		5
> +
> +/* PCIe Bridge Phy and Controller Phy offsets */
> +#define MICROCHIP_PCIE0_BRIDGE_ADDR		0x00004000u
> +#define MICROCHIP_PCIE0_CTRL_ADDR		0x00006000u
> +
> +#define MICROCHIP_PCIE1_BRIDGE_ADDR		0x00008000u
> +#define MICROCHIP_PCIE1_CTRL_ADDR		0x0000a000u
> +
> +/* PCIe Controller Phy Regs */
> +#define MICROCHIP_SEC_ERROR_INT			0x28
> +#define  SEC_ERROR_INT_TX_RAM_SEC_ERR_INT	GENMASK(3, 0)
> +#define  SEC_ERROR_INT_RX_RAM_SEC_ERR_INT	GENMASK(7, 4)
> +#define  SEC_ERROR_INT_PCIE2AXI_RAM_SEC_ERR_INT	GENMASK(11, 8)
> +#define  SEC_ERROR_INT_AXI2PCIE_RAM_SEC_ERR_INT	GENMASK(15, 12)
> +#define MICROCHIP_SEC_ERROR_INT_MASK		0x2c
> +#define MICROCHIP_DED_ERROR_INT			0x30
> +#define  DED_ERROR_INT_TX_RAM_DED_ERR_INT	GENMASK(3, 0)
> +#define  DED_ERROR_INT_RX_RAM_DED_ERR_INT	GENMASK(7, 4)
> +#define  DED_ERROR_INT_PCIE2AXI_RAM_DED_ERR_INT	GENMASK(11, 8)
> +#define  DED_ERROR_INT_AXI2PCIE_RAM_DED_ERR_INT	GENMASK(15, 12)
> +#define MICROCHIP_DED_ERROR_INT_MASK		0x34
> +#define MICROCHIP_ECC_CONTROL			0x38
> +#define  ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS	BIT(27)
> +#define  ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS	BIT(26)
> +#define  ECC_CONTROL_RX_RAM_ECC_BYPASS		BIT(25)
> +#define  ECC_CONTROL_TX_RAM_ECC_BYPASS		BIT(24)
> +#define MICROCHIP_LTSSM_STATE			0x5c
> +#define  LTSSM_L0_STATE				0x10
> +#define MICROCHIP_PCIE_EVENT_INT		0x14c
> +#define  PCIE_EVENT_INT_L2_EXIT_INT		BIT(0)
> +#define  PCIE_EVENT_INT_HOTRST_EXIT_INT		BIT(1)
> +#define  PCIE_EVENT_INT_DLUP_EXIT_INT		BIT(2)
> +#define  PCIE_EVENT_INT_L2_EXIT_INT_MASK	BIT(16)
> +#define  PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK	BIT(17)
> +#define  PCIE_EVENT_INT_DLUP_EXIT_INT_MASK	BIT(18)
> +
> +/* PCIe Bridge Phy Regs */
> +#define MICROCHIP_PCIE_PCI_IDS_DW1		0x9c
> +
> +/* PCIe Config space MSI capability structure */
> +#define MICROCHIP_MSI_CAP_CTRL			0xe0u
> +#define  MSI_ENABLE				(0x01u << 16)
> +#define  MSI_ENABLE_MULTI			\
> +	 (MICROCHIP_NUM_MSI_IRQS_CODED << 20)
> +#define MICROCHIP_MSI_MSG_ADDR			0xe4u
> +#define MICROCHIP_MSI_UPPER_ADDR		0xe8u
> +#define MICROCHIP_MSI_MSG_DATA			0xf0u
> +
> +#define MICROCHIP_IMASK_LOCAL			0x180
> +#define  PCIE_LOCAL_INT_ENABLE			0x0f000000u
> +#define  PCI_INTS				0x0f000000u
> +#define  PM_MSI_INT_SHIFT			24
> +#define  PCIE_ENABLE_MSI			0x10000000u
> +#define  MSI_INT				0x10000000u
> +#define  MSI_INT_SHIFT				28
> +#define MICROCHIP_ISTATUS_LOCAL			0x184
> +#define MICROCHIP_IMASK_HOST			0x188
> +#define MICROCHIP_ISTATUS_HOST			0x18c
> +#define MICROCHIP_ISTATUS_MSI			0x194
> +
> +/* PCIe Master table init defines */
> +#define MICROCHIP_ATR0_PCIE_WIN0_SRCADDR_31_12	0x600u
> +#define  ATR0_PCIE_WIN0_SIZE			0x1f
> +#define  ATR0_PCIE_WIN0_SIZE_SHIFT		1
> +#define MICROCHIP_ATR0_PCIE_WIN0_SRCADDR_63_32	0x604u
> +
> +/* PCIe AXI slave table init defines */
> +#define MICROCHIP_ATR0_AXI4_SLV0_SRCADDR_PARAM	0x800u
> +#define  ATR_SIZE_SHIFT				1
> +#define  ATR_IMPL_ENABLE			1
> +#define MICROCHIP_ATR0_AXI4_SLV0_SRC_ADDR	0x804u
> +#define MICROCHIP_ATR0_AXI4_SLV0_TRSL_ADDR_LSB	0x808u
> +#define MICROCHIP_ATR0_AXI4_SLV0_TRSL_ADDR_UDW	0x80cu
> +#define MICROCHIP_ATR0_AXI4_SLV0_TRSL_PARAM	0x810u
> +#define  PCIE_TX_RX_INTERFACE			0x00000000u
> +#define  PCIE_CONFIG_INTERFACE			0x00000001u
> +#define  ATR0_AXI4_SLV_SIZE			32
> +
> +struct microchip_msi {
> +	struct mutex		lock;		/* protect used bitmap */
> +	struct irq_domain	*msi_domain;
> +	struct irq_domain	*dev_domain;
> +	u32			num_vectors;
> +	u32			vector_phy;
> +	DECLARE_BITMAP(used, MICROCHIP_NUM_MSI_IRQS);

Either line up the members (as above) or don't (as below),
consistently.

> +};
> +
> +/**
> + * struct microchip_pcie - PCIe port information
> + * @base_addr: IO Mapped Register Base
> + * @irq: Interrupt number
> + * @root_busno: Root Bus number
> + * @dev: Device pointer
> + * @leg_domain: Legacy IRQ domain pointer
> + * @resources: Bus Resources
> + */
> +struct microchip_pcie {
> +	struct platform_device *pdev;
> +	void __iomem *base_addr;
> +	void __iomem *bridge_base_addr;
> +	void __iomem *ctrl_base_addr;
> +	u64 hw_base_addr;
> +	u32 atr_sz;
> +	int bridgeno;
> +	u32 irq;
> +	u8 root_busno;
> +	struct irq_domain *intx_domain;
> +	raw_spinlock_t intx_mask_lock;
> +	struct list_head resources;
> +	struct microchip_msi msi;
> +};
> +
> +static inline u32 pcie_readl(struct microchip_pcie *pcie, const u32 reg)
> +{
> +	return readl_relaxed(pcie->base_addr + reg);
> +}
> +
> +static inline void pcie_writel(struct microchip_pcie *pcie,
> +			       const u32 val, const u32 reg)
> +{
> +	writel_relaxed(val, pcie->base_addr + reg);
> +}
> +
> +static void microchip_pcie_enable(struct microchip_pcie *pcie)
> +{
> +	u32 enb;
> +
> +	enb = readl(pcie->bridge_base_addr + MICROCHIP_LTSSM_STATE);
> +	enb |= LTSSM_L0_STATE;
> +	writel(enb, pcie->bridge_base_addr + MICROCHIP_LTSSM_STATE);
> +}
> +
> +static bool microchip_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
> +{
> +	struct microchip_pcie *pcie = bus->sysdata;
> +
> +	/* Only one device down on each root port */
> +	if (bus->number == pcie->root_busno && (PCI_SLOT(devfn) > 0))
> +		return false;
> +
> +	/*
> +	 * Do not read more than one device on the bus directly
> +	 * attached
> +	 */
> +	if (bus->primary == pcie->root_busno && devfn > 0)
> +		return false;

Sorry, I should have noticed this before.  Is there a reason you need
to check whether the device is valid?  If you omit this check for
"valid devices", the hardware *should* respond correctly with an error
if we try to read config space for a device that doesn't exist.

That should mean you can use pci_generic_ecam_ops instead of defining
your own microchip_pcie_ops and related constants.

Checking for valid devices is also racy because a device may disappear
between the check and the config access.  Since we have to handle the
error that occurs in that case, we should also be able to handle it in
the enumeration path.

> +	return true;
> +}
> +
> +/*
> + * microchip_pcie_map_bus - routine to get the configuration base
> + * of either root port or endpoint
> + */
> +static void __iomem *microchip_pcie_map_bus(struct pci_bus *bus,
> +					    unsigned int devfn, int where)
> +{
> +	struct microchip_pcie *pcie = bus->sysdata;
> +	int relbus;
> +
> +	if (!microchip_pcie_valid_device(bus, devfn))
> +		return NULL;
> +
> +	relbus = (bus->number << ECAM_BUS_NUM_SHIFT) |
> +		(devfn << ECAM_DEV_NUM_SHIFT);
> +
> +	return pcie->base_addr + relbus + where;
> +}
> +
> +static struct pci_ops microchip_pcie_ops = {
> +	.map_bus = microchip_pcie_map_bus,
> +	.read = pci_generic_config_read,
> +	.write = pci_generic_config_write,
> +};
> +
> +static void microchip_pcie_isr(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct microchip_pcie *pcie = irq_desc_get_handler_data(desc);
> +	struct device *dev = &pcie->pdev->dev;
> +	struct microchip_msi *msi = &pcie->msi;
> +	unsigned long status;
> +	u32 bit;
> +	u32 virq;
> +
> +	/*
> +	 * The core provides a single interrupt for both INTx/MSI messages.
> +	 * So we'll read both INTx and MSI status

Period at end of comment.

> +	 */
> +	chained_irq_enter(chip, desc);
> +
> +	status = readl(pcie->bridge_base_addr + MICROCHIP_ISTATUS_LOCAL);
> +	if ((status & PCI_INTS) != 0) {

  if (status & PCI_INTS) {

would match the style of MSI_INT below.

> +		status = (status & PCI_INTS)
> +			>> PM_MSI_INT_SHIFT;

Looks like this would fit on one line.

> +		for_each_set_bit(bit, &status, PCI_NUM_INTX) {
> +			/* clear that interrupt bit */
> +			writel(1 << (bit + PM_MSI_INT_SHIFT),
> +			       pcie->bridge_base_addr +
> +			       MICROCHIP_ISTATUS_LOCAL);
> +
> +			virq = irq_find_mapping(pcie->intx_domain, bit);
> +			if (virq)
> +				generic_handle_irq(virq);
> +			else
> +				dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n",
> +						    bit);
> +		}
> +	}
> +	status = readl(pcie->bridge_base_addr + MICROCHIP_ISTATUS_LOCAL);

Doesn't seem like you need to read ISTATUS_LOCAL again here.

> +	if (status & MSI_INT) {
> +		/* Clear the ISTATUS MSI bit */
> +		writel((1 << MSI_INT_SHIFT),
> +		       pcie->bridge_base_addr + MICROCHIP_ISTATUS_LOCAL);
> +		status = readl(pcie->bridge_base_addr + MICROCHIP_ISTATUS_MSI);
> +		for_each_set_bit(bit, &status, msi->num_vectors) {
> +			/* clear that MSI interrupt bit */
> +			writel((1 << bit),
> +			       pcie->bridge_base_addr + MICROCHIP_ISTATUS_MSI);
> +			virq = irq_find_mapping(msi->dev_domain, bit);
> +			if (virq)
> +				generic_handle_irq(virq);
> +		}
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static int microchip_pcie_parse_dt(struct microchip_pcie *pcie)
> +{
> +	struct platform_device *pdev = pcie->pdev;
> +	struct device *dev = &pcie->pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct microchip_msi *msi = &pcie->msi;
> +	struct resource res;
> +	const char *type;
> +	int ret;
> +	void __iomem *axi_base_addr;
> +	u32 size;
> +
> +	type = of_get_property(node, "device_type", NULL);
> +	if (!type || strcmp(type, "pci")) {
> +		dev_err(dev, "invalid \"device_type\" %s\n", type);
> +		return -EINVAL;
> +	}
> +
> +	/* Only supporting bridge 1 */
> +	pcie->bridgeno = 1;
> +
> +	pcie->root_busno = 0;
> +
> +	ret = of_address_to_resource(node, 0, &res);
> +	if (ret) {
> +		dev_err(dev, "missing \"reg\" property\n");
> +		return ret;
> +	}
> +
> +	pcie->base_addr = devm_pci_remap_cfg_resource(dev, &res);
> +	if (IS_ERR(pcie->base_addr))
> +		return PTR_ERR(pcie->base_addr);
> +
> +	pcie->hw_base_addr = res.start;
> +
> +	size = resource_size(&res);
> +	pcie->atr_sz = find_first_bit((const unsigned long *)&size, 64) - 1;
> +
> +	ret = of_address_to_resource(node, 1, &res);
> +	if (ret) {
> +		dev_err(dev, "missing \"reg\" property\n");
> +		return ret;
> +	}
> +
> +	axi_base_addr = devm_ioremap_resource(dev, &res);
> +	if (IS_ERR(axi_base_addr))
> +		return PTR_ERR(axi_base_addr);
> +
> +	if (pcie->bridgeno == 0) {

Per your comment above about only supporting bridge 1, this code is
dead.  Not a big deal, but I would probably omit bridgeno, this test,
and the PCIE0_* definitions altogether if they're not used.

They can be easily added all at once if/when you decide to also
support bridge 0.

> +		pcie->bridge_base_addr = axi_base_addr
> +			+ MICROCHIP_PCIE0_BRIDGE_ADDR;
> +		pcie->ctrl_base_addr = axi_base_addr
> +			+ MICROCHIP_PCIE0_CTRL_ADDR;
> +	} else {
> +		pcie->bridge_base_addr = axi_base_addr
> +			+ MICROCHIP_PCIE1_BRIDGE_ADDR;
> +		pcie->ctrl_base_addr = axi_base_addr
> +			+ MICROCHIP_PCIE1_CTRL_ADDR;
> +	}
> +
> +	if (of_property_read_u32(node, "vector-slave", &msi->vector_phy))
> +		msi->vector_phy = 0x190;
> +
> +	if (of_property_read_u32(node, "num-vectors", &msi->num_vectors))
> +		msi->num_vectors = 32;
> +
> +	pcie->irq = platform_get_irq(pdev, 0);
> +	if (pcie->irq < 0) {
> +		dev_err(dev, "unable to request IRQ%d\n", pcie->irq);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static void microchip_pcie_enable_msi(struct microchip_pcie *pcie)
> +{
> +	struct microchip_msi *msi = &pcie->msi;
> +	u32 cap_ctrl = pcie_readl(pcie, MICROCHIP_MSI_CAP_CTRL);
> +
> +	cap_ctrl |= MSI_ENABLE_MULTI | MSI_ENABLE;
> +	pcie_writel(pcie, cap_ctrl, MICROCHIP_MSI_CAP_CTRL);
> +	pcie_writel(pcie, msi->vector_phy, MICROCHIP_MSI_MSG_ADDR);
> +}
> +
> +static int microchip_host_init(struct microchip_pcie *pcie)
> +{
> +	u32 val;
> +
> +	microchip_pcie_enable(pcie);
> +
> +	val = ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS
> +		| ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS
> +		| ECC_CONTROL_RX_RAM_ECC_BYPASS
> +		| ECC_CONTROL_TX_RAM_ECC_BYPASS;
> +	writel(val, pcie->ctrl_base_addr + MICROCHIP_ECC_CONTROL);
> +
> +	val = PCIE_EVENT_INT_L2_EXIT_INT
> +		| PCIE_EVENT_INT_HOTRST_EXIT_INT
> +		| PCIE_EVENT_INT_DLUP_EXIT_INT
> +		| PCIE_EVENT_INT_L2_EXIT_INT_MASK
> +		| PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK
> +		| PCIE_EVENT_INT_DLUP_EXIT_INT_MASK;
> +	writel(val, pcie->ctrl_base_addr + MICROCHIP_PCIE_EVENT_INT);
> +
> +	val = SEC_ERROR_INT_TX_RAM_SEC_ERR_INT
> +		| SEC_ERROR_INT_RX_RAM_SEC_ERR_INT
> +		| SEC_ERROR_INT_PCIE2AXI_RAM_SEC_ERR_INT
> +		| SEC_ERROR_INT_AXI2PCIE_RAM_SEC_ERR_INT;
> +	writel(val, pcie->ctrl_base_addr + MICROCHIP_SEC_ERROR_INT);
> +	writel(val, pcie->ctrl_base_addr + MICROCHIP_SEC_ERROR_INT_MASK);
> +
> +	val = DED_ERROR_INT_TX_RAM_DED_ERR_INT
> +		| DED_ERROR_INT_RX_RAM_DED_ERR_INT
> +		| DED_ERROR_INT_PCIE2AXI_RAM_DED_ERR_INT
> +		| DED_ERROR_INT_AXI2PCIE_RAM_DED_ERR_INT;
> +	writel(val, pcie->ctrl_base_addr + MICROCHIP_DED_ERROR_INT);
> +	writel(val, pcie->ctrl_base_addr + MICROCHIP_DED_ERROR_INT_MASK);
> +
> +	writel(0, pcie->bridge_base_addr + MICROCHIP_IMASK_LOCAL);
> +	writel(GENMASK(31, 0),
> +	       pcie->bridge_base_addr + MICROCHIP_ISTATUS_LOCAL);
> +	writel(0, pcie->bridge_base_addr + MICROCHIP_IMASK_HOST);
> +	writel(GENMASK(31, 0), pcie->bridge_base_addr + MICROCHIP_ISTATUS_HOST);
> +
> +	/* Configure Address Translation Table 0 for PCIe config space */
> +	writel(PCIE_CONFIG_INTERFACE,
> +	       pcie->bridge_base_addr + MICROCHIP_ATR0_AXI4_SLV0_TRSL_PARAM);
> +
> +	val = lower_32_bits(pcie->hw_base_addr) |
> +		(pcie->atr_sz << ATR_SIZE_SHIFT) | ATR_IMPL_ENABLE;
> +	writel(val, pcie->bridge_base_addr +
> +		MICROCHIP_ATR0_AXI4_SLV0_SRCADDR_PARAM);
> +
> +	val  = lower_32_bits(pcie->hw_base_addr);

Remove extra space after "val".

> +	writel(val, pcie->bridge_base_addr +
> +		MICROCHIP_ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
> +
> +	val = readl(pcie->bridge_base_addr +
> +		MICROCHIP_ATR0_PCIE_WIN0_SRCADDR_31_12);
> +	val |= (ATR0_PCIE_WIN0_SIZE << ATR0_PCIE_WIN0_SIZE_SHIFT);
> +
> +	writel(val, pcie->bridge_base_addr +
> +		MICROCHIP_ATR0_PCIE_WIN0_SRCADDR_31_12);
> +
> +	writel(0, pcie->bridge_base_addr +
> +		MICROCHIP_ATR0_PCIE_WIN0_SRCADDR_63_32);
> +
> +	val = readl(pcie->bridge_base_addr + MICROCHIP_PCIE_PCI_IDS_DW1);
> +	val &= 0xffff;
> +	val |= (PCI_CLASS_BRIDGE_PCI << 16);
> +	writel(val, pcie->bridge_base_addr + MICROCHIP_PCIE_PCI_IDS_DW1);
> +
> +	/* setup MSI hardware registers */

Capitalize comment to match others (or remove it altogether, since
it's fairly obvious from the function name).  There are several others
throughout the file.

> +	microchip_pcie_enable_msi(pcie);
> +
> +	val = PCIE_ENABLE_MSI | PCIE_LOCAL_INT_ENABLE;
> +	writel(val, pcie->bridge_base_addr + MICROCHIP_IMASK_LOCAL);
> +
> +	return 0;
> +}
> +
> +static int microchip_pcie_parse_pci_ranges(struct microchip_pcie *pcie)
> +{
> +	int ret = 0;

Unnecessary initialization.

> +	struct device *dev = &pcie->pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct of_pci_range_parser parser;
> +	struct of_pci_range range;
> +	resource_size_t size;
> +	u32 atr_sz;
> +	u32 val;
> +	int index = 1;

I would put the initialization right before the loop where it's used.

> +	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> +						    &pcie->resources, NULL);
> +	if (ret) {
> +		dev_err(dev, "getting bridge resources failed\n");
> +		return ret;
> +	}
> +
> +	ret = devm_request_pci_bus_resources(dev, &pcie->resources);
> +	if (ret)
> +		return ret;
> +
> +	if (of_pci_range_parser_init(&parser, node)) {
> +		dev_err(dev, "missing \"ranges\" property\n");
> +		return -EINVAL;
> +	}
> +
> +	for_each_of_pci_range(&parser, &range) {
> +		switch (range.flags & IORESOURCE_TYPE_BITS) {
> +		case IORESOURCE_MEM:
> +			size = range.size;
> +			atr_sz =
> +				find_first_bit((const unsigned long *)&size, 64)
> +				- 1;
> +
> +			/* Configure Address Translation Table index for PCIe
> +			 * mem space

Use conventional multi-line comment style:

  /*
   * Configure ...
   */

s/PCIe mem space/PCI mem space/ since there's nothing PCIe-specific
about this.

> +			 */
> +			writel(PCIE_TX_RX_INTERFACE,
> +			       pcie->bridge_base_addr
> +			       + (index * ATR0_AXI4_SLV_SIZE)
> +			       + MICROCHIP_ATR0_AXI4_SLV0_TRSL_PARAM);
> +
> +			val = lower_32_bits(range.cpu_addr) |
> +				(atr_sz << ATR_SIZE_SHIFT) | ATR_IMPL_ENABLE;
> +			writel(val, pcie->bridge_base_addr
> +				+ (index * ATR0_AXI4_SLV_SIZE)
> +				+ MICROCHIP_ATR0_AXI4_SLV0_SRCADDR_PARAM);
> +
> +			writel(lower_32_bits(range.pci_addr),
> +			       pcie->bridge_base_addr
> +			       + (index * ATR0_AXI4_SLV_SIZE)
> +			       + MICROCHIP_ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
> +
> +			break;
> +		}
> +		index++;
> +	}
> +
> +	return 0;
> +}
> +
> +static void microchip_mask_intx_irq(struct irq_data *data)
> +{
> +	struct irq_desc *desc = irq_to_desc(data->irq);
> +	struct microchip_pcie *pcie;
> +	unsigned long flags;
> +	u32 mask, val;
> +
> +	pcie = irq_desc_get_chip_data(desc);
> +	mask = PCIE_LOCAL_INT_ENABLE;
> +	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
> +	val = readl(pcie->bridge_base_addr + MICROCHIP_IMASK_LOCAL);
> +	val &= ~mask;
> +	writel(val, pcie->bridge_base_addr + MICROCHIP_IMASK_LOCAL);
> +	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
> +}
> +
> +static void microchip_unmask_intx_irq(struct irq_data *data)
> +{
> +	struct irq_desc *desc = irq_to_desc(data->irq);
> +	struct microchip_pcie *pcie;
> +	unsigned long flags;
> +	u32 mask, val;
> +
> +	pcie = irq_desc_get_chip_data(desc);
> +	mask = PCIE_LOCAL_INT_ENABLE;
> +	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
> +	val = readl(pcie->bridge_base_addr + MICROCHIP_IMASK_LOCAL);
> +	val |= mask;
> +	writel(val, pcie->bridge_base_addr + MICROCHIP_IMASK_LOCAL);
> +	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
> +}
> +
> +static struct irq_chip microchip_intx_irq_chip = {
> +	.name = "microchip_pcie:intx",
> +	.irq_enable = microchip_unmask_intx_irq,
> +	.irq_disable = microchip_mask_intx_irq,
> +	.irq_mask = microchip_mask_intx_irq,
> +	.irq_unmask = microchip_unmask_intx_irq,
> +};
> +
> +/* routine to setup the INTx related data */

Superfluous comment.

> +static int microchip_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> +				   irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &microchip_intx_irq_chip,
> +				 handle_simple_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +/* INTx domain operations structure */

Superfluous comment.

> +static const struct irq_domain_ops intx_domain_ops = {
> +	.map = microchip_pcie_intx_map,
> +};
> +
> +static struct irq_chip microchip_msi_irq_chip = {
> +	.name = "Microchip PCIe MSI",
> +	.irq_mask = pci_msi_mask_irq,
> +	.irq_unmask = pci_msi_unmask_irq,
> +};
> +
> +static struct msi_domain_info microchip_msi_domain_info = {
> +	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +			MSI_FLAG_PCI_MSIX),
> +	.chip = &microchip_msi_irq_chip,
> +};
> +
> +static void microchip_compose_msi_msg(struct irq_data *data,
> +				      struct msi_msg *msg)
> +{
> +	struct microchip_pcie *pcie = irq_data_get_irq_chip_data(data);
> +	phys_addr_t addr = pcie->msi.vector_phy;
> +
> +	msg->address_lo = lower_32_bits(addr);
> +	msg->address_hi = upper_32_bits(addr);
> +	msg->data = data->hwirq;
> +
> +	dev_dbg(&pcie->pdev->dev, "msi#%d address_hi %#x address_lo %#x\n",
> +		(int)data->hwirq, msg->address_hi, msg->address_lo);
> +}
> +
> +static int microchip_msi_set_affinity(struct irq_data *irq_data,
> +				      const struct cpumask *mask, bool force)
> +{
> +	return -EINVAL;
> +}
> +
> +static struct irq_chip microchip_msi_bottom_irq_chip = {
> +	.name		= "Microchip MSI",
> +	.irq_compose_msi_msg	= microchip_compose_msi_msg,
> +	.irq_set_affinity	= microchip_msi_set_affinity,

Don't bother lining up the "=", especially since it looks like they
*don't* line up and they aren't lined up in microchip_msi_irq_chip
above.

> +};
> +
> +static int microchip_irq_msi_domain_alloc(struct irq_domain *domain,
> +					  unsigned int virq,
> +					  unsigned int nr_irqs, void *args)
> +{
> +	struct microchip_pcie *pcie = domain->host_data;
> +	struct microchip_msi *msi = &pcie->msi;
> +	unsigned long bit;
> +	u32 reg;
> +
> +	WARN_ON(nr_irqs != 1);
> +	mutex_lock(&msi->lock);
> +	bit = find_first_zero_bit(msi->used, msi->num_vectors);
> +	if (bit >= msi->num_vectors) {
> +		mutex_unlock(&msi->lock);
> +		return -ENOSPC;
> +	}
> +
> +	set_bit(bit, msi->used);
> +	mutex_unlock(&msi->lock);
> +
> +	irq_domain_set_info(domain, virq, bit, &microchip_msi_bottom_irq_chip,
> +			    domain->host_data, handle_simple_irq,
> +			    NULL, NULL);
> +
> +	/* Enable MSI interrupts */
> +	reg = readl(pcie->bridge_base_addr + MICROCHIP_IMASK_LOCAL);
> +	reg |= PCIE_ENABLE_MSI;
> +	writel(reg, pcie->bridge_base_addr + MICROCHIP_IMASK_LOCAL);
> +
> +	return 0;
> +}
> +
> +static void microchip_irq_msi_domain_free(struct irq_domain *domain,
> +					  unsigned int virq,
> +					  unsigned int nr_irqs)
> +{
> +	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +	struct microchip_pcie *pcie = irq_data_get_irq_chip_data(d);
> +	struct microchip_msi *msi = &pcie->msi;
> +
> +	mutex_lock(&msi->lock);
> +
> +	if (!test_bit(d->hwirq, msi->used))
> +		dev_err(&pcie->pdev->dev, "trying to free unused MSI%lu\n",
> +			d->hwirq);
> +	else
> +		__clear_bit(d->hwirq, msi->used);

I would invert the sense of this test so it reads better:

  if (test_bit(...))
    __clear_bit(...)
  else
    dev_err(...)

> +
> +	mutex_unlock(&msi->lock);
> +}
> +
> +static const struct irq_domain_ops msi_domain_ops = {
> +	.alloc	= microchip_irq_msi_domain_alloc,
> +	.free	= microchip_irq_msi_domain_free,
> +};
> +
> +static int microchip_allocate_msi_domains(struct microchip_pcie *pcie)
> +{
> +	struct device *dev = &pcie->pdev->dev;
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> +	struct microchip_msi *msi = &pcie->msi;
> +
> +	mutex_init(&pcie->msi.lock);
> +
> +	msi->dev_domain = irq_domain_add_linear(NULL, msi->num_vectors,
> +						&msi_domain_ops,
> +						pcie);

Fill the line above.

> +	if (!msi->dev_domain) {
> +		dev_err(dev, "failed to create IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	msi->msi_domain =
> +		pci_msi_create_irq_domain(fwnode,
> +					  &microchip_msi_domain_info,

I think this fits on the line above, doesn't it?

> +					  msi->dev_domain);
> +	if (!msi->msi_domain) {
> +		dev_err(dev, "failed to create MSI domain\n");
> +		irq_domain_remove(msi->dev_domain);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int microchip_pcie_init_irq_domains(struct microchip_pcie *pcie)
> +{
> +	struct device *dev = &pcie->pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	int ret;
> +
> +	/* Setup INTx */
> +	pcie->intx_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
> +						  &intx_domain_ops,
> +						  pcie);
> +	if (!pcie->intx_domain) {
> +		dev_err(dev, "failed to get an INTx IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +	raw_spin_lock_init(&pcie->intx_mask_lock);
> +
> +	/* setup MSI */

Match case of comment above (or delete both comments).

> +	ret = microchip_allocate_msi_domains(pcie);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

This is a complicated way of writing:

  return microchip_allocate_msi_domains(pcie);

> +}
> +
> +static int microchip_pcie_probe(struct platform_device *pdev)
> +{
> +	struct microchip_pcie *pcie;
> +	struct pci_bus *bus;
> +	struct pci_bus *child;
> +	struct pci_host_bridge *bridge;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	if (!dev->of_node)
> +		return -ENODEV;
> +
> +	/* allocate the PCIe port */
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	pcie = pci_host_bridge_priv(bridge);
> +
> +	pcie->pdev = pdev;
> +
> +	ret = microchip_pcie_parse_dt(pcie);
> +	if (ret) {
> +		dev_err(dev, "parsing devicetree failed, ret %x\n", ret);
> +		return ret;
> +	}
> +
> +	irq_set_chained_handler_and_data(pcie->irq, microchip_pcie_isr, pcie);
> +
> +	/*
> +	 * configure all inbound and outbound windows and prepare
> +	 * for config access

Capitalize this and other comments so they all match.

> +	 */
> +	ret = microchip_host_init(pcie);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize host\n");
> +		goto error;
> +	}
> +
> +	INIT_LIST_HEAD(&pcie->resources);
> +
> +	ret = microchip_pcie_parse_pci_ranges(pcie);
> +	if (ret) {
> +		dev_err(dev, "failed to parse pci ranges\n");

s/pci/PCI/

> +		return ret;
> +	}
> +
> +	/* initialise the IRQ domains */

Decide whether it's "initialise" (above) or "initialize" (below).

> +	ret = microchip_pcie_init_irq_domains(pcie);
> +	if (ret) {
> +		dev_err(dev, "failed creating IRQ domains\n");
> +		goto error;
> +	}
> +
> +	/* Initialize bridge */
> +	list_splice_init(&pcie->resources, &bridge->windows);
> +	bridge->dev.parent = dev;
> +	bridge->sysdata = pcie;
> +	bridge->busnr = pcie->root_busno;
> +	bridge->ops = &microchip_pcie_ops;
> +	bridge->map_irq = of_irq_parse_and_map_pci;
> +	bridge->swizzle_irq = pci_common_swizzle;
> +
> +	/* setup the kernel resources for the newly added PCIe root bus */
> +	ret = pci_scan_root_bus_bridge(bridge);
> +	if (ret < 0)
> +		goto error;
> +
> +	bus = bridge->bus;
> +
> +	pci_assign_unassigned_bus_resources(bus);
> +	list_for_each_entry(child, &bus->children, node)
> +		pcie_bus_configure_settings(child);
> +	pci_bus_add_devices(bus);
> +
> +	return 0;
> +
> +error:
> +	pci_free_resource_list(&pcie->resources);
> +	return ret;
> +}
> +
> +static const struct of_device_id microchip_pcie_of_match[] = {
> +	{ .compatible = "microchip,pf-axi-pcie-host-1.0", },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, microchip_pcie_of_match)
> +
> +static struct platform_driver microchip_pcie_driver = {
> +	.probe = microchip_pcie_probe,
> +	.driver = {
> +		.name = "microchip-pcie",
> +		.of_match_table = microchip_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +
> +builtin_platform_driver(microchip_pcie_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Microchip PCIe host controller driver");
> +MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
> -- 
> 2.17.1
> 
