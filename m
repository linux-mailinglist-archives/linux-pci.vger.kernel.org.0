Return-Path: <linux-pci+bounces-37016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EA6BA0C13
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 19:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFEAB19C14D7
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396AC30AAC6;
	Thu, 25 Sep 2025 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9RzLPfl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5058630DD17
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820174; cv=none; b=R5ivq/P+nV7R2zeb6wO9lKm7n1dswnLyez80i8mQ5vk+DW97TldtQAFj5cxqygZYgTJiTuhZAS1HJzJsJwe/933YBLETdK657ROYwed8962KE9/Loo3MHnzxPUA0XwKk1SVA0diD9hAtZ3VkWoK9vueZjatK/LAXo5UfTuCihak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820174; c=relaxed/simple;
	bh=TI4UFEUJi3Gk5qkuEPjTPMKZyjiydEe8wJaAtnvoS9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7UHemY9K1+VWyTpvw6CMBZN4khQSMUj9mU/6sbIOON9xXNW+5+FwtJV/4O9gK0uOWiICAJbA4edOxUMNfhSMuPbpUhALt9GtfwIqtlUREkcGfQvh1pFEF7e7M6pbwrOHcJuDSeSTU395KXV5g0tbijEJNBRpa5nz41Zcwto7Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b9RzLPfl; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63053019880so2478980a12.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758820170; x=1759424970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uu45AuA4+OICIroBZ/rvLji/N0U6nhUh6dslshE2fqg=;
        b=b9RzLPflEy2KghyEQ29Y/NvVC+qOZhCmyKk56N4DKRCIeNzHSGpMtCmoemzs+RV6/F
         NPwZfva5vI3mcEhHvCHg5JYX5rqZT6q1TBBbzjc/qzLRLmkrBDHuvsHTI9WD+4opdk53
         phHkzTjO0gkMXLTyls0HbCyht1Bsz28rCbbPkNhp4HS4NXfvxi4NVLg3reB5HdG3XkfO
         lX96UJM/6zaaNLbG7oMAIjVu/eXRzCPMwOVE+4D+chBdUuiHM+hRRWaAo34Bn7GSSCbU
         JpVD6fK/u0mWKZtdPyM3cxuZfMpC8+EeNEyjYO7vC+68eMJrJAGJRFW4QWQ9NBgLMKKA
         /fVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758820170; x=1759424970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uu45AuA4+OICIroBZ/rvLji/N0U6nhUh6dslshE2fqg=;
        b=O/Demdc6uD5vgS07kzWuQdItjec5i2iE0bJvP/8A7MCPfDeljZ00UirJIWN4Esyshp
         U2U4bhiq7klLgAkTsfcophfKkEiDy+wvSJOC3lBi8U9rHdnEp2hOuaJVniKPDfS2y2ek
         WjavNohVp1ACYiJqf6vGByUDZPR7Gpoj18XmXjRaLSwun5BQQOuRCve9oxILr1QIK1an
         DtfwlvVtTY0c63JTQKi2ePn+bXgJxhyKylddIWtGEYmFZYc7BrRabCOXkK5PbOSQuAo4
         FYb1TBxNWwuPm6Hg08HqceHIEwHOXixSU6CRQfNVSVNoSf171Mm01jMgXZtvPqQi86/h
         05rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIivSb4BSPQAZBK1WTf2J4sFmsR8zvhWW9YQcXn9aGrIuPJb6FYlKOcRHTCEDTtwliktO37rv2sQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCI7jAL4Y3QNKCLCqaPaZ7aiySi6jBPn39ZGhLc0NtfCHsgz7C
	yWO80cytkRIF6JlqV0W9oicSrfaceY5GxfCeJaF0BiyCjGLaO0uoGAjoEqAP/8xrwHAfF/HnhXg
	KXK1Mp++b/+eyEYYLSNK4y/s52w20q9Z5l9jl+SqEZw==
