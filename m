Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C445423BCFF
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 17:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgHDPN6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 11:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729305AbgHDPN3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 11:13:29 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35B4F22CBE;
        Tue,  4 Aug 2020 15:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596554003;
        bh=/VyvzXQa/AJF0fQ8y2ddiypbwJGanvNQVpDg2wnRSkc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JzgJXcblY2aiqIBY3aLoaCloWHWgaR70rKsKIYxIyOdz0DhDyOQk9jJjSNIfIzWWq
         4Q7zxNn9fw/LoWSXL4WxUWSnQbZlm/cWSZok98Th63VWbQ/WaUIdjWh4CCg+L4Ntup
         B1PCKPDjIx1Cos1t7RQtoiq6lDPRpUuVzWe3KIhs=
Received: by mail-yb1-f176.google.com with SMTP id q16so19910150ybk.6;
        Tue, 04 Aug 2020 08:13:23 -0700 (PDT)
X-Gm-Message-State: AOAM531Qt6r4ky/NaID5YExCsYxhqP29cKhOjQ5meM3aQ3XAyAiw0/qf
        mu3bA2dHlTq2zrmD2/I5VrACi396AuLjTjlVwA==
X-Google-Smtp-Source: ABdhPJxh9dJbSLfU6Nwv/yJMmnpLPR54KOz7EmmOkgm7Ly+4ylRFpnDySUtwPNVJNs/aSiEi9+iiHmUJSMEt/gWTgiQ=
X-Received: by 2002:a05:6830:1b79:: with SMTP id d25mr17121176ote.107.1596554001883;
 Tue, 04 Aug 2020 08:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200722022514.1283916-1-robh@kernel.org> <20200722022514.1283916-18-robh@kernel.org>
 <CAMuHMdWVWoQDc3MMv9LjA+hA1EoXQjVM-JfO_hVqnDf0tC8LJg@mail.gmail.com>
In-Reply-To: <CAMuHMdWVWoQDc3MMv9LjA+hA1EoXQjVM-JfO_hVqnDf0tC8LJg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Aug 2020 09:13:10 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+6Xcf5KT1Db5mGFWr9E04Jd8Rx4aVJpUmfUT8hPmtqBg@mail.gmail.com>
Message-ID: <CAL_Jsq+6Xcf5KT1Db5mGFWr9E04Jd8Rx4aVJpUmfUT8hPmtqBg@mail.gmail.com>
Subject: Re: [PATCH 17/19] PCI: rcar-gen2: Convert to use modern host bridge
 probe functions
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Will Deacon <will@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 4, 2020 at 6:12 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Wed, Jul 22, 2020 at 4:26 AM Rob Herring <robh@kernel.org> wrote:
> > The rcar-gen2 host driver still uses the old Arm PCI setup function
> > pci_common_init_dev(). Let's update it to use the modern
> > devm_pci_alloc_host_bridge(), pci_parse_request_of_pci_ranges() and
> > pci_host_probe() functions.
> >
> > Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-renesas-soc@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> This is now commit 92d69cc6275845a7 ("PCI: rcar-gen2: Convert to use
> modern host bridge probe functions"), and causes a crash on r8a7791/koelsch:

Can't say I'm surprised, this was a big change. Thanks for testing.


>     Unable to handle kernel NULL pointer dereference at virtual address 00000008
>     pgd = (ptrval)
>     [00000008] *pgd=00000000
>     Internal error: Oops: 5 [#1] SMP ARM
>     CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 5.8.0-rc1-shmobile-00035-g92d69cc6275845a7 #645
>     Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
>     PC is at rcar_pci_probe+0x154/0x340
>     LR is at _raw_spin_unlock_irqrestore+0x18/0x20
>
> > --- a/drivers/pci/controller/pci-rcar-gen2.c
> > +++ b/drivers/pci/controller/pci-rcar-gen2.c
> > @@ -189,19 +170,33 @@ static inline void rcar_pci_setup_errirq(struct rcar_pci_priv *priv) { }
> >  #endif
> >
> >  /* PCI host controller setup */
> > -static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
> > +static void rcar_pci_setup(struct rcar_pci_priv *priv)
> >  {
> > -       struct rcar_pci_priv *priv = sys->private_data;
> > +       struct pci_host_bridge *bridge = pci_host_bridge_from_priv(priv);
> >         struct device *dev = priv->dev;
> >         void __iomem *reg = priv->reg;
> > +       struct resource_entry *entry;
> > +       unsigned long window_size;
> > +       unsigned long window_addr;
> > +       unsigned long window_pci;
> >         u32 val;
> > -       int ret;
> > +
> > +       entry = resource_list_first_type(&bridge->dma_ranges, IORESOURCE_MEM);
>
> bridge->dma_ranges is not initialized => BOOM.
>
> >  static int rcar_pci_probe(struct platform_device *pdev)
> >  {
> >         struct device *dev = &pdev->dev;
> >         struct resource *cfg_res, *mem_res;
> >         struct rcar_pci_priv *priv;
> > +       struct pci_host_bridge *bridge;
> >         void __iomem *reg;
> > -       struct hw_pci hw;
> > -       void *hw_private[1];
> > +       int ret;
> > +
> > +       bridge = devm_pci_alloc_host_bridge(dev, sizeof(*priv));
> > +       if (!bridge)
> > +               return -ENOMEM;
> > +
> > +       priv = pci_host_bridge_priv(bridge);
>
> This is the "new" priv instance.
>
> > +       bridge->sysdata = priv;
> >
> >         cfg_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >         reg = devm_ioremap_resource(dev, cfg_res);
>
> However, the "old" instance is still allocated below, and should be removed.
>
> I've send a patch to fix that, which should appear soon at
> https://lore.kernel.org/r/20200804120430.9253-1-geert+renesas@glider.be
>
> BTW, the conversion has the following impact on r8a7791/koelsch:
>
>     -pci-rcar-gen2 ee090000.pci: PCI: bus0 revision 11
>     +pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
>     +pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff
> -> 0x00ee080000
>     +pci-rcar-gen2 ee090000.pci: PCI: revision 11
>      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
>     -pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
>                                              ^^^^^^^^^^^^^^^^^^^^^
>     -pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
>     +pci_bus 0000:00: root bus resource [bus 00]
>     +pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
>                                              ^^^^^^^^^^^^^^^^^^^^^
>
>     pci0: pci@ee090000 {
>             ...
>             reg = <0 0xee090000 0 0xc00>,
>                   <0 0xee080000 0 0x1100>;
>             ...
>             ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
>             ...
>             usb@1,0 {
>                     reg = <0x800 0 0 0 0>;
>                     ...
>             };
>
>             usb@2,0 {
>                     reg = <0x1000 0 0 0 0>;
>                     ...
>             };
>
>     }
>
> The old root bus resource size was based on the "reg" property.
> The new root bus resource size is based on the "ranges" property.

That was wrong to have PCI memory space in 'reg', but the driver could
always adjust the size to 0x1100 if needed.

BTW, the binding description seems to have the 'reg' description reversed.

> Given the only children are hardcoded, I guess that is OK?

In the sense that those are the only 2 devices and you know their
memory fits, yes. However, the memory space itself isn't hardcoded. If
you wanted to do that, then the children really need
'assigned-addresses' properties. I guess it happens to work because
memory space is allocated from the start and goes in order of device
addresses. But if that changed to top down allocation?

Rob
