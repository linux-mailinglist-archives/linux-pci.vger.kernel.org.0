Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83D227D7F8
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 22:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgI2UXe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 16:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgI2UXe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 16:23:34 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2969B2076B;
        Tue, 29 Sep 2020 20:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601411013;
        bh=uWjhqa94Zy6FJXXzWhyvIhYi26jEMocMspCnZALP12s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BJhzYceNxCY5ayHwn8ZWonbWzVFby85DehHUpJqWqjptt56r//yfnctn/vK75Is/l
         0zHYtzMfK6nwWd9CQzQ77nJ5lWqGPL8wCMWOydVMlTYkXb9a/x0Z7wYFxVBtkovFLL
         UsDiK+1WvXi8iY5mD5abIU0f1Y8p5EaDeRTiMdss=
Date:   Tue, 29 Sep 2020 15:23:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Toan Le <toan@os.amperecomputing.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] PCI: Unify ECAM constants in native PCI Express
 drivers
Message-ID: <20200929202331.GA2567309@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200925211513.1701254-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 25, 2020 at 09:15:13PM +0000, Krzysztof Wilczyński wrote:
> Unify ECAM-related constants into a single set of standard constants
> defining memory address shift values for the byte-level address that can
> be used when accessing the PCI Express Configuration Space, and then
> move native PCI Express controller drivers to use newly introduced
> definitions retiring any driver-specific ones.
> 
> The ECAM ("Enhanced Configuration Access Mechanism") is defined by the
> PCI Express specification (see PCI Base Specification, Revision 5.0,
> Version 1.0, Section 7.2.2, p. 676), thus most hardware should implement
> it the same way.  Most of the native PCI Express controller drivers
> define their ECAM-related constants, many of these could be shared, or
> use open-coded values when setting the .bus_shift field of the struct
> pci_ecam_ops.
> 
> All of the newly added constants should remove ambiguity and reduce the
> number of open-coded values, and also correlate more strongly with the
> descriptions in the aforementioned specification (see Table 7-1
> "Enhanced Configuration Address Mapping", p. 677).
> 
> There is no change to functionality.

I like this a lot.  A few minor comments below.

