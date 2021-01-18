Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1212FA09D
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jan 2021 14:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391770AbhARNBA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 08:01:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:42559 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391959AbhARNAM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jan 2021 08:00:12 -0500
IronPort-SDR: 0aPJczm8/RATZgD3xOOVhTHOgj3eOqKe/1qqKWGsADNX0d1vbT1kZrKRJk/Z8mvX2e1Qo+amqC
 04rBY//zG1Sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="178948943"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="178948943"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 04:58:14 -0800
IronPort-SDR: cJg6YwWKCAIOfTNVMd2W93hqStndq8aETTQYkJgq7RDpfGCBRjybt74WWmGIr035+ZNg780Gc7
 NSvm5/FhvBGA==
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="383562184"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 04:58:11 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 18 Jan 2021 14:58:09 +0200
Date:   Mon, 18 Jan 2021 14:58:09 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        linux-pci@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH] PCI: Re-enable downstream port LTR if it was previously
 enabled
Message-ID: <20210118125809.GO968855@lahna.fi.intel.com>
References: <20210115090021.GC968855@lahna.fi.intel.com>
 <20210116003606.GA2136097@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116003606.GA2136097@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 15, 2021 at 06:36:06PM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 15, 2021 at 11:00:21AM +0200, Mika Westerberg wrote:
> > On Thu, Jan 14, 2021 at 06:10:07PM -0600, Bjorn Helgaas wrote:
> > > On Thu, Jan 14, 2021 at 04:47:24PM +0300, Mika Westerberg wrote:
> > > > PCIe r5.0, sec 7.5.3.16 says that the downstream ports must reset the
> > > > LTR enable bit if the link goes down (port goes DL_Down status). Now, if
> > > > we had LTR previously enabled and the PCIe endpoint gets hot-removed and
> > > > then hot-added back the ->ltr_path of the downstream port is still set
> > > > but the port now does not have the LTR enable bit set anymore.
> > > 
> > > IIRC LTR is only needed for L1.2, and of course the LTR Capability
> > > (Max Snoop/No-Snoop Latency registers) and the L1 PM Substates
> > > Capability (LTR_L1.2_THRESHOLD) must be programmed before enabling
> > > LTR.  For the bridge, I guess we're assuming those were programmed
> > > before the hot-remove, and they remain valid after the hot-add.
> > > 
> > > But what about the endpoint that we hot-added?  How do we program its
> > > LTR and L1 PM Substates Capabilities?  I know we have
> > > aspm_calc_l1ss_info() for L1 PM Substates, but I really don't trust
> > > it, and I don't think we do anything at all to program the LTR
> > > Capability.
> > 
> > True - we don't. However, enabling the LTR bit here for the endpoint
> > (and for the bridges all the way up to the root port) makes the endpoint
> > to report that there is no LTR requirement and that allows the SoC to do
> > some PM optimizations or so.
> > 
> > We actually see that if this is not re-programmed like this on a Tiger
> > Lake based ChromeBook S0ix fails (S0ix is Intel low power idle state).
> 
> So if we set PCI_EXP_DEVCTL2_LTR_EN for the bridge and also for the
> hot-added endpoint, S0ix works.  But we never get to the S0ix state if
> we don't set those bits?

Yes, correct.

> And we never actually set the Max Snoop/No-Snoop Latency registers in
> the LTR Capability, so they should power up as zeroes.  IIRC, that is
> the most conservative setting (PCIe r5.0, sec 6.18 says "all 0's
> indicates that the device will be impacted by any delay and that the
> best possible service is requested").
> 
> So I *guess* it makes some sort of sense to enable LTR in that
> situation, although I wish we could set the content of the messages
> before enabling them.

Right.

We actually have a bus agnostic API for that in PM QoS that requires the
PCI core to implement dev->power.set_latency_tolerance() and then
drivers can take advantage of this. However, it does not make much sense
to implement it without an actual user (driver).

> > > I used to think the LTR _DSM was a way to help us program the LTR
> > > Capability, and Puranjay did a nice job implementing support for it
> > > [1].  But I now think that _DSM doesn't give us enough information
> > > (and of course it doesn't help at all for non-ACPI systems or for
> > > hierarchies not integrated on the system board), so I didn't merge
> > > Puranjay's work.
> > > 
> > > I tried to have some discussion in the PCI SIG about this, but it
> > > never really went anywhere.  Here's my basic question, just for the
> > > archives:
> > > 
> > >   I think the LTR capability Max Snoop registers could also use some
> > >   clarification.  The base spec says "Software should set this to the
> > >   platform's maximum supported latency or less."  I assume this
> > >   platform data is supposed to come from the ACPI LTR _DSM.  The
> > >   firmware spec says software should sum the latencies along the path
> > >   between each downstream port (I wonder if this should say "Root
> > >   Port"?) and an endpoint that supports LTR.  Switches not embedded in
> > >   the platform will not have this _DSM, but I assume they contribute
> > >   to this sum.  But I don't know *what* they contribute.
> > > 
> > 
> > That's a fair question :)
> > 
> > I personally think that the driver for the specific hardware should know
> > what is the latency tolerance for the device when it is doing different
> > "tasks".
> > 
> > > > For this reason check if the bridge upstrea had LTR enabled set
> > > > previously and re-enable it before enabling LTR for the endpoint.
> > > 
> > > s/upstrea/upstream/
> > > s/enabled set/enabled/
> > 
> > Thanks, I'll fix those.
> > 
> > > Seems like there could be more things in the upstream bridge that need
> > > to be reprogrammed when the link comes back up (MPS, Common Clock
> > > Configuration, etc?).
> > > 
> > > I don't see anything in the spec about link status affecting MPS, but
> > > if we hot-removed a device that supported 4KB MPS and hot-added one
> > > that only support 128B, we might need more extensive reconfiguration.
> > > I haven't checked; maybe that's already covered?
> > 
> > It looks like that's covered in pcie_find_smpss(). It limits the MPS to
> > 128 if there are hotplug bridges in the topology. Assuming I read it
> > correctly.
> 
> OK, and it looks like that's called in the hot-add path:
> 
>   pciehp_configure_device
>     pcie_bus_configure_settings
>       pcie_find_smpss
> 
> so that's good.  I forgot that we had that path.
> 
> > > I think Common Clock Config also depends on characteristics of the
> > > hot-added device, so we might need to take a look at that, too.
> > 
> > I think pcie_aspm_configure_common_clock() takes care of that already.
> > It programs both ends of the link when a device is being added.
> 
> Yep, right.
> 
> > > If it turns out that we need to do more to the upstream bridge than
> > > just this LTR thing, I wonder if we should pull it out to some kind of
> > > "reconfig bridge" function so it's not buried in several random
> > > places.
> > 
> > It seems that at the moment it is only the LTR thing that needs to be
> > reconfigured as others looks like they are covered by their
> > corresponding "enable" functions. Not sure if it is better to move those
> > to "reconfig bridge" function because it might be harder to follow if it
> > is not close to the code that enables the feature in the first place.
> > 
> > But I can do that if you still think it is better.
> 
> No, I don't think it's worth doing that.

OK, thanks.
