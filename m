Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB6D3040F8
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 15:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391346AbhAZOxa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 09:53:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391314AbhAZOx1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 09:53:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98F9223103;
        Tue, 26 Jan 2021 14:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611672764;
        bh=3yBxzjkgZhuyNBbMaccqgbZLYAKuOFoO0Q29PtcedmU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XTkQNv8Sbs4GgCocet74Y0iwGHu2J4vtK6ffoT2EiaLXhKdv6+gXprNgC/91C2sld
         ZdA2w1TSkTamreVLY6tGDje+3rgiY/G57iiXOcRNzUccxx5vGIuxJCLGrSV8il8/4B
         E7rhmyrQHEx/wB+Z9CW1wz96IvEq+hC3edpHow4/1eTbnupidGt+9Y4Fa+lfqO7EUi
         OLJR+AZHucIYJ6M/mt5yxzyfzBigbeI3Fgz7JjLZav62AiDzmFxr4GICriOU09G/Hj
         /4lzkpmLdlThZBbb8qpP0amMjjFfNYgQv1iTpHyCJ9lBxDS05/+TWgR4SLys4qxRmI
         USD7Klh2QhO6A==
Received: by mail-ed1-f52.google.com with SMTP id bx12so20053883edb.8;
        Tue, 26 Jan 2021 06:52:44 -0800 (PST)
X-Gm-Message-State: AOAM532mxoCYUZskT8JnAZTaq3NVBVwRZ2QadjOFshXApMWunMFh/maH
        sgU61iG4N3yQKQQALrNsJm9o3X8s3GskZZvEgg==
X-Google-Smtp-Source: ABdhPJx9p+Z7FBDf1hYI1Kfn/L638Nk9D11uIpYesw9n6jxClik4PWGyAIMoLFtqYSEQp7jkpV+XQhsyE8iIOyuGiv0=
X-Received: by 2002:aa7:c895:: with SMTP id p21mr4836358eds.165.1611672763215;
 Tue, 26 Jan 2021 06:52:43 -0800 (PST)
MIME-Version: 1.0
References: <20210125024824.634583-1-xxm@rock-chips.com> <20210125024927.634634-1-xxm@rock-chips.com>
 <20210125054836.GB579511@unreal> <0b65ca38-ff7a-f9cd-5406-1f275fbbecd1@rock-chips.com>
 <20210125090129.GF579511@unreal>
In-Reply-To: <20210125090129.GF579511@unreal>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 26 Jan 2021 08:52:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJET8-gn-uy11EVHJAz057FVH3-BErwyL41W2WpxhgQUQ@mail.gmail.com>
Message-ID: <CAL_JsqJET8-gn-uy11EVHJAz057FVH3-BErwyL41W2WpxhgQUQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: rockchip: add DesignWare based PCIe controller
To:     Leon Romanovsky <leon@kernel.org>
Cc:     xxm <xxm@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 25, 2021 at 3:01 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Jan 25, 2021 at 02:40:10PM +0800, xxm wrote:
> > Hi Leon,
> >
> > Thanks for your reply.
> >
> > =E5=9C=A8 2021/1/25 13:48, Leon Romanovsky =E5=86=99=E9=81=93:
> > > On Mon, Jan 25, 2021 at 10:49:27AM +0800, Simon Xue wrote:
> > > > pcie-dw-rockchip is based on DWC IP. But pcie-rockchip-host
> > > > is Rockchip designed IP which is only used for RK3399. So all the f=
ollowing
> > > > non-RK3399 SoCs should use this driver.
> > > >
> > > > Signed-off-by: Simon Xue <xxm@rock-chips.com>
> > > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > > ---
> > > >   drivers/pci/controller/dwc/Kconfig            |   9 +
> > > >   drivers/pci/controller/dwc/Makefile           |   1 +
> > > >   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 286 +++++++++++++=
+++++
> > > >   3 files changed, 296 insertions(+)
> > > >   create mode 100644 drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/contr=
oller/dwc/Kconfig
> > > > index 22c5529e9a65..aee408fe9283 100644
> > > > --- a/drivers/pci/controller/dwc/Kconfig
> > > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > > @@ -214,6 +214,15 @@ config PCIE_ARTPEC6_EP
> > > >             Enables support for the PCIe controller in the ARTPEC-6=
 SoC to work in
