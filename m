Return-Path: <linux-pci+bounces-41775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 319A9C73719
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 11:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7AC64E3748
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 10:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161232EBBAA;
	Thu, 20 Nov 2025 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLAEEK93"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D038F2DE711;
	Thu, 20 Nov 2025 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763634369; cv=none; b=RXKZkYsB/yR18mZJPW/Yga+B4YA3qdm0nXGcyZndJlIH72cIVsODlnzA1atbLPSjJzkOJD1BpjmfyVkdM4eldOVBnskWIArdOcj+4paStA49GD6T4b01OApku/KmtnUyxBdC8aVN/ong/YBaL0frEH23bKLRvlLc0vUgp8QWl1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763634369; c=relaxed/simple;
	bh=DI7Cdd1ov2IMhJq4Nen2ZfUBn1MrWU7t3iy4UBZqN6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQABpinLCwasbVsiXwDHY7+1o36SyoQV+Y8124aVOlURiabMh0bgYKFNNYoGeAK6lIc6HfoqCDb6kqSJiWp8ZI0iH+xiFFwW5mKmVSBkLPrsSQUuER0UU2GLgM/dywXn6XnjCEaWBfdqhxlSM6hi896kVI7nm8soRIhgrrMO/NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLAEEK93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C399C4CEF1;
	Thu, 20 Nov 2025 10:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763634367;
	bh=DI7Cdd1ov2IMhJq4Nen2ZfUBn1MrWU7t3iy4UBZqN6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GLAEEK93EJk41rFpzF9y6RUUplXLPT/7YtIBg+x6FOiBpu1RWFkQUPf0DS/4hExYt
	 ZQ0DQgzbgVuxJbY8feps9zQ16q453OhUt53GHwAhbR01/esU23Y6j7zx2nLbQ5eU7z
	 G/0/w5J5zl9oreKipIy1VVAbv3TKSm6zXUr+CSmKt6abrM++DFy9GZndopPomy5eUF
	 VaWUUWgsTfsXQjYf0+vHZUgYCEmpwJ7DWID/XilEmqzqJzvg1wouMvtuH9/Sv7N0gA
	 UKCGCKmIjJuZ0pO8egKJ0TL2SYsguLOVRux96TW4PWhfUSwKvXipTiB+BggeIT6Yl5
	 eccvltaSOyX4A==
Date: Thu, 20 Nov 2025 15:55:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, 
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, 
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	Frank.li@nxp.com, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	cassel@kernel.org
Subject: Re: [PATCH 3/4 v5] PCI: s32g: Add initial PCIe support (RC)
Message-ID: <gz67pxlwddob5my62imtkiluwezixvn55gm2dse46njsolb3ct@p3wmu2j6swnc>
References: <20251118160238.26265-1-vincent.guittot@linaro.org>
 <20251118160238.26265-4-vincent.guittot@linaro.org>
 <qvpx4ys2jqqugfbcdwidwvklcatdqiwdxfjumn7ncbh7z6ef5n@sepvjsatmpbd>
 <CAKfTPtDONX3-syavhhza6t6+6U8wowqwCN2Hnv9CHBR6W9RNNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtDONX3-syavhhza6t6+6U8wowqwCN2Hnv9CHBR6W9RNNQ@mail.gmail.com>

