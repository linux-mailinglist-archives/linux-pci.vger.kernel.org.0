Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8542BC498
	for <lists+linux-pci@lfdr.de>; Sun, 22 Nov 2020 10:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgKVJI6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Nov 2020 04:08:58 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:51837 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKVJI6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Nov 2020 04:08:58 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 00E7B100E417C;
        Sun, 22 Nov 2020 10:08:51 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4D14923339E; Sun, 22 Nov 2020 10:08:52 +0100 (CET)
Date:   Sun, 22 Nov 2020 10:08:52 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 1/1] PCI: pciehp: Add support for handling MRL events
Message-ID: <20201122090852.GA29616@wunner.de>
References: <20201122014203.4706-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122014203.4706-1-ashok.raj@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 21, 2020 at 05:42:03PM -0800, Ashok Raj wrote:
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>  void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  {
>  	int present, link_active;
> +	u8 getstatus = 0;
>  
>  	/*
>  	 * If the slot is on and presence or link has changed, turn it off.
> @@ -246,6 +259,20 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  		if (events & PCI_EXP_SLTSTA_PDC)
>  			ctrl_info(ctrl, "Slot(%s): Card not present\n",
>  				  slot_name(ctrl));
> +		if (events & PCI_EXP_SLTSTA_MRLSC)
> +			ctrl_info(ctrl, "Slot(%s): Latch %s\n",
> +				  slot_name(ctrl), getstatus ? "Open" : "Closed");

This message will currently always be "Latch closed".  It should be
"Latch open" instead because if the slot was up, the latch must have
been closed.  So an MRLSC event can only mean that the latch is now open.
The "getstatus" variable can be removed.


> +		/*
> +		 * PCIe Base Spec 5.0 Chapter 6.7.1.3 states.
> +		 *
> +		 * If an MRL Sensor is implemented without a corresponding MRL Sensor input
> +		 * on the Hot-Plug Controller, it is recommended that the MRL Sensor be
> +		 * routed to power fault input of the Hot-Plug Controller.
> +		 * This allows an active adapter to be powered off when the MRL is opened."
> +		 *
> +		 * This seems to suggest that the slot should be brought down as soon as MRL
> +		 * is opened.
> +		 */
>  		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
>  		break;

The code comment is not wrapped at 80 chars and a bit long.
I'd move it to the commit message and keep only a shortened version here.

The "SURPRISE_REMOVAL" may now be problematic because the card may still
be in the slot (both presence and link still up) with only the MRL open.
My suggestion would be to add a local variable "bool safe_removal"
which is initialized to "SAFE_REMOVAL".  In the two if-clauses for
DLLSC and PDC, it is set to SURPRISE_REMOVAL.


> @@ -275,6 +302,13 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  		if (link_active)
>  			ctrl_info(ctrl, "Slot(%s): Link Up\n",
>  				  slot_name(ctrl));
> +		/*
> +		 * If slot is closed && ATTN button exists
> +		 * don't continue, let the ATTN button
> +		 * drive the hot-plug
> +		 */
> +		if (((events & PCI_EXP_SLTSTA_MRLSC) && ATTN_BUTTN(ctrl)))
> +			return;
>  		ctrl->request_result = pciehp_enable_slot(ctrl);
>  		break;

Hm, if the Attention Button is pressed with MRL still open, the slot is
not brought up.  If the MRL is subsequently closed, it is still not
brought up.  I guess the slot keeps blinking and one has to push the
button to abort the operation, then press it once more to attempt
another slot bringup.  The spec doesn't seem to say how such a situation
should be handled. Oh well.

I'm wondering if this is the right place to bail out:  Immediately
before the above hunk, the button_work is canceled, so it can't later
trigger bringup of the slot.  Shouldn't the above check be in the
code block with the "Turn the slot on if it's occupied or link is up"
comment?

You're also not unlocking the state_lock here before bailing out of
the function.


> @@ -710,8 +710,10 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>  	down_read(&ctrl->reset_lock);
>  	if (events & DISABLE_SLOT)
>  		pciehp_handle_disable_request(ctrl);
> -	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
> +	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC |
> +			   PCI_EXP_SLTSTA_MRLSC))
>  		pciehp_handle_presence_or_link_change(ctrl, events);
> +
>  	up_read(&ctrl->reset_lock);

Unnecessary newline added.


> @@ -768,6 +770,14 @@ static void pcie_enable_notification(struct controller *ctrl)
>  		cmd |= PCI_EXP_SLTCTL_ABPE;
>  	else
>  		cmd |= PCI_EXP_SLTCTL_PDCE;
> +
> +	/*
> +	 * If MRL sensor is present, then subscribe for MRL
> +	 * Changes to be notified as well.
> +	 */
> +	if (MRL_SENS(ctrl))
> +		cmd |= PCI_EXP_SLTCTL_MRLSCE;
> +

The code comment doesn't add much information, so can probably be
dropped.

You need to add PCI_EXP_SLTCTL_MRLSCE to the "mask" variable in this
function (before PFDE, as in pcie_disable_notification()).
I don't think the interrupt is enabled at all if it's not added to
"mask", has this patch been tested at all?

Something else:  When pciehp probes, it should check whether the slot
is up even though MRL is open.  (E.g. the machine is booted, the card
in the slot was enumerated but the latch is open.)  I think in that
case we need to bring down the slot.  I suggest adding a check to
pciehp_check_presence() whether the latch is open.  If so,
a PCI_EXP_SLTSTA_MRLSC event should be synthesized.  You could rename
the latch_closed() function to pciehp_latch_closed() and remove its
"static" attribute so that you can call it from pciehp_core.c.

Thanks,

Lukas
