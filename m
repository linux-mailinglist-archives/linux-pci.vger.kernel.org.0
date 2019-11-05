Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 578ECEFA2D
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 10:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387926AbfKEJyd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 04:54:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:3948 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730571AbfKEJyd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Nov 2019 04:54:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 01:54:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,270,1569308400"; 
   d="scan'208";a="212507068"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 05 Nov 2019 01:54:29 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 05 Nov 2019 11:54:28 +0200
Date:   Tue, 5 Nov 2019 11:54:28 +0200
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
Message-ID: <20191105095428.GR2552@lahna.fi.intel.com>
References: <20191101111918.GL2593@lahna.fi.intel.com>
 <20191105000000.GA126282@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105000000.GA126282@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 04, 2019 at 06:00:00PM -0600, Bjorn Helgaas wrote:
> > > > > The outline of the pci_pm_resume_noirq() part of this patch is:
> > > > > 
> > > > >   pci_pm_resume_noirq
> > > > >     if (!dev->skip_bus_pm ...)   # <-- condition 1
> > > > >       pci_pm_default_resume_early
> > > > >         pci_power_up
> > > > >           if (platform_pci_power_manageable())   # _PS0 or _PR0 exist?
> > > > >             platform_pci_set_power_state
> > > > >               pci_platform_pm->set_state
> > > > >                 acpi_pci_set_power_state(PCI_D0) # acpi_pci_platform_pm.set_state
> > > > >                   acpi_device_set_power(ACPI_STATE_D0) # <-- eval _PS0
> > > > > +   if (d3cold)                  # <-- condition 2
> > > > > +     pci_bridge_wait_for_secondary_bus
> 
> > The reason why pci_bridge_wait_for_secondary_bus() is called almost the
> > last is that I figured we want to resume the root/downstream port
> > completely first before we start delaying for the device downstream.
> 
> For understandability, I think the wait needs to go in some function
> that contains "PCI_D0", e.g., platform_pci_set_power_state() or
> pci_power_up(), so it's connected with the transition from D3cold to
> D0.
> 
> Since pci_pm_default_resume_early() is the only caller of
> pci_power_up(), maybe we should just inline pci_power_up(), e.g.,
> something like this:
> 
>   static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
>   {
>     pci_power_state_t prev_state = pci_dev->current_state;
> 
>     if (platform_pci_power_manageable(pci_dev))
>       platform_pci_set_power_state(pci_dev, PCI_D0);
> 
>     pci_raw_set_power_state(pci_dev, PCI_D0);
>     pci_update_current_state(pci_dev, PCI_D0);
> 
>     pci_restore_state(pci_dev);
>     pci_pme_restore(pci_dev);
> 
>     if (prev_state == PCI_D3cold)
>       pci_bridge_wait_for_secondary_bus(dev);
>   }

OK, I'll see if this works.

> I don't understand why we call both platform_pci_set_power_state() and
> pci_raw_set_power_state().

platform_pci_set_power_state() deals with the ACPI methods such as
calling _PS0 after D3hot. To transition the device from D3hot to D0 you
need the PMCSR write which is done in pci_raw_set_power_state().

> I thought platform_pci_set_power_state()
> should put the device in D0, so we shouldn't need the PCI_PM_CTRL
> update in pci_raw_set_power_state(), although we probably do need
> things like pci_restore_bars() and pcie_aspm_pm_state_change().
> 
> And in fact, it seems wrong that if platform_pci_set_power_state()
> puts the device in D0 and the device lacks a PM capability, we bail
> out of pci_raw_set_power_state() before calling pci_restore_bars().
> 
> Tangent: I think "pci_pm_default_resume_early" is the wrong name for
> this because "default" suggests that this is what we fall back to if a
> driver or arch doesn't supply a more specific method.  But here we're
> doing mandatory things that cannot be overridden, so I think something
> like "pci_pm_core_resume_early()" would be more accurate.
> 
> > Need to call it before port services (pciehp) is resumed, though.
> 
> I guess this is because pciehp_resume() looks at PCI_EXP_LNKSTA and
> will be confused if the link isn't up yet?

Yes.

> > If you think it is fine to do the delay before we have restored
> > everything I can move it inside pci_power_up() or call it after
> > pci_pm_default_resume_early() as above. I think at least we should make
> > sure all the saved registers are restored before so that the link
> > activation check actually works.
> 
> What needs to be restored to make pcie_wait_for_link_delay() work?

I'm not entirely sure. I think that pci_restore_state() at least should
be called so that the PCIe capability gets restored. Maybe not event
that because Data Link Layer Layer Active always reflects the DL_Active
or not and it does not need to be enabled separately.

> And what event does the restore need to be ordered with?

Not sure I follow you here.
