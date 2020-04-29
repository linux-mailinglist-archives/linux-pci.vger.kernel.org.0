Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4166C1BE61C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Apr 2020 20:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgD2ST3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Apr 2020 14:19:29 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39218 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2ST3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Apr 2020 14:19:29 -0400
Received: by mail-ot1-f67.google.com with SMTP id m13so2552619otf.6
        for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2020 11:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EuTyTLFzhz0JGdCzscLsNWcLHplvfROosSyNzGLlGDA=;
        b=UY6e4ZVq4f+iNj2ZBOR39Tp5hNmxcHwXA2WishZIPF18gAigK3zH4CRSI5OBIKAmFN
         Wn01dJ/N1zcES4NYz0sGMgVOx8tFO7A6OSm2xSB9yjYYdBrLePx5V08r890uW/7wpSvQ
         j1wFm8Hebdj97C13ZAqxAj6FDjjYsYkiryETDwL9LYYrQyVXiEmoIxhwF1KlY1zovmF+
         DXrQd7PDSmOKAS/1kb5EzDU3m/skaY66tP7xIjXxtTjLkVGEd2XpOEMZEkUDFRlZZ77r
         DvWr7vgF407voPqqK7hoqLEJzwkSzcZ1Jy3wZR3IlioVgI7igWy15sVkRvCRj9D7h1wc
         eOvA==
X-Gm-Message-State: AGi0PuYIoGpMCZ9cA3v0XJlmdPip5rijzw8N3ww35LwGFkqT3ONCcZpG
        XnAXqeoEwwSOZ8bVpVc75g==
X-Google-Smtp-Source: APiQypINQimXuY85iQi+jjbH4nE5RQA+s47XI1yT11Nlv3EHEz51WHIXJss1oAmlwKmQ5wh16WjJIw==
X-Received: by 2002:a9d:2aa9:: with SMTP id e38mr13928608otb.162.1588184366349;
        Wed, 29 Apr 2020 11:19:26 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t20sm512180ott.51.2020.04.29.11.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 11:19:25 -0700 (PDT)
Received: (nullmailer pid 14159 invoked by uid 1000);
        Wed, 29 Apr 2020 18:19:24 -0000
Date:   Wed, 29 Apr 2020 13:19:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daire.McNamara@microchip.com
Cc:     amurray@thegoodpenguin.co.uk, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, helgaas@kernel.org
Subject: Re: [PATCH v8 1/1] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20200429181924.ihlxcpj2wcpxb76t@bogus>
References: <dc6d1276e04d944bd56b424a85370e6625dadff2.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc6d1276e04d944bd56b424a85370e6625dadff2.camel@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 29, 2020 at 09:39:14AM +0000, Daire.McNamara@microchip.com wrote:
> This patch adds support for the Microchip PCIe PolarFire PCIe
> controller when configured in host (Root Complex) mode.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  .../bindings/pci/microchip-pcie.txt           |  64 ++

Bindings need to be a separate patch and be sent to the DT list. Also, 
bindings are now in schema format. See 
Documentation/devicetree/writing-schema.rst. There's a couple of 
examples for PCI now too.

>  drivers/pci/controller/Kconfig                |   9 +
>  drivers/pci/controller/Makefile               |   1 +
>  drivers/pci/controller/pcie-microchip-host.c  | 702 ++++++++++++++++++
>  4 files changed, 776 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/microchip-pcie.txt
>  create mode 100644 drivers/pci/controller/pcie-microchip-host.c
> 
> diff --git a/Documentation/devicetree/bindings/pci/microchip-pcie.txt b/Documentation/devicetree/bindings/pci/microchip-pcie.txt
> new file mode 100644
> index 000000000000..9fa129cbce80
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

Only 1 version of this IP?

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
> +		bus-range = <0x00 0x7f>;
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

The order doesn't seem to match the driver. 

Typically the config space is called 'config' or 'cfg'.

