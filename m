Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E633D21A84C
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 22:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgGIUA6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 16:00:58 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:37888 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgGIUA6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2020 16:00:58 -0400
Received: by mail-il1-f194.google.com with SMTP id s21so3106265ilk.5;
        Thu, 09 Jul 2020 13:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MuHdkkaW40NRgnPltODbRUA94WxA7UeTonMS1MzTY+o=;
        b=SoMIaa5+C0vVRRHOBxBlx2q88tHxiwCGHQcgvry3DuBqZwLJ95LB3YD4obbFearw5R
         I0ky4EITPWBFpvY9HF/WD6P8fRneFn8UM/7jdwbcvvYBgvmYJ4+X6JS0Kv85BcmZ19lS
         6Roab114vjhegh8IvMeadcW/tEkP29RNE2S8e0AmBvC+S0g+hqWf+tSUbI0sN83QnJcQ
         a6k1Sszzan5j89jq1SakqFRsMBv+qjCUw2iE8LxnmNK8UEGBG1ecYsAzbDceuhx4uHS1
         fc/dVdfmGaIESII3i0dXLLqXDwpiq6OLHGsLaJkqz3DDxKOvdGYDpZ6n1hr3RctZ5UKO
         pl4g==
X-Gm-Message-State: AOAM530R6QtRV6Ij5XUOm7u2S4fL7K/+QTABN/o2NLqDNkBRAF7UIQZM
        6nLokYrg42qcbSDuV5hzZeN5ZhlELQ==
X-Google-Smtp-Source: ABdhPJwhcs735ubDW0GOxZzclQoVD7jo27D4WxTx+w8Lpb4PUfe2MCuYRrGxtBdZquXN0yTyJ4jQvg==
X-Received: by 2002:a05:6e02:f42:: with SMTP id y2mr48955741ilj.264.1594324856341;
        Thu, 09 Jul 2020 13:00:56 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id 13sm2348869ilj.81.2020.07.09.13.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:00:55 -0700 (PDT)
Received: (nullmailer pid 796296 invoked by uid 1000);
        Thu, 09 Jul 2020 20:00:55 -0000
Date:   Thu, 9 Jul 2020 14:00:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daire.McNamara@microchip.com
Cc:     lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, devicetree@vger.kernel.org,
        david.abdurachmanov@gmail.com
Subject: Re: [PATCH v13 2/2] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20200709200055.GA763222@bogus>
References: <56d2a9855f93455c6150b92682178c93fe70ed72.camel@microchip.com>
 <acf9e17ff72b1f74ebdc8579acb19b8fffa7676f.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acf9e17ff72b1f74ebdc8579acb19b8fffa7676f.camel@microchip.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 08, 2020 at 03:00:52PM +0000, Daire.McNamara@microchip.com wrote:
