Return-Path: <linux-pci+bounces-37214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 619F2BAA022
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 18:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012D03BE263
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 16:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2784830C11F;
	Mon, 29 Sep 2025 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t4IDz+eP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47130B508
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163002; cv=none; b=gDtwI5yrOhOp1Kl7uq1M/0K6EcRSBFqjRDLop0tSma4cZsFU9jaeU5aBVipvstlGxlWjczg5lIzBUHm8Iop4+oYEZQO3BkBE1wEcxbbQ+23yX5TAvde5Ky895znl01pqAsf2/CLlDY9tl6GSGxZp6YZ3g6QJ3OwXe58e76iGrMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163002; c=relaxed/simple;
	bh=lm9i8y7Ti1H6l0SiJXFDsZCS8BN+fGL4O3uSzyhpnWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pV8KQAHqcSjne7V9W2d3oh7OtriFqMcYwj/pafP/TyLBuW4nOJNuG1NutKB7B4VmKAGBUjClvpqpQ/F9zjkbHcPD1qwlE+J8/zV1NT8Oy+9Eiqh59RPCURNI1BZduQznpP0czj61F5jLuDtkqzxDJxIyp++pRHc+08a2WU4ReiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t4IDz+eP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso10032365a12.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 09:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759162997; x=1759767797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YQoxCqYRFr1IPODxO3ePMy5XMnd34Oj4csnrBa794A=;
        b=t4IDz+ePFOjOtVIMe8kAKH+hK5IY5kSq+urX5QCKekl+1j4MQGd2y+MC8TPTOUAGjy
         eAjrr0/rO+7B9aoBcsbi5YnsHnuu+yBGCpyqKDb0c9mQ3NlOVkxbO3WN5IB3VJ8hzrf8
         izQ4fKm0ttviarRYKe1HaoPxzX+YwpAto/18a7BCLWNhg2yNFJIIH9U6GCC3Ghl3ppVP
         KZoGveWfi4Eu21mml42NFcatSyElBMidBc2AyRhmcjNGkPZ7HTZKgYufJgkC2jwsFdSU
         hunQYgk5VNR4KKPe5Qgx6wH04xNsbk5IITnWw0j31BfhFFoI06l9UAc+0AamC78hxG17
         qaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759162997; x=1759767797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YQoxCqYRFr1IPODxO3ePMy5XMnd34Oj4csnrBa794A=;
        b=GFylm3cvoRwpIopbGUQilPY3TPpxXmlcWXdLFzmMbQ+Bq5rPTWP0KcA9mWPl+3QAr1
         gVyUlRsetZvpB1dxt7woHjR0RKpyAKBsItpp7yphCmlMYvjz/u8RfadRGyBtW9xFnMtp
         FqvVcpmTGYmbu8v7lbqvZFgVFiMkIWZ8AZQSdZ0MO9R7I6MhGBDl3tyvbS3to7PpYbnb
         xNtkvCM23qjmpzTBDQQhmeAnvrWUqRalIrdqUycmLl7oEZNKs7IHMGidEpl1AMBZ88Oq
         trHkC/P7GYQlkJhkK6xxgEz9IWoqzJj4G5CPC2p6z0nCGB7CgaEjpBRMVSzc8qiXgx4I
         h8vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlfCAWidfhMgLBpT/ejkNG+yfKxgF68OW/TpidYd6w1LeN0qMblK4kGNxuxC0Xzn3rsUmjkxdkCRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmMtXPNdyHa0n3BePpI6rFalA85y2M2ajI0nE2rPW9SBk2np+q
	9oaf/9k77/qLMhQB9knQ9HspSVzs89ndjcQLGPDUcpeTSvybCJz0WjFhMkMXpu72lQAh0QrCK/G
	7aPEsJa+iYbD59nrDIvrKi4phQYdpvxexMTTZfBnUUg==
