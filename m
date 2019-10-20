Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD28DE0B9
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2019 23:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfJTVhF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Oct 2019 17:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfJTVhF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 20 Oct 2019 17:37:05 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF4B2245D;
        Sun, 20 Oct 2019 21:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571607424;
        bh=oJ9t8UtXb7PRYsq3ePfq3A9aFk1ZN+i+OvWB9IzCOps=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sFDrPikJCzwykX55SSurJgFmuuxOUHgZXuZlpY26FTjeHzgoQK+kZBQrEuQvrPZSl
         swj3ol6RnlfGAvGIDnOSky1gkb+pI38z70kPryc5Ath1MqJxokc9LifxS+bE0bORD8
         mRHyLXDF1rK1RrOrQoNT1T2ieNM+f/qGCMkH+144=
Received: by mail-qt1-f174.google.com with SMTP id c17so14744245qtn.8;
        Sun, 20 Oct 2019 14:37:04 -0700 (PDT)
X-Gm-Message-State: APjAAAVZfy4Wc6uL7J6EoD5QejHVkBpQnFoSkDo2Xysui60MlST+FCqA
        vuO0M+wz3sXfSfweGKqybi/Oq7alQyChEqiX1A==
X-Google-Smtp-Source: APXvYqxapHq3qkRx86TykFEOegIN1VZm+E1xyc2NVyUchfsKxelq3sgZATdHJ8Qy+cPP9gdZ1ruTPx3i/ITuPkGPW3o=
X-Received: by 2002:ac8:741a:: with SMTP id p26mr6882617qtq.143.1571607423322;
 Sun, 20 Oct 2019 14:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191016200647.32050-1-robh@kernel.org> <20191016200647.32050-11-robh@kernel.org>
 <20191018155152.GK47056@e119886-lin.cambridge.arm.com>
In-Reply-To: <20191018155152.GK47056@e119886-lin.cambridge.arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Sun, 20 Oct 2019 16:36:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLWuUhv1qb3Soo0xKGJ167SvV3rnr+c07j9x3FFPEc3YA@mail.gmail.com>
Message-ID: <CAL_JsqLWuUhv1qb3Soo0xKGJ167SvV3rnr+c07j9x3FFPEc3YA@mail.gmail.com>
Subject: Re: [PATCH v2 10/25] PCI: rockchip: Use pci_parse_request_of_pci_ranges()
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

On Fri, Oct 18, 2019 at 10:52 AM Andrew Murray <andrew.murray@arm.com> wrote:
>
> On Wed, Oct 16, 2019 at 03:06:32PM -0500, Rob Herring wrote:
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
> > v2:
> > - New patch
> >
> >  drivers/pci/controller/pcie-rockchip-host.c | 36 ++++-----------------
> >  1 file changed, 7 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> > index ef8e677ce9d1..8d2e6f2e141e 100644
> > --- a/drivers/pci/controller/pcie-rockchip-host.c
> > +++ b/drivers/pci/controller/pcie-rockchip-host.c
> > @@ -950,14 +950,10 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> >       struct device *dev = &pdev->dev;
> >       struct pci_bus *bus, *child;
> >       struct pci_host_bridge *bridge;
> > +     struct resource *bus_res;
> >       struct resource_entry *win;
> > -     resource_size_t io_base;
> > -     struct resource *mem;
> > -     struct resource *io;
> >       int err;
> >
> > -     LIST_HEAD(res);
> > -
> >       if (!dev->of_node)
> >               return -ENODEV;
> >
> > @@ -995,29 +991,20 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> >       if (err < 0)
> >               goto err_deinit_port;
> >
> > -     err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> > -                                                 &res, &io_base);
> > +     err = pci_parse_request_of_pci_ranges(dev, &bridge->windows, &bus_res);
> >       if (err)
> >               goto err_remove_irq_domain;
> >
> > -     err = devm_request_pci_bus_resources(dev, &res);
> > -     if (err)
> > -             goto err_free_res;
> > +     rockchip->root_bus_nr = bus_res->start;
> >
> >       /* Get the I/O and memory ranges from DT */
> > -     resource_list_for_each_entry(win, &res) {
> > +     resource_list_for_each_entry(win, &bridge->windows) {
> >               switch (resource_type(win->res)) {
> >               case IORESOURCE_IO:
> >                       io = win->res;
> >                       io->name = "I/O";
>
> In some patches of this series we drop the custom naming of memory resources,
> yet in others, like this one, we preserve the custom naming.

Actually, patch #11 drops it for rockchip.

> Should we be consistent in preserving the existing naming?

The custom naming seems a bit pointless IMO and something mindlessly
copied and pasted around, so I'd rather see removing the remaining
cases. The only ones left AFAICT are designware and V3.

Rob
