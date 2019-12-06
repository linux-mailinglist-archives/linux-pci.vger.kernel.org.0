Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96CB7115205
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2019 15:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfLFOJI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Dec 2019 09:09:08 -0500
Received: from foss.arm.com ([217.140.110.172]:45790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfLFOJI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Dec 2019 09:09:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9397D1FB;
        Fri,  6 Dec 2019 06:09:07 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F249A3F718;
        Fri,  6 Dec 2019 06:09:03 -0800 (PST)
Date:   Fri, 6 Dec 2019 14:09:01 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Christoph Hellwig <hch@infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Simon Horman <horms@verge.net.au>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Scott Branden <sbranden@broadcom.com>,
        Jingoo Han <jingoohan1@gmail.com>, rfi@lists.rocketboards.org,
        linux-renesas-soc@vger.kernel.org,
        Tom Joseph <tjoseph@cadence.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v3 10/25] PCI: rockchip: Use
 pci_parse_request_of_pci_ranges()
Message-ID: <20191206140901.GB26562@e121166-lin.cambridge.arm.com>
References: <20191028163256.8004-1-robh@kernel.org>
 <20191028163256.8004-11-robh@kernel.org>
 <CAFqH_51-BMWSGGBpoKxA3UK+yPHSpPgok5i=daSC0KS5oc5ueA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqH_51-BMWSGGBpoKxA3UK+yPHSpPgok5i=daSC0KS5oc5ueA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 05, 2019 at 06:56:01PM +0100, Enric Balletbo Serra wrote:
> Hi Rob,
> 
> Missatge de Rob Herring <robh@kernel.org> del dia dl., 28 d’oct. 2019
> a les 17:38:
> >
> > Convert the Rockchip host bridge to use the common
> > pci_parse_request_of_pci_ranges().
> >
> > There's no need to assign the resources to a temporary list first. Just
> > use bridge->windows directly and remove all the temporary list handling.
> >
> > Cc: Shawn Lin <shawn.lin@rock-chips.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Andrew Murray <andrew.murray@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: linux-rockchip@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> 
> I just tested mainline on my Samsung Chromebook Plus, and since
> yesterday I'm getting a "synchronous external abort" [1]. After a
> bisection, I found that this patch triggers the issue (this patch was
> merged yesterday)

This patch standalone triggers a compilation error - so it does
trigger a bisection but not the one you are enquiring about.

Can you try to bisect it again and report back please ?

Thanks,
Lorenzo

> I didn't look in detail yet, but if you have any idea of what could be
> the problem, that would be great.
> 
> Thanks,
>  Enric
> 
> [1] https://hastebin.com/adasegihiw.rb
> 
> >  drivers/pci/controller/pcie-rockchip-host.c | 36 ++++-----------------
> >  1 file changed, 7 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> > index ef8e677ce9d1..8d2e6f2e141e 100644
> > --- a/drivers/pci/controller/pcie-rockchip-host.c
> > +++ b/drivers/pci/controller/pcie-rockchip-host.c
> > @@ -950,14 +950,10 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> >         struct device *dev = &pdev->dev;
> >         struct pci_bus *bus, *child;
> >         struct pci_host_bridge *bridge;
> > +       struct resource *bus_res;
> >         struct resource_entry *win;
> > -       resource_size_t io_base;
> > -       struct resource *mem;
> > -       struct resource *io;
> >         int err;
> >
> > -       LIST_HEAD(res);
> > -
> >         if (!dev->of_node)
> >                 return -ENODEV;
> >
> > @@ -995,29 +991,20 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> >         if (err < 0)
> >                 goto err_deinit_port;
> >
> > -       err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> > -                                                   &res, &io_base);
> > +       err = pci_parse_request_of_pci_ranges(dev, &bridge->windows, &bus_res);
> >         if (err)
> >                 goto err_remove_irq_domain;
> >
> > -       err = devm_request_pci_bus_resources(dev, &res);
> > -       if (err)
> > -               goto err_free_res;
> > +       rockchip->root_bus_nr = bus_res->start;
> >
> >         /* Get the I/O and memory ranges from DT */
> > -       resource_list_for_each_entry(win, &res) {
> > +       resource_list_for_each_entry(win, &bridge->windows) {
> >                 switch (resource_type(win->res)) {
> >                 case IORESOURCE_IO:
> >                         io = win->res;
> >                         io->name = "I/O";
> >                         rockchip->io_size = resource_size(io);
> >                         rockchip->io_bus_addr = io->start - win->offset;
> > -                       err = pci_remap_iospace(io, io_base);
> > -                       if (err) {
> > -                               dev_warn(dev, "error %d: failed to map resource %pR\n",
> > -                                        err, io);
> > -                               continue;
> > -                       }
> >                         rockchip->io = io;
> >                         break;
> >                 case IORESOURCE_MEM:
> > @@ -1026,9 +1013,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> >                         rockchip->mem_size = resource_size(mem);
> >                         rockchip->mem_bus_addr = mem->start - win->offset;
> >                         break;
> > -               case IORESOURCE_BUS:
> > -                       rockchip->root_bus_nr = win->res->start;
> > -                       break;
> >                 default:
> >                         continue;
> >                 }
> > @@ -1036,15 +1020,14 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> >
> >         err = rockchip_pcie_cfg_atu(rockchip);
> >         if (err)
> > -               goto err_unmap_iospace;
> > +               goto err_remove_irq_domain;
> >
> >         rockchip->msg_region = devm_ioremap(dev, rockchip->msg_bus_addr, SZ_1M);
> >         if (!rockchip->msg_region) {
> >                 err = -ENOMEM;
> > -               goto err_unmap_iospace;
> > +               goto err_remove_irq_domain;
> >         }
> >
> > -       list_splice_init(&res, &bridge->windows);
> >         bridge->dev.parent = dev;
> >         bridge->sysdata = rockchip;
> >         bridge->busnr = 0;
> > @@ -1054,7 +1037,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> >
> >         err = pci_scan_root_bus_bridge(bridge);
> >         if (err < 0)
> > -               goto err_unmap_iospace;
> > +               goto err_remove_irq_domain;
> >
> >         bus = bridge->bus;
> >
> > @@ -1068,10 +1051,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> >         pci_bus_add_devices(bus);
> >         return 0;
> >
> > -err_unmap_iospace:
> > -       pci_unmap_iospace(rockchip->io);
> > -err_free_res:
> > -       pci_free_resource_list(&res);
> >  err_remove_irq_domain:
> >         irq_domain_remove(rockchip->irq_domain);
> >  err_deinit_port:
> > @@ -1097,7 +1076,6 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
> >
> >         pci_stop_root_bus(rockchip->root_bus);
> >         pci_remove_root_bus(rockchip->root_bus);
> > -       pci_unmap_iospace(rockchip->io);
> >         irq_domain_remove(rockchip->irq_domain);
> >
> >         rockchip_pcie_deinit_phys(rockchip);
> > --
> > 2.20.1
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
