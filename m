Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED713DF7B6
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 00:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhHCWSg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 18:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhHCWSf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 18:18:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E242460F01;
        Tue,  3 Aug 2021 22:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628029099;
        bh=dmC4L4bdvyZSiNCr9W4OaXUElnomSjOVPWbBcAd+9is=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RrG6MtmCWws8IM+oQHZh1IlmLZB/o+sqQgZ+5bNkSDgZNw4GHDdsp+QzG5J9q6qJa
         vTK9XXmq4PXKzSCyWteROUS+J0DSxAF1Pw1Hvnh5lrLAyj3vyTLNoj4ESTe84yvbe2
         L/F9XT9ReVnrZURKDfzBOpT7UOO8uAel/Txopu6hsIDBo/AO3SF5kxhBDUKPH/ObCA
         M5n4cK+YqnftYGnliPRIYKuJskSy61SXszNMpxhl0JIqzJwhaA1swxtpP4lEyTGzAD
         ad2KX1n4l0JkWoDqTkRZpmfc86RcYVdPKDUshIoTMcQbohGC7yWXwmLwWqB8ypbFsA
         oVGZ8c3HnrC8g==
Received: by mail-ed1-f54.google.com with SMTP id p21so996130edi.9;
        Tue, 03 Aug 2021 15:18:19 -0700 (PDT)
X-Gm-Message-State: AOAM530fjLWnrUwXjASN/QPc6+9JtVctFcP8n2qPd9/iWT/pxlhkdSWz
        ak8P6vavuI0rBmqMUJMrtptDkIyElFJoeQ4KtA==
X-Google-Smtp-Source: ABdhPJw6FD5Y41IoWVgZfbbuhV/RKvp2qBB181ykknmZg/sbKiL5Obes9EzO5aidDxmyPOEgKDnB+xFldDHzlbfmRQY=
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr28647216edt.194.1628029098472;
 Tue, 03 Aug 2021 15:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210719073456.28666-1-chuanjia.liu@mediatek.com>
 <20210719073456.28666-3-chuanjia.liu@mediatek.com> <1626749978.2466.14.camel@mhfsdcap03>
