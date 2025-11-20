Return-Path: <linux-pci+bounces-41752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 645E6C7304C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 10:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 198D62FB92
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 09:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7F526F443;
	Thu, 20 Nov 2025 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pl+HdA0M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5753D30F941
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763629629; cv=none; b=KkUZytV3FBtbDvC6+Zn3VnBExTEeqtfoQhhPHgWohaz9k7KEd+JN845Ni1dUeWdLn1AQ14rKEWnFv5KSzwxQ1gzU6DstBA3NnkRUqVrZHWiGgaGE24JlI+ZWFz4f4lJuJ0A/frvDLYTT4hV9SUu6keC7uv2cjytcAWvq9rXoGkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763629629; c=relaxed/simple;
	bh=0wF8jVFA1YtaTxl0xxnHRWQ5JtztxoCJS9yFPlt9+D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXvfYvFX9vqWTQ3OLSR+kvTw3WseO6lI7yU1QEIhqxg3XDjNRva0gczSK28RY60ZV3FbFcRBTsWGggquK6+yo818piM/8ZYZdrltGKkAtcMPTBV2OwXHczwQVRPwyOdvj8VGy7szQBMGzs2ZfdvmouvzrNt5Di8a7S+konh11A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pl+HdA0M; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so935861a12.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 01:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763629625; x=1764234425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXBJfz+nlT32zvUVTDmHspee1phygZAGEQqGMhXUGqo=;
        b=Pl+HdA0MI3+qAijybdpSn/yGZFDqI8O8948ouvk1ief1Y+2tHxQgqF05A4QrgFoT1c
         5XylL/ceFsG4863xK2aMx3kjFNvjNYtYndjC+KiZqfgACvxDLV2pYrEEowQDjIDdn1kA
         LxGR5jOkr3P/oVpRYXEkrPuN9YdigJ2OEOfpAdJPgvvLIlHw6DMh049VRymzzxpmnC4G
         Kjxq72NgtMgoF1uORSqp1EsNLQBSIGGOtfk7yrwIf0ysvY+oRc5228n2W7LEc+Pbr4PS
         4EN85Ao4XHvRS14vcFC2Tj+yXA5R2t1pJk1p4w+5PShqsUVlpOEQCsqV2C84PM5SjbkF
         Aczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763629625; x=1764234425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eXBJfz+nlT32zvUVTDmHspee1phygZAGEQqGMhXUGqo=;
        b=xBssV0X3Ki9gLNATOn7G5KR9kfo9QZn4Se5orgqht8MaUX0OivZ/owMxzhbYV06lb6
         Azk4EAFaNDkz/Jxruli6KnRpUecJp9w3hgwRm73b8n5r+SUXdhp15gC1QHa7qpaPR73A
         vX3UwWe4yjICZybo54pnpcsUsB6gf7PxhACSopbRqCSvmxL7iu/zXB9bQhFBQeyqq2iS
         pcQ+f+FrbPMw2jvNmrYuqyGRKNxU2VJy9envkQDgKp+w7EkRDR42kLDN7lqTEtRrrC1+
         /JKoCmRSNlktOeL/aTW2NBUN6JcOJ7ZguNTpAA0GTEx37DHAb7aW0V9PnyZevZlvX/7s
         5gMw==
X-Forwarded-Encrypted: i=1; AJvYcCXdhvE9woiUTQj+mq+jehV+MRejkoEk+ASXjtWs/AGG26cNcdZ9iVRF6GFYTKaHY2/vjXYqdcPHzLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTF55hoRacWdN88mzM1ccj5lMPGtCLpmkNGAsMpwAOWRpuObim
	y3xoj7WO6ZcBX8bO5oYOd18xfU93snp4UVyYVgeFVm4TCbekjNNjn66h2+qcBO3bhl5QxgCscRf
	koY/V/R5Ou+atXjXMc4Xj+aUuS8z9aeYpqufUZPdmMg==
