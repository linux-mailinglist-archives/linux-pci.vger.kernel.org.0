Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70C941986FA
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 00:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgC3WIp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 18:08:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730065AbgC3WIp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Mar 2020 18:08:45 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92C172082F;
        Mon, 30 Mar 2020 22:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585606124;
        bh=ZOErm6lEmZvP+ovsodL45iQmjYZzPPNLN+eo5hQkzSo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SHHRwzG61NxtUja7gaNlX7ZyR762n8IuRYa6oyD9qp4IHyRHIFpNAa4gMUbYl/APW
         ay2NqSC9ACRHJETCz/uOACtzUiboQLS4hBqo7sglrSeDKUHBgLavo7UdKRaB8Ex7wJ
         zsPh57TTO8/aLSpS9Xgj0njvvcRz8HnqiKzdMsf8=
Received: by mail-qt1-f170.google.com with SMTP id g7so16598031qtj.13;
        Mon, 30 Mar 2020 15:08:44 -0700 (PDT)
X-Gm-Message-State: ANhLgQ00B1T9njlpifKk/TjVT84qLjofQhtLD9XlUkcznxhEsRG1+T7x
        TqN8ok5mNV9QqLzrbMg//HvQyW7INO7MQ395Ig==
X-Google-Smtp-Source: ADFU+vsxy/WcQxSvxiDJHczEz5Nnj3IOpeWpw7TJdl2/M3fVUm11rKYD/dQTJfqeYCYaprHkckA/dcd+YCXXppiG9aw=
X-Received: by 2002:aed:3461:: with SMTP id w88mr2245257qtd.143.1585606123550;
 Mon, 30 Mar 2020 15:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200330114239.1112759-1-jiaxun.yang@flygoat.com> <20200330114239.1112759-3-jiaxun.yang@flygoat.com>
In-Reply-To: <20200330114239.1112759-3-jiaxun.yang@flygoat.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 30 Mar 2020 16:08:31 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Wwx1A9_cPLwrGwmciR2h5q0ij-SBiORrCL5rDA-EGZg@mail.gmail.com>
Message-ID: <CAL_Jsq+Wwx1A9_cPLwrGwmciR2h5q0ij-SBiORrCL5rDA-EGZg@mail.gmail.com>
Subject: Re: [PATCH 2/5] PCI: Add Loongson PCI Controller support
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     "open list:MIPS" <linux-mips@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 30, 2020 at 5:44 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> This controller can be found on Loongson-2K SoC, Loongson-3
> systems with RS780E/LS7A PCH.
>
> The RS780E part of code was previously located at
> arch/mips/pci/ops-loongson3.c and now it can use generic PCI
> driver implementation.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  drivers/pci/controller/Kconfig        |  10 +
>  drivers/pci/controller/Makefile       |   1 +
>  drivers/pci/controller/pci-loongson.c | 263 ++++++++++++++++++++++++++
>  3 files changed, 274 insertions(+)
>  create mode 100644 drivers/pci/controller/pci-loongson.c
>
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 91bfdb784829..f6c3058ec4b8 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -258,6 +258,16 @@ config PCI_HYPERV_INTERFACE
>           The Hyper-V PCI Interface is a helper driver allows other drivers to
>           have a common interface with the Hyper-V PCI frontend driver.
>
> +config PCI_LOONGSON
> +       tristate "LOONGSON PCI Controller"
> +       depends on MACH_LOONGSON64

Add: || COMPILE_TEST

(assuming that builds on x86, arm, etc.)

> +       depends on OF
> +       depends on PCI_QUIRKS
> +       default y

New drivers should not default to yes.

