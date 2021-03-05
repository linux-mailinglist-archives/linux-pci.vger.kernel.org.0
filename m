Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DB632F59B
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 22:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhCEV5z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 16:57:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhCEV5u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Mar 2021 16:57:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 477D0650A8;
        Fri,  5 Mar 2021 21:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614981470;
        bh=Aj0cFvIyz7NQcACEFdepojn3t06iDgfxmYBrnBVP67U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eHiu5fHqQyZFvUxNqh5sWVMaDYQ89eJPH43cuBFseS+MNOfkq6/uCo7z/tyqHt5ZV
         2CdqT6dydGQdvG67wTrszafQMJISXg8gSv7+mNERY3jtwQF+LlY/KkxrzXp5Ba75vO
         DaxyvpeZkVJ4Dln8IvmPI+IPKtplJz1Ck1NK3ROgPojNCLan1IqCJUz1RZ8FiDMAvo
         sC3DrQy97FksVY13wjRP3CtguFCxao33QXQOr8QQ+sX25FI0FcgN4g0fZ1QvC/HrXi
         Fk3Poc6DBehy0Kj08Bx5ypxdhHaejai06cDnfBD8Q6jTXayr5eIoDdOg7RvYwn4Jui
         X1LIY+0QJvUJw==
Date:   Fri, 5 Mar 2021 15:57:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, andrew.murray@arm.com, treding@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH V3 2/2] PCI: Add MCFG quirks for Tegra194 host controllers
Message-ID: <20210305215749.GA1117765@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110191500.9538-3-vidyas@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krzysztof for .bus_shift below]

This is [2/2] but I don't see a [1/2].  Is there something missing?

On Sat, Jan 11, 2020 at 12:45:00AM +0530, Vidya Sagar wrote:
> The PCIe controller in Tegra194 SoC is not completely ECAM-compliant.
> With the current hardware design limitations in place, ECAM can be enabled
> only for one controller (C5 controller to be precise) with bus numbers
> starting from 160 instead of 0. A different approach is taken to avoid this
> abnormal way of enabling ECAM for just one controller but to enable
> configuration space access for all the other controllers. In this approach,
> ops are added through MCFG quirk mechanism which access the configuration
> spaces by dynamically programming iATU (internal AddressTranslation Unit)
> to generate respective configuration accesses just like the way it is
> done in DesignWare core sub-system.

Is this a published erratum in the device?  The purpose of specs is so
we can run existing code on new platforms without having to add quirks
like this, so I'm looking for some acknowledgement that this is an
issue that will be fixed in future designs.

Ideally this would be a URL to published errata, and we would include
the text or a synopsis here in the commit log.

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reported-by: kbuild test robot <lkp@intel.com>

What is this "Reported-by" telling me?  Normally this would be a
person who could supply more information about a defect we're fixing
and might be able to test the fix.

> ---
> V3:
> * Removed MCFG address hardcoding in pci_mcfg.c file
> * Started using 'dbi_base' for accessing root port's own config space
> * and using 'config_base' for accessing config space of downstream hierarchy
> 
> V2:
> * Fixed build issues reported by kbuild test bot

Ah, I see this is probably where the "Reported-by" came from.  To me,
it would make sense to add the tag if the commit *only* fixes the
build problem so it's obvious what the robot reported.

But here, the build fix got squashed in before merging, so it's more
like a general review comment and I think the robot's response on the
mailing list is probably enough.

>  drivers/acpi/pci_mcfg.c                    |   7 ++
>  drivers/pci/controller/dwc/Kconfig         |   3 +-
>  drivers/pci/controller/dwc/Makefile        |   2 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c | 102 +++++++++++++++++++++
>  include/linux/pci-ecam.h                   |   1 +
>  5 files changed, 113 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 6b347d9920cc..707181408173 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -116,6 +116,13 @@ static struct mcfg_fixup mcfg_quirks[] = {
>  	THUNDER_ECAM_QUIRK(2, 12),
>  	THUNDER_ECAM_QUIRK(2, 13),
>  
> +	{ "NVIDIA", "TEGRA194", 1, 0, MCFG_BUS_ANY, &tegra194_pcie_ops},
> +	{ "NVIDIA", "TEGRA194", 1, 1, MCFG_BUS_ANY, &tegra194_pcie_ops},
> +	{ "NVIDIA", "TEGRA194", 1, 2, MCFG_BUS_ANY, &tegra194_pcie_ops},
> +	{ "NVIDIA", "TEGRA194", 1, 3, MCFG_BUS_ANY, &tegra194_pcie_ops},
> +	{ "NVIDIA", "TEGRA194", 1, 4, MCFG_BUS_ANY, &tegra194_pcie_ops},
> +	{ "NVIDIA", "TEGRA194", 1, 5, MCFG_BUS_ANY, &tegra194_pcie_ops},
> +
>  #define XGENE_V1_ECAM_MCFG(rev, seg) \
>  	{"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
>  		&xgene_v1_pcie_ecam_ops }
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 0830dfcfa43a..f5b9e75aceed 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -255,7 +255,8 @@ config PCIE_TEGRA194
>  	select PHY_TEGRA194_P2U
>  	help
>  	  Say Y here if you want support for DesignWare core based PCIe host
> -	  controller found in NVIDIA Tegra194 SoC.
> +	  controller found in NVIDIA Tegra194 SoC. ACPI platforms with Tegra194
> +	  don't need to enable this.
>  
>  config PCIE_UNIPHIER
>  	bool "Socionext UniPhier PCIe controllers"
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 8a637cfcf6e9..76a6c52b8500 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -17,7 +17,6 @@ obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
>  obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
>  obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
>  obj-$(CONFIG_PCI_MESON) += pci-meson.o
> -obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
>  obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>  
>  # The following drivers are for devices that use the generic ACPI
> @@ -33,4 +32,5 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>  ifdef CONFIG_PCI
>  obj-$(CONFIG_ARM64) += pcie-al.o
>  obj-$(CONFIG_ARM64) += pcie-hisi.o
> +obj-$(CONFIG_ARM64) += pcie-tegra194.o
>  endif
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index cbe95f0ea0ca..660f55caa8be 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -21,6 +21,8 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci.h>
> +#include <linux/pci-acpi.h>
> +#include <linux/pci-ecam.h>
>  #include <linux/phy/phy.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> @@ -285,6 +287,103 @@ struct tegra_pcie_dw {
>  	struct dentry *debugfs;
>  };
>  
> +#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
> +struct tegra194_pcie_acpi  {
> +	void __iomem *config_base;
> +	void __iomem *iatu_base;
> +	void __iomem *dbi_base;
> +};
> +
> +static int tegra194_acpi_init(struct pci_config_window *cfg)
> +{
> +	struct device *dev = cfg->parent;
> +	struct tegra194_pcie_acpi *pcie;

"pcie" doesn't seem like the best name for this since everywhere else
in this driver, "pcie" is a "struct tegra_pcie_dw *".  Maybe "mcfg"
or similar?

With some rename of tegra194_pcie_acpi along the same lines, since it
really isn't ACPI-specific.  It's just that the ACPI MCFG table
happens to be the way to discover the ECAM address space.

> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pcie->config_base = cfg->win;
> +	pcie->iatu_base = cfg->win + SZ_256K;
> +	pcie->dbi_base = cfg->win + SZ_512K;
> +	cfg->priv = pcie;
> +
> +	return 0;
> +}
> +
> +static inline void atu_reg_write(struct tegra194_pcie_acpi *pcie, int index,
> +				 u32 val, u32 reg)

