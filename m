Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B791FD13D
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 17:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgFQPuU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 11:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgFQPuT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jun 2020 11:50:19 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 732AD20773;
        Wed, 17 Jun 2020 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592409017;
        bh=0XX0Neg6rqJ60J3T0nNMWFJUKq6z1gWzk0W6g0jZa74=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AOU9mRwuF6CZWoURPlSqNu0yWihfib63eZ9mxHuyS1k9Kh9bqxFiZP3+ZJ69pOzWH
         AsccJRlR24GgHPg1wC/7PpovkGBbPRiyXtujMf4F97VmWZBWcoAh8z0w7cqikBVjin
         AkUpvlhZDYYHTVA0UWVVantVseIbAKVJAKlhfMVc=
Date:   Wed, 17 Jun 2020 10:50:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, tsbogend@alpha.franken.de,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        jiaxun.yang@flygoat.com, paulburton@kernel.org, info@metux.net,
        allison@lohutok.net, kstewart@linuxfoundation.org,
        tglx@linutronix.de, jonas.gorski@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 3/3] pci: add BCM6328 PCIe controller support
Message-ID: <20200617155015.GA2035534@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200617102556.3792821-4-noltari@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"git log --oneline drivers/pci/controller/" tells you that the
conventional style for the subject would be:

  PCI: bcm6328: Add BCM6328 PCIe host controller support

On Wed, Jun 17, 2020 at 12:25:56PM +0200, Álvaro Fernández Rojas wrote:
> BCM6328 PCIe host controller is found on BCM6328, BCM6362 and BCM63268 SoCs.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  drivers/pci/controller/Kconfig        |   8 +
>  drivers/pci/controller/Makefile       |   1 +
>  drivers/pci/controller/pcie-bcm6328.c | 346 ++++++++++++++++++++++++++
>  3 files changed, 355 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-bcm6328.c
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index adddf21fa381..7e238c04764e 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -3,6 +3,14 @@
>  menu "PCI controller drivers"
>  	depends on PCI
>  
> +config PCIE_BCM6328
> +	bool "BCM6328 PCIe controller"
> +	depends on BMIPS_GENERIC || COMPILE_TEST
> +	depends on OF
> +	help
> +	  Say Y here if you want support for the PCIe host controller found
> +	  on BCM6328, BCM6362 and BCM63268 SoCs.
> +
>  config PCI_MVEBU
>  	bool "Marvell EBU PCIe controller"
>  	depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index efd9733ead26..1c3e82575845 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_PCIE_BCM6328) += pcie-bcm6328.o
>  obj-$(CONFIG_PCIE_CADENCE) += cadence/
>  obj-$(CONFIG_PCI_FTPCI100) += pci-ftpci100.o
>  obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o
> diff --git a/drivers/pci/controller/pcie-bcm6328.c b/drivers/pci/controller/pcie-bcm6328.c
> new file mode 100644
> index 000000000000..5bd86b166336
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-bcm6328.c
> @@ -0,0 +1,346 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * BCM6328 PCIe Controller Driver
> + *
> + * Copyright (C) 2020 Álvaro Fernández Rojas <noltari@gmail.com>
> + * Copyright (C) 2015 Jonas Gorski <jonas.gorski@gmail.com>
> + * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#include "../pci.h"
> +
> +#define SERDES_PCIE_EN			BIT(0)
> +#define SERDES_PCIE_EXD_EN		BIT(15)
> +
> +#define PCIE_BUS_BRIDGE			0
> +#define PCIE_BUS_DEVICE			1
> +
> +#define PCIE_CONFIG2_REG		0x408
> +#define CONFIG2_BAR1_SIZE_EN		1
> +#define CONFIG2_BAR1_SIZE_MASK		0xf
> +
> +#define PCIE_IDVAL3_REG			0x43c
> +#define IDVAL3_CLASS_CODE_MASK		0xffffff
> +#define IDVAL3_SUBCLASS_SHIFT		8
> +#define IDVAL3_CLASS_SHIFT		16
> +
> +#define PCIE_DLSTATUS_REG		0x1048
> +#define DLSTATUS_PHYLINKUP		BIT(13)
> +
> +#define PCIE_BRIDGE_OPT1_REG		0x2820
> +#define OPT1_RD_BE_OPT_EN		BIT(7)
> +#define OPT1_RD_REPLY_BE_FIX_EN		BIT(9)
> +#define OPT1_PCIE_BRIDGE_HOLE_DET_EN	BIT(11)
> +#define OPT1_L1_INT_STATUS_MASK_POL	BIT(12)
> +
> +#define PCIE_BRIDGE_OPT2_REG		0x2824
> +#define OPT2_UBUS_UR_DECODE_DIS		BIT(2)
> +#define OPT2_TX_CREDIT_CHK_EN		BIT(4)
> +#define OPT2_CFG_TYPE1_BD_SEL		BIT(7)
> +#define OPT2_CFG_TYPE1_BUS_NO_SHIFT	16
> +#define OPT2_CFG_TYPE1_BUS_NO_MASK	(0xff << OPT2_CFG_TYPE1_BUS_NO_SHIFT)
> +
> +#define PCIE_BRIDGE_BAR0_BASEMASK_REG	0x2828
> +#define BASEMASK_REMAP_EN		BIT(0)
> +#define BASEMASK_SWAP_EN		BIT(1)
> +#define BASEMASK_MASK_SHIFT		4
> +#define BASEMASK_MASK_MASK		(0xfff << BASEMASK_MASK_SHIFT)
> +#define BASEMASK_BASE_SHIFT		20
> +#define BASEMASK_BASE_MASK		(0xfff << BASEMASK_BASE_SHIFT)
> +
> +#define PCIE_BRIDGE_BAR0_REBASE_ADDR_REG 0x282c
> +#define REBASE_ADDR_BASE_SHIFT		20
> +#define REBASE_ADDR_BASE_MASK		(0xfff << REBASE_ADDR_BASE_SHIFT)
> +
> +#define PCIE_BRIDGE_RC_INT_MASK_REG	0x2854
> +#define PCIE_RC_INT_A			BIT(0)
> +#define PCIE_RC_INT_B			BIT(1)
> +#define PCIE_RC_INT_C			BIT(2)
> +#define PCIE_RC_INT_D			BIT(3)
> +
> +#define PCIE_DEVICE_OFFSET		0x8000
> +
> +struct bcm6328_pcie {
> +	void __iomem *base;
> +	struct regmap *serdes;
> +	struct clk *clk;
> +	struct reset_control *reset;
> +	struct reset_control *reset_ext;
> +	struct reset_control *reset_core;
> +	struct reset_control *reset_hard;
> +};
> +
> +static struct bcm6328_pcie bcm6328_pcie;

