Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903DF3ECB0E
	for <lists+linux-pci@lfdr.de>; Sun, 15 Aug 2021 22:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhHOU6i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 16:58:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230352AbhHOU6h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 16:58:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 210256137A;
        Sun, 15 Aug 2021 20:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629061087;
        bh=701hC0Pot4YsRAa+iaWLWdi0Rx4tcYoDLxbMcFJr9ic=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PRey80e3BTQy0ZrIppsVN7Ao0R8V+DQSAazXxXX3MGEB/YwHxtFnfxL+Jm839E0An
         z0dU6Di16fBcOjqCwuzSWk8Rk52L52xuSNUrlwFBCB5pnDCNhgxtKjRLiTuc7tQrPL
         PQMhNfVMJEo+dydFvDF0LNLuX2AYqaHvpYmcIq44wjQP+kUbrM1/4a9qJrciR+e68P
         lZnEfsoaYUA+TcA0b7OnmcNDMUaEn40OUFdt5wIb95llM54LEinCqZufM+AbI690hT
         1veVvaRIjrqHfheLW/KAmoiRrmrKZMQgnubmChS+7U3kUln/jVZX/40DmeO9uKaz4t
         2dmprSNHXpEKA==
Received: by mail-ej1-f54.google.com with SMTP id u3so28310763ejz.1;
        Sun, 15 Aug 2021 13:58:07 -0700 (PDT)
X-Gm-Message-State: AOAM533uNQPzuKhQDUevR8yAjCulTLmVijMeOuSj3wCoOZ6T8QDIB9er
        xHjyNaIcTrjUz3nKwidysajWOSH+TLi4aRSZqQ==
X-Google-Smtp-Source: ABdhPJyq0vLK2t57/+XHb6p+i8A1B5VURFVXP0sEPT4szm07T192iP3qXDM4CZMHXJckQx8yaDy/grJa1XkdlAtM64g=
X-Received: by 2002:a17:906:fa92:: with SMTP id lt18mr12962504ejb.359.1629061085598;
 Sun, 15 Aug 2021 13:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210815042525.36878-1-alyssa@rosenzweig.io> <20210815042525.36878-3-alyssa@rosenzweig.io>
