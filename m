Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8308922B361
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jul 2020 18:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgGWQV6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jul 2020 12:21:58 -0400
Received: from foss.arm.com ([217.140.110.172]:48280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgGWQV6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Jul 2020 12:21:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B1BA1FB;
        Thu, 23 Jul 2020 09:21:57 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CC683F66F;
        Thu, 23 Jul 2020 09:21:53 -0700 (PDT)
Date:   Thu, 23 Jul 2020 17:21:48 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>
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
Subject: Re: [PATCH 11/19] PCI: Move setting pci_host_bridge.busnr out of
 host drivers
Message-ID: <20200723162148.GA11749@e121166-lin.cambridge.arm.com>
References: <20200722022514.1283916-1-robh@kernel.org>
 <20200722022514.1283916-12-robh@kernel.org>
 <CAL_Jsq+sPaubVERLHaRzjvThk3zDO6zAnRQjGuAMKaVA87Y4HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+sPaubVERLHaRzjvThk3zDO6zAnRQjGuAMKaVA87Y4HQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 23, 2020 at 09:26:01AM -0600, Rob Herring wrote:
> On Tue, Jul 21, 2020 at 8:25 PM Rob Herring <robh@kernel.org> wrote:
> >
> > Most host drivers only parse the DT bus range to set the root bus number
> > in pci_host_bridge.busnr. The ones that don't set busnr are buggy in
> > that they ignore what's in DT. Let's set busnr in pci_scan_root_bus_bridge()
> > where we already check for the bus resource and remove setting it in
> > host drivers.
> >
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Jonathan Hunter <jonathanh@nvidia.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Ryder Lee <ryder.lee@mediatek.com>
> > Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Cc: linux-tegra@vger.kernel.org
> > Cc: linux-mediatek@lists.infradead.org
> > Cc: linux-renesas-soc@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 4 ----
> >  drivers/pci/controller/dwc/pcie-designware.h      | 1 -
> >  drivers/pci/controller/pci-aardvark.c             | 5 ++---
> >  drivers/pci/controller/pci-host-common.c          | 1 -
> >  drivers/pci/controller/pci-tegra.c                | 4 +---
> >  drivers/pci/controller/pci-v3-semi.c              | 2 --
> >  drivers/pci/controller/pcie-mediatek.c            | 8 +-------
> >  drivers/pci/controller/pcie-rcar-host.c           | 1 -
> >  drivers/pci/probe.c                               | 1 +
> >  9 files changed, 5 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 9e8a9cfc6d3a..fa922cb876a3 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -374,9 +374,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >                         pp->cfg0_base = pp->cfg->start;
> >                         pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
> >                         break;
> > -               case IORESOURCE_BUS:
> > -                       pp->busn = win->res;
> > -                       break;
> >                 }
> >         }
> >
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index fd2146298b58..9fb44290ed43 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -188,7 +188,6 @@ struct pcie_port {
> >         struct resource         *cfg;
> >         struct resource         *io;
> >         struct resource         *mem;
> > -       struct resource         *busn;
> >         int                     irq;
> >         const struct dw_pcie_host_ops *ops;
> >         int                     msi_irq;
> 
> These 2 hunks should be dropped as they are breaking the Amazon driver.
> 
> Lorenzo, do you want to fixup or I can send a fix?

Done (I have not removed the hunk below though):

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9e8a9cfc6d3a..9775558acdc8 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -474,7 +474,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	}

 	bridge->sysdata = pp;
-	bridge->busnr = pp->busn->start;
 	bridge->ops = &dw_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