It would be better to dynamically allocate this like all the other
drivers in driver/pci/controller/ do.

> +/*
> + * swizzle 32bits data to return only the needed part
> + */
> +static int postprocess_read(u32 data, int where, unsigned int size)
> +{
> +	u32 ret = 0;
> +
> +	switch (size) {
> +	case 1:
> +		ret = (data >> ((where & 3) << 3)) & 0xff;
> +		break;
> +	case 2:
> +		ret = (data >> ((where & 3) << 3)) & 0xffff;
> +		break;
> +	case 4:
> +		ret = data;
> +		break;
> +	}
> +
> +	return ret;

No need for "ret" here; just return the values directly.

> +}
> +
> +static int preprocess_write(u32 orig_data, u32 val, int where,
> +			    unsigned int size)
> +{
> +	u32 ret = 0;
> +
> +	switch (size) {
> +	case 1:
> +		ret = (orig_data & ~(0xff << ((where & 3) << 3))) |
> +		      (val << ((where & 3) << 3));
> +		break;
> +	case 2:
> +		ret = (orig_data & ~(0xffff << ((where & 3) << 3))) |
> +		      (val << ((where & 3) << 3));
> +		break;
> +	case 4:
> +		ret = val;
> +		break;
> +	}
> +
> +	return ret;

No need for "ret" here either.

> +}
> +
> +static int bcm6328_pcie_can_access(struct pci_bus *bus, int devfn)
> +{
> +	struct bcm6328_pcie *priv = &bcm6328_pcie;
> +
> +	switch (bus->number) {
> +	case PCIE_BUS_BRIDGE:
> +		return PCI_SLOT(devfn) == 0;
> +	case PCIE_BUS_DEVICE:
> +		if (PCI_SLOT(devfn) == 0)
> +			return __raw_readl(priv->base + PCIE_DLSTATUS_REG)
> +			       & DLSTATUS_PHYLINKUP;

Checking for link up is problematic.  The link may go down after we
check but before we do the actual config read.  We have to be able to
handle that case anyway, so you should not check whether the link is
up.

> +		/* fall through */
> +	default:
> +		return false;
> +	}

Why do you need this function at all?  Normally a config read to a
device that doesn't exist returns ~0 data, and the PCI core knows how
to interpret that.

The implication is that this controller is severely limited and can
only support:

  bus 0, device 0, functions 0-7 (presumably root ports), and
  bus 1, device 0, functions 0-7 (presumably endpoints)?

It cannot support any switches or slots?  And apparently the root bus
number is not programmable?

> +}
> +
> +static int bcm6328_pcie_read(struct pci_bus *bus, unsigned int devfn,
> +			     int where, int size, u32 *val)
> +{
> +	struct bcm6328_pcie *priv = &bcm6328_pcie;
> +	u32 data;
> +	u32 reg = where & ~3;
> +
> +	if (!bcm6328_pcie_can_access(bus, devfn))
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	if (bus->number == PCIE_BUS_DEVICE)
> +		reg += PCIE_DEVICE_OFFSET;
> +
> +	data = __raw_readl(priv->base + reg);

Why do you need __raw_readl() and __raw_writel?  This would be the
first use in drivers/pci/, so you shouldn't need them unless this
hardware is really unique in some way.

> +	*val = postprocess_read(data, where, size);
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int bcm6328_pcie_write(struct pci_bus *bus, unsigned int devfn,
> +			      int where, int size, u32 val)
> +{
> +	struct bcm6328_pcie *priv = &bcm6328_pcie;
> +	u32 data;
> +	u32 reg = where & ~3;
> +
> +	if (!bcm6328_pcie_can_access(bus, devfn))
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	if (bus->number == PCIE_BUS_DEVICE)
> +		reg += PCIE_DEVICE_OFFSET;
> +
> +	data = __raw_readl(priv->base + reg);
> +	data = preprocess_write(data, val, where, size);
> +	__raw_writel(data, priv->base + reg);

So this hardware is unable to perform 1- or 2-byte config writes on
PCI?  That's a hardware defect that can cause corruption of config
registers.

See pci_generic_config_write32() and add a similar warning here if
this hardware is broken in this way.

> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static struct pci_ops bcm6328_pcie_ops = {
> +	.read = bcm6328_pcie_read,
> +	.write = bcm6328_pcie_write,
> +};
> +
> +static struct resource bcm6328_pcie_io_resource;
> +static struct resource bcm6328_pcie_mem_resource;
> +static struct resource bcm6328_pcie_busn_resource;
> +
> +static struct pci_controller bcm6328_pcie_controller = {
> +	.pci_ops = &bcm6328_pcie_ops,
> +	.io_resource = &bcm6328_pcie_io_resource,
> +	.mem_resource = &bcm6328_pcie_mem_resource,
> +	.busn_resource = &bcm6328_pcie_busn_resource,
> +};
> +
> +static void bcm6328_pcie_reset(struct bcm6328_pcie *priv)
> +{
> +	regmap_write_bits(priv->serdes, 0,
> +			  SERDES_PCIE_EN | SERDES_PCIE_EXD_EN,
> +			  SERDES_PCIE_EN | SERDES_PCIE_EXD_EN);
> +
> +	reset_control_assert(priv->reset);
> +	reset_control_assert(priv->reset_core);
> +	reset_control_assert(priv->reset_ext);
> +	if (priv->reset_hard) {
> +		reset_control_assert(priv->reset_hard);
> +		mdelay(10);
> +		reset_control_deassert(priv->reset_hard);
> +	}
> +	mdelay(10);
> +
> +	reset_control_deassert(priv->reset_core);
> +	reset_control_deassert(priv->reset);
> +	mdelay(10);
> +
> +	reset_control_deassert(priv->reset_ext);
> +	mdelay(200);
> +}
> +
> +static void bcm6328_pcie_setup(struct bcm6328_pcie *priv)
> +{
> +	u32 val;
> +
> +	val = __raw_readl(priv->base + PCIE_BRIDGE_OPT1_REG);
> +	val |= OPT1_RD_BE_OPT_EN;
> +	val |= OPT1_RD_REPLY_BE_FIX_EN;
> +	val |= OPT1_PCIE_BRIDGE_HOLE_DET_EN;
> +	val |= OPT1_L1_INT_STATUS_MASK_POL;
> +	__raw_writel(val, priv->base + PCIE_BRIDGE_OPT1_REG);
> +
> +	val = __raw_readl(priv->base + PCIE_BRIDGE_RC_INT_MASK_REG);
> +	val |= PCIE_RC_INT_A;
> +	val |= PCIE_RC_INT_B;
> +	val |= PCIE_RC_INT_C;
> +	val |= PCIE_RC_INT_D;
> +	__raw_writel(val, priv->base + PCIE_BRIDGE_RC_INT_MASK_REG);
> +
> +	val = __raw_readl(priv->base + PCIE_BRIDGE_OPT2_REG);
> +	/* enable credit checking and error checking */
> +	val |= OPT2_TX_CREDIT_CHK_EN;
> +	val |= OPT2_UBUS_UR_DECODE_DIS;
> +	/* set device bus/func for the pcie device */
> +	val |= (PCIE_BUS_DEVICE << OPT2_CFG_TYPE1_BUS_NO_SHIFT);
> +	val |= OPT2_CFG_TYPE1_BD_SEL;
> +	__raw_writel(val, priv->base + PCIE_BRIDGE_OPT2_REG);
> +
> +	/* setup class code as bridge */
> +	val = __raw_readl(priv->base + PCIE_IDVAL3_REG);
> +	val &= ~IDVAL3_CLASS_CODE_MASK;
> +	val |= (PCI_CLASS_BRIDGE_PCI << IDVAL3_SUBCLASS_SHIFT);
> +	__raw_writel(val, priv->base + PCIE_IDVAL3_REG);
> +
> +	/* disable bar1 size */
> +	val = __raw_readl(priv->base + PCIE_CONFIG2_REG);
> +	val &= ~CONFIG2_BAR1_SIZE_MASK;
> +	__raw_writel(val, priv->base + PCIE_CONFIG2_REG);
> +
> +	/* set bar0 to little endian */
> +	val = (bcm6328_pcie_mem_resource.start >> 20)
> +	      << BASEMASK_BASE_SHIFT;
> +	val |= (bcm6328_pcie_mem_resource.end >> 20) << BASEMASK_MASK_SHIFT;
> +	val |= BASEMASK_REMAP_EN;
> +	__raw_writel(val, priv->base + PCIE_BRIDGE_BAR0_BASEMASK_REG);
> +
> +	val = (bcm6328_pcie_mem_resource.start >> 20)
> +	      << REBASE_ADDR_BASE_SHIFT;
> +	__raw_writel(val, priv->base + PCIE_BRIDGE_BAR0_REBASE_ADDR_REG);
> +}
> +
> +static int bcm6328_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct bcm6328_pcie *priv = &bcm6328_pcie;
> +	int ret;
> +
> +	of_pci_check_probe_only();

Why do you need this?

> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->serdes = syscon_regmap_lookup_by_phandle(np, "brcm,serdes");
> +	if (IS_ERR(priv->serdes))
> +		return PTR_ERR(priv->serdes);
> +
> +	priv->reset = devm_reset_control_get_exclusive(dev, "pcie");
> +	if (IS_ERR(priv->reset))
> +		return PTR_ERR(priv->reset);
> +
> +	priv->reset_ext = devm_reset_control_get_exclusive(dev, "pcie-ext");
> +	if (IS_ERR(priv->reset_ext))
> +		return PTR_ERR(priv->reset_ext);
> +
> +	priv->reset_core = devm_reset_control_get_exclusive(dev, "pcie-core");
> +	if (IS_ERR(priv->reset_core))
> +		return PTR_ERR(priv->reset_core);
> +
> +	priv->reset_hard = devm_reset_control_get_optional_exclusive(dev,
> +		"pcie-hard");
> +	if (IS_ERR(priv->reset_hard))
> +		return PTR_ERR(priv->reset_hard);
> +
> +	priv->clk = devm_clk_get(dev, "pcie");
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret) {
> +		dev_err(dev, "could not enable clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	pci_load_of_ranges(&bcm6328_pcie_controller, np);

Please use the generic pci_parse_request_of_pci_ranges() as most PCIe
host drivers do, instead of the MIPS-specific pci_load_of_ranges().

I know that's probably not a trivial change, but it would help remove
a lot of unnecessarily MIPS-specific code from this driver and its
dependencies.

> +	if (!bcm6328_pcie_mem_resource.start)
> +		return -EINVAL;
> +
> +	of_pci_parse_bus_range(np, &bcm6328_pcie_busn_resource);
> +
> +	bcm6328_pcie_reset(priv);
> +	bcm6328_pcie_setup(priv);
> +
> +	register_pci_controller(&bcm6328_pcie_controller);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id bcm6328_pcie_of_match[] = {
> +	{ .compatible = "brcm,bcm6328-pcie", },
> +	{ .compatible = "brcm,bcm6362-pcie", },
> +	{ .compatible = "brcm,bcm63268-pcie", },
> +	{ /* sentinel */ },
> +};
> +
> +static struct platform_driver bcm6328_pcie_driver = {
> +	.driver	= {
> +		.name = "bcm6328-pcie",
> +		.of_match_table = bcm6328_pcie_of_match,
> +	},
> +	.probe = bcm6328_pcie_probe,
> +};
> +builtin_platform_driver(bcm6328_pcie_driver);
> -- 
> 2.27.0
> 