In-Reply-To: <20210815042525.36878-3-alyssa@rosenzweig.io>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 15 Aug 2021 15:57:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJfhQr7fa4dD2cOQmo8bdj2fQ+2Hjrh_4Xie-zbr1g7KQ@mail.gmail.com>
Message-ID: <CAL_JsqJfhQr7fa4dD2cOQmo8bdj2fQ+2Hjrh_4Xie-zbr1g7KQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] PCI: apple: Add driver for the Apple M1
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Stan Skowronek <stan@corellium.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 14, 2021 at 11:34 PM Alyssa Rosenzweig <alyssa@rosenzweig.io> wrote:
>
> Add a driver for the PCIe controller found in Apple system-on-chips,
> particularly the Apple M1. This driver exposes the internal bus used for
> the USB type-A ports, Ethernet, Wi-Fi, and Bluetooth. This patch brings
> up the USB type-A ports and Ethernet. Bringing up the radios requires
> interfacing with the System Management Coprocessor via Apple's
> mailboxes, so that's left to a future patch.
>
> In this state, the driver consists of two major parts: hardware
> initialization and MSI handling. The hardware initialization is derived
> from Mark Kettenis's U-Boot patches which in turn is derived from
> Corellium's patches for the hardware. The rest of the driver is derived
> from Marc Zyngier's driver for the hardware.
>
> Co-developed-by: Stan Skowronek <stan@corellium.com>
> Signed-off-by: Stan Skowronek <stan@corellium.com>
> Co-developed-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> ---
>  MAINTAINERS                         |   1 +
>  drivers/pci/controller/Kconfig      |  13 +
>  drivers/pci/controller/Makefile     |   1 +
>  drivers/pci/controller/pcie-apple.c | 466 ++++++++++++++++++++++++++++
>  4 files changed, 481 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-apple.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d7d2e1d1e2f2..f13f65a844f7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1274,6 +1274,7 @@ M:        Alyssa Rosenzweig <alyssa@rosenzweig.io>
>  L:     linux-pci@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/pci/apple,pcie.yaml
> +F:     drivers/pci/controller/pcie-apple.c
>
>  APPLE SMC DRIVER
>  M:     Henrik Rydberg <rydberg@bitmath.org>
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 326f7d13024f..881a6a81f3e2 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -312,6 +312,19 @@ config PCIE_HISI_ERR
>           Say Y here if you want error handling support
>           for the PCIe controller's errors on HiSilicon HIP SoCs
>
> +config PCIE_APPLE
> +       tristate "Apple PCIe controller"
> +       depends on ARCH_APPLE || COMPILE_TEST
> +       depends on OF
> +       depends on PCI_MSI_IRQ_DOMAIN
> +       depends on GPIOLIB
> +       help
> +         Say Y here if you want to enable PCIe controller support on Apple
> +         system-on-chips, like the Apple M1. This is required for the USB
> +         type-A ports, Ethernet, Wi-Fi, and Bluetooth.
> +
> +         If unsure, say Y if you have an Apple Silicon system.
> +
>  source "drivers/pci/controller/dwc/Kconfig"
>  source "drivers/pci/controller/mobiveil/Kconfig"
>  source "drivers/pci/controller/cadence/Kconfig"
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index aaf30b3dcc14..f9d40bad932c 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_VMD) += vmd.o
>  obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
>  obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
>  obj-$(CONFIG_PCIE_HISI_ERR) += pcie-hisi-error.o
> +obj-$(CONFIG_PCIE_APPLE) += pcie-apple.o
>  # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
>  obj-y                          += dwc/
>  obj-y                          += mobiveil/
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> new file mode 100644
> index 000000000000..08088e06460f
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -0,0 +1,466 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host bridge driver for Apple system-on-chips.
> + *
> + * The HW is ECAM compliant, so once the controller is initialized, the driver
> + * mostly only needs MSI handling. Initialization requires enabling power and
> + * clocks, along with a number of register pokes.
> + *
> + * Copyright (C) 2021 Google LLC
> + * Copyright (C) 2021 Corellium LLC
> + * Copyright (C) 2021 Mark Kettenis <kettenis@openbsd.org>
> + * Copyright (C) 2021 Alyssa Rosenzweig <alyssa@rosenzweig.io>
> + * Author: Marc Zyngier <maz@kernel.org>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/of_irq.h>
> +#include <linux/pci-ecam.h>
> +#include <linux/iopoll.h>
> +#include <linux/gpio/consumer.h>
> +
> +#define CORE_RC_PHYIF_CTL              0x00024
> +#define   CORE_RC_PHYIF_CTL_RUN                BIT(0)
> +#define CORE_RC_PHYIF_STAT             0x00028
> +#define   CORE_RC_PHYIF_STAT_REFCLK    BIT(4)
> +#define CORE_RC_CTL                    0x00050
> +#define   CORE_RC_CTL_RUN              BIT(0)
> +#define CORE_RC_STAT                   0x00058
> +#define   CORE_RC_STAT_READY           BIT(0)
> +#define CORE_FABRIC_STAT               0x04000
> +#define   CORE_FABRIC_STAT_MASK                0x001F001F
> +#define CORE_PHY_CTL                   0x80000
> +#define   CORE_PHY_CTL_CLK0REQ         BIT(0)
> +#define   CORE_PHY_CTL_CLK1REQ         BIT(1)
> +#define   CORE_PHY_CTL_CLK0ACK         BIT(2)
> +#define   CORE_PHY_CTL_CLK1ACK         BIT(3)
> +#define   CORE_PHY_CTL_RESET           BIT(7)

I was going to say these should be a phy driver perhaps, but they are
unused. So for now, just drop them.

