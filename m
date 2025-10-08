Return-Path: <linux-pci+bounces-37704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD619BC4572
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 12:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AEB84E4EB1
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 10:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CEB2F49F7;
	Wed,  8 Oct 2025 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brF/cZuA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529C12580F3;
	Wed,  8 Oct 2025 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919757; cv=none; b=J3SjgsR1byzORtEvUKttUudG1YCaUgf8yycGrmxI1aDIUsxyhPvZoOkBXd+bRfoc5IY3KvYfq1WbqxlMNez3Ng9NxA7DyGDBCititN3OeeEx7pTx9cRAo8NIVOWIsfWd2s6pEnLzB/H8hCuCvmuaaCFKZGW7C3KSVdSiy5uqWtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919757; c=relaxed/simple;
	bh=9RqEXUujz/PpWW4H2k7WMGpGABZxw+Nt5qUjiEVCk40=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XszEoKkegzFEjWQ1TRXRjgceporrgWkuuD/rVjR445r8xEFdJOP+aRB0agE6xCg3YA8HmsYap6r2/b10ETu8BvZUIdtrz0SEs9cyYzc1mjVNZWswcsLyrumUU482sPwoAfA8wbSBPVRL+LwOOvLyMva+EtuS4SmpNX+Gd1JD7iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brF/cZuA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759919755; x=1791455755;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9RqEXUujz/PpWW4H2k7WMGpGABZxw+Nt5qUjiEVCk40=;
  b=brF/cZuAW+E+ciL33xe65VEl2s1ihMJt4OssvcEG8D73gj1ZQEcsEt8g
   XAKLyomL3ipiPdz9uNoQIto9MCAQCqgeISaVD+BdEFjTXA+d7K8sfAd/R
   fJEOq78OZ3P+ywKrz34t7MX8P3LW9JaRCKeVFaSPhQ/BvAfWdUaRyEQJ5
   cUkeIuzdHj1KL4i9N/hTboHYAw+Rpp2nIxSXmCk0zvIJlW10BDBMREnNW
   xjRKL97SNK9qLUO+sKQEp3DZATs9E3ZSzlVgpcusUsF1fbldkQ1ziglxf
   Tcg5F/2oYuhU/LSQztJ72ra/PJa/Nq0Yg2LvAgzOi3LAe6krgyI+qSnKU
   g==;
X-CSE-ConnectionGUID: HBxFpsneTkKsjVC+RSYLJA==
X-CSE-MsgGUID: EBsDFBuGSySzsUDe8cHXQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="61315351"
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; 
   d="scan'208";a="61315351"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 03:35:54 -0700
X-CSE-ConnectionGUID: Xa+K/yk/R62z8aeBsETWtw==
X-CSE-MsgGUID: KHXsbDOrQOWMp4dzt5ZuvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,323,1754982000"; 
   d="scan'208";a="180232833"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 03:35:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 8 Oct 2025 13:35:43 +0300 (EEST)
To: Daniel Palmer <daniel@thingy.jp>
cc: linux-m68k@lists.linux-m68k.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 5/5] PCI: Add driver for Elbox Mediator 4000 Zorro->PCI
 bridge
In-Reply-To: <20251007092313.755856-6-daniel@thingy.jp>
Message-ID: <62f9c9af-9764-a75e-e311-064cd1388a86@linux.intel.com>
References: <20251007092313.755856-1-daniel@thingy.jp> <20251007092313.755856-6-daniel@thingy.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 7 Oct 2025, Daniel Palmer wrote:

