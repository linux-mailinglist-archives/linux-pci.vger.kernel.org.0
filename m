Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0161409A0
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2020 13:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgAQMRp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 07:17:45 -0500
Received: from foss.arm.com ([217.140.110.172]:40508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbgAQMRp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jan 2020 07:17:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEB1911D4;
        Fri, 17 Jan 2020 04:17:43 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C72BD3F6C4;
        Fri, 17 Jan 2020 04:17:41 -0800 (PST)
Date:   Fri, 17 Jan 2020 12:17:37 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bjorn@helgaas.com, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>, treding@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI: Add MCFG quirks for Tegra194 host controllers
Message-ID: <20200117121736.GA7072@e121166-lin.cambridge.arm.com>
References: <20200103174935.5612-1-vidyas@nvidia.com>
 <CABhMZUUHGEEhsJ-+foSsodqtKXyX5ZNPkGgv_VzXz=Qv+NVcUA@mail.gmail.com>
 <9a767725-9671-6402-4e1c-a648f5a7860b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a767725-9671-6402-4e1c-a648f5a7860b@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 04, 2020 at 09:14:42AM +0530, Vidya Sagar wrote:
> On 1/3/2020 11:34 PM, Bjorn Helgaas wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Fri, Jan 3, 2020 at 11:50 AM Vidya Sagar <vidyas@nvidia.com> wrote:
> > > 
> > > The PCIe controller in Tegra194 SoC is not completely ECAM-compliant.
> > 
> > What is the plan for making these SoCs ECAM-compliant?  When was
> > Tegra194 designed?  Is it shipping to end customers, i.e., would I be
> > able to buy one?
> Tegra194 is designed in 2017 and started shipping from 2018 onwards.
> Nothing much can be done for Tegra194 to make it fully ECAM compliant
> at this point in time. Tegra194 based development kits are available @
> https://developer.nvidia.com/embedded/jetson-agx-xavier-developer-kit
> Currently the BSP has the kernel booting through Device Tree mechanism
> and there is a plan to support UEFI based boot as well in the future software
> releases for which we need this quirky way of handling ECAM.
> Tegra194 is going to be the only and last chip with this issue and next chip
> in line in Tegra SoC series will be fully compliant with ECAM.

ACPI on ARM64 works on a standard subset of systems, defined by the
ARM SBSA:

http://infocenter.arm.com/help/topic/com.arm.doc.den0029c/Server_Base_System_Architecture_v6_0_ARM_DEN_0029C_SBSA_6_0.pdf

These patches will have to be carried out of tree, the MCFG quirk
mechanism (merged as Bjorn said more than three years ago) was supposed
to be a temporary plaster to bootstrap server platforms with teething
issues, the aim is to remove it eventually not to add more code to it
indefinitely.

So I am afraid but this quirk (and any other coming our way) will not be
merged in an upstream kernel anymore - for any queries please put Nvidia
in touch.

Thanks,
Lorenzo

> - Vidya Sagar
> > 
> > I do not want to add these quirks indefinitely, and the first quirks
> > were added over three years ago.
> > 
> > > With the current hardware design limitations in place, ECAM can be enabled
> > > only for one controller (C5 controller to be precise) with bus numbers
> > > starting from 160 instead of 0. A different approach is taken to avoid this
> > > abnormal way of enabling ECAM  for just one controller and to also enable
> > > configuration space access for all the other controllers. In this approach,
> > > MCFG quirks are added for each controller with a 30MB PCIe aperture
> > > resource for each controller in the disguise of ECAM region. But, this
> > > region actually contains DesignWare core's internal Address Translation
> > > Unit (iATU) using which the ECAM ops access configuration space in the
> > > otherwise standard way of programming iATU registers in DesignWare core
> > > based IPs for a respective B:D:F.
> > > 
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > ---
> > >   drivers/acpi/pci_mcfg.c                    | 13 +++
> > >   drivers/pci/controller/dwc/pcie-tegra194.c | 95 ++++++++++++++++++++++
> > >   include/linux/pci-ecam.h                   |  1 +
> > >   3 files changed, 109 insertions(+)
> > > 
> > > diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> > > index 6b347d9920cc..a42918ecc19a 100644
> > > --- a/drivers/acpi/pci_mcfg.c
> > > +++ b/drivers/acpi/pci_mcfg.c
> > > @@ -116,6 +116,19 @@ static struct mcfg_fixup mcfg_quirks[] = {
> > >          THUNDER_ECAM_QUIRK(2, 12),
> > >          THUNDER_ECAM_QUIRK(2, 13),
> > > 
> > > +       { "NVIDIA", "TEGRA194", 1, 0, MCFG_BUS_ANY, &tegra194_pcie_ops,
> > > +         DEFINE_RES_MEM(0x38200000, (30 * SZ_1M))},
> > > +       { "NVIDIA", "TEGRA194", 1, 1, MCFG_BUS_ANY, &tegra194_pcie_ops,
> > > +         DEFINE_RES_MEM(0x30200000, (30 * SZ_1M))},
> > > +       { "NVIDIA", "TEGRA194", 1, 2, MCFG_BUS_ANY, &tegra194_pcie_ops,
> > > +         DEFINE_RES_MEM(0x32200000, (30 * SZ_1M))},
> > > +       { "NVIDIA", "TEGRA194", 1, 3, MCFG_BUS_ANY, &tegra194_pcie_ops,
> > > +         DEFINE_RES_MEM(0x34200000, (30 * SZ_1M))},
> > > +       { "NVIDIA", "TEGRA194", 1, 4, MCFG_BUS_ANY, &tegra194_pcie_ops,
> > > +         DEFINE_RES_MEM(0x36200000, (30 * SZ_1M))},
> > > +       { "NVIDIA", "TEGRA194", 1, 5, MCFG_BUS_ANY, &tegra194_pcie_ops,
> > > +         DEFINE_RES_MEM(0x3a200000, (30 * SZ_1M))},
> > > +
> > >   #define XGENE_V1_ECAM_MCFG(rev, seg) \
> > >          {"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
> > >                  &xgene_v1_pcie_ecam_ops }
> > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > index cbe95f0ea0ca..91496978deb7 100644
> > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > @@ -21,6 +21,8 @@
> > >   #include <linux/of_irq.h>
> > >   #include <linux/of_pci.h>
> > >   #include <linux/pci.h>
> > > +#include <linux/pci-acpi.h>
> > > +#include <linux/pci-ecam.h>
> > >   #include <linux/phy/phy.h>
> > >   #include <linux/pinctrl/consumer.h>
> > >   #include <linux/platform_device.h>
> > > @@ -895,6 +897,99 @@ static struct dw_pcie_host_ops tegra_pcie_dw_host_ops = {
> > >          .set_num_vectors = tegra_pcie_set_msi_vec_num,
> > >   };
> > > 
> > > +#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
> > > +struct tegra194_pcie_acpi  {
> > > +       void __iomem *dbi_base;
> > > +       void __iomem *iatu_base;
> > > +};
> > > +
> > > +static int tegra194_acpi_init(struct pci_config_window *cfg)
> > > +{
> > > +       struct device *dev = cfg->parent;
> > > +       struct tegra194_pcie_acpi *pcie;
> > > +
> > > +       pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> > > +       if (!pcie)
> > > +               return -ENOMEM;
> > > +
> > > +       pcie->dbi_base = cfg->win;
> > > +       pcie->iatu_base = cfg->win + SZ_256K;
> > > +       cfg->priv = pcie;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static inline void atu_reg_write(struct tegra194_pcie_acpi *pcie, int index,
> > > +                                u32 val, u32 reg)
> > > +{
> > > +       u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
> > > +
> > > +       writel(val, pcie->iatu_base + offset + reg);
> > > +}
> > > +
> > > +static void program_outbound_atu(struct tegra194_pcie_acpi *pcie, int index,
> > > +                                int type, u64 cpu_addr, u64 pci_addr, u64 size)
> > > +{
> > > +       atu_reg_write(pcie, index, lower_32_bits(cpu_addr),
> > > +                     PCIE_ATU_LOWER_BASE);
> > > +       atu_reg_write(pcie, index, upper_32_bits(cpu_addr),
> > > +                     PCIE_ATU_UPPER_BASE);
> > > +       atu_reg_write(pcie, index, lower_32_bits(pci_addr),
> > > +                     PCIE_ATU_LOWER_TARGET);
> > > +       atu_reg_write(pcie, index, lower_32_bits(cpu_addr + size - 1),
> > > +                     PCIE_ATU_LIMIT);
> > > +       atu_reg_write(pcie, index, upper_32_bits(pci_addr),
> > > +                     PCIE_ATU_UPPER_TARGET);
> > > +       atu_reg_write(pcie, index, type, PCIE_ATU_CR1);
> > > +       atu_reg_write(pcie, index, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
> > > +}
> > > +
> > > +static void __iomem *tegra194_map_bus(struct pci_bus *bus,
> > > +                                     unsigned int devfn, int where)
> > > +{
> > > +       struct pci_config_window *cfg = bus->sysdata;
> > > +       struct tegra194_pcie_acpi *pcie = cfg->priv;
> > > +       u32 busdev;
> > > +       int type;
> > > +
> > > +       if (bus->number < cfg->busr.start || bus->number > cfg->busr.end)
> > > +               return NULL;
> > > +
> > > +       if (bus->number == cfg->busr.start) {
> > > +               if (PCI_SLOT(devfn) == 0)
> > > +                       return pcie->dbi_base + where;
> > > +               else
> > > +                       return NULL;
> > > +       }
> > > +
> > > +       busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
> > > +                PCIE_ATU_FUNC(PCI_FUNC(devfn));
> > > +
> > > +       if (bus->parent->number == cfg->busr.start) {
> > > +               if (PCI_SLOT(devfn) == 0)
> > > +                       type = PCIE_ATU_TYPE_CFG0;
> > > +               else
> > > +                       return NULL;
> > > +       } else {
> > > +               type = PCIE_ATU_TYPE_CFG1;
> > > +       }
> > > +
> > > +       program_outbound_atu(pcie, PCIE_ATU_REGION_INDEX0, type,
> > > +                            cfg->res.start + SZ_128K, busdev, SZ_128K);
> > > +       return (void __iomem *)(pcie->dbi_base + SZ_128K + where);
> > > +}
> > > +
> > > +struct pci_ecam_ops tegra194_pcie_ops = {
> > > +       .bus_shift      = 20,
> > > +       .init           = tegra194_acpi_init,
> > > +       .pci_ops        = {
> > > +               .map_bus        = tegra194_map_bus,
> > > +               .read           = pci_generic_config_read,
> > > +               .write          = pci_generic_config_write,
> > > +       }
> > > +};
> > > +#endif /* defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS) */
> > > +
> > >   static void tegra_pcie_disable_phy(struct tegra_pcie_dw *pcie)
> > >   {
> > >          unsigned int phy_count = pcie->phy_count;
> > > diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> > > index a73164c85e78..6156140dcbb6 100644
> > > --- a/include/linux/pci-ecam.h
> > > +++ b/include/linux/pci-ecam.h
> > > @@ -57,6 +57,7 @@ extern struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
> > >   extern struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 */
> > >   extern struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
> > >   extern struct pci_ecam_ops al_pcie_ops; /* Amazon Annapurna Labs PCIe */
> > > +extern struct pci_ecam_ops tegra194_pcie_ops; /* Tegra194 PCIe */
> > >   #endif
> > > 
> > >   #ifdef CONFIG_PCI_HOST_COMMON
> > > --
> > > 2.17.1
> > > 
> 
