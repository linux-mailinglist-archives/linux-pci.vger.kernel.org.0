Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392B837F4EE
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 11:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhEMJmG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 05:42:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:51223 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232753AbhEMJmE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 May 2021 05:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620898843;
        bh=NbbmEt6SBBWvhCE8heGwZDb813os6ASbduHML08rmhg=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=V6zi/IH19taa+kvRq8oEHkSHJyoOhjbhHWWyre++nIn5iHrWyVWjw8NIetF+CZbGT
         do10B611yeLogND7CrEgbQSNd7PsIt5q+ITW+0yFS1rAEA2Zv7sU4YVgKmtf5sIv0Q
         DRdtD7fiJl4EJcSNz9hZls9SbS3FSUo/ts4uO+3s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgvrB-1l0M1W0BpN-00hLlH; Thu, 13
 May 2021 11:40:43 +0200
To:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        andrew.murray@arm.com, treding@nvidia.com, jonathanh@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20200106082709.14370-1-vidyas@nvidia.com>
 <20200110191500.9538-1-vidyas@nvidia.com>
 <20200110191500.9538-3-vidyas@nvidia.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH V3 2/2] PCI: Add MCFG quirks for Tegra194 host controllers
Message-ID: <bba8c172-bade-d6fe-d167-3fbc2c917c93@gmx.com>
Date:   Thu, 13 May 2021 17:40:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20200110191500.9538-3-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4bEhAZQiQW9XgZE6ViOjieDsIJ2nUDvkYY4L/uOi8eMzqfPQGJF
 J6xXrnTWLIGO9spmei3txgwUQs0gBhwMwRfn3g8c9MPYH67csf9/xpj3R4XHl6uhEBcC+cH
 HAAeREt+X8S5BynsWDwBEQLiuO5sNuGfENiZaEZVaRWQDTJt2QqGlsi3Wk/stTpc5TIPDhi
 mjsj9Fra7F9JkyeEOdUWA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:64ksOx+nsPQ=:rVIj24C2TY7Xv2Fx/7xi5d
 dhI0Lq9SjbKkGIqnOEw4IrMBwevCCxUSHIHr7aTxqWrr0PsPtjA3oThnJgyEdHS5LLH+/7xJu
 RBSFXCDnYmH85fhn6cKThUjXpd1Yy1HfoFUSMFi9w15LIHgiB2L5iYNkRkxnwGEkOU1kKrDKb
 fm/fZyv6voIkCNTqctUqlWg3tvUyeq19S1uv7wpQt3uV8R0lNW7DxZAIJvAyhmAZJoUwupJj5
 o6iEn9oFn7AXP6h01ASotqi5gdrCf68IRr2xZ55RgIuafYkgvL0JchJkJ2Yk8ruBy6uJclJnJ
 hpY/+LEWeUXwc3MkBobWztJbX5WbDDi1EQ3DDUInYlIiBTVDTI/zxjQlzigW0OA4jXo3ZMA+n
 FYwRv7OubehQpf1wMrW7y+1GXpHJA1hLjfdcrPUVTLMGwFcT8J0qOvbzmTWeoMYUs9icBQnqQ
 UGOnbg38uDmduRlLke2+iX1sbEwhg5m3OvAqWMh9OO4hX8eaPKkRGmuPuNjWPK27Cr8sMm35M
 J1gMyvUDBMCYEqSCbd7dFLAKeXhN0HPq9U3nQh2DHxR7KmjH8cdNTTHMgyVmP3YlqtFB5VLcy
 UyIu86ClfUcYlAqMnIfIcfLvxU7jZUGpRgyRBDkm98WhKAOjeN3t4MwaO7RAK9FbizBgXH/EF
 Ia7NYyS7e80smKZzUt+GYRFk+DMOveXuSczzmj6QxbnDhmecpzmENf2VhYNXmIK66Qr22dUR8
 t0jlGUiX1wjCUdxpPLX0LbkHj5Lp61QNOlA3rbsrsEtM7C88sz1iKngo2uh3aHzX4QaFMaeg0
 aeLNnm/HRa+cRctB7PcP2XhUqoreXfUscly7a4LVBq0UQiCC7KuNFAW+BhQ3uq3gpFpROqlQp
 eymN7cfHmoEbvSxcpLkUvsiEwFHemuj5Yo9N4j8TEGoXdfUNaxHfBp521WHvRLL+2OMg6f1p2
 chwD338xTp4sMxtDWKsygeQ/zW+uXBWsbC8kFDTTQeXQfauu36hNO+e6qfTVfGBrZAswBkPpt
 ziRWa6o5a7sPDrEcAgV+BBoa88Ql/hDbQaYcW83UE+gdnbJ71+aJdlY5uoXUFRUb2ta+6pR2x
 vWb2av26FvJ2u8JO+TgX///fAmTdQCK7ZVxDhJjxyQrlECRZTkcr1km5dAia4s4Cqs8UoyDtO
 0YISWahCum4vfdy2oUPgDWloPJb18uh7kfoW0+NuoPr7QAfKdLvwSuH+oVUuy+6YQXAN6naqF
 A4AxZhO6J+LmWTnGW
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020/1/11 =E4=B8=8A=E5=8D=883:15, Vidya Sagar wrote:
> The PCIe controller in Tegra194 SoC is not completely ECAM-compliant.
> With the current hardware design limitations in place, ECAM can be enabl=
ed
> only for one controller (C5 controller to be precise) with bus numbers
> starting from 160 instead of 0. A different approach is taken to avoid t=
his
> abnormal way of enabling ECAM for just one controller but to enable
> configuration space access for all the other controllers. In this approa=
ch,
> ops are added through MCFG quirk mechanism which access the configuratio=
n
> spaces by dynamically programming iATU (internal AddressTranslation Unit=
)
> to generate respective configuration accesses just like the way it is
> done in DesignWare core sub-system.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reported-by: kbuild test robot <lkp@intel.com>