On Thu, Nov 20, 2025 at 10:06:53AM +0100, Vincent Guittot wrote:
> On Thu, 20 Nov 2025 at 09:22, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Tue, Nov 18, 2025 at 05:02:37PM +0100, Vincent Guittot wrote:
> > > Add initial support of the PCIe controller for S32G Soc family. Only
> > > host mode is supported.
> > >
> > > Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > > Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > > Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > > Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > > Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > > Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > > Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> > > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >  drivers/pci/controller/dwc/Kconfig            |  10 +
> > >  drivers/pci/controller/dwc/Makefile           |   1 +
> > >  .../pci/controller/dwc/pcie-nxp-s32g-regs.h   |  21 +
> > >  drivers/pci/controller/dwc/pcie-nxp-s32g.c    | 391 ++++++++++++++++++
> > >  4 files changed, 423 insertions(+)
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > >
> > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > index 349d4657393c..e276956c3fca 100644
> > > --- a/drivers/pci/controller/dwc/Kconfig
> > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > @@ -256,6 +256,16 @@ config PCIE_TEGRA194_EP
> > >         in order to enable device-specific features PCIE_TEGRA194_EP must be
> > >         selected. This uses the DesignWare core.
> > >
> > > +config PCIE_NXP_S32G
> > > +     tristate "NXP S32G PCIe controller (host mode)"
> > > +     depends on ARCH_S32 || COMPILE_TEST
> > > +     select PCIE_DW_HOST
> > > +     help
> > > +       Enable support for the PCIe controller in NXP S32G based boards to
> > > +       work in Host mode. The controller is based on DesignWare IP and
> > > +       can work either as RC or EP. In order to enable host-specific
> > > +       features PCIE_NXP_S32G must be selected.
> > > +
> > >  config PCIE_DW_PLAT
> > >       bool
> > >
> > > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> > > index 7ae28f3b0fb3..3301bbbad78c 100644
> > > --- a/drivers/pci/controller/dwc/Makefile
> > > +++ b/drivers/pci/controller/dwc/Makefile
> > > @@ -10,6 +10,7 @@ obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
> > >  obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
> > >  obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
> > >  obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
> > > +obj-$(CONFIG_PCIE_NXP_S32G) += pcie-nxp-s32g.o
> > >  obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
> > >  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
> > >  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
> > > diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h b/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
> > > new file mode 100644
> > > index 000000000000..81e35b6227d1
> > > --- /dev/null
> > > +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
> > > @@ -0,0 +1,21 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > > +/*
> > > + * Copyright 2015-2016 Freescale Semiconductor, Inc.
> > > + * Copyright 2016-2023, 2025 NXP
> > > + */
> > > +
> > > +#ifndef PCIE_S32G_REGS_H
> > > +#define PCIE_S32G_REGS_H
> > > +
> > > +/* PCIe controller Sub-System */
> > > +
> > > +/* PCIe controller 0 General Control 1 */
> > > +#define PCIE_S32G_PE0_GEN_CTRL_1             0x50
> > > +#define DEVICE_TYPE_MASK                     GENMASK(3, 0)
> > > +#define SRIS_MODE                            BIT(8)
> > > +
> > > +/* PCIe controller 0 General Control 3 */
> > > +#define PCIE_S32G_PE0_GEN_CTRL_3             0x58
> > > +#define LTSSM_EN                             BIT(0)
> > > +
> >
> > Since this header is not used by other drivers as of now, I'd prefer moving
> > these definitions inside the driver.
> 
> I would prefer to keep it separate. It makes reg easier to parse and
> more registers will be added with new coming features
> 

The convention we follow is to mostly add register definitions within the driver
itself if they are not shared.