X-Gm-Gg: ASbGncvE3hdDS/I/rBmGcEClBzA61bPRDdKHZXf+OBc/k6I3rD9fZNofGey0PRlXD0F
	09r4V1I2kT+VW98eeYdex/OKIXJbByYyPThXhBWEgvTtKP/dL4SoBLVi1lByiD2l9JWy6/Xtb2m
	SEfw+p51B2O6QFBhSmR25MPrch4FEXgacLPMufnx1I1Y/21ERn1UhD43wtaKCQXCzzkZalPcPg6
	el9fXwmnvNAssboVzcS4sxQENrrqEw5WDjwBxwYYf2a8r2kKnknDtBrVtesl4uRiGvfDAyjjYe/
	hTg3Ww+o9Pp+7yArIiMcqlg=
X-Google-Smtp-Source: AGHT+IHr/LLoSOyZaRnaG92hpxiXwEwUws8DiyqeFHyQxoqH5z1SqVajNFGpFPiD/vA6q098LJZ8VNvxzb3o3RWgfGo=
X-Received: by 2002:a05:6402:4302:b0:640:c643:75dd with SMTP id
 4fb4d7f45d1cf-64536409732mr2241018a12.12.1763629624483; Thu, 20 Nov 2025
 01:07:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118160238.26265-1-vincent.guittot@linaro.org>
 <20251118160238.26265-4-vincent.guittot@linaro.org> <qvpx4ys2jqqugfbcdwidwvklcatdqiwdxfjumn7ncbh7z6ef5n@sepvjsatmpbd>
In-Reply-To: <qvpx4ys2jqqugfbcdwidwvklcatdqiwdxfjumn7ncbh7z6ef5n@sepvjsatmpbd>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 20 Nov 2025 10:06:53 +0100
X-Gm-Features: AWmQ_bmE9vkDDyDL2VNdrRaFqjJ3Ook37JBhnVf_WMx1pdoYrW372XueHwRvONI
Message-ID: <CAKfTPtDONX3-syavhhza6t6+6U8wowqwCN2Hnv9CHBR6W9RNNQ@mail.gmail.com>
Subject: Re: [PATCH 3/4 v5] PCI: s32g: Add initial PCIe support (RC)
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

On Thu, 20 Nov 2025 at 09:22, Manivannan Sadhasivam <mani@kernel.org> wrote=
:
>
> On Tue, Nov 18, 2025 at 05:02:37PM +0100, Vincent Guittot wrote:
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
> >  drivers/pci/controller/dwc/Kconfig            |  10 +
> >  drivers/pci/controller/dwc/Makefile           |   1 +
> >  .../pci/controller/dwc/pcie-nxp-s32g-regs.h   |  21 +
> >  drivers/pci/controller/dwc/pcie-nxp-s32g.c    | 391 ++++++++++++++++++
> >  4 files changed, 423 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
> >  create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g.c
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controlle=
r/dwc/Kconfig
> > index 349d4657393c..e276956c3fca 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -256,6 +256,16 @@ config PCIE_TEGRA194_EP
> >         in order to enable device-specific features PCIE_TEGRA194_EP mu=
st be
> >         selected. This uses the DesignWare core.
> >
> > +config PCIE_NXP_S32G
> > +     tristate "NXP S32G PCIe controller (host mode)"
> > +     depends on ARCH_S32 || COMPILE_TEST
> > +     select PCIE_DW_HOST
> > +     help
> > +       Enable support for the PCIe controller in NXP S32G based boards=
 to
