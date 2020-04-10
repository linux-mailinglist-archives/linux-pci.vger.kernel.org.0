Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 485041A4C1A
	for <lists+linux-pci@lfdr.de>; Sat, 11 Apr 2020 00:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDJWbC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 18:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgDJWbB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Apr 2020 18:31:01 -0400
Received: from localhost (mobile-166-170-220-109.mycingular.net [166.170.220.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A60BA207FF;
        Fri, 10 Apr 2020 22:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586557861;
        bh=WKCPMyZXyRYjTjboILM55FNirG1PFaP3Ss/VnsTBfQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qBEc+7+O1wMkH/6ypssUxab8P2wygTjaQTHKGyjIrKIbjjqi3/CzoMgKk7rBrlr2a
         9+0liEXt3w1Z2/B/+9ywGPovBmGJ4BOAnGt0xG5oMng2iNQH6O+2HYmD1HeUpl7W4/
         ivNhAKFQf0U2lhBVnLnA1veNBR9iHphBNKVrsoGM=
Date:   Fri, 10 Apr 2020 17:30:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 10/10] PCI / ACPI: Whitelist D3 for more PCIe hotplug
 ports
Message-ID: <20200410223058.GA18278@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409065411.GH2567@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[breadcrumbs for the archives: this thread is about
26ad34d510a8 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports"),
https://git.kernel.org/linus/26ad34d510a8]

On Thu, Apr 09, 2020 at 09:54:11AM +0300, Mika Westerberg wrote:
> On Wed, Apr 08, 2020 at 03:12:08PM -0500, Bjorn Helgaas wrote:
> > On Wed, Apr 08, 2020 at 09:04:09AM +0300, Mika Westerberg wrote:
> > > On Tue, Apr 07, 2020 at 06:54:23PM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Sep 13, 2018 at 05:33:22PM +0300, Mika Westerberg wrote:
> > > > > In order to have better power management for Thunderbolt PCIe chains,
> > > > > Windows enables power management for native PCIe hotplug ports if there
> > > > > is following ACPI _DSD attached to the root port:
> > > > > 
> > > > >   Name (_DSD, Package () {
> > > > >       ToUUID ("6211e2c0-58a3-4af3-90e1-927a4e0c55a4"),
> > > > >       Package () {
> > > > >           Package () {"HotPlugSupportInD3", 1}
> > > > >       }
> > > > >   })
> > > > > 
> > > > > This is also documented in:
> > > > > 
> > > > >   https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
> > > > 
> > > > This doc basically says that if the platform supplies this _DSD, the
> > > > root port is "capable of handling hot plug events while in D3 state".
> > > > 
> > > > What does that mean?  That statement is not really actionable.  I
> > > > *assume* it's telling us about some specific hardware or firmware
> > > > functionality, like maybe we'll get a notification for hotplug events
> > > > when the device is in D3?  D3hot?  D3cold?  What is the notification?
> > > > Is it immediate or when the device comes back to D0?  How do we
> > > > control and field the notification?
> > > 
> > > I think it simply gives the OS a hint that it can put PCIe hotplug
> > > capable port into D3 and expect it to wake up when device is detected.
> > 
> > I'd really like more specific details than this.  PCI power management
> > is explicitly controlled by software, so I don't know what it means
> > for a bridge to "wake up when device is detected."
> 
> Note these are for PCIe which is not the same as the parallel PCI.

Sure, but the PCI power management framework doesn't need to know
about PCI/PCIe differences.

> What I mean here is that there is some sort of wake depending whether
> the link is in L1 or L2/L3 and then resulting the link to go to L0 and
> PME message being send over to the root complex.

This is compatible with conventional PCI behavior.  PME_Support in the
PM Capability tells us whether the device can generate a PME from D0,
D1, D2, D3hot, or D3cold.  AFAIK, this applies to both conventional
PCI and PCIe, so I think this _DSD must be telling us something more
than just "this PCIe device can assert PME from D3hot and D3cold."

PME_Support tells us whether the device can generate PMEs from D3cold,
but of course it doesn't say anything about whether hotplug events
cause those PMEs.

PCIe r5.0, sec 6.7.3.4, says ports must support PMEs for hotplug
events while the device is in D1, D2, or D3hot.  It clearly leaves out
D3cold.

So maybe this _DSD tells us that this device can generate *hotplug*
event PMEs from D3cold?

> > Normally Linux would get some kind of notification like a PME, then
> > execute an ACPI method and/or write PCI_PM_CTRL to put the device back
> > in D0.
> 
> Right.
> 
> > Are we talking about D3hot or D3cold?
> 
> My interpretation is that both (D3 implies both D3hot and D3cold) but I
> did not write that spec.
> 
> Systems where this is used typically go down to D3cold with the PCIe
> topology (links are in L2).
> 
> > The PCI PM capability already has a way to advertise that it can
> > generate PME from D3cold.  How is this different from that?
> 
> Well you always need some platform (ACPI) help in order to even to
> D3cold. This applies to waking up as well. The PCIe device may advertise
> that it supports this but I don't think it can be sure that the system
> it is connected to has this plumbing.

Yes, transitions to/from D3cold require platform support.  But those
transitions are done by ACPI methods, so any plumbing is ACPI's
problem, and I don't think this _DSD helps the OS with that.

> For PCIe hotplug ports there have been issues that have prevented doing
> power management for those. The _DSD is there to provide a hint to the
> OS saying that yeah, this port actually is expected to work even if it
> goes into D3 (cold/hot).

That doesn't really help fix bugs in this area or help with future
refactoring, because it's not specific about what the issues were or
what the _DSD means.

I think the combination of PCIe r5.0 7.5.2.1 (PME_Support from D0, D1,
D2, D3hot, D3cold) and 6.7.3.4 (hotplug PME events from D1, D2,
D3hot) covers everything except hotplug PME events from D3cold.

So my guess is that this _DSD is a way to tell the OS that this device
generates PMEs for hotplug events even when the device is in D3cold.
Does that make any sense?

> > Is this _DSD something that *could* be advertised via PCI config
> > space, i.e., is it completely determined by the Root Port?  Or is it
> > something that requires ACPI support, so it cannot be done directly by
> > the hardware device?
> 
> You always need help from platform (ACPI) to get into D3cold.
> 
> > These are all things we need to know in order to make power management
> > reliable.

> > > > > +static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
> > > > > +{
> > > > > +	return pci_platform_pm ? pci_platform_pm->bridge_d3(dev) : false;
> > > > 
> > > > This patch added a .bridge_d3() implementation for ACPI but
> > > > not for MID.  What prevents us from calling
> > > > platform_pci_bridge_d3() on a MID platform and trying to call
> > > > through a NULL pointer?
> > > > 
> > > > Shouldn't we do something like the patch attached below?
> > > 
> > > IIRC MID devices in general don't have PCIe ports (so we never
> > > enable PM for them). Is this a real problem that crashes peoples
> > > kernels on MID systems? Then yes I think the patch makes sense
> > > to have.
> > > 
> > > I also remember testing some other stuff on one MID system
> > > (Edison) quite recently and did not see any issues.
> > 
> > I have not seen reports of crashes, but I do think this is a real
> > problem.  The problem is that the code as-is relies on assumptions
> > ("MID does not have PCI and never will") that are implicit and
> > impossible to verify, which is a maintenance problem.
> 
> Well, there won't be any new MID devices and the only one we support
> partially is Edison and it does not have a single PCIe port that
> could even be power managed.

The problem I'm trying to solve is making this code understandable.
It doesn't help to assert that "there are no devices that exercise
this path" because one cannot figure that out by looking at the code.

> > > BTW, this patch was merged over a year ago so I'm not sure why you comment
> > > it now. Or you want me to add incremental changes to it?
> > 
> > I was reviewing [1], which updates pci_find_pcie_root_port(), which is
> > used by acpi_pci_bridge_d3().  I noticed a potential NULL pointer
> > dereference, which was a distraction.
> > 
> > Unless you object, I'll merge something like the patch below to
> > prevent that distraction for others.
> 
> No objections :)
> 
> However, in order to make this more maintainable, what if we check in
> the platform_pci_bridge_d3() itself whether the pointer is NULL and
> return false? That would work for any future platforms and avoid adding
> the dummy implementation each time.

That's a much better idea, thank you!  I'll cc you when I revise the
patch.

Bjorn
