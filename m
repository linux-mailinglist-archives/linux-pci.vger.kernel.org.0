Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D042A2409B8
	for <lists+linux-pci@lfdr.de>; Mon, 10 Aug 2020 17:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgHJPfR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Aug 2020 11:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbgHJPfO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Aug 2020 11:35:14 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A54C922CAE;
        Mon, 10 Aug 2020 15:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073710;
        bh=4JPMX16vqx4nizrZ/AGkQpTdM7ubcfwC/kdjnH1sElc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XnNSJIAsqyXxOvQXFJqLvmvIMVzApxgbCJUt9oMey+XDizehIqe+b/LJa0XMi0FDW
         exVYEhkZgTgYtMt0kyWTme3xebmM+fleB6hd0SjXiQ9syfYjl+V5sncll/CbH9xwa0
         TZH5M4gSq1KP5+taZKDGnWCEj3cnIoLBNAGJr/DE=
Received: by mail-oi1-f177.google.com with SMTP id h3so9245146oie.11;
        Mon, 10 Aug 2020 08:35:10 -0700 (PDT)
X-Gm-Message-State: AOAM532n+VvUi/3ng4J/QuA4odqzHqY87gWQyaPHBl647XDmjkJVlpjg
        kyMqX3RGFU8XtkTe/g0JAZGS7RBKq5ka/uOtaQ==
X-Google-Smtp-Source: ABdhPJz28KN5hQwieIOmTCm+jjfb6yXXF4E6g1THHBZIfTlVl6aI4ozgZX3Pqnjd0V9WJ+7Ey6CKvHF0+T8sBFcdeFk=
X-Received: by 2002:aca:190c:: with SMTP id l12mr1163175oii.147.1597073709853;
 Mon, 10 Aug 2020 08:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <eb2abaa7fc97a6e700a7c4ed37182820803414c3.camel@microchip.com> <a4d01ca94fd22b1c574e92612b00d979f407ce0d.camel@microchip.com>
In-Reply-To: <a4d01ca94fd22b1c574e92612b00d979f407ce0d.camel@microchip.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 10 Aug 2020 09:34:57 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Y0b8Fk__ia2d1P4JyqnRiK2eidGvqskpsJHGE6zZKsg@mail.gmail.com>
Message-ID: <CAL_Jsq+Y0b8Fk__ia2d1P4JyqnRiK2eidGvqskpsJHGE6zZKsg@mail.gmail.com>
Subject: Re: [PATCH v14 2/2] PCI: microchip: Add host driver for Microchip
 PCIe controller
