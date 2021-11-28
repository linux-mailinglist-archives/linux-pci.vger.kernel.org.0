Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AC54605C0
	for <lists+linux-pci@lfdr.de>; Sun, 28 Nov 2021 12:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhK1LNE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Nov 2021 06:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357169AbhK1LLE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Nov 2021 06:11:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0D8C061758;
        Sun, 28 Nov 2021 03:07:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C83F0B80B26;
        Sun, 28 Nov 2021 11:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B2FC004E1;
        Sun, 28 Nov 2021 11:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638097628;
        bh=v7cxfg1IWWR/ZzTX0d9ZOPxttph66qinQjGsJ2S31UA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8mCqVBi00/PDm4cRlYF11PtzZS7QFUikhFx7Vp7THlW9e1s6bK6Mw3OCWT51zFO5
         VmQF5aGDWVQV5bOzH/hHLbM3Mt9ML22VXRfpDs5mpqLbOGHx610wlR050V+XudB+R+
         Qauv3MyPNXGSvjo9whHBMw8tF526RUBvCsXU2h4Y=
Date:   Sun, 28 Nov 2021 12:07:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [patch 31/32] genirq/msi: Simplify sysfs handling
Message-ID: <YaNi2RkiYdnoEDau@kroah.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232736.135247787@linutronix.de>
 <YaIlX8bef2jPLkUE@kroah.com>
 <87lf19fl9i.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf19fl9i.ffs@tglx>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 27, 2021 at 08:31:37PM +0100, Thomas Gleixner wrote:
> On Sat, Nov 27 2021 at 13:32, Greg Kroah-Hartman wrote:
> > On Sat, Nov 27, 2021 at 02:23:15AM +0100, Thomas Gleixner wrote:
> >> The sysfs handling for MSI is a convoluted maze and it is in the way of
> >> supporting dynamic expansion of the MSI-X vectors because it only supports
> >> a one off bulk population/free of the sysfs entries.
> >> 
> >> Change it to do:
> >> 
> >>    1) Creating an empty sysfs attribute group when msi_device_data is
> >>       allocated
> >> 
> >>    2) Populate the entries when the MSI descriptor is initialized
> >
> > How much later does this happen?  Can it happen while the device has a
> > driver bound to it?
> 
> That's not later than before. It's when the driver initializes the
> MSI[X] interrupts, which usually happens in the probe() function.
> 
> The difference is that the group, (i.e.) directory is created slightly
> earlier.

Ok, but that still happens when probe() is called for the driver, right?

> >> +
> >> +static inline int msi_sysfs_create_group(struct device *dev)
> >> +{
> >> +	return devm_device_add_group(dev, &msi_irqs_group);
> >
> > Much nicer, but you changed the lifetime rules of when these attributes
> > will be removed, is that ok?
> 
> The msi entries are removed at the same place as they are removed in the
> current mainline code, i.e. when the device driver shuts the device
> down and disables MSI[X], which happens usually during remove()
> 
> What's different now is that the empty group stays around a bit
> longer. I don't see how that matters.

How much longer does it stick around?

What happens if this sequence happens:
	- probe()
	- disconnect()
	- probe()
with the same device (i.e. the device is not removed from the system)?

Which can happen as userspace can trigger disconnect() or even worse, if
the driver is unloaded and then loaded again?  Will the second call to
create this directory fail as it is not cleaned up yet?

I can never remember if devm_*() stuff sticks around for the device
lifecycle, or for the driver/device lifecycle, which is one big reason
why I don't like that api...

> > I still worry that these attributes show up "after" the device is
> > registered with the driver core, but hey, it's no worse than it
> > currently is, so that's not caused by this patch series...
> 
> Happens that register before or after driver->probe()?

During probe is a bit too late, but we can handle that as we are used to
it.  If it happens after probe() succeeds, based on something else being
asked for in the driver (like the device being opened), then userspace
has no chance of ever noticing these attributes being added.

But again, this isn't new to your code series, so I wouldn't worry about
it.  Obviously userspace tools do not care or really notice these
attributes at all otherwise the authors of them would have complained
a long time ago :)

So again, no real objection from me here, just meta-comments, except for
the above thing with the devm_* call to ensure that the
probe/disconnect/probe sequence will still work just as well as it does
today.  Should be easy enough to test out by just unloading a module and
then loading it again with this patch series applied.

thanks,

greg k-h
