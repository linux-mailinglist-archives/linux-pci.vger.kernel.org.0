Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3345E3ABA2A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 19:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhFQRCw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 13:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhFQRCv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jun 2021 13:02:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99165613AA;
        Thu, 17 Jun 2021 17:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623949243;
        bh=dL4wkinslUu1o2pVcMJ7IhAvRSS6ebej58EJ5JcHwt0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IpbFBjNF+X8vEmvhN8/fjSvz1h8gQlkvfiaMhDlYdMQKPUObTyCDndaJQQyythWbF
         +z6/HmwDGaErzikKW3tzFZQhGvN2ZZZ5WczQhxi2r+V7uvGXkRUYx5PkotCbwbMEAx
         f6yQami9+pb8zcNT52xTIcH4OkcipbbRgOx8bgfUVXDen6834GqlKKllhJjD9666CI
         BBrAmVE9b/ZXRHlopLZoc590RhPuLjkXp15eXjWh7jRcEpJdvSptbXZ0j1y9COSk/x
         rRrxl+nyCNR+KtZHqSw5JGoZYLfX8FnVaUq+b3aghz2QEhUjZqgdEDg7j3lT1mdl42
         MyLFclcR+Lopg==
Date:   Thu, 17 Jun 2021 12:00:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH V4] PCI: tegra: Fix building Tegra194 PCIe driver
Message-ID: <20210617170042.GA3091529@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210610064134.336781-1-jonathanh@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 10, 2021 at 07:41:34AM +0100, Jon Hunter wrote:
> Commit 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
> errata") caused a few build regressions for the Tegra194 PCIe driver
> which are:
> 
> 1. The Tegra194 PCIe driver can no longer be built as a module. This
>    was caused by removing the Makefile entry to build the pcie-tegra.c
>    based upon the CONFIG_PCIE_TEGRA194 option. Therefore, restore this
>    so that we can build the driver as a module.
> 2. 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
>    errata") added "#ifdef CONFIG_PCIE_TEGRA194" around the native
>    driver. But if we set CONFIG_PCIE_TEGRA194=m to build the driver as a
>    module, autoconf.h contains "#define CONFIG_PCIE_TEGRA194_MODULE 1"
>    (not "#define CONFIG_PCIE_TEGRA194 1"), so the #ifdef excludes the
>    driver. Given that the ACPI quirk code for Tegra194 is completely
>    independent of the native Tegra194 PCIe driver, move this code into
>    its own file so that it can be built independently and we can remove
>    the "#ifdef CONFIG_PCIE_TEGRA194" in the native driver. Note that
>    given the native Tegra194 PCIe driver is only used with device-tree,
>    this will not cause any conflicts.
> 3. The below build warnings to be seen with particular kernel
>    configurations. Fix these by moving these structure definitions to
>    within the necessary guards.
> 
>   drivers/pci/controller/dwc/pcie-tegra194.c:259:18: warning:
>   	‘event_cntr_data_offset’ defined but not used [-Wunused-const-variable=]
>   drivers/pci/controller/dwc/pcie-tegra194.c:250:18: warning:
>   	‘event_cntr_ctrl_offset’ defined but not used [-Wunused-const-variable=]
>   drivers/pci/controller/dwc/pcie-tegra194.c:243:27: warning:
>   	‘pcie_gen_freq’ defined but not used [-Wunused-const-variable=]
> 
> Fixes: 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM errata")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Applied with Thierry's reviewed-by and the following subject to
for-linus for v5.13, thanks!

  PCI: tegra194: Fix MCFG quirk build regressions

