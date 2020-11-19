Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFCC2B8C95
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 08:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgKSHvY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 02:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgKSHvY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2020 02:51:24 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34012C0613CF
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2020 23:51:24 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 69A6C280052F9;
        Thu, 19 Nov 2020 08:51:16 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4016222EA8D; Thu, 19 Nov 2020 08:51:20 +0100 (CET)
Date:   Thu, 19 Nov 2020 08:51:20 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pci: pciehp: Handle MRL interrupts to enable slot
 for hotplug.
Message-ID: <20201119075120.GA542@wunner.de>
References: <20200925230138.29011-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925230138.29011-1-ashok.raj@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ashok,

my sincere apologies for the delay.

On Fri, Sep 25, 2020 at 04:01:38PM -0700, Ashok Raj wrote:
> When Mechanical Retention Lock (MRL) is present, Linux doesn't process
> those change events.
> 
> The following changes need to be enabled when MRL is present.
> 
> 1. Subscribe to MRL change events in SlotControl.
> 2. When MRL is closed,
>    - If there is no ATTN button, then POWER on the slot.
>    - If there is ATTN button, and an MRL event pending, ignore
>      Presence Detect. Since we want ATTN button to drive the
>      hotplug event.

So I understand you have a hardware platform which has both MRL and
Attention Button on its hotplug slots?  It may be useful to name the
hardware platform in the commit message.

If an Attention Button is present, the current behavior is to bring up
the hotplug slot as soon as presence or link is detected.  We don't wait
for a button press.  This is intended as a convience feature to bring up
slots as quickly as possible, but the behavior can be changed if the
button press and 5 second delay is preferred.

In any case the behavior in response to an Attention Button press should
be the same regardless whether an MRL is present or not.  (The spec
doesn't seem to say otherwise.)


> +		if (MRL_SENS(ctrl)) {
> +			pciehp_get_latch_status(ctrl, &getstatus);
> +			/*
> +			 * If slot is closed && ATTN button exists
> +			 * don't continue, let the ATTN button
> +			 * drive the hot-plug
> +			 */
> +			if (!getstatus && ATTN_BUTTN(ctrl))
> +				return;
> +		}

For the sake of readability I'd suggest adding a pciehp_latch_closed()
helper similar to pciehp_card_present_or_link_active() which returns
true if no MRL is present (i.e. !MRL_SENS(ctrl)), otherwise retrieves
and returns the status with pciehp_get_latch_status().


> +void pciehp_handle_mrl_change(struct controller *ctrl)
> +{
> +	u8 getstatus = 0;
> +	int present, link_active;
> +
> +	pciehp_get_latch_status(ctrl, &getstatus);
> +
> +	present = pciehp_card_present(ctrl);
> +	link_active = pciehp_check_link_active(ctrl);
> +
> +	ctrl_info(ctrl, "Slot(%s): Card %spresent\n",
> +		  slot_name(ctrl), present ? "" : "not ");
> +
> +	ctrl_info(ctrl, "Slot(%s): Link %s\n",
> +		  slot_name(ctrl), link_active ? "Up" : "Down");

This duplicates a lot of code from pciehp_handle_presence_or_link_change(),
which I think suggests handling MRL events in that function.  After all,
an MRL event may lead to bringup or bringdown of a slot similar to
a link or presence event.

Basically pciehp_handle_presence_or_link_change() just needs to be
amended to bring down the slot if an MRL event occurred, and
afterwards only bring up the slot if MRL is closed.  Like this:

-	if (present <= 0 && link_active <= 0) {
+	if ((present <= 0 && link_active <= 0) || !latch_closed) {
		mutex_unlock(&ctrl->state_lock);
		return;
	}


> +	/*
> +	 * Need to handle only MRL Open. When MRL is closed with
> +	 * a Card Present, either the ATTN button, or the PDC indication
> +	 * should power the slot and add the card in the slot
> +	 */

I agree with the second sentence.  You may want to refer to PCIe Base Spec
r4.0, section 6.7.1.3 either in the commit message or a code comment,
which says:

"If an MRL Sensor is implemented without a corresponding MRL Sensor input
on the Hot-Plug Controller, it is recommended that the MRL Sensor be
routed to power fault input of the Hot-Plug Controller.
This allows an active adapter to be powered off when the MRL is opened."

This seems to suggest that the slot should be brought down as soon as MRL
is opened.


> +	/*
> +	 * If MRL is triggered, if ATTN button exists, ignore the event.
> +	 */
> +	if (ATTN_BUTTN(ctrl) && (events & PCI_EXP_SLTSTA_MRLSC))
> +		events &= ~PCI_EXP_SLTSTA_PDC;

Hm, the spec doesn't seem to imply a connection between presence of
an MRL and presence of an Attention Button, so I find this confusing.


> +	/*
> +	 * If ATTN is present and MRL is triggered
> +	 * ignore the Presence Change Event.
> +	 */
> +	if (ATTN_BUTTN(ctrl) && (events & PCI_EXP_SLTSTA_MRLSC))
> +		events &= ~PCI_EXP_SLTSTA_PDC;

An Attention Button press results in a synthesized PDC event after
5 seconds, which may get lost due to the above if-statement.

Thanks,

Lukas
