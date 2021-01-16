Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5232F89FD
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jan 2021 01:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbhAPAgu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jan 2021 19:36:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:55074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbhAPAgs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Jan 2021 19:36:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C19F922AAC;
        Sat, 16 Jan 2021 00:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610757368;
        bh=fbGi5Mkd+wHJVZakUM/rbIWNnqXHMVw/OF3geWRYAV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Bzdc9h4wKnvDLEjJgyNmAL7ChbNHBZrKo+ljVJxxTtc5Lo9scLt0d/wmS9pwGNivc
         HWBZZ+AMOma1zb/Kg/LqqdQd5Tysyi9AEitjpdXPFcomdsHRthsejFMNMCJW4HsjAb
         RZ66p95DI7VauE3MIvQ6zqznDowTSPd2mORuMS+oRymUut13dlmVIjoe1f0T8Ij6sA
         0r8uWCM9O59XdpBId7Sv92AGWbYNfyILzOh3T2+PrSGUvQhHHPCFke7geK4CHYYBqI
         NSXuEocABYcAnJNYnmFxr/gk0vw1UGL3oO6QOLEwgXRbgB3oLOzRLb3Y7BgVpM7tuM
         hcBdF8N5apfYg==
Date:   Fri, 15 Jan 2021 18:36:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        linux-pci@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH] PCI: Re-enable downstream port LTR if it was previously
 enabled
Message-ID: <20210116003606.GA2136097@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115090021.GC968855@lahna.fi.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 15, 2021 at 11:00:21AM +0200, Mika Westerberg wrote:
> On Thu, Jan 14, 2021 at 06:10:07PM -0600, Bjorn Helgaas wrote:
> > On Thu, Jan 14, 2021 at 04:47:24PM +0300, Mika Westerberg wrote:
> > > PCIe r5.0, sec 7.5.3.16 says that the downstream ports must reset the
> > > LTR enable bit if the link goes down (port goes DL_Down status). Now, if
> > > we had LTR previously enabled and the PCIe endpoint gets hot-removed and
> > > then hot-added back the ->ltr_path of the downstream port is still set
> > > but the port now does not have the LTR enable bit set anymore.
> > 
> > IIRC LTR is only needed for L1.2, and of course the LTR Capability
> > (Max Snoop/No-Snoop Latency registers) and the L1 PM Substates
> > Capability (LTR_L1.2_THRESHOLD) must be programmed before enabling
> > LTR.  For the bridge, I guess we're assuming those were programmed
> > before the hot-remove, and they remain valid after the hot-add.
> > 
> > But what about the endpoint that we hot-added?  How do we program its
> > LTR and L1 PM Substates Capabilities?  I know we have
> > aspm_calc_l1ss_info() for L1 PM Substates, but I really don't trust
> > it, and I don't think we do anything at all to program the LTR
> > Capability.
> 
> True - we don't. However, enabling the LTR bit here for the endpoint
> (and for the bridges all the way up to the root port) makes the endpoint
> to report that there is no LTR requirement and that allows the SoC to do
> some PM optimizations or so.
> 
> We actually see that if this is not re-programmed like this on a Tiger
> Lake based ChromeBook S0ix fails (S0ix is Intel low power idle state).

So if we set PCI_EXP_DEVCTL2_LTR_EN for the bridge and also for the
hot-added endpoint, S0ix works.  But we never get to the S0ix state if
we don't set those bits?

And we never actually set the Max Snoop/No-Snoop Latency registers in
the LTR Capability, so they should power up as zeroes.  IIRC, that is
the most conservative setting (PCIe r5.0, sec 6.18 says "all 0's
indicates that the device will be impacted by any delay and that the
best possible service is requested").

So I *guess* it makes some sort of sense to enable LTR in that
situation, although I wish we could set the content of the messages
before enabling them.

> > I used to think the LTR _DSM was a way to help us program the LTR
> > Capability, and Puranjay did a nice job implementing support for it
> > [1].  But I now think that _DSM doesn't give us enough information
> > (and of course it doesn't help at all for non-ACPI systems or for
> > hierarchies not integrated on the system board), so I didn't merge
> > Puranjay's work.
> > 
> > I tried to have some discussion in the PCI SIG about this, but it
> > never really went anywhere.  Here's my basic question, just for the
> > archives:
> > 
> >   I think the LTR capability Max Snoop registers could also use some
> >   clarification.  The base spec says "Software should set this to the
> >   platform's maximum supported latency or less."  I assume this
> >   platform data is supposed to come from the ACPI LTR _DSM.  The
> >   firmware spec says software should sum the latencies along the path
> >   between each downstream port (I wonder if this should say "Root
> >   Port"?) and an endpoint that supports LTR.  Switches not embedded in
> >   the platform will not have this _DSM, but I assume they contribute
> >   to this sum.  But I don't know *what* they contribute.
> > 
> 
> That's a fair question :)
> 
> I personally think that the driver for the specific hardware should know
> what is the latency tolerance for the device when it is doing different
> "tasks".
> 
> > > For this reason check if the bridge upstrea had LTR enabled set
> > > previously and re-enable it before enabling LTR for the endpoint.
> > 
> > s/upstrea/upstream/
> > s/enabled set/enabled/
> 
> Thanks, I'll fix those.
> 
> > Seems like there could be more things in the upstream bridge that need
> > to be reprogrammed when the link comes back up (MPS, Common Clock
> > Configuration, etc?).
> > 
> > I don't see anything in the spec about link status affecting MPS, but
> > if we hot-removed a device that supported 4KB MPS and hot-added one
> > that only support 128B, we might need more extensive reconfiguration.
> > I haven't checked; maybe that's already covered?
> 
> It looks like that's covered in pcie_find_smpss(). It limits the MPS to
> 128 if there are hotplug bridges in the topology. Assuming I read it
> correctly.

OK, and it looks like that's called in the hot-add path:

  pciehp_configure_device
    pcie_bus_configure_settings
      pcie_find_smpss

so that's good.  I forgot that we had that path.

> > I think Common Clock Config also depends on characteristics of the
> > hot-added device, so we might need to take a look at that, too.
> 
> I think pcie_aspm_configure_common_clock() takes care of that already.
> It programs both ends of the link when a device is being added.

Yep, right.

> > If it turns out that we need to do more to the upstream bridge than
> > just this LTR thing, I wonder if we should pull it out to some kind of
> > "reconfig bridge" function so it's not buried in several random
> > places.
> 
> It seems that at the moment it is only the LTR thing that needs to be
> reconfigured as others looks like they are covered by their
> corresponding "enable" functions. Not sure if it is better to move those
> to "reconfig bridge" function because it might be harder to follow if it
> is not close to the code that enables the feature in the first place.
> 
> But I can do that if you still think it is better.

No, I don't think it's worth doing that.

Bjorn
