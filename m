Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F31367D08
	for <lists+linux-pci@lfdr.de>; Thu, 22 Apr 2021 10:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhDVI6a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Apr 2021 04:58:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56253 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbhDVI63 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Apr 2021 04:58:29 -0400
Received: from mail-lf1-f70.google.com ([209.85.167.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lZV9l-0005us-UG
        for linux-pci@vger.kernel.org; Thu, 22 Apr 2021 08:57:54 +0000
Received: by mail-lf1-f70.google.com with SMTP id q24-20020a0565122118b02901ae16b0713aso9603096lfr.16
        for <linux-pci@vger.kernel.org>; Thu, 22 Apr 2021 01:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uhKCITlC8z0lLRtKu0vRLYsI5e5s6htEBYCstI+rfV0=;
        b=fBZVwM/5Mrz88uPYPJYNQo6csHNz49ejidKyV44xYB4y+wJ9mMgTfz75Rh2Voouwql
         gzfYfK+5Fn9WUkcMHXoRxbA03e8mUOKpEKxgdslDE+KrAIXcCP2WdKuc/xT/1hJad/Mq
         rXbZFytVv4igEMMIqBD/CjIAj/Mm9sf9VmngVEveEJX55vTnh288+fZW4NGgte08aCAV
         DOcrU0+66xztlEAb0e+cpIluH1mW5oRTVXoil0qnwSFj+E4AOhAiWahvtONeyu+avUZn
         m7MGKxUpHrscpj/3cDbQlLUEWgXIjWRkIC/o8/7/IDO8c8PWdJURSXMMlCnp4t58DHht
         jT+g==
X-Gm-Message-State: AOAM5302VHeL63U0LiZnTp4Gx1Y1Q5BaYX1cUOkecKjLf+7rOpMWFay6
        FI2HJw6Bm8FEDzkmbSvEmmbWjxsI/ejD0VnIq6ZPmhdl3ec5z7r6ISvuAdP5FWZ72Z7LXCm1tjk
        iNXALXq1iXdzQkTWxFUaIslYyFbM/hWBKAZCkP6ux80cSj++vW3GNKA==
X-Received: by 2002:a2e:97c6:: with SMTP id m6mr1782296ljj.403.1619081873363;
        Thu, 22 Apr 2021 01:57:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxf1VedjgFvgDyRthjvX0RdF1wlywxyF26kdMlppzEwkoidctA07kTG4IOcwZiQDCy/WaMCHpJ3r4j8aPuJjio=
X-Received: by 2002:a2e:97c6:: with SMTP id m6mr1782284ljj.403.1619081873008;
 Thu, 22 Apr 2021 01:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210401131252.531935-1-kai.heng.feng@canonical.com>
In-Reply-To: <20210401131252.531935-1-kai.heng.feng@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 22 Apr 2021 16:57:41 +0800
Message-ID: <CAAd53p5rtZW_yqV2S77g34Dv9m9941yoBM6a_6fAvKpEuzXJ9g@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Coalesce contiguous regions for host bridges
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 1, 2021 at 9:12 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Built-in graphics on HP EliteDesk 805 G6 doesn't work because graphics
> can't get the BAR it needs:
> [    0.611504] pci_bus 0000:00: root bus resource [mem 0x10020200000-0x100303fffff window]
> [    0.611505] pci_bus 0000:00: root bus resource [mem 0x10030400000-0x100401fffff window]
> ...
> [    0.638083] pci 0000:00:08.1:   bridge window [mem 0xd2000000-0xd23fffff]
> [    0.638086] pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100401fffff 64bit pref]
> [    0.962086] pci 0000:00:08.1: can't claim BAR 15 [mem 0x10030000000-0x100401fffff 64bit pref]: no compatible bridge window
> [    0.962086] pci 0000:00:08.1: [mem 0x10030000000-0x100401fffff 64bit pref] clipped to [mem 0x10030000000-0x100303fffff 64bit pref]
> [    0.962086] pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100303fffff 64bit pref]
> [    0.962086] pci 0000:07:00.0: can't claim BAR 0 [mem 0x10030000000-0x1003fffffff 64bit pref]: no compatible bridge window
> [    0.962086] pci 0000:07:00.0: can't claim BAR 2 [mem 0x10040000000-0x100401fffff 64bit pref]: no compatible bridge window
>
> However, the root bus has two contiguous regions that can contain the
> child resource requested.
>
> Bjorn Helgaas pointed out that we can simply coalesce contiguous regions
> for host bridges, since host bridge don't have _SRS. So do that
> accordingly to make child resource can be contained. This change makes
> the graphics works on the system in question.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212013
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

A gentle ping...

> ---
> v2:
>  - Coalesce all contiguous regresion in pci_register_host_bridge(), if
>    conditions are met.
>
>  drivers/pci/probe.c | 49 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 953f15abc850..3607ce7402b4 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -19,6 +19,7 @@
>  #include <linux/hypervisor.h>
>  #include <linux/irqdomain.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/list_sort.h>
>  #include "pci.h"
>
>  #define CARDBUS_LATENCY_TIMER  176     /* secondary latency timer */
> @@ -874,14 +875,30 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
>         dev_set_msi_domain(&bus->dev, d);
>  }
>
> +static int res_cmp(void *priv, struct list_head *a, struct list_head *b)
> +{
> +       struct resource_entry *entry1, *entry2;
> +
> +       entry1 = container_of(a, struct resource_entry, node);
> +       entry2 = container_of(b, struct resource_entry, node);
> +
> +       if (entry1->res->flags != entry2->res->flags)
> +               return entry1->res->flags > entry2->res->flags;
> +
> +       if (entry1->offset != entry2->offset)
> +               return entry1->offset > entry2->offset;
> +
> +       return entry1->res->start > entry2->res->start;
> +}
> +
>  static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  {
>         struct device *parent = bridge->dev.parent;
> -       struct resource_entry *window, *n;
> +       struct resource_entry *window, *next, *n;
>         struct pci_bus *bus, *b;
> -       resource_size_t offset;
> +       resource_size_t offset, next_offset;
>         LIST_HEAD(resources);
> -       struct resource *res;
> +       struct resource *res, *next_res;
>         char addr[64], *fmt;
>         const char *name;
>         int err;
> @@ -959,11 +976,35 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>         if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
>                 dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
>
> +       /* Sort and coalesce contiguous windows */
> +       list_sort(NULL, &resources, res_cmp);
> +       resource_list_for_each_entry_safe(window, n, &resources) {
> +               if (list_is_last(&window->node, &resources))
> +                       break;
> +
> +               next = list_next_entry(window, node);
> +               offset = window->offset;
> +               res = window->res;
> +               next_offset = next->offset;
> +               next_res = next->res;
> +
> +               if (res->flags != next_res->flags || offset != next_offset)
> +                       continue;
> +
> +               if (res->end + 1 == next_res->start) {
> +                       next_res->start = res->start;
> +                       res->flags = res->start = res->end = 0;
> +               }
> +       }
> +
>         /* Add initial resources to the bus */
>         resource_list_for_each_entry_safe(window, n, &resources) {
> -               list_move_tail(&window->node, &bridge->windows);
>                 offset = window->offset;
>                 res = window->res;
> +               if (!res->end)
> +                       continue;
> +
> +               list_move_tail(&window->node, &bridge->windows);
>
>                 if (res->flags & IORESOURCE_BUS)
>                         pci_bus_insert_busn_res(bus, bus->number, res->end);
> --
> 2.30.2
>