> > +       work in Host mode. The controller is based on DesignWare IP and
> > +       can work either as RC or EP. In order to enable host-specific
> > +       features PCIE_NXP_S32G must be selected.
> > +
> >  config PCIE_DW_PLAT
> >       bool
> >
> > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controll=
er/dwc/Makefile
> > index 7ae28f3b0fb3..3301bbbad78c 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -10,6 +10,7 @@ obj-$(CONFIG_PCI_DRA7XX) +=3D pci-dra7xx.o
> >  obj-$(CONFIG_PCI_EXYNOS) +=3D pci-exynos.o
> >  obj-$(CONFIG_PCIE_FU740) +=3D pcie-fu740.o
> >  obj-$(CONFIG_PCI_IMX6) +=3D pci-imx6.o
> > +obj-$(CONFIG_PCIE_NXP_S32G) +=3D pcie-nxp-s32g.o
> >  obj-$(CONFIG_PCIE_SPEAR13XX) +=3D pcie-spear13xx.o
> >  obj-$(CONFIG_PCI_KEYSTONE) +=3D pci-keystone.o
> >  obj-$(CONFIG_PCI_LAYERSCAPE) +=3D pci-layerscape.o
> > diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h b/drivers/=
pci/controller/dwc/pcie-nxp-s32g-regs.h
> > new file mode 100644
> > index 000000000000..81e35b6227d1
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2015-2016 Freescale Semiconductor, Inc.
> > + * Copyright 2016-2023, 2025 NXP
> > + */
> > +
> > +#ifndef PCIE_S32G_REGS_H
> > +#define PCIE_S32G_REGS_H
> > +
> > +/* PCIe controller Sub-System */
> > +
> > +/* PCIe controller 0 General Control 1 */
> > +#define PCIE_S32G_PE0_GEN_CTRL_1             0x50
> > +#define DEVICE_TYPE_MASK                     GENMASK(3, 0)
> > +#define SRIS_MODE                            BIT(8)
> > +
> > +/* PCIe controller 0 General Control 3 */
> > +#define PCIE_S32G_PE0_GEN_CTRL_3             0x58
> > +#define LTSSM_EN                             BIT(0)
> > +
>
> Since this header is not used by other drivers as of now, I'd prefer movi=
ng
> these definitions inside the driver.

I would prefer to keep it separate. It makes reg easier to parse and
more registers will be added with new coming features

>
> > +#endif  /* PCI_S32G_REGS_H */
> > diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/c=
ontroller/dwc/pcie-nxp-s32g.c
> > new file mode 100644
> > index 000000000000..eaa6b5363afe
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > @@ -0,0 +1,391 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCIe host controller driver for NXP S32G SoCs
> > + *
> > + * Copyright 2019-2025 NXP
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/memblock.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_address.h>
> > +#include <linux/pci.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/sizes.h>
> > +#include <linux/types.h>
> > +
> > +#include "pcie-designware.h"
> > +#include "pcie-nxp-s32g-regs.h"
> > +
> > +struct s32g_pcie_port {
> > +     struct list_head list;
> > +     struct phy *phy;
> > +};
> > +
> > +struct s32g_pcie {
> > +     struct dw_pcie  pci;
> > +     void __iomem *ctrl_base;
> > +     struct list_head ports;
> > +};
> > +
> > +#define to_s32g_from_dw_pcie(x) \
> > +     container_of(x, struct s32g_pcie, pci)
> > +
> > +static void s32g_pcie_writel_ctrl(struct s32g_pcie *s32g_pp, u32 reg, =
u32 val)
> > +{
> > +     writel(val, s32g_pp->ctrl_base + reg);
> > +}
> > +
> > +static u32 s32g_pcie_readl_ctrl(struct s32g_pcie *s32g_pp, u32 reg)
> > +{
> > +     return readl(s32g_pp->ctrl_base + reg);
> > +}
> > +
> > +static void s32g_pcie_enable_ltssm(struct s32g_pcie *s32g_pp)
> > +{
> > +     u32 reg;
> > +
> > +     reg =3D s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3);
> > +     reg |=3D LTSSM_EN;
> > +     s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3, reg);
> > +}
> > +
> > +static void s32g_pcie_disable_ltssm(struct s32g_pcie *s32g_pp)
> > +{
> > +     u32 reg;
> > +
> > +     reg =3D s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3);
> > +     reg &=3D ~LTSSM_EN;
> > +     s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3, reg);
> > +}
> > +
> > +static int s32g_pcie_start_link(struct dw_pcie *pci)
> > +{
> > +     struct s32g_pcie *s32g_pp =3D to_s32g_from_dw_pcie(pci);
> > +
> > +     s32g_pcie_enable_ltssm(s32g_pp);
> > +
> > +     return 0;
> > +}
> > +
> > +static void s32g_pcie_stop_link(struct dw_pcie *pci)
> > +{
> > +     struct s32g_pcie *s32g_pp =3D to_s32g_from_dw_pcie(pci);
> > +
> > +     s32g_pcie_disable_ltssm(s32g_pp);
> > +}
> > +
> > +static struct dw_pcie_ops s32g_pcie_ops =3D {
> > +     .start_link =3D s32g_pcie_start_link,
> > +     .stop_link =3D s32g_pcie_stop_link,
> > +};
> > +
> > +/* Configure the AMBA AXI Coherency Extensions (ACE) interface */
> > +static void s32g_pcie_reset_mstr_ace(struct dw_pcie *pci, u64 ddr_base=
_addr)
> > +{
> > +     u32 ddr_base_low =3D lower_32_bits(ddr_base_addr);
> > +     u32 ddr_base_high =3D upper_32_bits(ddr_base_addr);
> > +
> > +     dw_pcie_dbi_ro_wr_en(pci);
> > +     dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_3_OFF, 0x0);
> > +
> > +     /*
> > +      * Ncore is a cache-coherent interconnect module that enables the
> > +      * integration of heterogeneous coherent and non-coherent agents =
in
> > +      * the chip. Ncore Transactions to peripheral should be non-coher=
ent
> > +      * or it might drop them.
> > +      *
> > +      * One example where this is needed are PCIe MSIs, which use NoSn=
oop=3D0
> > +      * and might end up routed to Ncore.
>
> I don't think this statement is correct. No Snoop attribute is only appli=
cable
> to MRd/MWr operations and not applicable to MSIs. Also, you've marked the

The Ncore makes the bridge between the PCIe and the NoC and can decide
to drop some transactions based in this boundary

> controller as cache coherent in the binding, but this comment doesn't rel=
ate to
> it.

More details of the issue:
PCIe coherent traffic (e.g. MSIs) that targets peripheral space will
be dropped by Ncore because peripherals on S32G are not coherent as
slaves. We add a hard boundary in the PCIe controller coherency
control registers to separate physical memory space from peripheral
space.

>
> > +      * Define the start of DDR as seen by Linux as the boundary betwe=
en
> > +      * "memory" and "peripherals", with peripherals being below.
>
> Please mention what this configuration does and why it is necessary. This=
 is not
> clearly mentioned in the comment.
>
> > +      */
> > +     dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_1_OFF,
> > +                        (ddr_base_low & CFG_MEMTYPE_BOUNDARY_LOW_ADDR_=
MASK));
> > +     dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_2_OFF, ddr_base_high);
> > +     dw_pcie_dbi_ro_wr_dis(pci);
> > +}
> > +
> > +static int s32g_init_pcie_controller(struct dw_pcie_rp *pp)
> > +{
> > +     struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > +     struct s32g_pcie *s32g_pp =3D to_s32g_from_dw_pcie(pci);
> > +     u32 val;
> > +
> > +     /* Set RP mode */
> > +     val =3D s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_1);
> > +     val &=3D ~DEVICE_TYPE_MASK;
> > +     val |=3D FIELD_PREP(DEVICE_TYPE_MASK, PCI_EXP_TYPE_ROOT_PORT);
> > +
> > +     /* Use default CRNS */
>
> SRNS?