> +		interrupt-controller;
> +	};
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 91bfdb784829..4478f5a4d8a6 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -258,6 +258,15 @@ config PCI_HYPERV_INTERFACE
>  	  The Hyper-V PCI Interface is a helper driver allows other drivers to
>  	  have a common interface with the Hyper-V PCI frontend driver.
>  
> +config PCIE_MICROCHIP_HOST
> +	bool "Microchip AXI PCIe host bridge support"
> +	depends on PCI_MSI && OF && RISCV && 64BIT
> +	select PCI_MSI_IRQ_DOMAIN
> +	select GENERIC_MSI_IRQ_DOMAIN
> +	help
> +	  Say Y here if you want kernel to support the Microchip AXI PCIe
> +	  Host Bridge driver.
> +
>  source "drivers/pci/controller/dwc/Kconfig"
>  source "drivers/pci/controller/mobiveil/Kconfig"
>  source "drivers/pci/controller/cadence/Kconfig"
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index 158c59771824..416528d8553e 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_PCIE_ROCKCHIP_EP) += pcie-rockchip-ep.o
>  obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
>  obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
>  obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
> +obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
>  obj-$(CONFIG_VMD) += vmd.o
>  obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
>  # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> new file mode 100644
> index 000000000000..79b1f56cc9b6
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -0,0 +1,702 @@
> +// SPDX-License-Identifier: GPL-2.0+

Kernel code should be GPL-2.0-only generally.

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

And 2 out of 3 of these are GPL-2.0-only

