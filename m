Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131C91F4A44
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 02:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgFJAEE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 20:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgFJAED (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 20:04:03 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B3F5206F7;
        Wed, 10 Jun 2020 00:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591747443;
        bh=TgYBh3hFmyr+9S0dXASc57F/8jC83xEDq/nM7svbx5s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Dp0+uMvreY94yy95BJjMnXIuKuk/WslM4u9jyUmvrdKoWkPey1gf5FLb07g9E05fz
         DuxmoZYpnYcGHHV7cM8vw59TlYi0LIB6wrBhlQdcDr4sRV+zjiS23NNMAyHstPIP/H
         e3Y1JGu1/jya/vYUhTDZVRewZe4laq72HIUXB1Hg=
Date:   Tue, 9 Jun 2020 19:04:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatxjain@gmail.com>,
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
Message-ID: <20200610000400.GA1473845@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6E0s-Y207sb-AqSHVB7KmhvDgJQFFaz6ijQ_0OS3Qjisw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 09, 2020 at 04:23:54PM -0700, Rajat Jain wrote:
> Hi Bjorn,
> 
> Thanks for sending out the summary, I was about to send it out but got lazy.
> 
> On Tue, Jun 9, 2020 at 2:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Sun, Jun 07, 2020 at 01:36:32PM +0200, Greg Kroah-Hartman wrote:
> >
> > > Your "problem" I think can be summed up a bit more concise:
> > >       - you don't trust kernel drivers to be "secure" for untrusted
> > >         devices
> > >       - you only want to bind kernel drivers to "internal" devices
> > >         automatically as you "trust" drivers in that situation.
> > >       - you want to only bind specific kernel drivers that you somehow
> > >         feel are "secure" to untrusted devices "outside" of a system
> > >         when those devices are added to the system.
> > >
> > > Is that correct?
> > >
> > > If so, fine, you can do that today with the bind/unbind ability of
> > > drivers, right?  After boot with your "trusted" drivers bound to
> > > "internal" devices, turn off autobind of drivers to devices and then
> > > manually bind them when you see new devices show up, as those "must" be
> > > from external devices (see the bind/unbind files that all drivers export
> > > for how to do this, and old lwn.net articles, this feature has been
> > > around for a very long time.)
> > >
> > > I know for USB you can do this, odds are PCI you can turn off
> > > autobinding as well, as I think this is a per-bus flag somewhere.  If
> > > that's not exported to userspace, should be trivial to do so, should be
> > > somewere in the driver model already...
> > >
> > > Ah, yes, look at the "drivers_autoprobe" and "drivers_probe" files in
> > > sysfs for all busses.  Do those not work for you?
> > >
> > > My other points are the fact that you don't want to put policy in the
> > > kernel, and I think that you can do everything you want in userspace
> > > today, except maybe the fact that trying to determine what is "inside"
> > > and "outside" is not always easy given that most hardware does not
> > > export this information properly, if at all.  Go work with the firmware
> > > people on that issue please, that would be most helpful for everyone
> > > involved to get that finally straightened out.
> >
> > To sketch this out, my understanding of how this would work is:
> >
> >   - Expose the PCI pdev->untrusted bit in sysfs.  We don't expose this
> >     today, but doing so would be trivial.  I think I would prefer a
> >     sysfs name like "external" so it's more descriptive and less of a
> >     judgment.
> 
> Yes. I think we should probably semantically differentiate between
> "external" and "external facing" devices. Root ports and downstream
> ports can be "external facing" but are actually internal devices.
> Anything below an "external facing" device is "external". So the sysfs
> attribute "external" should be set only for devices that are truly
> external.

Good point; we (maybe you? :)) should fix that edge case.

> Just a suggestion: Do you think an enum attribute may be better
> instead, whose values could be "internal" / "external" /
> "external-facing" in case need arises later to distinguish between
> them?

I don't see the need for an enum yet.  Maybe we should add that
if/when we do need it?

> >   - Early userspace code prevents modular drivers from automatically
> >     binding to PCI devices:
> >
> >       echo 0 > /sys/bus/pci/drivers_autoprobe
> 
> Yes.
> I believe this setting will apply it equally to both modular and
> statically linked drivers?

Yes.  The test is in bus_probe_device(), and it does the same for both
modular and statically linked drivers.

But for statically linked drivers, it only prevents them from binding
to *hot-added* devices.  They will claim devices present at boot even
before userspace code can run.

> The one thing that still needs more thought is how about the
> "pcieport" driver that enumerates the PCI bridges. I'm unsure if it
> needs to be whitelisted for further enumeration downstream. What do
> you think?

The pcieport driver is required for AER, PCIe native hotplug, PME,
etc., and it cannot be a module, so the whitelist wouldn't apply to
it.  I assume you need hotplug support, so you would have pcieport
enabled and built in statically.

If you're using ACPI hotplug, that doesn't require pcieport.