> +#define CORE_LANE_CFG(port)            (0x84000 + 0x4000 * (port))
> +#define   CORE_LANE_CFG_REFCLK0REQ     BIT(0)
> +#define   CORE_LANE_CFG_REFCLK1                BIT(1)
> +#define   CORE_LANE_CFG_REFCLK0ACK     BIT(2)
> +#define   CORE_LANE_CFG_REFCLKEN       (BIT(9) | BIT(10))
> +#define CORE_LANE_CTL(port)            (0x84004 + 0x4000 * (port))
> +#define   CORE_LANE_CTL_CFGACC         BIT(15)
> +
> +#define PORT_LTSSMCTL                  0x00080
> +#define   PORT_LTSSMCTL_START          BIT(0)
> +#define PORT_INTSTAT                   0x00100
> +#define   PORT_INT_TUNNEL_ERR          BIT(31)
> +#define   PORT_INT_CPL_TIMEOUT         BIT(23)
> +#define   PORT_INT_RID2SID_MAPERR      BIT(22)
> +#define   PORT_INT_CPL_ABORT           BIT(21)
> +#define   PORT_INT_MSI_BAD_DATA                BIT(19)
> +#define   PORT_INT_MSI_ERR             BIT(18)
> +#define   PORT_INT_REQADDR_GT32                BIT(17)
> +#define   PORT_INT_AF_TIMEOUT          BIT(15)
> +#define   PORT_INT_LINK_DOWN           BIT(14)
> +#define   PORT_INT_LINK_UP             BIT(12)
> +#define   PORT_INT_LINK_BWMGMT         BIT(11)
> +#define   PORT_INT_AER_MASK            (15 << 4)
> +#define   PORT_INT_PORT_ERR            BIT(4)
> +#define   PORT_INT_INTx(i)             BIT(i)
> +#define   PORT_INT_INTxALL             15
> +#define PORT_INTMSK                    0x00104
> +#define PORT_INTMSKSET                 0x00108
> +#define PORT_INTMSKCLR                 0x0010c
> +#define PORT_MSICFG                    0x00124
> +#define   PORT_MSICFG_EN               BIT(0)
> +#define   PORT_MSICFG_L2MSINUM_SHIFT   4
> +#define PORT_MSIBASE                   0x00128
> +#define   PORT_MSIBASE_1_SHIFT         16
> +#define PORT_MSIADDR                   0x00168
> +#define PORT_LINKSTS                   0x00208
> +#define   PORT_LINKSTS_UP              BIT(0)
> +#define   PORT_LINKSTS_BUSY            BIT(2)
> +#define PORT_LINKCMDSTS                        0x00210
> +#define PORT_OUTS_NPREQS               0x00284
> +#define   PORT_OUTS_NPREQS_REQ         BIT(24)
> +#define   PORT_OUTS_NPREQS_CPL         BIT(16)
> +#define PORT_RXWR_FIFO                 0x00288
> +#define   PORT_RXWR_FIFO_HDR           GENMASK(15, 10)
> +#define   PORT_RXWR_FIFO_DATA          GENMASK(9, 0)
> +#define PORT_RXRD_FIFO                 0x0028C
> +#define   PORT_RXRD_FIFO_REQ           GENMASK(6, 0)
> +#define PORT_OUTS_CPLS                 0x00290
> +#define   PORT_OUTS_CPLS_SHRD          GENMASK(14, 8)
> +#define   PORT_OUTS_CPLS_WAIT          GENMASK(6, 0)
> +#define PORT_APPCLK                    0x00800
> +#define   PORT_APPCLK_EN               BIT(0)
> +#define   PORT_APPCLK_CGDIS            BIT(8)
> +#define PORT_STATUS                    0x00804
> +#define   PORT_STATUS_READY            BIT(0)
> +#define PORT_REFCLK                    0x00810
> +#define   PORT_REFCLK_EN               BIT(0)
> +#define   PORT_REFCLK_CGDIS            BIT(8)
> +#define PORT_PERST                     0x00814
> +#define   PORT_PERST_OFF               BIT(0)
> +#define PORT_RID2SID(i16)              (0x00828 + 4 * (i16))
> +#define   PORT_RID2SID_VALID           BIT(31)
> +#define   PORT_RID2SID_SID_SHIFT       16
> +#define   PORT_RID2SID_BUS_SHIFT       8
> +#define   PORT_RID2SID_DEV_SHIFT       3
> +#define   PORT_RID2SID_FUNC_SHIFT      0
> +#define PORT_OUTS_PREQS_HDR            0x00980
> +#define   PORT_OUTS_PREQS_HDR_MASK     GENMASK(9, 0)
> +#define PORT_OUTS_PREQS_DATA           0x00984
> +#define   PORT_OUTS_PREQS_DATA_MASK    GENMASK(15, 0)
> +#define PORT_TUNCTRL                   0x00988
> +#define   PORT_TUNCTRL_PERST_ON                BIT(0)
> +#define   PORT_TUNCTRL_PERST_ACK_REQ   BIT(1)
> +#define PORT_TUNSTAT                   0x0098c
> +#define   PORT_TUNSTAT_PERST_ON                BIT(0)
> +#define   PORT_TUNSTAT_PERST_ACK_PEND  BIT(1)
> +#define PORT_PREFMEM_ENABLE            0x00994
> +
> +/* The doorbell address is "well known" */
> +#define DOORBELL_ADDR                  0xfffff000
> +
> +/* The hardware exposes 3 ports. Port 0 (WiFi and Bluetooth) is special, as it
> + * is power-gated by SMC to facilitate rfkill.
> + */
> +enum apple_pcie_port {
> +       APPLE_PCIE_PORT_RADIO    = 0,
> +       APPLE_PCIE_PORT_USB      = 1,
> +       APPLE_PCIE_PORT_ETHERNET = 2,
> +       APPLE_PCIE_NUM_PORTS
> +};
> +
> +struct apple_pcie {
> +       u32                     msi_base;
> +       u32                     nvecs;
> +       struct mutex            lock;
> +       struct device           *dev;
> +       struct irq_domain       *domain;
> +       unsigned long           *bitmap;
> +       void __iomem            *rc;
> +};
> +
> +static inline void rmwl(u32 clr, u32 set, void __iomem *addr)
> +{
> +       writel((readl(addr) & ~clr) | set, addr);
> +}
> +
> +static void apple_msi_top_irq_mask(struct irq_data *d)
> +{
> +       pci_msi_mask_irq(d);
> +       irq_chip_mask_parent(d);
> +}
> +
> +static void apple_msi_top_irq_unmask(struct irq_data *d)
> +{
> +       pci_msi_unmask_irq(d);
> +       irq_chip_unmask_parent(d);
> +}
> +
> +static void apple_msi_top_irq_eoi(struct irq_data *d)
> +{
> +       irq_chip_eoi_parent(d);
> +}
> +
> +static struct irq_chip apple_msi_top_chip = {
> +       .name                   = "PCIe MSI",
> +       .irq_mask               = apple_msi_top_irq_mask,
> +       .irq_unmask             = apple_msi_top_irq_unmask,
> +       .irq_eoi                = apple_msi_top_irq_eoi,
> +       .irq_set_affinity       = irq_chip_set_affinity_parent,
> +       .irq_set_type           = irq_chip_set_type_parent,
> +};
> +
> +static void apple_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +       msg->address_hi = 0;
> +       msg->address_lo = DOORBELL_ADDR;
> +       msg->data = data->hwirq;
> +}
> +
> +static struct irq_chip apple_msi_bottom_chip = {
> +       .name                   = "MSI",
> +       .irq_mask               = irq_chip_mask_parent,
> +       .irq_unmask             = irq_chip_unmask_parent,
> +       .irq_set_affinity       = irq_chip_set_affinity_parent,
> +       .irq_eoi                = irq_chip_eoi_parent,
> +       .irq_set_affinity       = irq_chip_set_affinity_parent,
> +       .irq_set_type           = irq_chip_set_type_parent,
> +       .irq_compose_msi_msg    = apple_msi_compose_msg,
> +};
> +
> +static int apple_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +                                 unsigned int nr_irqs, void *args)
> +{
> +       struct apple_pcie *pcie = domain->host_data;
> +       struct irq_fwspec fwspec;
> +       unsigned int i;
> +       int ret, hwirq;
> +
> +       mutex_lock(&pcie->lock);
> +
> +       hwirq = bitmap_find_free_region(pcie->bitmap, pcie->nvecs,
> +                                       order_base_2(nr_irqs));
> +
> +       mutex_unlock(&pcie->lock);
> +
> +       if (hwirq < 0)
> +               return -ENOSPC;
> +
> +       fwspec.fwnode = domain->parent->fwnode;
> +       fwspec.param_count = 3;
> +       fwspec.param[0] = 0;
> +       fwspec.param[1] = hwirq + pcie->msi_base;
> +       fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
> +
> +       ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &fwspec);
> +       if (ret)
> +               return ret;
> +
> +       for (i = 0; i < nr_irqs; i++) {
> +               irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> +                                             &apple_msi_bottom_chip,
> +                                             domain->host_data);
> +       }
> +
> +       return 0;
> +}
> +
> +static void apple_msi_domain_free(struct irq_domain *domain, unsigned int virq,
> +                                 unsigned int nr_irqs)
> +{
> +       struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +       struct apple_pcie *pcie = domain->host_data;
> +
> +       mutex_lock(&pcie->lock);
> +
> +       bitmap_release_region(pcie->bitmap, d->hwirq, order_base_2(nr_irqs));
> +
> +       mutex_unlock(&pcie->lock);
> +}
> +
> +static const struct irq_domain_ops apple_msi_domain_ops = {
> +       .alloc  = apple_msi_domain_alloc,
> +       .free   = apple_msi_domain_free,
> +};
> +
> +static struct msi_domain_info apple_msi_info = {
> +       .flags  = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +                  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
> +       .chip   = &apple_msi_top_chip,
> +};
> +
> +static int apple_pcie_setup_refclk(void __iomem *rc,
> +                                  void __iomem *port,
> +                                  unsigned int idx)
> +{
> +       u32 stat;
> +       int res;
> +
> +       res = readl_poll_timeout(rc + CORE_RC_PHYIF_STAT, stat,
> +                                stat & CORE_RC_PHYIF_STAT_REFCLK, 100, 50000);
> +       if (res < 0)
> +               return res;
> +
> +       rmwl(0, CORE_LANE_CTL_CFGACC, rc + CORE_LANE_CTL(idx));
> +       rmwl(0, CORE_LANE_CFG_REFCLK0REQ, rc + CORE_LANE_CFG(idx));
> +
> +       res = readl_poll_timeout(rc + CORE_LANE_CFG(idx), stat,
> +                                stat & CORE_LANE_CFG_REFCLK0ACK, 100, 50000);
> +       if (res < 0)
> +               return res;
> +
> +       rmwl(0, CORE_LANE_CFG_REFCLK1, rc + CORE_LANE_CFG(idx));
> +       res = readl_poll_timeout(rc + CORE_LANE_CFG(idx), stat,
> +                                stat & CORE_LANE_CFG_REFCLK1, 100, 50000);
> +
> +       if (res < 0)
> +               return res;
> +
> +       rmwl(CORE_LANE_CTL_CFGACC, 0, rc + CORE_LANE_CTL(idx));
> +       udelay(1);
> +       rmwl(0, CORE_LANE_CFG_REFCLKEN, rc + CORE_LANE_CFG(idx));
> +
> +       rmwl(0, PORT_REFCLK_EN, port + PORT_REFCLK);
> +
> +       return 0;
> +}
> +
> +static int apple_pcie_setup_port(struct apple_pcie *pcie, unsigned int i)
> +{
> +       struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);

