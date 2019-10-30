Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 041C6E9A9D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2019 12:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfJ3LPW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Oct 2019 07:15:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:24063 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfJ3LPW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Oct 2019 07:15:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 04:15:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,247,1569308400"; 
   d="scan'208";a="211303915"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 30 Oct 2019 04:15:17 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 30 Oct 2019 13:15:16 +0200
Date:   Wed, 30 Oct 2019 13:15:16 +0200
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
Message-ID: <20191030111516.GX2593@lahna.fi.intel.com>
References: <20191029111520.GE2593@lahna.fi.intel.com>
 <20191029202708.GA38926@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029202708.GA38926@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 29, 2019 at 03:27:09PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 29, 2019 at 01:15:20PM +0200, Mika Westerberg wrote:
> > On Mon, Oct 28, 2019 at 03:16:53PM -0500, Bjorn Helgaas wrote:
> > > > The related hardware event is resume in this case. Can you point
> > > > me to the actual point where you want me to put this?
> > > 
> > > "Resume" is a Linux software concept, so of course the PCIe spec
> > > doesn't say anything about it.  The spec talks about delays
> > > related to resets and device power and link state transitions, so
> > > somehow we have to connect the Linux delay with those hardware
> > > events.
> > > 
> > > Since we're talking about a transition from D3cold, this has to be
> > > done via something external to the device such as power
> > > regulators.  For ACPI systems that's probably hidden inside _PS0
> > > or something similar.  That's opaque, but at least it's a hook
> > > that says "here's where we put the device into D0".  I suggested
> > > acpi_pci_set_power_state() as a possibility since I think that's
> > > the lowest-level point where we have the pci_dev so we know the
> > > current state and the new state.
> > 
> > I looked at how we could use acpi_pci_set_power_state() but I don't
> > think it is possible because it is likely that only the root port
> > has the power resource that is used to bring the link to L2 or L3.
> > However, we would need to repeat the delay for each downstream/root
> > port if there are multiple PCIe switches in the topology.
> 
> OK, I think I understand why that's a problem (correct me if I'm
> wrong):
> 
>   We call pci_pm_resume_noirq() for every device, but it only calls
>   acpi_pci_set_power_state() for devices that have _PS0 or _PR0
>   methods.  So if the delay is in acpi_pci_set_power_state() and we
>   have A -> B -> C where only A has _PS0, we would delay for the link
>   to B to come up, but not for the link to C.

Yes, that's correct.

> I do see that we do need both delays.  In acpi_pci_set_power_state()
> when we transition A from D3cold->D0, I assume that single _PS0
> evaluation on A causes B to transition from D3cold->D3hot, which in
> turn causes C to transition from D3cold->D3hot.  Is that your
> understanding, too?

Not exactly :)

It is _ON() that causes the links to be retrained and it also causes the
PERST# (reset) to be unasserted for the whole topology transitioning all
devices into D0unitialized (default value for PMCSR PowerState field is 0).

> We do know that topology in acpi_pci_set_power_state(), since we have
> the pci_dev for A, so it seems conceivable that we could descend the
> hierarchy and delay for each level.

Right.

> If the delay is in pci_pm_resume_noirq() (as in your patch), what
> happens with a switch with several Downstream Ports?  I assume that
> all the Downstream Ports start their transition out of D3cold
> basically simultaneously, so we probably don't need N delays, do we?

No. Actually Linux already resumes these in paraller because async
suspend is set for them (for system suspend that is).

> It seems a little messy to optimize this in pci_pm_resume_noirq().

I agree.

> The outline of the pci_pm_resume_noirq() part of this patch is:
> 
>   pci_pm_resume_noirq
>     if (!dev->skip_bus_pm ...)   # <-- condition 1
>       pci_pm_default_resume_early
>         pci_power_up
>           if (platform_pci_power_manageable())   # _PS0 or _PR0 exist?
>             platform_pci_set_power_state
>               pci_platform_pm->set_state
>                 acpi_pci_set_power_state(PCI_D0) # acpi_pci_platform_pm.set_state
>                   acpi_device_set_power(ACPI_STATE_D0) # <-- eval _PS0
> +   if (d3cold)                  # <-- condition 2
> +     pci_bridge_wait_for_secondary_bus
> 
> Another thing that niggles at me here is that the condition for
> calling pci_bridge_wait_for_secondary_bus() is completely different
> than the condition for changing the power state.  If we didn't change
> the power state, there's no reason to wait, is there?

Indeed, if you are talking about the dev->skip_bus_pm check there is no
point to wait if we did not change the power state. I would assume that
d3cold is false in that case but we could also do this for clarity:

	if (!dev->skip_bus_pm && d3cold)
		pci_bridge_wait_for_secondary_bus(...)

> The outline of the pci_pm_runtime_resume() part of this patch is:
> 
>   pci_pm_runtime_resume
>     pci_restore_standard_config
>       if (dev->current_state != PCI_D0)
>         pci_set_power_state(PCI_D0)
>           __pci_start_power_transition
>             pci_platform_power_transition
>               if (platform_pci_power_manageable())   # _PS0 or _PR0 exist?
>                 platform_pci_set_power_state
>                   pci_platform_pm->set_state
>                     acpi_pci_set_power_state(PCI_D0) # acpi_pci_platform_pm.set_state
>                       acpi_device_set_power(ACPI_STATE_D0) # <-- eval _PS0
>               pci_raw_set_power_state
>           __pci_complete_power_transition
> +   if (d3cold)
> +     pci_bridge_wait_for_secondary_bus
> 
> In this part, the power state change is inside
> pci_restore_standard_config(), which calls pci_set_power_state().
> There are many other callers of pci_set_power_state(); can we be sure
> that none of them need a delay?

Since we are handling the delay when we resume the downstream port, not
when we resume the device itself, I think the link should be up already
and the device accessible if someone calls pci_set_power_state() for it
(as the parent is always resumed before children).

> > > But it seems that at least some ACPI firmware doesn't do those
> > > delays, so I guess our only alternatives are to always do it in
> > > the OS or have some sort of blacklist.  And it doesn't really seem
> > > practical to maintain a blacklist.
> > 
> > I really think this is crystal clear:
> 
> I am agreeing with you that the OS needs to do the delays.
> 
> > The OS is always responsible for the delays described in the PCIe
> > spec.
> 
> If the ACPI spec contained this statement, it would be useful, but I
> haven't seen it.  It's certainly true that some combination of
> firmware and the OS is responsible for the delays :)
> 
> > However, if the platform implements some of them say in _ON or _PS0
> > methods then it can notify the OS about this by using the _DSM so
> > the OS does not need to duplicate all of them.
> 
> That makes good sense, but there are other reasons for using that
> _DSM, e.g., firmware may know that MID or similar devices are not
> really PCI devices and don't need delays anywhere.  So the existence
> of the _DSM by itself doesn't convince me that the OS is responsible
> for the delays.

Hmm, my interpretion of the specs is that OS is responsible for these
delays but if you can't be convinced then how you propose we handle this
problem? I mean there are two cases already listed in the changelog of
this patch from a real systems that need these delays. I don't think we
can just say people that unfortunately your system will not be supported
by Linux because we are not convinced that OS should do these delays. ;-)
