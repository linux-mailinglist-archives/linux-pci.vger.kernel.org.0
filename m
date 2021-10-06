Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6707342378C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 07:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhJFFrH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 01:47:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhJFFrH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Oct 2021 01:47:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08C45610A8;
        Wed,  6 Oct 2021 05:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633499115;
        bh=TkhOS3oV3aBi6/QsuUnIcb7Tuh/r6ed2nyWTvBNeZCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ja+ryf444x6Di/ECYJ1MMxrIt8xWGjoeayFFSxzN7eUIV+0TdxlBE0oLlQK/Z6CPA
         Mkt0M00dGomHevaZhMCpHpdn51zXqCAEv+4jonKBlHTIZ50E6rRLws7+HdzmJccBZV
         CwuhTxux4JPGErPjZnNy3G/8slESpIe3e8+O8gMs=
Date:   Wed, 6 Oct 2021 07:45:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
Message-ID: <YV036H5iGd7FKg+E@kroah.com>
References: <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
 <YVaywQLAboZ6b36V@kroah.com>
 <CAPcyv4gqs=KuGyxFR61QWqF6HKrRg851roCGUqrq585+s2Cm=w@mail.gmail.com>
 <20211001164533.GC505557@rowland.harvard.edu>
 <CAPcyv4i__reKFRP1KjWUov_W5jBQN9_vbUbKRL_V7KMM3oPuuQ@mail.gmail.com>
 <20211001190048.GA512418@rowland.harvard.edu>
 <CAPcyv4hYL51DcBuSuyMRFo5Jcc=zLd=Ugo+H_2saELcZ5AJBeQ@mail.gmail.com>
 <YVqONA0vhl0/H3QE@lahna>
 <CAPcyv4im4Tsj1SnxSWe=cAHBP1mQ=zgO-D81n2BpD+_HkpitbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4im4Tsj1SnxSWe=cAHBP1mQ=zgO-D81n2BpD+_HkpitbQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 05, 2021 at 03:33:29PM -0700, Dan Williams wrote:
> On Sun, Oct 3, 2021 at 10:16 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi,
> >
> > On Fri, Oct 01, 2021 at 12:57:18PM -0700, Dan Williams wrote:
> > > > > Ah, so are you saying that it would be sufficient for USB if the
> > > > > generic authorized implementation did something like:
> > > > >
> > > > > dev->authorized = 1;
> > > > > device_attach(dev);
> > > > >
> > > > > ...for the authorize case, and:
> > > > >
> > > > > dev->authorize = 0;
> > > > > device_release_driver(dev);
> > > > >
> > > > > ...for the deauthorize case?
> > > >
> > > > Yes, I think so.  But I haven't tried making this change to test and
> > > > see what really happens.
> > >
> > > Sounds like a useful path for this effort to explore. Especially as
> > > Greg seems to want the proposed "has_probe_authorization" flag in the
> > > bus_type to disappear and make this all generic. It just seems that
> > > Thunderbolt would need deeper surgery to move what it does in the
> > > authorization toggle path into the probe and remove paths.
> > >
> > > Mika, do you see a path for Thunderbolt to align its authorization
> > > paths behind bus ->probe() ->remove() events similar to what USB might
> > > be able to support for a generic authorization path?
> >
> > In Thunderbolt "authorization" actually means whether there is a PCIe
> > tunnel to the device or not. There is no driver bind/unbind happening
> > when authorization toggles (well on Thunderbolt bus, there can be on PCI
> > bus after the tunnel is established) so I'm not entirely sure how we
> > could use the bus ->probe() or ->remove for that to be honest.
> 
> Greg, per your comment:
> 
> "... which was to move the way that busses are allowed to authorize
> the devices they wish to control into a generic way instead of being
> bus-specific logic."
> 
> We have USB and TB that have already diverged on the ABI here. The USB
> behavior is more in line with the "probe authorization" concept, while
> TB is about tunnel establishment and not cleanly tied to probe
> authorization. So while I see a path to a common authorization
> implementation for USB and other buses (per the insight from Alan), TB
> needs to retain the ability to record the authorization state as an
> enum rather than a bool, and emit a uevent on authorization status
> change.
> 
> So how about something like the following that moves the attribute
> into the core, but still calls back to TB and USB to perform their
> legacy authorization work. This new authorized attribute only shows up
> when devices default to not authorized, i.e. when userspace owns the
> allow list past critical-boot built-in drivers, or if the bus (USB /
> TB) implements ->authorize().

At quick glance, this looks better, but it would be good to see someone
test it :)

thanks,

greg k-h
