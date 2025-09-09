Return-Path: <linux-pci+bounces-35726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4C7B4A2C1
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 08:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFE716509B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 06:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B463009D5;
	Tue,  9 Sep 2025 06:59:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F42311F3BA4
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401182; cv=none; b=E9KOv/5j2HjvXZOkjC2tVzJZLmBa1S4CYOqH2d22/RjDQ4i/g1ceHsWYV14jTp2w5so45QtSdsaG3fIsW7EC+cemomqsiTXZGDB+tQdx1P0B0cQuz+EucNKzxB8TRYI4rW5OwxgRriC7xFv5P+fHV0sMGos4Tz1Q033s1fQLz+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401182; c=relaxed/simple;
	bh=a+zH20pPBcZcl7ZvxNQUYq1IBbBalFPqm4D8wO5ddMk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nk3JR3xIkrgaNpqbQXxQSkYe57pxf+bbETLJNvkFq+eVb2k263T+s52yG/7yy0OdHj6PvwvZw3udwcQlgPL4cg2NllsWns/ICTodfX6qrU0PRFcoDiJDgH9uc8LBwTJPQUwCdsZs/JFYZfNZ8itQnbfVktWaX0i9srBhHTJyUH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 5896xOcA027944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 14:59:24 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS31.andestech.com (10.0.1.89)
 with Microsoft SMTP Server id 14.3.498.0; Tue, 9 Sep 2025 14:59:23 +0800
Date: Tue, 9 Sep 2025 14:59:18 +0800
From: Randolph Lin <randolph@andestech.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <linux-pci@vger.kernel.org>, <ben717@andestech.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <jingoohan1@gmail.com>,
        <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <bhelgaas@google.com>, <randolph.sklin@gmail.com>,
        <tim609@andestech.com>
Subject: Re: [PATCH 5/6] PCI: andes: Add Andes QiLai SoC PCIe host driver
 support
Message-ID: <aL_QLOc0JiYpmT6K@swlinux02>
References: <20250820111843.811481-1-randolph@andestech.com>
 <20250820111843.811481-6-randolph@andestech.com>
 <b2etz3ayj7rkx5jhvpeejrgto5i36gxxkcodnq5zfhntocdr3a@sqshghbm7arr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2etz3ayj7rkx5jhvpeejrgto5i36gxxkcodnq5zfhntocdr3a@sqshghbm7arr>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 5896xOcA027944

Hi Manivannan,

On Mon, Sep 08, 2025 at 12:32:28PM +0530, Manivannan Sadhasivam wrote:
> [EXTERNAL MAIL]
> 
> On Wed, Aug 20, 2025 at 07:18:42PM GMT, Randolph Lin wrote:
> 
> On top of Bjorn's review...
> 
> > Add driver support for DesignWare based PCIe controller in Andes
> > QiLai SoC. The driver only supports the Root Complex mode.
> >
> 
> Add more info about the controller. Like data rate supported, lanes, DWC IP
> version, any quirks etc...
>

It's PCIe 4.0,
One Port is 4 lanes (at 0x80000000),
Two port is 2 lanes (at 0xA0000000 and 0xC0000000).

The result of dw_pcie_readl_dbi(pci, PCIE_VERSION_NUMBER) is 0x3539372a.
Should I write it as 5.97a (version from documenmt) or
597A (version macro in pcie-designware.h)?

> > Signed-off-by: Randolph Lin <randolph@andestech.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig            |  13 +
> >  drivers/pci/controller/dwc/Makefile           |   1 +
> >  drivers/pci/controller/dwc/pcie-andes-qilai.c | 227 ++++++++++++++++++
> >  3 files changed, 241 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-andes-qilai.c
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index ff6b6d9e18ec..a9c5a43f648b 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -49,6 +49,19 @@ config PCIE_AMD_MDB
> >         DesignWare IP and therefore the driver re-uses the DesignWare
> >         core functions to implement the driver.
> >
> > +config PCIE_ANDES_QILAI
> > +     bool "ANDES QiLai PCIe controller"
> 
> No need to make it always built-in. You can make it as a loadable module, but
> prevent unloading during runtime (by using builtin_platform_driver) as it
> implements MSI controller. We do not allows irqchip controllers to be unloaded
> during runtime.
> 

