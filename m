Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12358508D8B
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 18:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354873AbiDTQp4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 12:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351187AbiDTQp4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 12:45:56 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53AB4664D;
        Wed, 20 Apr 2022 09:43:09 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2f19fdba41fso24585827b3.3;
        Wed, 20 Apr 2022 09:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N3fPv8pbsvbdnmwuFsfNg5pjCiBB7G4V4ZkZ1LyVVAk=;
        b=WPPNboVxHsC72mWqGrSGIYy+ZCzHVDCSkBb6MObrs6ADUgTYpepaImgSf5nfvlAPFf
         rQmA6JAQTHX3/PkolKvwYfwMW27tmS34udvJwRyyaamuwXlX6mxFoArQJmEAPfqM9DSm
         PCmPK0G5fsDRPm7S4iphzzQs0jSLTXSCKnCCmfFLjdPGPSEFIEx2Xx74EslLxhKksCiB
         +o3eiQKqPZlHI8Uc7ZwbPfkAr79xlFAPxFnEBJGCy+4ewOIsogNCUXYOPkN6DzIjX1cO
         IL2ynnscfiWSJuzDb1pkIrnbW8mjLE34+0YhvUei9GL/m38t1QaJwUS7n68lF5XFe4Ra
         N2XQ==
X-Gm-Message-State: AOAM531K7izctXOiPOcDxLG3YZWyl09QFyKRiX4/HZ6XWSkmmuoPAfqO
        0wEhxAT7I+JytDzk3QKlpoGZ9M7SqTH6cRAIRuu34fG2
X-Google-Smtp-Source: ABdhPJx1MRoqevzR07uqcAORlypGWMMfnKJzm9Gux29mmz4s281MKa3K/SVjud1AOtVAAe0shAK9t5QDyfP62Wj/4n8=
X-Received: by 2002:a81:b89:0:b0:2eb:e9e6:470a with SMTP id
 131-20020a810b89000000b002ebe9e6470amr22115304ywl.7.1650472989143; Wed, 20
 Apr 2022 09:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220414123736.34150-1-yangyicong@hisilicon.com> <20220420163249.GA1305194@bhelgaas>
In-Reply-To: <20220420163249.GA1305194@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Apr 2022 18:42:58 +0200
Message-ID: <CAJZ5v0jarkeaPsq6qPLotYVqfw9rZ_OdawxBN1-1=YhvVQAz9Q@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Make sure the bus bridge powered on when scanning bus
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, prime.zeng@huawei.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 20, 2022 at 6:32 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rafael, linux-pm, since I'd really like his ack/review]
>
> On Thu, Apr 14, 2022 at 08:37:36PM +0800, Yicong Yang wrote:
> > When the bus bridge is runtime suspended, we'll fail to rescan
> > the devices through sysfs as we cannot access the configuration
> > space correctly when the bridge is in D3hot.
> > It can be reproduced like:
> >
> > $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/0000:81:00.1/remove
> > $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/pci_bus/0000:81/rescan
> >
> > 0000:80:00.0 is root port and is runtime suspended and we cannot
> > get 0000:81:00.1 after rescan.
> >
> > Make bridge powered on when scanning the child bus, by adding
> > pm_runtime_get_sync()/pm_runtime_put() in pci_scan_child_bus_extend().
> >
> > A similar issue is met and solved by
> > d963f6512e15 ("PCI: Power on bridges before scanning new devices")
> > which rescan the devices through /sys/bus/pci/devices/0000:80:00.0/rescan.
> > The callstack is like:
> >
> > dev_rescan_restore()
> >   pci_rescan_bus()
> >     pci_scan_bridge_extend()
> >       pci_scan_child_bus_extend() /* will wake up the bridge with this patch */
> >
> > With this patch the issue is also resolved, so let's remove the calls of
> > pm_runtime_*() in pci_scan_bridge_extend().
> >
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > ---
> > Change since v2:
> > - just rebase it on v5.18-rc2
> > Link: https://lore.kernel.org/linux-pci/1601029386-4928-1-git-send-email-yangyicong@hisilicon.com/
> >
> > Change since v1:
> > - use an intermediate variable *bridge as suggested
> > - remove the pm_runtime_*() calls in pci_scan_bridge_extend()
> > Link: https://lore.kernel.org/linux-pci/1596022223-4765-1-git-send-email-yangyicong@hisilicon.com/
> >
> >  drivers/pci/probe.c | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 17a969942d37..2ca6b4b708e3 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1257,12 +1257,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> >       u8 fixed_sec, fixed_sub;
> >       int next_busnr;
> >
> > -     /*
> > -      * Make sure the bridge is powered on to be able to access config
> > -      * space of devices below it.
> > -      */
> > -     pm_runtime_get_sync(&dev->dev);

I understand why this is added below, but I'm not sure why it is safe
to remove it from here.

Say the bridge is initially in D3cold and we are accessing its config
space below.  Why is it not necessary to power it up in that case?

> > -
> >       pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
> >       primary = buses & 0xFF;
> >       secondary = (buses >> 8) & 0xFF;
> > @@ -1464,8 +1458,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> >  out:
> >       pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
> >
> > -     pm_runtime_put(&dev->dev);
> > -
> >       return max;
> >  }
> >
> > @@ -2859,11 +2851,19 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
> >       unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
> >       unsigned int start = bus->busn_res.start;
> >       unsigned int devfn, fn, cmax, max = start;
> > -     struct pci_dev *dev;
> > +     struct pci_dev *dev, *bridge = bus->self;

I would initialize the new variable in a separate line.

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
> > @@ -2976,6 +2976,9 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
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
