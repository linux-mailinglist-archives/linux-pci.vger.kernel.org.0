Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D22425572A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Aug 2020 11:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgH1JK3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 28 Aug 2020 05:10:29 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728555AbgH1JK0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Aug 2020 05:10:26 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id BD1A9668571B3AFB272E;
        Fri, 28 Aug 2020 10:10:19 +0100 (IST)
Received: from localhost (10.52.127.106) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 28 Aug
 2020 10:10:19 +0100
Date:   Fri, 28 Aug 2020 10:08:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>, <linux-pci@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "Michal Simek" <michal.simek@xilinx.com>,
        <linux-rockchip@lists.infradead.org>,
        "Zhou Wang" <wangzhou1@hisilicon.com>,
        Robert Richter <rrichter@marvell.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] PCI: Unify ECAM constants in native PCI Express drivers
Message-ID: <20200828100843.0000474e@Huawei.com>
In-Reply-To: <20200827224938.977757-1-kw@linux.com>
References: <20200827224938.977757-1-kw@linux.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.127.106]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 27 Aug 2020 22:49:38 +0000
Krzysztof Wilczyński <kw@linux.com> wrote:

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
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Seems sensible and looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Might potentially be worth tidying up the masks as well?
Or potentially drop them given I suspect that there are no cases
in which the mask is actually doing anything...

Jonathan


