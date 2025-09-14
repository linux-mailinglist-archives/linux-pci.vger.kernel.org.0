Return-Path: <linux-pci+bounces-36100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 833D9B568DD
	for <lists+linux-pci@lfdr.de>; Sun, 14 Sep 2025 14:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB863BE722
	for <lists+linux-pci@lfdr.de>; Sun, 14 Sep 2025 12:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CADC1922DD;
	Sun, 14 Sep 2025 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UGck00hg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA74D263F2D
	for <linux-pci@vger.kernel.org>; Sun, 14 Sep 2025 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757853834; cv=none; b=Sa2hkP6HzFUI9SovERcD/9m3enZNzlzjSUZZxPo4qDRRT/hGKGj8KVrfolUSqC4klKp8DvLh31GBuBWyNGqaMWWDFL6pWyQIh4hLnTu1/zKFw9mLnQmjRxsHSNG7AQBEi08m95/1tQ802sMzN1CQl927wcr+MtJLVTfTGk6+3QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757853834; c=relaxed/simple;
	bh=dobWVe4i1FMGK9eSIlzkiWbWJCfleFYNOK9LtkbVQso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKIZ1pjQUoSxf99eqty5xL1kKcWU5DOTX7Ktaiuwr7Lnie6NY6928xtDpNlDRM9zBCp1IqIX6FZFQXsrDlyhJfXfSVyiSRcRe/rFwsV9qNvOWQzFFG7lYs/bP7lDkks2i4c/m2gHIlIdUpDbWF0dnbE6Ah/Gh6DiVrHfR2vCcXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UGck00hg; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62f1987d547so1012066a12.2
        for <linux-pci@vger.kernel.org>; Sun, 14 Sep 2025 05:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757853828; x=1758458628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uy+cd2lbAR50ajGef2hlnG8fQ1RbkXqMoeFyiCl2OoQ=;
        b=UGck00hgPsmZ2aiohgyM0vr3lh/qraeN65uqjU2STZoq00SvGQgcU3s/z9oNchDp5z
         NJhG7sHtwkN+QrpRtDjpTA4lyIS5y4v201K44CX9fv0TNQyb4H+nOBb8D1gbsTFWpIPV
         w/BrHb8wPMjj4lgsOqu+d/90BoyWN22itioODBFSZC09pRUj1l4ro+dyNDth4XuHYZoW
         KEoqa0nxL3goREAil6yyVA/NU4I/kxaHoy3dILJfCtNYq97vJ3yAbVeOxbhPcwcgJbwp
         1ElruQK4YkTeDS6HGrzl3ikiaOtHGVawp4WXiNNU4hL6MkACc4cC+sG26xc0XfTqnMHS
         AagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757853828; x=1758458628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uy+cd2lbAR50ajGef2hlnG8fQ1RbkXqMoeFyiCl2OoQ=;
        b=g7DYTvKZqZmUht3WSrT7Ri7mN+3wRAT4KLi7nEwVpgYU3fixIMdpeLfb7uhN3vQPvo
         royle7PGFa0NGlEPEHvMH0QspAq+v/GOLxAgvbPz8fnLAHClGZzqP75UUBWbR6qIhnQN
         lEGApjyejK/svpmsqMxWVrHl82rQQXkfsy4+v4Wk1I0s6mvo2DLlBn7W9h0PjJSSraiX
         kmKlMLHCMfmkamY1hrDYJnS48Avyk/5JXbOh6CpC7zyw7FdDz0vYfLzK68SZjh0swz7c
         BhcZc8Ej90L+6O5dOIrGUPJ/cvNdFwvoBCN2kbdvZWFk3AQ4IuMxkWV6YizafREvF4Je
         oNrg==
X-Forwarded-Encrypted: i=1; AJvYcCVw7ST0ZIBRNXY30COKqCZ/f/B6YCSwsBk3dX+FALDmt2iagkjVN20AW97zBvfDaBdr/r467KWz6SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSrs320+/sVa4hTIiIbhn9NtzaV0s3n/PwF1s7dLrsudE3DgHY
	qNp9/iE6ZzWzOetYYQY0/eZA+8GIikhaCm1nQP0R96mzobIM9HVhKOC7SwUfnVHtRRl2/zRndY3
	DL5GZhFSSCfYr4FF9gWuYSRgCkq0Kq3VBfcOZwnLEXg==
X-Gm-Gg: ASbGncsw6wVq+WCKiPAsCCx/mQOzpt8t2yt7AgeCwCG3PpQMioDoiDbIAYmYXGnqD32
	cdCcUSh7+oNVAgaujS5S40AsrmKEU98LgvfJMmb7GkoAfDNRJIwSmYBCd56WNaKLbNSy4JjtzzT
	os26qSjRLd/mE0JTsQETNzhBjdrleVpd+t9IWsevx6XXF7z1gO5XuEEtHXg4Qih10yNFYmdY3kl
	QK6MVSYLqqeLe3XPSZyO7cHmtgRUgm7UfE5BmcjK2PIwQg=
X-Google-Smtp-Source: AGHT+IF0+cMm0m1j0KWd+MnKwHHdp6AZ30WPyeA9VH0YZdhu1m4FfBCmr/HiFz9OfJzY55rCubQi7bscp7GWFYE+3cA=
X-Received: by 2002:a05:6402:454e:b0:615:78c6:7aed with SMTP id
 4fb4d7f45d1cf-62ed8619168mr7646484a12.32.1757853828043; Sun, 14 Sep 2025
 05:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912141436.2347852-1-vincent.guittot@linaro.org>
 <20250912141436.2347852-4-vincent.guittot@linaro.org> <aMSQ+CWz/rUoap2u@lizhi-Precision-Tower-5810>
