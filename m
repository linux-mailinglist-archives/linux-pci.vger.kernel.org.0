Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 628B2E8664
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 12:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfJ2LP1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 07:15:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:31180 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfJ2LP1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 07:15:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 04:15:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="211085589"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 29 Oct 2019 04:15:21 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 29 Oct 2019 13:15:20 +0200
Date:   Tue, 29 Oct 2019 13:15:20 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20191029111520.GE2593@lahna.fi.intel.com>
References: <20191028180601.GA2593@lahna.fi.intel.com>
 <20191028201653.GA124445@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028201653.GA124445@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 28, 2019 at 03:16:53PM -0500, Bjorn Helgaas wrote:
> > The related hardware event is resume in this case. Can you point me to
> > the actual point where you want me to put this?
> 
> "Resume" is a Linux software concept, so of course the PCIe spec
> doesn't say anything about it.  The spec talks about delays related to
> resets and device power and link state transitions, so somehow we have
> to connect the Linux delay with those hardware events.
> 
> Since we're talking about a transition from D3cold, this has to be
> done via something external to the device such as power regulators.
> For ACPI systems that's probably hidden inside _PS0 or something
> similar.  That's opaque, but at least it's a hook that says "here's
> where we put the device into D0".  I suggested
> acpi_pci_set_power_state() as a possibility since I think that's the
> lowest-level point where we have the pci_dev so we know the current
> state and the new state.

I looked at how we could use acpi_pci_set_power_state() but I don't
think it is possible because it is likely that only the root port has
the power resource that is used to bring the link to L2 or L3. However,
we would need to repeat the delay for each downstream/root port if there
are multiple PCIe switches in the topology.

Also the delay needs to be issued after the downstream link is trained
so the downstream/root port needs to be in D0 first.

> > > > > For D3cold->D0, I guess that would be somewhere down in
> > > > > platform_pci_set_power_state()?  Maybe acpi_pci_set_power_state()?
> > > > > What about the mid_pci_set_power_state() path?  Does that need this
> > > > > too?
> > > > 
> > > > I can take a look if it can be placed there. Yes,
> > > > mid_pci_set_power_state() may at least in theory need it too although I
> > > > don't remember any MID platforms with real PCIe devices.
> > > 
> > > I don't know how the OS is supposed to know if these are real PCIe
> > > devices or not.  If we don't know, we have to assume they work per
> > > spec and may require the delays per spec.
> > 
> > Well MID devices are pretty much "hard-coded" the OS knows everything
> > there is connected.
> 
> MID seems to be magic in that it wants to use the normal PCI core
> without having to abide by all the assumptions in the spec.  That's
> OK, but MID needs to be explicit about when it is OK to violate those
> assumptions.  In this case, I think it means that if we add the delay
> to acpi_pci_set_power_state(), we should at least add a comment to
> mid_pci_set_power_state() about why the delay is or is not required
> for MID.
> 
> > > > > In the ACPI spec, _PS0 doesn't say anything about delays.  _ON (which
> > > > > I assume is not for PCI devices themselves) *does* say firmware is
> > > > > responsible for sequencing delays, so I would tend to assume it's
> > > > > really firmware's job and we shouldn't need to do this in the kernel
> > > > > at all.
> > > > 
> > > > _ON is also for PCI device itself but all those methods are not just for
> > > > PCI so they don't really talk about any PCI specific delays. You need to
> > > > look at other specs. For example PCI FW spec v3.2 section 4.6.9 says
> > > > this about the _DSM that can be used to decrease the delays:
> > > > 
> > > >   This function is optional. If the platform does not provide it, the
> > > >   operating system must adhere to all timing requirements as described
> > > >   in the PCI Express Base specification and/or applicable form factor
> > > >   specification, including values contained in Readiness Time Reporting
> > > >   capability structure.
> > > 
> > > I don't think this _DSM tells us anything about delays after _ON,
> > > _PS0, etc.  All the delays it mentions are for transitions the OS can
> > > do natively without the _ON, _PS0, etc methods.  It makes no mention
> > > of those methods, or of the D3cold->D0 transition (which would require
> > > them).
> > 
> > D3cold->D0 transition is explained in PCI spec 5.0 page 492 (there is
> > picture). You can see that D3cold -> D0 involves fundamental reset.
> > Section 6.6.1 (page 551) then says that fundamental reset is one
> > category of conventional reset. Now, that _DSM allows lowering the init
> > time after conventional reset. So to me it talks exactly about those
> > delays (also PCIe cannot go into D3cold without help from the platform,
> > ACPI in this case).
> 
> Everything on the _DSM list is something the OS can do natively (even
> conventional reset can be done via Secondary Bus Reset), and it says
> nothing about a connection with ACPI power management methods (_PS0,
> etc), so I think it's ambiguous at best.  A simple "OS is responsible
> for any bus-specific delays after a transition" in the ACPI _PS0
> documentation would have trivially resolved this.