> Add support for the Microchip PolarFire PCIe controller when
> configured in host (Root Complex) mode.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  drivers/pci/controller/Kconfig               |   9 +
>  drivers/pci/controller/Makefile              |   1 +
>  drivers/pci/controller/pcie-microchip-host.c | 683 +++++++++++++++++++
>  3 files changed, 693 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-microchip-host.c
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index adddf21fa381..d9e11581119a 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -286,6 +286,15 @@ config PCI_LOONGSON
>  	  Say Y here if you want to enable PCI controller support on
>  	  Loongson systems.
>  
> +config PCIE_MICROCHIP_HOST
> +	bool "Microchip AXI PCIe host bridge support"
> +	depends on PCI_MSI && OF
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
> index efd9733ead26..27f89b499c6e 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_PCIE_ROCKCHIP_EP) += pcie-rockchip-ep.o
>  obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
>  obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
>  obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
> +obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
>  obj-$(CONFIG_VMD) += vmd.o
>  obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
>  obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> new file mode 100644
> index 000000000000..90d051100181
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -0,0 +1,683 @@
> +// SPDX-License-Identifier: GPL-2.0
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
> +#define MC_MSI_CAP_CTRL_OFFSET			0xe0u
> +#define  MC_MSI_MAX_Q_AVAIL			(MC_NUM_MSI_IRQS_CODED << 1)
> +#define  MC_MSI_Q_SIZE				(MC_NUM_MSI_IRQS_CODED << 4)
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
> +#define MC_MSI_ADDR				0x190
> +#define MC_ISTATUS_MSI				0x194
> +
> +/* PCIe Master table init defines */
> +#define MC_ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
> +#define  ATR0_PCIE_ATR_SIZE			0x1f
> +#define  ATR0_PCIE_ATR_SIZE_SHIFT		1
> +#define MC_ATR0_PCIE_WIN0_SRC_ADDR		0x604u
> +#define MC_ATR0_PCIE_WIN0_TRSL_ADDR_LSB		0x608u
> +#define MC_ATR0_PCIE_WIN0_TRSL_ADDR_UDW		0x60cu
> +#define MC_ATR0_PCIE_WIN0_TRSL_PARAM		0x610u
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
> +
> +#define ATT_ENTRY_SIZE				32
> +
> +struct mc_msi {
> +	struct mutex lock;		/* Protect used bitmap */
> +	struct irq_domain *msi_domain;
> +	struct irq_domain *dev_domain;
> +	u32 num_vectors;
> +	u64 vector_phy;
> +	DECLARE_BITMAP(used, MC_NUM_MSI_IRQS);
> +};
> +
> +struct mc_pcie {
> +	struct platform_device *pdev;
> +	void __iomem *cfg_base_addr;
> +	void __iomem *bridge_base_addr;
> +	void __iomem *ctrl_base_addr;
> +	struct irq_domain *intx_domain;
> +	raw_spinlock_t intx_mask_lock;
> +	struct mc_msi msi;
> +};
> +
> +static inline u32 cfg_readl(struct mc_pcie *pcie, const u32 reg)

Unused, remove.