X-Gm-Gg: ASbGnctwwzAkE6JW7xm76F4eao5oWoITAu8BOnfrBYS5mOQkwqnHunBD2jbA/d6e/do
	iMSvBZFWBqj5r9EobaSl4KyRTuAcNTAc3ctWaKG1jmv1pgDMlI39BO2zCYhdRWd06Tit4Flz/Ln
	IqzGrV33OA4tVlJMk5UBJfJOJRL18X+yAQAUXZHKQiUcGRX43oe6EGpsJQs6SksGyH4cMBkJds2
	3TvAt5TFQbJ2ekke8bVIF9SWgNLzA0DedwK9Fblxtfufoo=
X-Google-Smtp-Source: AGHT+IEQD1BpgSF0z/c/mJJwi8cnJHWjQYFs7yuK6+w9PPbW1p70qiX8XqOv4IL6RqByzwe1yUK1NZrqO2adewR/gmE=
X-Received: by 2002:aa7:c88f:0:b0:631:b058:bef0 with SMTP id
 4fb4d7f45d1cf-6349faa0ceamr11349916a12.32.1759162996913; Mon, 29 Sep 2025
 09:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-3-vincent.guittot@linaro.org> <4ee5tqdjv5ogcdtysiebtoxmrvrzhkar4bjcsqi47dxtgwac4c@rezn4waubroh>
 <CAKfTPtAEkegCV-9_x-dXSWQFOoG6kO5JbJq_LToY9YuuRusoVA@mail.gmail.com> <lmczw5agheqbcl6xcomlhf7yfbdvfx45pozmaxjmbkkqudsxlu@c7u6s5h4xm6j>
In-Reply-To: <lmczw5agheqbcl6xcomlhf7yfbdvfx45pozmaxjmbkkqudsxlu@c7u6s5h4xm6j>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 29 Sep 2025 18:23:05 +0200
X-Gm-Features: AS18NWDZOxPs7jB1-W-zDx-gh2UpfgrmkNJD8zYQ6wJpdnMNmLjoT0rjb-_sqWM
Message-ID: <CAKfTPtCacFhJztYvWycSdoWMUStaf1WAcGJKHwk3y4n-uEELSw@mail.gmail.com>
Subject: Re: [PATCH 2/3 v2] PCI: s32g: Add initial PCIe support (RC)
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, 
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com, 
	bogdan.hamciuc@nxp.com, Frank.li@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Sept 2025 at 15:57, Manivannan Sadhasivam <mani@kernel.org> wrot=
e:
>
> On Thu, Sep 25, 2025 at 06:52:57PM +0200, Vincent Guittot wrote:
> > On Mon, 22 Sept 2025 at 09:56, Manivannan Sadhasivam <mani@kernel.org> =
wrote:
> > >
> > > On Fri, Sep 19, 2025 at 05:58:20PM +0200, Vincent Guittot wrote:
> > > > Add initial support of the PCIe controller for S32G Soc family. Onl=
y
> > > > host mode is supported.
> > > >
> > > > Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > > > Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > > > Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.co=
m>
> > > > Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > > > Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > > > Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > > > Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> > > > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/Kconfig           |  11 +
> > > >  drivers/pci/controller/dwc/Makefile          |   1 +
> > > >  drivers/pci/controller/dwc/pcie-designware.h |   1 +
> > > >  drivers/pci/controller/dwc/pcie-s32g-regs.h  |  61 ++
> > > >  drivers/pci/controller/dwc/pcie-s32g.c       | 578 +++++++++++++++=
++++
> > > >  5 files changed, 652 insertions(+)
> > > >  create mode 100644 drivers/pci/controller/dwc/pcie-s32g-regs.h
> > > >  create mode 100644 drivers/pci/controller/dwc/pcie-s32g.c
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/contr=
oller/dwc/Kconfig
> > > > index ff6b6d9e18ec..d7cee915aedd 100644
> > > > --- a/drivers/pci/controller/dwc/Kconfig
> > > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > > @@ -255,6 +255,17 @@ config PCIE_TEGRA194_EP
> > > >         in order to enable device-specific features PCIE_TEGRA194_E=
P must be
> > > >         selected. This uses the DesignWare core.
> > > >
> > > > +config PCIE_S32G
> > >
> > > PCIE_NXP_S32G?
> >
> > I don't have a  strong opinion on this. I have followed what was done
> > for other PCIE drivers which only use soc family as well like
> > PCI_IMX6_HOST
> > PCIE_KIRIN
> > PCIE_ARMADA_8K
> > PCIE_TEGRA194_HOST
> > PCIE_RCAR_GEN4
> > PCIE_SPEAR13XX
> >
>
> I'd prefer to have vendor prefix to avoid collisions. Especially if the p=
roduct
> name is something like S32G, which is not 'unique'.
>
> > >
> > > > +     bool "NXP S32G PCIe controller (host mode)"
> > > > +     depends on ARCH_S32 || (OF && COMPILE_TEST)
> > > > +     select PCIE_DW_HOST
> > > > +     help
> > > > +       Enable support for the PCIe controller in NXP S32G based bo=
ards to
> > > > +       work in Host mode. The controller is based on DesignWare IP=
 and
