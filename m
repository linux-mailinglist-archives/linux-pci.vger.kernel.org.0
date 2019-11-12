Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68A58F9935
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 19:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLS6r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 13:58:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfKLS6r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 13:58:47 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A60DB2067B;
        Tue, 12 Nov 2019 18:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573585126;
        bh=b8bPjq8ByE01/C5oSu9o1/i5lf2p+4RePWdCWvb2E2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Km9QvEzfZmcuH8kjyRH2ijpC5A8lBsjArXixZLbEhBetVIeaDtU1H7Bg26zYytKog
         04FWqiA3McNJybZrGf9CNuAaQvXovPlRspXWHwlASecpisMH9WaaqUlPmHwJKOVYZx
         iEAZDqhKBeOLu2lDA67LeqkN1wuw4qWXmvryQ/MQ=
Date:   Tue, 12 Nov 2019 12:58:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Thierry Reding <treding@nvidia.com>, Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Andrew Murray <andrew.murray@arm.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
Message-ID: <20191112185844.GA191944@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bb62272-6a9f-f4e3-540a-360ff5a8a0f7@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 12, 2019 at 11:29:55PM +0530, Vidya Sagar wrote:
> On 11/12/2019 7:51 PM, Bjorn Helgaas wrote:
> > On Tue, Nov 12, 2019 at 01:59:23PM +0100, Thierry Reding wrote:
> > > On Mon, Nov 11, 2019 at 04:32:35PM -0600, Bjorn Helgaas wrote:
> > > > On Mon, Nov 11, 2019 at 11:31:18AM +0530, Vidya Sagar wrote:
> > > > > On 11/6/2019 10:11 PM, Bjorn Helgaas wrote:
> > > > 
> > > > > > Based on Vidya's backtrace, I think the resume path with problems
> > > > > > is this:
> > > > > > 
> > > > > >     pci_pm_resume_noirq
> > > > > >       pci_pm_default_resume_early
> > > > > >         pci_power_up
> > > > > >           if (platform_pci_power_manageable(dev))
> > > > > >             platform_pci_set_power_state(dev, PCI_D0)  # <-- FW delay here?
> > > > > >           pci_raw_set_power_state
> > > > > >           pci_update_current_state
> > > > > >             pci_device_is_present        # <-- config read returns CRS
> > > > > > 
> > > > > > So I think your suggestion is that Vidya's firmware should be
> > > > > > doing the delay inside platform_pci_set_power_state()?
> > > > > > 
> > > > > > Vidya, you typically work on Tegra, so I assume this is on an
> > > > > > arm64 system?  Does it have ACPI?  Do you have access to the
> > > > > > firmware developers to ask about who they expect to do the delays?
> > > > > 
> > > > > Yes. This is on arm64 (Tegra) and we don't have any ACPI or any
> > > > > other firmware for that matter. PCIe is brought up directly in the
> > > > > kernel.
> > > > 
> > > > I assume that your device is coming out of D3cold because apparently
> > > > you're seeing a CRS status from the config read when
> > > > pci_update_current_state() calls pci_device_is_present().  CRS status
> > > > should only happen after reset or power-on from D3cold, and you're not
> > > > doing a reset.
> > > > 
> > > > I'm pretty sure platform_pci_power_manageable() returns false on
> > > > your system (can you confirm that?) because the only scenarios with
> > > > platform power management are MID (Intel platform) and ACPI (which you
> > > > don't have).
> > > > 
> > > > Maybe you have some other platform-specific mechanism that controls
> > > > power to PCI devices, and it's not integrated into the
> > > > platform_pci_*() framework?
> > > 
> > > My understanding after reading the PCIe specification is that CRS is a
> > > mechanism that allows an endpoint to signal that it isn't ready yet for
> > > operation after reset or power-on from D3cold. There's nothing in there
> > > that's platform specific. This is really only for specific endpoints.
> > > 
> > > I don't see how adding platform specific PM code would help in this
> > > case. At a platform level we don't know if users are going to plug in a
> > > PCI endpoint that needs a long delay before it's ready after reset and/
> > > or exit from D3cold.
> > 
> > Right, see below.
> > 
> > > I do understand that perhaps pci_device_is_present() is perhaps not the
> > > best place to do complex CRS handling, but if a mechanism is clearly
> > > described in the specification, isn't it something that should be dealt
> > > with in the core? That way we don't have to quirk this for every device
> > > and platform.
> > 
> > Definitely; we don't want quirks for endpoints (unless they're
> > actually broken) or for platforms (unless there's a platform hardware
> > or firmware defect).
> > 
> > There's no question that we need to delay and handle CRS after
> > power-on from D3cold.  I'm trying to get at the point that PCI itself
> > doesn't tell us how to do that power-on.  The mechanisms defined by
> > PCI rely on config space, which is only accessible in D0-D3hot, not
> > D3cold.  Power-on from D3cold can only happen via ACPI methods or
> > other platform-specific mechanisms, and the current design abstracts
> > those via platform_pci_set_power_state().  This is partly based on
> > Rafael's response in [1].
> > 
> > > The PCIe specification says that:
> > > 
> > > 	Software that intends to take advantage of this mechanism must
> > > 	ensure that the first access made to a device following a valid
> > > 	reset condition is a Configuration Read Request accessing both
> > > 	bytes of the Vendor ID field in the device's Configuration Space
> > > 	header.
> > > 
> > > So doesn't that mean that pci_device_is_present() is already much too
> > > late because we've potentially made other configuration read requests in
> > > the meantime?
> > > 
> > > Wouldn't it make more sense to push the CRS handling up a bit? The
> > > existing pci_power_up() function seems like it would be a good place.
> > > For example, adding code to deal with CRS right after the platform PCI
> > > PM calls but before pci_raw_set_power_state() seems like it would fit
> > > the restrictions given in the above quote from the specification.
> > 
> > Yep, I think that's the right point.  I'm trying to figure out how to
> > integrate it.  Rafael suggests that delays may be platform-specific
> > and should be in platform_pci_set_power_state(), but the CRS handling
> > itself isn't platform-specific and maybe could be higher up.
> > 
> > I'm fishing to see if Tegra has some kind of power control for
> > endpoints that is not related to the platform_pci_*() framework.  How
> > did the endpoint get put in D3cold in the first place?  I assume
> > something in the suspend path did that?  Maybe this happens when we
> > suspend the Tegra RC itself, e.g., tegra_pcie_pm_suspend()?
> > 
> >    tegra_pcie_pm_suspend
> >      tegra_pcie_phy_power_off
> >      tegra_pcie_power_off
> > 
> >    tegra_pcie_pm_resume
> >      tegra_pcie_power_on
> >      tegra_pcie_phy_power_on
> > 
> > If a path like tegra_pcie_pm_resume() is causing the D3cold -> D0
> > transition for the endpoint, I don't think we want to do CRS handling
> > there because that path shouldn't be touching the endpoint.  But maybe
> > it should be doing the delays required by PCIe r5.0, sec 6.6.1, before
> > any config accesses are issued to devices.
>
> Here, I'm exercising suspend-to-RAM sequence and the PCIe endpoint of
> concern is Intel 750 NVMe drive.
> PCIe host controller driver already has 100ms of delay as per the spec,