> +{
> +	return readl_relaxed(pcie->cfg_base_addr + reg);
> +}
> +
> +static inline u16 cfg_readw(struct mc_pcie *pcie, const u16 reg)
> +{
> +	return readw_relaxed(pcie->cfg_base_addr + reg);
> +}
> +
> +static inline void cfg_writel(struct mc_pcie *pcie, const u32 val,
> +			      const u32 reg)
> +{
> +	writel_relaxed(val, pcie->cfg_base_addr + reg);
> +}
> +
> +static inline void cfg_writew(struct mc_pcie *pcie, const u16 val,
> +			      const u16 reg)
> +{
> +	writew_relaxed(val, pcie->cfg_base_addr + reg);
> +}
> +
> +static void mc_pcie_enable(struct mc_pcie *pcie)
> +{
> +	u32 enb;
> +
> +	enb = readl_relaxed(pcie->bridge_base_addr + MC_LTSSM_STATE);
> +	enb |= LTSSM_L0_STATE;
> +	writel_relaxed(enb, pcie->bridge_base_addr + MC_LTSSM_STATE);
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
> +	status = readl_relaxed(pcie->bridge_base_addr + MC_ISTATUS_LOCAL);
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
> +			writel_relaxed(1 << (bit + PM_MSI_INT_SHIFT),
> +				       pcie->bridge_base_addr +
> +				       MC_ISTATUS_LOCAL);
> +		}
> +
> +		msi_status = (status & MSI_INT);
> +		if (msi_status) {
> +			msi_status = readl_relaxed(pcie->bridge_base_addr +
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
> +				writel_relaxed((1 << bit),
> +					       pcie->bridge_base_addr +
> +					       MC_ISTATUS_MSI);
> +			}
> +			/* Clear the ISTATUS MSI bit */
> +			writel_relaxed(1 << MSI_INT_SHIFT,
> +				       pcie->bridge_base_addr +
> +				       MC_ISTATUS_LOCAL);
> +		}
> +
> +		status = readl_relaxed(pcie->bridge_base_addr +
> +				       MC_ISTATUS_LOCAL);
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static int mc_pcie_parse_dt(struct mc_pcie *pcie)
> +{
> +	struct platform_device *pdev = pcie->pdev;
> +	struct device *dev = &pcie->pdev->dev;
> +	struct mc_msi *msi = &pcie->msi;
> +	struct resource *res;
> +	void __iomem *axi_base_addr;
> +	u32 irq;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	axi_base_addr = devm_ioremap_resource(dev, res);

Use devm_platform_ioremap_resource()

> +	if (IS_ERR(axi_base_addr))
> +		return PTR_ERR(axi_base_addr);
> +
> +	pcie->bridge_base_addr = axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
> +	pcie->ctrl_base_addr = axi_base_addr + MC_PCIE1_CTRL_ADDR;
> +
> +	msi->vector_phy = MC_MSI_ADDR;
> +
> +	msi->num_vectors = MC_NUM_MSI_IRQS;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "unable to request IRQ%d\n", irq);
> +		return -ENODEV;
> +	}
> +
> +	irq_set_chained_handler_and_data(irq, mc_pcie_isr, pcie);
> +
> +	return 0;
> +}
> +
> +static void mc_pcie_enable_msi(struct mc_pcie *pcie)
> +{
> +	struct mc_msi *msi = &pcie->msi;
> +	u32 cap_offset = MC_MSI_CAP_CTRL_OFFSET;
> +
> +	u16 msg_ctrl = cfg_readw(pcie, cap_offset + PCI_MSI_FLAGS);
> +
> +	msg_ctrl |= PCI_MSI_FLAGS_ENABLE;
> +	msg_ctrl &= ~PCI_MSI_FLAGS_QMASK;
> +	msg_ctrl |= MC_MSI_MAX_Q_AVAIL;
> +	msg_ctrl &= ~PCI_MSI_FLAGS_QSIZE;
> +	msg_ctrl |= MC_MSI_Q_SIZE;
> +	msg_ctrl |= PCI_MSI_FLAGS_64BIT;
> +	cfg_writew(pcie, msg_ctrl, cap_offset + PCI_MSI_FLAGS);
> +
> +	cfg_writel(pcie, lower_32_bits(msi->vector_phy),
> +		   cap_offset + PCI_MSI_ADDRESS_LO);
> +	cfg_writel(pcie, upper_32_bits(msi->vector_phy),
> +		   cap_offset + PCI_MSI_ADDRESS_HI);
> +}
> +
> +static int mc_host_init(struct mc_pcie *pcie, u64 cfghw_base_addr, u32 atr_sz)
> +{
> +	u32 val;
> +
> +	mc_pcie_enable(pcie);

Only used once, just inline the function contents here.

> +
> +	val = ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS |
> +	      ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS |
> +	      ECC_CONTROL_RX_RAM_ECC_BYPASS | ECC_CONTROL_TX_RAM_ECC_BYPASS;
> +	writel_relaxed(val, pcie->ctrl_base_addr + MC_ECC_CONTROL);
> +
> +	val = PCIE_EVENT_INT_L2_EXIT_INT | PCIE_EVENT_INT_HOTRST_EXIT_INT |
> +	      PCIE_EVENT_INT_DLUP_EXIT_INT | PCIE_EVENT_INT_L2_EXIT_INT_MASK |
> +	      PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK |
> +	      PCIE_EVENT_INT_DLUP_EXIT_INT_MASK;
> +	writel_relaxed(val, pcie->ctrl_base_addr + MC_PCIE_EVENT_INT);
> +
> +	val = SEC_ERROR_INT_TX_RAM_SEC_ERR_INT |
> +	      SEC_ERROR_INT_RX_RAM_SEC_ERR_INT |
> +	      SEC_ERROR_INT_PCIE2AXI_RAM_SEC_ERR_INT |
> +	      SEC_ERROR_INT_AXI2PCIE_RAM_SEC_ERR_INT;
> +	writel_relaxed(val, pcie->ctrl_base_addr + MC_SEC_ERROR_INT);
> +	writel_relaxed(val, pcie->ctrl_base_addr + MC_SEC_ERROR_INT_MASK);
> +
> +	val = DED_ERROR_INT_TX_RAM_DED_ERR_INT |
> +	      DED_ERROR_INT_RX_RAM_DED_ERR_INT |
> +	      DED_ERROR_INT_PCIE2AXI_RAM_DED_ERR_INT |
> +	      DED_ERROR_INT_AXI2PCIE_RAM_DED_ERR_INT;
> +	writel_relaxed(val, pcie->ctrl_base_addr + MC_DED_ERROR_INT);
> +	writel_relaxed(val, pcie->ctrl_base_addr + MC_DED_ERROR_INT_MASK);
> +
> +	writel_relaxed(0, pcie->bridge_base_addr + MC_IMASK_LOCAL);
> +	writel_relaxed(GENMASK(31, 0), pcie->bridge_base_addr +
> +		       MC_ISTATUS_LOCAL);
> +	writel_relaxed(0, pcie->bridge_base_addr + MC_IMASK_HOST);
> +	writel_relaxed(GENMASK(31, 0), pcie->bridge_base_addr +
> +		       MC_ISTATUS_HOST);
> +
> +	/* Configure Address Translation Table 0 for PCIe config space */
> +	writel_relaxed(PCIE_CONFIG_INTERFACE, pcie->bridge_base_addr +
> +	       MC_ATR0_AXI4_SLV0_TRSL_PARAM);
> +
> +	val = lower_32_bits(cfghw_base_addr) |
> +	      (atr_sz << ATR_SIZE_SHIFT) | ATR_IMPL_ENABLE;
> +	writel_relaxed(val, pcie->bridge_base_addr +
> +		       MC_ATR0_AXI4_SLV0_SRCADDR_PARAM);
> +	writel_relaxed(0, pcie->bridge_base_addr +
> +		       MC_ATR0_AXI4_SLV0_SRC_ADDR);
> +
> +	val = lower_32_bits(cfghw_base_addr);
> +	writel_relaxed(val, pcie->bridge_base_addr +
> +		       MC_ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
> +	val = upper_32_bits(cfghw_base_addr);
> +	writel_relaxed(val, pcie->bridge_base_addr +
> +			    MC_ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
> +
> +	val = readl_relaxed(pcie->bridge_base_addr +
> +			    MC_ATR0_PCIE_WIN0_SRCADDR_PARAM);
> +	val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
> +	writel_relaxed(val, pcie->bridge_base_addr +
> +		       MC_ATR0_PCIE_WIN0_SRCADDR_PARAM);
> +	writel_relaxed(0, pcie->bridge_base_addr + MC_ATR0_PCIE_WIN0_SRC_ADDR);
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
> +	val = readl_relaxed(pcie->bridge_base_addr + MC_IMASK_LOCAL);
> +	val &= ~mask;
> +	writel_relaxed(val, pcie->bridge_base_addr + MC_IMASK_LOCAL);
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
> +	val = readl_relaxed(pcie->bridge_base_addr + MC_IMASK_LOCAL);
> +	val |= mask;
> +	writel_relaxed(val, pcie->bridge_base_addr + MC_IMASK_LOCAL);
> +	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
> +}
> +
> +static struct irq_chip mc_intx_irq_chip = {
> +	.name = "microchip_pcie:intx",
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
> +
> +	irq_domain_set_info(domain, virq, bit, &mc_msi_bottom_irq_chip,
> +			    domain->host_data, handle_simple_irq, NULL, NULL);
> +
> +	/* Enable MSI interrupts */
> +	reg = readl_relaxed(pcie->bridge_base_addr + MC_IMASK_LOCAL);
> +	reg |= PCIE_ENABLE_MSI;
> +	writel_relaxed(reg, pcie->bridge_base_addr + MC_IMASK_LOCAL);
> +
> +	mutex_unlock(&msi->lock);
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
> +	struct pci_host_bridge *bridge;
> +	struct pci_config_window *cfg;
> +	struct device *dev = &pdev->dev;
> +	struct resource_entry *win;
> +	struct resource *bus_range = NULL;
> +	struct resource *cfgres;
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
> +	cfgres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	size = resource_size(cfgres);
> +	atr_sz = ilog2(size) - 1;
> +
> +	ret = mc_pcie_parse_dt(pcie);
> +	if (ret) {
> +		dev_err(dev, "parsing devicetree failed, ret %x\n", ret);
> +		return ret;
> +	}
> +
> +	ret = mc_host_init(pcie, cfgres->start, atr_sz);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize host\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Configure all inbound and outbound windows and prepare
> +	 * for config access
> +	 */
> +	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
> +					      &bridge->dma_ranges, &bus_range);
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
> +		atr_sz = ilog2(size) - 1;
> +
> +		/*
> +		 * Configure Address Translation Table index for PCI
> +		 * mem space
> +		 */
> +		writel_relaxed(PCIE_TX_RX_INTERFACE, pcie->bridge_base_addr +
> +		       (index * ATT_ENTRY_SIZE) +
> +		       MC_ATR0_AXI4_SLV0_TRSL_PARAM);
> +
> +		val = lower_32_bits(win->res->start) |
> +				    (atr_sz << ATR_SIZE_SHIFT) |
> +				    ATR_IMPL_ENABLE;
> +
> +		writel_relaxed(val, pcie->bridge_base_addr +
> +		       (index * ATT_ENTRY_SIZE) +
> +		       MC_ATR0_AXI4_SLV0_SRCADDR_PARAM);
> +
> +		val = upper_32_bits(win->res->start);
> +		writel_relaxed(val, pcie->bridge_base_addr +
> +				(index * ATT_ENTRY_SIZE) +
> +				MC_ATR0_AXI4_SLV0_SRC_ADDR);
> +
> +		val = lower_32_bits(win->res->start - win->offset);
> +		writel_relaxed(val, pcie->bridge_base_addr +
> +		       (index * ATT_ENTRY_SIZE) +
> +		       MC_ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
> +
> +		val = upper_32_bits(win->res->start);
> +		writel_relaxed(val, pcie->bridge_base_addr +
> +				    (index * ATT_ENTRY_SIZE) +
> +				    MC_ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
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
> +	/* Parse and map our Configuration Space windows */
> +	cfg = pci_ecam_create(dev, cfgres, bus_range, &pci_generic_ecam_ops);
> +	if (IS_ERR(cfg)) {
> +		dev_err(dev, "failed creating Configuration Space\n");
> +		return PTR_ERR(cfg);
> +	}
> +
> +	pcie->cfg_base_addr = cfg->win;
> +
> +	/* Hardware doesn't setup MSI by default */
> +	mc_pcie_enable_msi(pcie);
> +
> +	val = PCIE_ENABLE_MSI | PCIE_LOCAL_INT_ENABLE;
> +	writel_relaxed(val, pcie->bridge_base_addr + MC_IMASK_LOCAL);
> +
> +	ret = devm_add_action_or_reset(dev, mc_pci_unmap_cfg, cfg);
> +	if (ret)
> +		return ret;
> +
> +	/* Initialize bridge */
> +	bridge->dev.parent = dev;
> +	bridge->sysdata = cfg;
> +	bridge->busnr = cfg->busr.start;
> +	bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
> +	bridge->map_irq = of_irq_parse_and_map_pci;
> +	bridge->swizzle_irq = pci_common_swizzle;
> +
> +	return pci_host_probe(bridge);

I think you can restructure this and use pci_host_common_probe(). You'd 
need to be able to do all the h/w init after pci_ecam_create() call. I 
think that looks like it would work in this case. If so, then define a 
struct pci_ecam_ops with an .init() function to do all the h/w setup
and make the ops the match data.

Rob
