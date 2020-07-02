Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276BB211D0B
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 09:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgGBHcX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 03:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbgGBHcX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Jul 2020 03:32:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82A882073E;
        Thu,  2 Jul 2020 07:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593675142;
        bh=9uMGCANmWxBqzGlyaZHnPio5yurOzxTiArpPB34Pebc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xtAUKiF9XpawbXtRL3SVO2WstqWIFh8gKEXMnezWRDH6VBXFMuet1kN0lJRAQGk7U
         wks4t4KltOcfWeoBt7MF071uhuTRxXBqaKUmCS7Pxc+jKmXfoVm13MoUwax5Yz+1Qa
         3Kp5HekQXyKIgWlreAnE1+523V+MlF/l2UlGjnVA=
Date:   Thu, 2 Jul 2020 09:32:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oliver O'Halloran <oohall@gmail.com>
Cc:     Rajat Jain <rajatja@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 5/7] driver core: Add device location to "struct
 device" and expose it in sysfs
Message-ID: <20200702073226.GB1073011@kroah.com>
References: <20200630044943.3425049-1-rajatja@google.com>
 <20200630044943.3425049-6-rajatja@google.com>
 <20200630104948.GC856968@kuha.fi.intel.com>
 <20200630125216.GA1109228@kroah.com>
 <CAJZ5v0iYFKrouQx_b7afPnz7ohjWOKKDhdHj_3HObKYV_rRhiw@mail.gmail.com>
 <20200630153816.GD1785141@kroah.com>
 <CAJZ5v0jUx-RVhJRDngkOXx-3szFJDOgCJs2yuGKFyo2f1qZAwA@mail.gmail.com>
 <20200630170012.GB1894898@kroah.com>
 <CACK8Z6Fcrb8PtmbUJLn8RgiGnC8eqTC9GjsgjPmQgU212WPU0Q@mail.gmail.com>
 <CAOSf1CEZ82iXhYnig0UScS+oRRaxHzSCge9LbA1hW3NaQAiSxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSf1CEZ82iXhYnig0UScS+oRRaxHzSCge9LbA1hW3NaQAiSxQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 02, 2020 at 03:23:23PM +1000, Oliver O'Halloran wrote:
> On Thu, Jul 2, 2020 at 4:07 AM Rajat Jain <rajatja@google.com> wrote:
> >
> > *snip*
> >
> > > > I guess it would make sense to have an attribute for user space to
> > > > write to in order to make the kernel reject device plug-in events
> > > > coming from a given port or connector, but the kernel has no reliable
> > > > means to determine *which* ports or connectors are "safe", and even if
> > > > there was a way for it to do that, it still may not agree with user
> > > > space on which ports or connectors should be regarded as "safe".
> > >
> > > Again, we have been doing this for USB devices for a very long time, PCI
> > > shouldn't be any different.  Why people keep ignoring working solutions
> > > is beyond me, there's nothing "special" about PCI devices here for this
> > > type of "worry" or reasoning to try to create new solutions.
> > >
> > > So, again, I ask, go do what USB does, and to do that, take the logic
> > > out of the USB core, make it bus-agnositic, and _THEN_ add it to the PCI
> > > code. Why the original submitter keeps ignoring my request to do this
> > > is beyond me, I guess they like making patches that will get rejected :(
> >
> > IMHO I'm actually trying to precisely do what I think was the
> > conclusion of our discussion, and then some changes because of the
> > further feedback I received on those patches. Let's take a step back
> > and please allow me to explain how I got here (my apologies but this
> > spans a couple of threads, and I"m trying to tie them all together
> > here):
> 
> The previous thread had some suggestions, but no real conclusions.
> That's probably why we're still arguing about it...
> 
> > GOAL: To allow user space to control what (PCI) drivers he wants to
> > allow on external (thunderbolt) ports. There was a lot of debate about
> > the need for such a policy at
> > https://lore.kernel.org/linux-pci/CACK8Z6GR7-wseug=TtVyRarVZX_ao2geoLDNBwjtB+5Y7VWNEQ@mail.gmail.com/
> > with the final conclusion that it should be OK to implement such a
> > policy in userspace, as long as the policy is not implemented in the
> > kernel. The kernel only needs to expose bits & info that is needed by
> > the userspace to implement such a policy, and it can be used in
> > conjunction with "drivers_autoprobe" to implement this policy:
> > --------------------------------------------------------------------
> > ....
> > That's an odd thing, but sure, if you want to write up such a policy for
> > your systems, great.  But that policy does not belong in the kernel, it
> > belongs in userspace.
> > ....
> > --------------------------------------------------------------------
> > 1) The post https://lore.kernel.org/linux-pci/20200609210400.GA1461839@bjorn-Precision-5520/
> > lists out the approach that was agreed on. Replicating it here:
> > -----------------------------------------------------------------------
> >   - Expose the PCI pdev->untrusted bit in sysfs.  We don't expose this
> >     today, but doing so would be trivial.  I think I would prefer a
> >     sysfs name like "external" so it's more descriptive and less of a
> >     judgment.
> >
> >     This comes from either the DT "external-facing" property or the
> >     ACPI "ExternalFacingPort" property.
> >
> >   - All devices present at boot are enumerated.  Any statically built
> >     drivers will bind to them before any userspace code runs.
> >
> >     If you want to keep statically built drivers from binding, you'd
> >     need to invent some mechanism so pci_driver_init() could clear
> >     drivers_autoprobe after registering pci_bus_type.
> >
> >   - Early userspace code prevents modular drivers from automatically
> >     binding to PCI devices:
> >
> >       echo 0 > /sys/bus/pci/drivers_autoprobe
> >
> >     This prevents modular drivers from binding to all devices, whether
> >     present at boot or hot-added.
> >
> >   - Userspace code uses the sysfs "bind" file to control which drivers
> >     are loaded and can bind to each device, e.g.,
> >
> >       echo 0000:02:00.0 > /sys/bus/pci/drivers/nvme/bind
> 
> I think this is a reasonable suggestion. However, as Greg pointed out
> it's gratuitously different to what USB does for no real reason.

