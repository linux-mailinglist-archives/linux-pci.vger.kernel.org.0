Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A506A9D8CD
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 00:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfHZWFG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Aug 2019 18:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfHZWFG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Aug 2019 18:05:06 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03B4721872;
        Mon, 26 Aug 2019 22:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566857104;
        bh=o9Rw/G4Lfm9gr1ZvkCXsO3UOpleaOEFyNAANx3n4jIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EwoA6GUGoGge8EoXje8VLHBikUottJWRNE5TNQ0cvnVjiVPcoe0NXc1AQwEtRmcrw
         RFC//wQ6tKck4pv74SuNFEfaPYy22Xr4p5L1pHnf5zKJeQ1arHPjwEvTp7oz50zjMH
         klr/FXzR4tdMCIIMRTM+GsheNZyp+E2f+xfZBCK4=
Date:   Mon, 26 Aug 2019 17:05:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Andree <matthias.andree@gmx.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Justin Forbes <jmforbes@linuxtx.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add missing link delays required by the PCIe spec
Message-ID: <20190826220502.GD127465@google.com>
References: <20190821124519.71594-1-mika.westerberg@linux.intel.com>
 <20190824021254.GB127465@google.com>
 <20190826101726.GD19908@lahna.fi.intel.com>
 <20190826140712.GC127465@google.com>
 <20190826144242.GA2643@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826144242.GA2643@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 26, 2019 at 05:42:42PM +0300, Mika Westerberg wrote:
> On Mon, Aug 26, 2019 at 09:07:12AM -0500, Bjorn Helgaas wrote:
> > On Mon, Aug 26, 2019 at 01:17:26PM +0300, Mika Westerberg wrote:
> > > On Fri, Aug 23, 2019 at 09:12:54PM -0500, Bjorn Helgaas wrote:

> > > > But the "wait downstream" part seems a little too specific to be at
> > > > the .resume_noirq and .runtime_resume level.
> > > > 
> > > > Do we descend the hierarchy and call .resume_noirq and .runtime_resume
> > > > for the children of the bridge, too?
> > > 
> > > We do but at that time it is too late as we have already resumed pciehp
> > > of the parent downstream port and it may have already started tearing
> > > down the device stack below.
> > > 
> > > I'm open to any better ideas where this delay could be added, though :)
> > 
> > So we resume pciehp *before* we're finished resuming the Downstream
> > Port?  That sounds wrong.
> 
> I mean once we resume the downstream port (the bridge) we also resume
> "PCIe port services" including pciehp and only then descend to whatever
> device is physically connected to that port.

That order sounds right.  I guess I'd have to see more details about
what's happening with pciehp to understand this.  Do you happen to
have a trace (dmesg, backtrace, etc) of pciehp tearing things down?

> > > > > +static int pcie_get_downstream_delay(struct pci_bus *bus)
> > > > > +{
> > > > > +	struct pci_dev *pdev;
> > > > > +	int min_delay = 100;
> > > > > +	int max_delay = 0;
> > > > > +
> > > > > +	list_for_each_entry(pdev, &bus->devices, bus_list) {
> > > > > +		if (pdev->imm_ready)
> > > > > +			min_delay = 0;
> > > > > +		else if (pdev->d3cold_delay < min_delay)
> > > > > +			min_delay = pdev->d3cold_delay;
> > > > > +		if (pdev->d3cold_delay > max_delay)
> > > > > +			max_delay = pdev->d3cold_delay;
> > > > > +	}
> > > > > +
> > > > > +	return max(min_delay, max_delay);
> > > > > +}
> > 
> > > > > + */
> > > > > +void pcie_wait_downstream_accessible(struct pci_dev *pdev)
> > 
> > > > Do we need to observe the Trhfa requirements for Conventional PCI and
> > > > PCI-X devices here?  If we don't do it here, where is it observed?
> > > 
> > > We probably should but I intended this to be PCIe specific since there
> > > we have issues. For conventional PCI/PCI-X things "seem" to work and we
> > > don't power manage those bridges anyway.
> > > 
> > > I'm not aware if Trhfa is handled in anywhere in the PCI stack
> > > currently.
> > 
> > I think we should make this agnostic of the Conventional/PCIe
> > difference if possible.  I assume we can tell if we're dealing with a
> > D3->D0 transition and we only add delays in that case.  If we don't
> > power manage Conventional PCI devices, I assume we won't see D3->D0
> > transitions for runtime resume so there won't be any harm.
> >
> > Making it PCIe-specific seems like it adds extra code ("dev-is-PCIe
> > checks") with no obvious reason for existence and an implicit
> > dependency on the fact that we only power manage PCIe devices.  If we
> > ever *did* support runtime power-management for Conventional PCI, we'd
> > trip over that implicit dependency and probably debug this issue
> > again.
> > 
> > But I guess it might slow down system resume for Conventional PCI
> > devices.  If we rely on delays in firmware, I wonder if there's
> > any point during resume where we could grab an early timestamp, then
> > take another timestamp here and deduce that we've already delayed the
> > difference?
> 
> That sounds rather complex, to be honest ;-)

