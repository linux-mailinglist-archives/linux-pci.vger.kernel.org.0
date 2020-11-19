Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3872B9D63
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 23:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgKSWIJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 17:08:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:11216 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgKSWIJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 17:08:09 -0500
IronPort-SDR: IPMIicnUVjrpYpewlbPSHMay3Oc85cUhK4OvM6zihdH24UYoaesOgJIlFuXxrYFCKjmht4sN2F
 xdzh6teFTt5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="170592550"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="170592550"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 14:08:09 -0800
IronPort-SDR: j6vcc1RP9WQOlPo7lSgSezcUlpAkgQtucdHVTA5GVwQ18vpSEUAXlsVlVbgZ5NGsS6h5WMc0g3
 F/2j6SOcXW0A==
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="341842084"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 14:08:08 -0800
Date:   Thu, 19 Nov 2020 14:08:07 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 1/1] pci: pciehp: Handle MRL interrupts to enable slot
 for hotplug.
Message-ID: <20201119220807.GB102444@otc-nc-03>
References: <20200925230138.29011-1-ashok.raj@intel.com>
 <20201119075120.GA542@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119075120.GA542@wunner.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 19, 2020 at 08:51:20AM +0100, Lukas Wunner wrote:
> Hi Ashok,
> 
> my sincere apologies for the delay.

No worries.. 

> 
> On Fri, Sep 25, 2020 at 04:01:38PM -0700, Ashok Raj wrote:
> > When Mechanical Retention Lock (MRL) is present, Linux doesn't process
> > those change events.
> > 
> > The following changes need to be enabled when MRL is present.
> > 
> > 1. Subscribe to MRL change events in SlotControl.
> > 2. When MRL is closed,
> >    - If there is no ATTN button, then POWER on the slot.
> >    - If there is ATTN button, and an MRL event pending, ignore
> >      Presence Detect. Since we want ATTN button to drive the
> >      hotplug event.
> 
> So I understand you have a hardware platform which has both MRL and
> Attention Button on its hotplug slots?  It may be useful to name the
> hardware platform in the commit message.

I should, let me find out the exact intercept and include it next.

> 
> If an Attention Button is present, the current behavior is to bring up
> the hotplug slot as soon as presence or link is detected.  We don't wait
> for a button press.  This is intended as a convience feature to bring up
> slots as quickly as possible, but the behavior can be changed if the
> button press and 5 second delay is preferred.

No personal preference, I thought that is how the code in Linux was
earlier.

Looks like we still don't subscribe to PDC if ATTN is present? So you don't
get an event until someone presses the button to process hotplug right?

pciehp_hpc.c:pcie_enable_notification()
{
....

         * Always enable link events: thus link-up and link-down shall
         * always be treated as hotplug and unplug respectively. Enable
         * presence detect only if Attention Button is not present.
         */ 
        cmd = PCI_EXP_SLTCTL_DLLSCE;
        if (ATTN_BUTTN(ctrl))
                cmd |= PCI_EXP_SLTCTL_ABPE;
        else
                cmd |= PCI_EXP_SLTCTL_PDCE;
....
}


Looks like we still wait for button press to process. When you don't have a
power control yes the DLLSC would kick in and we would process them. but if
you have power control, you won't turn on until the button press?

