Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCD35E90C6
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 21:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfJ2U1L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 16:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:32848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfJ2U1L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 16:27:11 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CD642086A;
        Tue, 29 Oct 2019 20:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572380830;
        bh=Rfr/YDkbZCOBS716poVW8CX96iFpyW3wXlvdADnE1S0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kdqNFfvp0mv4767Ab/4Mvqpwrpx+Oe7F80ZXbDqs8o0owqHY/uQJMKKDZtw6k3Xg7
         7MbmMi0f2uBKKSK5lyhXh44/jEizkkjy0wKhh/XVWPe0jiSxRgln8wVbOBP2SbyTHw
         CVeKyE6d0JW4zp8vttpk13eILu0yOmCGqAOTAzIc=
Date:   Tue, 29 Oct 2019 15:27:09 -0500
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
Message-ID: <20191029202708.GA38926@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029111520.GE2593@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 29, 2019 at 01:15:20PM +0200, Mika Westerberg wrote:
> On Mon, Oct 28, 2019 at 03:16:53PM -0500, Bjorn Helgaas wrote:
> > > The related hardware event is resume in this case. Can you point
> > > me to the actual point where you want me to put this?
> > 
> > "Resume" is a Linux software concept, so of course the PCIe spec
> > doesn't say anything about it.  The spec talks about delays
> > related to resets and device power and link state transitions, so
> > somehow we have to connect the Linux delay with those hardware
> > events.
> > 
> > Since we're talking about a transition from D3cold, this has to be
> > done via something external to the device such as power
> > regulators.  For ACPI systems that's probably hidden inside _PS0
> > or something similar.  That's opaque, but at least it's a hook
> > that says "here's where we put the device into D0".  I suggested
> > acpi_pci_set_power_state() as a possibility since I think that's
> > the lowest-level point where we have the pci_dev so we know the
> > current state and the new state.
> 
> I looked at how we could use acpi_pci_set_power_state() but I don't
> think it is possible because it is likely that only the root port
> has the power resource that is used to bring the link to L2 or L3.
> However, we would need to repeat the delay for each downstream/root
> port if there are multiple PCIe switches in the topology.

OK, I think I understand why that's a problem (correct me if I'm
wrong):

  We call pci_pm_resume_noirq() for every device, but it only calls
  acpi_pci_set_power_state() for devices that have _PS0 or _PR0
  methods.  So if the delay is in acpi_pci_set_power_state() and we
  have A -> B -> C where only A has _PS0, we would delay for the link
  to B to come up, but not for the link to C.

I do see that we do need both delays.  In acpi_pci_set_power_state()
when we transition A from D3cold->D0, I assume that single _PS0
evaluation on A causes B to transition from D3cold->D3hot, which in
turn causes C to transition from D3cold->D3hot.  Is that your
understanding, too?

We do know that topology in acpi_pci_set_power_state(), since we have
the pci_dev for A, so it seems conceivable that we could descend the
hierarchy and delay for each level.

If the delay is in pci_pm_resume_noirq() (as in your patch), what
happens with a switch with several Downstream Ports?  I assume that
all the Downstream Ports start their transition out of D3cold
basically simultaneously, so we probably don't need N delays, do we?
It seems a little messy to optimize this in pci_pm_resume_noirq().

The outline of the pci_pm_resume_noirq() part of this patch is:

  pci_pm_resume_noirq
    if (!dev->skip_bus_pm ...)   # <-- condition 1
      pci_pm_default_resume_early
        pci_power_up
          if (platform_pci_power_manageable())   # _PS0 or _PR0 exist?
            platform_pci_set_power_state
              pci_platform_pm->set_state
                acpi_pci_set_power_state(PCI_D0) # acpi_pci_platform_pm.set_state
                  acpi_device_set_power(ACPI_STATE_D0) # <-- eval _PS0
+   if (d3cold)                  # <-- condition 2
+     pci_bridge_wait_for_secondary_bus

Another thing that niggles at me here is that the condition for
calling pci_bridge_wait_for_secondary_bus() is completely different
than the condition for changing the power state.  If we didn't change
the power state, there's no reason to wait, is there?

The outline of the pci_pm_runtime_resume() part of this patch is:

  pci_pm_runtime_resume
    pci_restore_standard_config
      if (dev->current_state != PCI_D0)
        pci_set_power_state(PCI_D0)
          __pci_start_power_transition
            pci_platform_power_transition
              if (platform_pci_power_manageable())   # _PS0 or _PR0 exist?
                platform_pci_set_power_state
                  pci_platform_pm->set_state
                    acpi_pci_set_power_state(PCI_D0) # acpi_pci_platform_pm.set_state
                      acpi_device_set_power(ACPI_STATE_D0) # <-- eval _PS0
              pci_raw_set_power_state
          __pci_complete_power_transition
+   if (d3cold)
+     pci_bridge_wait_for_secondary_bus

In this part, the power state change is inside
pci_restore_standard_config(), which calls pci_set_power_state().
There are many other callers of pci_set_power_state(); can we be sure
that none of them need a delay?

> > But it seems that at least some ACPI firmware doesn't do those
> > delays, so I guess our only alternatives are to always do it in
> > the OS or have some sort of blacklist.  And it doesn't really seem
> > practical to maintain a blacklist.
> 
> I really think this is crystal clear:

I am agreeing with you that the OS needs to do the delays.

> The OS is always responsible for the delays described in the PCIe
> spec.

If the ACPI spec contained this statement, it would be useful, but I
haven't seen it.  It's certainly true that some combination of
firmware and the OS is responsible for the delays :)

> However, if the platform implements some of them say in _ON or _PS0
> methods then it can notify the OS about this by using the _DSM so
> the OS does not need to duplicate all of them.

That makes good sense, but there are other reasons for using that
_DSM, e.g., firmware may know that MID or similar devices are not
really PCI devices and don't need delays anywhere.  So the existence
of the _DSM by itself doesn't convince me that the OS is responsible
for the delays.

> > > > In pci_pm_reset(), we're doing the D0->D3hot->D0 transitions
> > > > specifically to do a reset, so No_Soft_Reset is false.
> > > > Doesn't 6.6.1 say we need at least 100ms here?
> > > 
> > > No since it does not go into D3cold. It just "reset" the thing
> > > if it happens to do internal reset after D3hot -> D0.
> > 
> > Sec 5.8, Figure 5-18 says D3hot->D0uninitialized is a "Soft
> > Reset", which unfortunately is not defined.
> > 
> > My guess is that in sec 5.9, Table 5-13, the 10ms delay is for the
> > D3hot->D0active (i.e., No_Soft_Reset=1) transition, and the
> > D3hot->D0uninitialized (i.e., No_Soft_Reset=0) that does a "soft
> > reset" (whatever that is) probably requires more and we should
> > handle it like a conventional reset to be safe.
> 
> I think it simply means the device functional context is lost (there
> is more in section 5.3.1.4). Linux handles this properly already
> (well at least according the minimum timings required by the spec)
> and restores the context accordingly after it has waited for the
> 10ms.
> 
> It is the D3cold (where links go to L2 or L3) where we really need
> the delays so that the link gets properly trained before we start
> poking the downstream device.

I'm already speculating above, so I don't think I can contribute
anything useful here.
