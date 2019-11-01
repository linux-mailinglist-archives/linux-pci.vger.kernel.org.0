Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78A8AEC1A1
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2019 12:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfKALTX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Nov 2019 07:19:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:17515 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729044AbfKALTX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Nov 2019 07:19:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 04:19:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,254,1569308400"; 
   d="scan'208";a="211768832"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Nov 2019 04:19:19 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 01 Nov 2019 13:19:18 +0200
Date:   Fri, 1 Nov 2019 13:19:18 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Add missing link delays required by the PCIe
 spec
Message-ID: <20191101111918.GL2593@lahna.fi.intel.com>
References: <20191030111516.GX2593@lahna.fi.intel.com>
 <20191031223144.GA81598@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031223144.GA81598@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 31, 2019 at 05:31:44PM -0500, Bjorn Helgaas wrote:
> On Wed, Oct 30, 2019 at 01:15:16PM +0200, Mika Westerberg wrote:
> > On Tue, Oct 29, 2019 at 03:27:09PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Oct 29, 2019 at 01:15:20PM +0200, Mika Westerberg wrote:
> > > > On Mon, Oct 28, 2019 at 03:16:53PM -0500, Bjorn Helgaas wrote:
> > > > > > The related hardware event is resume in this case. Can you point
> > > > > > me to the actual point where you want me to put this?
> > > > > 
> > > > > "Resume" is a Linux software concept, so of course the PCIe spec
> > > > > doesn't say anything about it.  The spec talks about delays
> > > > > related to resets and device power and link state transitions, so
> > > > > somehow we have to connect the Linux delay with those hardware
> > > > > events.
> > > > > 
> > > > > Since we're talking about a transition from D3cold, this has to be
> > > > > done via something external to the device such as power
> > > > > regulators.  For ACPI systems that's probably hidden inside _PS0
> > > > > or something similar.  That's opaque, but at least it's a hook
> > > > > that says "here's where we put the device into D0".  I suggested
> > > > > acpi_pci_set_power_state() as a possibility since I think that's
> > > > > the lowest-level point where we have the pci_dev so we know the
> > > > > current state and the new state.
> > > > 
> > > > I looked at how we could use acpi_pci_set_power_state() but I don't
> > > > think it is possible because it is likely that only the root port
> > > > has the power resource that is used to bring the link to L2 or L3.
> > > > However, we would need to repeat the delay for each downstream/root
> > > > port if there are multiple PCIe switches in the topology.
> > > 
> > > OK, I think I understand why that's a problem (correct me if I'm
> > > wrong):
> > > 
> > >   We call pci_pm_resume_noirq() for every device, but it only calls
> > >   acpi_pci_set_power_state() for devices that have _PS0 or _PR0
> > >   methods.  So if the delay is in acpi_pci_set_power_state() and we
> > >   have A -> B -> C where only A has _PS0, we would delay for the link
> > >   to B to come up, but not for the link to C.
> > 
> > Yes, that's correct.
> > 
> > > I do see that we do need both delays.  In acpi_pci_set_power_state()
> > > when we transition A from D3cold->D0, I assume that single _PS0
> > > evaluation on A causes B to transition from D3cold->D3hot, which in
> > > turn causes C to transition from D3cold->D3hot.  Is that your
> > > understanding, too?
> > 
> > Not exactly :)
> > 
> > It is _ON() that causes the links to be retrained and it also causes the
> > PERST# (reset) to be unasserted for the whole topology transitioning all
> > devices into D0unitialized (default value for PMCSR PowerState field is 0).
> 
> OK.  I guess the important thing is that a single power-on from D3cold
> at any point in the hierarchy can power on the entire subtree rooted
> at that point.  So if we have RP -> SUP -> SDP0..SDP7 where SDP0..SDP7
> are Switch Downstream Ports, when we evaluate _ON for RP, PERST# will
> be deasserted below it, and everything downstream should start the
> process of going to D0uninitialized.
> 
> And we can't rely on any other hooks like _ON/_PS0 invocations for
> SUP, SDPx, etc, where we could do additional delays.