> +       help
> +         Say Y here if you want to enable PCI controller support on
> +         Loongson systems.
> +
>  source "drivers/pci/controller/dwc/Kconfig"
>  source "drivers/pci/controller/mobiveil/Kconfig"
>  source "drivers/pci/controller/cadence/Kconfig"
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index 158c59771824..fbac4b0190a0 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
>  obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
>  obj-$(CONFIG_VMD) += vmd.o
>  obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
> +obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
>  # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
>  obj-y                          += dwc/
>  obj-y                          += mobiveil/
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> new file mode 100644
> index 000000000000..b9abb27793ab
> --- /dev/null
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -0,0 +1,263 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Loongson PCI Host Controller Driver
> + *
> + * Copyright (C) 2020 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + */
> +
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci.h>
> +#include <linux/pci_ids.h>
> +
> +#include "../pci.h"
> +
> +/* Device IDs */
> +#define DEV_PCIE_PORT_0        0x7a09
> +#define DEV_PCIE_PORT_1        0x7a19
> +#define DEV_PCIE_PORT_2        0x7a29
> +
> +#define DEV_LS2K_APB   0x7a02
> +#define DEV_LS7A_CONF  0x7a10
> +#define DEV_LS7A_LPC   0x7a0c
> +
> +#define FLAG_CFG0      BIT(0)
> +#define FLAG_CFG1      BIT(1)
> +#define FLAG_DEV_FIX   BIT(2)
> +
> +struct loongson_pci {
> +       void __iomem *cfg0_base;
> +       void __iomem *cfg1_base;
> +       struct platform_device *pdev;
> +       u32 flags;
> +};
> +
> +/* Fixup wrong class code in PCIe bridges */
> +static void bridge_class_quirk(struct pci_dev *dev)
> +{
> +       dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
> +                       DEV_PCIE_PORT_0, bridge_class_quirk);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
> +                       DEV_PCIE_PORT_1, bridge_class_quirk);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
> +                       DEV_PCIE_PORT_2, bridge_class_quirk);
> +
> +static void system_bus_quirk(struct pci_dev *pdev)
> +{
> +       u16 tmp;
> +
> +       pdev->mmio_always_on = 1;
> +       pdev->non_compliant_bars = 1;
> +       /* Enable MEM & IO Decoding */
> +       pci_read_config_word(pdev, PCI_STATUS, &tmp);
> +       tmp |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
> +       pci_write_config_word(pdev, PCI_STATUS, tmp);
> +}
> +
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +                       DEV_LS2K_APB, system_bus_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +                       DEV_LS7A_CONF, system_bus_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +                       DEV_LS7A_LPC, system_bus_quirk);
> +
> +static void loongson_mrrs_quirk(struct pci_dev *dev)
> +{
> +       struct pci_bus *bus = dev->bus;
> +       struct pci_dev *bridge;
> +       static const struct pci_device_id bridge_devids[] = {
> +               { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> +               { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
> +               { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> +               { 0, },
> +       };
> +
> +
> +       /* look for the matching bridge */
> +       while (!pci_is_root_bus(bus)) {
> +               bridge = bus->self;
> +               bus = bus->parent;
> +               /*
> +                * Some Loongson PCIE ports has a h/w limitation of
> +                * 256 bytes maximum read request size. It can't handle
> +                * anything higher than this. So force this limit on
> +                * any devices attached under these ports.
> +                */
> +               if (pci_match_id(bridge_devids, bridge)) {
> +                       if (pcie_get_readrq(dev) > 256) {
> +                               dev_info(&dev->dev, "limiting MRRS to 256\n");
> +                               pcie_set_readrq(dev, 256);
> +                       }
> +                       break;
> +               }
> +       }
> +}
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
> +
> +static void __iomem *cfg1_map(struct loongson_pci *priv, int bus, int dev,
> +                               int func, int where)
> +{
> +       unsigned long addroff = 0x0;
> +
> +       if (bus != 0)
> +               addroff |= BIT(28); /* Type 1 Access */
> +       addroff |= (where & 0xff) | ((where & 0xf00) << 16);
> +       addroff |= (bus << 16) | (dev << 11) | (func << 8);
> +       return priv->cfg1_base + addroff;
> +}
> +
> +static void __iomem *cfg0_map(struct loongson_pci *priv, int bus, int dev,
> +                               int func, int where)
> +{
> +       unsigned long addroff = 0x0;
> +
> +       if (bus != 0)
> +               addroff |= BIT(24); /* Type 1 Access */
> +       addroff |= (bus << 16) | (dev << 11) | (func << 8) | where;
> +       return priv->cfg0_base + addroff;
> +}
> +
> +void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devfn,
> +                              int where)
> +{
> +       unsigned char busnum = bus->number;
> +       int device = PCI_SLOT(devfn);
> +       int function = PCI_FUNC(devfn);
> +       struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
> +       struct loongson_pci *priv =  pci_host_bridge_priv(bridge);
> +
> +       /*
> +        * Do not read more than one device on the bus other than
> +        * the host bridge.
> +        */
> +       if (bus->primary != 0 && device > 0 &&
> +               priv->flags & FLAG_DEV_FIX)
> +               return NULL;
> +
> +       /* CFG0 can only access standard space */
> +       if (where < PCI_CFG_SPACE_SIZE && priv->flags & FLAG_CFG0 &&
> +               priv->cfg0_base)
> +               return cfg0_map(priv, busnum, device, function, where);
> +
> +       /* CFG1 can access exp space */
> +       if (where < PCI_CFG_SPACE_EXP_SIZE && priv->flags & FLAG_CFG1 &&
> +               priv->cfg1_base)
> +               return cfg1_map(priv, busnum, device, function, where);
> +
> +

Single blank line.

> +       return NULL;
> +}
> +
> +static int loongson_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +{
> +       int irq;
> +       u8 val;
> +
> +       irq = of_irq_parse_and_map_pci(dev, slot, pin);
> +       if (irq > 0)
> +               return irq;
> +
> +       /* Care legacy systems */
> +       pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &val);
> +       /* 0xff is also invalid */
> +       if (val == 0xff)
> +               return 0;
> +
> +       return val;
> +}
> +
> +/* PCI operations */
> +static struct pci_ops loongson_pci_ops = {
> +       .map_bus = pci_loongson_map_bus,
> +       .read   = pci_generic_config_read32,
> +       .write  = pci_generic_config_write32,

Do you really require 32-bit writes? That isn't safe. See comments for
the function.

> +};
> +
> +static const struct of_device_id loongson_pci_of_match[] = {
> +       { .compatible = "loongson,rs780e-pci",
> +               .data = (void *)(FLAG_CFG0), },
> +       { .compatible = "loongson,ls2k-pci",
> +               .data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
> +       { .compatible = "loongson,ls7a-pci",
> +               .data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
> +       {}
> +};
> +
> +static int loongson_pci_probe(struct platform_device *pdev)
> +{
> +       struct loongson_pci *priv;
> +       struct device *dev = &pdev->dev;
> +       struct device_node *node = dev->of_node;
> +       struct pci_host_bridge *bridge;
> +       const struct of_device_id *match;
> +       struct resource regs;
> +       int err;
> +       LIST_HEAD(res);
> +
> +       if (!node)
> +               return -ENODEV;
> +
> +       bridge = devm_pci_alloc_host_bridge(dev, sizeof(*priv));
> +       if (!bridge)
> +               return -ENODEV;
> +
> +       priv = pci_host_bridge_priv(bridge);
> +       priv->pdev = pdev;
> +
> +       match = of_match_device(loongson_pci_of_match, &pdev->dev);
> +       priv->flags = (unsigned long)match->data;

Use of_device_get_match_data() instead.

> +
> +       err = of_address_to_resource(node, 0, &regs);

Use platform_get_resource() instead.

You should be able to drop of_address.h

> +       if (err) {
> +               dev_err(dev, "missing \"reg\" property for cfg0\n");
> +               return err;
> +       }
> +
> +       priv->cfg0_base = devm_pci_remap_cfg_resource(dev, &regs);
> +       if (IS_ERR(priv->cfg0_base))
> +               return PTR_ERR(priv->cfg0_base);
> +
> +       /* CFG1 is optional */
> +       if (priv->flags & FLAG_CFG1) {
> +               if (of_address_to_resource(node, 1, &regs))
> +                       dev_info(dev, "missing \"reg\" property for cfg1\n");
> +               else {
> +                       priv->cfg1_base = devm_pci_remap_cfg_resource(dev, &regs);
> +                       if (IS_ERR(priv->cfg1_base))
> +                               priv->cfg1_base = NULL;
> +               }
> +       }
> +
> +
> +       err = pci_parse_request_of_pci_ranges(dev, &res,

Just pass &bridge->windows and remove res.

> +                                               &bridge->dma_ranges, NULL);
> +       if (err) {
> +               dev_err(dev, "Failed to get bridge resources\n");
> +               return err;
> +       }
> +
> +       list_splice_init(&res, &bridge->windows);
> +       bridge->dev.parent = dev;
> +       bridge->sysdata = priv;
> +       bridge->busnr = 0;

Already 0.

> +       bridge->ops = &loongson_pci_ops;
> +       bridge->map_irq = loongson_map_irq;
> +
> +       err = pci_host_probe(bridge);
> +       if (err)
> +               return err;
> +
> +       return 0;
> +}
> +
> +static struct platform_driver loongson_pci_driver = {
> +       .driver = {
> +               .name = "loongson-pci",
> +               .of_match_table = loongson_pci_of_match,
> +       },
> +       .probe = loongson_pci_probe,
> +};
> +builtin_platform_driver(loongson_pci_driver);

Can't work as a module?

Rob