Agreed.

> > -----------------------------------------------------------------------
> > 2) As part of implementing the above agreed approach, when I exposed
> > PCI "untrusted" attribute to userspace, it ran into discussion that
> > concluded that instead of this, the device core should be enhanced
> > with a location attribute.
> > https://lore.kernel.org/linux-pci/20200618184621.GA446639@kroah.com/
> > -----------------------------------------------------------------------
> > ...
> > The attribute should be called something like "location" or something
> > like that (naming is hard), as you don't always know if something is
> > external or not (it could be internal, it could be unknown, it could be
> > internal to an external device that you trust (think PCI drawers for
> > "super" computers that are hot pluggable but yet really part of the
> > internal bus).
> > ....
> > "trust" has no direct relation to the location, except in a policy of
> > what you wish to do with that device, so as long as you keep them
> > separate that way, I am fine with it.
> > ...
> > -----------------------------------------------------------------------
> >
> > And hence this patch. I don't see an attribute in USB comparable to
> > this new attribute, except for the boolean "removable" may be. Are you
> > suggesting to pull that into the device core instead of adding this
> > "physical_location" attribute?
> 
> He's suggesting you pull the "authorized" attribute into the driver
> core. That's the mechanism USB uses to block drivers binding unless
> userspace authorizes them. I don't see any reason why we can't re-use
> that sysfs interface for PCI devices since the problem being solved is
> fundamentally the same. The main question is what we should do as a
> default policy in the kernel. For USB the default comes from the
> "authorized_default" module param of usbcore:
> 
> > /* authorized_default behaviour:
> >  * -1 is authorized for all devices except wireless (old behaviour)
> >  * 0 is unauthorized for all devices
> >  * 1 is authorized for all devices
> >  * 2 is authorized for internal devices
> >  */
> > #define USB_AUTHORIZE_WIRED   -1
> > #define USB_AUTHORIZE_NONE    0
> > #define USB_AUTHORIZE_ALL     1
> > #define USB_AUTHORIZE_INTERNAL        2
> >
> > static int authorized_default = USB_AUTHORIZE_WIRED;
> > module_param(authorized_default, int, S_IRUGO|S_IWUSR);
> 
> So the default policy for USB is to authorize any wired USB device and
> we can optionally restrict that to just integrated devices. Sounding
> familiar?

Thank you, that is what I have been trying to get across here, obviously
I didn't do a good job.  :)

Thanks for the summary.

> The internal / external status is still useful to know so we might
> want to make a sysfs attribute for that too. However, I'd like to
> point out that internal / external isn't the whole story. As I
> mentioned in the last thread if I have a BMC device I *really* don't
> want it to be authorized by default even though it's an internal
> device. Similarly, if I know all my internal cards support PCIe
> Component Authentication then I might choose not to trust any PCI
> devices unless they authenticate successfully.

Agreed.

> > 3) The one deviation from the agreed approach in (1) is
> > https://patchwork.kernel.org/patch/11633095/ . The reason is I
> > realized that contrary to what I earlier believed, we might not be
> > able to disable the PCI link to all external PCI devices at boot. So
> > external PCI devices may actually bind to drivers before userspace
> > comes up and does "echo 0 > /sys/bus/pci/drivers_autoprobe").
> 
> Yep, that's a problem. If we want to provide a useful mechanism to
> userspace then the default behaviour of the kernel can't undermine
> that mechanism. If that means we need another kernel command line
> parameter then I guess we just have to live with it.

I really do not want yet-another-kernel-command-line-option if we can
help it at all.  Sane defaults are the best thing to do here.  Userspace
comes up really early, put your policy in there, not in blobs passed
from your bootloader.

thanks,

greg k-h