What I've seen they don't typically even have representation in ACPI.

> > > If the delay is in pci_pm_resume_noirq() (as in your patch), what
> > > happens with a switch with several Downstream Ports?  I assume that
> > > all the Downstream Ports start their transition out of D3cold
> > > basically simultaneously, so we probably don't need N delays, do we?
> > 
> > No. Actually Linux already resumes these in parallel because async
> > suspend is set for them (for system suspend that is).
> 
> So I think we have something like this:
> 
>   pci_pm_resume_noirq(RP)
>     pdev->current_state == PCI_D3cold  # HW actually in D3cold
>     _ON(RP)                            # turns on entire hierarchy
>     pci_bridge_wait_for_secondary_bus  # waits only for RP -> SUP link
> 
>   pci_pm_resume_noirq(SUP)
>     pdev->current_state == PCI_D3cold  # HW probably in D0uninitialized
>     pci_bridge_wait_for_secondary_bus  # no wait (not a downstream port)
> 
>   pci_pm_resume_noirq(SDP0)
>     pdev->current_state == PCI_D3cold  # HW probably in D0uninitialized
>     pci_bridge_wait_for_secondary_bus  # waits for SDP0 -> ? link
> 
>   ...
> 
>   pci_pm_resume_noirq(SDP7)
>     pdev->current_state == PCI_D3cold  # HW probably in D0uninitialized
>     pci_bridge_wait_for_secondary_bus  # waits for SDP7 -> ? link
> 
> and we have 1 delay for the Root Port plus 8 delays (one for each
> Switch Downstream Port), and as soon as SUP has been resumed,
> SDP0..SDP7 can be resumed simultaneously (assuming async is set for
> them)?

Yes.

> I'm not a huge fan of relying on async because the asynchrony is far
> removed from this code and really hard to figure out.  Maybe an
> alternative would be to figure out in the pci_pm_resume_noirq(RP) path
> how many levels of links to wait for.

There is problem with this. For gen3 speeds and further we need to wait
for the link (each link) to be activated before we delay. If we do it
only in the root port it would need to enumerate all the ports and
handle this which complicates it unnecessarily.

You can also "guess" the delay by waiting for the worst possible time
but I don't think that's something we want to do.

> Ideally someone expert in PCIe but not in Linux would be able to look
> at the local code and verify that it matches the spec.  If verification
> requires extensive analysis or someone expert in *both* PCIe and
> Linux, it makes maintenance much harder.

Well whoever reads the code needs to be expert in both anyway.

> > > The outline of the pci_pm_resume_noirq() part of this patch is:
> > > 
> > >   pci_pm_resume_noirq
> > >     if (!dev->skip_bus_pm ...)   # <-- condition 1
> > >       pci_pm_default_resume_early
> > >         pci_power_up
> > >           if (platform_pci_power_manageable())   # _PS0 or _PR0 exist?
> > >             platform_pci_set_power_state
> > >               pci_platform_pm->set_state
> > >                 acpi_pci_set_power_state(PCI_D0) # acpi_pci_platform_pm.set_state
> > >                   acpi_device_set_power(ACPI_STATE_D0) # <-- eval _PS0
> > > +   if (d3cold)                  # <-- condition 2
> > > +     pci_bridge_wait_for_secondary_bus
> > > 
> > > Another thing that niggles at me here is that the condition for
> > > calling pci_bridge_wait_for_secondary_bus() is completely different
> > > than the condition for changing the power state.  If we didn't change
> > > the power state, there's no reason to wait, is there?
> > 
> > Indeed, if you are talking about the dev->skip_bus_pm check there is no
> > point to wait if we did not change the power state. I would assume that
> > d3cold is false in that case but we could also do this for clarity:
> > 
> > 	if (!dev->skip_bus_pm && d3cold)
> > 		pci_bridge_wait_for_secondary_bus(...)
> 
> Could the wait go in pci_power_up()?  That would at least connect it
> directly with a -> D0 transition.  Or, if that doesn't seem the right
> place for it, could we do the following?
> 
>   if (!(pci_dev->skip_bus_pm && pm_suspend_no_platform())) {
>     pci_pm_default_resume_early(pci_dev);
>     if (d3cold)
>       pci_bridge_wait_for_secondary_bus(pci_dev);
>   }
> 
>   pci_fixup_device(pci_fixup_resume_early, pci_dev);
>   pcie_pme_root_status_cleanup(pci_dev);
> 
>   if (pci_has_legacy_pm_support(pci_dev))
>     return pci_legacy_resume_early(dev);
>   ...

