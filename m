Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C936B1F5E99
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jun 2020 01:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgFJXJJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 19:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgFJXJJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jun 2020 19:09:09 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4A6D206F4;
        Wed, 10 Jun 2020 23:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591830548;
        bh=+sWKmm6Ubk1LJNZpWMm14cIgTz4h4XbbXmrO3hLuzYw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SQ2H2eIQscz9nAiLjkEqKDjh+saVGgqTTmuzkaH0WpkwjmxrCjXB7OC5O6BQupEk3
         HLVy3MhU9dASdYYEXP3lF9sU9wgW8iYyaw9VeiKTTlf21ZewJVoIw69QNqZIKQSeth
         VZ1GwbUab8ix7DT9c193tURqCdWCwbPxGHTF54+E=
Date:   Wed, 10 Jun 2020 18:09:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatxjain@gmail.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20200610230906.GA1528594@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA93t1pFqsi2a-LGP7+eHpCmSvzoDfWEe7KSeFx6wt2caeFA1A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 10, 2020 at 01:17:54PM -0700, Rajat Jain wrote:
> On Tue, Jun 9, 2020 at 5:30 PM Rajat Jain <rajatja@google.com> wrote:
> >
> > On Tue, Jun 9, 2020 at 5:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Tue, Jun 09, 2020 at 04:23:54PM -0700, Rajat Jain wrote:
> > > > Hi Bjorn,
> > > >
> > > > Thanks for sending out the summary, I was about to send it out but got lazy.
> > > >
> > > > On Tue, Jun 9, 2020 at 2:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > >
> > > > > On Sun, Jun 07, 2020 at 01:36:32PM +0200, Greg Kroah-Hartman wrote:
> > > > >
> > > > > > Your "problem" I think can be summed up a bit more concise:
> > > > > >       - you don't trust kernel drivers to be "secure" for untrusted
> > > > > >         devices
> > > > > >       - you only want to bind kernel drivers to "internal" devices
> > > > > >         automatically as you "trust" drivers in that situation.
> > > > > >       - you want to only bind specific kernel drivers that you somehow
> > > > > >         feel are "secure" to untrusted devices "outside" of a system
> > > > > >         when those devices are added to the system.
> > > > > >
> > > > > > Is that correct?
> > > > > >
> > > > > > If so, fine, you can do that today with the bind/unbind ability of
> > > > > > drivers, right?  After boot with your "trusted" drivers bound to
> > > > > > "internal" devices, turn off autobind of drivers to devices and then
> > > > > > manually bind them when you see new devices show up, as those "must" be
> > > > > > from external devices (see the bind/unbind files that all drivers export
> > > > > > for how to do this, and old lwn.net articles, this feature has been
> > > > > > around for a very long time.)
> > > > > >
> > > > > > I know for USB you can do this, odds are PCI you can turn off
> > > > > > autobinding as well, as I think this is a per-bus flag somewhere.  If
> > > > > > that's not exported to userspace, should be trivial to do so, should be
> > > > > > somewere in the driver model already...
> > > > > >
> > > > > > Ah, yes, look at the "drivers_autoprobe" and "drivers_probe" files in
> > > > > > sysfs for all busses.  Do those not work for you?
> > > > > >
> > > > > > My other points are the fact that you don't want to put policy in the
> > > > > > kernel, and I think that you can do everything you want in userspace
> > > > > > today, except maybe the fact that trying to determine what is "inside"
> > > > > > and "outside" is not always easy given that most hardware does not
> > > > > > export this information properly, if at all.  Go work with the firmware
> > > > > > people on that issue please, that would be most helpful for everyone
> > > > > > involved to get that finally straightened out.
> > > > >
> > > > > To sketch this out, my understanding of how this would work is:
> > > > >
> > > > >   - Expose the PCI pdev->untrusted bit in sysfs.  We don't expose this
> > > > >     today, but doing so would be trivial.  I think I would prefer a
> > > > >     sysfs name like "external" so it's more descriptive and less of a
> > > > >     judgment.
> > > >
> > > > Yes. I think we should probably semantically differentiate between
> > > > "external" and "external facing" devices. Root ports and downstream
> > > > ports can be "external facing" but are actually internal devices.
> > > > Anything below an "external facing" device is "external". So the sysfs
> > > > attribute "external" should be set only for devices that are truly
> > > > external.
> > >
> > > Good point; we (maybe you? :)) should fix that edge case.
> >
> 
> I realized that we may not need to distinguish between internal and
> external devices if we can assume that no internal PCI devices will
> show up after boot. That assumption is 99% true for our use case
> (leaving 1% out because we have some corner cases i.e. PCIe rescans,
> module insertions etc that may probably make some internal devices
> disappear and reappear).  If I find that I can do without the need for
> a UAPI to distinguish internal vs external devices, do you still want
> me to fix this edge case (i.e. "break" the pdev->untrusted flag into
> "external_facing" and "external" devices)?

I'm not sure there's a need to explicitly identify the
"external-facing" devices at all.  AFAIK there's nothing today that
would do anything different with a root port that happens to have an
external connector.

The "untrusted" uses today are things like forcing use of an IOMMU.
Most root ports don't initiate DMA themselves, but even if they did,
there's no reason to treat DMA from the root port differently than DMA
from other internal devices.  What we want is to treat DMA from
devices *connected* to that external connector differently.

So yes, I think we should change the current behavior so we only set
the dev->untrusted flag for devices *downstream* from an
external-facing device, but not the external-facing device itself.