X-Gm-Gg: ASbGnctGFCxwH5qVHDa+unDK+p2ugbLcOc+ufZeBSYh5MsYs2bbjpPLLlrdAw3tm7+W
	MGUuIQMJXGFSgRk8sOJG/50jEucEzJvpQtbsU4aw0oM62kxaFyWRazOQVkPTKFS9RAtme2Zblh8
	zRA/iPuob/FKQJiUDAfzlSi1+TO+NI5JuisC/kFPtO+Dza2FwNaQO5x/RgSUHBOngqYnfiWMBMy
	dqwYE9nfENxnXaepZBxkkJkpclRWisu8bq4
X-Google-Smtp-Source: AGHT+IGXQunu2ZkBwwJwYxJ/LCc/AW2nRKtyjv8YQQxyyQaUn4HJmzhndXF7HgLXPQvELWtx0Xb7fDVxsbRBSW03hfg=
X-Received: by 2002:aa7:d389:0:b0:62f:7da5:470c with SMTP id
 4fb4d7f45d1cf-6349f9cce0amr2515311a12.4.1758820169427; Thu, 25 Sep 2025
 10:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-3-vincent.guittot@linaro.org> <aM2i+E7OUqL2fYDV@lizhi-Precision-Tower-5810>
In-Reply-To: <aM2i+E7OUqL2fYDV@lizhi-Precision-Tower-5810>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 25 Sep 2025 19:09:18 +0200
X-Gm-Features: AS18NWCtZyKJOTFm5Tj5kj13aTQFh0yfjs9C-00HtfG5J9eqen0BKXK18VKL6W8
Message-ID: <CAKfTPtBSZPtFSP4MEMuBnzWs2njpsPyhEsE97yDyp6Ek4mMwRw@mail.gmail.com>
Subject: Re: [PATCH 2/3 v2] PCI: s32g: Add initial PCIe support (RC)
To: Frank Li <Frank.li@nxp.com>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, 
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com, 
	bogdan.hamciuc@nxp.com, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Sept 2025 at 20:38, Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, Sep 19, 2025 at 05:58:20PM +0200, Vincent Guittot wrote:
> > Add initial support of the PCIe controller for S32G Soc family. Only
> > host mode is supported.
> >
> > Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/Kconfig           |  11 +
> >  drivers/pci/controller/dwc/Makefile          |   1 +
> >  drivers/pci/controller/dwc/pcie-designware.h |   1 +
> >  drivers/pci/controller/dwc/pcie-s32g-regs.h  |  61 ++
> >  drivers/pci/controller/dwc/pcie-s32g.c       | 578 +++++++++++++++++++
> >  5 files changed, 652 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-s32g-regs.h
> >  create mode 100644 drivers/pci/controller/dwc/pcie-s32g.c
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index ff6b6d9e18ec..d7cee915aedd 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -255,6 +255,17 @@ config PCIE_TEGRA194_EP
> >         in order to enable device-specific features PCIE_TEGRA194_EP must be
> >         selected. This uses the DesignWare core.
> >
> > +config PCIE_S32G
> > +     bool "NXP S32G PCIe controller (host mode)"
> > +     depends on ARCH_S32 || (OF && COMPILE_TEST)
> > +     select PCIE_DW_HOST
> > +     help
> > +       Enable support for the PCIe controller in NXP S32G based boards to
> > +       work in Host mode. The controller is based on DesignWare IP and
> > +       can work either as RC or EP. In order to enable host-specific
> > +       features PCIE_S32G must be selected.
> > +
> > +
> >  config PCIE_DW_PLAT
> >       bool
> >
> > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> > index 6919d27798d1..47fbedd57747 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -14,6 +14,7 @@ obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
> >  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
> >  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
> >  obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
> > +obj-$(CONFIG_PCIE_S32G) += pcie-s32g.o
>
> keep alphabet order.

yes

>
> >  obj-$(CONFIG_PCIE_QCOM_COMMON) += pcie-qcom-common.o
> >  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
> >  obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 00f52d472dcd..2aec011a9dd4 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -119,6 +119,7 @@
> >
> >  #define GEN3_RELATED_OFF                     0x890
> >  #define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL BIT(0)
> > +#define GEN3_RELATED_OFF_EQ_PHASE_2_3                BIT(9)
> >  #define GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS  BIT(13)
> >  #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE     BIT(16)
> >  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT       24
>
> This one should be separate patch

