Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B984846096E
	for <lists+linux-pci@lfdr.de>; Sun, 28 Nov 2021 20:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbhK1Tic (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Nov 2021 14:38:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49096 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbhK1Tgc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Nov 2021 14:36:32 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638127993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1GlxYQghjX/NPZP4Y4QM4fareAu4mBm93KG+myCiGto=;
        b=DgcprPBW/81BkSHjJgmsxjaRqitbjGL9EDMFHHZ2nCVm9ZNuM+gjECAv90JUHFxIrui/L+
        i8xnBM1FGsJYSxNTiCauSdv5yq6vcYFxjg+FI4ckbVHmijipJqfqB/tp1npM9PeYCOem7w
        WnJURZe7FSx9wfTCeaewenlJgqEez6dqTl1QMrs4TNmeae/FEBB98svXJROIwA5OrHNTX7
        9naqvYA4XfNvKY9+xYUYkGJQIupfvGqG6TqdnkTyCSBDA/ixiT0p7IuVArVx4YX/t987LW
        XaTE6vqhjiMCzwIGTWR49NxaOW6QNxg7HHdQ4VMUSEWf8Lt9R9AeQEE8/+D0/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638127993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1GlxYQghjX/NPZP4Y4QM4fareAu4mBm93KG+myCiGto=;
        b=0YFK2ikLD85dMchKzkQEjIhjX0qFq4rzV5LTolOrL2HSk1n7hhTkLtb+10n0f+lAvVO+JT
        ZOgkaWMfNUcjy/Dg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [patch 31/32] genirq/msi: Simplify sysfs handling
In-Reply-To: <YaNi2RkiYdnoEDau@kroah.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232736.135247787@linutronix.de> <YaIlX8bef2jPLkUE@kroah.com>
 <87lf19fl9i.ffs@tglx> <YaNi2RkiYdnoEDau@kroah.com>
Date:   Sun, 28 Nov 2021 20:33:13 +0100
Message-ID: <871r30f53a.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 28 2021 at 12:07, Greg Kroah-Hartman wrote:
> On Sat, Nov 27, 2021 at 08:31:37PM +0100, Thomas Gleixner wrote:
>> On Sat, Nov 27 2021 at 13:32, Greg Kroah-Hartman wrote:
>> > On Sat, Nov 27, 2021 at 02:23:15AM +0100, Thomas Gleixner wrote:
>> >> The sysfs handling for MSI is a convoluted maze and it is in the way of
>> >> supporting dynamic expansion of the MSI-X vectors because it only supports
>> >> a one off bulk population/free of the sysfs entries.
>> >> 
>> >> Change it to do:
>> >> 
>> >>    1) Creating an empty sysfs attribute group when msi_device_data is
>> >>       allocated
>> >> 
>> >>    2) Populate the entries when the MSI descriptor is initialized
>> >
>> > How much later does this happen?  Can it happen while the device has a
>> > driver bound to it?
>> 
>> That's not later than before. It's when the driver initializes the
>> MSI[X] interrupts, which usually happens in the probe() function.
>> 
>> The difference is that the group, (i.e.) directory is created slightly
>> earlier.
>
> Ok, but that still happens when probe() is called for the driver,
> right?

Yes.

>> >> +static inline int msi_sysfs_create_group(struct device *dev)
>> >> +{
>> >> +	return devm_device_add_group(dev, &msi_irqs_group);
>> >
>> > Much nicer, but you changed the lifetime rules of when these attributes
>> > will be removed, is that ok?
>> 
>> The msi entries are removed at the same place as they are removed in the
>> current mainline code, i.e. when the device driver shuts the device
>> down and disables MSI[X], which happens usually during remove()
>> 
>> What's different now is that the empty group stays around a bit
>> longer. I don't see how that matters.
>
> How much longer does it stick around?
>
> What happens if this sequence happens:
> 	- probe()
> 	- disconnect()
> 	- probe()
> with the same device (i.e. the device is not removed from the system)?
>
> Which can happen as userspace can trigger disconnect() or even worse, if
> the driver is unloaded and then loaded again?  Will the second call to
> create this directory fail as it is not cleaned up yet?
>
> I can never remember if devm_*() stuff sticks around for the device
> lifecycle, or for the driver/device lifecycle, which is one big reason
> why I don't like that api...

Driver lifecycle AFAICT.

>> > I still worry that these attributes show up "after" the device is
>> > registered with the driver core, but hey, it's no worse than it
>> > currently is, so that's not caused by this patch series...
>> 
>> Happens that register before or after driver->probe()?
>
> During probe is a bit too late, but we can handle that as we are used to
> it.  If it happens after probe() succeeds, based on something else being
> asked for in the driver (like the device being opened), then userspace
> has no chance of ever noticing these attributes being added.
>
> But again, this isn't new to your code series, so I wouldn't worry about
> it.  Obviously userspace tools do not care or really notice these
> attributes at all otherwise the authors of them would have complained
> a long time ago :)

I have no idea how these attributes are used at all. Neil should knows
as he added it in the first place.

> So again, no real objection from me here, just meta-comments, except for
> the above thing with the devm_* call to ensure that the
> probe/disconnect/probe sequence will still work just as well as it does
> today.  Should be easy enough to test out by just unloading a module and
> then loading it again with this patch series applied.

That works just fine. Tested that already before posting. After module
removal the directory is gone.

Thanks,

        tglx