> ---
>  drivers/pci/controller/dwc/pcie-al.c      | 8 ++++----
>  drivers/pci/controller/dwc/pcie-hisi.c    | 4 ++--
>  drivers/pci/controller/pci-host-generic.c | 2 +-
>  drivers/pci/controller/pci-thunder-ecam.c | 2 +-
>  drivers/pci/controller/pcie-rockchip.h    | 7 ++++---
>  drivers/pci/controller/pcie-tango.c       | 2 +-
>  drivers/pci/controller/pcie-xilinx-nwl.c  | 7 +++----
>  drivers/pci/controller/pcie-xilinx.c      | 9 +++------
>  drivers/pci/ecam.c                        | 4 ++--
>  include/linux/pci-ecam.h                  | 8 ++++++++
>  10 files changed, 29 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
> index d57d4ee15848..57165cb0ef02 100644
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
> @@ -138,7 +138,7 @@ struct al_pcie {
>  	struct al_pcie_target_bus_cfg target_bus_cfg;
>  };
>  
> -#define PCIE_ECAM_DEVFN(x)		(((x) & 0xff) << 12)
> +#define PCIE_ECAM_DEVFN(x)		(((x) & 0xff) << PCIE_ECAM_FUN_SHIFT)
>  
>  #define to_al_pcie(x)		dev_get_drvdata((x)->dev)
>  
> @@ -228,7 +228,7 @@ static void __iomem *al_pcie_conf_addr_map(struct al_pcie *pcie,
>  	void __iomem *pci_base_addr;
>  
>  	pci_base_addr = (void __iomem *)((uintptr_t)pp->va_cfg0_base +
> -					 (busnr_ecam << 20) +
> +					 (busnr_ecam << PCIE_ECAM_BUS_SHIFT) +
>  					 PCIE_ECAM_DEVFN(devfn));
>  
>  	if (busnr_reg != target_bus_cfg->reg_val) {
> @@ -300,7 +300,7 @@ static void al_pcie_config_prepare(struct al_pcie *pcie)
>  
>  	target_bus_cfg = &pcie->target_bus_cfg;
>  
> -	ecam_bus_mask = (pcie->ecam_size >> 20) - 1;
> +	ecam_bus_mask = (pcie->ecam_size >> PCIE_ECAM_BUS_SHIFT) - 1;
>  	if (ecam_bus_mask > 255) {
>  		dev_warn(pcie->dev, "ECAM window size is larger than 256MB. Cutting off at 256\n");
>  		ecam_bus_mask = 255;
> diff --git a/drivers/pci/controller/dwc/pcie-hisi.c b/drivers/pci/controller/dwc/pcie-hisi.c
> index 5ca86796d43a..b7afbf1d4bd9 100644
> --- a/drivers/pci/controller/dwc/pcie-hisi.c
> +++ b/drivers/pci/controller/dwc/pcie-hisi.c
> @@ -100,7 +100,7 @@ static int hisi_pcie_init(struct pci_config_window *cfg)
>  }
>  
>  const struct pci_ecam_ops hisi_pcie_ops = {
> -	.bus_shift    = 20,
> +	.bus_shift    = PCIE_ECAM_BUS_SHIFT,
>  	.init         =  hisi_pcie_init,
>  	.pci_ops      = {
>  		.map_bus    = hisi_pcie_map_bus,
> @@ -135,7 +135,7 @@ static int hisi_pcie_platform_init(struct pci_config_window *cfg)
>  }
>  
>  static const struct pci_ecam_ops hisi_pcie_platform_ops = {
> -	.bus_shift    = 20,
> +	.bus_shift    = PCIE_ECAM_BUS_SHIFT,
>  	.init         =  hisi_pcie_platform_init,
>  	.pci_ops      = {
>  		.map_bus    = hisi_pcie_map_bus,
> diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
> index b51977abfdf1..c1c69b11615f 100644
> --- a/drivers/pci/controller/pci-host-generic.c
> +++ b/drivers/pci/controller/pci-host-generic.c
> @@ -49,7 +49,7 @@ static void __iomem *pci_dw_ecam_map_bus(struct pci_bus *bus,
>  }
>  
>  static const struct pci_ecam_ops pci_dw_ecam_bus_ops = {
> -	.bus_shift	= 20,
> +	.bus_shift	= PCIE_ECAM_BUS_SHIFT,
>  	.pci_ops	= {
>  		.map_bus	= pci_dw_ecam_map_bus,
>  		.read		= pci_generic_config_read,
> diff --git a/drivers/pci/controller/pci-thunder-ecam.c b/drivers/pci/controller/pci-thunder-ecam.c
> index 7e8835fee5f7..22ed7e995b39 100644
> --- a/drivers/pci/controller/pci-thunder-ecam.c
> +++ b/drivers/pci/controller/pci-thunder-ecam.c
> @@ -346,7 +346,7 @@ static int thunder_ecam_config_write(struct pci_bus *bus, unsigned int devfn,
>  }
>  
>  const struct pci_ecam_ops pci_thunder_ecam_ops = {
> -	.bus_shift	= 20,
> +	.bus_shift	= PCIE_ECAM_BUS_SHIFT,
>  	.pci_ops	= {
>  		.map_bus        = pci_ecam_map_bus,
>  		.read           = thunder_ecam_config_read,
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index c7d0178fc8c2..50f425e03e8f 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -13,6 +13,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
> +#include <linux/pci-ecam.h>
>  
>  /*
>   * The upper 16 bits of PCIE_CLIENT_CONFIG are a write mask for the lower 16
> @@ -178,9 +179,9 @@
>  #define MIN_AXI_ADDR_BITS_PASSED		8
>  #define PCIE_RC_SEND_PME_OFF			0x11960
>  #define ROCKCHIP_VENDOR_ID			0x1d87
> -#define PCIE_ECAM_BUS(x)			(((x) & 0xff) << 20)
> -#define PCIE_ECAM_DEV(x)			(((x) & 0x1f) << 15)
> -#define PCIE_ECAM_FUNC(x)			(((x) & 0x7) << 12)
> +#define PCIE_ECAM_BUS(x)			(((x) & 0xff) << PCIE_ECAM_BUS_SHIFT)
> +#define PCIE_ECAM_DEV(x)			(((x) & 0x1f) << PCIE_ECAM_DEV_SHIFT)
> +#define PCIE_ECAM_FUNC(x)			(((x) & 0x7) << PCIE_ECAM_FUN_SHIFT)
>  #define PCIE_ECAM_REG(x)			(((x) & 0xfff) << 0)
>  #define PCIE_ECAM_ADDR(bus, dev, func, reg) \
>  	  (PCIE_ECAM_BUS(bus) | PCIE_ECAM_DEV(dev) | \
> diff --git a/drivers/pci/controller/pcie-tango.c b/drivers/pci/controller/pcie-tango.c
> index d093a8ce4bb1..8f0d695afbde 100644
> --- a/drivers/pci/controller/pcie-tango.c
> +++ b/drivers/pci/controller/pcie-tango.c
> @@ -208,7 +208,7 @@ static int smp8759_config_write(struct pci_bus *bus, unsigned int devfn,
>  }
>  
>  static const struct pci_ecam_ops smp8759_ecam_ops = {
> -	.bus_shift	= 20,
> +	.bus_shift	= PCIE_ECAM_BUS_SHIFT,
>  	.pci_ops	= {
>  		.map_bus	= pci_ecam_map_bus,
>  		.read		= smp8759_config_read,
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index f3cf7d61924f..8f628b66a0d7 100644
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
> @@ -245,8 +244,8 @@ static void __iomem *nwl_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>  	if (!nwl_pcie_valid_device(bus, devfn))
>  		return NULL;
>  
> -	relbus = (bus->number << ECAM_BUS_LOC_SHIFT) |
> -			(devfn << ECAM_DEV_LOC_SHIFT);
> +	relbus = (bus->number << PCIE_ECAM_BUS_SHIFT) |
> +			(devfn << PCIE_ECAM_FUN_SHIFT);
>  
>  	return pcie->ecam_base + relbus + where;
>  }
> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index 8523be61bba5..7e9fdaccd132 100644
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
> @@ -188,8 +185,8 @@ static void __iomem *xilinx_pcie_map_bus(struct pci_bus *bus,
>  	if (!xilinx_pcie_valid_device(bus, devfn))
>  		return NULL;
>  
> -	relbus = (bus->number << ECAM_BUS_NUM_SHIFT) |
> -		 (devfn << ECAM_DEV_NUM_SHIFT);
> +	relbus = (bus->number << PCIE_ECAM_BUS_SHIFT) |
> +		 (devfn << PCIE_ECAM_FUN_SHIFT);
>  
>  	return port->reg_base + relbus + where;
>  }
> diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
> index 8f065a42fc1a..ffd010290084 100644
> --- a/drivers/pci/ecam.c
> +++ b/drivers/pci/ecam.c
> @@ -149,7 +149,7 @@ EXPORT_SYMBOL_GPL(pci_ecam_map_bus);
>  
>  /* ECAM ops */
>  const struct pci_ecam_ops pci_generic_ecam_ops = {
> -	.bus_shift	= 20,
> +	.bus_shift	= PCIE_ECAM_BUS_SHIFT,
>  	.pci_ops	= {
>  		.map_bus	= pci_ecam_map_bus,
>  		.read		= pci_generic_config_read,
> @@ -161,7 +161,7 @@ EXPORT_SYMBOL_GPL(pci_generic_ecam_ops);
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
>  /* ECAM ops for 32-bit access only (non-compliant) */
>  const struct pci_ecam_ops pci_32b_ops = {
> -	.bus_shift	= 20,
> +	.bus_shift	= PCIE_ECAM_BUS_SHIFT,
>  	.pci_ops	= {
>  		.map_bus	= pci_ecam_map_bus,
>  		.read		= pci_generic_config_read32,
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index 1af5cb02ef7f..58a5d5e2e831 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -9,6 +9,14 @@
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  
> +/*
> + * Memory address shift values for the byte-level address that
> + * can be used when accessing the PCI Express Configuration Space.
> + */
> +#define PCIE_ECAM_FUN_SHIFT	12	/* Function Number */
> +#define PCIE_ECAM_DEV_SHIFT	15	/* Device Number */
> +#define PCIE_ECAM_BUS_SHIFT	20	/* Bus Number */
> +
>  /*
>   * struct to hold pci ops and bus shift of the config window
>   * for a PCI controller.