In-Reply-To: <1626749978.2466.14.camel@mhfsdcap03>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 3 Aug 2021 16:18:07 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+DcNe8jVqisHXt3jQHeJAoLKmiah7o8ePVKra5OvAbGA@mail.gmail.com>
Message-ID: <CAL_Jsq+DcNe8jVqisHXt3jQHeJAoLKmiah7o8ePVKra5OvAbGA@mail.gmail.com>
Subject: Re: [PATCH v11 2/4] PCI: mediatek: Add new method to get shared
 pcie-cfg base address and parse node
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        PCI <linux-pci@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 19, 2021 at 8:59 PM Chuanjia Liu <chuanjia.liu@mediatek.com> wr=
ote:
>
> On Mon, 2021-07-19 at 15:34 +0800, Chuanjia Liu wrote:
> > For the new dts format, add a new method to get
> > shared pcie-cfg base address and parse node.
> >
> > Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
> > Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 52 +++++++++++++++++++-------
> >  1 file changed, 39 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/contr=
oller/pcie-mediatek.c
> > index 25bee693834f..928e0983a900 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/irqchip/chained_irq.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/kernel.h>
> > +#include <linux/mfd/syscon.h>
> >  #include <linux/msi.h>
> >  #include <linux/module.h>
> >  #include <linux/of_address.h>
> > @@ -23,6 +24,7 @@
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> >  #include <linux/reset.h>
> >
> >  #include "../pci.h"
> > @@ -207,6 +209,7 @@ struct mtk_pcie_port {
> >   * struct mtk_pcie - PCIe host information
> >   * @dev: pointer to PCIe device
> >   * @base: IO mapped register base
> > + * @cfg: IO mapped register map for PCIe config
> >   * @free_ck: free-run reference clock
> >   * @mem: non-prefetchable memory resource
> >   * @ports: pointer to PCIe port information
> > @@ -215,6 +218,7 @@ struct mtk_pcie_port {
> >  struct mtk_pcie {
> >       struct device *dev;
> >       void __iomem *base;
> > +     struct regmap *cfg;
> >       struct clk *free_ck;
> >
> >       struct list_head ports;
> > @@ -650,7 +654,11 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port=
 *port,
> >               return err;
> >       }
> >
> > -     port->irq =3D platform_get_irq(pdev, port->slot);
> > +     if (of_find_property(dev->of_node, "interrupt-names", NULL))
> > +             port->irq =3D platform_get_irq_byname(pdev, "pcie_irq");
> > +     else
> > +             port->irq =3D platform_get_irq(pdev, port->slot);
> > +
> >       if (port->irq < 0)
> >               return port->irq;
> >
> > @@ -682,6 +690,10 @@ static int mtk_pcie_startup_port_v2(struct mtk_pci=
e_port *port)
> >               val |=3D PCIE_CSR_LTSSM_EN(port->slot) |
> >                      PCIE_CSR_ASPM_L1_EN(port->slot);
> >               writel(val, pcie->base + PCIE_SYS_CFG_V2);
> > +     } else if (pcie->cfg) {
> > +             val =3D PCIE_CSR_LTSSM_EN(port->slot) |
> > +                   PCIE_CSR_ASPM_L1_EN(port->slot);
> > +             regmap_update_bits(pcie->cfg, PCIE_SYS_CFG_V2, val, val);
> >       }
> >
> >       /* Assert all reset signals */
> > @@ -985,6 +997,7 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie =
*pcie)
> >       struct device *dev =3D pcie->dev;
> >       struct platform_device *pdev =3D to_platform_device(dev);
> >       struct resource *regs;
> > +     struct device_node *cfg_node;
> >       int err;
> >
> >       /* get shared registers, which are optional */
> > @@ -995,6 +1008,14 @@ static int mtk_pcie_subsys_powerup(struct mtk_pci=
e *pcie)
> >                       return PTR_ERR(pcie->base);
> >       }
> >
> > +     cfg_node =3D of_find_compatible_node(NULL, NULL,
> > +                                        "mediatek,generic-pciecfg");
> > +     if (cfg_node) {
> > +             pcie->cfg =3D syscon_node_to_regmap(cfg_node);
> > +             if (IS_ERR(pcie->cfg))
> > +                     return PTR_ERR(pcie->cfg);
> > +     }
> > +
> >       pcie->free_ck =3D devm_clk_get(dev, "free_ck");
> >       if (IS_ERR(pcie->free_ck)) {
> >               if (PTR_ERR(pcie->free_ck) =3D=3D -EPROBE_DEFER)
> > @@ -1027,22 +1048,27 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie=
)
> >       struct device *dev =3D pcie->dev;
> >       struct device_node *node =3D dev->of_node, *child;
> >       struct mtk_pcie_port *port, *tmp;
> > -     int err;
> > +     int err, slot;
> > +
> > +     slot =3D of_get_pci_domain_nr(dev->of_node);
> > +     if (slot < 0) {
> > +             for_each_available_child_of_node(node, child) {
> > +                     err =3D of_pci_get_devfn(child);
> > +                     if (err < 0) {
> > +                             dev_err(dev, "failed to get devfn: %d\n",=
 err);
> > +                             goto error_put_node;
> > +                     }
> >
> > -     for_each_available_child_of_node(node, child) {
> > -             int slot;
> > +                     slot =3D PCI_SLOT(err);
> >
> > -             err =3D of_pci_get_devfn(child);
> > -             if (err < 0) {
> > -                     dev_err(dev, "failed to parse devfn: %d\n", err);
> > -                     goto error_put_node;
> > +                     err =3D mtk_pcie_parse_port(pcie, child, slot);
> > +                     if (err)
> > +                             goto error_put_node;
> >               }
> > -
> > -             slot =3D PCI_SLOT(err);
> > -
> > -             err =3D mtk_pcie_parse_port(pcie, child, slot);
> > +     } else {
> > +             err =3D mtk_pcie_parse_port(pcie, node, slot);
> >               if (err)
> > -                     goto error_put_node;
> > +                     return err;
>
> Hi=EF=BC=8CRob
> I changed this in the v9 version:
> When the new dts format is used, of_node_get() is not called.
> So when mtk_pcie_parse_port fails, of_node_put don't need to be called.
> if you still ok for this, I will add R-b in next version.

Yes, and that's small enough change to keep my R-b.

Rob