> > > >             endpoint mode. This uses the DesignWare core.
> > > >
> > > > +config PCIE_ROCKCHIP_DW_HOST
> > > > + bool "Rockchip DesignWare PCIe controller"
> > > > + select PCIE_DW
> > > > + select PCIE_DW_HOST
> > > > + depends on ARCH_ROCKCHIP || COMPILE_TEST
> > > > + depends on OF
> > > > + help
> > > > +   Enables support for the DW PCIe controller in the Rockchip SoC.
> > > > +
> > > >   config PCIE_INTEL_GW
> > > >           bool "Intel Gateway PCIe host controller support"
> > > >           depends on OF && (X86 || COMPILE_TEST)
> > > > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/cont=
roller/dwc/Makefile
> > > > index a751553fa0db..30eef8e9ee8a 100644
> > > > --- a/drivers/pci/controller/dwc/Makefile
> > > > +++ b/drivers/pci/controller/dwc/Makefile
> > > > @@ -13,6 +13,7 @@ obj-$(CONFIG_PCI_LAYERSCAPE_EP) +=3D pci-layersca=
pe-ep.o
> > > >   obj-$(CONFIG_PCIE_QCOM) +=3D pcie-qcom.o
> > > >   obj-$(CONFIG_PCIE_ARMADA_8K) +=3D pcie-armada8k.o
> > > >   obj-$(CONFIG_PCIE_ARTPEC6) +=3D pcie-artpec6.o
> > > > +obj-$(CONFIG_PCIE_ROCKCHIP_DW_HOST) +=3D pcie-dw-rockchip.o
> > > >   obj-$(CONFIG_PCIE_INTEL_GW) +=3D pcie-intel-gw.o
> > > >   obj-$(CONFIG_PCIE_KIRIN) +=3D pcie-kirin.o
> > > >   obj-$(CONFIG_PCIE_HISI_STB) +=3D pcie-histb.o
> > > > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/driver=
s/pci/controller/dwc/pcie-dw-rockchip.c
> > > > new file mode 100644
> > > > index 000000000000..07f6d1cd5853
> > > > --- /dev/null
> > > > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > > @@ -0,0 +1,286 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * PCIe host controller driver for Rockchip SoCs
> > > > + *
> > > > + * Copyright (C) 2021 Rockchip Electronics Co., Ltd.
> > > > + *               http://www.rock-chips.com
> > > > + *
> > > > + * Author: Simon Xue <xxm@rock-chips.com>
> > > > + */
> > > > +
> > > > +#include <linux/clk.h>
> > > > +#include <linux/gpio/consumer.h>
> > > > +#include <linux/mfd/syscon.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of_device.h>
> > > > +#include <linux/phy/phy.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/regmap.h>
> > > > +#include <linux/reset.h>
> > > > +
> > > > +#include "pcie-designware.h"
> > > > +
> > > > +/*
> > > > + * The upper 16 bits of PCIE_CLIENT_CONFIG are a write
> > > > + * mask for the lower 16 bits.  This allows atomic updates
> > > > + * of the register without locking.
> > > > + */
> > > This is correct only for the variables that naturally aligned, I imag=
ine
> > > that this is the case here and in the Linux, but better do not write =
comments
> > > in the code that are not accurate.
> >
> > Ok, will remove.
> > I wonder what it would be when outside the Linux? Could you share some =
information?
>
> The C standard says nothing about atomicity, integer assignment maybe ato=
mic,
> maybe it isn=E2=80=99t. There is no guarantee, plain integer assignment i=
n C is non-atomic
> by definition.
>
> The atomicity of u32 is very dependent on hardware vendor, memory model a=
nd compiler,
> for example x86 and ARMs guarantee atomicity for u32. This is why I said =
that probably
> here (Linux) it is ok and you are not alone in expecting lockless write.

But this is a mmio register accessed thru writel() which does have all
those guarantees.

Rob
