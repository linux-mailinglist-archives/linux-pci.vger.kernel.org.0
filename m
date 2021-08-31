Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0526E3FCCF2
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 20:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbhHaSZS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Aug 2021 14:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232870AbhHaSZS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Aug 2021 14:25:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F42760FE8;
        Tue, 31 Aug 2021 18:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630434262;
        bh=JppPB/r91xiHliv4KMyg+e4WdWnb/md7Nq5OwRDXCJQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lM3iIqS0bv/TZAayziHSuifgl2v9HezM8iyfdyKEjuSdK2EPbRzrin7MzBre7U+ow
         ZsMwfMS7DSxzWhm6UFMVDOp3/L+OqlsHDRhQhiMNj2C2XcTXfdzJpUs+Y1EnnoJDMv
         OlV+MLef2DrOFUQG9m4kfBSLNlVIdIvV5wRomvHA2EPxUoq71cIYhDG+K+DxdxjZJA
         GRibCKFSOpqzYumk7jGDlDQgyLRVM69YR/pyXFeZjbq5OHIJyEYv/M0kQ9BIBR+9su
         hE+KLqybUKR1q9ywtSEyOiJ2bhperswXQxa4Wz/vqDv0TK+A0vnbNCP5mUmsayhoUC
         9YLGnaPWMOhLA==
Received: by mail-ej1-f43.google.com with SMTP id t19so734538ejr.8;
        Tue, 31 Aug 2021 11:24:22 -0700 (PDT)
X-Gm-Message-State: AOAM533NgxHWIZBG40iU9NTiYm4nx9BO70TUhfGryAVJ6/2oXyQf9IRb
        B2s5Pub4MofiSKpbCrcmzT8NrR1jjUelysk5JA==
X-Google-Smtp-Source: ABdhPJx0bWUTQpVcwF3zUZB8CpqetIM2G7wA1PzLMXQI4MWCrkFokKMqKxjrdpW/NUMoT4LNfTTn7o0aQrfDcpk04lI=
X-Received: by 2002:a17:907:b06:: with SMTP id h6mr30094347ejl.130.1630434261057;
 Tue, 31 Aug 2021 11:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_JsqKEvAypWhiaWMhxM7zVkLAFL9=eMU7_vr=ht+uyxYe0qg@mail.gmail.com>
 <20210831154711.GA107126@bjorn-Precision-5520>
