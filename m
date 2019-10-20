Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96E63DE0BF
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2019 23:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfJTVkM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Oct 2019 17:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfJTVkM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 20 Oct 2019 17:40:12 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 765A1222CD;
        Sun, 20 Oct 2019 21:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571607610;
        bh=qgl8etf05zFSFgrmUt3a3ejlLNLZr9gR4jAYnTio8dk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q+vGSyU0uunAMGyJHqC4IiX+kVlgyKYyHxP/pjaRaZmfKnRL2VTBpkfdpUAFBxG9q
         6c97x2oAjqdPPs4ysequSxUmA3zKFsb50RTtwqCTpO4QsDH+aaRWz04KuWj2yTvPWo
         Do6FKvjIOO5BaYpnds4KsoqGAuXrTt95tibK6ig0=
Received: by mail-qt1-f172.google.com with SMTP id g50so3604788qtb.4;
        Sun, 20 Oct 2019 14:40:10 -0700 (PDT)
X-Gm-Message-State: APjAAAXLx9POO5z+znrLmysH60IlZ83yP3g0Pe3ttrwGYmHoSDEjoXMN
        DMRBUd1yF2Poet4fdc3frA+VRwuY2s/CSOPkYg==
X-Google-Smtp-Source: APXvYqyPNdeHc97P9vjK6aAr1OKGgzvAPW2UkIiZ4oCT73veRFA/jHuYzT+Hd/cVM4y/SwD9YgTWhEfrCQ8HEGQNi2k=
X-Received: by 2002:ac8:4508:: with SMTP id q8mr5790443qtn.110.1571607609587;
 Sun, 20 Oct 2019 14:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191016200647.32050-1-robh@kernel.org> <20191016200647.32050-6-robh@kernel.org>
 <20191018123537.GG47056@e119886-lin.cambridge.arm.com>
In-Reply-To: <20191018123537.GG47056@e119886-lin.cambridge.arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Sun, 20 Oct 2019 16:39:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLchmnwV3=Ufrs0sxc+ye5kzyKdenUa+cWxiMEzf0rFCA@mail.gmail.com>
Message-ID: <CAL_JsqLchmnwV3=Ufrs0sxc+ye5kzyKdenUa+cWxiMEzf0rFCA@mail.gmail.com>
Subject: Re: [PATCH v2 05/25] PCI: dwc: Use pci_parse_request_of_pci_ranges()
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 18, 2019 at 7:35 AM Andrew Murray <andrew.murray@arm.com> wrote:
>
> On Wed, Oct 16, 2019 at 03:06:27PM -0500, Rob Herring wrote:
> > Convert the Designware host bridge to use the common
> > pci_parse_request_of_pci_ranges().
> >
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Andrew Murray <andrew.murray@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v2:
> > - New patch
> >
> >  .../pci/controller/dwc/pcie-designware-host.c | 28 ++++++-------------
> >  1 file changed, 8 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 0f36a926059a..aeec8b65eb97 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -319,7 +319,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >       struct device *dev = pci->dev;
> >       struct device_node *np = dev->of_node;
> >       struct platform_device *pdev = to_platform_device(dev);
> > -     struct resource_entry *win, *tmp;
> > +     struct resource_entry *win;
> >       struct pci_bus *child;
> >       struct pci_host_bridge *bridge;
> >       struct resource *cfg_res;
> > @@ -342,31 +342,19 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >       if (!bridge)
> >               return -ENOMEM;
> >
> > -     ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> > -                                     &bridge->windows, &pp->io_base);

[...]

> > +                     pp->io_bus_addr = pp->io->start - win->offset;
> > +                     pp->io_base = pci_pio_to_address(pp->io->start);
>
> Where did io_base come from? This wasn't here before, so why are we setting it
> now?

It was set in the removed devm_of_pci_get_host_bridge_resources().

Rob
