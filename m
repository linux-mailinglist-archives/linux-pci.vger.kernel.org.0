Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C412533BB8
	for <lists+linux-pci@lfdr.de>; Wed, 25 May 2022 13:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242907AbiEYL16 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 May 2022 07:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243072AbiEYL1n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 May 2022 07:27:43 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FED8A5004;
        Wed, 25 May 2022 04:27:34 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id x137so7307895ybg.5;
        Wed, 25 May 2022 04:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6y23SpN7c4c8/IBWbHgVH2b6SE13FAa8+3zts9g7JvI=;
        b=3OS9EuHmoKEW4OFeUF/RKhubiB73e6qD9o2Iwf5zZi9GlgokjZNpPIEu14MGemf58z
         ZIa2mI67C5VqIDpHkuZBGmEE0vziF8Eu6VKtQ7T54KuLrvAaUqipZWNBsRuCKBBHieAO
         Xgvt6l4jO90lp6RVtW6AN1YhW3giAsPv+3kT22Ir12CTA+Ahw/RpO5q2zpYt6moeYznz
         hYvcmP1W/MQoEwY0GcVdQlrjhE0m5wcSYPSk4xX+HzAQ15T3uxCc7SUeVcnc39J6Yf1u
         GroDuzeXpxbx9Y7XIhKIGYucxOIvAsAlPhzGyxyIzkapoYU+imjIyuOtMwXy9T9rssP4
         qWhA==
X-Gm-Message-State: AOAM532tbc/QBucgO4V7SZmtWKsK+dkO2Egmhiht2j45tHNXhO/i0/Td
        7+iybtlTzS954cAVC81FAAUmKvcuWeRCv4U7YEK7YSuE
X-Google-Smtp-Source: ABdhPJxv4NC5ewjAl+6ZgT3dAfwiCabSb/MpiAttzeIfQyfIk//kPsCr9OR/MIvwnrAs3rH/wsXniEwrQVVUu3fYPek=
X-Received: by 2002:a25:d687:0:b0:64e:3a41:8d5 with SMTP id
 n129-20020a25d687000000b0064e3a4108d5mr29946641ybg.622.1653478053551; Wed, 25
 May 2022 04:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220517124319.47125-1-yangyicong@hisilicon.com> <20220524205842.GA269611@bhelgaas>
In-Reply-To: <20220524205842.GA269611@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 May 2022 13:27:21 +0200
Message-ID: <CAJZ5v0iKyVbHqjxH5nqfZ9E8C94EDhXXdkHYoN2smg3V7p6Wuw@mail.gmail.com>
Subject: Re: [RESEND PATCH v5] PCI: Make sure the bus bridge powered on when
 scanning bus
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 24, 2022 at 10:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, May 17, 2022 at 08:43:19PM +0800, Yicong Yang wrote:
> > When the bus bridge is runtime suspended, we'll fail to rescan
> > the devices through sysfs as we cannot access the configuration
> > space correctly when the bridge is in D3hot.
>
> Is the "D3hot" above a typo?  I think devices are supposed to respond
> to config accesses when in D3hot.  PCIe r6.0, sec 5.3.1.4.1:
>
>   Configuration and Message requests are the only TLPs accepted by a
>   Function in the D3Hot state. ...
>
>   Functions that are in D3Hot are permitted to be transitioned by
>   software (writing to their PMCSR PowerState field) to the D0active
>   state or the D0uninitialized state. Functions that are in D3Hot must
>   respond to Configuration Space accesses as long as power and clock
>   are supplied so that they can be returned to D0 by software.

That applies to the device itself, though, and not to the bus under it.

In general, a bridge in D3hot causes the bus segment on the other side
of it to be inaccessible even for config space accesses AFAICS.

> > It can be reproduced like:
> >
> > $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/0000:81:00.1/remove
> > $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/pci_bus/0000:81/rescan
> >
> > 0000:80:00.0 is a Root Port and it is runtime-suspended, so
> > 0000:81:00.1 is unreachable after a rescan.
> >
> > Power up the bridge when scanning the child bus and allow it to
> > suspend again by adding pm_runtime_get_sync()/pm_runtime_put()
> > in pci_scan_child_bus_extend().
> >
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/pci/probe.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 17a969942d37..b108e72b6586 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2859,11 +2859,20 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
> >       unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
> >       unsigned int start = bus->busn_res.start;
> >       unsigned int devfn, fn, cmax, max = start;
> > +     struct pci_dev *bridge = bus->self;
> >       struct pci_dev *dev;
> >       int nr_devs;
> >
> >       dev_dbg(&bus->dev, "scanning bus\n");
> >
> > +     /*
> > +      * Make sure the bus bridge is powered on, otherwise we may not be
> > +      * able to scan the devices as we may fail to access the configuration
> > +      * space of subordinates.
> > +      */
> > +     if (bridge)
> > +             pm_runtime_get_sync(&bridge->dev);
> > +
> >       /* Go find them, Rover! */
> >       for (devfn = 0; devfn < 256; devfn += 8) {
> >               nr_devs = pci_scan_slot(bus, devfn);
> > @@ -2976,6 +2985,9 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
> >               }
> >       }
> >
> > +     if (bridge)
> > +             pm_runtime_put(&bridge->dev);
> > +
> >       /*
> >        * We've scanned the bus and so we know all about what's on
> >        * the other side of any bridges that may be on this bus plus
> > --
> > 2.24.0
> >