In-Reply-To: <20210831154711.GA107126@bjorn-Precision-5520>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 31 Aug 2021 13:24:09 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+y=-UTv6B5cGG5p-q-rzzyEuWZ_Q6YKPT=Jej1boZwjQ@mail.gmail.com>
Message-ID: <CAL_Jsq+y=-UTv6B5cGG5p-q-rzzyEuWZ_Q6YKPT=Jej1boZwjQ@mail.gmail.com>
Subject: Re: [PATCH v12 2/6] PCI: mediatek: Add new method to get shared
 pcie-cfg base address
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Chuanjia Liu <chuanjia.liu@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        PCI <linux-pci@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 31, 2021 at 10:47 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Aug 31, 2021 at 10:04:40AM -0500, Rob Herring wrote:
> > On Fri, Aug 27, 2021 at 11:46 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Mon, Aug 23, 2021 at 11:27:56AM +0800, Chuanjia Liu wrote:
> > > > For the new dts format, add a new method to get
> > > > shared pcie-cfg base address and use it to configure
> > > > the PCIECFG controller
> > >
> > > Rewrap this to fill 75 columns.
> > >
> > > > Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
> > > > Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> > > > ---
> > > >  drivers/pci/controller/pcie-mediatek.c | 17 +++++++++++++++++
> > > >  1 file changed, 17 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > > > index 25bee693834f..4296d9e04240 100644
> > > > --- a/drivers/pci/controller/pcie-mediatek.c
> > > > +++ b/drivers/pci/controller/pcie-mediatek.c
> > > > @@ -14,6 +14,7 @@
> > > >  #include <linux/irqchip/chained_irq.h>
> > > >  #include <linux/irqdomain.h>
> > > >  #include <linux/kernel.h>
> > > > +#include <linux/mfd/syscon.h>
> > > >  #include <linux/msi.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/of_address.h>
> > > > @@ -23,6 +24,7 @@
> > > >  #include <linux/phy/phy.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/pm_runtime.h>
> > > > +#include <linux/regmap.h>
> > > >  #include <linux/reset.h>
> > > >
> > > >  #include "../pci.h"
> > > > @@ -207,6 +209,7 @@ struct mtk_pcie_port {
> > > >   * struct mtk_pcie - PCIe host information
> > > >   * @dev: pointer to PCIe device
> > > >   * @base: IO mapped register base
> > > > + * @cfg: IO mapped register map for PCIe config
> > > >   * @free_ck: free-run reference clock
> > > >   * @mem: non-prefetchable memory resource
> > > >   * @ports: pointer to PCIe port information
> > > > @@ -215,6 +218,7 @@ struct mtk_pcie_port {
> > > >  struct mtk_pcie {
> > > >       struct device *dev;
> > > >       void __iomem *base;
> > > > +     struct regmap *cfg;
> > > >       struct clk *free_ck;
> > > >
> > > >       struct list_head ports;
> > > > @@ -682,6 +686,10 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> > > >               val |= PCIE_CSR_LTSSM_EN(port->slot) |
> > > >                      PCIE_CSR_ASPM_L1_EN(port->slot);
> > > >               writel(val, pcie->base + PCIE_SYS_CFG_V2);
> > > > +     } else if (pcie->cfg) {
> > > > +             val = PCIE_CSR_LTSSM_EN(port->slot) |
> > > > +                   PCIE_CSR_ASPM_L1_EN(port->slot);
> > > > +             regmap_update_bits(pcie->cfg, PCIE_SYS_CFG_V2, val, val);
> > > >       }
> > > >
> > > >       /* Assert all reset signals */
> > > > @@ -985,6 +993,7 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
> > > >       struct device *dev = pcie->dev;
> > > >       struct platform_device *pdev = to_platform_device(dev);
> > > >       struct resource *regs;
> > > > +     struct device_node *cfg_node;
> > > >       int err;
> > > >
> > > >       /* get shared registers, which are optional */
> > > > @@ -995,6 +1004,14 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
> > > >                       return PTR_ERR(pcie->base);
> > > >       }
> > > >
> > > > +     cfg_node = of_find_compatible_node(NULL, NULL,
> > > > +                                        "mediatek,generic-pciecfg");
> > >
> > > This looks wrong to me.  IIUC, since we start at NULL, this searches
> > > the entire device tree for any node with
> > >
> > >   compatible = "mediatek,generic-pciecfg"
> > >
> > > but we should only care about the specific device/node this driver
> > > claimed.
> > >
> > > Should this be part of the match data, i.e., struct mtk_pcie_soc?
> >
> > What would you put in match data exactly?
> >
> > The other way to do this is to have a DT property with the phandle
> > which people like to do (have everything in the node 'for their
> > driver'). If there's only 1 possible node (which is almost always the
> > case), then there is little benefit to having another property. It's
> > just redundant data. A phandle lookup might be a bit faster with the
> > caching we do, but on a miss it would still walk all nodes.
> >
> > The other thing with these 'extra register bits to twiddle' is that
> > they tend to be SoC specific and change from chip to chip, so either
> > way is not very portable. The real question to ask is should there be
> > a standard interface used or created.
> >
> > > > +     if (cfg_node) {
> > > > +             pcie->cfg = syscon_node_to_regmap(cfg_node);
> > >
> > > Other drivers in drivers/pci/controller/ use
> > > syscon_regmap_lookup_by_phandle() (j721e, dra7xx, keystone,
> > > layerscape, artpec6) or syscon_regmap_lookup_by_compatible() (imx6,
> > > kirin, v3-semi).
> >
> > There's no phandle to use in this case. As above, I'm trying to break
> > people of this habit.
>
> Thanks!  I was mistaken in lots of ways here.  I first assumed
> "mediatek,generic-pciecfg" was local to the pcie node, but that's not
> true.  Then I thought there might be an ownership issue because the
> regmap is not local to the device, and several drivers look up and use
> the same regmap.  But it looks like regmap provides some internal
> locking which mitigates most or all of that concern.
>
> Just to check -- you prefer syscon_regmap_lookup_by_compatible() over
> syscon_regmap_lookup_by_phandle()?

Yes, unless there is either more than 1 instance of the syscon or some
additional data specific to the user (e.g. a register offset).

Rob
