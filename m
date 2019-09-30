Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6074C2415
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 17:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbfI3PQg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 11:16:36 -0400
Received: from foss.arm.com ([217.140.110.172]:56708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730780AbfI3PQg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 11:16:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFC251000;
        Mon, 30 Sep 2019 08:16:35 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46A1D3F706;
        Mon, 30 Sep 2019 08:16:35 -0700 (PDT)
Date:   Mon, 30 Sep 2019 16:16:33 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 05/11] PCI: versatile: Use
 pci_parse_request_of_pci_ranges()
Message-ID: <20190930151633.GE42880@e119886-lin.cambridge.arm.com>
References: <20190924214630.12817-1-robh@kernel.org>
 <20190924214630.12817-6-robh@kernel.org>
 <20190925103752.GS9720@e119886-lin.cambridge.arm.com>
 <CAL_JsqJW2t3F6HdKqcHguYLLiYQ6XWOsQbY-TFsDXhrDjjszew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJW2t3F6HdKqcHguYLLiYQ6XWOsQbY-TFsDXhrDjjszew@mail.gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 26, 2019 at 04:44:31PM -0500, Rob Herring wrote:
> On Wed, Sep 25, 2019 at 5:37 AM Andrew Murray <andrew.murray@arm.com> wrote:
> >
> > On Tue, Sep 24, 2019 at 04:46:24PM -0500, Rob Herring wrote:
> > > Convert ARM Versatile host bridge to use the common
> > > pci_parse_request_of_pci_ranges().
> > >
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  drivers/pci/controller/pci-versatile.c | 62 +++++---------------------
> > >  1 file changed, 11 insertions(+), 51 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
> > > index f59ad2728c0b..237b1abb26f2 100644
> > > --- a/drivers/pci/controller/pci-versatile.c
> > > +++ b/drivers/pci/controller/pci-versatile.c
> > > @@ -62,60 +62,12 @@ static struct pci_ops pci_versatile_ops = {
> > >       .write  = pci_generic_config_write,
> > >  };
> > >
> > > -static int versatile_pci_parse_request_of_pci_ranges(struct device *dev,
> > > -                                                  struct list_head *res)
> > > -{
> > > -     int err, mem = 1, res_valid = 0;
> > > -     resource_size_t iobase;
> > > -     struct resource_entry *win, *tmp;
> > > -
> > > -     err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, res, &iobase);
> > > -     if (err)
> > > -             return err;
> > > -
> > > -     err = devm_request_pci_bus_resources(dev, res);
> > > -     if (err)
> > > -             goto out_release_res;
> > > -
> > > -     resource_list_for_each_entry_safe(win, tmp, res) {
> > > -             struct resource *res = win->res;
> > > -
> > > -             switch (resource_type(res)) {
> > > -             case IORESOURCE_IO:
> > > -                     err = devm_pci_remap_iospace(dev, res, iobase);
> > > -                     if (err) {
> > > -                             dev_warn(dev, "error %d: failed to map resource %pR\n",
> > > -                                      err, res);
> > > -                             resource_list_destroy_entry(win);
> > > -                     }
> > > -                     break;
> > > -             case IORESOURCE_MEM:
> > > -                     res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> > > -
> > > -                     writel(res->start >> 28, PCI_IMAP(mem));
> > > -                     writel(PHYS_OFFSET >> 28, PCI_SMAP(mem));
> > > -                     mem++;
> > > -
> > > -                     break;
> > > -             }
> > > -     }
> > > -
> > > -     if (res_valid)
> > > -             return 0;
> > > -
> > > -     dev_err(dev, "non-prefetchable memory resource required\n");
> > > -     err = -EINVAL;
> > > -
> > > -out_release_res:
> > > -     pci_free_resource_list(res);
> > > -     return err;
> > > -}
> > > -
> > >  static int versatile_pci_probe(struct platform_device *pdev)
> > >  {
> > >       struct device *dev = &pdev->dev;
> > >       struct resource *res;
> > > -     int ret, i, myslot = -1;
> > > +     struct resource_entry *entry;
> > > +     int ret, i, myslot = -1, mem = 0;
> >
> > I think 'mem' should be initialised to 1, at least that's what the original
> > code did. However I'm not sure why it should start from 1.
> 
> The original code I moved from arch/arm had 32MB @ 0x0c000000 called
> "PCI unused" which was requested with request_resource(), but never
> provided to the PCI core. Otherwise, I kept the setup the same. No one
> has complained in 4 years, though I'm not sure anyone would have
> noticed if I just deleted PCI support...

OK, well it would be good to see a tested-by tag from someone for this.

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

Thanks,

Andrew Murray

> 
> Rob
