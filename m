Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9672F74D1
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jan 2021 10:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbhAOJCP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jan 2021 04:02:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:25111 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbhAOJCO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Jan 2021 04:02:14 -0500
IronPort-SDR: typwA+IYWS6VL3FcSKzILSf8HPgrpKrp0kvsrIgPJdJKFI5OKLeWoGivvt8TNULGU9FCckdJVi
 HQvuj3BPSm3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="178670986"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="178670986"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 01:00:27 -0800
IronPort-SDR: WLt1HcHdqScXiBAxBcUtqNktixeSahOXlMgOo2vZRDcmDiDpOs4y2drKKBMzB1EMZurmqqI2oy
 lrrIHvm/50Zg==
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="465526291"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 01:00:24 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 15 Jan 2021 11:00:21 +0200
Date:   Fri, 15 Jan 2021 11:00:21 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        linux-pci@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH] PCI: Re-enable downstream port LTR if it was previously
 enabled
Message-ID: <20210115090021.GC968855@lahna.fi.intel.com>
References: <20210114134724.79511-1-mika.westerberg@linux.intel.com>
 <20210115001007.GA2021499@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115001007.GA2021499@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Thu, Jan 14, 2021 at 06:10:07PM -0600, Bjorn Helgaas wrote:
> [+cc Puranjay]
> 
> On Thu, Jan 14, 2021 at 04:47:24PM +0300, Mika Westerberg wrote:
> > PCIe r5.0, sec 7.5.3.16 says that the downstream ports must reset the
> > LTR enable bit if the link goes down (port goes DL_Down status). Now, if
> > we had LTR previously enabled and the PCIe endpoint gets hot-removed and
> > then hot-added back the ->ltr_path of the downstream port is still set
> > but the port now does not have the LTR enable bit set anymore.
> 
> IIRC LTR is only needed for L1.2, and of course the LTR Capability
> (Max Snoop/No-Snoop Latency registers) and the L1 PM Substates
> Capability (LTR_L1.2_THRESHOLD) must be programmed before enabling
> LTR.  For the bridge, I guess we're assuming those were programmed
> before the hot-remove, and they remain valid after the hot-add.
> 
> But what about the endpoint that we hot-added?  How do we program its
> LTR and L1 PM Substates Capabilities?  I know we have
> aspm_calc_l1ss_info() for L1 PM Substates, but I really don't trust
> it, and I don't think we do anything at all to program the LTR
> Capability.

True - we don't. However, enabling the LTR bit here for the endpoint
(and for the bridges all the way up to the root port) makes the endpoint
to report that there is no LTR requirement and that allows the SoC to do
some PM optimizations or so.

We actually see that if this is not re-programmed like this on a Tiger
Lake based ChromeBook S0ix fails (S0ix is Intel low power idle state).

> I used to think the LTR _DSM was a way to help us program the LTR
> Capability, and Puranjay did a nice job implementing support for it
> [1].  But I now think that _DSM doesn't give us enough information
> (and of course it doesn't help at all for non-ACPI systems or for
> hierarchies not integrated on the system board), so I didn't merge
> Puranjay's work.
> 
> I tried to have some discussion in the PCI SIG about this, but it
> never really went anywhere.  Here's my basic question, just for the
> archives:
> 
>   I think the LTR capability Max Snoop registers could also use some
>   clarification.  The base spec says "Software should set this to the
>   platform's maximum supported latency or less."  I assume this
>   platform data is supposed to come from the ACPI LTR _DSM.  The
>   firmware spec says software should sum the latencies along the path
>   between each downstream port (I wonder if this should say "Root
>   Port"?) and an endpoint that supports LTR.  Switches not embedded in
>   the platform will not have this _DSM, but I assume they contribute
>   to this sum.  But I don't know *what* they contribute.
> 

That's a fair question :)

I personally think that the driver for the specific hardware should know
what is the latency tolerance for the device when it is doing different
"tasks".

> > For this reason check if the bridge upstrea had LTR enabled set
> > previously and re-enable it before enabling LTR for the endpoint.
> 
> s/upstrea/upstream/
> s/enabled set/enabled/

Thanks, I'll fix those.

> Seems like there could be more things in the upstream bridge that need
> to be reprogrammed when the link comes back up (MPS, Common Clock
> Configuration, etc?).
> 
> I don't see anything in the spec about link status affecting MPS, but
> if we hot-removed a device that supported 4KB MPS and hot-added one
> that only support 128B, we might need more extensive reconfiguration.
> I haven't checked; maybe that's already covered?

It looks like that's covered in pcie_find_smpss(). It limits the MPS to
128 if there are hotplug bridges in the topology. Assuming I read it
correctly.

> I think Common Clock Config also depends on characteristics of the
> hot-added device, so we might need to take a look at that, too.

I think pcie_aspm_configure_common_clock() takes care of that already.
It programs both ends of the link when a device is being added.

> If it turns out that we need to do more to the upstream bridge than
> just this LTR thing, I wonder if we should pull it out to some kind of
> "reconfig bridge" function so it's not buried in several random
> places.

It seems that at the moment it is only the LTR thing that needs to be
reconfigured as others looks like they are covered by their
corresponding "enable" functions. Not sure if it is better to move those
to "reconfig bridge" function because it might be harder to follow if it
is not close to the code that enables the feature in the first place.

But I can do that if you still think it is better.

> [1] https://lore.kernel.org/r/20201015080311.7811-1-puranjay12@gmail.com
> 
> > Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/pci/probe.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 0eb68b47354f..cd174e06f46f 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2153,7 +2153,7 @@ static void pci_configure_ltr(struct pci_dev *dev)
> >  {
> >  #ifdef CONFIG_PCIEASPM
> >  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> > -	struct pci_dev *bridge;
> > +	struct pci_dev *bridge = NULL;
> >  	u32 cap, ctl;
> >  
> >  	if (!pci_is_pcie(dev))
> > @@ -2191,6 +2191,21 @@ static void pci_configure_ltr(struct pci_dev *dev)
> >  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> >  	    ((bridge = pci_upstream_bridge(dev)) &&
> >  	      bridge->ltr_path)) {
> > +		/*
> > +		 * Downstream ports reset the LTR enable bit when the
> > +		 * link goes down (e.g on hot-remove) so re-enable the
> > +		 * bit here if not set anymore.
> > +		 * PCIe r5.0, sec 7.5.3.16.
> > +		 */
> > +		if (bridge && pcie_downstream_port(bridge)) {
> 
> Why test for pcie_downstream_port(bridge) here?  "dev" is a PCIe
> device, and "bridge" is a PCI device leading to "dev".  I think the
> only possibilities are that "bridge" is a root port, a switch
> downstream port, or a PCI-to-PCIe bridge, i.e., exactly what
> pcie_downstream_port() tests for.

Good point that check is not needed. I'll remove it.

> > +			pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2, &ctl);
> > +			if (!(ctl & PCI_EXP_DEVCTL2_LTR_EN)) {
> > +				pci_dbg(bridge, "re-enabling LTR\n");
> > +				pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
> > +							 PCI_EXP_DEVCTL2_LTR_EN);
> > +			}
> > +		}
> > +		pci_dbg(dev, "enabling LTR\n");
> >  		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
> >  					 PCI_EXP_DEVCTL2_LTR_EN);
> >  		dev->ltr_path = 1;
> > -- 
> > 2.29.2
> > 
