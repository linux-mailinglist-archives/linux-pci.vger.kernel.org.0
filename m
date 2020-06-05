Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049531EF2A3
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jun 2020 10:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgFEICd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jun 2020 04:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgFEICd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jun 2020 04:02:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5698F206E6;
        Fri,  5 Jun 2020 08:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591344151;
        bh=CoHBeLSQsOKCK9e3iScbJC0JUQmuPB+yRgWT4d8b4gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=stGKkPV722UeONEGXfEv2y787Ta/WZWF2yhccvfSP7ncJJr/f7lSI9+/KjwqeeCcP
         VSpMi4eQ1r7LYHitD0hIo7+ML6XptTjgZV/zOhD8SkqokxSO9tbJ9O60UJZQu96oT+
         c6i5GWQMsO4ervgj3MrYCu8uUjTaM4Vdwczx1VrU=
Date:   Fri, 5 Jun 2020 10:02:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Rajat Jain <rajatxjain@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
Message-ID: <20200605080229.GC2209311@kroah.com>
References: <CACK8Z6F3jE-aE+N7hArV3iye+9c-COwbi3qPkRPxfrCnccnqrw@mail.gmail.com>
 <20200601232542.GA473883@bjorn-Precision-5520>
 <20200602050626.GA2174820@kroah.com>
 <CAA93t1puWzFx=1h0xkZEkpzPJJbBAF7ONL_wicSGxHjq7KL+WA@mail.gmail.com>
 <20200603060751.GA465970@kroah.com>
 <CACK8Z6EXDf2vUuJbKm18R6HovwUZia4y_qUrTW8ZW+8LA2+RgA@mail.gmail.com>
 <20200603121613.GA1488883@kroah.com>
 <CACK8Z6EOGduHX1m7eyhFgsGV7CYiVN0en4U0cM4BEWJwk2bmoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6EOGduHX1m7eyhFgsGV7CYiVN0en4U0cM4BEWJwk2bmoA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 04, 2020 at 12:38:18PM -0700, Rajat Jain wrote:
> Hello,
> 
> I spent some more thoughts into this...
> 
> On Wed, Jun 3, 2020 at 5:16 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jun 03, 2020 at 04:51:18AM -0700, Rajat Jain wrote:
> > > Hello,
> > >
> > > >
> > > > > Thanks for the pointer! I'm still looking at the details yet, but a
> > > > > quick look (usb_dev_authorized()) seems to suggest that this API is
> > > > > "device based". The multiple levels of "authorized" seem to take shape
> > > > > from either how it is wired or from userspace choice. Once authorized,
> > > > > USB device or interface is authorized to be used by *anyone* (can be
> > > > > attached to any drivers). Do I understand it right that it does not
> > > > > differentiate between drivers?
> > > >
> > > > Yes, and that is what you should do, don't fixate on drivers.  Users
> > > > know how to control and manage devices.  Us kernel developers are
> > > > responsible for writing solid drivers and getting them merged into the
> > > > kernel tree and maintaining them over time.  Drivers in the kernel
> > > > should always be trusted, ...
> > >
> > > 1) Yes, I agree that this would be ideal, and this should be our
> > > mission. I should clarify that I may have used the wrong term
> > > "Trusted/Certified drivers". I didn't really mean that the drivers may
> > > be malicious by intent. What I really meant is that a driver may have
> > > an attack surface, which is a vulnerability that may be exploited.
> >
> > Any code has such a thing, proving otherwise is a tough problem :)
> >
> > > Realistically speaking, finding vulnerabilities in drivers, creating
> > > attacks to exploit them, and fixing them is a never ending cat and
> > > mouse game. At Least "identifying the vulnerabilities" part is better
> > > performed by security folks rather than driver writers.
> >
> > Are you sure about that?  It's hard to prove a negative :)
> >
> > > Earlier in the
> > > thread I had mentioned certain studies/projects that identified and
> > > exploited such vulnerabilities in the drivers. I should have used the
> > > term "Vetted Drivers" maybe to convey the intent better - drivers that
> > > have been vetted by a security focussed team (admin). What I'm
> > > advocating here is an administrator's right to control the drivers
> > > that he wants to allow for external ports on his systems.
> >
> > That's an odd thing, but sure, if you want to write up such a policy for
> > your systems, great.  But that policy does not belong in the kernel, it
> > belongs in userspace.
> >
> > > 2) In addition to the problem of driver negligences / vulnerabilities
> > > to be exploited, we ran into another problem with the "whitelist
> > > devices only" approach. We did start with the "device based" approach
> > > only initially - but quickly realized that anything we use to
> > > whitelist an external device can only be based on the info provided by
> > > *that device* itself. So until we have devices that exchange
> > > certificates with kernel [1], it is easy for a malicious device to
> > > spoof a whitelisted device (by presenting the same VID:DID or any
> > > other data that is used by us to whitelist it).
> > >
> > > [1] https://www.intel.com/content/www/us/en/io/pci-express/pcie-device-security-enhancements-spec.html
> > >
> > > I hope that helps somewhat clarify how / why we reached here?
> >
> > Kind of, I still think all you need to do is worry about controling the
> > devices and if a driver should bind to it or not.  Again, much like USB
> > has been doing for a very long time now.  The idea of "spoofing" ids
> > also is not new, and has been around for a very long time as well, and
> > again, the controls that the USB core gives you allows you to make any
> > type of policy decision you want to, in userspace.
> 
> Er, *currently* it doesn't allow the userspace to make the particular
> policy I want to, right? Specifically, today an administrator can not
> control which USB *drivers* he wants to allow on an *external* USB
> port.