Ok.

> > +     depends on OF && (RISCV || COMPILE_TEST)
> > +     depends on PCI_MSI
> > +     depends on ARCH_ANDES
> > +     select PCIE_DW_HOST
> > +     default y if ARCH_ANDES
> > +     help
> > +       Say Y here if you want to enable PCIe controller support on Andes
> 
> Mention 'Root Complex' mode.
>

Ok. 

> > +       QiLai SoCs. The Andes QiLai SoCs PCIe controller is based on
> > +       DesignWare IP and therefore the driver re-uses the DesignWare
> > +       core functions to implement the driver.
> > +
> >  config PCI_MESON
> >       tristate "Amlogic Meson PCIe controller"
> >       default m if ARCH_MESON
> > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> > index 6919d27798d1..de9583cbd675 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -5,6 +5,7 @@ obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
> >  obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
> >  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
> >  obj-$(CONFIG_PCIE_AMD_MDB) += pcie-amd-mdb.o
> > +obj-$(CONFIG_PCIE_ANDES_QILAI) += pcie-andes-qilai.o
> >  obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
> >  obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
> >  obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
> > diff --git a/drivers/pci/controller/dwc/pcie-andes-qilai.c b/drivers/pci/controller/dwc/pcie-andes-qilai.c
> > new file mode 100644
> > index 000000000000..dd06eee82cac
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-andes-qilai.c
> > @@ -0,0 +1,227 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for the PCIe Controller in QiLai from Andes
> > + *
> > + * Copyright (C) 2025 Andes Technology Corporation
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/types.h>
> > +
> > +#include "pcie-designware.h"
> > +
> > +#define PCIE_INTR_CONTROL1                   0x15c
> > +#define PCIE_MSI_CTRL_INT_EN                 BIT(28)
> > +
> > +#define PCIE_LOGIC_COHERENCY_CONTROL3                0x8e8
> > +/* Write-Back, Read and Write Allocate */
> > +#define IOCP_ARCACHE                         0xf
> > +/* Write-Back, Read and Write Allocate */
> > +#define IOCP_AWCACHE                         0xf
> > +#define PCIE_CFG_MSTR_ARCACHE_MODE           GENMASK(6, 3)
> > +#define PCIE_CFG_MSTR_AWCACHE_MODE           GENMASK(14, 11)
> > +#define PCIE_CFG_MSTR_ARCACHE_VALUE          GENMASK(22, 19)
> > +#define PCIE_CFG_MSTR_AWCACHE_VALUE          GENMASK(30, 27)
> > +
> > +#define PCIE_GEN_CONTROL2                    0x54
> > +#define PCIE_CFG_LTSSM_EN                    BIT(0)
> > +
> > +#define PCIE_REGS_PCIE_SII_PM_STATE          0xc0
> > +#define SMLH_LINK_UP                         BIT(6)
> > +#define RDLH_LINK_UP                         BIT(7)
> > +#define PCIE_REGS_PCIE_SII_LINK_UP           (SMLH_LINK_UP | RDLH_LINK_UP)
> > +
> > +struct qilai_pcie {
> > +     struct dw_pcie dw;
> > +     struct platform_device *pdev;
> > +     void __iomem *apb_base;
> > +};
> > +
> > +#define to_qilai_pcie(_dw) container_of(_dw, struct qilai_pcie, dw)
> > +
> > +static u64 qilai_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
> > +{
> > +     struct dw_pcie_rp *pp = &pci->pp;
> > +
> > +     return cpu_addr - pp->cfg0_base;
> > +}
> > +
> > +static u32 qilai_pcie_outbound_atu_check(struct dw_pcie *pci,
> > +                                      const struct dw_pcie_ob_atu_cfg *atu,
> > +                                      u64 *limit_addr)
> > +{
> > +     u64 parent_bus_addr = atu->parent_bus_addr;
> > +
> > +     *limit_addr = parent_bus_addr + atu->size - 1;
> > +
> > +     /*
> > +      * Addresses below 4 GB are not 1:1 mapped; therefore, range checks
> > +      * only need to ensure addresses below 4 GB match pci->region_limit.
> > +      */
> > +     if (lower_32_bits(*limit_addr & ~pci->region_limit) !=
> > +         lower_32_bits(parent_bus_addr & ~pci->region_limit) ||
> > +         !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
> > +         !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size)
> > +             return -EINVAL;
> > +     else
> > +             return 0;
> > +}
> > +
> > +static bool qilai_pcie_link_up(struct dw_pcie *pci)
> > +{
> > +     struct qilai_pcie *qlpci = to_qilai_pcie(pci);
> > +     u32 val;
> > +
> > +     /* Read smlh & rdlh link up by checking debug port */
> > +     dw_pcie_read(qlpci->apb_base + PCIE_REGS_PCIE_SII_PM_STATE, 0x4, &val);
> > +
> > +     return (val & PCIE_REGS_PCIE_SII_LINK_UP) == PCIE_REGS_PCIE_SII_LINK_UP;
> > +}
> > +
> > +static int qilai_pcie_start_link(struct dw_pcie *pci)
> > +{
> > +     struct qilai_pcie *qlpci = to_qilai_pcie(pci);
> > +     u32 val;
> > +
> > +     /* Do phy link up */
> 
> Drop the comment.
> 

Ok.

> > +     dw_pcie_read(qlpci->apb_base + PCIE_GEN_CONTROL2, 0x4, &val);
> > +     val |= PCIE_CFG_LTSSM_EN;
> > +     dw_pcie_write(qlpci->apb_base + PCIE_GEN_CONTROL2, 0x4, val);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct dw_pcie_ops qilai_pcie_ops = {
> > +     .cpu_addr_fixup = qilai_pcie_cpu_addr_fixup,
> > +     .outbound_atu_check = qilai_pcie_outbound_atu_check,
> > +     .link_up = qilai_pcie_link_up,
> > +     .start_link = qilai_pcie_start_link,
> > +};
> > +
> > +static struct qilai_pcie *qilai_pcie_create_data(struct platform_device *pdev)
> > +{
> > +     struct qilai_pcie *qlpci;
> > +
> > +     qlpci = devm_kzalloc(&pdev->dev, sizeof(*qlpci), GFP_KERNEL);
> > +     if (!qlpci)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     qlpci->pdev = pdev;
> > +     platform_set_drvdata(pdev, qlpci);
> > +
> > +     return qlpci;
> > +}
> > +
> > +/*
> > + * Setup the Qilai PCIe IOCP (IO Coherence Port) Read/Write Behaviors to the
> > + * Write-Back, Read and Write Allocate mode.
> > + */
> 
> What caches does the IOCP target? Is it the shared system cache? Does it allow
> the PCIe transactions to snoop the cache?
> 

The target is SoC last-level cache (L2 Cache), which serves as the system cache.
The IOCP hardware helps maintain cache monitoring, ensuring that the device can
snoop data from/to the cache. The PCIe interface is connected behind the IOCP.
In this case, the PCIe does not directly snoop the cache; it achieves the same
purpose through the IOCP hardware.

> > +static void qilai_pcie_iocp_cache_setup(struct dw_pcie_rp *pp)
> > +{
> > +     struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +     u32 val;
> > +
> > +     dw_pcie_dbi_ro_wr_en(pci);
> > +
> > +     dw_pcie_read(pci->dbi_base + PCIE_LOGIC_COHERENCY_CONTROL3,
> > +                  sizeof(val), &val);
> > +     val |= FIELD_PREP(PCIE_CFG_MSTR_ARCACHE_MODE, IOCP_ARCACHE);
> > +     val |= FIELD_PREP(PCIE_CFG_MSTR_AWCACHE_MODE, IOCP_AWCACHE);
> > +     val |= FIELD_PREP(PCIE_CFG_MSTR_ARCACHE_VALUE, IOCP_ARCACHE);
> > +     val |= FIELD_PREP(PCIE_CFG_MSTR_AWCACHE_VALUE, IOCP_AWCACHE);
> > +     dw_pcie_write(pci->dbi_base + PCIE_LOGIC_COHERENCY_CONTROL3,
> > +                   sizeof(val), val);
> > +
> > +     dw_pcie_dbi_ro_wr_dis(pci);
> > +}
> > +
> > +static void qilai_pcie_enable_msi(struct qilai_pcie *qlpci)
> > +{
> > +     u32 val;
> > +
> > +     dw_pcie_read(qlpci->apb_base + PCIE_INTR_CONTROL1,
> > +                  sizeof(val), &val);
> > +     val |= PCIE_MSI_CTRL_INT_EN;
> > +     dw_pcie_write(qlpci->apb_base + PCIE_INTR_CONTROL1,
> > +                   sizeof(val), val);
> > +}
> > +
> > +static int qilai_pcie_host_init(struct dw_pcie_rp *pp)
> > +{
> > +     struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +     struct qilai_pcie *qlpci = to_qilai_pcie(pci);
> > +
> > +     qilai_pcie_enable_msi(qlpci);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct dw_pcie_host_ops qilai_pcie_host_ops = {
> > +     .init = qilai_pcie_host_init,
> > +};
> > +
> > +static int qilai_pcie_add_port(struct qilai_pcie *qlpci)
> > +{
> > +     struct device *dev = &qlpci->pdev->dev;
> > +     struct platform_device *pdev = qlpci->pdev;
> > +     int ret;
> > +
> > +     qlpci->dw.dev = dev;
> > +     qlpci->dw.ops = &qilai_pcie_ops;
> > +     qlpci->dw.pp.num_vectors = MAX_MSI_IRQS;
> 
> Does your platform really supports 256 MSIs? You have defined only a single
> 'msi' SPI interrupt in binding. So that means, your platform can only support 32
> MSIs.
> 
> So if that's the case, you can drop this assignment since DWC uses 32 MSIs by
> default.
>

It should use the default value, I will remove this assignment.

> > +     qlpci->dw.pp.ops = &qilai_pcie_host_ops;
> > +
> > +     dw_pcie_cap_set(&qlpci->dw, REQ_RES);
> > +
> > +     qlpci->apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
> > +     if (IS_ERR(qlpci->apb_base))
> > +             return PTR_ERR(qlpci->apb_base);
> > +
> > +     ret = dw_pcie_host_init(&qlpci->dw.pp);
> > +     if (ret) {
> > +             dev_err_probe(dev, ret, "Failed to initialize PCIe host\n");
> > +             return ret;
> > +     }
> > +
> > +     qilai_pcie_iocp_cache_setup(&qlpci->dw.pp);
> 
> Are you sure that you need to set it up after enumerating devices?
>

Yes, it must be set up.
If the IOCP cache attribute is not configured, the EP device will be treated as
a non-coherent device. For better performance and compatibility, it is therefore
treated as a coherent device. Of course, it also provides flexibility for users
to configure the attribute themselves. Here, we set it up with the commonly used
settings.

> > +
> > +     return 0;
> > +}
> > +
> > +static int qilai_pcie_probe(struct platform_device *pdev)
> > +{
> > +     struct qilai_pcie *qlpci;
> > +
> > +     qlpci = qilai_pcie_create_data(pdev);
> > +     if (IS_ERR(qlpci))
> > +             return PTR_ERR(qlpci);
> > +
> > +     platform_set_drvdata(pdev, qlpci);
> > +
> > +     return qilai_pcie_add_port(qlpci);
> > +}
> > +
> > +static const struct of_device_id qilai_pcie_of_match[] = {
> > +     { .compatible = "andestech,qilai-pcie" },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, qilai_pcie_of_match);
> > +
> > +static struct platform_driver qilai_pcie_driver = {
> > +     .probe = qilai_pcie_probe,
> > +     .driver = {
> > +             .name   = "qilai-pcie",
> > +             .of_match_table = qilai_pcie_of_match,
> > +     },
> 
> You should start using PROBE_PREFER_ASYNCHRONOUS.
> 

Can I keep using the PROBE_DEFAULT_STRATEGY?
I will leave a comment noting that the tests only passed with
PROBE_DEFAULT_STRATEGY.

When using PROBE_PREFER_ASYNCHRONOUS, numerous errors were encountered in
the EP device probe flow. 

> > +};
> > +
> > +module_platform_driver(qilai_pcie_driver);
> 
> builtin_platform_driver() since this driver is not going to be removed.
> 

ok.

> - Mani
> 
> --
> மணிவண்ணன் சதாசிவம்

Sincerely,
Randolph Lin

