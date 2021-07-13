Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470A63C6CA2
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 10:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbhGMIwh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 04:52:37 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:57264
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234842AbhGMIw1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jul 2021 04:52:27 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 8C34040616
        for <linux-pci@vger.kernel.org>; Tue, 13 Jul 2021 08:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626166176;
        bh=fYODBWPoJ33VG3U0icO8NForQTKKbh/BGBOLG1sBNPQ=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
        b=LX9XtL+zVYhRY6KP4pHRmKGI6wmHXn7VnWEgq1UKNdSiedkHM4GNzt6/TEvY0UmE9
         qwwxb6TQ00svkv+Guo5POz6BI4IQtfO9QtqHbeuQ4FG/sV3kZfNycUMs9P/NRF7/3+
         1tOGl89xOCi35zeQYXskGxtLQioSHY0Fm9Y5vkZbRDB29KmvpDJCsr8N94ZCuES7e0
         JV7HQsGIWwhlZ/ztNxb7NxGLGoHtI6PXSzD4wWU3YCbRcNThsNflLILreEYxKdaMVo
         OSVYhyoSgIaEnnq+CJMchcv/SnjS3HxqNRZmI0TgNRLUzht41Z+QSG1S9cESgn7oey
         +moWE0QMVdMtQ==
Received: by mail-ej1-f72.google.com with SMTP id bl17-20020a170906c251b029052292d7c3b4so1379070ejb.9
        for <linux-pci@vger.kernel.org>; Tue, 13 Jul 2021 01:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYODBWPoJ33VG3U0icO8NForQTKKbh/BGBOLG1sBNPQ=;
        b=XyKXKZ/VBZ5KXS5h1W7vJexkATyNF7+GnBRBOTesLOvYNGwXlBN2Q6DPq7zxKwLGnV
         OTbv8xKoIR4ax4no3wPP5JFXH4Ech7/GZPfXI/YD4dvuznPsyB+M+cIP2g0gZWO00QLB
         DkqdP0Jkv8KvM8rEVT0tjFI9r85Pde0W9ntScbWsxQoXOU0He5+0Xx84HGdz3OxUP6W2
         m4Lo6mW91vsCPt68adEHGMimz1itNagFu3yu0dxEHYrqeNmWiV5kXXQa+1PUwQvh5GKr
         TMT/vIMcUS+uhpElSBoTTvckEruljfliA+sQ3dRkpsB1CdAoL5q9pitwXBYTdUuyGXUy
         rQ+A==
X-Gm-Message-State: AOAM530Oaw7S0vcrDoqNSSB01Kddu41cvUUd/qkNwzf8UYGjTG3E8SlN
        STSib5lEjLAMufSG5zXIf/n4Q6L/ibB++TxVLdcKbdlvH1BtS1Qhh515ugr8o+DWPlk5YIQ1isR
        BG7IiatJT8fNwDWm+c/NIlR9++9mqvGp2Nm9OWCkijxRIQNMKmRH7bA==
X-Received: by 2002:a17:907:724b:: with SMTP id ds11mr4505677ejc.192.1626166176154;
        Tue, 13 Jul 2021 01:49:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9CfQXikcQgD2Aueli7R1D60T974C+DJA6gfBqcKcZTxIQ5ixSXpmhgL13fKHVUCixXCYX8iS6liVz+J9iL9k=
X-Received: by 2002:a17:907:724b:: with SMTP id ds11mr4505657ejc.192.1626166175820;
 Tue, 13 Jul 2021 01:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210713075726.1232938-1-kai.heng.feng@canonical.com> <f18e36f7-cb18-1a4a-e7e8-4fbb253581ae@roeck-us.net>
In-Reply-To: <f18e36f7-cb18-1a4a-e7e8-4fbb253581ae@roeck-us.net>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 13 Jul 2021 16:49:23 +0800
Message-ID: <CAAd53p50502g1_7Db4xzUXrzcofmtBDO=+-HLqfs+J7NvVhB+A@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI: Coalesce host bridge contiguous apertures
 without sorting
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 13, 2021 at 4:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/13/21 12:57 AM, Kai-Heng Feng wrote:
> > Commit 65db04053efe ("PCI: Coalesce host bridge contiguous apertures")
> > sorts the resources by address so the resources can be swapped.
> >
> > Before:
> > PCI host bridge to bus 0002:00
> > pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
> > pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
> > pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
> >
> > And after:
> > PCI host bridge to bus 0002:00
> > pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
> > pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
> > pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
> >
> > However, the sorted resources make NVMe stops working on QEMU ppc:sam460ex.
> >
> > Resources in the original issue are already in ascending order:
> > pci_bus 0000:00: root bus resource [mem 0x10020200000-0x100303fffff window]
> > pci_bus 0000:00: root bus resource [mem 0x10030400000-0x100401fffff window]
> >
> > So remove the sorting part to resolve the issue.
> >
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Fixes: 65db04053efe ("PCI: Coalesce host bridge contiguous apertures")
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> I think the original commit message would make more sense here. This patch
> doesn't fix 65db04053efe, it replaces it. The commit message now misses
> the point, and the patch coalesces continuous apertures without explaining
> the reason.

Because the message is already in the git log so I didn't think that's
necessary.
Will send another one with the original message along with this one.

Kai-Heng

>
> Guenter
>
> > ---
> >   drivers/pci/probe.c | 31 +++++++++++++++++++++++++++----
> >   1 file changed, 27 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 79177ac37880..5de157600466 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -877,11 +877,11 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
> >   static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >   {
> >       struct device *parent = bridge->dev.parent;
> > -     struct resource_entry *window, *n;
> > +     struct resource_entry *window, *next, *n;
> >       struct pci_bus *bus, *b;
> > -     resource_size_t offset;
> > +     resource_size_t offset, next_offset;
> >       LIST_HEAD(resources);
> > -     struct resource *res;
> > +     struct resource *res, *next_res;
> >       char addr[64], *fmt;
> >       const char *name;
> >       int err;
> > @@ -961,11 +961,34 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >       if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
> >               dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
> >
> > +     /* Coalesce contiguous windows */
> > +     resource_list_for_each_entry_safe(window, n, &resources) {
> > +             if (list_is_last(&window->node, &resources))
> > +                     break;
> > +
> > +             next = list_next_entry(window, node);
> > +             offset = window->offset;
> > +             res = window->res;
> > +             next_offset = next->offset;
> > +             next_res = next->res;
> > +
> > +             if (res->flags != next_res->flags || offset != next_offset)
> > +                     continue;
> > +
> > +             if (res->end + 1 == next_res->start) {
> > +                     next_res->start = res->start;
> > +                     res->flags = res->start = res->end = 0;
> > +             }
> > +     }
> > +
> >       /* Add initial resources to the bus */
> >       resource_list_for_each_entry_safe(window, n, &resources) {
> > -             list_move_tail(&window->node, &bridge->windows);
> >               offset = window->offset;
> >               res = window->res;
> > +             if (!res->end)
> > +                     continue;
> > +
> > +             list_move_tail(&window->node, &bridge->windows);
> >
> >               if (res->flags & IORESOURCE_BUS)
> >                       pci_bus_insert_busn_res(bus, bus->number, res->end);
> >
>
