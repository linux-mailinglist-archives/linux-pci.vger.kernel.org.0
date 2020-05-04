Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4411C4A81
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 01:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgEDXnd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 19:43:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgEDXnc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 19:43:32 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41369206A4;
        Mon,  4 May 2020 23:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588635811;
        bh=IIO/VEz6xCydUxsIfH4s10Jq/d4K4Rnc0dQtg+qzOIU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WKsE5c8j+HGSRl7lyI22/rjYXHGCprNBD5dZkiftJFzEkppUHwmbybyindIS/T+OR
         Y8Is1tWPJ3Mk6FwErMqTPj88/UaK6c6fSBnubxb+dwDbZ6u9fY3yAPgZSXfX/jD8mI
         bx7OxCOaGx8IygtfDpcY6txvyLwurKMylCvAfOOI=
Date:   Mon, 4 May 2020 18:43:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/5] PCI: Add Loongson PCI Controller support
Message-ID: <20200504234329.GA300770@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428011429.1852081-3-jiaxun.yang@flygoat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 28, 2020 at 09:14:17AM +0800, Jiaxun Yang wrote:
> This controller can be found on Loongson-2K SoC, Loongson-3
> systems with RS780E/LS7A PCH.
> 
> The RS780E part of code was previously located at
> arch/mips/pci/ops-loongson3.c and now it can use generic PCI
> driver implementation.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> --
> v2:
> 	- Clean up according to rob's suggestions
> 	- Claim that it can't work as a module
> v3:
> 	- Fix a typo
> v4:
> 	- More clean-ups: Drop flag check, use devfn
> v7:
> 	- Fix ordering according to huacai's suggestion
> ---
>  drivers/pci/controller/Kconfig        |  10 +
>  drivers/pci/controller/Makefile       |   1 +
>  drivers/pci/controller/pci-loongson.c | 251 ++++++++++++++++++++++++++
>  3 files changed, 262 insertions(+)
>  create mode 100644 drivers/pci/controller/pci-loongson.c
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 91bfdb784829..ae36edb1d7db 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -258,6 +258,16 @@ config PCI_HYPERV_INTERFACE
>  	  The Hyper-V PCI Interface is a helper driver allows other drivers to
>  	  have a common interface with the Hyper-V PCI frontend driver.
>  
> +config PCI_LOONGSON
> +	bool "LOONGSON PCI Controller"
> +	depends on MACH_LOONGSON64 || COMPILE_TEST
> +	depends on OF
> +	depends on PCI_QUIRKS
> +	default MACH_LOONGSON64
> +	help
> +	  Say Y here if you want to enable PCI controller support on
> +	  Loongson systems.
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

This is apparently a PCIe controller, not a Conventional PCI
controller, since you reference PCIe-specific things like MRRS below.

If that's the case, I'd name it pcie-loongson.c.

