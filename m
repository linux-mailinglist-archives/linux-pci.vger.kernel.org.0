Return-Path: <linux-pci+bounces-37202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F424BA973D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 15:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF321921074
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 13:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711E13090D0;
	Mon, 29 Sep 2025 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBMuLTur"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2973090C9;
	Mon, 29 Sep 2025 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154238; cv=none; b=HOCGOU5Zw86sIb5rJ/aIRiNBVCCc11xATWypMX+YpCJmt7U00xgVJQiKwOu7mSir+5j0B+n9EZMDYhpchy8ReHpeL7j/XlggGXIF747uhHdti3l9DOcfSrqLOH5R9vuYM78K0ADdUpXj65GJO/R15Ms4NaEoruVmoDAyKk0GDmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154238; c=relaxed/simple;
	bh=V28ScHZUk31Y/PHYeuAAxTC1bxzcn5pYcwPDPIx9b3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSrF31qn+wLWrIkDsavaNYIpZOWXjqFTd3ieB6S9sCdzTHK0j3287LoLCSzXA7Vfm7GHsatIx0qIm4XbxKsKreU71W+xPdl8tzMvzx3GKouPUaEaEIUmglXT3MB4X2XqJpgyosO230j4UvolLxVXZ3tMmbOI+Jls79jEqYRff7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBMuLTur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B69C4CEF7;
	Mon, 29 Sep 2025 13:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759154238;
	bh=V28ScHZUk31Y/PHYeuAAxTC1bxzcn5pYcwPDPIx9b3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBMuLTur0TQyNhthdX2G9UsTool1TdPs+yso2/RV9nHcWRg9mIzgjIJS3kgLeEkzf
	 ya53rTqC/JFnC/ApZL1PPIo3fqIEWL0+8H2OrHH9zSXTdSKrhs+Mx2j/ILCNytx+Wd
	 FWTmVYbcnl2T504zcJNpqoyzH+rDIuitKzRjq9htcy5vhlmczikiey6x09z8XBpV3S
	 ZXPwn7kLyrKdwwP3ZO5UnGGU9nLlcTw8HNgGoHGnXSInVY1Y2334p8wwfPRDlgKfHG
	 SrRAxv4boPwczPbGuhcEqi7NQsaTnU01EARS2/WJqTm8z0PROmxdlqsP8C6Jh5jJQi
	 wcWc5yAy65RTA==
Date: Mon, 29 Sep 2025 19:27:01 +0530
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
Subject: Re: [PATCH 2/3 v2] PCI: s32g: Add initial PCIe support (RC)
Message-ID: <lmczw5agheqbcl6xcomlhf7yfbdvfx45pozmaxjmbkkqudsxlu@c7u6s5h4xm6j>
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-3-vincent.guittot@linaro.org>
 <4ee5tqdjv5ogcdtysiebtoxmrvrzhkar4bjcsqi47dxtgwac4c@rezn4waubroh>
 <CAKfTPtAEkegCV-9_x-dXSWQFOoG6kO5JbJq_LToY9YuuRusoVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtAEkegCV-9_x-dXSWQFOoG6kO5JbJq_LToY9YuuRusoVA@mail.gmail.com>

On Thu, Sep 25, 2025 at 06:52:57PM +0200, Vincent Guittot wrote:
> On Mon, 22 Sept 2025 at 09:56, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Fri, Sep 19, 2025 at 05:58:20PM +0200, Vincent Guittot wrote:
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
> > >  drivers/pci/controller/dwc/Kconfig           |  11 +
> > >  drivers/pci/controller/dwc/Makefile          |   1 +
> > >  drivers/pci/controller/dwc/pcie-designware.h |   1 +
> > >  drivers/pci/controller/dwc/pcie-s32g-regs.h  |  61 ++
> > >  drivers/pci/controller/dwc/pcie-s32g.c       | 578 +++++++++++++++++++
> > >  5 files changed, 652 insertions(+)
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-s32g-regs.h
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-s32g.c
> > >
> > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > index ff6b6d9e18ec..d7cee915aedd 100644
> > > --- a/drivers/pci/controller/dwc/Kconfig
> > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > @@ -255,6 +255,17 @@ config PCIE_TEGRA194_EP
> > >         in order to enable device-specific features PCIE_TEGRA194_EP must be
> > >         selected. This uses the DesignWare core.
> > >
> > > +config PCIE_S32G
> >
> > PCIE_NXP_S32G?
> 
> I don't have a  strong opinion on this. I have followed what was done
> for other PCIE drivers which only use soc family as well like
> PCI_IMX6_HOST
> PCIE_KIRIN
> PCIE_ARMADA_8K
> PCIE_TEGRA194_HOST
> PCIE_RCAR_GEN4
> PCIE_SPEAR13XX
> 