Maybe so, I was just trying to brainstorm possibilities for making
sure we observe the delay requirements without slowing down resume.

For example, if we have several devices on the same bus, we shouldn't
have to do the delays serially; we should be able to take advantage of
the fact that the Trhfa period starts at the same time for all of
them.

> > > > > +	delay = pcie_get_downstream_delay(bus);
> > > > > +	if (!delay)
> > > > > +		return;
> > > > 
> > > > I'm not sold on the idea that this delay depends on what's *below* the
> > > > bridge.  We're using sec 6.6.1 to justify the delay, and that section
> > > > doesn't say anything about downstream devices.
> > > 
> > > 6.6.1 indeed talks about Downstream Ports and devices immediately below
> > > them.
> > 
> > Wait, I don't think we're reading this the same way.  6.6.1 mentions
> > Downstream Ports: "With a Downstream Port that does not support Link
> > speeds greater than 5.0 GT/s, software must wait a minimum of 100 ms
> > before sending a Configuration Request to the device immediately below
> > that Port."
> > 
> > This says we have to delay before sending a config request to a device
> > below a Downstream Port, but it doesn't say anything about the
> > characteristics of that device.  In particular, I don't think it says
> > the delay can be shortened if that device supports Immediate Readiness
> > or implements a readiness _DSM.
> 
> Well it says this:
> 
>   To allow components to perform internal initialization, system software
>   must wait a specified minimum period following the end of a Conventional
>   Reset of one or more devices before it is permitted to issue
>   Configuration Requests to those devices, unless Readiness Notifications
>   mechanisms are used
> 
> My understanding of the above (might be wrong) is that Readiness
> Notification can shorten the delay.

Yeeesss, but if we're talking about transitioning device X from
D3->D0, I think this is talking about config requests to device X,
not to something downstream from X.

And we have no support for Readiness Notifications, although maybe the
_DSM stuff qualifies as "a mechanism that supersedes FRS and/or DRS"
(as mentioned in 6.23).

If device X was in D3cold, don't we have to assume that devices
downstream from X may have been added/removed while X was in D3cold?

> > I don't think this delay has anything to do with devices downstream
> > from the Port.  I think this is about giving the Downstream Port time
> > to bring up the link.  That way config requests may fail because
> > there's no device below the Port or it's not ready yet, but they
> > shouldn't fail simply because the link isn't up yet.
> 
> My understanding (again might be wrong) is that there are two factors
> here. One is to get the link trained and the other is to give the
> downstream device some time to perform its internal initialization so
> that it is ready to answer config requests.

Yeah, maybe you're right.  The second item about waiting 100ms after
Link training completes (for Ports that support speeds greater than
5.0 GT/s) does suggest that the delay is related to the downstream
device, since the Link is already up before the 100ms delay.

Bjorn
