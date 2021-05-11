Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC6E379DDC
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 05:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhEKDez (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 23:34:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36529 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhEKDey (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 23:34:54 -0400
Received: from mail-lj1-f197.google.com ([209.85.208.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lgJ9X-0006Il-PW
        for linux-pci@vger.kernel.org; Tue, 11 May 2021 03:33:47 +0000
Received: by mail-lj1-f197.google.com with SMTP id g6-20020a05651c0446b02900dee525f111so10169102ljg.19
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 20:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSs6wGkqCeP3e2X7oXR6Znw5oiB9jcI2Zxhz3FUpuYs=;
        b=GsIgcwWgDCCJesKZORYQasEiKSg+JM25RALxOJ00edmAj0z6ECibd0RcCTY7S7XKtw
         vkUY2iZ5/gm3F1FJd3iY4mbvNsb0Tb7wCWSvW0i0xO9bdLIsASe9Vl5Owu8SdGFm+puT
         kht1rAGylKIAQZREQ2qzEu+PN2G+VgmLokQvBm3x+dPyYyl1xN+Iat1oMTpnju/Ya4we
         i+OWwxted9wZgxjpg5JnuFCXUtcOamjfcXJsldYCqrrkC4HPjvr0Ah3A14INzjflDp5t
         hDwENs6+hmSB2hETHhmFWBNDypWHnhs9PGnf5gWe9731D5cNFELc5tmiMYPc7gHJhVcJ
         g/nw==
X-Gm-Message-State: AOAM532BkA0yN+ta59t+9A+WAf+KB6zABCE+tKQ4UWOi6KtsrIjQTTDq
        TKgllSBu7w0yRTgtvIPhaAoAKTHivrZTvxPNSRPRFY+IauXRjHKnGuoPdzZlI6DaV+NfoAp+qOA
        6PbxbwXw85qk62mgKWv9kWAq7o2gpHz+7qP39QkZQWq4TxHkD9PbFjw==
X-Received: by 2002:ac2:5fc9:: with SMTP id q9mr19797837lfg.290.1620704027217;
        Mon, 10 May 2021 20:33:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwP91Z8IW8EkWCaYE8EiEizLo10auyoxnofDLFvVJpbYoM/pbeICOSGgXCP8irVnTkBCxZQjTKfX4gt3OIYbS8=
X-Received: by 2002:ac2:5fc9:: with SMTP id q9mr19797820lfg.290.1620704026948;
 Mon, 10 May 2021 20:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210401131252.531935-1-kai.heng.feng@canonical.com> <CAAd53p5rtZW_yqV2S77g34Dv9m9941yoBM6a_6fAvKpEuzXJ9g@mail.gmail.com>
In-Reply-To: <CAAd53p5rtZW_yqV2S77g34Dv9m9941yoBM6a_6fAvKpEuzXJ9g@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 11 May 2021 11:33:34 +0800
Message-ID: <CAAd53p52C9TQz_zOPE-ySqfKbRNFo0MPzq7E3p_8mAwF_g0VjQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Coalesce contiguous regions for host bridges
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 22, 2021 at 4:57 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Thu, Apr 1, 2021 at 9:12 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > Built-in graphics on HP EliteDesk 805 G6 doesn't work because graphics
> > can't get the BAR it needs:
> > [    0.611504] pci_bus 0000:00: root bus resource [mem 0x10020200000-0x100303fffff window]
> > [    0.611505] pci_bus 0000:00: root bus resource [mem 0x10030400000-0x100401fffff window]
> > ...
> > [    0.638083] pci 0000:00:08.1:   bridge window [mem 0xd2000000-0xd23fffff]
> > [    0.638086] pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100401fffff 64bit pref]
> > [    0.962086] pci 0000:00:08.1: can't claim BAR 15 [mem 0x10030000000-0x100401fffff 64bit pref]: no compatible bridge window
> > [    0.962086] pci 0000:00:08.1: [mem 0x10030000000-0x100401fffff 64bit pref] clipped to [mem 0x10030000000-0x100303fffff 64bit pref]
> > [    0.962086] pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100303fffff 64bit pref]
> > [    0.962086] pci 0000:07:00.0: can't claim BAR 0 [mem 0x10030000000-0x1003fffffff 64bit pref]: no compatible bridge window
> > [    0.962086] pci 0000:07:00.0: can't claim BAR 2 [mem 0x10040000000-0x100401fffff 64bit pref]: no compatible bridge window
> >
> > However, the root bus has two contiguous regions that can contain the
> > child resource requested.
> >
> > Bjorn Helgaas pointed out that we can simply coalesce contiguous regions
> > for host bridges, since host bridge don't have _SRS. So do that
> > accordingly to make child resource can be contained. This change makes
> > the graphics works on the system in question.
> >
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212013
> > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> A gentle ping...

Another gentle ping...

>
> > ---
> > v2:
> >  - Coalesce all contiguous regresion in pci_register_host_bridge(), if
> >    conditions are met.
> >
> >  drivers/pci/probe.c | 49 +++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 45 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 953f15abc850..3607ce7402b4 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/hypervisor.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/list_sort.h>
> >  #include "pci.h"
> >
> >  #define CARDBUS_LATENCY_TIMER  176     /* secondary latency timer */
> > @@ -874,14 +875,30 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
> >         dev_set_msi_domain(&bus->dev, d);
> >  }
> >
> > +static int res_cmp(void *priv, struct list_head *a, struct list_head *b)
> > +{
> > +       struct resource_entry *entry1, *entry2;
> > +
> > +       entry1 = container_of(a, struct resource_entry, node);
> > +       entry2 = container_of(b, struct resource_entry, node);
> > +
> > +       if (entry1->res->flags != entry2->res->flags)
> > +               return entry1->res->flags > entry2->res->flags;
> > +
> > +       if (entry1->offset != entry2->offset)
> > +               return entry1->offset > entry2->offset;
> > +
> > +       return entry1->res->start > entry2->res->start;
> > +}
> > +
> >  static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >  {
> >         struct device *parent = bridge->dev.parent;
> > -       struct resource_entry *window, *n;
> > +       struct resource_entry *window, *next, *n;
> >         struct pci_bus *bus, *b;
> > -       resource_size_t offset;
> > +       resource_size_t offset, next_offset;
> >         LIST_HEAD(resources);
> > -       struct resource *res;
> > +       struct resource *res, *next_res;
> >         char addr[64], *fmt;
> >         const char *name;
> >         int err;
> > @@ -959,11 +976,35 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >         if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
> >                 dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
> >
> > +       /* Sort and coalesce contiguous windows */
> > +       list_sort(NULL, &resources, res_cmp);
> > +       resource_list_for_each_entry_safe(window, n, &resources) {
> > +               if (list_is_last(&window->node, &resources))
> > +                       break;
> > +
> > +               next = list_next_entry(window, node);
> > +               offset = window->offset;
> > +               res = window->res;
> > +               next_offset = next->offset;
> > +               next_res = next->res;
> > +
> > +               if (res->flags != next_res->flags || offset != next_offset)
> > +                       continue;
> > +
> > +               if (res->end + 1 == next_res->start) {
> > +                       next_res->start = res->start;
> > +                       res->flags = res->start = res->end = 0;
> > +               }
> > +       }
> > +
> >         /* Add initial resources to the bus */
> >         resource_list_for_each_entry_safe(window, n, &resources) {
> > -               list_move_tail(&window->node, &bridge->windows);
> >                 offset = window->offset;
> >                 res = window->res;
> > +               if (!res->end)
> > +                       continue;
> > +
> > +               list_move_tail(&window->node, &bridge->windows);
> >
> >                 if (res->flags & IORESOURCE_BUS)
> >                         pci_bus_insert_busn_res(bus, bus->number, res->end);
> > --
> > 2.30.2
> >
