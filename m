Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7146037B2E4
	for <lists+linux-pci@lfdr.de>; Wed, 12 May 2021 02:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhELADs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 20:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhELADr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 20:03:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F601C06174A
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 17:02:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g4so1722593lfv.6
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 17:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=32gqo5zV+RGURV86mp7uR8bqTCYhZqWaxrh2ZcUwp+Q=;
        b=CCsH611G4x21fZfVYf0v8Uqz26dKRwG2KiRnW8DZ9z/vsVBoHqWJw6zP1N41FBHhYN
         zuDuzFqwXcYoNkcjP815gHThFTedy/Ch4f3inR1yWh9tefwvO5/Eic6epkuRMmqHwjgg
         zDAs5fkh6LnrUa4Q3fIy3ETxyxF8nfeW2RSbXJMVP79bgmfePYKIvYl4m9TdwO3FoXoj
         shtmxO29me0yaSlh5vAUHMAHp2ZKEAp5eX5gl79Jh+ZmG4hfo4xC8bWYk4LRhpBhlVrt
         kBKnwO4Nr8wl6pLw/vYtbm8C3yFsVH66K5up5BUm8+b52GDJK3jHhMQ4wVMG8KWFRsR9
         2J+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32gqo5zV+RGURV86mp7uR8bqTCYhZqWaxrh2ZcUwp+Q=;
        b=EwItOnUXDvEOjTe3OKWRnW0leKdQxV0/LTceICpo6IGQSv1W8+C6ZneFeMXY1wNK3I
         ELZOu/68JSrdeUhCPiyBN9Zm/EmqVkcO8NPObAHr2Iib4fH4pJGuqa+snuyEjJcktT49
         zzfr/HF8SXhV5G12o4L94n4FrjtrUDauvrnzMW7/2uIg6bPVkXyqxKFgrG39B8ZkHd6f
         /OtErb7VilVrbwPZqWEhwRuZra3b/aN1v8q6pdiabIjwcCCFBkZ/eLpIxGwHGqtfpw2W
         ak39pOPXY0vdmlsBRmRV82iv7+XXpV1XcHRymoBlwiXttNu1dOHJq8ef5y6AxNdIiiEH
         qt3Q==
X-Gm-Message-State: AOAM533Xb7KpornCbxrmZ43A3niH2aM4383nGtAldFGAtob7jL9uKuPi
        84aZ78E/dbWRfxLMCUtFu4//9m5uJ/54IM6kDsm89w==
X-Google-Smtp-Source: ABdhPJxJNKIzcTydfcq8l3OfDTW2Wj6PJ/9Mn6Z6QIIXygEekNyz/PbnPGOaYen0QceGgB3TPOcJbv29YXy9zAIuXc0=
X-Received: by 2002:a05:6512:2190:: with SMTP id b16mr22322694lft.122.1620777758826;
 Tue, 11 May 2021 17:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6GP415hmDUYU74LRrGYKCN4aAXGD-B=ctN8R7P3LnFUrw@mail.gmail.com>
 <20210511230228.GA2429744@bjorn-Precision-5520>
