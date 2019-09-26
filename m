Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43482BFB18
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 23:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbfIZVoo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 17:44:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfIZVoo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Sep 2019 17:44:44 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E012E2245B
        for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2019 21:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569534283;
        bh=r9iUZ3xZ2uMsXW7rQV7RMqQESKbTLrIuyOwfkbYEZLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sMObkmUZmqpnExM8bz8MEnZGfupBlIz+aa0n1TjVwjdZF8YIcJ01Lfq8BOs3wocJe
         DO3k/8jdJ89rMxZDES0x1fakblEVra+dIEfbzj80ustEj6ocLbzdpuxl9EIKl8/1YF
         fVCQhWDEKvx7Hwsqz9Umm9g0dynSVWo8z3q7/488=
Received: by mail-qt1-f182.google.com with SMTP id c21so4728844qtj.12
        for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2019 14:44:42 -0700 (PDT)
X-Gm-Message-State: APjAAAWK3lR2UkKK9atHpSvJwE7+7YJLSNZmEy16TM+eOxPhEulVCW+T
        At52/0qaxUCoeorvsWD0gDxHGomOHSY9RsX+TQ==
X-Google-Smtp-Source: APXvYqwv+D0Jq+ovkUxTwqp6gYb4j4V558s6dRtAHKz09nF40eEEKka4fyZVcmcbX2AQig7dCJk4MguEwUH32YdtERg=
X-Received: by 2002:ac8:6915:: with SMTP id e21mr6477376qtr.224.1569534282085;
 Thu, 26 Sep 2019 14:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190924214630.12817-1-robh@kernel.org> <20190924214630.12817-6-robh@kernel.org>
 <20190925103752.GS9720@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190925103752.GS9720@e119886-lin.cambridge.arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 26 Sep 2019 16:44:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJW2t3F6HdKqcHguYLLiYQ6XWOsQbY-TFsDXhrDjjszew@mail.gmail.com>
Message-ID: <CAL_JsqJW2t3F6HdKqcHguYLLiYQ6XWOsQbY-TFsDXhrDjjszew@mail.gmail.com>
Subject: Re: [PATCH 05/11] PCI: versatile: Use pci_parse_request_of_pci_ranges()
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 25, 2019 at 5:37 AM Andrew Murray <andrew.murray@arm.com> wrote:
>
> On Tue, Sep 24, 2019 at 04:46:24PM -0500, Rob Herring wrote:
> > Convert ARM Versatile host bridge to use the common
> > pci_parse_request_of_pci_ranges().
> >
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/pci/controller/pci-versatile.c | 62 +++++---------------------
> >  1 file changed, 11 insertions(+), 51 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
> > index f59ad2728c0b..237b1abb26f2 100644
> > --- a/drivers/pci/controller/pci-versatile.c
> > +++ b/drivers/pci/controller/pci-versatile.c
> > @@ -62,60 +62,12 @@ static struct pci_ops pci_versatile_ops = {
> >       .write  = pci_generic_config_write,
> >  };
> >
> > -static int versatile_pci_parse_request_of_pci_ranges(struct device *dev,
> > -                                                  struct list_head *res)
> > -{
> > -     int err, mem = 1, res_valid = 0;
> > -     resource_size_t iobase;
> > -     struct resource_entry *win, *tmp;
> > -
> > -     err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, res, &iobase);
> > -     if (err)
> > -             return err;
> > -
> > -     err = devm_request_pci_bus_resources(dev, res);
> > -     if (err)
> > -             goto out_release_res;
> > -
> > -     resource_list_for_each_entry_safe(win, tmp, res) {
> > -             struct resource *res = win->res;
> > -
> > -             switch (resource_type(res)) {
> > -             case IORESOURCE_IO:
> > -                     err = devm_pci_remap_iospace(dev, res, iobase);
> > -                     if (err) {
> > -                             dev_warn(dev, "error %d: failed to map resource %pR\n",
> > -                                      err, res);
> > -                             resource_list_destroy_entry(win);
> > -                     }
> > -                     break;
> > -             case IORESOURCE_MEM:
> > -                     res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> > -
> > -                     writel(res->start >> 28, PCI_IMAP(mem));
> > -                     writel(PHYS_OFFSET >> 28, PCI_SMAP(mem));
> > -                     mem++;
> > -
> > -                     break;
> > -             }
> > -     }
> > -
> > -     if (res_valid)
> > -             return 0;
> > -
> > -     dev_err(dev, "non-prefetchable memory resource required\n");
> > -     err = -EINVAL;
> > -
> > -out_release_res:
> > -     pci_free_resource_list(res);
> > -     return err;
> > -}
> > -
> >  static int versatile_pci_probe(struct platform_device *pdev)
> >  {
> >       struct device *dev = &pdev->dev;
> >       struct resource *res;
> > -     int ret, i, myslot = -1;
> > +     struct resource_entry *entry;
> > +     int ret, i, myslot = -1, mem = 0;
>
> I think 'mem' should be initialised to 1, at least that's what the original
> code did. However I'm not sure why it should start from 1.

The original code I moved from arch/arm had 32MB @ 0x0c000000 called
"PCI unused" which was requested with request_resource(), but never
provided to the PCI core. Otherwise, I kept the setup the same. No one
has complained in 4 years, though I'm not sure anyone would have
noticed if I just deleted PCI support...

Rob