To:     Daire McNamara <Daire.McNamara@microchip.com>
Cc:     Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, david.abdurachmanov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 7, 2020 at 7:25 AM <Daire.McNamara@microchip.com> wrote:
>
>
> Add support for the Microchip PolarFire PCIe controller when
> configured in host (Root Complex) mode.
>
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  drivers/pci/controller/Kconfig               |   9 +
>  drivers/pci/controller/Makefile              |   1 +
>  drivers/pci/controller/pcie-microchip-host.c | 569 +++++++++++++++++++
>  3 files changed, 579 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-microchip-host.c
>
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index adddf21fa381..d9e11581119a 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -286,6 +286,15 @@ config PCI_LOONGSON
>           Say Y here if you want to enable PCI controller support on
>           Loongson systems.
>
> +config PCIE_MICROCHIP_HOST
> +       bool "Microchip AXI PCIe host bridge support"
> +       depends on PCI_MSI && OF
> +       select PCI_MSI_IRQ_DOMAIN
> +       select GENERIC_MSI_IRQ_DOMAIN
> +       help
> +         Say Y here if you want kernel to support the Microchip AXI PCIe
> +         Host Bridge driver.
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
> index 000000000000..4f6d04630697
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -0,0 +1,569 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Microchip AXI PCIe Bridge host controller driver
> + *
> + * Copyright (c) 2018 - 2019 Microchip Corporation. All rights reserved.
> + *
> + * Author: Daire McNamara <daire.mcnamara@microchip.com>
> + *
> + * Based on:
> + *     pcie-rcar.c
> + *     pcie-xilinx.c
> + *     pcie-altera.c
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
> +#define MC_NUM_MSI_IRQS                                32
> +#define MC_NUM_MSI_IRQS_CODED                  5
> +
> +/* PCIe Bridge Phy and Controller Phy offsets */
> +#define MC_PCIE1_BRIDGE_ADDR                   0x00008000u
> +#define MC_PCIE1_CTRL_ADDR                     0x0000a000u
> +
> +/* PCIe Controller Phy Regs */
> +#define MC_SEC_ERROR_INT                       0x28
> +#define  SEC_ERROR_INT_TX_RAM_SEC_ERR_INT      GENMASK(3, 0)
> +#define  SEC_ERROR_INT_RX_RAM_SEC_ERR_INT      GENMASK(7, 4)
> +#define  SEC_ERROR_INT_PCIE2AXI_RAM_SEC_ERR_INT        GENMASK(11, 8)
> +#define  SEC_ERROR_INT_AXI2PCIE_RAM_SEC_ERR_INT        GENMASK(15, 12)
> +#define MC_SEC_ERROR_INT_MASK                  0x2c
> +#define MC_DED_ERROR_INT                       0x30
> +#define  DED_ERROR_INT_TX_RAM_DED_ERR_INT      GENMASK(3, 0)
> +#define  DED_ERROR_INT_RX_RAM_DED_ERR_INT      GENMASK(7, 4)
> +#define  DED_ERROR_INT_PCIE2AXI_RAM_DED_ERR_INT        GENMASK(11, 8)
> +#define  DED_ERROR_INT_AXI2PCIE_RAM_DED_ERR_INT        GENMASK(15, 12)
> +#define MC_DED_ERROR_INT_MASK                  0x34
> +#define MC_ECC_CONTROL                         0x38
> +#define  ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS   BIT(27)
> +#define  ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS   BIT(26)
> +#define  ECC_CONTROL_RX_RAM_ECC_BYPASS         BIT(25)
> +#define  ECC_CONTROL_TX_RAM_ECC_BYPASS         BIT(24)
> +#define MC_LTSSM_STATE                         0x5c
> +#define  LTSSM_L0_STATE                                0x10
> +#define MC_PCIE_EVENT_INT                      0x14c
> +#define  PCIE_EVENT_INT_L2_EXIT_INT            BIT(0)
> +#define  PCIE_EVENT_INT_HOTRST_EXIT_INT                BIT(1)
> +#define  PCIE_EVENT_INT_DLUP_EXIT_INT          BIT(2)
> +#define  PCIE_EVENT_INT_L2_EXIT_INT_MASK       BIT(16)
> +#define  PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK   BIT(17)
> +#define  PCIE_EVENT_INT_DLUP_EXIT_INT_MASK     BIT(18)
> +
> +/* PCIe Bridge Phy Regs */
> +#define MC_PCIE_PCI_IDS_DW1                    0x9c
> +
> +/* PCIe Config space MSI capability structure */
> +#define MC_MSI_CAP_CTRL_OFFSET                 0xe0u
> +#define  MC_MSI_MAX_Q_AVAIL                    (MC_NUM_MSI_IRQS_CODED << 1)
> +#define  MC_MSI_Q_SIZE                         (MC_NUM_MSI_IRQS_CODED << 4)
> +
> +#define MC_IMASK_LOCAL                         0x180
> +#define  PCIE_LOCAL_INT_ENABLE                 0x0f000000u
> +#define  PCI_INTS                              0x0f000000u
> +#define  PM_MSI_INT_SHIFT                      24
> +#define  PCIE_ENABLE_MSI                       0x10000000u
> +#define  MSI_INT                               0x10000000u
> +#define  MSI_INT_SHIFT                         28
> +#define MC_ISTATUS_LOCAL                       0x184
> +#define MC_IMASK_HOST                          0x188
> +#define MC_ISTATUS_HOST                                0x18c
> +#define MC_MSI_ADDR                            0x190
> +#define MC_ISTATUS_MSI                         0x194
> +
> +/* PCIe Master table init defines */
> +#define MC_ATR0_PCIE_WIN0_SRCADDR_PARAM                0x600u
> +#define  ATR0_PCIE_ATR_SIZE                    0x1f
> +#define  ATR0_PCIE_ATR_SIZE_SHIFT              1
> +#define MC_ATR0_PCIE_WIN0_SRC_ADDR             0x604u
> +#define MC_ATR0_PCIE_WIN0_TRSL_ADDR_LSB                0x608u
> +#define MC_ATR0_PCIE_WIN0_TRSL_ADDR_UDW                0x60cu
> +#define MC_ATR0_PCIE_WIN0_TRSL_PARAM           0x610u
> +
> +/* PCIe AXI slave table init defines */
> +#define MC_ATR0_AXI4_SLV0_SRCADDR_PARAM                0x800u
> +#define  ATR_SIZE_SHIFT                                1
> +#define  ATR_IMPL_ENABLE                       1
> +#define MC_ATR0_AXI4_SLV0_SRC_ADDR             0x804u
> +#define MC_ATR0_AXI4_SLV0_TRSL_ADDR_LSB                0x808u
> +#define MC_ATR0_AXI4_SLV0_TRSL_ADDR_UDW                0x80cu
> +#define MC_ATR0_AXI4_SLV0_TRSL_PARAM           0x810u
> +#define  PCIE_TX_RX_INTERFACE                  0x00000000u
> +#define  PCIE_CONFIG_INTERFACE                 0x00000001u
> +
> +#define ATR_ENTRY_SIZE                         32
> +
> +struct mc_msi {
> +       struct mutex lock;              /* Protect used bitmap */
> +       struct irq_domain *msi_domain;
> +       struct irq_domain *dev_domain;
> +       u32 num_vectors;
> +       u64 vector_phy;
> +       DECLARE_BITMAP(used, MC_NUM_MSI_IRQS);
> +};
> +
> +struct mc_port {
> +       void __iomem *axi_base_addr;
> +       struct device *dev;
> +       struct irq_domain *intx_domain;
> +       raw_spinlock_t intx_mask_lock;
> +       struct mc_msi msi;
> +};
> +
> +static inline u16 cfg_readw(void __iomem *addr)
> +{
> +       return readw_relaxed(addr);
> +}
> +
> +static inline void cfg_writel(const u32 val, void __iomem *addr)
> +{
> +       writel_relaxed(val, addr);
> +}
> +
> +static inline void cfg_writew(const u16 val, void __iomem *addr)
> +{
> +       writew_relaxed(val, addr);
> +}