In-Reply-To: <20210511230228.GA2429744@bjorn-Precision-5520>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 11 May 2021 17:02:02 -0700
Message-ID: <CACK8Z6GEJt4_XMzJuT4LXdW9VToRZzGTn3QowTpdZaUDv5osjA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pci: Support "removable" attribute for PCI devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Oliver Neukum <oneukum@suse.com>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 11, 2021 at 4:02 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, May 11, 2021 at 03:15:11PM -0700, Rajat Jain wrote:
> > On Tue, May 11, 2021 at 2:30 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, Apr 23, 2021 at 07:16:31PM -0700, Rajat Jain wrote:
> > > ...
> > > This looks like a good start.  I think it would be useful to have a
> > > more concrete example of how this information will be used.  I know
> > > that use would be in userspace, so an example probably would not be a
> > > kernel patch.  If you have user code published anywhere, that would
> > > help.  Or even a patch to an existing daemon.  Or pointers to how
> > > "removable" is used for USB devices.
> >
> > Sure, I'll point to some existing user space code (which will be using
> > a similar attribute we are carrying internally).
>
> Great, thanks!
>
> > > > +     set_pci_dev_removable(dev);
> > >
> > > So this *only* sets the "removable" attribute based on the
> > > ExternalFacingPort or external-facing properties.  I think Oliver and
> > > David were hinting that maybe we should also set it for devices in
> > > hotpluggable slots.  What do you think?
> >
> > I did think about it. So I have a mixed feeling about this. Primarily
> > because I have seen the use of hotpluggable slots in situations where
> > we wouldn't want to classify the device as removable:
> >
> > - Using link-state based hotplug as a way to work around unstable PCIe
> > links. I have seen PCIe devices marked as hot-pluggable only to ensure
> > that if the PCIe device falls off PCI bus due to some reason (e.g. due
> > to SI issues or device firmware bugs), the kernel should be able to
> > detect it if it does come back up (remember quick "Link-Down" /
> > "Link-Up" events in succession?).
> >
> > - Internal hot-pluggable PCI devices. In my past life, I was working
> > on a large system that would have hot-pluggable daughter cards, but
> > those wouldn't be user removable. Also, it is conceivable to have
> > hot-pluggable M.2 slots for PCIe devices such as NVMEs etc, but they
> > may still not be removable by user. I don't think these should be
> > treated as "removable". I was also looking at USB as an example where
> > this originally came from, USB does ensure that only devices that are
> > "user visible" devices are marked as "removable":
> >
> > 54d3f8c63d69 ("usb: Set device removable state based on ACPI USB data")
> > d35e70d50a06 ("usb: Use hub port data to determine whether a port is removable")
>
> IIUC your main concern is consumer platforms where PCI devices would
> be hotplugged via a Thunderbolt or similar cable, and that port
> would be marked as an "ExternalFacingPort" so we'd mark them as
> "removable".

Yes.

>
> A device in a server hotplug slot would probably *not* be marked as
> "removable".  The same device in an external chassis connected via an
> iPass or similar cable *might* be "removable" depending on whether the
> firmware calls the iPass port an "ExternalFacingPort".

Yes.

>
> Does the following capture some of what you're thinking?  Maybe some
> wordsmithed version of it would be useful in a comment and/or commit
> log?

Yes, you captured my thoughts perfectly. I shall update the commit log
and / or provide comments to reflect this.

>
>   We're mainly concerned with consumer platforms with accessible
>   Thunderbolt ports that are vulnerable to DMA attacks, and we expect
>   those ports to be identified as "ExternalFacingPort".
>
>   Devices in traditional hotplug slots are also "removable," but not
>   as vulnerable because these slots are less accessible to users.
>
> > > I wonder if this (and similar hooks like set_pcie_port_type(),
> > > set_pcie_untrusted(), set_pcie_thunderbolt(), etc) should go *after*
> > > the early fixups so we could use fixups to work around issues?
> >
> > I agree. We can do that if none of the early fixups actually use the
> > fields set by these functions. I think it should be ok to move
> > set_pcie_untrusted(), set_pcie_thunderbolt(), but I wonder if any
> > early fixups already use the pcie_cap or any other fields set by
> > set_pcie_port_type().
>
> I think you should move the one you're adding
> (set_pci_dev_removable()) and leave the others where they are for now.

Ack, will do.

Thanks,

Rajat

>
> No need to expand the scope of your patch; I was just thinking they're
> all basically similar and should ideally be done at similar times.
>
> > > >       /* Early fixups, before probing the BARs */
> > > >       pci_fixup_device(pci_fixup_early, dev);
> > > >
> > > > --
> > > > 2.31.1.498.g6c1eba8ee3d-goog
> > > >