ok

>
> > diff --git a/drivers/pci/controller/dwc/pcie-s32g-regs.h b/drivers/pci/controller/dwc/pcie-s32g-regs.h
> > new file mode 100644
> > index 000000000000..674ea47a525f
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-s32g-regs.h
> > @@ -0,0 +1,61 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2015-2016 Freescale Semiconductor, Inc.
> > + * Copyright 2016-2023, 2025 NXP
> > + */
> > +
> > +#ifndef PCIE_S32G_REGS_H
> > +#define PCIE_S32G_REGS_H
> > +
> > +/* Instance PCIE_SS - CTRL register offsets (ctrl base) */
> > +#define LINK_INT_CTRL_STS                    0x40
> > +#define LINK_REQ_RST_NOT_INT_EN                      BIT(1)
> > +#define LINK_REQ_RST_NOT_CLR                 BIT(2)
> > +
> > +/* PCIe controller 0 general control 1 (ctrl base) */
> > +#define PE0_GEN_CTRL_1                               0x50
> > +#define SS_DEVICE_TYPE_MASK                  GENMASK(3, 0)
> > +#define SS_DEVICE_TYPE(x)                    FIELD_PREP(SS_DEVICE_TYPE_MASK, x)
> > +#define SRIS_MODE_EN                         BIT(8)
> > +
> > +/* PCIe controller 0 general control 3 (ctrl base) */
> > +#define PE0_GEN_CTRL_3                               0x58
> > +/* LTSSM Enable. Active high. Set it low to hold the LTSSM in Detect state. */
> > +#define LTSSM_EN                             BIT(0)
> > +
> > +/* PCIe Controller 0 Link Debug 2 (ctrl base) */
> > +#define PCIE_SS_PE0_LINK_DBG_2                       0xB4
> > +#define PCIE_SS_SMLH_LTSSM_STATE_MASK                GENMASK(5, 0)
> > +#define PCIE_SS_SMLH_LINK_UP                 BIT(6)
> > +#define PCIE_SS_RDLH_LINK_UP                 BIT(7)
> > +#define LTSSM_STATE_L0                               0x11U /* L0 state */
> > +#define LTSSM_STATE_L0S                              0x12U /* L0S state */
> > +#define LTSSM_STATE_L1_IDLE                  0x14U /* L1_IDLE state */
> > +#define LTSSM_STATE_HOT_RESET                        0x1FU /* HOT_RESET state */
>
> These LTSSM* are the exact the same as enum dw_pcie_ltssm.
> why need redefine it?

fair enough

>
> Can you check other register also?
>
> > +
> > +/* PCIe Controller 0  Interrupt Status (ctrl base) */
> > +#define PE0_INT_STS                          0xE8
> > +#define HP_INT_STS                           BIT(6)
> > +
> > +/* Link Control and Status Register. (PCI_EXP_LNKCTL in pci-regs.h) */
> > +#define PCIE_CAP_LINK_TRAINING                       BIT(27)
>
> Does it belong to PCIe standand?

Can be removed, it's not used

The same for PE0_INT_STS above

