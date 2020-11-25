Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27D22C4ADA
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 23:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgKYWkD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 17:40:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:58181 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgKYWkD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 17:40:03 -0500
IronPort-SDR: WzOLzb6YeI+2lSt6k3BJiYm+5Kne8rJlBs7Or0vxvuNkIObwYuiphktHArH2bUZLHjOC7f5XKA
 OcfAfy9SykHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="172309031"
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="172309031"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 14:40:01 -0800
IronPort-SDR: OcUNuP796ecCL5cwzrtyZLX0AlC4gTKuLzOCkM0SK2BqG74Agr7uDW7S8WUUGy8smLUUtV6mXA
 6Ngvt4rH29nA==
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="333162799"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 14:40:01 -0800
Date:   Wed, 25 Nov 2020 14:40:00 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch v2 1/1] PCI: pciehp: Add support for handling MRL events
Message-ID: <20201125224000.GA53750@otc-nc-03>
References: <20201122014203.4706-1-ashok.raj@intel.com>
 <20201122090852.GA29616@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122090852.GA29616@wunner.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas

On Sun, Nov 22, 2020 at 10:08:52AM +0100, Lukas Wunner wrote:
> On Sat, Nov 21, 2020 at 05:42:03PM -0800, Ashok Raj wrote:
> > --- a/drivers/pci/hotplug/pciehp_ctrl.c
> > +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> >  void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
> >  {
> >  	int present, link_active;
> > +	u8 getstatus = 0;
> >  
> >  	/*
> >  	 * If the slot is on and presence or link has changed, turn it off.
> > @@ -246,6 +259,20 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
> >  		if (events & PCI_EXP_SLTSTA_PDC)
> >  			ctrl_info(ctrl, "Slot(%s): Card not present\n",
> >  				  slot_name(ctrl));
> > +		if (events & PCI_EXP_SLTSTA_MRLSC)
> > +			ctrl_info(ctrl, "Slot(%s): Latch %s\n",
> > +				  slot_name(ctrl), getstatus ? "Open" : "Closed");
> 
> This message will currently always be "Latch closed".  It should be
> "Latch open" instead because if the slot was up, the latch must have
> been closed.  So an MRLSC event can only mean that the latch is now open.
> The "getstatus" variable can be removed.

We only report if there was an MRLSC event. What if there is a link event,
but MRL is closed? This just reflects current state rather than hardcoding
a value which could be wrong in cases where you try to remove due to DLLSC
event?

> 
> 
> > +		/*
> > +		 * PCIe Base Spec 5.0 Chapter 6.7.1.3 states.
> > +		 *
> > +		 * If an MRL Sensor is implemented without a corresponding MRL Sensor input
> > +		 * on the Hot-Plug Controller, it is recommended that the MRL Sensor be
> > +		 * routed to power fault input of the Hot-Plug Controller.
> > +		 * This allows an active adapter to be powered off when the MRL is opened."
> > +		 *
> > +		 * This seems to suggest that the slot should be brought down as soon as MRL
> > +		 * is opened.
> > +		 */
> >  		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
> >  		break;
> 
> The code comment is not wrapped at 80 chars and a bit long.
> I'd move it to the commit message and keep only a shortened version here.

Make sense. I'll clean this up.
> 
> The "SURPRISE_REMOVAL" may now be problematic because the card may still
> be in the slot (both presence and link still up) with only the MRL open.
> My suggestion would be to add a local variable "bool safe_removal"
> which is initialized to "SAFE_REMOVAL".  In the two if-clauses for
> DLLSC and PDC, it is set to SURPRISE_REMOVAL.

I see, so for MRL we want to treat it as safe-removal, for other two its
surprise. Got it.

> 
> 
> > @@ -275,6 +302,13 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
> >  		if (link_active)
> >  			ctrl_info(ctrl, "Slot(%s): Link Up\n",
> >  				  slot_name(ctrl));
> > +		/*
> > +		 * If slot is closed && ATTN button exists
> > +		 * don't continue, let the ATTN button
> > +		 * drive the hot-plug
> > +		 */
> > +		if (((events & PCI_EXP_SLTSTA_MRLSC) && ATTN_BUTTN(ctrl)))
> > +			return;
> >  		ctrl->request_result = pciehp_enable_slot(ctrl);
> >  		break;
> 
> Hm, if the Attention Button is pressed with MRL still open, the slot is
> not brought up.  If the MRL is subsequently closed, it is still not
> brought up.  I guess the slot keeps blinking and one has to push the
> button to abort the operation, then press it once more to attempt
> another slot bringup.  The spec doesn't seem to say how such a situation
> should be handled. Oh well.

Looks like we are in the same boat today even without MRL. If no card in
slot and someone presses ATTN, after 5 sec blink, we call the synthetic PDC
event. But the check for present || link_active would fail and return
immediately. So the light would keep blinking until someone presses ATTN to
cancel?

Maybe in that we should simply cancel if it was blinking before we return?

> 
> I'm wondering if this is the right place to bail out:  Immediately
> before the above hunk, the button_work is canceled, so it can't later
> trigger bringup of the slot.  Shouldn't the above check be in the
> code block with the "Turn the slot on if it's occupied or link is up"
> comment?

Or maybe remove the check !latch_closed(ctrl), and let if fall through
anyway. 
> 
> You're also not unlocking the state_lock here before bailing out of
> the function.
> 
> 
> > @@ -710,8 +710,10 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
> >  	down_read(&ctrl->reset_lock);
> >  	if (events & DISABLE_SLOT)
> >  		pciehp_handle_disable_request(ctrl);
> > -	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
> > +	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC |
> > +			   PCI_EXP_SLTSTA_MRLSC))
> >  		pciehp_handle_presence_or_link_change(ctrl, events);
> > +
> >  	up_read(&ctrl->reset_lock);
> 
> Unnecessary newline added.

Will remove.

> 
> 
> > @@ -768,6 +770,14 @@ static void pcie_enable_notification(struct controller *ctrl)
> >  		cmd |= PCI_EXP_SLTCTL_ABPE;
> >  	else
> >  		cmd |= PCI_EXP_SLTCTL_PDCE;
> > +
> > +	/*
> > +	 * If MRL sensor is present, then subscribe for MRL
> > +	 * Changes to be notified as well.
> > +	 */
> > +	if (MRL_SENS(ctrl))
> > +		cmd |= PCI_EXP_SLTCTL_MRLSCE;
> > +
> 
> The code comment doesn't add much information, so can probably be
> dropped.

Make sense.

> 
> You need to add PCI_EXP_SLTCTL_MRLSCE to the "mask" variable in this
> function (before PFDE, as in pcie_disable_notification()).
> I don't think the interrupt is enabled at all if it's not added to
> "mask", has this patch been tested at all?

The first patch was tested, but I didn't have that in the mask variable
even then. 

> 
> Something else:  When pciehp probes, it should check whether the slot
> is up even though MRL is open.  (E.g. the machine is booted, the card
> in the slot was enumerated but the latch is open.)  I think in that
> case we need to bring down the slot.  I suggest adding a check to
> pciehp_check_presence() whether the latch is open.  If so,
> a PCI_EXP_SLTSTA_MRLSC event should be synthesized.  You could rename
> the latch_closed() function to pciehp_latch_closed() and remove its
> "static" attribute so that you can call it from pciehp_core.c.

Good point. I missed that. I'll have another version spun after a test.

-- 
Cheers,
Ashok

[Forgiveness is the attribute of the STRONG - Gandhi]
