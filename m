Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6788E79DD
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 21:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfJ1UQ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 16:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfJ1UQ5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Oct 2019 16:16:57 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79FAA20578;
        Mon, 28 Oct 2019 20:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572293815;
        bh=0R2EuqJT9woI8LfpF+/9pnB80dGqfib5Z73A6keWxPU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=wFn6V8hhfyKUMK2sTFE1mP6Oa1mjRCJSJE4dv+wQcZmAaJ4BzwL6WHcIEgK4brAsf
         2bVolqpfxW1WBSUCWOw1Z/8EDCLXpHIKyksNFgTTfMvKa37xoYsDAi2iwkr6jAA/QG
         a655a+0xe54fo+JugxaysornLu698Q2udg4MgmzA=
Date:   Mon, 28 Oct 2019 15:16:53 -0500
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
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Add missing link delays required by the PCIe
 spec
Message-ID: <20191028201653.GA124445@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028180601.GA2593@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 28, 2019 at 08:06:01PM +0200, Mika Westerberg wrote:
> On Mon, Oct 28, 2019 at 08:42:47AM -0500, Bjorn Helgaas wrote:
> > On Mon, Oct 28, 2019 at 01:28:52PM +0200, Mika Westerberg wrote:
> > > On Sat, Oct 26, 2019 at 09:19:38AM -0500, Bjorn Helgaas wrote:
> > > > On Fri, Oct 04, 2019 at 03:39:47PM +0300, Mika Westerberg wrote:
> > > > > Currently Linux does not follow PCIe spec regarding the required delays
> > > > > after reset. A concrete example is a Thunderbolt add-in-card that
> > > > > consists of a PCIe switch and two PCIe endpoints:
> > > > > 
> > > > >   +-1b.0-[01-6b]----00.0-[02-6b]--+-00.0-[03]----00.0 TBT controller
> > > > >                                   +-01.0-[04-36]-- DS hotplug port
> > > > >                                   +-02.0-[37]----00.0 xHCI controller
> > > > >                                   \-04.0-[38-6b]-- DS hotplug port
> > > > > 
> > > > > The root port (1b.0) and the PCIe switch downstream ports are all PCIe
> > > > > gen3 so they support 8GT/s link speeds.
> > > > > 
> > > > > We wait for the PCIe hierarchy to enter D3cold (runtime):
> > > > > 
> > > > >   pcieport 0000:00:1b.0: power state changed by ACPI to D3cold
> > > > > 
> > > > > When it wakes up from D3cold, according to the PCIe 4.0 section 5.8 the
> > > > > PCIe switch is put to reset and its power is re-applied. This means that
> > > > > we must follow the rules in PCIe 4.0 section 6.6.1.
> > > > 
> > > > If you have the PCIe 5.0 spec, can you update these references to
> > > > that?  If not, I'm happy to do it for you.
> > > 
> > > I do have it and sure, I'll update them.
> > > 
> > > > > For the PCIe gen3 ports we are dealing with here, the following applies:
> > > > > 
> > > > >   With a Downstream Port that supports Link speeds greater than 5.0
> > > > >   GT/s, software must wait a minimum of 100 ms after Link training
> > > > >   completes before sending a Configuration Request to the device
> > > > >   immediately below that Port. Software can determine when Link training
> > > > >   completes by polling the Data Link Layer Link Active bit or by setting
> > > > >   up an associated interrupt (see Section 6.7.3.3).
> > > > > 
> > > > > Translating this into the above topology we would need to do this (DLLLA
> > > > > stands for Data Link Layer Link Active):
> > > > > 
> > > > >   0000:00:1b.0: wait for 100 ms after DLLLA is set before access to 0000:01:00.0
> > > > >   0000:02:00.0: wait for 100 ms after DLLLA is set before access to 0000:03:00.0
> > > > >   0000:02:02.0: wait for 100 ms after DLLLA is set before access to 0000:37:00.0
> > > > > 
> > > > > I've instrumented the kernel with some additional logging so we can see
> > > > > the actual delays performed:
> > > > > 
> > > > >   pcieport 0000:00:1b.0: power state changed by ACPI to D0
> > > > >   pcieport 0000:00:1b.0: waiting for D3cold delay of 100 ms
> > > > >   pcieport 0000:00:1b.0: waiting for D3hot delay of 10 ms
> > > > >   pcieport 0000:02:01.0: waiting for D3hot delay of 10 ms
> > > > >   pcieport 0000:02:04.0: waiting for D3hot delay of 10 ms
> > > > > 
> > > > > For the switch upstream port (01:00.0 reachable through 00:1b.0 root
> > > > > port) we wait for 100 ms but not taking into account the DLLLA
> > > > > requirement. We then wait 10 ms for D3hot -> D0 transition of the root
> > > > > port and the two downstream hotplug ports. This means that we deviate
> > > > > from what the spec requires.
> > > > > 
> > > > > Performing the same check for system sleep (s2idle) transitions it turns
> > > > > out to be even worse. None of the mandatory delays are performed. If
> > > > > this would be S3 instead of s2idle then according to PCI FW spec 3.2
> > > > > section 4.6.8. there is a specific _DSM that allows the OS to skip the
> > > > > delays but this platform does not provide the _DSM and does not go to S3
> > > > > anyway so no firmware is involved that could already handle these
> > > > > delays.
> > > > > 
> > > > > On this particular platform these delays are not actually needed because
> > > > > there is an additional delay as part of the ACPI power resource that is
> > > > > used to turn on power to the hierarchy but since that additional delay
> > > > > is not required by any of standards (PCIe, ACPI) it is not present in
> > > > > the Intel Ice Lake, for example where missing the mandatory delays
> > > > > causes pciehp to start tearing down the stack too early (links are not
> > > > > yet trained). Below is an example how it looks like when this happens:
> > > > > 
> > > > >   pcieport 0000:83:04.0: pciehp: Slot(4): Card not present
> > > > >   pcieport 0000:87:04.0: PME# disabled
> > > > >   pcieport 0000:83:04.0: pciehp: pciehp_unconfigure_device: domain:bus:dev = 0000:86:00
> > > > >   pcieport 0000:86:00.0: Refused to change power state, currently in D3
> > > > >   pcieport 0000:86:00.0: restoring config space at offset 0x3c (was 0xffffffff, writing 0x201ff)
> > > > >   pcieport 0000:86:00.0: restoring config space at offset 0x38 (was 0xffffffff, writing 0x0)
> > > > >   ...
> > > > > 
> > > > > There is also one reported case (see the bugzilla link below) where the
> > > > > missing delay causes xHCI on a Titan Ridge controller fail to runtime
> > > > > resume when USB-C dock is plugged. This does not involve pciehp but
> > > > > instead it PCI core fails to runtime resume the xHCI device:
> > > > > 
> > > > >   pcieport 0000:04:02.0: restoring config space at offset 0xc (was 0x10000, writing 0x10020)
> > > > >   pcieport 0000:04:02.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100406)
> > > > >   xhci_hcd 0000:39:00.0: Refused to change power state, currently in D3
> > > > >   xhci_hcd 0000:39:00.0: restoring config space at offset 0x3c (was 0xffffffff, writing 0x1ff)
> > > > >   xhci_hcd 0000:39:00.0: restoring config space at offset 0x38 (was 0xffffffff, writing 0x0)
> > > > >   ...
> > > > > 
> > > > > For this reason, introduce a new function pci_bridge_wait_for_secondary_bus()
> > > > > that is called on PCI core resume and runtime resume paths accordingly
> > > > > if the bridge entered D3cold (and thus went through reset).
> > > > > 
> > > > > This is second attempt to add the missing delays. The previous solution
> > > > > in commit c2bf1fc212f7 ("PCI: Add missing link delays required by the
> > > > > PCIe spec") was reverted because of two issues it caused:
> > > > > 
> > > > >   1. One system become unresponsive after S3 resume due to PME service
> > > > >      spinning in pcie_pme_work_fn(). The root port in question reports
> > > > >      that the xHCI sent PME but the xHCI device itself does not have PME
> > > > >      status set. The PME status bit is never cleared in the root port
> > > > >      resulting the indefinite loop in pcie_pme_work_fn().
> > > > > 
> > > > >   2. Slows down resume if the root/downstream port does not support
> > > > >      Data Link Layer Active Reporting because pcie_wait_for_link_delay()
> > > > >      waits 1100 ms in that case.
> > > > > 
> > > > > This version should avoid the above issues because we restrict the delay
> > > > > to happen only if the port went into D3cold.
> > > > > 
> > > > > Link: https://lore.kernel.org/linux-pci/SL2P216MB01878BBCD75F21D882AEEA2880C60@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM/
> > > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=203885
> > > > > Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > > Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > ---
> > > > >  drivers/pci/pci-driver.c | 18 ++++++++
> > > > >  drivers/pci/pci.c        | 92 +++++++++++++++++++++++++++++++++++++---
> > > > >  drivers/pci/pci.h        |  1 +
> > > > >  3 files changed, 104 insertions(+), 7 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > > > index a8124e47bf6e..74a144c9cf4e 100644
> > > > > --- a/drivers/pci/pci-driver.c
> > > > > +++ b/drivers/pci/pci-driver.c
> > > > > @@ -917,6 +917,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
> > > > >  static int pci_pm_resume_noirq(struct device *dev)
> > > > >  {
> > > > >  	struct pci_dev *pci_dev = to_pci_dev(dev);
> > > > > +	bool d3cold = pci_dev->current_state == PCI_D3cold;
> > > > >  	struct device_driver *drv = dev->driver;
> > > > >  	int error = 0;
> > > > >  
> > > > > @@ -947,6 +948,14 @@ static int pci_pm_resume_noirq(struct device *dev)
> > > > >  
> > > > >  	pcie_pme_root_status_cleanup(pci_dev);
> > > > >  
> > > > > +	/*
> > > > > +	 * If the hierarchy went into D3cold wait for the secondary bus to
> > > > > +	 * become accessible. This is important for PCIe to prevent pciehp
> > > > > +	 * from tearing down the downstream devices too soon.
> > 
> > > > Can we move this closer to where we initiate the reset?  It's pretty
> > > > hard to tell from looking at pci_pm_resume_noirq() that there's a
> > > > reset happening here.
> > > 
> > > Well we actually don't do explicit reset but instead we power the thing
> > > on from D3cold.
> > 
> > The point is that it's too hard to maintain unless we can connect the
> > delay with the related hardware event.
> 
> The related hardware event is resume in this case. Can you point me to
> the actual point where you want me to put this?

"Resume" is a Linux software concept, so of course the PCIe spec
doesn't say anything about it.  The spec talks about delays related to
resets and device power and link state transitions, so somehow we have
to connect the Linux delay with those hardware events.

Since we're talking about a transition from D3cold, this has to be
done via something external to the device such as power regulators.
For ACPI systems that's probably hidden inside _PS0 or something
similar.  That's opaque, but at least it's a hook that says "here's
where we put the device into D0".  I suggested
acpi_pci_set_power_state() as a possibility since I think that's the
lowest-level point where we have the pci_dev so we know the current
state and the new state.

> > > > For D3cold->D0, I guess that would be somewhere down in
> > > > platform_pci_set_power_state()?  Maybe acpi_pci_set_power_state()?
> > > > What about the mid_pci_set_power_state() path?  Does that need this
> > > > too?
> > > 
> > > I can take a look if it can be placed there. Yes,
> > > mid_pci_set_power_state() may at least in theory need it too although I
> > > don't remember any MID platforms with real PCIe devices.
> > 
> > I don't know how the OS is supposed to know if these are real PCIe
> > devices or not.  If we don't know, we have to assume they work per
> > spec and may require the delays per spec.
> 
> Well MID devices are pretty much "hard-coded" the OS knows everything
> there is connected.

MID seems to be magic in that it wants to use the normal PCI core
without having to abide by all the assumptions in the spec.  That's
OK, but MID needs to be explicit about when it is OK to violate those
assumptions.  In this case, I think it means that if we add the delay
to acpi_pci_set_power_state(), we should at least add a comment to
mid_pci_set_power_state() about why the delay is or is not required
for MID.

> > > > In the ACPI spec, _PS0 doesn't say anything about delays.  _ON (which
> > > > I assume is not for PCI devices themselves) *does* say firmware is
> > > > responsible for sequencing delays, so I would tend to assume it's
> > > > really firmware's job and we shouldn't need to do this in the kernel
> > > > at all.
> > > 
> > > _ON is also for PCI device itself but all those methods are not just for
> > > PCI so they don't really talk about any PCI specific delays. You need to
> > > look at other specs. For example PCI FW spec v3.2 section 4.6.9 says
> > > this about the _DSM that can be used to decrease the delays:
> > > 
> > >   This function is optional. If the platform does not provide it, the
> > >   operating system must adhere to all timing requirements as described
> > >   in the PCI Express Base specification and/or applicable form factor
> > >   specification, including values contained in Readiness Time Reporting
> > >   capability structure.
> > 
> > I don't think this _DSM tells us anything about delays after _ON,
> > _PS0, etc.  All the delays it mentions are for transitions the OS can
> > do natively without the _ON, _PS0, etc methods.  It makes no mention
> > of those methods, or of the D3cold->D0 transition (which would require
> > them).
> 
> D3cold->D0 transition is explained in PCI spec 5.0 page 492 (there is
> picture). You can see that D3cold -> D0 involves fundamental reset.
> Section 6.6.1 (page 551) then says that fundamental reset is one
> category of conventional reset. Now, that _DSM allows lowering the init
> time after conventional reset. So to me it talks exactly about those
> delays (also PCIe cannot go into D3cold without help from the platform,
> ACPI in this case).

Everything on the _DSM list is something the OS can do natively (even
conventional reset can be done via Secondary Bus Reset), and it says
nothing about a connection with ACPI power management methods (_PS0,
etc), so I think it's ambiguous at best.  A simple "OS is responsible
for any bus-specific delays after a transition" in the ACPI _PS0
documentation would have trivially resolved this.

But it seems that at least some ACPI firmware doesn't do those delays,
so I guess our only alternatives are to always do it in the OS or have
some sort of blacklist.  And it doesn't really seem practical to
maintain a blacklist.

> > > Relevant PCIe spec section is 6.6.1 (also referenced in the changelog).
> > > 
> > > [If you have access to ECN titled "Async Hot-Plug Updates" (you can find
> > > it in PCI-SIG site) that document has a nice table about the delays in
> > > page 32. It compares surprise hotplug with downstream port containment
> > > for async hotplug]
> > 
> > Thanks for the pointer, that ECN looks very useful.  It does talk
> > about delays in general, but I don't see anything that clarifies
> > whether ACPI methods or the OS is responsible for them.
> 
> No but the _DSM description above is pretty clear about that. At least
> for me it is clear.
> 
> > > > What about D3hot->D0?  When a bridge (Root Port or Switch Downstream
> > > > Port) is in D3hot, I'm not really clear on the state of its link.  If
> > > > the link is down, I assume putting the bridge in D0 will bring it up
> > > > and we'd have to wait for that?  If so, we'd need to do something in
> > > > the reset path, e.g., pci_pm_reset()?
> > > 
> > > AFAIK the link goes into L1 when the function is programmed to any other
> > > D state than D0. 
> > 
> > Yes, and the "function" here is the one on the *downstream* end, e.g.,
> > the Endpoint or Switch Upstream Port.  When the upstream bridge (Root
> > Port or Switch Downstream Port) is in a non-D0 state, the downstream
> > component is unreachable (memory, I/O, and type 1 config requests are
> > terminated by the bridge as unsupported requests).
> 
> Yes, the link is in L1 (its PM state is determined by the D-state of the
> downstream component. From there you can get it back to functional state
> by programming the downstream port to D0 (the link is still in L1)
> followed by programming the function itself to D0 which brings the link
> back to L0. It does not involve conventional reset (see picture in page
> 492 of PCIe 5.0 spec). The recovery delays needed are listed in the same
> page.
> 
> > > If we don't put the device into D3cold then I think it
> > > stays in L1 where it can be brought back by writing D0 to PM register
> > > which does not need any other delay than the D3hot -> D0 (10ms).
> > 
> > In pci_pm_reset(), we're doing the D0->D3hot->D0 transitions
> > specifically to do a reset, so No_Soft_Reset is false.  Doesn't 6.6.1
> > say we need at least 100ms here?
> 
> No since it does not go into D3cold. It just "reset" the thing if it
> happens to do internal reset after D3hot -> D0.

Sec 5.8, Figure 5-18 says D3hot->D0uninitialized is a "Soft Reset", which
unfortunately is not defined.

My guess is that in sec 5.9, Table 5-13, the 10ms delay is for the
D3hot->D0active (i.e., No_Soft_Reset=1) transition, and the
D3hot->D0uninitialized (i.e., No_Soft_Reset=0) that does a "soft
reset" (whatever that is) probably requires more and we should handle
it like a conventional reset to be safe.

> Actually looking at the spec 5.3.1.4 it seems that pci_pm_reset() may
> depend on something not guaranteed:
> 
>   If the No_Soft_Reset bit is Clear, functional context is not required
>   to be maintained by the Function in the D3hot state, however it is not
>   guaranteed that functional context will be cleared and software must
>   not depend on such behavior.

Good point.  Sounds like that reset method may not be reliable in
general, although it might work for SR-IOV: 9.6.2 says that PFs with
No_Soft_Reset clear must perform an internal reset on D3hot->D0.

Bjorn