> The Mediator 4000 is pretty simple:
> - There is one "board" in the zorro space that has 2 registers to
>   set the base address of the PCI memory address space in the
>   machine address space and handle interrupts, and then windows
>   to address the PCI config space and PCI IO space.
> 
> - Another board that contains the PCI memory address space inside
>   of a window of 256MB or 512MB (configured by a jumper).
> 
> Since the hardware has no official documentation I cooked this
> up using the WinUAE emulated version to work out how it mostly
> works then confirmed it still worked on my real Amiga 4000.
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> ---
>  drivers/pci/controller/Kconfig            |  11 +
>  drivers/pci/controller/Makefile           |   1 +
>  drivers/pci/controller/pci-mediator4000.c | 314 ++++++++++++++++++++++
>  3 files changed, 326 insertions(+)
>  create mode 100644 drivers/pci/controller/pci-mediator4000.c
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 41748d083b93..3fb977318123 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -215,6 +215,17 @@ config PCIE_MEDIATEK_GEN3
>  	  Say Y here if you want to enable Gen3 PCIe controller support on
>  	  MediaTek SoCs.
>  
> +config PCI_MEDIATOR4000
> +	tristate "Elbox Mediator 4000 Zorro->PCI bridge"
> +	depends on AMIGA
> +	select IRQ_DOMAIN
> +	help
> +	  Adds support for the Elbox Mediator 4000 Zorro->PCI bridge for
> +	  the Amiga 4000.
> +
> +	  Say Y here if you are one of the few people that has this hardware
> +	  and run Linux on it.
> +
>  config PCIE_MT7621
>  	tristate "MediaTek MT7621 PCIe controller"
>  	depends on SOC_MT7621 || COMPILE_TEST
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index 038ccbd9e3ba..03cd529716ec 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
>  obj-$(CONFIG_PCIE_HISI_ERR) += pcie-hisi-error.o
>  obj-$(CONFIG_PCIE_APPLE) += pcie-apple.o
>  obj-$(CONFIG_PCIE_MT7621) += pcie-mt7621.o
> +obj-$(CONFIG_PCI_MEDIATOR4000) += pci-mediator4000.o
>  
>  # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
>  obj-y				+= dwc/
> diff --git a/drivers/pci/controller/pci-mediator4000.c b/drivers/pci/controller/pci-mediator4000.c
> new file mode 100644
> index 000000000000..106cde263e2c
> --- /dev/null
> +++ b/drivers/pci/controller/pci-mediator4000.c
> @@ -0,0 +1,314 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Daniel Palmer <daniel@thingy.jp>
> + */
> +
> +#include <asm/amigaints.h>
> +#include <linux/irqdomain.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +#include <linux/zorro.h>
> +
> +/* Offsets etc */
> +#define MEDIATOR4000_CONTROL			0x0
> +#define MEDIATOR4000_CONTROL_SIZE		0x4
> +#define MEDIATOR4000_CONTROL_WINDOW		0x0
> +#define MEDIATOR4000_CONTROL_WINDOW_SHIFT	0x18

Define the field with GENMASK(). Usually SHIFT defines are unnecessary. 
Down- and upshifting can be done with FIELD_GET/PREP() if needed.

> +#define MEDIATOR4000_CONTROL_IRQ		0x4
> +#define MEDIATOR4000_CONTROL_IRQ_MASK_SHIFT	0x4

GENMASK()?

> +#define MEDIATOR4000_PCICONF			0x800000
> +#define MEDIATOR4000_PCICONF_SIZE		0x400000
> +#define MEDIATOR4000_PCICONF_DEV_STRIDE		0x800
> +#define MEDIATOR4000_PCICONF_FUNC_STRIDE	0x100
> +#define MEDIATOR4000_PCIIO			0xc00000
> +#define MEDIATOR4000_PCIIO_SIZE			0x100000

Use SZ_* from linux/sizes.h