To make this more concrete, where specifically is this delay?

> but this particular device is taking 1023ms to get ready to respond to
> configuration space requests (till that time, it responds with
> configuration request retry statuses)
> I've put a dump_stack () to see the path resume sequence takes and here it is
> 
>  Call trace:
>   dump_backtrace+0x0/0x158
>   show_stack+0x14/0x20
>   dump_stack+0xb0/0xf4
>   pci_bus_generic_read_dev_vendor_id+0x19c/0x1a0
>   pci_bus_read_dev_vendor_id+0x48/0x70
>   pci_update_current_state+0x68/0xd8
>   pci_power_up+0x40/0x50
>   pci_pm_resume_noirq+0x7c/0x138
>   dpm_run_callback.isra.16+0x20/0x70
>   device_resume_noirq+0x120/0x238
>   async_resume_noirq+0x24/0x58
>   async_run_entry_fn+0x40/0x148
>   process_one_work+0x1e8/0x360
>   worker_thread+0x40/0x488
>   kthread+0x118/0x120
>   ret_from_fork+0x10/0x1c
>  pci 0005:01:00.0: ready after 1023ms
> 
> Spec also mentions the following
>     Unless Readiness Notifications mechanisms are used (see Section
>     6.23), the Root Complex and/or system software must allow at
>     least 1.0 s after a Conventional Reset of a device, before it
>     may determine that a device which fails to return a Successful
>     Completion status for a valid Configuration Request is a broken
>     device. This period is independent of how quickly Link training
>     completes.
> 
> My understanding is that this 1sec waiting is supposed to be done by
> the PCIe sub-system and not the host controller driver.

That doesn't say we must wait 1s; it only says we can't decide the
device is broken before 1s.  But regardless, I agree that the CRS
handling doesn't belong in the driver for either the endpoint or the
PCIe host controller.

My question is whether this wait should be connected somehow with
platform_pci_set_power_state().  It sounds like the tegra host
controller driver already does the platform-specific delays, and I'm
not sure it's reasonable for platform_pci_set_power_state() to do the
CRS polling.  Maybe something like this?  I'd really like to get
Rafael's thinking here.

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e7982af9a5d8..052fa316c917 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -964,9 +964,14 @@ void pci_refresh_power_state(struct pci_dev *dev)
  */
 void pci_power_up(struct pci_dev *dev)
 {
+	pci_power_state_t prev_state = dev->current_state;
+
 	if (platform_pci_power_manageable(dev))
 		platform_pci_set_power_state(dev, PCI_D0);
 
+	if (prev_state == PCI_D3cold)
+		pci_dev_wait(dev, "D3cold->D0", PCIE_RESET_READY_POLL_MS);
+
 	pci_raw_set_power_state(dev, PCI_D0);
 	pci_update_current_state(dev, PCI_D0);
 }

> FWIW, this particular device is taking a little more time than 1 sec
> (i.e. 1023 ms) I'm now wondering why is it that the CRS has a
> timeout of 60 secs than just 1 sec?

pci_bus_wait_crs() does an exponential backoff, i.e., it does reads
after 0ms, 2ms, 4ms, 8ms, ..., 512ms, 1024ms, so we don't know
*exactly* when the device became ready.  All we know is that it
became ready somewhere between 512ms and 1024ms.

But 821cdad5c46c ("PCI: Wait up to 60 seconds for device to become
ready after FLR") does suggest that the Intel 750 NVMe may require
more than 1s.  I think the 60s timeout is just a convenient large
number and I'm not sure it's derived from anything in the spec.

> > [1] https://lore.kernel.org/r/11429373.7ySiFsEkgL@kreacher