Hi Vidya,

Mind to update the patch so that guys can test booting tegra194 boards
using ACPI with PCIE enabled?

I tried to backport this to current kernel, there are some simple
conflicts like pci_ecam_ops now are definied with const.

But "PCIE_ATU_REGION_INDEX0" is not definited anywhere, not even in the
first patch, thus unable to compile at all.


I have already tried to boot the Xavier AGX using device tree (5.12-rc8
kernel), although I can boot it from PCIE NVME using upstream device
tree, but there seems to be something wrong, as just trying to push
kernel git to the fs on NVME can lead to random crash.

Thus if we can test booting using ACPI with PCIE, maybe we can find if
it's really the upstream device tree causing the problem.

Thanks,
Qu
> ---
> V3:
> * Removed MCFG address hardcoding in pci_mcfg.c file
> * Started using 'dbi_base' for accessing root port's own config space
> * and using 'config_base' for accessing config space of downstream hiera=
rchy
>
> V2:
> * Fixed build issues reported by kbuild test bot
>
>   drivers/acpi/pci_mcfg.c                    |   7 ++
>   drivers/pci/controller/dwc/Kconfig         |   3 +-
>   drivers/pci/controller/dwc/Makefile        |   2 +-
>   drivers/pci/controller/dwc/pcie-tegra194.c | 102 +++++++++++++++++++++
>   include/linux/pci-ecam.h                   |   1 +
>   5 files changed, 113 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 6b347d9920cc..707181408173 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -116,6 +116,13 @@ static struct mcfg_fixup mcfg_quirks[] =3D {
>   	THUNDER_ECAM_QUIRK(2, 12),
>   	THUNDER_ECAM_QUIRK(2, 13),
>
> +	{ "NVIDIA", "TEGRA194", 1, 0, MCFG_BUS_ANY, &tegra194_pcie_ops},
> +	{ "NVIDIA", "TEGRA194", 1, 1, MCFG_BUS_ANY, &tegra194_pcie_ops},
> +	{ "NVIDIA", "TEGRA194", 1, 2, MCFG_BUS_ANY, &tegra194_pcie_ops},
> +	{ "NVIDIA", "TEGRA194", 1, 3, MCFG_BUS_ANY, &tegra194_pcie_ops},
> +	{ "NVIDIA", "TEGRA194", 1, 4, MCFG_BUS_ANY, &tegra194_pcie_ops},
> +	{ "NVIDIA", "TEGRA194", 1, 5, MCFG_BUS_ANY, &tegra194_pcie_ops},
> +
>   #define XGENE_V1_ECAM_MCFG(rev, seg) \
>   	{"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
>   		&xgene_v1_pcie_ecam_ops }
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller=
/dwc/Kconfig
> index 0830dfcfa43a..f5b9e75aceed 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -255,7 +255,8 @@ config PCIE_TEGRA194
>   	select PHY_TEGRA194_P2U
>   	help
>   	  Say Y here if you want support for DesignWare core based PCIe host
> -	  controller found in NVIDIA Tegra194 SoC.
> +	  controller found in NVIDIA Tegra194 SoC. ACPI platforms with Tegra19=
4
> +	  don't need to enable this.
>
>   config PCIE_UNIPHIER
>   	bool "Socionext UniPhier PCIe controllers"
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controlle=
r/dwc/Makefile
> index 8a637cfcf6e9..76a6c52b8500 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -17,7 +17,6 @@ obj-$(CONFIG_PCIE_INTEL_GW) +=3D pcie-intel-gw.o
>   obj-$(CONFIG_PCIE_KIRIN) +=3D pcie-kirin.o
>   obj-$(CONFIG_PCIE_HISI_STB) +=3D pcie-histb.o
>   obj-$(CONFIG_PCI_MESON) +=3D pci-meson.o
> -obj-$(CONFIG_PCIE_TEGRA194) +=3D pcie-tegra194.o
>   obj-$(CONFIG_PCIE_UNIPHIER) +=3D pcie-uniphier.o
>
>   # The following drivers are for devices that use the generic ACPI
> @@ -33,4 +32,5 @@ obj-$(CONFIG_PCIE_UNIPHIER) +=3D pcie-uniphier.o
>   ifdef CONFIG_PCI
>   obj-$(CONFIG_ARM64) +=3D pcie-al.o
>   obj-$(CONFIG_ARM64) +=3D pcie-hisi.o
> +obj-$(CONFIG_ARM64) +=3D pcie-tegra194.o
>   endif
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/co=
ntroller/dwc/pcie-tegra194.c
> index cbe95f0ea0ca..660f55caa8be 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -21,6 +21,8 @@
>   #include <linux/of_irq.h>
>   #include <linux/of_pci.h>
>   #include <linux/pci.h>
> +#include <linux/pci-acpi.h>
> +#include <linux/pci-ecam.h>
>   #include <linux/phy/phy.h>
>   #include <linux/pinctrl/consumer.h>
>   #include <linux/platform_device.h>
> @@ -285,6 +287,103 @@ struct tegra_pcie_dw {
>   	struct dentry *debugfs;
>   };
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
> +	struct device *dev =3D cfg->parent;
> +	struct tegra194_pcie_acpi *pcie;
> +
> +	pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pcie->config_base =3D cfg->win;
> +	pcie->iatu_base =3D cfg->win + SZ_256K;
> +	pcie->dbi_base =3D cfg->win + SZ_512K;
> +	cfg->priv =3D pcie;
> +
> +	return 0;
> +}
> +
> +static inline void atu_reg_write(struct tegra194_pcie_acpi *pcie, int i=
ndex,
> +				 u32 val, u32 reg)
> +{
> +	u32 offset =3D PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
> +
> +	writel(val, pcie->iatu_base + offset + reg);
> +}
> +
> +static void program_outbound_atu(struct tegra194_pcie_acpi *pcie, int i=
ndex,
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
> +	struct pci_config_window *cfg =3D bus->sysdata;
> +	struct tegra194_pcie_acpi *pcie =3D cfg->priv;
> +	u32 busdev;
> +	int type;
> +
> +	if (bus->number < cfg->busr.start || bus->number > cfg->busr.end)
> +		return NULL;
> +
> +	if (bus->number =3D=3D cfg->busr.start) {
> +		if (PCI_SLOT(devfn) =3D=3D 0)
> +			return pcie->dbi_base + where;
> +		else
> +			return NULL;
> +	}
> +
> +	busdev =3D PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
> +		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
> +
> +	if (bus->parent->number =3D=3D cfg->busr.start) {
> +		if (PCI_SLOT(devfn) =3D=3D 0)
> +			type =3D PCIE_ATU_TYPE_CFG0;
> +		else
> +			return NULL;
> +	} else {
> +		type =3D PCIE_ATU_TYPE_CFG1;
> +	}
> +
> +	program_outbound_atu(pcie, PCIE_ATU_REGION_INDEX0, type,
> +			     cfg->res.start, busdev, SZ_256K);
> +	return (void __iomem *)(pcie->config_base + where);
> +}
> +
> +struct pci_ecam_ops tegra194_pcie_ops =3D {
> +	.bus_shift	=3D 20,
> +	.init		=3D tegra194_acpi_init,
> +	.pci_ops	=3D {
> +		.map_bus	=3D tegra194_map_bus,
> +		.read		=3D pci_generic_config_read,
> +		.write		=3D pci_generic_config_write,
> +	}
> +};
> +#endif /* defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS) */
> +
> +#ifdef CONFIG_PCIE_TEGRA194
> +
>   static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
>   {
>   	return container_of(pci, struct tegra_pcie_dw, pci);
> @@ -1728,3 +1827,6 @@ MODULE_DEVICE_TABLE(of, tegra_pcie_dw_of_match);
>   MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
>   MODULE_DESCRIPTION("NVIDIA PCIe host controller driver");
>   MODULE_LICENSE("GPL v2");
> +
> +#endif /* CONFIG_PCIE_TEGRA194 */
> +
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index a73164c85e78..6156140dcbb6 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -57,6 +57,7 @@ extern struct pci_ecam_ops pci_thunder_ecam_ops; /* Ca=
vium ThunderX 1.x */
>   extern struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe =
v1 */
>   extern struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe =
v2.x */
>   extern struct pci_ecam_ops al_pcie_ops; /* Amazon Annapurna Labs PCIe =
*/
> +extern struct pci_ecam_ops tegra194_pcie_ops; /* Tegra194 PCIe */
>   #endif
>
>   #ifdef CONFIG_PCI_HOST_COMMON
>