> +/* How the Amiga sees the mediator 4000 */
> +#define MEDIATOR4000_IRQ	IRQ_AMIGA_PORTS
> +#define MEDIATOR4000_ID_CONTROL	ZORRO_ID(ELBOX_COMPUTER, 0x21, 0)
> +#define MEDIATOR4000_ID_WINDOW	ZORRO_ID(ELBOX_COMPUTER, 0x21 | 0x80, 0)
> +
> +/*
> + * There are a few versions of the PCI backplane board,
> + * at most there are 6 slots it seems.
> + */
> +#define MEDIATOR4000_MAX_SLOTS 6
> +
> +#define MEDIATOR4000_PCICONF_DEVFUNC_OFF(priv, devfn)		\
> +	(priv->config_base +					\
> +	(MEDIATOR4000_PCICONF_DEV_STRIDE * PCI_SLOT(devfn)) +	\
> +	(MEDIATOR4000_PCICONF_FUNC_STRIDE * PCI_FUNC(devfn)))
> +
> +struct pci_mediator4000_priv {
> +	struct resource pciio_res;
> +	unsigned long config_base;
> +	unsigned long setup_base;
> +	struct irq_domain *irqdomain;
> +	int irqmap[PCI_NUM_INTX];
> +};
> +
> +static int pci_mediator4000_readconfig(struct pci_bus *bus, unsigned int devfn,
> +				       int where, int size, u32 *value)
> +{
> +	struct pci_mediator4000_priv *priv = bus->sysdata;
> +	unsigned long addr = MEDIATOR4000_PCICONF_DEVFUNC_OFF(priv, devfn) + where;
> +	u32 v;
> +
> +	if (PCI_SLOT(devfn) >= MEDIATOR4000_MAX_SLOTS)
> +		return PCIBIOS_FUNC_NOT_SUPPORTED;
> +
> +	/* Apparently only reading longs works */
> +	v = z_readl(addr & ~0x3);
> +
> +	switch (size) {
> +	case 4:
> +		v = le32_to_cpu(v);
> +		break;
> +	case 2:
> +		v = le16_to_cpu(((u16 *)(&v))[(addr & 0x3) >> 1]);
> +		break;
> +	case 1:
> +		v = ((u8 *)&v)[addr & 0x3];
> +		break;
> +	default:
> +		return PCIBIOS_FUNC_NOT_SUPPORTED;
> +	}
> +
> +	*value = v;
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int pci_mediator4000_writeconfig(struct pci_bus *bus, unsigned int devfn,
> +					int where, int size, u32 value)
> +{
> +	struct pci_mediator4000_priv *priv = bus->sysdata;
> +	unsigned long addr = MEDIATOR4000_PCICONF_DEVFUNC_OFF(priv, devfn) + where;
> +	u32 v;
> +
> +	if (PCI_SLOT(devfn) >= MEDIATOR4000_MAX_SLOTS)
> +		return PCIBIOS_FUNC_NOT_SUPPORTED;
> +
> +	/* If its a long just write it */
> +	if (size == 4) {
> +		v = cpu_to_le32(value);
> +		z_writel(v, addr);
> +		return PCIBIOS_SUCCESSFUL;
> +	}
> +
> +	/* Not a long, do RMW */
> +	v = z_readl(addr & ~0x3);
> +
> +	switch (size) {
> +	case 2:
> +		((u16 *)(&v))[(addr & 0x3) >> 1] = cpu_to_le16((u16)value);
> +		break;
> +	case 1:
> +		((u8 *)(&v))[addr & 0x3] = value;
> +		break;
> +	default:
> +		return PCIBIOS_FUNC_NOT_SUPPORTED;
> +	}
> +
> +	z_writel(v, addr & ~0x3);
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static irqreturn_t pci_mediator4000_irq(int irq, void *dev_id)
> +{
> +	struct pci_mediator4000_priv *priv = dev_id;
> +	u8 v = z_readb(priv->setup_base + MEDIATOR4000_CONTROL_IRQ);
> +	unsigned long mask = v & 0xf;

What's this magic 0xf, should it use FIELD_GET() instead and name that 
field?

I personally find this way of hiding logic into the variable declarations 
harder to read than if it would appear after them separately, it costs a 
few lines but this is simple and short function so it doesn't make things 
hard to follow.

> +	int i;
> +
> +	for_each_set_bit(i, &mask, PCI_NUM_INTX)
> +		generic_handle_domain_irq(priv->irqdomain, i);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int pci_mediator4000_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +{
> +	struct pci_mediator4000_priv *priv = dev->bus->sysdata;
> +
> +	/*
> +	 * I'm not actually sure how the lines are wired on
> +	 * mediators with more than 4 slots. My 4 slot board seems to just
> +	 * have slot number == irq.
> +	 */
> +	return priv->irqmap[slot % PCI_NUM_INTX];
> +}
> +
> +static struct pci_ops pci_mediator4000_ops = {
> +	.read = pci_mediator4000_readconfig,
> +	.write = pci_mediator4000_writeconfig,
> +};
> +
> +static struct resource mediator4000_busn = {
> +	.name = "mediator4000 busn",
> +	.start = 0,
> +	.end = 0,
> +	.flags = IORESOURCE_BUS,
> +};
> +
> +static void pci_mediator4000_mask_irq(struct irq_data *d)
> +{
> +	struct pci_mediator4000_priv *priv = irq_data_get_irq_chip_data(d);
> +	u8 v = z_readb(priv->setup_base + MEDIATOR4000_CONTROL_IRQ);
> +
> +	v &= ~(BIT(irqd_to_hwirq(d)) << MEDIATOR4000_CONTROL_IRQ_MASK_SHIFT);

Use FIELD_PREP() instead of the SHIFT define.

I'd also put these z_readb() calls right before this line (and not on the 
variable declaration line) as it's part of this RMW sequence (which is 
easy to pick up when they're grouped together).

> +	z_writeb(v, priv->setup_base + MEDIATOR4000_CONTROL_IRQ);
> +}
> +
> +static void pci_mediator4000_unmask_irq(struct irq_data *d)
> +{
> +	struct pci_mediator4000_priv *priv = irq_data_get_irq_chip_data(d);
> +	u8 v = z_readb(priv->setup_base + MEDIATOR4000_CONTROL_IRQ);
> +
> +	v |= (BIT(irqd_to_hwirq(d)) << MEDIATOR4000_CONTROL_IRQ_MASK_SHIFT);

FIELD_PREP()

> +	z_writeb(v, priv->setup_base + MEDIATOR4000_CONTROL_IRQ);
> +}
> +
> +static struct irq_chip pci_mediator4000_irq_chip = {
> +	.name = "mediator4000",
> +	.irq_mask = pci_mediator4000_mask_irq,
> +	.irq_unmask = pci_mediator4000_unmask_irq,
> +};
> +
> +static int pci_mediator4000_irq_map(struct irq_domain *domain, unsigned int irq,
> +				    irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &pci_mediator4000_irq_chip, handle_level_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops pci_mediator4000_irqdomain_ops = {
> +	.map = pci_mediator4000_irq_map,
> +};
> +
> +static int mediator4000_setup(struct device *dev,
> +			      struct zorro_dev *m4k_control,
> +			      struct zorro_dev *m4k_window)
> +{
> +	unsigned long control_base = m4k_control->resource.start;
> +	struct pci_mediator4000_priv *priv;
> +	struct pci_host_bridge *bridge;
> +	struct fwnode_handle *fwnode;
> +	struct resource *res;
> +	int i, ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	ret = devm_request_irq(dev, MEDIATOR4000_IRQ, pci_mediator4000_irq,
> +			       IRQF_SHARED, "mediator4000", priv);
> +	if (ret)
> +		return -ENODEV;
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, 0);
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	res = devm_request_mem_region(dev, control_base + MEDIATOR4000_CONTROL,
> +				      MEDIATOR4000_CONTROL_SIZE, "mediator4000-registers");
> +	if (!res)
> +		return -ENOMEM;
> +
> +	priv->setup_base = res->start;
> +
> +	/* Setup the window base */
> +	z_writeb((m4k_window->resource.start >> MEDIATOR4000_CONTROL_WINDOW_SHIFT) & 0xf0,

FIELD_GET().

I'm not sure what that 0xf0 does, is it aligning for which we've 
ALIGN_DOWN()?

> +		 priv->setup_base + MEDIATOR4000_CONTROL_WINDOW);
> +
> +	res = devm_request_mem_region(dev, control_base + MEDIATOR4000_PCICONF,
> +				 MEDIATOR4000_PCICONF_SIZE, "mediator4000-pci-config");
> +	if (!res)
> +		return -ENOMEM;
> +
> +	priv->config_base = res->start;
> +
> +	res = devm_request_mem_region(dev, control_base + MEDIATOR4000_PCIIO,
> +				  MEDIATOR4000_PCIIO_SIZE, "mediator4000-pci-io");
> +	if (!res)
> +		return -ENOMEM;
> +
> +	priv->pciio_res.name = "mediator4000-pci-io",
> +	priv->pciio_res.flags  = IORESOURCE_IO,
> +	priv->pciio_res.start = res->start;
> +	priv->pciio_res.end = res->end;

DEFINE_RES()

> +	res = insert_resource_conflict(&ioport_resource, &priv->pciio_res);
> +	if (res)
> +		return -ENOMEM;
> +
> +	pci_add_resource_offset(&bridge->windows, &priv->pciio_res, priv->pciio_res.start);
> +	pci_add_resource(&bridge->windows, &m4k_window->resource);
> +	pci_add_resource(&bridge->windows, &mediator4000_busn);
> +
> +	/* fixme: PCI DMA can only happen inside the window? How to enforce that? */
> +
> +	bridge->sysdata = priv;
> +	bridge->ops = &pci_mediator4000_ops;
> +	bridge->swizzle_irq = pci_common_swizzle;
> +	bridge->map_irq = pci_mediator4000_map_irq;
> +
> +	fwnode = irq_domain_alloc_named_fwnode("mediator4000");
> +	if (!fwnode)
> +		return -ENOMEM;
> +
> +	priv->irqdomain = irq_domain_create_linear(fwnode,
> +						   PCI_NUM_INTX,
> +						   &pci_mediator4000_irqdomain_ops,
> +						   priv);
> +	if (!priv->irqdomain) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	for (i = 0; i < PCI_NUM_INTX; i++)
> +		priv->irqmap[i] = irq_create_mapping(priv->irqdomain, i);
> +
> +	ret = pci_host_probe(bridge);
> +	if (!ret)

Please reverse the logic.

> +		return 0;
> +
> +err:
> +	irq_domain_free_fwnode(fwnode);
> +	return ret;
> +}
> +
> +static int pci_mediator4000_probe(struct zorro_dev *m4k_control,
> +				  const struct zorro_device_id *ent)
> +{
> +	struct device *dev = &m4k_control->dev;
> +	struct zorro_dev *m4k_window;
> +
> +	m4k_window = zorro_find_device(MEDIATOR4000_ID_WINDOW, m4k_control);
> +	if (!m4k_window) {
> +		dev_err(&m4k_control->dev, "Could not find window board\n");
> +		return -ENODEV;
> +	}
> +
> +	return mediator4000_setup(dev, m4k_control, m4k_window);
> +}
> +
> +static const struct zorro_device_id pci_mediator4000_zorro_tbl[] = {
> +	{
> +		.id = MEDIATOR4000_ID_CONTROL,
> +	},
> +	{ 0 }
> +};
> +MODULE_DEVICE_TABLE(zorro, pci_mediator4000_zorro_tbl);
> +
> +static struct zorro_driver pci_mediator4000_driver = {
> +	.name     = "pci_mediator4000",
> +	.id_table = pci_mediator4000_zorro_tbl,
> +	.probe    = pci_mediator4000_probe,
> +};
> +
> +module_driver(pci_mediator4000_driver,
> +	      zorro_register_driver,
> +	      zorro_unregister_driver);
> 

-- 
 i.