In-Reply-To: <aMSQ+CWz/rUoap2u@lizhi-Precision-Tower-5810>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 14 Sep 2025 14:43:36 +0200
X-Gm-Features: Ac12FXxWimjpHL5bggBdXUjYa05b4pawK7VJrjWOHLmsBfbyANBkdNbMhZ52qqU
Message-ID: <CAKfTPtC8qm5XTpxj7BCG4MjKYHmFE4qRMdxdcm5X6jVCUpGOxg@mail.gmail.com>
Subject: Re: [PATCH 3/4] pcie: s32g: Add initial PCIe support (RC)
To: Frank Li <Frank.li@nxp.com>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Sept 2025 at 23:30, Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, Sep 12, 2025 at 04:14:35PM +0200, Vincent Guittot wrote:
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
> >  drivers/pci/controller/dwc/Kconfig         |  12 +
> >  drivers/pci/controller/dwc/Makefile        |   1 +
> >  drivers/pci/controller/dwc/pci-s32g-regs.h | 105 ++++
> >  drivers/pci/controller/dwc/pci-s32g.c      | 697 +++++++++++++++++++++
> >  drivers/pci/controller/dwc/pci-s32g.h      |  45 ++
>
> pcie-s32g.*, previous pci-* is wrong added.

Ok

>
> >  5 files changed, 860 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pci-s32g-regs.h
> >  create mode 100644 drivers/pci/controller/dwc/pci-s32g.c
> >  create mode 100644 drivers/pci/controller/dwc/pci-s32g.h
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index ff6b6d9e18ec..39d9a47f6fea 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -255,6 +255,18 @@ config PCIE_TEGRA194_EP
> >         in order to enable device-specific features PCIE_TEGRA194_EP must be
> >         selected. This uses the DesignWare core.
> >
> > +config PCI_S32G
> > +     bool "NXP S32G PCIe controller (host mode)"
> > +     depends on ARCH_S32 || (OF && COMPILE_TEST)
> > +     select PCIE_DW_HOST
> > +     help
> > +       Enable support for the PCIe controller in NXP S32G based boards to
> > +       work in Host mode. The controller is based on Designware IP and
> > +       can work either as RC or EP. In order to enable host-specific
> > +       features PCI_S32G must be selected and in order to enable
> > +       device-specific features PCI_S32G_EP must be selected.
> > +
> > +
> >  config PCIE_DW_PLAT
> >       bool
> >
> > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> > index 6919d27798d1..69f8e80fdae4 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -14,6 +14,7 @@ obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
> >  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
> >  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
> >  obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
> > +obj-$(CONFIG_PCI_S32G) += pci-s32g.o
> >  obj-$(CONFIG_PCIE_QCOM_COMMON) += pcie-qcom-common.o
> >  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
> >  obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o
> > diff --git a/drivers/pci/controller/dwc/pci-s32g-regs.h b/drivers/pci/controller/dwc/pci-s32g-regs.h
> > new file mode 100644
> > index 000000000000..e7ad1b6b7aa5
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pci-s32g-regs.h
> > @@ -0,0 +1,105 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2015-2016 Freescale Semiconductor, Inc.
> > + * Copyright 2016-2023, 2025 NXP
> > + */
> > +
> > +#ifndef PCI_S32G_REGS_H
> > +#define PCI_S32G_REGS_H
> > +
> > +/* Instance PCIE_SS - CTRL register offsets (ctrl base) */
> > +#define LINK_INT_CTRL_STS                    (0x40U)
> > +#define LINK_REQ_RST_NOT_INT_EN                      BIT(1)
> > +#define LINK_REQ_RST_NOT_CLR                 BIT(2)
> > +
> > +/* PCIe controller 0 general control 1 (PE0_GEN_CTRL_1) (ctrl base) */
> > +#define PE0_GEN_CTRL_1                               (0x50U)
> > +#define SS_DEVICE_TYPE_MASK                  GENMASK(3, 0)
> > +#define SS_DEVICE_TYPE(x)                    FIELD_PREP(SS_DEVICE_TYPE_MASK, x)
> > +
> > +enum pcie_dev_type_val {
> > +     PCIE_EP_VAL = 0x0,
> > +     PCIE_RC_VAL = 0x4
> > +};
> > +
> > +#define SRIS_MODE_EN                         BIT(8)
> > +
> > +/* PCIe controller 0 general control 3 (PE0_GEN_CTRL_3) (ctrl base) */
> > +#define PE0_GEN_CTRL_3                               (0x58U)
> > +/* LTSSM Enable. Active high. Set it low to hold the LTSSM in Detect state. */
> > +#define LTSSM_EN                             BIT(0)
> > +
> > +/* PCIe Controller 0 Link Debug 2 (ctrl base) */
> > +#define PCIE_SS_PE0_LINK_DBG_2                       (0xB4U)
> > +#define PCIE_SS_SMLH_LTSSM_STATE_MASK                GENMASK(5, 0)
> > +#define PCIE_SS_SMLH_LINK_UP                 BIT(6)
> > +#define PCIE_SS_RDLH_LINK_UP                 BIT(7)
> > +#define LTSSM_STATE_L0                               0x11U /* L0 state */
> > +#define LTSSM_STATE_L0S                              0x12U /* L0S state */
> > +#define LTSSM_STATE_L1_IDLE                  0x14U /* L1_IDLE state */
> > +#define LTSSM_STATE_HOT_RESET                        0x1FU /* HOT_RESET state */
>
> does common dw_pcie_get_ltssm() work for it, why need new macro for it.

We are not checking the same reg. I need to check why