Doesn't look like you ever use the fwnode, just get the DT node
pointer. Unless this driver is going to use ACPI someday (and ACPI
changes how PCI is done), there's no point in using fwnode.

> +       void __iomem *port;
> +       struct gpio_desc *reset;
> +       uint32_t stat;
> +       int ret;
> +
> +       port = devm_of_iomap(pcie->dev, to_of_node(fwnode), i + 3, NULL);

It's preferred to use platform resource api and ioremap over DT functions.

> +
> +       if (IS_ERR(port))
> +               return -ENODEV;
> +
> +       reset = devm_gpiod_get_index(pcie->dev, "reset", i, 0);
> +       if (IS_ERR(reset))
> +               return PTR_ERR(reset);
> +
> +       gpiod_direction_output(reset, 0);
> +
> +       rmwl(0, PORT_APPCLK_EN, port + PORT_APPCLK);
> +
> +       ret = apple_pcie_setup_refclk(pcie->rc, port, i);
> +       if (ret < 0)
> +               return ret;
> +
> +       rmwl(0, PORT_PERST_OFF, port + PORT_PERST);
> +       gpiod_set_value(reset, 1);
> +
> +       ret = readl_poll_timeout(port + PORT_STATUS, stat,
> +                                stat & PORT_STATUS_READY, 100, 250000);
> +       if (ret < 0) {
> +               dev_err(pcie->dev, "port %u ready wait timeout\n", i);
> +               return ret;
> +       }
> +
> +       rmwl(PORT_REFCLK_CGDIS, 0, port + PORT_REFCLK);
> +       rmwl(PORT_APPCLK_CGDIS, 0, port + PORT_APPCLK);
> +
> +       ret = readl_poll_timeout(port + PORT_LINKSTS, stat,
> +                                !(stat & PORT_LINKSTS_BUSY), 100, 250000);
> +       if (ret < 0) {
> +               dev_err(pcie->dev, "port %u link not busy timeout\n", i);
> +               return ret;
> +       }
> +
> +       writel(0xfb512fff, port + PORT_INTMSKSET);
> +
> +       writel(PORT_INT_LINK_UP | PORT_INT_LINK_DOWN | PORT_INT_AF_TIMEOUT |
> +              PORT_INT_REQADDR_GT32 | PORT_INT_MSI_ERR |
> +              PORT_INT_MSI_BAD_DATA | PORT_INT_CPL_ABORT |
> +              PORT_INT_CPL_TIMEOUT | (1 << 26), port + PORT_INTSTAT);
> +
> +       usleep_range(5000, 10000);
> +
> +       rmwl(0, PORT_LTSSMCTL_START, port + PORT_LTSSMCTL);
> +
> +       ret = readl_poll_timeout(port + PORT_LINKSTS, stat,
> +                                stat & PORT_LINKSTS_UP, 100, 500000);
> +       if (ret < 0) {
> +               dev_err(pcie->dev, "port %u link up wait timeout\n", i);
> +               return ret;
> +       }
> +
> +       writel(DOORBELL_ADDR, port + PORT_MSIADDR);
> +       writel(0, port + PORT_MSIBASE);
> +       writel((5 << PORT_MSICFG_L2MSINUM_SHIFT) | PORT_MSICFG_EN,
> +              port + PORT_MSICFG);
> +
> +       return 0;
> +}
> +
> +static int apple_msi_init(struct apple_pcie *pcie)
> +{
> +       struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
> +       struct device_node *parent_intc;
> +       struct irq_domain *parent;
> +       int ret, i;
> +
> +       pcie->rc = devm_of_iomap(pcie->dev, to_of_node(fwnode), 1, NULL);

Use devm_platform_ioremap_resource instead.

Rob