it's CRNS

>
> > +     val &=3D ~SRIS_MODE;
> > +
> > +     s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_1, val);
> > +
> > +     /*
> > +      * Make sure we use the coherency defaults (just in case the sett=
ings
> > +      * have been changed from their reset values)
> > +      */
> > +     s32g_pcie_reset_mstr_ace(pci, memblock_start_of_DRAM());
> > +
> > +     dw_pcie_dbi_ro_wr_en(pci);
> > +
> > +     val =3D dw_pcie_readl_dbi(pci, PCIE_PORT_FORCE);
> > +     val |=3D PORT_FORCE_DO_DESKEW_FOR_SRIS;
> > +     dw_pcie_writel_dbi(pci, PCIE_PORT_FORCE, val);
> > +
> > +     val =3D dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> > +     val |=3D GEN3_RELATED_OFF_EQ_PHASE_2_3;
> > +     dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> > +
> > +     dw_pcie_dbi_ro_wr_dis(pci);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct dw_pcie_host_ops s32g_pcie_host_ops =3D {
> > +     .init =3D s32g_init_pcie_controller,
> > +};
> > +
> > +static int s32g_init_pcie_phy(struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pci =3D &s32g_pp->pci;
> > +     struct device *dev =3D pci->dev;
> > +     struct s32g_pcie_port *port, *tmp;
> > +     int ret;
> > +
> > +     list_for_each_entry(port, &s32g_pp->ports, list) {
> > +             ret =3D phy_init(port->phy);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to init serdes PHY\n");
> > +                     goto err_phy_revert;
> > +             }
> > +
> > +             ret =3D phy_set_mode_ext(port->phy, PHY_MODE_PCIE, 0);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to set mode on serdes PHY\n"=
);
> > +                     goto err_phy_exit;
> > +             }
> > +
> > +             ret =3D phy_power_on(port->phy);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to power on serdes PHY\n");
> > +                     goto err_phy_exit;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +
> > +err_phy_exit:
> > +     phy_exit(port->phy);
> > +
> > +err_phy_revert:
> > +     list_for_each_entry_continue_reverse(port, &s32g_pp->ports, list)=
 {
> > +             phy_power_off(port->phy);
> > +             phy_exit(port->phy);
> > +     }
> > +
> > +     list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
> > +             list_del(&port->list);
>
> Can't you use list_for_each_entry_safe_reverse() to combine both operatio=
ns?