>
> > +
> > +/* PCIe Controller 0  Interrupt Status (ctrl base) */
> > +#define PE0_INT_STS                          (0xE8U)
> > +#define HP_INT_STS                           BIT(6)
> > +
> > +/* Status and Command Register. pci-regs.h */
> > +
> > +/* Instance PCIE_CAP */
> > +#define PCIE_CAP_BASE                                (0x70U)
> > +
> > +/* Device Control and Status Register. */
> > +#define CAP_DEVICE_CONTROL_DEVICE_STATUS     (PCIE_CAP_BASE + PCI_EXP_DEVCTL)
>
> You use standard method to search PCI_EXP_DEVCTL instead of hardcode CAP_BASE
> to 70

Ok

>
> > +#define CAP_CORR_ERR_REPORT_EN                       BIT(0)
> > +#define CAP_NON_FATAL_ERR_REPORT_EN          BIT(1)
> > +#define CAP_FATAL_ERR_REPORT_EN                      BIT(2)
> > +#define CAP_UNSUPPORT_REQ_REP_EN             BIT(3)
> > +#define CAP_EN_REL_ORDER                     BIT(4)
> > +#define CAP_MAX_PAYLOAD_SIZE_CS_MASK         GENMASK(7, 5)
> > +#define CAP_MAX_PAYLOAD_SIZE_CS(x)           FIELD_PREP(CAP_MAX_PAYLOAD_SIZE_CS_MASK, x)
> > +#define CAP_MAX_READ_REQ_SIZE_MASK           GENMASK(14, 12)
> > +#define CAP_MAX_READ_REQ_SIZE(x)             FIELD_PREP(CAP_MAX_READ_REQ_SIZE_MASK, x)
> > +
> > +/* Link Control and Status Register. */
> > +#define PCIE_CTRL_LINK_STATUS                        (PCIE_CAP_BASE + PCI_EXP_LNKCTL)
> > +#define PCIE_CAP_RETRAIN_LINK                        BIT(5)
> > +#define PCIE_CAP_LINK_TRAINING                       BIT(27)
> > +
> > +/* Slot Control and Status Register */
> > +#define PCIE_SLOT_CONTROL_SLOT_STATUS                (PCIE_CAP_BASE + PCI_EXP_SLTCTL)
> > +#define PCIE_CAP_PRESENCE_DETECT_CHANGE_EN   BIT(3)
> > +#define PCIE_CAP_HOT_PLUG_INT_EN             BIT(5)
> > +#define PCIE_CAP_DLL_STATE_CHANGED_EN                BIT(12)
> > +
> > +/* Link Control 2 and Status 2 Register. */
> > +#define CAP_LINK_CONTROL2_LINK_STATUS2               (PCIE_CAP_BASE + PCI_EXP_LNKCTL2)
> > +#define PCIE_CAP_TARGET_LINK_SPEED_MASK              GENMASK(3, 0)
> > +#define PCIE_CAP_TARGET_LINK_SPEED(x)                FIELD_PREP(PCIE_CAP_TARGET_LINK_SPEED_MASK, x)
>
> I think these should be standard. if not, add S32_ prefix.

Ok

