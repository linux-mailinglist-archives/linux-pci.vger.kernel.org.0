Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F5137EEFA
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 01:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhELWji (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 18:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349240AbhELWbB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 18:31:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86354C06135E
        for <linux-pci@vger.kernel.org>; Wed, 12 May 2021 15:29:07 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id g4so6518075lfv.6
        for <linux-pci@vger.kernel.org>; Wed, 12 May 2021 15:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=euIbK43tiaRQ+KGS8zmTT7eimhqDbUuewW75dr1LJ2I=;
        b=jNbXcBcnCu5Ai7idr7/7XtKlD8XRb4+qbPNhsYNoPVH0oxlKvWs0bLqgDPH6s6sNEW
         ajA6iWqM5ysmHP8NRRqk3m65e4Gb2+QIpiWECw2bayBuIV9MTidJeFJP4zHa2N/4Wo1a
         MUpvsAlJMNR5gHEXbT+DZQ6FAACuaZGxaQfa3ITUEFea2gGShNuhHAl3Fc16vAxPMi1V
         EJzTfKGlqLuhVD2B+ew3fbfonxUkhzFAVoI7IS7vuJXAiR2A1qLMmIdDMkGSzi4tLYd/
         CLSPmdck5PGxKWLWKVnexrIFS9wM0wj5cwQ39nwUOONNQLiomRwvc5EQpI/G3xRQryKV
         bTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=euIbK43tiaRQ+KGS8zmTT7eimhqDbUuewW75dr1LJ2I=;
        b=C6h4rSOXShEsq+wEhJGZC15OWhM94+5mjVPSbjBYuGucjGq4ltXgpW37r2e8BVvJ3D
         HsGqrF7v3d1panTlc6lzIrwwdo5J2RoS3Npzdvte/fkjbZE6hoeWPNZGjftsxNqld8+u
         tlgy8cNGQ4UScUOZGcYcMT6MFP5BkzvXwzLjhVH8YYhOCIWaDAwLvRlybkvTs95M/PJT
         Zi5Oi0UWh+TThCHvL0T4TYXeYD37HITMTYEy17AI7crWweGwdRCGo36D1qAl3QGdhyHY
         LMNDcDhxD8cf7ETGifaLZBhnM92A+DlYplA7Fh76Vee0wIow4AhnW5swilED+b3vJxZ4
         aAVA==
X-Gm-Message-State: AOAM533+Tp0RDp5bw67iRXgBsZLnfZ60t+LOh0sxRffK1BxQtC90eqou
        lpu43TuOyzkCJlw4T5398jqMuZgm+lzwmHVTvrDpkw==
X-Google-Smtp-Source: ABdhPJyuzhlTIWKLKvHBWtG8ylpeaOs72St27ZpF7ovn55bVTWNgnn98m0MIov6W6+j3Y3H2/4RjrCgsoMPcY+WcAt8=
X-Received: by 2002:a19:4086:: with SMTP id n128mr13570069lfa.464.1620858545793;
 Wed, 12 May 2021 15:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6GP415hmDUYU74LRrGYKCN4aAXGD-B=ctN8R7P3LnFUrw@mail.gmail.com>
 <20210511230228.GA2429744@bjorn-Precision-5520> <CACK8Z6GEJt4_XMzJuT4LXdW9VToRZzGTn3QowTpdZaUDv5osjA@mail.gmail.com>
In-Reply-To: <CACK8Z6GEJt4_XMzJuT4LXdW9VToRZzGTn3QowTpdZaUDv5osjA@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 12 May 2021 15:28:29 -0700
Message-ID: <CACK8Z6FNxHe_0KavGDOK=SOs_NHeSA-KsnZP28meESATazv8PQ@mail.gmail.com>
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

Posted v3 of this patch here:
https://lore.kernel.org/patchwork/patch/1428134/

On Tue, May 11, 2021 at 5:02 PM Rajat Jain <rajatja@google.com> wrote:
>
> On Tue, May 11, 2021 at 4:02 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, May 11, 2021 at 03:15:11PM -0700, Rajat Jain wrote:
> > > On Tue, May 11, 2021 at 2:30 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Fri, Apr 23, 2021 at 07:16:31PM -0700, Rajat Jain wrote:
> > > > ...
> > > > This looks like a good start.  I think it would be useful to have a
> > > > more concrete example of how this information will be used.  I know
> > > > that use would be in userspace, so an example probably would not be a
> > > > kernel patch.  If you have user code published anywhere, that would
> > > > help.  Or even a patch to an existing daemon.  Or pointers to how
> > > > "removable" is used for USB devices.
> > >
> > > Sure, I'll point to some existing user space code (which will be using
> > > a similar attribute we are carrying internally).
> >
> > Great, thanks!
> >
> > > > > +     set_pci_dev_removable(dev);
> > > >
> > > > So this *only* sets the "removable" attribute based on the
> > > > ExternalFacingPort or external-facing properties.  I think Oliver and
> > > > David were hinting that maybe we should also set it for devices in
> > > > hotpluggable slots.  What do you think?
> > >
> > > I did think about it. So I have a mixed feeling about this. Primarily
> > > because I have seen the use of hotpluggable slots in situations where
> > > we wouldn't want to classify the device as removable:
> > >
> > > - Using link-state based hotplug as a way to work around unstable PCIe
> > > links. I have seen PCIe devices marked as hot-pluggable only to ensure
> > > that if the PCIe device falls off PCI bus due to some reason (e.g. due
> > > to SI issues or device firmware bugs), the kernel should be able to
> > > detect it if it does come back up (remember quick "Link-Down" /
> > > "Link-Up" events in succession?).
> > >
> > > - Internal hot-pluggable PCI devices. In my past life, I was working
> > > on a large system that would have hot-pluggable daughter cards, but
> > > those wouldn't be user removable. Also, it is conceivable to have
> > > hot-pluggable M.2 slots for PCIe devices such as NVMEs etc, but they
> > > may still not be removable by user. I don't think these should be
> > > treated as "removable". I was also looking at USB as an example where
> > > this originally came from, USB does ensure that only devices that are
> > > "user visible" devices are marked as "removable":
> > >
> > > 54d3f8c63d69 ("usb: Set device removable state based on ACPI USB data")
> > > d35e70d50a06 ("usb: Use hub port data to determine whether a port is removable")
> >
> > IIUC your main concern is consumer platforms where PCI devices would
> > be hotplugged via a Thunderbolt or similar cable, and that port
> > would be marked as an "ExternalFacingPort" so we'd mark them as
> > "removable".
>
> Yes.
>
> >
> > A device in a server hotplug slot would probably *not* be marked as
> > "removable".  The same device in an external chassis connected via an
> > iPass or similar cable *might* be "removable" depending on whether the
> > firmware calls the iPass port an "ExternalFacingPort".
>
> Yes.
>
> >
> > Does the following capture some of what you're thinking?  Maybe some
> > wordsmithed version of it would be useful in a comment and/or commit
> > log?
>
> Yes, you captured my thoughts perfectly. I shall update the commit log
> and / or provide comments to reflect this.
>
> >
> >   We're mainly concerned with consumer platforms with accessible
> >   Thunderbolt ports that are vulnerable to DMA attacks, and we expect
> >   those ports to be identified as "ExternalFacingPort".
> >
> >   Devices in traditional hotplug slots are also "removable," but not
> >   as vulnerable because these slots are less accessible to users.
> >
> > > > I wonder if this (and similar hooks like set_pcie_port_type(),
> > > > set_pcie_untrusted(), set_pcie_thunderbolt(), etc) should go *after*
> > > > the early fixups so we could use fixups to work around issues?
> > >
> > > I agree. We can do that if none of the early fixups actually use the
> > > fields set by these functions. I think it should be ok to move
> > > set_pcie_untrusted(), set_pcie_thunderbolt(), but I wonder if any
> > > early fixups already use the pcie_cap or any other fields set by
> > > set_pcie_port_type().
> >
> > I think you should move the one you're adding
> > (set_pci_dev_removable()) and leave the others where they are for now.
>
> Ack, will do.
>
> Thanks,
>
> Rajat
>
> >
> > No need to expand the scope of your patch; I was just thinking they're
> > all basically similar and should ideally be done at similar times.
> >
> > > > >       /* Early fixups, before probing the BARs */
> > > > >       pci_fixup_device(pci_fixup_early, dev);
> > > > >
> > > > > --
> > > > > 2.31.1.498.g6c1eba8ee3d-goog
> > > > >