"inline" is pointless, I think, since this isn't a performance path
and the compiler will probably inline it by itself.

> +{
> +	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
> +
> +	writel(val, pcie->iatu_base + offset + reg);
> +}
> +
> +static void program_outbound_atu(struct tegra194_pcie_acpi *pcie, int index,
> +				 int type, u64 cpu_addr, u64 pci_addr, u64 size)
> +{
> +	atu_reg_write(pcie, index, lower_32_bits(cpu_addr),
> +		      PCIE_ATU_LOWER_BASE);
> +	atu_reg_write(pcie, index, upper_32_bits(cpu_addr),
> +		      PCIE_ATU_UPPER_BASE);
> +	atu_reg_write(pcie, index, lower_32_bits(pci_addr),
> +		      PCIE_ATU_LOWER_TARGET);
> +	atu_reg_write(pcie, index, lower_32_bits(cpu_addr + size - 1),
> +		      PCIE_ATU_LIMIT);
> +	atu_reg_write(pcie, index, upper_32_bits(pci_addr),
> +		      PCIE_ATU_UPPER_TARGET);
> +	atu_reg_write(pcie, index, type, PCIE_ATU_CR1);
> +	atu_reg_write(pcie, index, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
> +}
> +
> +static void __iomem *tegra194_map_bus(struct pci_bus *bus,
> +				      unsigned int devfn, int where)
> +{
> +	struct pci_config_window *cfg = bus->sysdata;
> +	struct tegra194_pcie_acpi *pcie = cfg->priv;
> +	u32 busdev;
> +	int type;
> +
> +	if (bus->number < cfg->busr.start || bus->number > cfg->busr.end)
> +		return NULL;
> +
> +	if (bus->number == cfg->busr.start) {
> +		if (PCI_SLOT(devfn) == 0)
> +			return pcie->dbi_base + where;
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
> +	program_outbound_atu(pcie, PCIE_ATU_REGION_INDEX0, type,
> +			     cfg->res.start, busdev, SZ_256K);

I don't see a PCIE_ATU_REGION_INDEX0 definition.  Maybe that's what's
in the [1/2] patch?  I guess there's some way to be sure this ATU
isn't used for other purposes?

> +	return (void __iomem *)(pcie->config_base + where);

Isn't the type correct even without the cast, same as above for
"pcie->dbi_base + where"?

> +}
> +
> +struct pci_ecam_ops tegra194_pcie_ops = {
> +	.bus_shift	= 20,

I think e7708f5b10e2 ("PCI: Unify ECAM constants in native PCI Express
drivers") means you don't need this .bus_shift.

> +	.init		= tegra194_acpi_init,
> +	.pci_ops	= {
> +		.map_bus	= tegra194_map_bus,
> +		.read		= pci_generic_config_read,
> +		.write		= pci_generic_config_write,
> +	}
> +};
> +#endif /* defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS) */
> +
> +#ifdef CONFIG_PCIE_TEGRA194
> +
>  static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
>  {
>  	return container_of(pci, struct tegra_pcie_dw, pci);
> @@ -1728,3 +1827,6 @@ MODULE_DEVICE_TABLE(of, tegra_pcie_dw_of_match);
>  MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
>  MODULE_DESCRIPTION("NVIDIA PCIe host controller driver");
>  MODULE_LICENSE("GPL v2");
> +
> +#endif /* CONFIG_PCIE_TEGRA194 */
> +
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index a73164c85e78..6156140dcbb6 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -57,6 +57,7 @@ extern struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
>  extern struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 */
>  extern struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
>  extern struct pci_ecam_ops al_pcie_ops; /* Amazon Annapurna Labs PCIe */
> +extern struct pci_ecam_ops tegra194_pcie_ops; /* Tegra194 PCIe */
>  #endif
>  
>  #ifdef CONFIG_PCI_HOST_COMMON
> -- 
> 2.17.1
> 