> ---
> Changes since V3:
> - Moved ACPI quirk code into separate source file
> 
> Changes since V2:
> - Update the commit message per Bjorn's feedback
> - Moved the structure definitions within the necessary guards as opposed
>   to wrapping the existing defintions with the appropriate guards.
> 
> Changes since V1:
> - Added fixes tag
> - Fixed 'defined but not used' compiler warnings
> 
>  drivers/pci/controller/dwc/Makefile           |   3 +-
>  .../pci/controller/dwc/pcie-tegra194-acpi.c   | 108 ++++++++++++++
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 138 +++---------------
>  3 files changed, 128 insertions(+), 121 deletions(-)
>  create mode 100644 drivers/pci/controller/dwc/pcie-tegra194-acpi.c
> 
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index eca805c1a023..9e6ce0dc2f53 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
>  obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
>  obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
>  obj-$(CONFIG_PCI_MESON) += pci-meson.o
> +obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
>  obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>  obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>  
> @@ -38,6 +39,6 @@ ifdef CONFIG_ACPI
>  ifdef CONFIG_PCI_QUIRKS
>  obj-$(CONFIG_ARM64) += pcie-al.o
>  obj-$(CONFIG_ARM64) += pcie-hisi.o
> -obj-$(CONFIG_ARM64) += pcie-tegra194.o
> +obj-$(CONFIG_ARM64) += pcie-tegra194-acpi.o
>  endif
>  endif
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194-acpi.c b/drivers/pci/controller/dwc/pcie-tegra194-acpi.c
> new file mode 100644
> index 000000000000..c2de6ed4d86f
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-tegra194-acpi.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ACPI quirks for Tegra194 PCIe host controller
> + *
> + * Copyright (C) 2021 NVIDIA Corporation.
> + *
> + * Author: Vidya Sagar <vidyas@nvidia.com>
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/pci-acpi.h>
> +#include <linux/pci-ecam.h>
> +
> +#include "pcie-designware.h"
> +
> +struct tegra194_pcie_ecam  {
> +	void __iomem *config_base;
> +	void __iomem *iatu_base;
> +	void __iomem *dbi_base;
> +};
> +
> +static int tegra194_acpi_init(struct pci_config_window *cfg)
> +{
> +	struct device *dev = cfg->parent;
> +	struct tegra194_pcie_ecam *pcie_ecam;
> +
> +	pcie_ecam = devm_kzalloc(dev, sizeof(*pcie_ecam), GFP_KERNEL);
> +	if (!pcie_ecam)
> +		return -ENOMEM;
> +
> +	pcie_ecam->config_base = cfg->win;
> +	pcie_ecam->iatu_base = cfg->win + SZ_256K;
> +	pcie_ecam->dbi_base = cfg->win + SZ_512K;
> +	cfg->priv = pcie_ecam;
> +
> +	return 0;
> +}
> +
> +static void atu_reg_write(struct tegra194_pcie_ecam *pcie_ecam, int index,
> +			  u32 val, u32 reg)
> +{
> +	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
> +
> +	writel(val, pcie_ecam->iatu_base + offset + reg);
> +}
> +
> +static void program_outbound_atu(struct tegra194_pcie_ecam *pcie_ecam,
> +				 int index, int type, u64 cpu_addr,
> +				 u64 pci_addr, u64 size)
> +{
> +	atu_reg_write(pcie_ecam, index, lower_32_bits(cpu_addr),
> +		      PCIE_ATU_LOWER_BASE);
> +	atu_reg_write(pcie_ecam, index, upper_32_bits(cpu_addr),
> +		      PCIE_ATU_UPPER_BASE);
> +	atu_reg_write(pcie_ecam, index, lower_32_bits(pci_addr),
> +		      PCIE_ATU_LOWER_TARGET);
> +	atu_reg_write(pcie_ecam, index, lower_32_bits(cpu_addr + size - 1),
> +		      PCIE_ATU_LIMIT);
> +	atu_reg_write(pcie_ecam, index, upper_32_bits(pci_addr),
> +		      PCIE_ATU_UPPER_TARGET);
> +	atu_reg_write(pcie_ecam, index, type, PCIE_ATU_CR1);
> +	atu_reg_write(pcie_ecam, index, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
> +}
> +
> +static void __iomem *tegra194_map_bus(struct pci_bus *bus,
> +				      unsigned int devfn, int where)
> +{
> +	struct pci_config_window *cfg = bus->sysdata;
> +	struct tegra194_pcie_ecam *pcie_ecam = cfg->priv;
> +	u32 busdev;
> +	int type;
> +
> +	if (bus->number < cfg->busr.start || bus->number > cfg->busr.end)
> +		return NULL;
> +
> +	if (bus->number == cfg->busr.start) {
> +		if (PCI_SLOT(devfn) == 0)
> +			return pcie_ecam->dbi_base + where;
> +		else
> +			return NULL;
> +	}
> +
> +	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
> +		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
> +
> +	if (bus->parent->number == cfg->busr.start) {
> +		if (PCI_SLOT(devfn) == 0)
> +			type = PCIE_ATU_TYPE_CFG0;
> +		else
> +			return NULL;
> +	} else {
> +		type = PCIE_ATU_TYPE_CFG1;
> +	}
> +
> +	program_outbound_atu(pcie_ecam, 0, type, cfg->res.start, busdev,
> +			     SZ_256K);
> +
> +	return pcie_ecam->config_base + where;
> +}
> +
> +const struct pci_ecam_ops tegra194_pcie_ops = {
> +	.init		= tegra194_acpi_init,
> +	.pci_ops	= {
> +		.map_bus	= tegra194_map_bus,
> +		.read		= pci_generic_config_read,
> +		.write		= pci_generic_config_write,
> +	}
> +};
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index b19775ab134e..fa6b12cfc043 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -22,8 +22,6 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci.h>
> -#include <linux/pci-acpi.h>
> -#include <linux/pci-ecam.h>
>  #include <linux/phy/phy.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> @@ -247,24 +245,6 @@ static const unsigned int pcie_gen_freq[] = {
>  	GEN4_CORE_CLK_FREQ
>  };
>  
> -static const u32 event_cntr_ctrl_offset[] = {
> -	0x1d8,
> -	0x1a8,
> -	0x1a8,
> -	0x1a8,
> -	0x1c4,
> -	0x1d8
> -};
> -
> -static const u32 event_cntr_data_offset[] = {
> -	0x1dc,
> -	0x1ac,
> -	0x1ac,
> -	0x1ac,
> -	0x1c8,
> -	0x1dc
> -};
> -
>  struct tegra_pcie_dw {
>  	struct device *dev;
>  	struct resource *appl_res;
> @@ -313,104 +293,6 @@ struct tegra_pcie_dw_of_data {
>  	enum dw_pcie_device_mode mode;
>  };
>  
> -#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
> -struct tegra194_pcie_ecam  {
> -	void __iomem *config_base;
> -	void __iomem *iatu_base;
> -	void __iomem *dbi_base;
> -};
> -
> -static int tegra194_acpi_init(struct pci_config_window *cfg)
> -{
> -	struct device *dev = cfg->parent;
> -	struct tegra194_pcie_ecam *pcie_ecam;
> -
> -	pcie_ecam = devm_kzalloc(dev, sizeof(*pcie_ecam), GFP_KERNEL);
> -	if (!pcie_ecam)
> -		return -ENOMEM;
> -
> -	pcie_ecam->config_base = cfg->win;
> -	pcie_ecam->iatu_base = cfg->win + SZ_256K;
> -	pcie_ecam->dbi_base = cfg->win + SZ_512K;
> -	cfg->priv = pcie_ecam;
> -
> -	return 0;
> -}
> -
> -static void atu_reg_write(struct tegra194_pcie_ecam *pcie_ecam, int index,
> -			  u32 val, u32 reg)
> -{
> -	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
> -
> -	writel(val, pcie_ecam->iatu_base + offset + reg);
> -}
> -
> -static void program_outbound_atu(struct tegra194_pcie_ecam *pcie_ecam,
> -				 int index, int type, u64 cpu_addr,
> -				 u64 pci_addr, u64 size)
> -{
> -	atu_reg_write(pcie_ecam, index, lower_32_bits(cpu_addr),
> -		      PCIE_ATU_LOWER_BASE);
> -	atu_reg_write(pcie_ecam, index, upper_32_bits(cpu_addr),
> -		      PCIE_ATU_UPPER_BASE);
> -	atu_reg_write(pcie_ecam, index, lower_32_bits(pci_addr),
> -		      PCIE_ATU_LOWER_TARGET);
> -	atu_reg_write(pcie_ecam, index, lower_32_bits(cpu_addr + size - 1),
> -		      PCIE_ATU_LIMIT);
> -	atu_reg_write(pcie_ecam, index, upper_32_bits(pci_addr),
> -		      PCIE_ATU_UPPER_TARGET);
> -	atu_reg_write(pcie_ecam, index, type, PCIE_ATU_CR1);
> -	atu_reg_write(pcie_ecam, index, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
> -}
> -
> -static void __iomem *tegra194_map_bus(struct pci_bus *bus,
> -				      unsigned int devfn, int where)
> -{
> -	struct pci_config_window *cfg = bus->sysdata;
> -	struct tegra194_pcie_ecam *pcie_ecam = cfg->priv;
> -	u32 busdev;
> -	int type;
> -
> -	if (bus->number < cfg->busr.start || bus->number > cfg->busr.end)
> -		return NULL;
> -
> -	if (bus->number == cfg->busr.start) {
> -		if (PCI_SLOT(devfn) == 0)
> -			return pcie_ecam->dbi_base + where;
> -		else
> -			return NULL;
> -	}
> -
> -	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
> -		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
> -
> -	if (bus->parent->number == cfg->busr.start) {
> -		if (PCI_SLOT(devfn) == 0)
> -			type = PCIE_ATU_TYPE_CFG0;
> -		else
> -			return NULL;
> -	} else {
> -		type = PCIE_ATU_TYPE_CFG1;
> -	}
> -
> -	program_outbound_atu(pcie_ecam, 0, type, cfg->res.start, busdev,
> -			     SZ_256K);
> -
> -	return pcie_ecam->config_base + where;
> -}
> -
> -const struct pci_ecam_ops tegra194_pcie_ops = {
> -	.init		= tegra194_acpi_init,
> -	.pci_ops	= {
> -		.map_bus	= tegra194_map_bus,
> -		.read		= pci_generic_config_read,
> -		.write		= pci_generic_config_write,
> -	}
> -};
> -#endif /* defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS) */
> -
> -#ifdef CONFIG_PCIE_TEGRA194
> -
>  static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
>  {
>  	return container_of(pci, struct tegra_pcie_dw, pci);
> @@ -694,6 +576,24 @@ static struct pci_ops tegra_pci_ops = {
>  };
>  
>  #if defined(CONFIG_PCIEASPM)
> +static const u32 event_cntr_ctrl_offset[] = {
> +	0x1d8,
> +	0x1a8,
> +	0x1a8,
> +	0x1a8,
> +	0x1c4,
> +	0x1d8
> +};
> +
> +static const u32 event_cntr_data_offset[] = {
> +	0x1dc,
> +	0x1ac,
> +	0x1ac,
> +	0x1ac,
> +	0x1c8,
> +	0x1dc
> +};
> +
>  static void disable_aspm_l11(struct tegra_pcie_dw *pcie)
>  {
>  	u32 val;
> @@ -2413,5 +2313,3 @@ MODULE_DEVICE_TABLE(of, tegra_pcie_dw_of_match);
>  MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
>  MODULE_DESCRIPTION("NVIDIA PCIe host controller driver");
>  MODULE_LICENSE("GPL v2");
> -
> -#endif /* CONFIG_PCIE_TEGRA194 */
> -- 
> 2.25.1
> 
