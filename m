Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0227C22B3F8
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jul 2020 18:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgGWQ4J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jul 2020 12:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgGWQ4I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Jul 2020 12:56:08 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E179C22C9E;
        Thu, 23 Jul 2020 16:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595523368;
        bh=9qNrdyKreXu55OEnqmMFmaXouq8WzhxQTRQhDqKFzO0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o6wMUa0PL7/6U5SHYS/PNagOvSs/yXS6zJA7IduXu9mNIItpgxVjzh/vehP9o1uS5
         7GU3azUhN1T2k4Slzl92tsJ0l5ngaMocjpWth3sl4E1Xrg/tUitOIxqUF5gFcxkFCk
         Xw5plQoEsDbZISRNB4LwPsRwJDiMjQVXpLVLYST0=
Received: by mail-oi1-f182.google.com with SMTP id 12so5608396oir.4;
        Thu, 23 Jul 2020 09:56:07 -0700 (PDT)
X-Gm-Message-State: AOAM533Su8a7BDBwduEvNbbUZlQu5a+sy6ZhQB+ECVOqGsN1nHe0iMV6
        /kltMSb3BnW+2h45FZcNncSzb2Oay7IZMc07zQ==
X-Google-Smtp-Source: ABdhPJxlKZuS4ILTZ0+IoSoyVcDFqevHuf8OXw4KW6x7xfb5X7pMDe0Ld53HmKjmZM6D5msfxGLb+rIS+n0uKMrGU/A=
X-Received: by 2002:aca:bb82:: with SMTP id l124mr4763076oif.106.1595523367119;
 Thu, 23 Jul 2020 09:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200722022514.1283916-1-robh@kernel.org> <20200722022514.1283916-12-robh@kernel.org>
 <CAL_Jsq+sPaubVERLHaRzjvThk3zDO6zAnRQjGuAMKaVA87Y4HQ@mail.gmail.com> <20200723162148.GA11749@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200723162148.GA11749@e121166-lin.cambridge.arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 23 Jul 2020 10:55:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKFVuJGcCTgANF_R8EcvrTGw8WdOT1SDfAMSYrimGgKKQ@mail.gmail.com>
Message-ID: <CAL_JsqKFVuJGcCTgANF_R8EcvrTGw8WdOT1SDfAMSYrimGgKKQ@mail.gmail.com>
Subject: Re: [PATCH 11/19] PCI: Move setting pci_host_bridge.busnr out of host drivers
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
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
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 23, 2020 at 10:21 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Jul 23, 2020 at 09:26:01AM -0600, Rob Herring wrote:
> > On Tue, Jul 21, 2020 at 8:25 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > Most host drivers only parse the DT bus range to set the root bus number
> > > in pci_host_bridge.busnr. The ones that don't set busnr are buggy in
> > > that they ignore what's in DT. Let's set busnr in pci_scan_root_bus_bridge()
> > > where we already check for the bus resource and remove setting it in
> > > host drivers.
> > >
> > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: Jonathan Hunter <jonathanh@nvidia.com>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Ryder Lee <ryder.lee@mediatek.com>
> > > Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
> > > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Cc: linux-tegra@vger.kernel.org
> > > Cc: linux-mediatek@lists.infradead.org
> > > Cc: linux-renesas-soc@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 4 ----
> > >  drivers/pci/controller/dwc/pcie-designware.h      | 1 -
> > >  drivers/pci/controller/pci-aardvark.c             | 5 ++---
> > >  drivers/pci/controller/pci-host-common.c          | 1 -
> > >  drivers/pci/controller/pci-tegra.c                | 4 +---
> > >  drivers/pci/controller/pci-v3-semi.c              | 2 --
> > >  drivers/pci/controller/pcie-mediatek.c            | 8 +-------
> > >  drivers/pci/controller/pcie-rcar-host.c           | 1 -
> > >  drivers/pci/probe.c                               | 1 +
> > >  9 files changed, 5 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 9e8a9cfc6d3a..fa922cb876a3 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -374,9 +374,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > >                         pp->cfg0_base = pp->cfg->start;
> > >                         pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
> > >                         break;
> > > -               case IORESOURCE_BUS:
> > > -                       pp->busn = win->res;
> > > -                       break;
> > >                 }
> > >         }
> > >
> >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index fd2146298b58..9fb44290ed43 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -188,7 +188,6 @@ struct pcie_port {
> > >         struct resource         *cfg;
> > >         struct resource         *io;
> > >         struct resource         *mem;
> > > -       struct resource         *busn;
> > >         int                     irq;
> > >         const struct dw_pcie_host_ops *ops;
> > >         int                     msi_irq;
> >
> > These 2 hunks should be dropped as they are breaking the Amazon driver.
> >
> > Lorenzo, do you want to fixup or I can send a fix?
>
> Done (I have not removed the hunk below though):

Right, that's correct. I'll post a separate patch removing 'pp->busn'
as that's available from the bridge struct. The bridge struct
surprisingly is not accessible from the DWC structs. I guess that's
why there's a bunch of duplication of data.

Rob

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 9e8a9cfc6d3a..9775558acdc8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -474,7 +474,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>         }
>
>         bridge->sysdata = pp;
> -       bridge->busnr = pp->busn->start;
>         bridge->ops = &dw_pcie_ops;
>         bridge->map_irq = of_irq_parse_and_map_pci;
>         bridge->swizzle_irq = pci_common_swizzle;