>
> > +
> > +/* Instance PCIE_PORT_LOGIC - DBI register offsets */
> > +#define PCIE_PORT_LOGIC_BASE                 (0x700U)
> > +
> > +/* Port Force Link Register. pcie-designware.h */
> > +
> > +/* Link Width and Speed Change Control Register. pcie-designware.h */
> > +
> > +/* Gen3 Control Register. pcie-designware.h */
> > +#define PCIE_EQ_PHASE_2_3                    BIT(9)
> > +
> > +/* Gen3 EQ Control Register. pcie-designware.h */
> > +
> > +/* ACE Cache Coherency Control Register 3 */
> > +#define PORT_LOGIC_COHERENCY_CONTROL_1               (PCIE_PORT_LOGIC_BASE + 0x1E0U)
> > +#define PORT_LOGIC_COHERENCY_CONTROL_2               (PCIE_PORT_LOGIC_BASE + 0x1E4U)
> > +#define PORT_LOGIC_COHERENCY_CONTROL_3               (PCIE_PORT_LOGIC_BASE + 0x1E8U)
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
> > diff --git a/drivers/pci/controller/dwc/pci-s32g.c b/drivers/pci/controller/dwc/pci-s32g.c
> > new file mode 100644
> > index 000000000000..3a7c2fc83432
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pci-s32g.c
> > @@ -0,0 +1,697 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCIe host controller driver for NXP S32G SoCs
> > + *
> > + * Copyright 2019-2025 NXP
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_address.h>
> > +#include <linux/pci.h>
> > +#include <linux/phy.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/io.h>
> > +#include <linux/sizes.h>
> > +
> > +#include "pcie-designware.h"
> > +#include "pci-s32g-regs.h"
> > +#include "pci-s32g.h"
> > +
> > +static void s32g_pcie_writel_ctrl(struct s32g_pcie *pci, u32 reg, u32 val)
> > +{
> > +     if (dw_pcie_write(pci->ctrl_base + reg, 0x4, val))
> > +             dev_err(pci->pcie.dev, "Write ctrl address failed\n");
> > +}
> > +
> > +static u32 s32g_pcie_readl_ctrl(struct s32g_pcie *pci, u32 reg)
> > +{
> > +     u32 val = 0;
> > +
> > +     if (dw_pcie_read(pci->ctrl_base + reg, 0x4, &val))
> > +             dev_err(pci->pcie.dev, "Read ctrl address failed\n");
> > +
> > +     return val;
> > +}
> > +
> > +static void s32g_pcie_enable_ltssm(struct s32g_pcie *pci)
> > +{
> > +     u32 reg;
> > +
> > +     reg = s32g_pcie_readl_ctrl(pci, PE0_GEN_CTRL_3);
> > +     reg |= LTSSM_EN;
> > +     s32g_pcie_writel_ctrl(pci, PE0_GEN_CTRL_3, reg);
> > +}
> > +
> > +static void s32g_pcie_disable_ltssm(struct s32g_pcie *pci)
> > +{
> > +     u32 reg;
> > +
> > +     reg = s32g_pcie_readl_ctrl(pci, PE0_GEN_CTRL_3);
> > +     reg &= ~LTSSM_EN;
> > +     s32g_pcie_writel_ctrl(pci, PE0_GEN_CTRL_3, reg);
> > +}
> > +
> > +static bool is_s32g_pcie_ltssm_enabled(struct s32g_pcie *pci)
> > +{
> > +     return (s32g_pcie_readl_ctrl(pci, PE0_GEN_CTRL_3) & LTSSM_EN);
> > +}
> > +
> > +#define PCIE_LINKUP  (PCIE_SS_SMLH_LINK_UP | PCIE_SS_RDLH_LINK_UP)
> > +
> > +static bool has_data_phy_link(struct s32g_pcie *s32g_pp)
> > +{
> > +     u32 val = s32g_pcie_readl_ctrl(s32g_pp, PCIE_SS_PE0_LINK_DBG_2);
> > +
> > +     if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
> > +             switch (val & PCIE_SS_SMLH_LTSSM_STATE_MASK) {
> > +             case LTSSM_STATE_L0:
> > +             case LTSSM_STATE_L0S:
> > +             case LTSSM_STATE_L1_IDLE:
> > +                     return true;
> > +             default:
> > +                     return false;
> > +             }
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static struct pci_bus *s32g_get_child_downstream_bus(struct pci_bus *bus)
> > +{
>
> what's this, why need it?
>
> > +     struct pci_bus *child, *root_bus = NULL;
> > +
> > +     list_for_each_entry(child, &bus->children, node) {
> > +             if (child->parent == bus) {
> > +                     root_bus = child;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     if (!root_bus)
> > +             return ERR_PTR(-ENODEV);
> > +
> > +     return root_bus;
> > +}
> > +
> > +static bool s32g_pcie_link_is_up(struct dw_pcie *pcie)
> > +{
> > +     struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pcie);
> > +
> > +     if (!is_s32g_pcie_ltssm_enabled(s32g_pp))
> > +             return 0;
>
> This function check if linkup, why enable ltssm here, suppose it should
> enable before call it.

it is also used by features not yet upstream, but I agree it's not
necessary there and i will check if it's really required for other
features. will remove for now

>
> > +
> > +     return has_data_phy_link(s32g_pp);
> > +}
> > +
> > +/* Use 200ms for PHY link timeout (slightly larger than 100ms, which PCIe standard requests
> > + * to wait "before sending a Configuration Request to the device")
> > + */
> > +#define PCIE_LINK_TIMEOUT_US         (200 * USEC_PER_MSEC)
>
> define SPEC's defined PCIE_LINK_TIMEOUT_US in pci.h.
>
> > +#define PCIE_LINK_WAIT_US            1000
> > +
> > +static int s32g_pcie_start_link(struct dw_pcie *pcie)
> > +{
> > +     struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pcie);
> > +     u32 reg, tmp;
> > +     int ret;
> > +
> > +     /* Don't do anything if not Root Complex */
> > +     if (!is_s32g_pcie_rc(s32g_pp->mode))
> > +             return 0;
> > +
> > +     if (pcie->max_link_speed >= 1 && pcie->max_link_speed < 3) {
> > +             /* Limit max link speed */
> > +             reg = dw_pcie_readl_dbi(pcie, CAP_LINK_CONTROL2_LINK_STATUS2);
> > +             reg &= ~(PCIE_CAP_TARGET_LINK_SPEED_MASK);
> > +             reg |= PCIE_CAP_TARGET_LINK_SPEED(pcie->max_link_speed);
> > +             dw_pcie_writel_dbi(pcie, CAP_LINK_CONTROL2_LINK_STATUS2, reg);
> > +
>
> use dw_pcie_wait_for_link();

ok

>
> > +             if (is_s32g_pcie_ltssm_enabled(s32g_pp)) {
> > +                     ret = read_poll_timeout(dw_pcie_readl_dbi, tmp,
> > +                                             !(tmp & PCIE_CAP_LINK_TRAINING),
> > +                                             PCIE_LINK_WAIT_US, PCIE_LINK_TIMEOUT_US, 0,
> > +                                             pcie, PCIE_CTRL_LINK_STATUS);
> > +                     if (ret)
> > +                             dev_warn(s32g_pp->pcie.dev,
> > +                                      "Failed to finalize link training\n");
> > +
> > +                     reg = dw_pcie_readl_dbi(pcie, PCIE_CTRL_LINK_STATUS);
> > +                     reg |= PCIE_CAP_RETRAIN_LINK;
> > +                     dw_pcie_writel_dbi(pcie, PCIE_CTRL_LINK_STATUS, reg);
> > +             }
> > +     }
> > +
> > +     /* Start LTSSM. */
> > +     s32g_pcie_enable_ltssm(s32g_pp);
> > +
> > +     return 0;
> > +}
> > +
> > +static void s32g_pcie_stop_link(struct dw_pcie *pcie)
> > +{
> > +     struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pcie);
> > +
> > +     s32g_pcie_disable_ltssm(s32g_pp);
> > +}
> > +
> > +struct dw_pcie_ops s32g_pcie_ops = {
> > +     .link_up = s32g_pcie_link_is_up,
> > +     .start_link = s32g_pcie_start_link,
> > +     .stop_link = s32g_pcie_stop_link,
> > +};
> > +
> > +static struct dw_pcie_host_ops s32g_pcie_host_ops;
> > +
> > +static void s32g_pcie_set_phy_mode(struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
> > +     struct device *dev = pcie->dev;
> > +     struct device_node *np = dev->of_node;
> > +     const char *pcie_phy_mode = NULL;
> > +     int ret;
> > +
> > +     ret = of_property_read_string(np, "nxp,phy-mode", &pcie_phy_mode);
> > +     if (ret || !pcie_phy_mode) {
> > +             dev_info(dev, "Missing 'nxp,phy-mode' property, using default CRNS\n");
> > +             s32g_pp->phy_mode = CRNS;
> > +     } else if (!strcmp(pcie_phy_mode, "crns")) {
> > +             s32g_pp->phy_mode = CRNS;
> > +     } else if (!strcmp(pcie_phy_mode, "crss")) {
> > +             s32g_pp->phy_mode = CRSS;
> > +     } else if (!strcmp(pcie_phy_mode, "srns")) {
> > +             s32g_pp->phy_mode = SRNS;
> > +     } else if (!strcmp(pcie_phy_mode, "sris")) {
> > +             s32g_pp->phy_mode = SRIS;
> > +     } else {
> > +             dev_warn(dev, "Unsupported 'nxp,phy-mode' specified, using default CRNS\n");
> > +             s32g_pp->phy_mode = CRNS;
> > +     }
>
> most likely it is ref clk property, not phy mode. You can check if there
> are standard clk property for it.

Ok I will

>
> > +}
> > +
> > +static void disable_equalization(struct dw_pcie *pcie)
> > +{
> > +     u32 val;
> > +
> > +     val = dw_pcie_readl_dbi(pcie, GEN3_EQ_CONTROL_OFF);
> > +     val &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
> > +              GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
> > +     val |= FIELD_PREP(GEN3_EQ_CONTROL_OFF_FB_MODE, 1) |
> > +            FIELD_PREP(GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC, 0x84);
> > +     dw_pcie_dbi_ro_wr_en(pcie);
> > +     dw_pcie_writel_dbi(pcie, GEN3_EQ_CONTROL_OFF, val);
> > +     dw_pcie_dbi_ro_wr_dis(pcie);
> > +}
> > +
> > +static void s32g_pcie_reset_mstr_ace(struct dw_pcie *pcie, u64 ddr_base_addr)
> > +{
> > +     u32 ddr_base_low = lower_32_bits(ddr_base_addr);
> > +     u32 ddr_base_high = upper_32_bits(ddr_base_addr);
> > +
> > +     dw_pcie_dbi_ro_wr_en(pcie);
> > +     dw_pcie_writel_dbi(pcie, PORT_LOGIC_COHERENCY_CONTROL_3, 0x0);
> > +     /* Transactions to peripheral targets should be non-coherent,
> > +      * or Ncore might drop them. Define the start of DDR as seen by Linux
> > +      * as the boundary between "memory" and "peripherals", with peripherals
> > +      * being below this boundary, and memory addresses being above it.
> > +      * One example where this is needed are PCIe MSIs, which use NoSnoop=0
> > +      * and might end up routed to Ncore.
> > +      */
> > +     dw_pcie_writel_dbi(pcie, PORT_LOGIC_COHERENCY_CONTROL_1,
> > +                        (ddr_base_low & CC_1_MEMTYPE_BOUNDARY_MASK) |
> > +                        (CC_1_MEMTYPE_LOWER_PERIPH & CC_1_MEMTYPE_VALUE));
> > +     dw_pcie_writel_dbi(pcie, PORT_LOGIC_COHERENCY_CONTROL_2, ddr_base_high);
> > +     dw_pcie_dbi_ro_wr_dis(pcie);
> > +}
> > +
> > +static int init_pcie(struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
> > +     u32 val;
> > +
> > +     val = s32g_pcie_readl_ctrl(s32g_pp, PE0_GEN_CTRL_1);
> > +     val &= ~SS_DEVICE_TYPE_MASK;
> > +
> > +     if (is_s32g_pcie_rc(s32g_pp->mode))
> > +             val |= SS_DEVICE_TYPE(PCIE_RC_VAL);
> > +     else
> > +             val |= SS_DEVICE_TYPE(PCIE_EP_VAL);
> > +
> > +     if (s32g_pp->phy_mode == SRIS)
> > +             val |= SRIS_MODE_EN;
> > +     else
> > +             val &= ~SRIS_MODE_EN;
> > +
> > +     s32g_pcie_writel_ctrl(s32g_pp, PE0_GEN_CTRL_1, val);
> > +
> > +     /* Disable phase 2,3 equalization */
> > +     disable_equalization(pcie);
> > +
> > +     /* Make sure DBI registers are R/W - see dw_pcie_setup_rc */
> > +     dw_pcie_dbi_ro_wr_en(pcie);
> > +     dw_pcie_setup(pcie);
> > +     dw_pcie_dbi_ro_wr_dis(pcie);
> > +
> > +     /* Make sure we use the coherency defaults (just in case the settings
> > +      * have been changed from their reset values
> > +      */
> > +     s32g_pcie_reset_mstr_ace(pcie, s32g_pp->coherency_base);
> > +
> > +     val = dw_pcie_readl_dbi(pcie, PCIE_PORT_FORCE);
> > +     val |= PORT_FORCE_DO_DESKEW_FOR_SRIS;
> > +     dw_pcie_dbi_ro_wr_en(pcie);
> > +     dw_pcie_writel_dbi(pcie, PCIE_PORT_FORCE, val);
> > +
> > +     if (is_s32g_pcie_rc(s32g_pp->mode)) {
> > +             /* Set max payload supported, 256 bytes and
> > +              * relaxed ordering.
> > +              */
> > +             val = dw_pcie_readl_dbi(pcie, CAP_DEVICE_CONTROL_DEVICE_STATUS);
> > +             val &= ~(CAP_EN_REL_ORDER |
> > +                      CAP_MAX_PAYLOAD_SIZE_CS_MASK |
> > +                      CAP_MAX_READ_REQ_SIZE_MASK);
> > +             val |= CAP_EN_REL_ORDER |
> > +                    CAP_MAX_PAYLOAD_SIZE_CS(1) |
> > +                    CAP_MAX_READ_REQ_SIZE(1);
> > +             dw_pcie_writel_dbi(pcie, CAP_DEVICE_CONTROL_DEVICE_STATUS, val);
> > +
> > +             /* Enable the IO space, Memory space, Bus master,
> > +              * Parity error, Serr and disable INTx generation
> > +              */
> > +             dw_pcie_writel_dbi(pcie, PCI_COMMAND,
> > +                                PCI_COMMAND_SERR | PCI_COMMAND_PARITY |
> > +                                PCI_COMMAND_INTX_DISABLE | PCI_COMMAND_IO |
> > +                                PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> > +
> > +             /* Enable errors */
> > +             val = dw_pcie_readl_dbi(pcie, CAP_DEVICE_CONTROL_DEVICE_STATUS);
> > +             val |= CAP_CORR_ERR_REPORT_EN |
> > +                    CAP_NON_FATAL_ERR_REPORT_EN |
> > +                    CAP_FATAL_ERR_REPORT_EN |
> > +                    CAP_UNSUPPORT_REQ_REP_EN;
> > +             dw_pcie_writel_dbi(pcie, CAP_DEVICE_CONTROL_DEVICE_STATUS, val);
> > +     }
> > +
> > +     val = dw_pcie_readl_dbi(pcie, GEN3_RELATED_OFF);
> > +     val |= PCIE_EQ_PHASE_2_3;
> > +     dw_pcie_writel_dbi(pcie, GEN3_RELATED_OFF, val);
> > +
> > +     /* Disable writing dbi registers */
> > +     dw_pcie_dbi_ro_wr_dis(pcie);
> > +
> > +     s32g_pcie_enable_ltssm(s32g_pp);
> > +
> > +     return 0;
> > +}
> > +
> > +static int init_pcie_phy(struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
> > +     struct device *dev = pcie->dev;
> > +     int ret;
> > +
> > +     ret = phy_init(s32g_pp->phy);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to init serdes PHY\n");
> > +             return ret;
> > +     }
> > +
> > +     ret = phy_set_mode_ext(s32g_pp->phy, PHY_MODE_PCIE,
> > +                            s32g_pp->phy_mode);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to set mode on serdes PHY\n");
> > +             goto err_phy_exit;
> > +     }
> > +
> > +     ret = phy_power_on(s32g_pp->phy);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to power on serdes PHY\n");
> > +             goto err_phy_exit;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_phy_exit:
> > +     phy_exit(s32g_pp->phy);
> > +     return ret;
> > +}
> > +
> > +static int deinit_pcie_phy(struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
> > +     struct device *dev = pcie->dev;
> > +     int ret;
> > +
> > +     if (s32g_pp->phy) {
> > +             ret = phy_power_off(s32g_pp->phy);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to power off serdes PHY\n");
> > +                     return ret;
> > +             }
> > +
> > +             ret = phy_exit(s32g_pp->phy);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to exit serdes PHY\n");
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int wait_phy_data_link(struct s32g_pcie *s32g_pp)
> > +{
> > +     bool has_link;
> > +     int ret;
> > +
> > +     ret = read_poll_timeout(has_data_phy_link, has_link, has_link,
> > +                             PCIE_LINK_WAIT_US, PCIE_LINK_TIMEOUT_US, 0, s32g_pp);
> > +     if (ret)
> > +             dev_info(s32g_pp->pcie.dev, "Failed to stabilize PHY link\n");
> > +
> > +     return ret;
> > +}
> > +
> > +static void s32g_pcie_downstream_dev_to_D0(struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
> > +     struct dw_pcie_rp *pp = &pcie->pp;
> > +     struct pci_bus *root_bus = NULL;
> > +     struct pci_dev *pdev;
> > +
> > +     /* Check if we did manage to initialize the host */
> > +     if (!pp->bridge || !pp->bridge->bus)
> > +             return;
> > +
> > +     /*
> > +      * link doesn't go into L2 state with some of the EndPoints
> > +      * if they are not in D0 state. So, we need to make sure that immediate
> > +      * downstream devices are in D0 state before sending PME_TurnOff to put
> > +      * link into L2 state.
> > +      */
> > +
> > +     root_bus = s32g_get_child_downstream_bus(pp->bridge->bus);
> > +     if (IS_ERR(root_bus)) {
> > +             dev_err(pcie->dev, "Failed to find downstream devices\n");
> > +             return;
> > +     }
> > +
> > +     list_for_each_entry(pdev, &root_bus->devices, bus_list) {
> > +             if (PCI_SLOT(pdev->devfn) == 0) {
> > +                     if (pci_set_power_state(pdev, PCI_D0))
> > +                             dev_err(pcie->dev,
> > +                                     "Failed to transition %s to D0 state\n",
> > +                                     dev_name(&pdev->dev));
> > +             }
> > +     }
> > +}
> > +
> > +static u64 s32g_get_coherency_boundary(struct device *dev)
> > +{
> > +     struct device_node *np;
> > +     struct resource res;
> > +
> > +     np = of_find_node_by_type(NULL, "memory");
> > +
> > +     if (of_address_to_resource(np, 0, &res)) {
> > +             dev_warn(dev, "Fail to get coherency boundary\n");
> > +             return 0;
> > +     }
> > +
> > +     return res.start;
> > +}
> > +
> > +static int s32g_pcie_init_common(struct platform_device *pdev,
> > +                              struct s32g_pcie *s32g_pp,
> > +                              const struct s32g_pcie_data *data)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
> > +     struct phy *phy;
> > +
> > +     pcie->dev = dev;
> > +     pcie->ops = &s32g_pcie_ops;
> > +
> > +     s32g_pp->mode = data->mode;
> > +
> > +     platform_set_drvdata(pdev, s32g_pp);
> > +
> > +     phy = devm_phy_get(dev, NULL);
> > +     if (IS_ERR(phy))
> > +             return dev_err_probe(dev, PTR_ERR(phy),
> > +                             "Failed to get serdes PHY\n");
> > +     s32g_pp->phy = phy;
> > +
> > +     s32g_pcie_set_phy_mode(s32g_pp);
> > +
> > +     pcie->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
> > +     if (IS_ERR(pcie->dbi_base))
> > +             return PTR_ERR(pcie->dbi_base);
> > +
> > +     pcie->dbi_base2 = devm_platform_ioremap_resource_byname(pdev, "dbi2");
> > +     if (IS_ERR(pcie->dbi_base2))
> > +             return PTR_ERR(pcie->dbi_base2);
> > +
> > +     pcie->atu_base = devm_platform_ioremap_resource_byname(pdev, "atu");
> > +     if (IS_ERR(pcie->atu_base))
> > +             return PTR_ERR(pcie->atu_base);
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
> > +static int s32g_pcie_init_host(struct platform_device *pdev,
> > +                            struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
> > +     struct dw_pcie_rp *pp = &pcie->pp;
> > +
> > +     /* Set dw host ops */
> > +     pp->ops = &s32g_pcie_host_ops;
> > +
> > +     return 0;
> > +}
> > +
> > +static int s32g_pcie_config_common(struct device *dev,
> > +                                struct s32g_pcie *s32g_pp)
> > +{
> > +     int ret = 0;
> > +
> > +     s32g_pcie_disable_ltssm(s32g_pp);
> > +
> > +     ret = init_pcie_phy(s32g_pp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = init_pcie(s32g_pp);
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
> > +static void s32g_pcie_deconfig_common(struct s32g_pcie *s32g_pp)
> > +{
> > +     s32g_pcie_disable_ltssm(s32g_pp);
> > +     deinit_pcie_phy(s32g_pp);
> > +}
> > +
> > +static int s32g_pcie_config_host(struct device *dev,
> > +                              struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
> > +     struct dw_pcie_rp *pp = &pcie->pp;
> > +     int ret = 0;
> > +
> > +     ret = wait_phy_data_link(s32g_pp);
> > +     if ((ret) && (!phy_validate(s32g_pp->phy, PHY_MODE_PCIE, 0, NULL))) {
> > +             dev_err(pcie->dev, "Failed to get link up with EP connected\n");
> > +             goto err_host_deinit;
> > +     }
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
> > +     const struct s32g_pcie_data *data;
> > +     int ret = 0;
> > +
> > +     data = of_device_get_match_data(dev);
> > +     if (!data)
> > +             return -EINVAL;
>
> Needn't check it now. never happen.

ok

>
> > +
> > +     s32g_pp = devm_kzalloc(dev, sizeof(*s32g_pp), GFP_KERNEL);
> > +     if (!s32g_pp)
> > +             return -ENOMEM;
> > +
> > +     ret = s32g_pcie_init_common(pdev, s32g_pp, data);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = s32g_pcie_init_host(pdev, s32g_pp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     pm_runtime_enable(dev);
>
> devm_pm_runtime_enable()

yes

>
> > +     ret = pm_runtime_get_sync(dev);
> > +     if (ret < 0)
> > +             goto err_pm_runtime_put;
> > +
> > +     ret = s32g_pcie_config_common(dev, s32g_pp);
> > +     if (ret)
> > +             goto err_pm_runtime_put;
> > +
> > +     ret = s32g_pcie_config_host(dev, s32g_pp);
> > +     if (ret)
> > +             goto err_deinit_controller;
> > +
> > +     return 0;
> > +
> > +err_deinit_controller:
> > +     s32g_pcie_deconfig_common(s32g_pp);
> > +err_pm_runtime_put:
> > +     pm_runtime_put(dev);
> > +     pm_runtime_disable(dev);
> > +
> > +     return ret;
> > +}
> > +
> > +static void s32g_pcie_shutdown(struct platform_device *pdev)
> > +{
> > +     pm_runtime_put(&pdev->dev);
> > +     pm_runtime_disable(&pdev->dev);
> > +}
> > +
> > +static int s32g_pcie_suspend(struct device *dev)
> > +{
> > +     struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
> > +     struct dw_pcie_rp *pp = &pcie->pp;
> > +     struct pci_bus *bus, *root_bus;
> > +
> > +     /* Save MSI interrupt vector */
> > +     s32g_pp->msi_ctrl_int = dw_pcie_readl_dbi(pcie,
> > +                                               PCIE_MSI_INTR0_ENABLE);
> > +
> > +     if (is_s32g_pcie_rc(s32g_pp->mode)) {
> > +             s32g_pcie_downstream_dev_to_D0(s32g_pp);
> > +
> > +             bus = pp->bridge->bus;
> > +             root_bus = s32g_get_child_downstream_bus(bus);
> > +             if (!IS_ERR(root_bus))
> > +                     pci_walk_bus(root_bus, pci_dev_set_disconnected, NULL);
> > +
> > +             pci_stop_root_bus(bus);
> > +             pci_remove_root_bus(bus);
> > +     }
> > +
> > +     s32g_pcie_deconfig_common(s32g_pp);
> > +
> > +     return 0;
> > +}
> > +
> > +static int s32g_pcie_resume(struct device *dev)
>
> does common dw_pcie_resume_noirq()/dw_pcie_suspend_noirq() work for you?

I will check


>
> > +{
> > +     struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> > +     struct dw_pcie *pcie = &s32g_pp->pcie;
> > +     struct dw_pcie_rp *pp = &pcie->pp;
> > +     int ret = 0;
> > +
> > +     ret = s32g_pcie_config_common(dev, s32g_pp);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (is_s32g_pcie_rc(s32g_pp->mode)) {
> > +             ret = dw_pcie_setup_rc(pp);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to resume DW RC: %d\n", ret);
> > +                     goto fail_host_init;
> > +             }
> > +
> > +             ret = dw_pcie_start_link(pcie);
> > +             if (ret) {
> > +                     /* We do not exit with error if link up was unsuccessful
> > +                      * EndPoint may not be connected.
> > +                      */
> > +                     if (dw_pcie_wait_for_link(pcie))
> > +                             dev_warn(pcie->dev,
> > +                                      "Link Up failed, EndPoint may not be connected\n");
> > +
> > +                     if (!phy_validate(s32g_pp->phy, PHY_MODE_PCIE, 0, NULL)) {
> > +                             dev_err(dev, "Failed to get link up with EP connected\n");
> > +                             goto fail_host_init;
> > +                     }
> > +             }
> > +
> > +             ret = pci_host_probe(pp->bridge);
> > +             if (ret)
> > +                     goto fail_host_init;
> > +     }
> > +
> > +     /* Restore MSI interrupt vector */
> > +     dw_pcie_writel_dbi(pcie, PCIE_MSI_INTR0_ENABLE,
> > +                        s32g_pp->msi_ctrl_int);
> > +
> > +     return 0;
> > +
> > +fail_host_init:
> > +     s32g_pcie_deconfig_common(s32g_pp);
> > +     return ret;
> > +}
> > +
> > +static const struct dev_pm_ops s32g_pcie_pm_ops = {
> > +     SYSTEM_SLEEP_PM_OPS(s32g_pcie_suspend,
> > +                         s32g_pcie_resume)
> > +};
> > +
> > +static const struct s32g_pcie_data rc_of_data = {
> > +     .mode = DW_PCIE_RC_TYPE,
> > +};
> > +
> > +static const struct of_device_id s32g_pcie_of_match[] = {
> > +     { .compatible = "nxp,s32g2-pcie", .data = &rc_of_data },
> > +     { /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, s32g_pcie_of_match);
> > +
> > +static struct platform_driver s32g_pcie_driver = {
> > +     .driver = {
> > +             .name   = "s32g-pcie",
> > +             .owner  = THIS_MODULE,
> > +             .of_match_table = s32g_pcie_of_match,
> > +             .pm = pm_sleep_ptr(&s32g_pcie_pm_ops),
> > +     },
> > +     .probe = s32g_pcie_probe,
> > +     .shutdown = s32g_pcie_shutdown,
> > +};
> > +
> > +module_platform_driver(s32g_pcie_driver);
> > +
> > +MODULE_AUTHOR("Ionut Vicovan <Ionut.Vicovan@nxp.com>");
> > +MODULE_DESCRIPTION("NXP S32G PCIe Host controller driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/pci/controller/dwc/pci-s32g.h b/drivers/pci/controller/dwc/pci-s32g.h
> > new file mode 100644
> > index 000000000000..cdd0c635cc72
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pci-s32g.h
> > @@ -0,0 +1,45 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * PCIe host controller driver for NXP S32G SoCs
> > + *
> > + * Copyright 2019-2025 NXP
> > + */
> > +
> > +#ifndef PCIE_S32G_H
> > +#define PCIE_S32G_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/pcie/nxp-s32g-pcie-phy-submode.h>
> > +
> > +#define to_s32g_from_dw_pcie(x) \
> > +     container_of(x, struct s32g_pcie, pcie)
> > +
> > +struct s32g_pcie_data {
> > +     enum dw_pcie_device_mode mode;
> > +};
> > +
> > +struct s32g_pcie {
> > +     struct dw_pcie  pcie;
> > +
> > +     u32 msi_ctrl_int;
> > +
> > +     /* we have cfg in struct dw_pcie_rp and
> > +      * dbi in struct dw_pcie, so define only ctrl here
> > +      */
> > +     void __iomem *ctrl_base;
> > +     u64 coherency_base;
> > +
> > +     enum dw_pcie_device_mode mode;
> > +
> > +     enum pcie_phy_mode phy_mode;
> > +
> > +     struct phy *phy;
> > +};
> > +
> > +static inline
> > +bool is_s32g_pcie_rc(enum dw_pcie_device_mode mode)
> > +{
> > +     return mode == DW_PCIE_RC_TYPE;
> > +}
> > +
> > +#endif       /*      PCIE_S32G_H     */
>
> unnecessary for seperte file now. You can put to c file.
>
> Frank
> > --
> > 2.43.0
> >