I'd prefer to have vendor prefix to avoid collisions. Especially if the product
name is something like S32G, which is not 'unique'.

> >
> > > +     bool "NXP S32G PCIe controller (host mode)"
> > > +     depends on ARCH_S32 || (OF && COMPILE_TEST)
> > > +     select PCIE_DW_HOST
> > > +     help
> > > +       Enable support for the PCIe controller in NXP S32G based boards to
> > > +       work in Host mode. The controller is based on DesignWare IP and
> > > +       can work either as RC or EP. In order to enable host-specific
> > > +       features PCIE_S32G must be selected.
> > > +
> > > +
> > >  config PCIE_DW_PLAT
> > >       bool
> > >
> > > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> > > index 6919d27798d1..47fbedd57747 100644
> > > --- a/drivers/pci/controller/dwc/Makefile
> > > +++ b/drivers/pci/controller/dwc/Makefile
> > > @@ -14,6 +14,7 @@ obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
> > >  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
> > >  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
> > >  obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
> > > +obj-$(CONFIG_PCIE_S32G) += pcie-s32g.o
> >
> > pcie-nxp-s32g?
> 
> Same as Kconfig, other drivers only use the SoC family.
> 
> >
> > >  obj-$(CONFIG_PCIE_QCOM_COMMON) += pcie-qcom-common.o
> > >  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
> > >  obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index 00f52d472dcd..2aec011a9dd4 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -119,6 +119,7 @@
> > >
> > >  #define GEN3_RELATED_OFF                     0x890
> > >  #define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL BIT(0)
> > > +#define GEN3_RELATED_OFF_EQ_PHASE_2_3                BIT(9)
> > >  #define GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS  BIT(13)
> > >  #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE     BIT(16)
> > >  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT       24
> > > diff --git a/drivers/pci/controller/dwc/pcie-s32g-regs.h b/drivers/pci/controller/dwc/pcie-s32g-regs.h
> > > new file mode 100644
> > > index 000000000000..674ea47a525f
> > > --- /dev/null
> > > +++ b/drivers/pci/controller/dwc/pcie-s32g-regs.h
> > > @@ -0,0 +1,61 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > > +/*
> > > + * Copyright 2015-2016 Freescale Semiconductor, Inc.
> > > + * Copyright 2016-2023, 2025 NXP
> > > + */
> > > +
> > > +#ifndef PCIE_S32G_REGS_H
> > > +#define PCIE_S32G_REGS_H
> > > +
> > > +/* Instance PCIE_SS - CTRL register offsets (ctrl base) */
> > > +#define LINK_INT_CTRL_STS                    0x40
> >
> > Use PCIE_S32G prefix for vendor specific registers.
> 
> Okay
> 
> >
> > > +#define LINK_REQ_RST_NOT_INT_EN                      BIT(1)
> > > +#define LINK_REQ_RST_NOT_CLR                 BIT(2)
> > > +
> > > +/* PCIe controller 0 general control 1 (ctrl base) */
> > > +#define PE0_GEN_CTRL_1                               0x50
> > > +#define SS_DEVICE_TYPE_MASK                  GENMASK(3, 0)
> > > +#define SS_DEVICE_TYPE(x)                    FIELD_PREP(SS_DEVICE_TYPE_MASK, x)
> > > +#define SRIS_MODE_EN                         BIT(8)
> > > +
> > > +/* PCIe controller 0 general control 3 (ctrl base) */
> > > +#define PE0_GEN_CTRL_3                               0x58
> > > +/* LTSSM Enable. Active high. Set it low to hold the LTSSM in Detect state. */
> > > +#define LTSSM_EN                             BIT(0)
> > > +
> > > +/* PCIe Controller 0 Link Debug 2 (ctrl base) */
> > > +#define PCIE_SS_PE0_LINK_DBG_2                       0xB4
> > > +#define PCIE_SS_SMLH_LTSSM_STATE_MASK                GENMASK(5, 0)
> > > +#define PCIE_SS_SMLH_LINK_UP                 BIT(6)
> > > +#define PCIE_SS_RDLH_LINK_UP                 BIT(7)
> > > +#define LTSSM_STATE_L0                               0x11U /* L0 state */
> > > +#define LTSSM_STATE_L0S                              0x12U /* L0S state */
> > > +#define LTSSM_STATE_L1_IDLE                  0x14U /* L1_IDLE state */
> > > +#define LTSSM_STATE_HOT_RESET                        0x1FU /* HOT_RESET state */
> > > +
> > > +/* PCIe Controller 0  Interrupt Status (ctrl base) */
> > > +#define PE0_INT_STS                          0xE8
> > > +#define HP_INT_STS                           BIT(6)
> > > +
> > > +/* Link Control and Status Register. (PCI_EXP_LNKCTL in pci-regs.h) */
> > > +#define PCIE_CAP_LINK_TRAINING                       BIT(27)
> > > +
> > > +/* Instance PCIE_PORT_LOGIC - DBI register offsets */
> > > +#define PCIE_PORT_LOGIC_BASE                 0x700
> > > +
> > > +/* ACE Cache Coherency Control Register 3 */
> > > +#define PORT_LOGIC_COHERENCY_CONTROL_1               (PCIE_PORT_LOGIC_BASE + 0x1E0)
> > > +#define PORT_LOGIC_COHERENCY_CONTROL_2               (PCIE_PORT_LOGIC_BASE + 0x1E4)
> > > +#define PORT_LOGIC_COHERENCY_CONTROL_3               (PCIE_PORT_LOGIC_BASE + 0x1E8)
> > > +
> > > +/*
> > > + * See definition of register "ACE Cache Coherency Control Register 1"
> > > + * (COHERENCY_CONTROL_1_OFF) in the SoC RM
> > > + */
> > > +#define CC_1_MEMTYPE_BOUNDARY_MASK           GENMASK(31, 2)
> > > +#define CC_1_MEMTYPE_BOUNDARY(x)             FIELD_PREP(CC_1_MEMTYPE_BOUNDARY_MASK, x)
> > > +#define CC_1_MEMTYPE_VALUE                   BIT(0)
> > > +#define CC_1_MEMTYPE_LOWER_PERIPH            0x0
> > > +#define CC_1_MEMTYPE_LOWER_MEM                       0x1
> > > +
> > > +#endif  /* PCI_S32G_REGS_H */
> > > diff --git a/drivers/pci/controller/dwc/pcie-s32g.c b/drivers/pci/controller/dwc/pcie-s32g.c
> > > new file mode 100644
> > > index 000000000000..995e4593a13e
> > > --- /dev/null
> > > +++ b/drivers/pci/controller/dwc/pcie-s32g.c
> > > @@ -0,0 +1,578 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * PCIe host controller driver for NXP S32G SoCs
> > > + *
> > > + * Copyright 2019-2025 NXP
> > > + */
> > > +
> > > +#include <linux/interrupt.h>
> > > +#include <linux/io.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/phy.h>
> > > +#include <linux/phy/phy.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/sizes.h>
> > > +#include <linux/types.h>
> > > +
> > > +#include "pcie-designware.h"
> > > +#include "pcie-s32g-regs.h"
> > > +
> > > +struct s32g_pcie {
> > > +     struct dw_pcie  pci;
> > > +
> > > +     /*
> > > +      * We have cfg in struct dw_pcie_rp and
> > > +      * dbi in struct dw_pcie, so define only ctrl here
> > > +      */
> > > +     void __iomem *ctrl_base;
> > > +     u64 coherency_base;
> > > +
> > > +     struct phy *phy;
> > > +};
> > > +
> > > +#define to_s32g_from_dw_pcie(x) \
> > > +     container_of(x, struct s32g_pcie, pci)
> > > +
> > > +static void s32g_pcie_writel_ctrl(struct s32g_pcie *s32g_pp, u32 reg, u32 val)
> > > +{
> > > +     if (dw_pcie_write(s32g_pp->ctrl_base + reg, 0x4, val))
> > > +             dev_err(s32g_pp->pci.dev, "Write ctrl address failed\n");
> > > +}
> >
> > Since you are having complete control over the register and the base, you can
> > directly use writel/readl without these helpers. They are mostly used to
> > read/write the common register space like DBI.
> 
> fair enough
> 