These don't abstract anything. Remove them and use readw_relaxed, etc. directly.

> +
> +static void mc_pcie_isr(struct irq_desc *desc)
> +{
> +       struct irq_chip *chip = irq_desc_get_chip(desc);
> +       struct mc_port *port = irq_desc_get_handler_data(desc);
> +       struct device *dev = port->dev;
> +       struct mc_msi *msi = &port->msi;
> +       void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
> +       unsigned long status;
> +       unsigned long intx_status;
> +       unsigned long msi_status;
> +       u32 bit;
> +       u32 virq;
> +
> +       /*
> +        * The core provides a single interrupt for both INTx/MSI messages.
> +        * So we'll read both INTx and MSI status.
> +        */
> +       chained_irq_enter(chip, desc);
> +
> +       status = readl_relaxed(bridge_base_addr + MC_ISTATUS_LOCAL);
> +       while (status & (PCI_INTS | MSI_INT)) {
> +               intx_status = (status & PCI_INTS) >> PM_MSI_INT_SHIFT;
> +               for_each_set_bit(bit, &intx_status, PCI_NUM_INTX) {
> +                       virq = irq_find_mapping(port->intx_domain, bit + 1);
> +                       if (virq)
> +                               generic_handle_irq(virq);
> +                       else
> +                               dev_err_ratelimited(dev, "bad INTx IRQ %d\n", bit);
> +
> +                       /* Clear that interrupt bit */
> +                       writel_relaxed(1 << (bit + PM_MSI_INT_SHIFT), bridge_base_addr +
> +                                      MC_ISTATUS_LOCAL);
> +               }
> +
> +               msi_status = (status & MSI_INT);
> +               if (msi_status) {
> +                       msi_status = readl_relaxed(bridge_base_addr + MC_ISTATUS_MSI);
> +                       for_each_set_bit(bit, &msi_status, msi->num_vectors) {
> +                               virq = irq_find_mapping(msi->dev_domain, bit);
> +                               if (virq)
> +                                       generic_handle_irq(virq);
> +                               else
> +                                       dev_err_ratelimited(dev, "bad MSI IRQ %d\n", bit);
> +
> +                               /* Clear that MSI interrupt bit */
> +                               writel_relaxed((1 << bit), bridge_base_addr + MC_ISTATUS_MSI);
> +                       }
> +                       /* Clear the ISTATUS MSI bit */
> +                       writel_relaxed(1 << MSI_INT_SHIFT, bridge_base_addr + MC_ISTATUS_LOCAL);
> +               }
> +
> +               status = readl_relaxed(bridge_base_addr + MC_ISTATUS_LOCAL);
> +       }
> +
> +       chained_irq_exit(chip, desc);
> +}
> +
> +static void mc_pcie_enable_msi(struct mc_port *port, void __iomem *base)
> +{
> +       struct mc_msi *msi = &port->msi;
> +       u32 cap_offset = MC_MSI_CAP_CTRL_OFFSET;
> +
> +       u16 msg_ctrl = cfg_readw(base + cap_offset + PCI_MSI_FLAGS);
> +
> +       msg_ctrl |= PCI_MSI_FLAGS_ENABLE;
> +       msg_ctrl &= ~PCI_MSI_FLAGS_QMASK;
> +       msg_ctrl |= MC_MSI_MAX_Q_AVAIL;
> +       msg_ctrl &= ~PCI_MSI_FLAGS_QSIZE;
> +       msg_ctrl |= MC_MSI_Q_SIZE;
> +       msg_ctrl |= PCI_MSI_FLAGS_64BIT;
> +
> +       cfg_writew(msg_ctrl, base + cap_offset + PCI_MSI_FLAGS);
> +
> +       cfg_writel(lower_32_bits(msi->vector_phy), base + cap_offset + PCI_MSI_ADDRESS_LO);
> +       cfg_writel(upper_32_bits(msi->vector_phy), base + cap_offset + PCI_MSI_ADDRESS_HI);
> +}
> +
> +static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +       struct mc_port *port = irq_data_get_irq_chip_data(data);
> +       phys_addr_t addr = port->msi.vector_phy;
> +
> +       msg->address_lo = lower_32_bits(addr);
> +       msg->address_hi = upper_32_bits(addr);
> +       msg->data = data->hwirq;
> +
> +       dev_dbg(port->dev, "msi#%x address_hi %#x address_lo %#x\n", (int)data->hwirq,
> +               msg->address_hi, msg->address_lo);
> +}
> +
> +static int mc_msi_set_affinity(struct irq_data *irq_data, const struct cpumask *mask, bool force)
> +{
> +       return -EINVAL;
> +}
> +
> +static struct irq_chip mc_msi_bottom_irq_chip = {
> +       .name = "Microchip MSI",
> +       .irq_compose_msi_msg = mc_compose_msi_msg,
> +       .irq_set_affinity = mc_msi_set_affinity,
> +};
> +
> +static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +                                  unsigned int nr_irqs, void *args)
> +{
> +       struct mc_port *port = domain->host_data;
> +       struct mc_msi *msi = &port->msi;
> +       void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
> +       unsigned long bit;
> +       u32 reg;
> +
> +       WARN_ON(nr_irqs != 1);
> +       mutex_lock(&msi->lock);
> +       bit = find_first_zero_bit(msi->used, msi->num_vectors);
> +       if (bit >= msi->num_vectors) {
> +               mutex_unlock(&msi->lock);
> +               return -ENOSPC;
> +       }
> +
> +       set_bit(bit, msi->used);
> +
> +       irq_domain_set_info(domain, virq, bit, &mc_msi_bottom_irq_chip, domain->host_data,
> +                           handle_simple_irq, NULL, NULL);
> +
> +       /* Enable MSI interrupts */
> +       reg = readl_relaxed(bridge_base_addr + MC_IMASK_LOCAL);
> +       reg |= PCIE_ENABLE_MSI;
> +       writel_relaxed(reg, bridge_base_addr + MC_IMASK_LOCAL);
> +
> +       mutex_unlock(&msi->lock);
> +
> +       return 0;
> +}
> +
> +static void mc_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
> +                                  unsigned int nr_irqs)
> +{
> +       struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +       struct mc_port *port = irq_data_get_irq_chip_data(d);
> +       struct mc_msi *msi = &port->msi;
> +
> +       mutex_lock(&msi->lock);
> +
> +       if (test_bit(d->hwirq, msi->used))
> +               __clear_bit(d->hwirq, msi->used);
> +       else
> +               dev_err(port->dev, "trying to free unused MSI%lu\n", d->hwirq);
> +
> +       mutex_unlock(&msi->lock);
> +}
> +
> +static const struct irq_domain_ops msi_domain_ops = {
> +       .alloc  = mc_irq_msi_domain_alloc,
> +       .free   = mc_irq_msi_domain_free,
> +};
> +
> +static struct irq_chip mc_msi_irq_chip = {
> +       .name = "Microchip PCIe MSI",
> +       .irq_mask = pci_msi_mask_irq,
> +       .irq_unmask = pci_msi_unmask_irq,
> +};
> +
> +static struct msi_domain_info mc_msi_domain_info = {
> +       .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_PCI_MSIX),
> +       .chip = &mc_msi_irq_chip,
> +};
> +
> +static int mc_allocate_msi_domains(struct mc_port *port)
> +{
> +       struct device *dev = port->dev;
> +       struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> +       struct mc_msi *msi = &port->msi;
> +
> +       mutex_init(&port->msi.lock);
> +
> +       msi->dev_domain = irq_domain_add_linear(NULL, msi->num_vectors, &msi_domain_ops, port);
> +       if (!msi->dev_domain) {
> +               dev_err(dev, "failed to create IRQ domain\n");
> +               return -ENOMEM;
> +       }
> +
> +       msi->msi_domain = pci_msi_create_irq_domain(fwnode, &mc_msi_domain_info, msi->dev_domain);
> +       if (!msi->msi_domain) {
> +               dev_err(dev, "failed to create MSI domain\n");
> +               irq_domain_remove(msi->dev_domain);
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static void mc_mask_intx_irq(struct irq_data *data)
> +{
> +       struct irq_desc *desc = irq_to_desc(data->irq);
> +       struct mc_port *port = irq_desc_get_chip_data(desc);

Use irq_data_get_irq_chip_data()

> +       void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
> +       unsigned long flags;
> +       u32 mask, val;
> +
> +       mask = PCIE_LOCAL_INT_ENABLE;
> +       raw_spin_lock_irqsave(&port->intx_mask_lock, flags);
> +       val = readl_relaxed(bridge_base_addr + MC_IMASK_LOCAL);
> +       val &= ~mask;
> +       writel_relaxed(val, bridge_base_addr + MC_IMASK_LOCAL);
> +       raw_spin_unlock_irqrestore(&port->intx_mask_lock, flags);
> +}
> +
> +static void mc_unmask_intx_irq(struct irq_data *data)
> +{
> +       struct irq_desc *desc = irq_to_desc(data->irq);
> +       struct mc_port *port = irq_desc_get_chip_data(desc);
> +       void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
> +       unsigned long flags;
> +       u32 mask, val;
> +
> +       mask = PCIE_LOCAL_INT_ENABLE;
> +       raw_spin_lock_irqsave(&port->intx_mask_lock, flags);
> +       val = readl_relaxed(bridge_base_addr + MC_IMASK_LOCAL);
> +       val |= mask;
> +       writel_relaxed(val, bridge_base_addr + MC_IMASK_LOCAL);
> +       raw_spin_unlock_irqrestore(&port->intx_mask_lock, flags);
> +}
> +
> +static struct irq_chip mc_intx_irq_chip = {
> +       .name = "Microchip PCIe INTx",
> +       .irq_mask = mc_mask_intx_irq,
> +       .irq_unmask = mc_unmask_intx_irq,
> +};
> +
> +static int mc_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> +                           irq_hw_number_t hwirq)
> +{
> +       irq_set_chip_and_handler(irq, &mc_intx_irq_chip, handle_simple_irq);
> +       irq_set_chip_data(irq, domain->host_data);
> +
> +       return 0;
> +}
> +
> +static const struct irq_domain_ops intx_domain_ops = {
> +       .map = mc_pcie_intx_map,
> +};
> +
> +static int mc_pcie_init_irq_domains(struct mc_port *port)
> +{
> +       struct device *dev = port->dev;
> +       struct device_node *node = dev->of_node;
> +
> +       port->intx_domain = irq_domain_add_linear(node, PCI_NUM_INTX, &intx_domain_ops, port);
> +       if (!port->intx_domain) {
> +               dev_err(dev, "failed to get an INTx IRQ domain\n");
> +               return -ENOMEM;
> +       }
> +       raw_spin_lock_init(&port->intx_mask_lock);
> +
> +       return mc_allocate_msi_domains(port);
> +}
> +
> +void mc_pcie_setup_addr_xlation(void __iomem *bridge_base_addr, u32 index, phys_addr_t axi_addr,
> +                               phys_addr_t pci_addr, size_t size)
> +{
> +       u32 atr_sz = ilog2(size) - 1;
> +       u32 val;
> +
> +       if (index == 0)
> +               val = PCIE_CONFIG_INTERFACE;
> +       else
> +               val = PCIE_TX_RX_INTERFACE;
> +
> +       writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) + MC_ATR0_AXI4_SLV0_TRSL_PARAM);
> +
> +       val = lower_32_bits(axi_addr) | (atr_sz << ATR_SIZE_SHIFT) | ATR_IMPL_ENABLE;
> +       writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
> +              MC_ATR0_AXI4_SLV0_SRCADDR_PARAM);
> +
> +       val = upper_32_bits(axi_addr);
> +
> +       writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
> +              MC_ATR0_AXI4_SLV0_SRC_ADDR);
> +
> +       val = lower_32_bits(pci_addr);
> +       writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
> +              MC_ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
> +
> +       val = upper_32_bits(pci_addr);
> +       writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
> +              MC_ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
> +
> +       val = readl(bridge_base_addr + MC_ATR0_PCIE_WIN0_SRCADDR_PARAM);
> +       val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
> +       writel(val, bridge_base_addr + MC_ATR0_PCIE_WIN0_SRCADDR_PARAM);
> +       writel(0, bridge_base_addr + MC_ATR0_PCIE_WIN0_SRC_ADDR);
> +}
> +
> +static int mc_platform_init(struct pci_config_window *cfg)
> +{
> +       struct device *dev = cfg->parent;
> +       struct device_node *np = dev->of_node;
> +       struct mc_port *port;
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct resource *res;
> +       void __iomem *bridge_base_addr;
> +       void __iomem *ctrl_base_addr;
> +       struct of_pci_range range;
> +       struct of_pci_range_parser parser;
> +       int ret;
> +       u32 irq;
> +       u32 val;
> +       u32 index;
> +
> +       port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +       if (!port)
> +               return -ENOMEM;
> +       port->dev = dev;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       if (!res)
> +               return -EINVAL;
> +
> +       port->axi_base_addr = devm_ioremap(dev, res->start, resource_size(res));

Use devm_platform_ioremap_resource.

> +       if (IS_ERR(port->axi_base_addr))
> +               return PTR_ERR(port->axi_base_addr);
> +
> +       bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
> +       ctrl_base_addr = port->axi_base_addr + MC_PCIE1_CTRL_ADDR;
> +
> +       port->msi.vector_phy = MC_MSI_ADDR;
> +       port->msi.num_vectors = MC_NUM_MSI_IRQS;
> +       ret = mc_pcie_init_irq_domains(port);
> +       if (ret) {
> +               dev_err(dev, "failed creating IRQ domains\n");
> +               return ret;
> +       }
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0) {
> +               dev_err(dev, "unable to request IRQ%d\n", irq);
> +               return -ENODEV;
> +       }
> +
> +       irq_set_chained_handler_and_data(irq, mc_pcie_isr, port);
> +
> +       /* Hardware doesn't setup MSI by default */
> +       mc_pcie_enable_msi(port, cfg->win);
> +
> +       val = PCIE_ENABLE_MSI | PCIE_LOCAL_INT_ENABLE;
> +       writel_relaxed(val, bridge_base_addr + MC_IMASK_LOCAL);
> +
> +       val = readl_relaxed(bridge_base_addr + MC_LTSSM_STATE);
> +       val |= LTSSM_L0_STATE;
> +       writel_relaxed(val, bridge_base_addr + MC_LTSSM_STATE);
> +
> +       val = ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS | ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS |
> +             ECC_CONTROL_RX_RAM_ECC_BYPASS | ECC_CONTROL_TX_RAM_ECC_BYPASS;
> +       writel_relaxed(val, ctrl_base_addr + MC_ECC_CONTROL);
> +
> +       val = PCIE_EVENT_INT_L2_EXIT_INT | PCIE_EVENT_INT_HOTRST_EXIT_INT |
> +             PCIE_EVENT_INT_DLUP_EXIT_INT | PCIE_EVENT_INT_L2_EXIT_INT_MASK |
> +             PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK | PCIE_EVENT_INT_DLUP_EXIT_INT_MASK;
> +       writel_relaxed(val, ctrl_base_addr + MC_PCIE_EVENT_INT);
> +
> +       val = SEC_ERROR_INT_TX_RAM_SEC_ERR_INT | SEC_ERROR_INT_RX_RAM_SEC_ERR_INT |
> +             SEC_ERROR_INT_PCIE2AXI_RAM_SEC_ERR_INT | SEC_ERROR_INT_AXI2PCIE_RAM_SEC_ERR_INT;
> +       writel_relaxed(val, ctrl_base_addr + MC_SEC_ERROR_INT);
> +       writel_relaxed(val, ctrl_base_addr + MC_SEC_ERROR_INT_MASK);
> +
> +       val = DED_ERROR_INT_TX_RAM_DED_ERR_INT | DED_ERROR_INT_RX_RAM_DED_ERR_INT |
> +             DED_ERROR_INT_PCIE2AXI_RAM_DED_ERR_INT | DED_ERROR_INT_AXI2PCIE_RAM_DED_ERR_INT;
> +       writel_relaxed(val, ctrl_base_addr + MC_DED_ERROR_INT);
> +       writel_relaxed(val, ctrl_base_addr + MC_DED_ERROR_INT_MASK);
> +
> +       writel_relaxed(0, bridge_base_addr + MC_IMASK_LOCAL);
> +       writel_relaxed(GENMASK(31, 0), bridge_base_addr + MC_ISTATUS_LOCAL);
> +       writel_relaxed(0, bridge_base_addr + MC_IMASK_HOST);
> +       writel_relaxed(GENMASK(31, 0), bridge_base_addr + MC_ISTATUS_HOST);
> +
> +       /* Configure Address Translation Table 0 for PCIe config space */
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

