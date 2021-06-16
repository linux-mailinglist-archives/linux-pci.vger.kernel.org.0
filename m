Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8903A8E69
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 03:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhFPBeF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 21:34:05 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:49800 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhFPBeF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 21:34:05 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 15G1Vd67014052; Wed, 16 Jun 2021 10:31:39 +0900
X-Iguazu-Qid: 34tMM6Vud0gzY6c7uf
X-Iguazu-QSIG: v=2; s=0; t=1623807099; q=34tMM6Vud0gzY6c7uf; m=Toya5T6GspcyyTL72069Q+UpHdXqc2PijYZgUEE/GU8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1513) id 15G1Vckk012784
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Jun 2021 10:31:38 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 0D4341000DD;
        Wed, 16 Jun 2021 10:31:38 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 15G1VbYY016342;
        Wed, 16 Jun 2021 10:31:37 +0900
Date:   Wed, 16 Jun 2021 10:31:36 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 2/3] PCI: Visconti: Add Toshiba Visconti PCIe host
 controller driver
X-TSB-HOP: ON
Message-ID: <20210616013136.tsxf3tpekczivztb@toshiba.co.jp>
References: <20210524063004.132043-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210524185839.GA1102116@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524185839.GA1102116@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, 

Thanks for your reivew.


On Mon, May 24, 2021 at 01:58:39PM -0500, Bjorn Helgaas wrote:
> [+cc Kishon for cpu_addr_fixup() question]
> 
> Please make the subject "PCI: visconti: Add ..." since the driver
> names are usually lower-case.  When referring to the hardware itself,
> use "Visconti", of course.


OK, I will do so from next time.

> 
> On Mon, May 24, 2021 at 03:30:03PM +0900, Nobuhiro Iwamatsu wrote:
> > Add support to PCIe RC controller on Toshiba Visconti ARM SoCs. PCIe
> > controller is based of Synopsys DesignWare PCIe core.
> > 
> > This patch does not yet use the clock framework to control the clock.
> > This will be replaced in the future.
> > 
> > v2 -> v3:
> >   - Update subject.
> >   - Wrap description in 75 columns.
> >   - Change config name to PCIE_VISCONTI_HOST.
> >   - Update Kconfig text.
> >   - Drop blank lines.
> >   - Adjusted to 80 columns.
> >   - Drop inline from functions for register access.
> >   - Changed function name from visconti_pcie_check_link_status to
> >     visconti_pcie_link_up.
> >   - Update to using dw_pcie_host_init().
> >   - Reorder these in the order of use in visconti_pcie_establish_link.
> >   - Rewrite visconti_pcie_host_init() without dw_pcie_setup_rc().
> >   - Change function name from  visconti_device_turnon() to
> >     visconti_pcie_power_on().
> >   - Unify formats such as dev_err().
> >   - Drop error label in visconti_add_pcie_port().
> > 
> > v1 -> v2:
> >   - Fix typo in commit message.
> >   - Drop "depends on OF && HAS_IOMEM" from Kconfig.
> >   - Stop using the pointer of struct dw_pcie.
> >   - Use _relaxed variant.
> >   - Drop dw_pcie_wait_for_link.
> >   - Drop dbi resource processing.
> >   - Drop MSI IRQ initialization processing.
> 
> Thanks for the changelog.  Please move it after the "---" line for
> future versions.  That way it won't appear in the commit log when this
> is merged.  The notes about v1->v2, v2->v3, etc are useful during
> review, but not after this is merged.


Simliar to the above your comment, I will do so from next time.

> 
> > Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> >  drivers/pci/controller/dwc/Kconfig         |   9 +
> >  drivers/pci/controller/dwc/Makefile        |   1 +
> >  drivers/pci/controller/dwc/pcie-visconti.c | 369 +++++++++++++++++++++
> >  3 files changed, 379 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-visconti.c
> > 
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index 423d35872ce4..7c3dcb86fcad 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -286,6 +286,15 @@ config PCIE_TEGRA194_EP
> >  	  in order to enable device-specific features PCIE_TEGRA194_EP must be
> >  	  selected. This uses the DesignWare core.
> >  
> > +config PCIE_VISCONTI_HOST
> > +	bool "Toshiba Visconti PCIe controllers"
> > +	depends on ARCH_VISCONTI || COMPILE_TEST
> > +	depends on PCI_MSI_IRQ_DOMAIN
> > +	select PCIE_DW_HOST
> > +	help
> > +	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
> > +	  This driver supports TMPV7708 SoC.
> > +

<snip>

> > diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
> > new file mode 100644
> > index 000000000000..b764334f32e6
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-visconti.c
> > @@ -0,0 +1,369 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * DWC PCIe RC driver for Toshiba Visconti ARM SoC
> > + *
> > + * Copyright (C) 2021 Toshiba Electronic Device & Storage Corporation
> > + * Copyright (C) 2021 TOSHIBA CORPORATION
> > + *
> > + * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > + */

<snip>

