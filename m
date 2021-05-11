Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDBD37B20F
	for <lists+linux-pci@lfdr.de>; Wed, 12 May 2021 01:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhEKXDm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 19:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKXDm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 May 2021 19:03:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3541561624;
        Tue, 11 May 2021 23:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774155;
        bh=BIKyXFoa74TTi5KNBShiCcyApEkI7I0Isisr4tY8eTs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V8pmrmEg/hRJTMOS1agePsx4onbtt4kay/0LeUCfitI3vveS/rfSEUxQY5WbM5v66
         ZeYrz7JsSMd8vGt5vQzNl+pz/YFIbsr/kKCEU9e9rc+qqpp97VHlyZYoJI4IpYKL8b
         9Gljda93u6s+oD6SKywj6dFoZiHMdvCVTCqtdP2x1W49wFCKKzbpTxefI4oa7eu16Z
         /VM72FHdfRxDQipx82hG06AGmTAQLyBdCPyltNk5w7jx/oFBkIINcfev7Sk3L3ZGss
         +Oq2rREBf5DOekyX+hVFe/3YT2T3tEEBkMB/KJdnmzrLOkBaXVYIy+1pH8ESOCiqul
         OXE+R6F24jz7A==
Date:   Tue, 11 May 2021 18:02:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
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
Subject: Re: [PATCH v2 2/2] pci: Support "removable" attribute for PCI devices
Message-ID: <20210511230228.GA2429744@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6GP415hmDUYU74LRrGYKCN4aAXGD-B=ctN8R7P3LnFUrw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 11, 2021 at 03:15:11PM -0700, Rajat Jain wrote:
> On Tue, May 11, 2021 at 2:30 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Apr 23, 2021 at 07:16:31PM -0700, Rajat Jain wrote:
> > ...
> > This looks like a good start.  I think it would be useful to have a
> > more concrete example of how this information will be used.  I know
> > that use would be in userspace, so an example probably would not be a
> > kernel patch.  If you have user code published anywhere, that would
> > help.  Or even a patch to an existing daemon.  Or pointers to how
> > "removable" is used for USB devices.
> 
> Sure, I'll point to some existing user space code (which will be using
> a similar attribute we are carrying internally).

Great, thanks!

> > > +     set_pci_dev_removable(dev);
> >
> > So this *only* sets the "removable" attribute based on the
> > ExternalFacingPort or external-facing properties.  I think Oliver and
> > David were hinting that maybe we should also set it for devices in
> > hotpluggable slots.  What do you think?
> 
> I did think about it. So I have a mixed feeling about this. Primarily
> because I have seen the use of hotpluggable slots in situations where
> we wouldn't want to classify the device as removable:
> 
> - Using link-state based hotplug as a way to work around unstable PCIe
> links. I have seen PCIe devices marked as hot-pluggable only to ensure
> that if the PCIe device falls off PCI bus due to some reason (e.g. due
> to SI issues or device firmware bugs), the kernel should be able to
> detect it if it does come back up (remember quick "Link-Down" /
> "Link-Up" events in succession?).
> 
> - Internal hot-pluggable PCI devices. In my past life, I was working
> on a large system that would have hot-pluggable daughter cards, but
> those wouldn't be user removable. Also, it is conceivable to have
> hot-pluggable M.2 slots for PCIe devices such as NVMEs etc, but they
> may still not be removable by user. I don't think these should be
> treated as "removable". I was also looking at USB as an example where
> this originally came from, USB does ensure that only devices that are
> "user visible" devices are marked as "removable":
> 
> 54d3f8c63d69 ("usb: Set device removable state based on ACPI USB data")
> d35e70d50a06 ("usb: Use hub port data to determine whether a port is removable")

IIUC your main concern is consumer platforms where PCI devices would
be hotplugged via a Thunderbolt or similar cable, and that port
would be marked as an "ExternalFacingPort" so we'd mark them as
"removable".

A device in a server hotplug slot would probably *not* be marked as
"removable".  The same device in an external chassis connected via an
iPass or similar cable *might* be "removable" depending on whether the
firmware calls the iPass port an "ExternalFacingPort".

Does the following capture some of what you're thinking?  Maybe some
wordsmithed version of it would be useful in a comment and/or commit
log?

  We're mainly concerned with consumer platforms with accessible
  Thunderbolt ports that are vulnerable to DMA attacks, and we expect
  those ports to be identified as "ExternalFacingPort".

  Devices in traditional hotplug slots are also "removable," but not
  as vulnerable because these slots are less accessible to users.

> > I wonder if this (and similar hooks like set_pcie_port_type(),
> > set_pcie_untrusted(), set_pcie_thunderbolt(), etc) should go *after*
> > the early fixups so we could use fixups to work around issues?
> 
> I agree. We can do that if none of the early fixups actually use the
> fields set by these functions. I think it should be ok to move
> set_pcie_untrusted(), set_pcie_thunderbolt(), but I wonder if any
> early fixups already use the pcie_cap or any other fields set by
> set_pcie_port_type().

I think you should move the one you're adding
(set_pci_dev_removable()) and leave the others where they are for now.

No need to expand the scope of your patch; I was just thinking they're
all basically similar and should ideally be done at similar times.

> > >       /* Early fixups, before probing the BARs */
> > >       pci_fixup_device(pci_fixup_early, dev);
> > >
> > > --
> > > 2.31.1.498.g6c1eba8ee3d-goog
> > >