You should also use _relaxed variants unless ordering is necessary.

> >
> > > +
> > > +static u32 s32g_pcie_readl_ctrl(struct s32g_pcie *s32g_pp, u32 reg)
> > > +{
> > > +     u32 val = 0;
> > > +
> > > +     if (dw_pcie_read(s32g_pp->ctrl_base + reg, 0x4, &val))
> > > +             dev_err(s32g_pp->pci.dev, "Read ctrl address failed\n");
> > > +
> > > +     return val;
> > > +}
> > > +
> > > +static void s32g_pcie_enable_ltssm(struct s32g_pcie *s32g_pp)
> > > +{
> > > +     u32 reg;
> > > +
> > > +     reg = s32g_pcie_readl_ctrl(s32g_pp, PE0_GEN_CTRL_3);
> > > +     reg |= LTSSM_EN;
> > > +     s32g_pcie_writel_ctrl(s32g_pp, PE0_GEN_CTRL_3, reg);
> > > +}
> > > +
> > > +static void s32g_pcie_disable_ltssm(struct s32g_pcie *s32g_pp)
> > > +{
> > > +     u32 reg;
> > > +
> > > +     reg = s32g_pcie_readl_ctrl(s32g_pp, PE0_GEN_CTRL_3);
> > > +     reg &= ~LTSSM_EN;
> > > +     s32g_pcie_writel_ctrl(s32g_pp, PE0_GEN_CTRL_3, reg);
> > > +}
> > > +
> > > +static bool is_s32g_pcie_ltssm_enabled(struct s32g_pcie *s32g_pp)
> > > +{
> > > +     return (s32g_pcie_readl_ctrl(s32g_pp, PE0_GEN_CTRL_3) & LTSSM_EN);
> > > +}
> > > +
> > > +static enum dw_pcie_ltssm s32g_pcie_get_ltssm(struct dw_pcie *pci)
> > > +{
> > > +     struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
> > > +     u32 val = s32g_pcie_readl_ctrl(s32g_pp, PCIE_SS_PE0_LINK_DBG_2);
> > > +
> > > +     return (enum dw_pcie_ltssm)FIELD_GET(PCIE_SS_SMLH_LTSSM_STATE_MASK, val);
> > > +}
> > > +
> > > +#define PCIE_LINKUP  (PCIE_SS_SMLH_LINK_UP | PCIE_SS_RDLH_LINK_UP)
> > > +
> > > +static bool has_data_phy_link(struct s32g_pcie *s32g_pp)
> > > +{
> > > +     u32 val = s32g_pcie_readl_ctrl(s32g_pp, PCIE_SS_PE0_LINK_DBG_2);
> > > +
> > > +     if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
> > > +             switch (val & PCIE_SS_SMLH_LTSSM_STATE_MASK) {
> > > +             case LTSSM_STATE_L0:
> > > +             case LTSSM_STATE_L0S:
> > > +             case LTSSM_STATE_L1_IDLE:
> > > +                     return true;
> > > +             default:
> > > +                     return false;
> > > +             }
> > > +     }
> > > +
> > > +     return false;
> > > +}
> > > +
> > > +static bool s32g_pcie_link_up(struct dw_pcie *pci)
> > > +{
> > > +     struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
> > > +
> > > +     if (!is_s32g_pcie_ltssm_enabled(s32g_pp))
> > > +             return false;
> > > +
> > > +     return has_data_phy_link(s32g_pp);
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
> > > +struct dw_pcie_ops s32g_pcie_ops = {
> > > +     .get_ltssm = s32g_pcie_get_ltssm,
> > > +     .link_up = s32g_pcie_link_up,
> > > +     .start_link = s32g_pcie_start_link,
> > > +     .stop_link = s32g_pcie_stop_link,
> > > +};
> > > +
> > > +static const struct dw_pcie_host_ops s32g_pcie_host_ops;
> > > +
> > > +static void disable_equalization(struct dw_pcie *pci)
> > > +{
> > > +     u32 val;
> > > +
> > > +     val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> > > +     val &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
> > > +              GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
> > > +     val |= FIELD_PREP(GEN3_EQ_CONTROL_OFF_FB_MODE, 1) |
> > > +            FIELD_PREP(GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC, 0x84);
> >
> > FIELD_MODIFY()?
> 
> FIELD_PREP() allows  adding multiple fields changes in a single access
> instead of having one access per field with FIELD_MODIFY
> 

Yeah, but it gets rid of the explicit masking.

> >
> > > +     dw_pcie_dbi_ro_wr_en(pci);
> > > +     dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
> > > +     dw_pcie_dbi_ro_wr_dis(pci);
> > > +}
> > > +
> > > +static void s32g_pcie_reset_mstr_ace(struct dw_pcie *pci, u64 ddr_base_addr)
> >
> > What does _ace stands for?
> 
> AMBA AXI Coherency Extensions (ACE)
> 

Ok. You could add a comment to make it clear of what this function does.

> >
> > > +{
> > > +     u32 ddr_base_low = lower_32_bits(ddr_base_addr);
> > > +     u32 ddr_base_high = upper_32_bits(ddr_base_addr);
> > > +
> > > +     dw_pcie_dbi_ro_wr_en(pci);
> > > +     dw_pcie_writel_dbi(pci, PORT_LOGIC_COHERENCY_CONTROL_3, 0x0);
> > > +
> > > +     /*
> > > +      * Transactions to peripheral targets should be non-coherent,
> >
> > What is exactly meant by 'Transactions to peripheral targets'? Is it the MMIO
> > access to peripherals? If so, all MMIO memory is marked as non-cacheable by
> > default.
> 
> From the ref manual of s32g :
> Ncore is a cache-coherent interconnect module. It enables the
> integration of heterogeneous coherent agents and non-coherent
> agents in a chip. It processes transactions with coherent access
> semantics from various fully-coherent and IO-coherent masters,
> targeting shared resources.
> 

Ok. It would help if this is described in the patch description.

> >
> > > +      * or Ncore might drop them.
> >
> > What is 'Ncore'?
> >

[...]

> >
> > > +
> > > +     return 0;
> > > +
> > > +err_host_deinit:
> > > +     dw_pcie_host_deinit(pp);
> > > +     return ret;
> > > +}
> > > +
> > > +static int s32g_pcie_probe(struct platform_device *pdev)
> > > +{
> > > +     struct device *dev = &pdev->dev;
> > > +     struct s32g_pcie *s32g_pp;
> > > +     int ret;
> > > +
> > > +     s32g_pp = devm_kzalloc(dev, sizeof(*s32g_pp), GFP_KERNEL);
> > > +     if (!s32g_pp)
> > > +             return -ENOMEM;
> > > +
> > > +     ret = s32g_pcie_get_resources(pdev, s32g_pp);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     devm_pm_runtime_enable(dev);
> > > +     ret = pm_runtime_get_sync(dev);
> >
> > Does this driver rely on any of its parent to enable the resources? Like
> > pm-domain, clock, etc... If so, just set pm_runtime_no_callbacks() before
> 
> pm_runtime_no_callbacks() is missing.
> 

I was specifically questioning the 'pm_runtime_get_sync()' call. If you need to
enable any parent resources, then you can keep it. Otherwise, just drop it.

> > devm_pm_runtime_enable(). If not, then do:
> >
> >         pm_runtime_set_active()
> >         pm_runtime_no_callbacks()
> >         devm_pm_runtime_enable()
> >
> > > +     if (ret < 0)
> > > +             goto err_pm_runtime_put;
> > > +
> > > +     ret = s32g_pcie_init(dev, s32g_pp);
> > > +     if (ret)
> > > +             goto err_pm_runtime_put;
> > > +
> > > +     ret = s32g_pcie_host_init(dev, s32g_pp);
> > > +     if (ret)
> > > +             goto err_deinit_controller;
> > > +
> > > +     return 0;
> > > +
> > > +err_deinit_controller:
> > > +     s32g_pcie_deinit(s32g_pp);
> > > +err_pm_runtime_put:
> > > +     pm_runtime_put(dev);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int s32g_pcie_suspend(struct device *dev)
> > > +{
> > > +     struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> > > +     struct dw_pcie *pci = &s32g_pp->pci;
> > > +     struct dw_pcie_rp *pp = &pci->pp;
> > > +     struct pci_bus *bus, *root_bus;
> > > +
> > > +     s32g_pcie_downstream_dev_to_D0(s32g_pp);
> > > +
> > > +     bus = pp->bridge->bus;
> > > +     root_bus = s32g_get_child_downstream_bus(bus);
> > > +     if (!IS_ERR(root_bus))
> > > +             pci_walk_bus(root_bus, pci_dev_set_disconnected, NULL);
> > > +
> > > +     pci_stop_root_bus(bus);
> > > +     pci_remove_root_bus(bus);
> >
> > Why can't you rely on dw_pcie_host_deinit()?
> 
> I need to check but mainly because we don't do dw_pcie_host_init() during resume
> 

You should and it will simplify your driver a lot.

> >
> > > +
> > > +     s32g_pcie_deinit(s32g_pp);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int s32g_pcie_resume(struct device *dev)
> > > +{
> > > +     struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> > > +     struct dw_pcie *pci = &s32g_pp->pci;
> > > +     struct dw_pcie_rp *pp = &pci->pp;
> > > +     int ret = 0;
> > > +
> > > +     ret = s32g_pcie_init(dev, s32g_pp);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     ret = dw_pcie_setup_rc(pp);
> > > +     if (ret) {
> > > +             dev_err(dev, "Failed to resume DW RC: %d\n", ret);
> > > +             goto fail_host_init;
> > > +     }
> > > +
> > > +     ret = dw_pcie_start_link(pci);
> > > +     if (ret) {
> > > +             /*
> > > +              * We do not exit with error if link up was unsuccessful
> > > +              * Endpoint may not be connected.
> > > +              */
> > > +             if (dw_pcie_wait_for_link(pci))
> > > +                     dev_warn(pci->dev,
> > > +                              "Link Up failed, Endpoint may not be connected\n");
> > > +
> > > +             if (!phy_validate(s32g_pp->phy, PHY_MODE_PCIE, 0, NULL)) {
> > > +                     dev_err(dev, "Failed to get link up with EP connected\n");
> > > +                     goto fail_host_init;
> > > +             }
> > > +     }
> > > +
> > > +     ret = pci_host_probe(pp->bridge);
> >
> > Oh no... Do not call pci_host_probe() directly from glue drivers. Use
> > dw_pcie_host_init() to do so. This should simplify suspend and resume functions.
> 
> dw_pcie_host_init() is doing much more than just init the controller
> as it gets resources which we haven't released during suspend.
> 

Any specific reason to keep resources enabled, even though you were removing the
Root bus? This doesn't make sense to me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