>  # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
>  obj-y				+= dwc/
>  obj-y				+= mobiveil/
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> new file mode 100644
> index 000000000000..db1ebf42faf3
> --- /dev/null
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -0,0 +1,251 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Loongson PCI Host Controller Driver
> + *
> + * Copyright (C) 2020 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + */
> +
> +#include <linux/of_device.h>
> +#include <linux/of_pci.h>
> +#include <linux/pci.h>
> +#include <linux/pci_ids.h>
> +
> +#include "../pci.h"
> +
> +/* Device IDs */
> +#define DEV_PCIE_PORT_0	0x7a09
> +#define DEV_PCIE_PORT_1	0x7a19
> +#define DEV_PCIE_PORT_2	0x7a29
> +
> +#define DEV_LS2K_APB	0x7a02
> +#define DEV_LS7A_CONF	0x7a10
> +#define DEV_LS7A_LPC	0x7a0c
> +
> +#define FLAG_CFG0	BIT(0)
> +#define FLAG_CFG1	BIT(1)
> +#define FLAG_DEV_FIX	BIT(2)
> +
> +struct loongson_pci {
> +	void __iomem *cfg0_base;
> +	void __iomem *cfg1_base;
> +	struct platform_device *pdev;
> +	u32 flags;
> +};
> +
> +/* Fixup wrong class code in PCIe bridges */
> +static void bridge_class_quirk(struct pci_dev *dev)
> +{
> +	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_0, bridge_class_quirk);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_1, bridge_class_quirk);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_2, bridge_class_quirk);
> +
> +static void system_bus_quirk(struct pci_dev *pdev)
> +{
> +	u16 tmp;
> +
> +	pdev->mmio_always_on = 1;
> +	pdev->non_compliant_bars = 1;
> +	/* Enable MEM & IO Decoding */
> +	pci_read_config_word(pdev, PCI_STATUS, &tmp);
> +	tmp |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
> +	pci_write_config_word(pdev, PCI_STATUS, tmp);

This needs some sort of explanation.  Is the non_compliant_bars part
an erratum?

And why can't we disable MEM/IO decoding?

You're also writing PCI_COMMAND_* bits to the PCI_STATUS register,
which is clearly broken.

Since we need an update for at least the PCI_STATUS part, there's
a little minor bike-shedding below.

> +}
> +
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_LS2K_APB, system_bus_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_LS7A_CONF, system_bus_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_LS7A_LPC, system_bus_quirk);
> +
> +static void loongson_mrrs_quirk(struct pci_dev *dev)
> +{
> +	struct pci_bus *bus = dev->bus;
> +	struct pci_dev *bridge;
> +	static const struct pci_device_id bridge_devids[] = {
> +		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
> +		{ 0, },
> +	};
> +
> +
> +	/* look for the matching bridge */
> +	while (!pci_is_root_bus(bus)) {
> +		bridge = bus->self;
> +		bus = bus->parent;
> +		/*
> +		 * Some Loongson PCIE ports has a h/w limitation of
> +		 * 256 bytes maximum read request size. It can't handle
> +		 * anything higher than this. So force this limit on
> +		 * any devices attached under these ports.

s/PCIE/PCIe/
s/ports has/ports have/
s/It can't/They can't/
s/anything higher/anything larger/

> +		 */
> +		if (pci_match_id(bridge_devids, bridge)) {
> +			if (pcie_get_readrq(dev) > 256) {
> +				dev_info(&dev->dev, "limiting MRRS to 256\n");

pci_info(dev, ...)

> +				pcie_set_readrq(dev, 256);
> +			}
> +			break;
> +		}
> +	}
> +}
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
> +
> +static void __iomem *cfg1_map(struct loongson_pci *priv, int bus,
> +				unsigned int devfn, int where)
> +{
> +	unsigned long addroff = 0x0;
> +
> +	if (bus != 0)
> +		addroff |= BIT(28); /* Type 1 Access */
> +	addroff |= (where & 0xff) | ((where & 0xf00) << 16);
> +	addroff |= (bus << 16) | (devfn << 8);
> +	return priv->cfg1_base + addroff;
> +}
> +
> +static void __iomem *cfg0_map(struct loongson_pci *priv, int bus,
> +				unsigned int devfn, int where)
> +{
> +	unsigned long addroff = 0x0;
> +
> +	if (bus != 0)
> +		addroff |= BIT(24); /* Type 1 Access */
> +	addroff |= (bus << 16) | (devfn << 8) | where;
> +	return priv->cfg0_base + addroff;
> +}
> +
> +void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devfn,
> +			       int where)
> +{
> +	unsigned char busnum = bus->number;
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
> +	struct loongson_pci *priv =  pci_host_bridge_priv(bridge);
> +
> +	/*
> +	 * Do not read more than one device on the bus other than
> +	 * the host bridge.
> +	 */
> +	if (bus->primary != 0 && PCI_SLOT(devfn) > 0 &&
> +		priv->flags & FLAG_DEV_FIX)

IIUC, FLAG_DEV_FIX is a workaround for a hardware issue, so this would
be easier to read as:

  if (priv->flags & FLAG_DEV_FIX && bus->primary != 0 ...

> +		return NULL;
> +
> +	/* CFG0 can only access standard space */
> +	if (where < PCI_CFG_SPACE_SIZE && priv->cfg0_base)
> +		return cfg0_map(priv, busnum, devfn, where);
> +
> +	/* CFG1 can access extended space */
> +	if (where < PCI_CFG_SPACE_EXP_SIZE && priv->cfg1_base)
> +		return cfg1_map(priv, busnum, devfn, where);
> +
> +	return NULL;
> +}
> +
> +static int loongson_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +{
> +	int irq;
> +	u8 val;
> +
> +	irq = of_irq_parse_and_map_pci(dev, slot, pin);
> +	if (irq > 0)
> +		return irq;
> +
> +	/* Care i8259 legacy systems */
> +	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &val);
> +	/* i8259 only have 15 IRQs */
> +	if (val > 15)
> +		return 0;
> +
> +	return val;
> +}
> +
> +/* H/w only accept 32-bit PCI operations */