> > > > +       can work either as RC or EP. In order to enable host-specif=
ic
> > > > +       features PCIE_S32G must be selected.
> > > > +
> > > > +
> > > >  config PCIE_DW_PLAT
> > > >       bool
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/cont=
roller/dwc/Makefile
> > > > index 6919d27798d1..47fbedd57747 100644
> > > > --- a/drivers/pci/controller/dwc/Makefile
> > > > +++ b/drivers/pci/controller/dwc/Makefile
> > > > @@ -14,6 +14,7 @@ obj-$(CONFIG_PCIE_SPEAR13XX) +=3D pcie-spear13xx.=
o
> > > >  obj-$(CONFIG_PCI_KEYSTONE) +=3D pci-keystone.o
> > > >  obj-$(CONFIG_PCI_LAYERSCAPE) +=3D pci-layerscape.o
> > > >  obj-$(CONFIG_PCI_LAYERSCAPE_EP) +=3D pci-layerscape-ep.o
> > > > +obj-$(CONFIG_PCIE_S32G) +=3D pcie-s32g.o
> > >
> > > pcie-nxp-s32g?
> >
> > Same as Kconfig, other drivers only use the SoC family.
> >
> > >
> > > >  obj-$(CONFIG_PCIE_QCOM_COMMON) +=3D pcie-qcom-common.o
> > > >  obj-$(CONFIG_PCIE_QCOM) +=3D pcie-qcom.o
> > > >  obj-$(CONFIG_PCIE_QCOM_EP) +=3D pcie-qcom-ep.o
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers=
/pci/controller/dwc/pcie-designware.h
> > > > index 00f52d472dcd..2aec011a9dd4 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -119,6 +119,7 @@
> > > >
> > > >  #define GEN3_RELATED_OFF                     0x890
> > > >  #define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL BIT(0)
> > > > +#define GEN3_RELATED_OFF_EQ_PHASE_2_3                BIT(9)
> > > >  #define GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS  BIT(13)
> > > >  #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE     BIT(16)
> > > >  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT       24
> > > > diff --git a/drivers/pci/controller/dwc/pcie-s32g-regs.h b/drivers/=
pci/controller/dwc/pcie-s32g-regs.h
> > > > new file mode 100644
> > > > index 000000000000..674ea47a525f
> > > > --- /dev/null
> > > > +++ b/drivers/pci/controller/dwc/pcie-s32g-regs.h
> > > > @@ -0,0 +1,61 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > > > +/*
> > > > + * Copyright 2015-2016 Freescale Semiconductor, Inc.
> > > > + * Copyright 2016-2023, 2025 NXP
> > > > + */
> > > > +
> > > > +#ifndef PCIE_S32G_REGS_H
> > > > +#define PCIE_S32G_REGS_H
> > > > +
> > > > +/* Instance PCIE_SS - CTRL register offsets (ctrl base) */
> > > > +#define LINK_INT_CTRL_STS                    0x40
> > >
> > > Use PCIE_S32G prefix for vendor specific registers.
> >
> > Okay
> >
> > >
> > > > +#define LINK_REQ_RST_NOT_INT_EN                      BIT(1)
> > > > +#define LINK_REQ_RST_NOT_CLR                 BIT(2)
> > > > +
> > > > +/* PCIe controller 0 general control 1 (ctrl base) */
> > > > +#define PE0_GEN_CTRL_1                               0x50
> > > > +#define SS_DEVICE_TYPE_MASK                  GENMASK(3, 0)
> > > > +#define SS_DEVICE_TYPE(x)                    FIELD_PREP(SS_DEVICE_=
TYPE_MASK, x)
> > > > +#define SRIS_MODE_EN                         BIT(8)
> > > > +
> > > > +/* PCIe controller 0 general control 3 (ctrl base) */
> > > > +#define PE0_GEN_CTRL_3                               0x58
> > > > +/* LTSSM Enable. Active high. Set it low to hold the LTSSM in Dete=
ct state. */
> > > > +#define LTSSM_EN                             BIT(0)
> > > > +
> > > > +/* PCIe Controller 0 Link Debug 2 (ctrl base) */
> > > > +#define PCIE_SS_PE0_LINK_DBG_2                       0xB4
> > > > +#define PCIE_SS_SMLH_LTSSM_STATE_MASK                GENMASK(5, 0)
> > > > +#define PCIE_SS_SMLH_LINK_UP                 BIT(6)
> > > > +#define PCIE_SS_RDLH_LINK_UP                 BIT(7)
> > > > +#define LTSSM_STATE_L0                               0x11U /* L0 s=
tate */
> > > > +#define LTSSM_STATE_L0S                              0x12U /* L0S =
state */
> > > > +#define LTSSM_STATE_L1_IDLE                  0x14U /* L1_IDLE stat=
e */
> > > > +#define LTSSM_STATE_HOT_RESET                        0x1FU /* HOT_=
RESET state */
> > > > +
> > > > +/* PCIe Controller 0  Interrupt Status (ctrl base) */
> > > > +#define PE0_INT_STS                          0xE8
> > > > +#define HP_INT_STS                           BIT(6)
> > > > +
> > > > +/* Link Control and Status Register. (PCI_EXP_LNKCTL in pci-regs.h=
) */
> > > > +#define PCIE_CAP_LINK_TRAINING                       BIT(27)
> > > > +
> > > > +/* Instance PCIE_PORT_LOGIC - DBI register offsets */
> > > > +#define PCIE_PORT_LOGIC_BASE                 0x700
> > > > +
> > > > +/* ACE Cache Coherency Control Register 3 */
> > > > +#define PORT_LOGIC_COHERENCY_CONTROL_1               (PCIE_PORT_LO=
GIC_BASE + 0x1E0)
> > > > +#define PORT_LOGIC_COHERENCY_CONTROL_2               (PCIE_PORT_LO=
GIC_BASE + 0x1E4)
> > > > +#define PORT_LOGIC_COHERENCY_CONTROL_3               (PCIE_PORT_LO=
GIC_BASE + 0x1E8)
> > > > +
> > > > +/*
> > > > + * See definition of register "ACE Cache Coherency Control Registe=
r 1"
> > > > + * (COHERENCY_CONTROL_1_OFF) in the SoC RM
> > > > + */
> > > > +#define CC_1_MEMTYPE_BOUNDARY_MASK           GENMASK(31, 2)
> > > > +#define CC_1_MEMTYPE_BOUNDARY(x)             FIELD_PREP(CC_1_MEMTY=
PE_BOUNDARY_MASK, x)
> > > > +#define CC_1_MEMTYPE_VALUE                   BIT(0)
> > > > +#define CC_1_MEMTYPE_LOWER_PERIPH            0x0
> > > > +#define CC_1_MEMTYPE_LOWER_MEM                       0x1
> > > > +
> > > > +#endif  /* PCI_S32G_REGS_H */
> > > > diff --git a/drivers/pci/controller/dwc/pcie-s32g.c b/drivers/pci/c=
ontroller/dwc/pcie-s32g.c
> > > > new file mode 100644
> > > > index 000000000000..995e4593a13e
> > > > --- /dev/null
> > > > +++ b/drivers/pci/controller/dwc/pcie-s32g.c
> > > > @@ -0,0 +1,578 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * PCIe host controller driver for NXP S32G SoCs
> > > > + *
> > > > + * Copyright 2019-2025 NXP
> > > > + */
> > > > +
> > > > +#include <linux/interrupt.h>
> > > > +#include <linux/io.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of_device.h>
> > > > +#include <linux/of_address.h>
> > > > +#include <linux/pci.h>
> > > > +#include <linux/phy.h>
> > > > +#include <linux/phy/phy.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/pm_runtime.h>
> > > > +#include <linux/sizes.h>
> > > > +#include <linux/types.h>
> > > > +
> > > > +#include "pcie-designware.h"
> > > > +#include "pcie-s32g-regs.h"
> > > > +
> > > > +struct s32g_pcie {
> > > > +     struct dw_pcie  pci;
> > > > +
> > > > +     /*
> > > > +      * We have cfg in struct dw_pcie_rp and
> > > > +      * dbi in struct dw_pcie, so define only ctrl here
> > > > +      */
> > > > +     void __iomem *ctrl_base;
> > > > +     u64 coherency_base;
> > > > +
> > > > +     struct phy *phy;
> > > > +};
> > > > +
> > > > +#define to_s32g_from_dw_pcie(x) \
> > > > +     container_of(x, struct s32g_pcie, pci)
> > > > +
> > > > +static void s32g_pcie_writel_ctrl(struct s32g_pcie *s32g_pp, u32 r=
eg, u32 val)
> > > > +{
> > > > +     if (dw_pcie_write(s32g_pp->ctrl_base + reg, 0x4, val))
> > > > +             dev_err(s32g_pp->pci.dev, "Write ctrl address failed\=
n");
> > > > +}
> > >
> > > Since you are having complete control over the register and the base,=
 you can
> > > directly use writel/readl without these helpers. They are mostly used=
 to
> > > read/write the common register space like DBI.
> >
> > fair enough
> >
>
> You should also use _relaxed variants unless ordering is necessary.
>
> > >
> > > > +
> > > > +static u32 s32g_pcie_readl_ctrl(struct s32g_pcie *s32g_pp, u32 reg=
)
> > > > +{
> > > > +     u32 val =3D 0;
> > > > +
> > > > +     if (dw_pcie_read(s32g_pp->ctrl_base + reg, 0x4, &val))
> > > > +             dev_err(s32g_pp->pci.dev, "Read ctrl address failed\n=
");
> > > > +
> > > > +     return val;
> > > > +}
> > > > +
> > > > +static void s32g_pcie_enable_ltssm(struct s32g_pcie *s32g_pp)
> > > > +{
> > > > +     u32 reg;
> > > > +
> > > > +     reg =3D s32g_pcie_readl_ctrl(s32g_pp, PE0_GEN_CTRL_3);
> > > > +     reg |=3D LTSSM_EN;
> > > > +     s32g_pcie_writel_ctrl(s32g_pp, PE0_GEN_CTRL_3, reg);
> > > > +}
> > > > +
> > > > +static void s32g_pcie_disable_ltssm(struct s32g_pcie *s32g_pp)
> > > > +{
> > > > +     u32 reg;
> > > > +
> > > > +     reg =3D s32g_pcie_readl_ctrl(s32g_pp, PE0_GEN_CTRL_3);
> > > > +     reg &=3D ~LTSSM_EN;
> > > > +     s32g_pcie_writel_ctrl(s32g_pp, PE0_GEN_CTRL_3, reg);
> > > > +}
> > > > +
> > > > +static bool is_s32g_pcie_ltssm_enabled(struct s32g_pcie *s32g_pp)
> > > > +{
> > > > +     return (s32g_pcie_readl_ctrl(s32g_pp, PE0_GEN_CTRL_3) & LTSSM=
_EN);
> > > > +}
> > > > +
> > > > +static enum dw_pcie_ltssm s32g_pcie_get_ltssm(struct dw_pcie *pci)
> > > > +{
> > > > +     struct s32g_pcie *s32g_pp =3D to_s32g_from_dw_pcie(pci);
> > > > +     u32 val =3D s32g_pcie_readl_ctrl(s32g_pp, PCIE_SS_PE0_LINK_DB=
G_2);
> > > > +
> > > > +     return (enum dw_pcie_ltssm)FIELD_GET(PCIE_SS_SMLH_LTSSM_STATE=
_MASK, val);
> > > > +}
> > > > +
> > > > +#define PCIE_LINKUP  (PCIE_SS_SMLH_LINK_UP | PCIE_SS_RDLH_LINK_UP)
> > > > +
> > > > +static bool has_data_phy_link(struct s32g_pcie *s32g_pp)
> > > > +{
> > > > +     u32 val =3D s32g_pcie_readl_ctrl(s32g_pp, PCIE_SS_PE0_LINK_DB=
G_2);
> > > > +
> > > > +     if ((val & PCIE_LINKUP) =3D=3D PCIE_LINKUP) {
> > > > +             switch (val & PCIE_SS_SMLH_LTSSM_STATE_MASK) {
> > > > +             case LTSSM_STATE_L0:
> > > > +             case LTSSM_STATE_L0S:
> > > > +             case LTSSM_STATE_L1_IDLE:
> > > > +                     return true;
> > > > +             default:
> > > > +                     return false;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     return false;
> > > > +}
> > > > +
> > > > +static bool s32g_pcie_link_up(struct dw_pcie *pci)
> > > > +{
> > > > +     struct s32g_pcie *s32g_pp =3D to_s32g_from_dw_pcie(pci);
> > > > +
> > > > +     if (!is_s32g_pcie_ltssm_enabled(s32g_pp))
> > > > +             return false;
> > > > +
> > > > +     return has_data_phy_link(s32g_pp);
> > > > +}
> > > > +
> > > > +static int s32g_pcie_start_link(struct dw_pcie *pci)
> > > > +{
> > > > +     struct s32g_pcie *s32g_pp =3D to_s32g_from_dw_pcie(pci);
> > > > +
> > > > +     s32g_pcie_enable_ltssm(s32g_pp);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void s32g_pcie_stop_link(struct dw_pcie *pci)
> > > > +{
> > > > +     struct s32g_pcie *s32g_pp =3D to_s32g_from_dw_pcie(pci);
> > > > +
> > > > +     s32g_pcie_disable_ltssm(s32g_pp);
> > > > +}
> > > > +
> > > > +struct dw_pcie_ops s32g_pcie_ops =3D {
> > > > +     .get_ltssm =3D s32g_pcie_get_ltssm,
> > > > +     .link_up =3D s32g_pcie_link_up,
> > > > +     .start_link =3D s32g_pcie_start_link,
> > > > +     .stop_link =3D s32g_pcie_stop_link,
> > > > +};
> > > > +
> > > > +static const struct dw_pcie_host_ops s32g_pcie_host_ops;
> > > > +
> > > > +static void disable_equalization(struct dw_pcie *pci)
> > > > +{
> > > > +     u32 val;
> > > > +
> > > > +     val =3D dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> > > > +     val &=3D ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
> > > > +              GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
> > > > +     val |=3D FIELD_PREP(GEN3_EQ_CONTROL_OFF_FB_MODE, 1) |
> > > > +            FIELD_PREP(GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC, 0x84);
> > >
> > > FIELD_MODIFY()?
> >
> > FIELD_PREP() allows  adding multiple fields changes in a single access
> > instead of having one access per field with FIELD_MODIFY
> >
>
> Yeah, but it gets rid of the explicit masking.
>
> > >
> > > > +     dw_pcie_dbi_ro_wr_en(pci);
> > > > +     dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
> > > > +     dw_pcie_dbi_ro_wr_dis(pci);
> > > > +}
> > > > +
> > > > +static void s32g_pcie_reset_mstr_ace(struct dw_pcie *pci, u64 ddr_=
base_addr)
> > >
> > > What does _ace stands for?
> >
> > AMBA AXI Coherency Extensions (ACE)
> >
>
> Ok. You could add a comment to make it clear of what this function does.
>
> > >
> > > > +{
> > > > +     u32 ddr_base_low =3D lower_32_bits(ddr_base_addr);
> > > > +     u32 ddr_base_high =3D upper_32_bits(ddr_base_addr);
> > > > +
> > > > +     dw_pcie_dbi_ro_wr_en(pci);
> > > > +     dw_pcie_writel_dbi(pci, PORT_LOGIC_COHERENCY_CONTROL_3, 0x0);
> > > > +
> > > > +     /*
> > > > +      * Transactions to peripheral targets should be non-coherent,
> > >
> > > What is exactly meant by 'Transactions to peripheral targets'? Is it =
the MMIO
> > > access to peripherals? If so, all MMIO memory is marked as non-cachea=
ble by
> > > default.
> >
> > From the ref manual of s32g :
> > Ncore is a cache-coherent interconnect module. It enables the
> > integration of heterogeneous coherent agents and non-coherent
> > agents in a chip. It processes transactions with coherent access
> > semantics from various fully-coherent and IO-coherent masters,
> > targeting shared resources.
> >
>
> Ok. It would help if this is described in the patch description.
>
> > >
> > > > +      * or Ncore might drop them.
> > >
> > > What is 'Ncore'?
> > >
>
> [...]
>
> > >
> > > > +
> > > > +     return 0;
> > > > +
> > > > +err_host_deinit:
> > > > +     dw_pcie_host_deinit(pp);
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static int s32g_pcie_probe(struct platform_device *pdev)
> > > > +{
> > > > +     struct device *dev =3D &pdev->dev;
> > > > +     struct s32g_pcie *s32g_pp;
> > > > +     int ret;
> > > > +
> > > > +     s32g_pp =3D devm_kzalloc(dev, sizeof(*s32g_pp), GFP_KERNEL);
> > > > +     if (!s32g_pp)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     ret =3D s32g_pcie_get_resources(pdev, s32g_pp);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     devm_pm_runtime_enable(dev);
> > > > +     ret =3D pm_runtime_get_sync(dev);
> > >
> > > Does this driver rely on any of its parent to enable the resources? L=
ike
> > > pm-domain, clock, etc... If so, just set pm_runtime_no_callbacks() be=
fore
> >
> > pm_runtime_no_callbacks() is missing.
> >
>
> I was specifically questioning the 'pm_runtime_get_sync()' call. If you n=
eed to
> enable any parent resources, then you can keep it. Otherwise, just drop i=
t.
>
> > > devm_pm_runtime_enable(). If not, then do:
> > >
> > >         pm_runtime_set_active()
> > >         pm_runtime_no_callbacks()
> > >         devm_pm_runtime_enable()
> > >
> > > > +     if (ret < 0)
> > > > +             goto err_pm_runtime_put;
> > > > +
> > > > +     ret =3D s32g_pcie_init(dev, s32g_pp);
> > > > +     if (ret)
> > > > +             goto err_pm_runtime_put;
> > > > +
> > > > +     ret =3D s32g_pcie_host_init(dev, s32g_pp);
> > > > +     if (ret)
> > > > +             goto err_deinit_controller;
> > > > +
> > > > +     return 0;
> > > > +
> > > > +err_deinit_controller:
> > > > +     s32g_pcie_deinit(s32g_pp);
> > > > +err_pm_runtime_put:
> > > > +     pm_runtime_put(dev);
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static int s32g_pcie_suspend(struct device *dev)
> > > > +{
> > > > +     struct s32g_pcie *s32g_pp =3D dev_get_drvdata(dev);
> > > > +     struct dw_pcie *pci =3D &s32g_pp->pci;
> > > > +     struct dw_pcie_rp *pp =3D &pci->pp;
> > > > +     struct pci_bus *bus, *root_bus;
> > > > +
> > > > +     s32g_pcie_downstream_dev_to_D0(s32g_pp);
> > > > +
> > > > +     bus =3D pp->bridge->bus;
> > > > +     root_bus =3D s32g_get_child_downstream_bus(bus);
> > > > +     if (!IS_ERR(root_bus))
> > > > +             pci_walk_bus(root_bus, pci_dev_set_disconnected, NULL=
);
> > > > +
> > > > +     pci_stop_root_bus(bus);
> > > > +     pci_remove_root_bus(bus);
> > >
> > > Why can't you rely on dw_pcie_host_deinit()?
> >
> > I need to check but mainly because we don't do dw_pcie_host_init() duri=
ng resume
> >
>
> You should and it will simplify your driver a lot.
>
> > >
> > > > +
> > > > +     s32g_pcie_deinit(s32g_pp);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int s32g_pcie_resume(struct device *dev)
> > > > +{
> > > > +     struct s32g_pcie *s32g_pp =3D dev_get_drvdata(dev);
> > > > +     struct dw_pcie *pci =3D &s32g_pp->pci;
> > > > +     struct dw_pcie_rp *pp =3D &pci->pp;
> > > > +     int ret =3D 0;
> > > > +
> > > > +     ret =3D s32g_pcie_init(dev, s32g_pp);
> > > > +     if (ret < 0)
> > > > +             return ret;
> > > > +
> > > > +     ret =3D dw_pcie_setup_rc(pp);
> > > > +     if (ret) {
> > > > +             dev_err(dev, "Failed to resume DW RC: %d\n", ret);
> > > > +             goto fail_host_init;
> > > > +     }
> > > > +
> > > > +     ret =3D dw_pcie_start_link(pci);
> > > > +     if (ret) {
> > > > +             /*
> > > > +              * We do not exit with error if link up was unsuccess=
ful
> > > > +              * Endpoint may not be connected.
> > > > +              */
> > > > +             if (dw_pcie_wait_for_link(pci))
> > > > +                     dev_warn(pci->dev,
> > > > +                              "Link Up failed, Endpoint may not be=
 connected\n");
> > > > +
> > > > +             if (!phy_validate(s32g_pp->phy, PHY_MODE_PCIE, 0, NUL=
L)) {
> > > > +                     dev_err(dev, "Failed to get link up with EP c=
onnected\n");
> > > > +                     goto fail_host_init;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     ret =3D pci_host_probe(pp->bridge);
> > >
> > > Oh no... Do not call pci_host_probe() directly from glue drivers. Use
> > > dw_pcie_host_init() to do so. This should simplify suspend and resume=
 functions.
> >
> > dw_pcie_host_init() is doing much more than just init the controller
> > as it gets resources which we haven't released during suspend.
> >
>
> Any specific reason to keep resources enabled, even though you were remov=
ing the
> Root bus? This doesn't make sense to me.

By ressources I mean everything before  dw_pcie_setup_rc()  in
dw_pcie_host_init() which are still there after dw_pcie_host_deinit()
in addition to being a waste of time. Also we don't need to remove
edma and free msi

>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