> >
> > > +#endif  /* PCI_S32G_REGS_H */
> > > diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > > new file mode 100644
> > > index 000000000000..eaa6b5363afe
> > > --- /dev/null
> > > +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > > @@ -0,0 +1,391 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * PCIe host controller driver for NXP S32G SoCs
> > > + *
> > > + * Copyright 2019-2025 NXP
> > > + */
> > > +
> > > +#include <linux/interrupt.h>
> > > +#include <linux/io.h>
> > > +#include <linux/memblock.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/phy/phy.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/sizes.h>
> > > +#include <linux/types.h>
> > > +
> > > +#include "pcie-designware.h"
> > > +#include "pcie-nxp-s32g-regs.h"
> > > +
> > > +struct s32g_pcie_port {
> > > +     struct list_head list;
> > > +     struct phy *phy;
> > > +};
> > > +
> > > +struct s32g_pcie {
> > > +     struct dw_pcie  pci;
> > > +     void __iomem *ctrl_base;
> > > +     struct list_head ports;
> > > +};
> > > +
> > > +#define to_s32g_from_dw_pcie(x) \
> > > +     container_of(x, struct s32g_pcie, pci)
> > > +
> > > +static void s32g_pcie_writel_ctrl(struct s32g_pcie *s32g_pp, u32 reg, u32 val)
> > > +{
> > > +     writel(val, s32g_pp->ctrl_base + reg);
> > > +}
> > > +
> > > +static u32 s32g_pcie_readl_ctrl(struct s32g_pcie *s32g_pp, u32 reg)
> > > +{
> > > +     return readl(s32g_pp->ctrl_base + reg);
> > > +}
> > > +
> > > +static void s32g_pcie_enable_ltssm(struct s32g_pcie *s32g_pp)
> > > +{
> > > +     u32 reg;
> > > +
> > > +     reg = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3);
> > > +     reg |= LTSSM_EN;
> > > +     s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3, reg);
> > > +}
> > > +
> > > +static void s32g_pcie_disable_ltssm(struct s32g_pcie *s32g_pp)
> > > +{
> > > +     u32 reg;
> > > +
> > > +     reg = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3);
> > > +     reg &= ~LTSSM_EN;
> > > +     s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3, reg);
> > > +}
> > > +
> > > +static int s32g_pcie_start_link(struct dw_pcie *pci)
> > > +{
> > > +     struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
> > > +
> > > +     s32g_pcie_enable_ltssm(s32g_pp);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void s32g_pcie_stop_link(struct dw_pcie *pci)
> > > +{
> > > +     struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
> > > +
> > > +     s32g_pcie_disable_ltssm(s32g_pp);
> > > +}
> > > +
> > > +static struct dw_pcie_ops s32g_pcie_ops = {
> > > +     .start_link = s32g_pcie_start_link,
> > > +     .stop_link = s32g_pcie_stop_link,
> > > +};
> > > +
> > > +/* Configure the AMBA AXI Coherency Extensions (ACE) interface */
> > > +static void s32g_pcie_reset_mstr_ace(struct dw_pcie *pci, u64 ddr_base_addr)
> > > +{
> > > +     u32 ddr_base_low = lower_32_bits(ddr_base_addr);
> > > +     u32 ddr_base_high = upper_32_bits(ddr_base_addr);
> > > +
> > > +     dw_pcie_dbi_ro_wr_en(pci);
> > > +     dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_3_OFF, 0x0);
> > > +
> > > +     /*
> > > +      * Ncore is a cache-coherent interconnect module that enables the
> > > +      * integration of heterogeneous coherent and non-coherent agents in
> > > +      * the chip. Ncore Transactions to peripheral should be non-coherent
> > > +      * or it might drop them.
> > > +      *
> > > +      * One example where this is needed are PCIe MSIs, which use NoSnoop=0
> > > +      * and might end up routed to Ncore.
> >
> > I don't think this statement is correct. No Snoop attribute is only applicable
> > to MRd/MWr operations and not applicable to MSIs. Also, you've marked the
> 
> The Ncore makes the bridge between the PCIe and the NoC and can decide
> to drop some transactions based in this boundary
> 
> > controller as cache coherent in the binding, but this comment doesn't relate to
> > it.
> 
> More details of the issue:
> PCIe coherent traffic (e.g. MSIs) that targets peripheral space will
> be dropped by Ncore because peripherals on S32G are not coherent as
> slaves. We add a hard boundary in the PCIe controller coherency
> control registers to separate physical memory space from peripheral
> space.
> 

Ok, this clarifies. Please add it to the comment.

> >
> > > +      * Define the start of DDR as seen by Linux as the boundary between
> > > +      * "memory" and "peripherals", with peripherals being below.
> >
> > Please mention what this configuration does and why it is necessary. This is not
> > clearly mentioned in the comment.
> >
> > > +      */
> > > +     dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_1_OFF,
> > > +                        (ddr_base_low & CFG_MEMTYPE_BOUNDARY_LOW_ADDR_MASK));
> > > +     dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_2_OFF, ddr_base_high);
> > > +     dw_pcie_dbi_ro_wr_dis(pci);
> > > +}
> > > +
> > > +static int s32g_init_pcie_controller(struct dw_pcie_rp *pp)
> > > +{
> > > +     struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +     struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
> > > +     u32 val;
> > > +
> > > +     /* Set RP mode */
> > > +     val = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_1);
> > > +     val &= ~DEVICE_TYPE_MASK;
> > > +     val |= FIELD_PREP(DEVICE_TYPE_MASK, PCI_EXP_TYPE_ROOT_PORT);
> > > +
> > > +     /* Use default CRNS */
> >
> > SRNS?
> 
> it's CRNS
> 