I'm sure you're aware that the spec actually requires 8- and 16-bit
operations, at least for config writes.  You probably see a few of the
warnings from pci_generic_config_write32()?  Just FYI for any future
hardware designs.

> +static struct pci_ops loongson_pci_ops = {
> +	.map_bus = pci_loongson_map_bus,
> +	.read	= pci_generic_config_read32,
> +	.write	= pci_generic_config_write32,
> +};
> +
> +static const struct of_device_id loongson_pci_of_match[] = {
> +	{ .compatible = "loongson,ls2k-pci",
> +		.data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
> +	{ .compatible = "loongson,ls7a-pci",
> +		.data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
> +	{ .compatible = "loongson,rs780e-pci",
> +		.data = (void *)(FLAG_CFG0), },
> +	{}
> +};
> +
> +static int loongson_pci_probe(struct platform_device *pdev)
> +{
> +	struct loongson_pci *priv;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct pci_host_bridge *bridge;
> +	struct resource *regs;
> +	int err;
> +
> +	if (!node)
> +		return -ENODEV;
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*priv));
> +	if (!bridge)
> +		return -ENODEV;
> +
> +	priv = pci_host_bridge_priv(bridge);
> +	priv->pdev = pdev;
> +	priv->flags = (unsigned long)of_device_get_match_data(dev);
> +
> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!regs) {
> +		dev_err(dev, "missing mem resources for cfg0\n");
> +		return -EINVAL;
> +	}
> +
> +	priv->cfg0_base = devm_pci_remap_cfg_resource(dev, regs);
> +	if (IS_ERR(priv->cfg0_base))
> +		return PTR_ERR(priv->cfg0_base);
> +
> +	/* CFG1 is optional */
> +	if (priv->flags & FLAG_CFG1) {
> +		regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		if (!regs)
> +			dev_info(dev, "missing mem resource for cfg1\n");
> +		else {
> +			priv->cfg1_base = devm_pci_remap_cfg_resource(dev, regs);
> +			if (IS_ERR(priv->cfg1_base))
> +				priv->cfg1_base = NULL;
> +		}
> +	}
> +
> +	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
> +						&bridge->dma_ranges, NULL);
> +	if (err) {
> +		dev_err(dev, "Failed to get bridge resources\n");

Some of your messages are capitalized (maybe just this one) and others
are lower-case.

> +		return err;
> +	}
> +
> +	bridge->dev.parent = dev;
> +	bridge->sysdata = priv;
> +	bridge->ops = &loongson_pci_ops;
> +	bridge->map_irq = loongson_map_irq;
> +
> +	err = pci_host_probe(bridge);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver loongson_pci_driver = {
> +	.driver = {
> +		.name = "loongson-pci",
> +		.of_match_table = loongson_pci_of_match,
> +	},
> +	.probe = loongson_pci_probe,
> +};
> +builtin_platform_driver(loongson_pci_driver);
> -- 
> 2.26.0.rc2
> 
