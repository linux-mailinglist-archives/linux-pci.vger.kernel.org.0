Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4C441E783
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 08:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352169AbhJAGb0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 02:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352084AbhJAGbX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 02:31:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD0D561A57;
        Fri,  1 Oct 2021 06:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633069779;
        bh=rcW5f2yBLwBChRyM5RHpwItzXk3vSZPn4evKCamc1c0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OkPICDQRY+xltvJ7ddDOZG9kEPCfLum70sOPEt/Lf/OtCN1j2XdfJYl0kuBOqscLw
         PujostpRqxD/hbx2g0swIybjvlpLeo8SaUjnLXSRTOjQnHiUaGpljPKzyDUTfgD78c
         BZXNayCKOYFzqCEcOExF+bZMAM7SOXAsPOzEHHB0=
Date:   Fri, 1 Oct 2021 08:29:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <YVaq0Hm8WHVY46xX@kroah.com>
References: <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930103537-mutt-send-email-mst@kernel.org>
 <YVXOc3IbcHsVXUxr@kroah.com>
 <20210930105852-mutt-send-email-mst@kernel.org>
 <YVXWIVZupeAzT6bO@kroah.com>
 <f4b5a269-843f-6911-24fe-ebffb2bd4f9e@linux.intel.com>
 <YVXyqBGa5Ix5MzmD@kroah.com>
 <bb27af8d-d4ba-fa70-8893-5b9939f9280a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb27af8d-d4ba-fa70-8893-5b9939f9280a@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 12:15:16PM -0700, Andi Kleen wrote:
> 
> On 9/30/2021 10:23 AM, Greg Kroah-Hartman wrote:
> > On Thu, Sep 30, 2021 at 10:17:09AM -0700, Andi Kleen wrote:
> > > The legacy drivers could be fixed, but nobody really wants to touch them
> > > anymore and they're impossible to test.
> > Pointers to them?
> 
> For example if you look over old SCSI drivers in drivers/scsi/*.c there is a
> substantial number that has a module init longer than just registering a
> driver. As a single example look at drivers/scsi/BusLogic.c

Great, send patches to fix them up instead of adding new infrastructure
to the kernel.  It is better to remove code than add it.  You can rip
the ISA code out of that driver and then you will not have the issue
anymore.

Or again, just add that module to the deny list and never load it from
userspace.

> There were also quite a few platform drivers like this.

Of course, platform drivers are horrible abusers of this.  Just like the
recent one submitted by Intel that would bind to any machine it was
loaded on and did not actually do any hardware detection assuming that
it owned the platform:
	https://lore.kernel.org/r/20210924213157.3584061-2-david.e.box@linux.intel.com

So yes, some drivers are horrible, it is our job to catch that and fix
it.  If you don't want to load those drivers on your system, we have
userspace solutions for that (you can have allow/deny lists there.)

> > > The drivers that probe something that is not enumerated in a standard way
> > > have no choice, it cannot be implemented in a different way.
> > PCI devices are not enumerated in a standard way???
> 
> The pci devices are enumerated in a standard way, but typically the driver
> also needs something else outside PCI that needs some other probing
> mechanism.

Like what?  What PCI drivers need outside connections to control the
hardware?

> > > So instead we're using a "firewall" the prevents these drivers from doing
> > > bad things by not allowing ioremap access unless opted in, and also do some
> > > filtering on the IO ports The device filter is still the primary mechanism,
> > > the ioremap filtering is just belts and suspenders for those odd cases.
> > That's horrible, don't try to protect the kernel from itself.  Just fix
> > the drivers.
> 
> I thought we had already established this last time we discussed it.
> 
> That's completely impractical. We cannot harden thousands of drivers,
> especially since it would be all wasted work since nobody will ever need
> them in virtual guests. Even if we could harden them how would such a work
> be maintained long term? Using a firewall and filtering mechanism is much
> saner for everyone.

I agree, you can not "harden" anything here.  That is why I asked you to
use the existing process that explicitly moves the model to userspace
where a user can say "do I want this device to be controlled by the
kernel or not" which then allows you to pick and choose what drivers you
want to have in your system.

You need to trust devices, and not worry about trusting drivers as you
yourself admit :)

The kernel's trust model is that once we bind to them, we trust almost
all device types almost explicitly.  If you wish to change that model,
that's great, but it is a much larger discussion than this tiny patchset
would require.

thanks,

greg k-h
