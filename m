Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35089F91E5
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 15:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfKLOVP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 09:21:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbfKLOVO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 09:21:14 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C5E72084F;
        Tue, 12 Nov 2019 14:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573568473;
        bh=/RyZ6geyuFDMCdS42y0y06jdX7OWhnoPMwj/kETqA+4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DWxQVDZLoLr4hpD1irCeTIpXfGv2MhNdloA/qoP7iqYEUnwijrDAhsIqbvjT2UnGD
         GAdzMTT8mF4vXqXET8+jerAi33P6UHYGn5u36r5f0vzyUUc+Kg5n/WTIi24rzaAUiL
         XpL7aQx3WKYNJVHahksl7SkfezoihykNrLt3BqGc=
Date:   Tue, 12 Nov 2019 08:21:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thierry Reding <treding@nvidia.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Andrew Murray <andrew.murray@arm.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
Message-ID: <20191112142111.GA152047@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112125923.GA4168874@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 12, 2019 at 01:59:23PM +0100, Thierry Reding wrote:
> On Mon, Nov 11, 2019 at 04:32:35PM -0600, Bjorn Helgaas wrote:
> > On Mon, Nov 11, 2019 at 11:31:18AM +0530, Vidya Sagar wrote:
> > > On 11/6/2019 10:11 PM, Bjorn Helgaas wrote:
> > 
> > > > Based on Vidya's backtrace, I think the resume path with problems
> > > > is this:
> > > > 
> > > >    pci_pm_resume_noirq
> > > >      pci_pm_default_resume_early
> > > >        pci_power_up
> > > >          if (platform_pci_power_manageable(dev))
> > > >            platform_pci_set_power_state(dev, PCI_D0)  # <-- FW delay here?
> > > >          pci_raw_set_power_state
> > > >          pci_update_current_state
> > > >            pci_device_is_present        # <-- config read returns CRS
> > > > 
> > > > So I think your suggestion is that Vidya's firmware should be
> > > > doing the delay inside platform_pci_set_power_state()?
> > > > 
> > > > Vidya, you typically work on Tegra, so I assume this is on an
> > > > arm64 system?  Does it have ACPI?  Do you have access to the
> > > > firmware developers to ask about who they expect to do the delays?
> > >
> > > Yes. This is on arm64 (Tegra) and we don't have any ACPI or any
> > > other firmware for that matter. PCIe is brought up directly in the
> > > kernel.
> > 
> > I assume that your device is coming out of D3cold because apparently
> > you're seeing a CRS status from the config read when
> > pci_update_current_state() calls pci_device_is_present().  CRS status
> > should only happen after reset or power-on from D3cold, and you're not
> > doing a reset.
> > 
> > I'm pretty sure platform_pci_power_manageable() returns false on
> > your system (can you confirm that?) because the only scenarios with
> > platform power management are MID (Intel platform) and ACPI (which you
> > don't have).
> > 
> > Maybe you have some other platform-specific mechanism that controls
> > power to PCI devices, and it's not integrated into the
> > platform_pci_*() framework?
> 
> My understanding after reading the PCIe specification is that CRS is a
> mechanism that allows an endpoint to signal that it isn't ready yet for
> operation after reset or power-on from D3cold. There's nothing in there
> that's platform specific. This is really only for specific endpoints.
> 
> I don't see how adding platform specific PM code would help in this
> case. At a platform level we don't know if users are going to plug in a
> PCI endpoint that needs a long delay before it's ready after reset and/
> or exit from D3cold.

Right, see below.

> I do understand that perhaps pci_device_is_present() is perhaps not the
> best place to do complex CRS handling, but if a mechanism is clearly
> described in the specification, isn't it something that should be dealt
> with in the core? That way we don't have to quirk this for every device
> and platform.

Definitely; we don't want quirks for endpoints (unless they're
actually broken) or for platforms (unless there's a platform hardware
or firmware defect).

There's no question that we need to delay and handle CRS after
power-on from D3cold.  I'm trying to get at the point that PCI itself
doesn't tell us how to do that power-on.  The mechanisms defined by
PCI rely on config space, which is only accessible in D0-D3hot, not
D3cold.  Power-on from D3cold can only happen via ACPI methods or
other platform-specific mechanisms, and the current design abstracts
those via platform_pci_set_power_state().  This is partly based on
Rafael's response in [1].

> The PCIe specification says that:
> 
> 	Software that intends to take advantage of this mechanism must
> 	ensure that the first access made to a device following a valid
> 	reset condition is a Configuration Read Request accessing both
> 	bytes of the Vendor ID field in the device's Configuration Space
> 	header.
> 
> So doesn't that mean that pci_device_is_present() is already much too
> late because we've potentially made other configuration read requests in
> the meantime?
> 
> Wouldn't it make more sense to push the CRS handling up a bit? The
> existing pci_power_up() function seems like it would be a good place.
> For example, adding code to deal with CRS right after the platform PCI
> PM calls but before pci_raw_set_power_state() seems like it would fit
> the restrictions given in the above quote from the specification.

Yep, I think that's the right point.  I'm trying to figure out how to
integrate it.  Rafael suggests that delays may be platform-specific
and should be in platform_pci_set_power_state(), but the CRS handling
itself isn't platform-specific and maybe could be higher up.

I'm fishing to see if Tegra has some kind of power control for
endpoints that is not related to the platform_pci_*() framework.  How
did the endpoint get put in D3cold in the first place?  I assume
something in the suspend path did that?  Maybe this happens when we
suspend the Tegra RC itself, e.g., tegra_pcie_pm_suspend()?

  tegra_pcie_pm_suspend
    tegra_pcie_phy_power_off
    tegra_pcie_power_off

  tegra_pcie_pm_resume
    tegra_pcie_power_on
    tegra_pcie_phy_power_on

If a path like tegra_pcie_pm_resume() is causing the D3cold -> D0
transition for the endpoint, I don't think we want to do CRS handling
there because that path shouldn't be touching the endpoint.  But maybe
it should be doing the delays required by PCIe r5.0, sec 6.6.1, before
any config accesses are issued to devices.

[1] https://lore.kernel.org/r/11429373.7ySiFsEkgL@kreacher