> 
> In any case the behavior in response to an Attention Button press should
> be the same regardless whether an MRL is present or not.  (The spec
> doesn't seem to say otherwise.)

True, Looks like that is a Linux behavior, certainly not a spec
recommendation. Our validation teams tell Windows also behaves such. i.e
when ATTN exists button press drivers the hot-add. Linux doesn't need to
follow suite though. 

In that case do we need to subscribe to PDC even when ATTN is present?

> 
> 
> > +		if (MRL_SENS(ctrl)) {
> > +			pciehp_get_latch_status(ctrl, &getstatus);
> > +			/*
> > +			 * If slot is closed && ATTN button exists
> > +			 * don't continue, let the ATTN button
> > +			 * drive the hot-plug
> > +			 */
> > +			if (!getstatus && ATTN_BUTTN(ctrl))
> > +				return;
> > +		}
> 
> For the sake of readability I'd suggest adding a pciehp_latch_closed()
> helper similar to pciehp_card_present_or_link_active() which returns
> true if no MRL is present (i.e. !MRL_SENS(ctrl)), otherwise retrieves
> and returns the status with pciehp_get_latch_status().

Makes sense.. I can add that.

> 
> 
> > +void pciehp_handle_mrl_change(struct controller *ctrl)
> > +{
> > +	u8 getstatus = 0;
> > +	int present, link_active;
> > +
> > +	pciehp_get_latch_status(ctrl, &getstatus);
> > +
> > +	present = pciehp_card_present(ctrl);
> > +	link_active = pciehp_check_link_active(ctrl);
> > +
> > +	ctrl_info(ctrl, "Slot(%s): Card %spresent\n",
> > +		  slot_name(ctrl), present ? "" : "not ");
> > +
> > +	ctrl_info(ctrl, "Slot(%s): Link %s\n",
> > +		  slot_name(ctrl), link_active ? "Up" : "Down");
> 
> This duplicates a lot of code from pciehp_handle_presence_or_link_change(),
> which I think suggests handling MRL events in that function.  After all,
> an MRL event may lead to bringup or bringdown of a slot similar to
> a link or presence event.
> 
> Basically pciehp_handle_presence_or_link_change() just needs to be
> amended to bring down the slot if an MRL event occurred, and
> afterwards only bring up the slot if MRL is closed.  Like this:
> 
> -	if (present <= 0 && link_active <= 0) {
> +	if ((present <= 0 && link_active <= 0) || !latch_closed) {

Certainly looks like good simplication. I'll change and have a test run.

> 		mutex_unlock(&ctrl->state_lock);
> 		return;
> 	}
> 
> 
> > +	/*
> > +	 * Need to handle only MRL Open. When MRL is closed with
> > +	 * a Card Present, either the ATTN button, or the PDC indication
> > +	 * should power the slot and add the card in the slot
> > +	 */
> 
> I agree with the second sentence.  You may want to refer to PCIe Base Spec
> r4.0, section 6.7.1.3 either in the commit message or a code comment,
> which says:
> 
> "If an MRL Sensor is implemented without a corresponding MRL Sensor input
> on the Hot-Plug Controller, it is recommended that the MRL Sensor be
> routed to power fault input of the Hot-Plug Controller.
> This allows an active adapter to be powered off when the MRL is opened."
> 
> This seems to suggest that the slot should be brought down as soon as MRL
> is opened.

Good for commit log. I'll add a pointer in code comments too. Rarely people
go to commit log :-)

> 
> 
> > +	/*
> > +	 * If MRL is triggered, if ATTN button exists, ignore the event.
> > +	 */
> > +	if (ATTN_BUTTN(ctrl) && (events & PCI_EXP_SLTSTA_MRLSC))
> > +		events &= ~PCI_EXP_SLTSTA_PDC;
> 
> Hm, the spec doesn't seem to imply a connection between presence of
> an MRL and presence of an Attention Button, so I find this confusing.

This isn't spec required. But to enforce the earlier behavior that only
ATTN drives the hot-add event. Sometimes you close the MRL, even if you
didn't subscribe for notification of PDC, the bit is set and
un-intentionally acted upon. If the event wasn't subscribed for to start
with PDC getting pulled in is a side effect of the MRL. 

Validation folks look for consistency :-).. so this was mostly to enforce
that.

> 
> 
> > +	/*
> > +	 * If ATTN is present and MRL is triggered
> > +	 * ignore the Presence Change Event.
> > +	 */
> > +	if (ATTN_BUTTN(ctrl) && (events & PCI_EXP_SLTSTA_MRLSC))
> > +		events &= ~PCI_EXP_SLTSTA_PDC;
> 
> An Attention Button press results in a synthesized PDC event after
> 5 seconds, which may get lost due to the above if-statement.

When its synthesized you don't get the MRLSC? So we won't nuke the PDC then
correct?

Cheers,
Ashok
