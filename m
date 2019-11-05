Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D642EF189
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 01:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfKEAAH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Nov 2019 19:00:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730163AbfKEAAE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Nov 2019 19:00:04 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF40C217F5;
        Tue,  5 Nov 2019 00:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572912003;
        bh=kcr4Li6D1gL54m0jCh6eOuzX4YCPo1SI7JsqswM3vAw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=0NNegkPHukvK3sD1x8yQ8BbgEzcZGKj28zPUdm3nI/SHFWsdz14RmqDez7JXRJ63h
         2bMXYciaH5PEk59oUMpakv0DhPrkKZCjKNXv6gWMt1lOrC2X+//zoBnjH5DGYR3cXg
         dFxqqZ43MvIQAl0iE7jj4FOPGc22hXip50wBkIjk=
Date:   Mon, 4 Nov 2019 18:00:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
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
Message-ID: <20191105000000.GA126282@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101111918.GL2593@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 01, 2019 at 01:19:18PM +0200, Mika Westerberg wrote:
> On Thu, Oct 31, 2019 at 05:31:44PM -0500, Bjorn Helgaas wrote:
> > On Wed, Oct 30, 2019 at 01:15:16PM +0200, Mika Westerberg wrote:
> > > On Tue, Oct 29, 2019 at 03:27:09PM -0500, Bjorn Helgaas wrote:

> > I'm not a huge fan of relying on async because the asynchrony is far
> > removed from this code and really hard to figure out.  Maybe an
> > alternative would be to figure out in the pci_pm_resume_noirq(RP) path
> > how many levels of links to wait for.
> 
> There is problem with this. For gen3 speeds and further we need to wait
> for the link (each link) to be activated before we delay. If we do it
> only in the root port it would need to enumerate all the ports and
> handle this which complicates it unnecessarily.

I agree, that doesn't sound good.  If we're resuming a Downstream
Port, I don't think we should be reading Link Status from other ports
farther downstream.

> > > > The outline of the pci_pm_resume_noirq() part of this patch is:
> > > > 
> > > >   pci_pm_resume_noirq
> > > >     if (!dev->skip_bus_pm ...)   # <-- condition 1
> > > >       pci_pm_default_resume_early
> > > >         pci_power_up
> > > >           if (platform_pci_power_manageable())   # _PS0 or _PR0 exist?
> > > >             platform_pci_set_power_state
> > > >               pci_platform_pm->set_state
> > > >                 acpi_pci_set_power_state(PCI_D0) # acpi_pci_platform_pm.set_state
> > > >                   acpi_device_set_power(ACPI_STATE_D0) # <-- eval _PS0
> > > > +   if (d3cold)                  # <-- condition 2
> > > > +     pci_bridge_wait_for_secondary_bus

> The reason why pci_bridge_wait_for_secondary_bus() is called almost the
> last is that I figured we want to resume the root/downstream port
> completely first before we start delaying for the device downstream.

For understandability, I think the wait needs to go in some function
that contains "PCI_D0", e.g., platform_pci_set_power_state() or
pci_power_up(), so it's connected with the transition from D3cold to
D0.

Since pci_pm_default_resume_early() is the only caller of
pci_power_up(), maybe we should just inline pci_power_up(), e.g.,
something like this:

  static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
  {
    pci_power_state_t prev_state = pci_dev->current_state;

    if (platform_pci_power_manageable(pci_dev))
      platform_pci_set_power_state(pci_dev, PCI_D0);

    pci_raw_set_power_state(pci_dev, PCI_D0);
    pci_update_current_state(pci_dev, PCI_D0);

    pci_restore_state(pci_dev);
    pci_pme_restore(pci_dev);

    if (prev_state == PCI_D3cold)
      pci_bridge_wait_for_secondary_bus(dev);
  }

I don't understand why we call both platform_pci_set_power_state() and
pci_raw_set_power_state().  I thought platform_pci_set_power_state()
should put the device in D0, so we shouldn't need the PCI_PM_CTRL
update in pci_raw_set_power_state(), although we probably do need
things like pci_restore_bars() and pcie_aspm_pm_state_change().

And in fact, it seems wrong that if platform_pci_set_power_state()
puts the device in D0 and the device lacks a PM capability, we bail
out of pci_raw_set_power_state() before calling pci_restore_bars().

Tangent: I think "pci_pm_default_resume_early" is the wrong name for
this because "default" suggests that this is what we fall back to if a
driver or arch doesn't supply a more specific method.  But here we're
doing mandatory things that cannot be overridden, so I think something
like "pci_pm_core_resume_early()" would be more accurate.

> Need to call it before port services (pciehp) is resumed, though.

I guess this is because pciehp_resume() looks at PCI_EXP_LNKSTA and
will be confused if the link isn't up yet?

> If you think it is fine to do the delay before we have restored
> everything I can move it inside pci_power_up() or call it after
> pci_pm_default_resume_early() as above. I think at least we should make
> sure all the saved registers are restored before so that the link
> activation check actually works.

What needs to be restored to make pcie_wait_for_link_delay() work?
And what event does the restore need to be ordered with?  I could
imagine needing to restore something like Target Link Speed before
waiting, but that sounds racy unless we force a link retrain after
restoring it.

Bjorn