>
> > +
> > +/* Instance PCIE_PORT_LOGIC - DBI register offsets */
> > +#define PCIE_PORT_LOGIC_BASE                 0x700
> > +
> > +/* ACE Cache Coherency Control Register 3 */
> > +#define PORT_LOGIC_COHERENCY_CONTROL_1               (PCIE_PORT_LOGIC_BASE + 0x1E0)
> > +#define PORT_LOGIC_COHERENCY_CONTROL_2               (PCIE_PORT_LOGIC_BASE + 0x1E4)
> > +#define PORT_LOGIC_COHERENCY_CONTROL_3               (PCIE_PORT_LOGIC_BASE + 0x1E8)
> > +
> > +/*
> > + * See definition of register "ACE Cache Coherency Control Register 1"
> > + * (COHERENCY_CONTROL_1_OFF) in the SoC RM
> > + */
> > +#define CC_1_MEMTYPE_BOUNDARY_MASK           GENMASK(31, 2)
> > +#define CC_1_MEMTYPE_BOUNDARY(x)             FIELD_PREP(CC_1_MEMTYPE_BOUNDARY_MASK, x)
> > +#define CC_1_MEMTYPE_VALUE                   BIT(0)
> > +#define CC_1_MEMTYPE_LOWER_PERIPH            0x0
> > +#define CC_1_MEMTYPE_LOWER_MEM                       0x1
> > +
> > +#endif  /* PCI_S32G_REGS_H */
> > diff --git a/drivers/pci/controller/dwc/pcie-s32g.c b/drivers/pci/controller/dwc/pcie-s32g.c
> > new file mode 100644
> > index 000000000000..995e4593a13e
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-s32g.c
> > @@ -0,0 +1,578 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCIe host controller driver for NXP S32G SoCs
> > + *
> > + * Copyright 2019-2025 NXP
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_address.h>
> > +#include <linux/pci.h>
> > +#include <linux/phy.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/sizes.h>
> > +#include <linux/types.h>
> > +
> > +#include "pcie-designware.h"
> > +#include "pcie-s32g-regs.h"
> > +
> > +struct s32g_pcie {
> > +     struct dw_pcie  pci;
> > +
> > +     /*
> > +      * We have cfg in struct dw_pcie_rp and
> > +      * dbi in struct dw_pcie, so define only ctrl here
> > +      */
> > +     void __iomem *ctrl_base;
> > +     u64 coherency_base;
> > +
> > +     struct phy *phy;
> > +};
> > +
>
> ...
>
> > +
> > +static bool s32g_pcie_link_up(struct dw_pcie *pci)
> > +{
> > +     struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
> > +
> > +     if (!is_s32g_pcie_ltssm_enabled(s32g_pp))
> > +             return false;
> > +
> > +     return has_data_phy_link(s32g_pp);
>
> Does dw_pcie_wait_for_link() work for s32g?

Yes. dw_pcie_wait_for_link() -> dw_pcie_link_up() ->
s32g_pcie_link_up() -> has_data_phy_link()

>
> > +}
> > +
> > +static int s32g_pcie_start_link(struct dw_pcie *pci)
> > +{
> > +     struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
> > +
> > +     s32g_pcie_enable_ltssm(s32g_pp);
> > +
> > +     return 0;
> > +}
> > +
>
> ...
>
> > +
> > +static void s32g_pcie_downstream_dev_to_D0(struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pci = &s32g_pp->pci;
> > +     struct dw_pcie_rp *pp = &pci->pp;
> > +     struct pci_bus *root_bus = NULL;
> > +     struct pci_dev *pdev;
> > +
> > +     /* Check if we did manage to initialize the host */
> > +     if (!pp->bridge || !pp->bridge->bus)
> > +             return;
> > +
> > +     /*
> > +      * link doesn't go into L2 state with some of the Endpoints
> > +      * if they are not in D0 state. So, we need to make sure that
> > +      * immediate downstream devices are in D0 state before sending
> > +      * PME_TurnOff to put link into L2 state.
> > +      */
> > +
> > +     root_bus = s32g_get_child_downstream_bus(pp->bridge->bus);
> > +     if (IS_ERR(root_bus)) {
> > +             dev_err(pci->dev, "Failed to find downstream devices\n");
> > +             return;
> > +     }
> > +
> > +     list_for_each_entry(pdev, &root_bus->devices, bus_list) {
> > +             if (PCI_SLOT(pdev->devfn) == 0) {
> > +                     if (pci_set_power_state(pdev, PCI_D0))
> > +                             dev_err(pci->dev,
> > +                                     "Failed to transition %s to D0 state\n",
> > +                                     dev_name(&pdev->dev));
> > +             }
>
> strange, why common code have not do that?

Some other drivers like tegra194 also do it

some devices were not accessible after resume. I'm going to have a closer look

>
> > +     }
> > +}
> > +
> > +static u64 s32g_get_coherency_boundary(struct device *dev)
> > +{
> > +     struct device_node *np;
> > +     struct resource res;
> > +
> > +     np = of_find_node_by_type(NULL, "memory");
>
> Feel like it is not good method to decide memory DDR space. It should
> be fixed value for each Soc.
>
> You can put ddr start address at your pci driver data, which is just
> used for split periphal mmio space and memory space.

It's a shame that we need to define a pcie driver data for what is a
global hw description but Rob suggested using memblokc
(memblock_start_of_DRAM)



>
> > +
> > +     if (of_address_to_resource(np, 0, &res)) {
> > +             dev_warn(dev, "Fail to get coherency boundary\n");
> > +             res.start = 0;
> > +     }
> > +
> > +     of_node_put(np);
> > +
> > +     return res.start;
> > +}
> > +
> > +static int s32g_pcie_get_resources(struct platform_device *pdev,
> > +                                struct s32g_pcie *s32g_pp)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct dw_pcie *pci = &s32g_pp->pci;
> > +     struct phy *phy;
> > +
> > +     pci->dev = dev;
> > +     pci->ops = &s32g_pcie_ops;
> > +
> > +     platform_set_drvdata(pdev, s32g_pp);
> > +
> > +     phy = devm_phy_get(dev, NULL);
> > +     if (IS_ERR(phy))
> > +             return dev_err_probe(dev, PTR_ERR(phy),
> > +                             "Failed to get serdes PHY\n");
> > +     s32g_pp->phy = phy;
> > +
> > +     pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
> > +     if (IS_ERR(pci->dbi_base))
> > +             return PTR_ERR(pci->dbi_base);
> > +
> > +     s32g_pp->ctrl_base = devm_platform_ioremap_resource_byname(pdev, "ctrl");
> > +     if (IS_ERR(s32g_pp->ctrl_base))
> > +             return PTR_ERR(s32g_pp->ctrl_base);
> > +
> > +     s32g_pp->coherency_base = s32g_get_coherency_boundary(dev);
> > +
> > +     return 0;
> > +}
> > +
> > +static int s32g_pcie_init(struct device *dev,
> > +                       struct s32g_pcie *s32g_pp)
> > +{
> > +     int ret;
> > +
> > +     s32g_pcie_disable_ltssm(s32g_pp);
> > +
> > +     ret = init_pcie_phy(s32g_pp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = init_pcie_controller(s32g_pp);
> > +     if (ret)
> > +             goto err_deinit_phy;
> > +
> > +     return 0;
> > +
> > +err_deinit_phy:
> > +     deinit_pcie_phy(s32g_pp);
> > +     return ret;
> > +}
> > +
> > +static void s32g_pcie_deinit(struct s32g_pcie *s32g_pp)
> > +{
> > +     s32g_pcie_disable_ltssm(s32g_pp);
> > +     deinit_pcie_phy(s32g_pp);
> > +}
> > +
> > +static int s32g_pcie_host_init(struct device *dev,
> > +                            struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pci = &s32g_pp->pci;
> > +     struct dw_pcie_rp *pp = &pci->pp;
> > +     int ret;
> > +
> > +     pp->ops = &s32g_pcie_host_ops;
> > +
> > +     ret = dw_pcie_host_init(pp);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to initialize host\n");
> > +             goto err_host_deinit;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_host_deinit:
> > +     dw_pcie_host_deinit(pp);
> > +     return ret;
> > +}
> > +
> > +static int s32g_pcie_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct s32g_pcie *s32g_pp;
> > +     int ret;
> > +
> > +     s32g_pp = devm_kzalloc(dev, sizeof(*s32g_pp), GFP_KERNEL);
> > +     if (!s32g_pp)
> > +             return -ENOMEM;
> > +
> > +     ret = s32g_pcie_get_resources(pdev, s32g_pp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     devm_pm_runtime_enable(dev);
> > +     ret = pm_runtime_get_sync(dev);
> > +     if (ret < 0)
> > +             goto err_pm_runtime_put;
>
> You enable run time pm, but no any run time pm callback in your driver.
>
> > +
> > +     ret = s32g_pcie_init(dev, s32g_pp);
> > +     if (ret)
> > +             goto err_pm_runtime_put;
> > +
> > +     ret = s32g_pcie_host_init(dev, s32g_pp);
> > +     if (ret)
> > +             goto err_deinit_controller;
> > +
> > +     return 0;
> > +
> > +err_deinit_controller:
> > +     s32g_pcie_deinit(s32g_pp);
> > +err_pm_runtime_put:
> > +     pm_runtime_put(dev);
> > +
> > +     return ret;
> > +}
> > +
> > +static int s32g_pcie_suspend(struct device *dev)
> > +{
> > +     struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> > +     struct dw_pcie *pci = &s32g_pp->pci;
> > +     struct dw_pcie_rp *pp = &pci->pp;
> > +     struct pci_bus *bus, *root_bus;
> > +
> > +     s32g_pcie_downstream_dev_to_D0(s32g_pp);
> > +
> > +     bus = pp->bridge->bus;
> > +     root_bus = s32g_get_child_downstream_bus(bus);
> > +     if (!IS_ERR(root_bus))
> > +             pci_walk_bus(root_bus, pci_dev_set_disconnected, NULL);
> > +
> > +     pci_stop_root_bus(bus);
> > +     pci_remove_root_bus(bus);
> > +
> > +     s32g_pcie_deinit(s32g_pp);
> > +
> > +     return 0;
> > +}
>
> why dw_pcie_suspend_noirq() and dw_pcie_suspend_ioresume() not work?
> can you enhance it to support s32g?
>
> Frank
> > +
> > +static int s32g_pcie_resume(struct device *dev)
> > +{
> > +     struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> > +     struct dw_pcie *pci = &s32g_pp->pci;
> > +     struct dw_pcie_rp *pp = &pci->pp;
> > +     int ret = 0;
> > +
> > +     ret = s32g_pcie_init(dev, s32g_pp);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = dw_pcie_setup_rc(pp);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to resume DW RC: %d\n", ret);
> > +             goto fail_host_init;
> > +     }
> > +
> > +     ret = dw_pcie_start_link(pci);
> > +     if (ret) {
> > +             /*
> > +              * We do not exit with error if link up was unsuccessful
> > +              * Endpoint may not be connected.
> > +              */
> > +             if (dw_pcie_wait_for_link(pci))
> > +                     dev_warn(pci->dev,
> > +                              "Link Up failed, Endpoint may not be connected\n");
> > +
> > +             if (!phy_validate(s32g_pp->phy, PHY_MODE_PCIE, 0, NULL)) {
> > +                     dev_err(dev, "Failed to get link up with EP connected\n");
> > +                     goto fail_host_init;
> > +             }
> > +     }
> > +
> > +     ret = pci_host_probe(pp->bridge);
> > +     if (ret)
> > +             goto fail_host_init;
> > +
> > +     return 0;
> > +
> > +fail_host_init:
> > +     s32g_pcie_deinit(s32g_pp);
> > +     return ret;
> > +}
> > +
> > +static const struct dev_pm_ops s32g_pcie_pm_ops = {
> > +     SYSTEM_SLEEP_PM_OPS(s32g_pcie_suspend,
> > +                         s32g_pcie_resume)
> > +};
> > +
> > +static const struct of_device_id s32g_pcie_of_match[] = {
> > +     { .compatible = "nxp,s32g2-pcie"},
> > +     { /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, s32g_pcie_of_match);
> > +
> > +static struct platform_driver s32g_pcie_driver = {
> > +     .driver = {
> > +             .name   = "s32g-pcie",
> > +             .of_match_table = s32g_pcie_of_match,
> > +             .suppress_bind_attrs = true,
> > +             .pm = pm_sleep_ptr(&s32g_pcie_pm_ops),
> > +     },
> > +     .probe = s32g_pcie_probe,
> > +};
> > +
> > +module_platform_driver(s32g_pcie_driver);
> > +
> > +MODULE_AUTHOR("Ionut Vicovan <Ionut.Vicovan@nxp.com>");
> > +MODULE_DESCRIPTION("NXP S32G PCIe Host controller driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.43.0
> >