But I would imagine that is not always the case, that's the reason we
have documents such as PCI FW.

> But it seems that at least some ACPI firmware doesn't do those delays,
> so I guess our only alternatives are to always do it in the OS or have
> some sort of blacklist.  And it doesn't really seem practical to
> maintain a blacklist.

I really think this is crystal clear:

The OS is always responsible for the delays described in the PCIe spec.
However, if the platform implements some of them say in _ON or _PS0
methods then it can notify the OS about this by using the _DSM so the OS
does not need to duplicate all of them.

> > > > Relevant PCIe spec section is 6.6.1 (also referenced in the changelog).
> > > > 
> > > > [If you have access to ECN titled "Async Hot-Plug Updates" (you can find
> > > > it in PCI-SIG site) that document has a nice table about the delays in
> > > > page 32. It compares surprise hotplug with downstream port containment
> > > > for async hotplug]
> > > 
> > > Thanks for the pointer, that ECN looks very useful.  It does talk
> > > about delays in general, but I don't see anything that clarifies
> > > whether ACPI methods or the OS is responsible for them.
> > 
> > No but the _DSM description above is pretty clear about that. At least
> > for me it is clear.
> > 
> > > > > What about D3hot->D0?  When a bridge (Root Port or Switch Downstream
> > > > > Port) is in D3hot, I'm not really clear on the state of its link.  If
> > > > > the link is down, I assume putting the bridge in D0 will bring it up
> > > > > and we'd have to wait for that?  If so, we'd need to do something in
> > > > > the reset path, e.g., pci_pm_reset()?
> > > > 
> > > > AFAIK the link goes into L1 when the function is programmed to any other
> > > > D state than D0. 
> > > 
> > > Yes, and the "function" here is the one on the *downstream* end, e.g.,
> > > the Endpoint or Switch Upstream Port.  When the upstream bridge (Root
> > > Port or Switch Downstream Port) is in a non-D0 state, the downstream
> > > component is unreachable (memory, I/O, and type 1 config requests are
> > > terminated by the bridge as unsupported requests).
> > 
> > Yes, the link is in L1 (its PM state is determined by the D-state of the
> > downstream component. From there you can get it back to functional state
> > by programming the downstream port to D0 (the link is still in L1)
> > followed by programming the function itself to D0 which brings the link
> > back to L0. It does not involve conventional reset (see picture in page
> > 492 of PCIe 5.0 spec). The recovery delays needed are listed in the same
> > page.
> > 
> > > > If we don't put the device into D3cold then I think it
> > > > stays in L1 where it can be brought back by writing D0 to PM register
> > > > which does not need any other delay than the D3hot -> D0 (10ms).
> > > 
> > > In pci_pm_reset(), we're doing the D0->D3hot->D0 transitions
> > > specifically to do a reset, so No_Soft_Reset is false.  Doesn't 6.6.1
> > > say we need at least 100ms here?
> > 
> > No since it does not go into D3cold. It just "reset" the thing if it
> > happens to do internal reset after D3hot -> D0.
> 
> Sec 5.8, Figure 5-18 says D3hot->D0uninitialized is a "Soft Reset", which
> unfortunately is not defined.
> 
> My guess is that in sec 5.9, Table 5-13, the 10ms delay is for the
> D3hot->D0active (i.e., No_Soft_Reset=1) transition, and the
> D3hot->D0uninitialized (i.e., No_Soft_Reset=0) that does a "soft
> reset" (whatever that is) probably requires more and we should handle
> it like a conventional reset to be safe.

I think it simply means the device functional context is lost (there is
more in section 5.3.1.4). Linux handles this properly already (well at
least according the minimum timings required by the spec) and restores
the context accordingly after it has waited for the 10ms.

It is the D3cold (where links go to L2 or L3) where we really need the
delays so that the link gets properly trained before we start poking the
downstream device.