> --- a/drivers/pci/controller/dwc/pcie-al.c
> +++ b/drivers/pci/controller/dwc/pcie-al.c
> @@ -76,7 +76,7 @@ static int al_pcie_init(struct pci_config_window *cfg)
>  }
>  
>  const struct pci_ecam_ops al_pcie_ops = {
> -	.bus_shift    = 20,
> +	.bus_shift    = PCIE_ECAM_BUS_SHIFT,
>  	.init         =  al_pcie_init,
>  	.pci_ops      = {
>  		.map_bus    = al_pcie_map_bus,
> @@ -138,8 +138,6 @@ struct al_pcie {
>  	struct al_pcie_target_bus_cfg target_bus_cfg;
>  };
>  
> -#define PCIE_ECAM_DEVFN(x)		(((x) & 0xff) << 12)
> -
>  #define to_al_pcie(x)		dev_get_drvdata((x)->dev)
>  
>  static inline u32 al_pcie_controller_readl(struct al_pcie *pcie, u32 offset)
> @@ -228,7 +226,7 @@ static void __iomem *al_pcie_conf_addr_map(struct al_pcie *pcie,
>  	void __iomem *pci_base_addr;
>  
>  	pci_base_addr = (void __iomem *)((uintptr_t)pp->va_cfg0_base +
> -					 (busnr_ecam << 20) +
> +					 PCIE_ECAM_BUS(busnr_ecam) +
>  					 PCIE_ECAM_DEVFN(devfn));

Apparently this driver lets you limit the number of buses, since it
does:

  unsigned int busnr_ecam = busnr & target_bus_cfg->ecam_mask;

I'm not entirely sure I believe that, but OK.  It's a shame because
it would be really nice to be able to use PCIE_ECAM_OFFSET() here
(with a little rework of the al_pcie_conf_addr_map() interface).

> --- a/drivers/pci/controller/pci-thunder-pem.c
> +++ b/drivers/pci/controller/pci-thunder-pem.c
> @@ -19,6 +19,9 @@
>  #define PEM_CFG_WR 0x28
>  #define PEM_CFG_RD 0x30
>  
> +/* Enhanced Configuration Access Mechanism (ECAM) */

Maybe just add a hint here that this is *non-standard* ECAM.

> +#define THUNDER_PCIE_ECAM_BUS_SHIFT	24

> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
> @@ -60,6 +60,9 @@
>  #define XGENE_PCIE_IP_VER_1		1
>  #define XGENE_PCIE_IP_VER_2		2
>  
> +/* Enhanced Configuration Access Mechanism (ECAM) */

Ditto.

> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -162,8 +162,7 @@ static int rockchip_pcie_rd_other_conf(struct rockchip_pcie *rockchip,
>  {
>  	u32 busdev;
>  
> -	busdev = PCIE_ECAM_ADDR(bus->number, PCI_SLOT(devfn),
> -				PCI_FUNC(devfn), where);
> +	busdev = PCIE_ECAM_ADDR(bus, devfn, where);

You made the minimal change, which is good, but I don't think I could
resist doing this, which would make this code read a lot better:

  u32 ecam_addr;

  ecam_addr = rockchip->reg_base + PCIE_ECAM_OFFSET(bus, devfn, where);
  ...
  *val = readl(ecam_addr);

> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/of_irq.h>
>  #include <linux/pci.h>
> +#include <linux/pci-ecam.h>
>  #include <linux/platform_device.h>
>  #include <linux/irqchip/chained_irq.h>
>  
> @@ -124,8 +125,6 @@
>  #define E_ECAM_CR_ENABLE		BIT(0)
>  #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
>  #define E_ECAM_SIZE_SHIFT		16
> -#define ECAM_BUS_LOC_SHIFT		20
> -#define ECAM_DEV_LOC_SHIFT		12
>  #define NWL_ECAM_VALUE_DEFAULT		12
>  
>  #define CFG_DMA_REG_BAR			GENMASK(2, 0)
> @@ -245,10 +244,9 @@ static void __iomem *nwl_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>  	if (!nwl_pcie_valid_device(bus, devfn))
>  		return NULL;
>  
> -	relbus = (bus->number << ECAM_BUS_LOC_SHIFT) |
> -			(devfn << ECAM_DEV_LOC_SHIFT);
> +	relbus = PCIE_ECAM_ADDR(bus, devfn, where);
>  
> -	return pcie->ecam_base + relbus + where;
> +	return pcie->ecam_base + relbus;

"relbus" seems pointless:

  return return pcie->ecam_base + PCIE_ECAM_OFFSET(bus, devfn, where);

> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -21,6 +21,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/of_irq.h>
>  #include <linux/pci.h>
> +#include <linux/pci-ecam.h>
>  #include <linux/platform_device.h>
>  
>  #include "../pci.h"
> @@ -86,10 +87,6 @@
>  /* Phy Status/Control Register definitions */
>  #define XILINX_PCIE_REG_PSCR_LNKUP	BIT(11)
>  
> -/* ECAM definitions */
> -#define ECAM_BUS_NUM_SHIFT		20
> -#define ECAM_DEV_NUM_SHIFT		12
> -
>  /* Number of MSI IRQs */
>  #define XILINX_NUM_MSI_IRQS		128
>  
> @@ -188,10 +185,9 @@ static void __iomem *xilinx_pcie_map_bus(struct pci_bus *bus,
>  	if (!xilinx_pcie_valid_device(bus, devfn))
>  		return NULL;
>  
> -	relbus = (bus->number << ECAM_BUS_NUM_SHIFT) |
> -		 (devfn << ECAM_DEV_NUM_SHIFT);
> +	relbus = PCIE_ECAM_ADDR(bus, devfn, where);
>  
> -	return port->reg_base + relbus + where;
> +	return port->reg_base + relbus;

Same here.

> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -9,6 +9,28 @@
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  
> +/*
> + * Memory address shift values for the byte-level address that
> + * can be used when accessing the PCI Express Configuration Space.
> + */
> +
> +/* Configuration Access Mechanism (CAM) */
> +#define PCIE_CAM_BUS_SHIFT	16 /* Bus Number */

Is this a generic spec thing like ECAM is?  If it is, I'll cite the
spec here.

> +/* Enhanced Configuration Access Mechanism (ECAM) */
> +#define PCIE_ECAM_BUS_SHIFT	20 /* Bus Number */
> +#define PCIE_ECAM_DEV_SHIFT	15 /* Device Number */
> +#define PCIE_ECAM_FUN_SHIFT	12 /* Function Number */
> +
> +#define PCIE_ECAM_BUS(x)	(((x) & 0xff) << PCIE_ECAM_BUS_SHIFT)
> +#define PCIE_ECAM_DEVFN(x)	(((x) & 0xff) << PCIE_ECAM_FUN_SHIFT)
> +#define PCIE_ECAM_REG(x)	((x) & 0xfff)
> +
> +#define PCIE_ECAM_ADDR(bus, devfn, where) \
> +    (PCIE_ECAM_BUS(bus->number) | \
> +     PCIE_ECAM_DEVFN(devfn) | \
> +     PCIE_ECAM_REG(where))

Can you name this PCIE_ECAM_OFFSET() instead of PCIE_ECAM_ADDR()?
The result isn't an address we can use as-is; we have to add it to a
base address, and it doesn't really make sense to add an address to an
address.

Bjorn