This is already available in cfg->res.

> +       if (!res)
> +               return -EINVAL;
> +
> +       mc_pcie_setup_addr_xlation(bridge_base_addr, 0, res->start & 0xffffffff, res->start,
> +                                  resource_size(res));
> +
> +       ret = of_pci_range_parser_init(&parser, np);

No host driver should have to do this. The resources are already
parsed and in bridge->windows. You'll need the bridge ptr, but
starting with 5.9 it is set to drvdata. See commit e63434f4cc0d ("PCI:
host-common: Use struct pci_host_bridge.windows list directly").

> +       if (ret)
> +               return ret;
> +
> +       index = 1;
> +       for_each_of_pci_range(&parser, &range) {
> +               if (((range.flags & IORESOURCE_TYPE_BITS) != IORESOURCE_MEM) &&
> +                   ((range.flags & IORESOURCE_TYPE_BITS) != IORESOURCE_IO))
> +                       continue;
> +
> +               mc_pcie_setup_addr_xlation(bridge_base_addr, index, range.cpu_addr, range.pci_addr,
> +                                          range.size);
> +               index++;
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct pci_ecam_ops mc_ecam_ops = {
> +       .bus_shift = 20,
> +       .init = mc_platform_init,
> +       .pci_ops = {
> +               .map_bus = pci_ecam_map_bus,
> +               .read = pci_generic_config_read,
> +               .write = pci_generic_config_write,
> +       }
> +};
> +
> +static const struct of_device_id mc_pcie_of_match[] = {
> +       {
> +               .compatible = "microchip,pcie-host-1.0",
> +               .data = &mc_ecam_ops,
> +       },
> +       {},
> +};
> +
> +MODULE_DEVICE_TABLE(of, mc_pcie_of_match)
> +
> +static struct platform_driver mc_pcie_driver = {
> +       .probe = pci_host_common_probe,
> +       .driver = {
> +               .name = "microchip-pcie",
> +               .of_match_table = mc_pcie_of_match,
> +               .suppress_bind_attrs = true,
> +       },
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