> + */
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_pci.h>
> +#include <linux/pci-ecam.h>
> +#include <linux/platform_device.h>
> +
> +#include "../pci.h"
> +
> +/* Number of MSI IRQs */
> +#define MC_NUM_MSI_IRQS				32
> +#define MC_NUM_MSI_IRQS_CODED			5
> +
> +#define MC_MSI_OFFSET				0x190
> +
> +/* PCIe Bridge Phy and Controller Phy offsets */
> +#define MC_PCIE1_BRIDGE_ADDR			0x00008000u
> +#define MC_PCIE1_CTRL_ADDR			0x0000a000u
> +
> +/* PCIe Controller Phy Regs */
> +#define MC_SEC_ERROR_INT			0x28
> +#define  SEC_ERROR_INT_TX_RAM_SEC_ERR_INT	GENMASK(3, 0)
> +#define  SEC_ERROR_INT_RX_RAM_SEC_ERR_INT	GENMASK(7, 4)
> +#define  SEC_ERROR_INT_PCIE2AXI_RAM_SEC_ERR_INT	GENMASK(11, 8)
> +#define  SEC_ERROR_INT_AXI2PCIE_RAM_SEC_ERR_INT	GENMASK(15, 12)
> +#define MC_SEC_ERROR_INT_MASK			0x2c
> +#define MC_DED_ERROR_INT			0x30
> +#define  DED_ERROR_INT_TX_RAM_DED_ERR_INT	GENMASK(3, 0)
> +#define  DED_ERROR_INT_RX_RAM_DED_ERR_INT	GENMASK(7, 4)
> +#define  DED_ERROR_INT_PCIE2AXI_RAM_DED_ERR_INT	GENMASK(11, 8)
> +#define  DED_ERROR_INT_AXI2PCIE_RAM_DED_ERR_INT	GENMASK(15, 12)
> +#define MC_DED_ERROR_INT_MASK			0x34
> +#define MC_ECC_CONTROL				0x38
> +#define  ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS	BIT(27)
> +#define  ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS	BIT(26)
> +#define  ECC_CONTROL_RX_RAM_ECC_BYPASS		BIT(25)
> +#define  ECC_CONTROL_TX_RAM_ECC_BYPASS		BIT(24)
> +#define MC_LTSSM_STATE				0x5c
> +#define  LTSSM_L0_STATE				0x10
> +#define MC_PCIE_EVENT_INT			0x14c
> +#define  PCIE_EVENT_INT_L2_EXIT_INT		BIT(0)
> +#define  PCIE_EVENT_INT_HOTRST_EXIT_INT		BIT(1)
> +#define  PCIE_EVENT_INT_DLUP_EXIT_INT		BIT(2)
> +#define  PCIE_EVENT_INT_L2_EXIT_INT_MASK	BIT(16)
> +#define  PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK	BIT(17)
> +#define  PCIE_EVENT_INT_DLUP_EXIT_INT_MASK	BIT(18)
> +
> +/* PCIe Bridge Phy Regs */
> +#define MC_PCIE_PCI_IDS_DW1			0x9c
> +
> +/* PCIe Config space MSI capability structure */
> +#define MC_MSI_CAP_CTRL				0xe0u
> +#define  MSI_ENABLE				(0x01u << 16)
> +#define  MSI_CAP_MULTI				(MC_NUM_MSI_IRQS_CODED << 17)
> +#define  MSI_ENABLE_MULTI			(MC_NUM_MSI_IRQS_CODED << 20)
> +#define MC_MSI_MSG_LO_ADDR			0xe4u
> +#define MC_MSI_MSG_HI_ADDR			0xe8u
> +#define MC_MSI_MSG_DATA				0xf0u
> +
> +#define MC_IMASK_LOCAL				0x180
> +#define  PCIE_LOCAL_INT_ENABLE			0x0f000000u
> +#define  PCI_INTS				0x0f000000u
> +#define  PM_MSI_INT_SHIFT			24
> +#define  PCIE_ENABLE_MSI			0x10000000u
> +#define  MSI_INT				0x10000000u
> +#define  MSI_INT_SHIFT				28
> +#define MC_ISTATUS_LOCAL			0x184
> +#define MC_IMASK_HOST				0x188
> +#define MC_ISTATUS_HOST				0x18c
> +#define MC_ISTATUS_MSI				0x194
> +
> +/* PCIe Master table init defines */
> +#define MC_ATR0_PCIE_WIN0_SRCADDR_31_12		0x600u
> +#define  ATR0_PCIE_WIN0_SIZE			0x1f
> +#define  ATR0_PCIE_WIN0_SIZE_SHIFT		1
> +#define MC_ATR0_PCIE_WIN0_SRCADDR_63_32		0x604u
> +
> +/* PCIe AXI slave table init defines */
> +#define MC_ATR0_AXI4_SLV0_SRCADDR_PARAM		0x800u
> +#define  ATR_SIZE_SHIFT				1
> +#define  ATR_IMPL_ENABLE			1
> +#define MC_ATR0_AXI4_SLV0_SRC_ADDR		0x804u
> +#define MC_ATR0_AXI4_SLV0_TRSL_ADDR_LSB		0x808u
> +#define MC_ATR0_AXI4_SLV0_TRSL_ADDR_UDW		0x80cu
> +#define MC_ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
> +#define  PCIE_TX_RX_INTERFACE			0x00000000u
> +#define  PCIE_CONFIG_INTERFACE			0x00000001u
> +#define  ATR0_AXI4_SLV_SIZE			32
> +
> +struct mc_msi {
> +	struct mutex lock;		/* Protect used bitmap */
> +	struct irq_domain *msi_domain;
> +	struct irq_domain *dev_domain;
> +	u32 num_vectors;
> +	phys_addr_t vector_phy;
> +	DECLARE_BITMAP(used, MC_NUM_MSI_IRQS);
> +};
> +
> +struct mc_pcie {
> +	struct platform_device *pdev;
> +	void __iomem *cfg_base_addr;
> +	void __iomem *bridge_base_addr;
> +	void __iomem *ctrl_base_addr;
> +	u64 hw_base_addr;
> +	u32 atr_sz;
> +	u32 irq;
> +	struct irq_domain *intx_domain;
> +	raw_spinlock_t intx_mask_lock;
> +	struct mc_msi msi;
> +};
> +
> +static inline u32 cfg_readl(struct mc_pcie *pcie, const u32 reg)
> +{
> +	return readl_relaxed(pcie->cfg_base_addr + reg);
> +}
> +
> +static inline void cfg_writel(struct mc_pcie *pcie, const u32 val,
> +			      const u32 reg)
> +{
> +	writel_relaxed(val, pcie->cfg_base_addr + reg);
> +}
> +
> +static void mc_pcie_enable(struct mc_pcie *pcie)
> +{
> +	u32 enb;
> +
> +	enb = readl(pcie->bridge_base_addr + MC_LTSSM_STATE);
> +	enb |= LTSSM_L0_STATE;
> +	writel(enb, pcie->bridge_base_addr + MC_LTSSM_STATE);
> +}
> +
> +static void mc_pcie_isr(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct mc_pcie *pcie = irq_desc_get_handler_data(desc);
> +	struct device *dev = &pcie->pdev->dev;
> +	struct mc_msi *msi = &pcie->msi;
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
> +	status = readl(pcie->bridge_base_addr + MC_ISTATUS_LOCAL);
> +	while (status & (PCI_INTS | MSI_INT)) {
> +		intx_status = (status & PCI_INTS) >> PM_MSI_INT_SHIFT;
> +		for_each_set_bit(bit, &intx_status, PCI_NUM_INTX) {
> +			virq = irq_find_mapping(pcie->intx_domain, bit + 1);
> +			if (virq)
> +				generic_handle_irq(virq);
> +			else
> +				dev_err_ratelimited(dev, "bad INTx IRQ %d\n",
> +						    bit);
> +
> +			/* Clear that interrupt bit */
> +			writel(1 << (bit + PM_MSI_INT_SHIFT),
> +			       pcie->bridge_base_addr + MC_ISTATUS_LOCAL);
> +		}
> +
> +		msi_status = (status & MSI_INT);
> +		if (msi_status) {
> +			msi_status = readl(pcie->bridge_base_addr +
> +					   MC_ISTATUS_MSI);
> +			for_each_set_bit(bit, &msi_status, msi->num_vectors) {
> +				virq = irq_find_mapping(msi->dev_domain, bit);
> +				if (virq)
> +					generic_handle_irq(virq);
> +				else
> +					dev_err_ratelimited(dev,
> +							    "bad MSI IRQ %d\n",
> +							    bit);
> +
> +				/* Clear that MSI interrupt bit */
> +				writel((1 << bit), pcie->bridge_base_addr +
> +				       MC_ISTATUS_MSI);
> +			}
> +			/* Clear the ISTATUS MSI bit */
> +			writel(1 << MSI_INT_SHIFT, pcie->bridge_base_addr +
> +			       MC_ISTATUS_LOCAL);
> +		}
> +
> +		status = readl(pcie->bridge_base_addr + MC_ISTATUS_LOCAL);
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static int mc_pcie_parse_dt(struct mc_pcie *pcie)
> +{
> +	struct platform_device *pdev = pcie->pdev;
> +	struct device *dev = &pcie->pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct mc_msi *msi = &pcie->msi;
> +	struct resource res;
> +	const char *type;
> +	resource_size_t size;
> +	int ret;
> +	void __iomem *axi_base_addr;
> +	u64 cfg_addr;
> +
> +	type = of_get_property(node, "device_type", NULL);
> +	if (!type || strcmp(type, "pci")) {
> +		dev_err(dev, "invalid \"device_type\" %s\n", type);
> +		return -EINVAL;
> +	}

Drop this. Not the kernel's job to validate the DT.

> +
> +	cfg_addr = of_translate_address(node,
> +					of_get_address(node, 0, &size, 0));

Drivers should not be calling of_translate_address() get and use the 
resource.

> +	if (cfg_addr == OF_BAD_ADDR) {
> +		dev_err(dev, "missing \"cfg reg\" property\n");
> +		return -ENODEV;
> +	}
> +
> +	pcie->cfg_base_addr = devm_ioremap(dev, cfg_addr, size);

Use devm_pci_remap_cfg_resource()

> +	pcie->hw_base_addr = cfg_addr;
> +
> +	pcie->atr_sz = find_first_bit((const unsigned long *)&size, 64) - 1;
> +
> +	ret = of_address_to_resource(node, 1, &res);

Use platform_get_resource() instead.

> +	if (ret) {
> +		dev_err(dev, "missing \"reg\" property\n");
> +		return ret;
> +	}
> +
> +	axi_base_addr = devm_ioremap_resource(dev, &res);
> +	if (IS_ERR(axi_base_addr))
> +		return PTR_ERR(axi_base_addr);
> +
> +	pcie->bridge_base_addr = axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
> +	pcie->ctrl_base_addr = axi_base_addr + MC_PCIE1_CTRL_ADDR;
> +
> +	if (of_property_read_u64(node, "vector-slave", &msi->vector_phy))
> +		msi->vector_phy = MC_MSI_OFFSET;

Not documented.

> +
> +	if (of_property_read_u32(node, "num-vectors", &msi->num_vectors))
> +		msi->num_vectors = MC_NUM_MSI_IRQS;

Not documented.

When does this vary? Should perhaps be implied by the compatible 
string(s).

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
> +static void mc_pcie_enable_msi(struct mc_pcie *pcie)
> +{
> +	struct mc_msi *msi = &pcie->msi;
> +	u32 msg_ctrl = cfg_readl(pcie, MC_MSI_CAP_CTRL);
> +
> +	msg_ctrl |= MSI_ENABLE_MULTI | MSI_CAP_MULTI | MSI_ENABLE;
> +	cfg_writel(pcie, msg_ctrl, MC_MSI_CAP_CTRL);
> +	cfg_writel(pcie, lower_32_bits(msi->vector_phy), MC_MSI_MSG_LO_ADDR);
> +	cfg_writel(pcie, upper_32_bits(msi->vector_phy), MC_MSI_MSG_HI_ADDR);
> +}
> +
> +static int mc_host_init(struct mc_pcie *pcie)
> +{
> +	u32 val;
> +
> +	mc_pcie_enable(pcie);
> +
> +	val = ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS |
> +	      ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS |
> +	      ECC_CONTROL_RX_RAM_ECC_BYPASS | ECC_CONTROL_TX_RAM_ECC_BYPASS;
> +	writel(val, pcie->ctrl_base_addr + MC_ECC_CONTROL);
> +
> +	val = PCIE_EVENT_INT_L2_EXIT_INT | PCIE_EVENT_INT_HOTRST_EXIT_INT |
> +	      PCIE_EVENT_INT_DLUP_EXIT_INT | PCIE_EVENT_INT_L2_EXIT_INT_MASK |
> +	      PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK |
> +	      PCIE_EVENT_INT_DLUP_EXIT_INT_MASK;
> +	writel(val, pcie->ctrl_base_addr + MC_PCIE_EVENT_INT);
> +
> +	val = SEC_ERROR_INT_TX_RAM_SEC_ERR_INT |
> +	      SEC_ERROR_INT_RX_RAM_SEC_ERR_INT |
> +	      SEC_ERROR_INT_PCIE2AXI_RAM_SEC_ERR_INT |
> +	      SEC_ERROR_INT_AXI2PCIE_RAM_SEC_ERR_INT;
> +	writel(val, pcie->ctrl_base_addr + MC_SEC_ERROR_INT);
> +	writel(val, pcie->ctrl_base_addr + MC_SEC_ERROR_INT_MASK);
> +
> +	val = DED_ERROR_INT_TX_RAM_DED_ERR_INT |
> +	      DED_ERROR_INT_RX_RAM_DED_ERR_INT |
> +	      DED_ERROR_INT_PCIE2AXI_RAM_DED_ERR_INT |
> +	      DED_ERROR_INT_AXI2PCIE_RAM_DED_ERR_INT;
> +	writel(val, pcie->ctrl_base_addr + MC_DED_ERROR_INT);
> +	writel(val, pcie->ctrl_base_addr + MC_DED_ERROR_INT_MASK);
> +
> +	writel(0, pcie->bridge_base_addr + MC_IMASK_LOCAL);
> +	writel(GENMASK(31, 0), pcie->bridge_base_addr + MC_ISTATUS_LOCAL);
> +	writel(0, pcie->bridge_base_addr + MC_IMASK_HOST);
> +	writel(GENMASK(31, 0), pcie->bridge_base_addr + MC_ISTATUS_HOST);
> +
> +	/* Configure Address Translation Table 0 for PCIe config space */
> +	writel(PCIE_CONFIG_INTERFACE, pcie->bridge_base_addr +
> +	       MC_ATR0_AXI4_SLV0_TRSL_PARAM);
> +
> +	val = lower_32_bits(pcie->hw_base_addr) |
> +	      (pcie->atr_sz << ATR_SIZE_SHIFT) | ATR_IMPL_ENABLE;
> +	writel(val, pcie->bridge_base_addr + MC_ATR0_AXI4_SLV0_SRCADDR_PARAM);
> +
> +	val = lower_32_bits(pcie->hw_base_addr);
> +	writel(val, pcie->bridge_base_addr + MC_ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
> +
> +	val = readl(pcie->bridge_base_addr + MC_ATR0_PCIE_WIN0_SRCADDR_31_12);
> +	val |= (ATR0_PCIE_WIN0_SIZE << ATR0_PCIE_WIN0_SIZE_SHIFT);
> +
> +	writel(val, pcie->bridge_base_addr + MC_ATR0_PCIE_WIN0_SRCADDR_31_12);
> +
> +	writel(0, pcie->bridge_base_addr + MC_ATR0_PCIE_WIN0_SRCADDR_63_32);
> +
> +	val = readl(pcie->bridge_base_addr + MC_PCIE_PCI_IDS_DW1);
> +	val &= 0xffff;
> +	val |= (PCI_CLASS_BRIDGE_PCI << 16);
> +	writel(val, pcie->bridge_base_addr + MC_PCIE_PCI_IDS_DW1);
> +
> +	/* Setup bus numbers */
> +	val = cfg_readl(pcie, PCI_PRIMARY_BUS);
> +	val &= 0xff000000;
> +	val |= 0x00ff0100;
> +	cfg_writel(pcie, val, PCI_PRIMARY_BUS);
> +
> +	mc_pcie_enable_msi(pcie);
> +
> +	val = PCIE_ENABLE_MSI | PCIE_LOCAL_INT_ENABLE;
> +	writel(val, pcie->bridge_base_addr + MC_IMASK_LOCAL);
> +
> +	return 0;
> +}
> +
> +static void mc_mask_intx_irq(struct irq_data *data)
> +{
> +	struct irq_desc *desc = irq_to_desc(data->irq);
> +	struct mc_pcie *pcie;
> +	unsigned long flags;
> +	u32 mask, val;
> +
> +	pcie = irq_desc_get_chip_data(desc);
> +	mask = PCIE_LOCAL_INT_ENABLE;
> +	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
> +	val = readl(pcie->bridge_base_addr + MC_IMASK_LOCAL);
> +	val &= ~mask;
> +	writel(val, pcie->bridge_base_addr + MC_IMASK_LOCAL);
> +	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
> +}
> +
> +static void mc_unmask_intx_irq(struct irq_data *data)
> +{
> +	struct irq_desc *desc = irq_to_desc(data->irq);
> +	struct mc_pcie *pcie;
> +	unsigned long flags;
> +	u32 mask, val;
> +
> +	pcie = irq_desc_get_chip_data(desc);
> +	mask = PCIE_LOCAL_INT_ENABLE;
> +	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
> +	val = readl(pcie->bridge_base_addr + MC_IMASK_LOCAL);
> +	val |= mask;
> +	writel(val, pcie->bridge_base_addr + MC_IMASK_LOCAL);
> +	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
> +}
> +
> +static struct irq_chip mc_intx_irq_chip = {
> +	.name = "microchip_pcie:intx",
> +	.irq_enable = mc_unmask_intx_irq,
> +	.irq_disable = mc_mask_intx_irq,
> +	.irq_mask = mc_mask_intx_irq,
> +	.irq_unmask = mc_unmask_intx_irq,
> +};
> +
> +static int mc_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> +			    irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &mc_intx_irq_chip, handle_simple_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops intx_domain_ops = {
> +	.map = mc_pcie_intx_map,
> +};
> +
> +static struct irq_chip mc_msi_irq_chip = {
> +	.name = "Microchip PCIe MSI",
> +	.irq_mask = pci_msi_mask_irq,
> +	.irq_unmask = pci_msi_unmask_irq,
> +};
> +
> +static struct msi_domain_info mc_msi_domain_info = {
> +	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +		  MSI_FLAG_PCI_MSIX),
> +	.chip = &mc_msi_irq_chip,
> +};
> +
> +static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	struct mc_pcie *pcie = irq_data_get_irq_chip_data(data);
> +	phys_addr_t addr = pcie->msi.vector_phy;
> +
> +	msg->address_lo = lower_32_bits(addr);
> +	msg->address_hi = upper_32_bits(addr);
> +	msg->data = data->hwirq;
> +
> +	dev_dbg(&pcie->pdev->dev, "msi#%x address_hi %#x address_lo %#x\n",
> +		(int)data->hwirq, msg->address_hi, msg->address_lo);
> +}
> +
> +static int mc_msi_set_affinity(struct irq_data *irq_data,
> +			       const struct cpumask *mask, bool force)
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
> +static int mc_irq_msi_domain_alloc(struct irq_domain *domain,
> +				   unsigned int virq, unsigned int nr_irqs,
> +				   void *args)
> +{
> +	struct mc_pcie *pcie = domain->host_data;
> +	struct mc_msi *msi = &pcie->msi;
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
> +	irq_domain_set_info(domain, virq, bit, &mc_msi_bottom_irq_chip,
> +			    domain->host_data, handle_simple_irq, NULL, NULL);
> +
> +	/* Enable MSI interrupts */
> +	reg = readl(pcie->bridge_base_addr + MC_IMASK_LOCAL);
> +	reg |= PCIE_ENABLE_MSI;
> +	writel(reg, pcie->bridge_base_addr + MC_IMASK_LOCAL);
> +
> +	return 0;
> +}
> +
> +static void mc_irq_msi_domain_free(struct irq_domain *domain,
> +				   unsigned int virq, unsigned int nr_irqs)
> +{
> +	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +	struct mc_pcie *pcie = irq_data_get_irq_chip_data(d);
> +	struct mc_msi *msi = &pcie->msi;
> +
> +	mutex_lock(&msi->lock);
> +
> +	if (test_bit(d->hwirq, msi->used))
> +		__clear_bit(d->hwirq, msi->used);
> +	else
> +		dev_err(&pcie->pdev->dev, "trying to free unused MSI%lu\n",
> +			d->hwirq);
> +
> +	mutex_unlock(&msi->lock);
> +}
> +
> +static const struct irq_domain_ops msi_domain_ops = {
> +	.alloc	= mc_irq_msi_domain_alloc,
> +	.free	= mc_irq_msi_domain_free,
> +};
> +
> +static int mc_allocate_msi_domains(struct mc_pcie *pcie)
> +{
> +	struct device *dev = &pcie->pdev->dev;
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> +	struct mc_msi *msi = &pcie->msi;
> +
> +	mutex_init(&pcie->msi.lock);
> +
> +	msi->dev_domain = irq_domain_add_linear(NULL, msi->num_vectors,
> +						&msi_domain_ops, pcie);
> +	if (!msi->dev_domain) {
> +		dev_err(dev, "failed to create IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	msi->msi_domain = pci_msi_create_irq_domain(fwnode,
> +						    &mc_msi_domain_info,
> +						    msi->dev_domain);
> +	if (!msi->msi_domain) {
> +		dev_err(dev, "failed to create MSI domain\n");
> +		irq_domain_remove(msi->dev_domain);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mc_pcie_init_irq_domains(struct mc_pcie *pcie)
> +{
> +	struct device *dev = &pcie->pdev->dev;
> +	struct device_node *node = dev->of_node;
> +
> +	pcie->intx_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
> +						  &intx_domain_ops, pcie);
> +	if (!pcie->intx_domain) {
> +		dev_err(dev, "failed to get an INTx IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +	raw_spin_lock_init(&pcie->intx_mask_lock);
> +
> +	return mc_allocate_msi_domains(pcie);
> +}
> +
> +static void mc_pci_unmap_cfg(void *ptr)
> +{
> +	pci_ecam_free((struct pci_config_window *)ptr);
> +}
> +
> +static int mc_pcie_probe(struct platform_device *pdev)
> +{
> +	struct mc_pcie *pcie;
> +	struct pci_bus *bus;
> +	struct pci_bus *child;
> +	struct pci_host_bridge *bridge;
> +	struct pci_config_window *cfg;
> +	struct device *dev = &pdev->dev;
> +	struct resource_entry *win;
> +	struct resource *bus_range = NULL;
> +	struct resource cfgres;
> +	int ret;
> +	resource_size_t size;
> +	u32 index;
> +	u32 atr_sz;
> +	u32 val;
> +
> +	if (!dev->of_node)
> +		return -ENODEV;
> +
> +	/* Allocate the PCIe port */
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	pcie = pci_host_bridge_priv(bridge);
> +
> +	pcie->pdev = pdev;
> +
> +	ret = mc_pcie_parse_dt(pcie);
> +	if (ret) {
> +		dev_err(dev, "parsing devicetree failed, ret %x\n", ret);
> +		return ret;
> +	}
> +
> +	irq_set_chained_handler_and_data(pcie->irq, mc_pcie_isr, pcie);
> +
> +	/*
> +	 * Configure all inbound and outbound windows and prepare
> +	 * for config access
> +	 */

Strange that you do this before...

> +	ret = mc_host_init(pcie);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize host\n");
> +		return ret;
> +	}
> +
> +	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
> +					      &bridge->dma_ranges, &bus_range);

...parsing any inbound and outbound ranges.

> +	if (ret) {
> +		dev_err(dev, "failed to parse PCI ranges\n");
> +		return ret;
> +	}
> +
> +	index = 1;
> +	resource_list_for_each_entry(win, &bridge->windows) {
> +		if ((resource_type(win->res) != IORESOURCE_MEM) &&
> +		    (resource_type(win->res) != IORESOURCE_IO))
> +			continue;
> +
> +		size = resource_size(win->res);
> +		atr_sz = find_first_bit((const unsigned long *)&size, 64) - 1;
> +
> +		/*
> +		 * Configure Address Translation Table index for PCI
> +		 * mem space
> +		 */
> +		writel(PCIE_TX_RX_INTERFACE, pcie->bridge_base_addr +
> +		       (index * ATR0_AXI4_SLV_SIZE) +
> +		       MC_ATR0_AXI4_SLV0_TRSL_PARAM);
> +
> +		val = lower_32_bits(win->res->start) |
> +				    (atr_sz << ATR_SIZE_SHIFT) |
> +				    ATR_IMPL_ENABLE;

In all the cases of writing addresses, what happens to the upper 
32-bits? You never write them.

> +
> +		writel(val, pcie->bridge_base_addr +
> +		       (index * ATR0_AXI4_SLV_SIZE) +
> +		       MC_ATR0_AXI4_SLV0_SRCADDR_PARAM);
> +
> +		val = lower_32_bits(win->res->start - win->offset);
> +		writel(val, pcie->bridge_base_addr +
> +		       (index * ATR0_AXI4_SLV_SIZE) +
> +		       MC_ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
> +
> +		index++;
> +	}
> +
> +	ret = mc_pcie_init_irq_domains(pcie);
> +	if (ret) {
> +		dev_err(dev, "failed creating IRQ domains\n");
> +		return ret;
> +	}
> +
> +	devm_iounmap(dev, pcie->cfg_base_addr);
> +
> +	ret = of_address_to_resource(dev->of_node, 0, &cfgres);

Would be better to not map and then unmap the config space. 
pci_ecam_create doesn't need any h/w setup. So do all the DT parsing, 
then call pci_ecam_create, then do h/w setup.

> +	if (ret) {
> +		dev_err(dev, "missing \"reg\" property\n");

Is this possible considering you already mapped this once...

> +		return ret;
> +	}
> +
> +	size = resource_size(&cfgres);
> +
> +	/* Parse and map our Configuration Space windows */
> +	cfg = pci_ecam_create(dev, &cfgres, bus_range, &pci_generic_ecam_ops);
> +	if (IS_ERR(cfg)) {
> +		dev_err(dev, "failed creating Configuration Space\n");
> +		return PTR_ERR(cfg);
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, mc_pci_unmap_cfg, cfg);

We should convert pci_ecam_create to use devm_kzalloc() instead and then 
can drop all these.

> +	if (ret)
> +		return ret;
> +
> +	/* Initialize bridge */
> +	bridge->dev.parent = dev;
> +	bridge->sysdata = cfg;
> +	bridge->busnr = cfg->busr.start;
> +	bridge->ops = &pci_generic_ecam_ops.pci_ops;
> +	bridge->map_irq = of_irq_parse_and_map_pci;
> +	bridge->swizzle_irq = pci_common_swizzle;
> +

> +	/* Setup the kernel resources for the newly added PCIe root bus */
> +	ret = pci_scan_root_bus_bridge(bridge);
> +	if (ret < 0)
> +		return ret;
> +
> +	bus = bridge->bus;
> +
> +	pci_assign_unassigned_bus_resources(bus);
> +	list_for_each_entry(child, &bus->children, node)
> +		pcie_bus_configure_settings(child);
> +	pci_bus_add_devices(bus);

I think all this can be done with pci_host_probe().

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mc_pcie_of_match[] = {
> +	{ .compatible = "microchip,pf-axi-pcie-host-1.0",

Doesn't match the documentation. What does '1.0' correspond to?

> +	  .data = &pci_generic_ecam_ops },

Drop, because you aren't using it.

> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, mc_pcie_of_match)
> +
> +static struct platform_driver mc_pcie_driver = {
> +	.probe = mc_pcie_probe,
> +	.driver = {
> +		.name = "microchip-pcie",
> +		.of_match_table = mc_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +
> +builtin_platform_driver(mc_pcie_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Microchip PCIe host controller driver");
> +MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
> -- 
> 2.17.1
> 