The reason why pci_bridge_wait_for_secondary_bus() is called almost the
last is that I figured we want to resume the root/downstream port
completely first before we start delaying for the device downstream.
Need to call it before port services (pciehp) is resumed, though.

If you think it is fine to do the delay before we have restored
everything I can move it inside pci_power_up() or call it after
pci_pm_default_resume_early() as above. I think at least we should make
sure all the saved registers are restored before so that the link
activation check actually works.

> Either way would also fix the problem that with the current patch, if
> the device has legacy PM support, we call pci_legacy_resume_early()
> but we don't wait for the secondary bus.

True.

> > > The outline of the pci_pm_runtime_resume() part of this patch is:
> > > 
> > >   pci_pm_runtime_resume
> > >     pci_restore_standard_config
> > >       if (dev->current_state != PCI_D0)
> > >         pci_set_power_state(PCI_D0)
> > >           __pci_start_power_transition
> > >             pci_platform_power_transition
> > >               if (platform_pci_power_manageable())   # _PS0 or _PR0 exist?
> > >                 platform_pci_set_power_state
> > >                   pci_platform_pm->set_state
> > >                     acpi_pci_set_power_state(PCI_D0) # acpi_pci_platform_pm.set_state
> > >                       acpi_device_set_power(ACPI_STATE_D0) # <-- eval _PS0
> > >               pci_raw_set_power_state
> > >           __pci_complete_power_transition
> > > +   if (d3cold)
> > > +     pci_bridge_wait_for_secondary_bus
> > > 
> > > In this part, the power state change is inside
> > > pci_restore_standard_config(), which calls pci_set_power_state().
> > > There are many other callers of pci_set_power_state(); can we be sure
> > > that none of them need a delay?
> > 
> > Since we are handling the delay when we resume the downstream port, not
> > when we resume the device itself, I think the link should be up already
> > and the device accessible if someone calls pci_set_power_state() for it
> > (as the parent is always resumed before children).
> 
> Ah, yeah, I guess that since all the calls I see are for non-bridge
> devices, there would be no delay for a secondary bus.
> 
> This is a tangent, but there are ~140 pci_set_power_state(PCI_D0)
> calls, mostly from .resume() methods of drivers with legacy PM.  Are
> those even necessary?  It looks like the PCI core does this so the
> driver wouldn't need to:
> 
>   pci_pm_resume_noirq
>     pci_pm_default_resume_early
>       pci_power_up
>         pci_raw_set_power_state(dev, PCI_D0)   # <-- PCI core
> 
>   pci_pm_resume
>     if (pci_has_legacy_pm_support(pci_dev))
>       pci_legacy_resume(dev)
>         drv->resume
> 	  pci_set_power_state(PCI_D0)          # <-- driver .resume()

I don't think most of them are necessary anymore.

> > > > > But it seems that at least some ACPI firmware doesn't do those
> > > > > delays, so I guess our only alternatives are to always do it in
> > > > > the OS or have some sort of blacklist.  And it doesn't really seem
> > > > > practical to maintain a blacklist.
> > > > 
> > > > I really think this is crystal clear:
> > > 
> > > I am agreeing with you that the OS needs to do the delays.
> 
> Did you miss this part?  I said below that the existence of the _DSM
> *by itself* doesn't convince me.  But I think the lack of clarity and
> the fact that at least some firmware doesn't do it means that the OS
> must do it.

Yes, I missed this part. Sorry about that.