Not true, you can do that today with the explicit binding/unbinding of
devices to drivers in userspace.  Been there for many decades :)

But, think this through, since when do you have _multiple_ drivers that
have support to control the same type of device?  We almost never allow
that in the kernel today as that way lies madness (no heiarchy of
drivers to bind to what devices and so on.)

We always strive to keep a one-to-one mapping of "this device is only
allowed to be controlled by this one driver" today, why would you want
to change that basic premise now?

> He can only control which USB devices he wants to authorize, but
> once authorized, they are free to bind to any of the USB drivers.

Since when do different drivers control the same type of USB device?  :)

> So if I want to allow the administrator to implement a policy that
> allows him to control the drivers for external ports, we'll need to
> enhance the current code (whether we want to do it specific to a bus,
> or more generically in the driver core). Are we on the same page?
> 
> To implement the policy that I want to in the driver core, what is
> missing today in driver core is a distinction between "internal" and
> "external" devices. Some buses have this knowledge locally today (PCI
> has "untrusted" flag which can be used, USB uses hcd->wireless and
> hub->port->connect_type) but it is not shared with the core.

Note the wireless USB code should now be gone from the tree.  If you see
any remants of it floating around, let me know and I will remove them, I
think there might be a few bits left that I missed.

> So just to make sure if I'm thinking in the right direction, this is
> what I'm thinking:
> 
> 1) The device core needs a notion of internal vs external devices (a
> flag) - a knowledge that needs to be filled in by the bus as it
> discovers the device.

Nope, don't go down this path.  We tried to do this for USB where the
BIOS tells us that a device is "internal" vs. "external" but in reality,
BIOSes get this wrong and it's not always all that useful.

And why would you somehow "trust" a device that is in your system more
than one is not?  The same driver binds to it no matter what (as I state
above), so you should be able to trust it the same.

> 2) The driver core needs to allow an admin to provide a whitelist of
> drivers for external devices. (Via Command line or a driver flag.
> Default = everything is whitelisted).

Again, nope, no difference, see above.

> 3) While matching a driver to a device, the driver core needs to
> impose the whitelist if the device is external, and if the
> administrator has provided a whitelist.

Ick, no, again, work on a per-device authorized setting.  That way it
works the same all across the system.  Don't get stuck in a "external
vs. internal" discussion as this will get messy really quickly (think
about "internal" devices with "external" links to them like PCI
"drawers" of devices that we currently support on large systems.  Or
things like thunderbolt hubs with "internal" devices like I have on my
desktop right now.

In summary, if a driver is "trusted enough" to control an internal
device, it should be "trusted enough" to control an external device.  If
not, then fix that driver so that you do "trust" it.

thanks,

greg k-h