I'm not aware of CRNS, but only SRNS. Care to expand it?

> >
> > > +     val &= ~SRIS_MODE;
> > > +
> > > +     s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_1, val);
> > > +
> > > +     /*
> > > +      * Make sure we use the coherency defaults (just in case the settings
> > > +      * have been changed from their reset values)
> > > +      */
> > > +     s32g_pcie_reset_mstr_ace(pci, memblock_start_of_DRAM());
> > > +
> > > +     dw_pcie_dbi_ro_wr_en(pci);
> > > +
> > > +     val = dw_pcie_readl_dbi(pci, PCIE_PORT_FORCE);
> > > +     val |= PORT_FORCE_DO_DESKEW_FOR_SRIS;
> > > +     dw_pcie_writel_dbi(pci, PCIE_PORT_FORCE, val);
> > > +
> > > +     val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> > > +     val |= GEN3_RELATED_OFF_EQ_PHASE_2_3;
> > > +     dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> > > +
> > > +     dw_pcie_dbi_ro_wr_dis(pci);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct dw_pcie_host_ops s32g_pcie_host_ops = {
> > > +     .init = s32g_init_pcie_controller,
> > > +};
> > > +
> > > +static int s32g_init_pcie_phy(struct s32g_pcie *s32g_pp)
> > > +{
> > > +     struct dw_pcie *pci = &s32g_pp->pci;
> > > +     struct device *dev = pci->dev;
> > > +     struct s32g_pcie_port *port, *tmp;
> > > +     int ret;
> > > +
> > > +     list_for_each_entry(port, &s32g_pp->ports, list) {
> > > +             ret = phy_init(port->phy);
> > > +             if (ret) {
> > > +                     dev_err(dev, "Failed to init serdes PHY\n");
> > > +                     goto err_phy_revert;
> > > +             }
> > > +
> > > +             ret = phy_set_mode_ext(port->phy, PHY_MODE_PCIE, 0);
> > > +             if (ret) {
> > > +                     dev_err(dev, "Failed to set mode on serdes PHY\n");
> > > +                     goto err_phy_exit;
> > > +             }
> > > +
> > > +             ret = phy_power_on(port->phy);
> > > +             if (ret) {
> > > +                     dev_err(dev, "Failed to power on serdes PHY\n");
> > > +                     goto err_phy_exit;
> > > +             }
> > > +     }
> > > +
> > > +     return 0;
> > > +
> > > +err_phy_exit:
> > > +     phy_exit(port->phy);
> > > +
> > > +err_phy_revert:
> > > +     list_for_each_entry_continue_reverse(port, &s32g_pp->ports, list) {
> > > +             phy_power_off(port->phy);
> > > +             phy_exit(port->phy);
> > > +     }
> > > +
> > > +     list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
> > > +             list_del(&port->list);
> >
> > Can't you use list_for_each_entry_safe_reverse() to combine both operations?
> 
> No, it goes over all elements of the list whereas I only want to power
> off and exit only those which have been init and powered on above.
> 

Sorry, I misread the kdoc...

> >
> > > +
> > > +     return ret;
> > > +}
> > > +

[...]

> > > +static struct platform_driver s32g_pcie_driver = {
> > > +     .driver = {
> > > +             .name   = "s32g-pcie",
> > > +             .of_match_table = s32g_pcie_of_match,
> > > +             .suppress_bind_attrs = true,
> > > +             .pm = pm_sleep_ptr(&s32g_pcie_pm_ops),
> > > +             .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> > > +     },
> > > +     .probe = s32g_pcie_probe,
> > > +};
> > > +
> > > +module_platform_driver(s32g_pcie_driver);
> >
> > builtin_platform_driver() since this controller implements MSI controller.
> 
> Can you elaborate ?
> 

If a PCI controller is implementing an irqchip, it is not supposed to be removed
during runtime due to IRQ disposal concern. So we encourage the driver to be
tristate, but use builtin_platform_driver() so that it can be loaded as a
module, but not removed dynamically.

This limitation comes from the irqchip framework.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