No, it goes over all elements of the list whereas I only want to power
off and exit only those which have been init and powered on above.

>
> > +
> > +     return ret;
> > +}
> > +
> > +static void s32g_deinit_pcie_phy(struct s32g_pcie *s32g_pp)
> > +{
> > +     struct s32g_pcie_port *port, *tmp;
> > +
> > +     list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list) {
> > +             phy_power_off(port->phy);
> > +             phy_exit(port->phy);
> > +             list_del(&port->list);
> > +     }
> > +}
> > +
> > +static int s32g_pcie_init(struct device *dev, struct s32g_pcie *s32g_p=
p)
> > +{
> > +     int ret;
> > +
> > +     s32g_pcie_disable_ltssm(s32g_pp);
> > +
> > +     ret =3D s32g_init_pcie_phy(s32g_pp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static void s32g_pcie_deinit(struct s32g_pcie *s32g_pp)
> > +{
> > +     s32g_pcie_disable_ltssm(s32g_pp);
> > +
> > +     s32g_deinit_pcie_phy(s32g_pp);
> > +}
> > +
> > +static int s32g_pcie_parse_port(struct s32g_pcie *s32g_pp, struct devi=
ce_node *node)
> > +{
> > +     struct device *dev =3D s32g_pp->pci.dev;
> > +     struct s32g_pcie_port *port;
> > +     int num_lanes;
> > +
> > +     port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> > +     if (!port)
> > +             return -ENOMEM;
> > +
> > +     port->phy =3D devm_of_phy_get(dev, node, NULL);
> > +     if (IS_ERR(port->phy))
> > +             return dev_err_probe(dev, PTR_ERR(port->phy),
> > +                             "Failed to get serdes PHY\n");
> > +
> > +     INIT_LIST_HEAD(&port->list);
> > +     list_add_tail(&port->list, &s32g_pp->ports);
> > +
> > +     /*
> > +      * The DWC core initialization code cannot parse yet the num-lane=
s
> > +      * attribute in the Root Port node. The S32G only supports one Ro=
ot
> > +      * Port for now so its driver can parse the node and set the num_=
lanes
> > +      * field of struct dwc_pcie before calling dw_pcie_host_init().
>
> Please add TODO prefix so that it catches the eyes looking for improvemen=
ts.

Okay

>
> > +      */
> > +     if (!of_property_read_u32(node, "num-lanes", &num_lanes))
> > +             s32g_pp->pci.num_lanes =3D num_lanes;
> > +
> > +     return 0;
> > +}
> > +
> > +static int s32g_pcie_parse_ports(struct device *dev, struct s32g_pcie =
*s32g_pp)
> > +{
> > +     struct s32g_pcie_port *port, *tmp;
> > +     int ret =3D -ENOENT;
> > +
> > +     for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> > +             if (!of_node_is_type(of_port, "pci"))
> > +                     continue;
> > +
> > +             ret =3D s32g_pcie_parse_port(s32g_pp, of_port);
> > +             if (ret)
> > +                     goto err_port;
> > +     }
> > +
> > +err_port:
> > +     list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
> > +             list_del(&port->list);
> > +
> > +     return ret;
> > +}
> > +
> > +static int s32g_pcie_get_resources(struct platform_device *pdev,
> > +                                struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pci =3D &s32g_pp->pci;
> > +     struct device *dev =3D &pdev->dev;
> > +     int ret;
> > +
> > +     pci->dev =3D dev;
> > +     pci->ops =3D &s32g_pcie_ops;
> > +
> > +     s32g_pp->ctrl_base =3D devm_platform_ioremap_resource_byname(pdev=
, "ctrl");
> > +     if (IS_ERR(s32g_pp->ctrl_base))
> > +             return PTR_ERR(s32g_pp->ctrl_base);
> > +
> > +     INIT_LIST_HEAD(&s32g_pp->ports);
> > +
> > +     ret =3D s32g_pcie_parse_ports(dev, s32g_pp);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret,
> > +                             "Failed to parse Root Port: %d\n", ret);
> > +
> > +     platform_set_drvdata(pdev, s32g_pp);
>
> nit: move this to probe()
>
> > +
> > +     return 0;
> > +}
> > +
> > +static int s32g_pcie_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct s32g_pcie *s32g_pp;
> > +     struct dw_pcie_rp *pp;
> > +     int ret;
> > +
> > +     s32g_pp =3D devm_kzalloc(dev, sizeof(*s32g_pp), GFP_KERNEL);
> > +     if (!s32g_pp)
> > +             return -ENOMEM;
> > +
> > +     ret =3D s32g_pcie_get_resources(pdev, s32g_pp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     pm_runtime_no_callbacks(dev);
> > +     devm_pm_runtime_enable(dev);
> > +     ret =3D pm_runtime_get_sync(dev);
> > +     if (ret < 0)
> > +             goto err_pm_runtime_put;
> > +
> > +     ret =3D s32g_pcie_init(dev, s32g_pp);
> > +     if (ret)
> > +             goto err_pm_runtime_put;
> > +
> > +     pp =3D &s32g_pp->pci.pp;
> > +     pp->ops =3D &s32g_pcie_host_ops;
> > +     pp->use_atu_msg =3D true;
> > +
> > +     ret =3D dw_pcie_host_init(pp);
> > +     if (ret)
> > +             goto err_pcie_deinit;
> > +
> > +     return 0;
> > +
> > +err_pcie_deinit:
> > +     s32g_pcie_deinit(s32g_pp);
> > +err_pm_runtime_put:
> > +     pm_runtime_put(dev);
> > +
> > +     return ret;
> > +}
> > +
> > +static int s32g_pcie_suspend_noirq(struct device *dev)
> > +{
> > +     struct s32g_pcie *s32g_pp =3D dev_get_drvdata(dev);
> > +     struct dw_pcie *pci =3D &s32g_pp->pci;
> > +
> > +     return dw_pcie_suspend_noirq(pci);
> > +}
> > +
> > +static int s32g_pcie_resume_noirq(struct device *dev)
> > +{
> > +     struct s32g_pcie *s32g_pp =3D dev_get_drvdata(dev);
> > +     struct dw_pcie *pci =3D &s32g_pp->pci;
> > +
> > +     return dw_pcie_resume_noirq(pci);
> > +}
> > +
> > +static const struct dev_pm_ops s32g_pcie_pm_ops =3D {
> > +     NOIRQ_SYSTEM_SLEEP_PM_OPS(s32g_pcie_suspend_noirq,
> > +                               s32g_pcie_resume_noirq)
> > +};
> > +
> > +static const struct of_device_id s32g_pcie_of_match[] =3D {
> > +     { .compatible =3D "nxp,s32g2-pcie" },
> > +     { /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, s32g_pcie_of_match);
> > +
> > +static struct platform_driver s32g_pcie_driver =3D {
> > +     .driver =3D {
> > +             .name   =3D "s32g-pcie",
> > +             .of_match_table =3D s32g_pcie_of_match,
> > +             .suppress_bind_attrs =3D true,
> > +             .pm =3D pm_sleep_ptr(&s32g_pcie_pm_ops),
> > +             .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > +     },
> > +     .probe =3D s32g_pcie_probe,
> > +};
> > +
> > +module_platform_driver(s32g_pcie_driver);
>
> builtin_platform_driver() since this controller implements MSI controller=
.

Can you elaborate ?

>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