> > +static u64 visconti_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 pci_addr)
> > +{
> > +	return pci_addr - PCIE_BUS_OFFSET;
> 
> This is called from __dw_pcie_prog_outbound_atu() as:
> 
>   cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
> 
> so I think the parameter here should be *cpu_addr*, not pci_addr.

I see, I rename the variable to cpu_addr.

> 
> dra7xx and artpec6 also call it "pci_addr", which is at best
> confusing.
> 
> I'm also confused about exactly what .cpu_addr_fixup() does.  Is it
> applying an offset that cannot be deduced from the DT description?  If
> so, *should* this offset be described in DT?
>

This depends on Visconti5's PCIe hardware implementation.
It depends on the specification that the CPU bus connected to PCIe outputs
with 0x40000000 added as an offset. This is fixed.
I will add this description as comment.

> > +}
> > +
> > +static const struct dw_pcie_ops dw_pcie_ops = {
> > +	.cpu_addr_fixup = visconti_pcie_cpu_addr_fixup,
> > +	.link_up = visconti_pcie_link_up,
> > +	.start_link = visconti_pcie_start_link,
> > +	.stop_link = visconti_pcie_stop_link,
> > +};
> > +
> > +static int visconti_pcie_power_on(struct visconti_pcie *pcie)
> > +{
> > +	void __iomem *addr;
> > +	int err;
> > +	u32 val;
> > +

<snip>

> > +static int
> > +visconti_add_pcie_port(struct visconti_pcie *pcie, struct platform_device *pdev)
> > +{
> > +	struct dw_pcie *pci = &pcie->pci;
> > +	struct pcie_port *pp = &pci->pp;
> > +	struct device *dev = &pdev->dev;
> > +
> > +	pp->irq = platform_get_irq_byname(pdev, "intr");
> > +	if (pp->irq < 0) {
> > +		dev_err(dev, "Interrupt intr is missing");
> > +		return pp->irq;
> > +	}
> 
> Looks like most drivers use "pp->irq = platform_get_irq(pdev, 0);"
> Is there a reason for this to be different?

This driver has two interrupts, msi and usual interrupt.
MSI is handled by the dwc framework, but the rest is handled by the driver.
When When I get the IRQ using index, it may not be processed correctly
depending on how to write DT, so I use platform_get_irq_byname() to check by name.

> 
> > +	pp->ops = &visconti_pcie_host_ops;
> > +
> > +	pci->link_gen = of_pci_get_max_link_speed(pdev->dev.of_node);
> > +	if (pci->link_gen < 0 || pci->link_gen > 3) {
> > +		pci->link_gen = 3;
> > +		dev_dbg(dev, "Applied default link speed\n");
> > +	}
> > +
> > +	dev_dbg(dev, "Link speed Gen %d", pci->link_gen);
> > +
> > +	return dw_pcie_host_init(pp);
> > +}
> > +
> > +static int visconti_pcie_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct visconti_pcie *pcie;
> > +	struct pcie_port *pp;
> > +	struct dw_pcie *pci;
> > +	int ret;
> > +
> > +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
> > +	if (ret)
> > +		return ret;
> 
> Somewhat unusual in PCIe controller drivers.  Is there something
> unusual about the Visconti hardware?
> 
> Also looks a little suspicious since the sequence is:
> 
>   visconti_pcie_probe
>     dma_set_mask_and_coherent(DMA_BIT_MASK(36))
>     visconti_add_pcie_port
>       dw_pcie_host_init
>         if (pci_msi_enabled())
>           dma_set_mask(DMA_BIT_MASK(32))
> 
> so dw_pcie_host_init() will override part of what we're setting here.
> 

Indeed, this process is unnecessary. I will drop.

> > +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> > +	if (!pcie)
> > +		return -ENOMEM;
> > +
> > +	pci = &pcie->pci;
> > +	pp = &pci->pp;
> > +	pp->num_vectors = MAX_MSI_IRQS;
> 
> Is this necessary?  I can't tell that this driver even implements MSI
> support.  It looks like tegra194 is the only other driver that sets
> num_vectors itself.

This device uses MSI. And I double-checked about interrupts. This device
does not need to do this, as it has a maximum of 32 interrupt vectors.
I will delete it. Thank you for pointing out.

> 
> > +	pci->dev = dev;
> > +	pci->ops = &dw_pcie_ops;
> > +
> > +	ret = visconti_get_resources(pdev, pcie);
> > +	if (ret)
> > +		return ret;
> > +
> > +	platform_set_drvdata(pdev, pcie);
> > +
> > +	return visconti_add_pcie_port(pcie, pdev);
> > +}
> > +
> > +static const struct of_device_id visconti_pcie_match[] = {
> > +	{ .compatible = "toshiba,visconti-pcie" },
> > +	{},
> > +};
> > +
> > +static struct platform_driver visconti_pcie_driver = {
> > +	.probe = visconti_pcie_probe,
> > +	.driver = {
> > +		.name = "visconti-pcie",
> > +		.of_match_table = visconti_pcie_match,
> > +		.suppress_bind_attrs = true,
> > +	},
> > +};
> > +
> > +builtin_platform_driver(visconti_pcie_driver);
> > -- 
> > 2.31.1
> > 
>

Best regards,
  Nobuhiro
