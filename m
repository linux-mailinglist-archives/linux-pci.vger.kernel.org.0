Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99886196D68
	for <lists+linux-pci@lfdr.de>; Sun, 29 Mar 2020 14:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgC2Mgq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Mar 2020 08:36:46 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:37407 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgC2Mgq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Mar 2020 08:36:46 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 3E07E2800A26D;
        Sun, 29 Mar 2020 14:36:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E29DF1D1; Sun, 29 Mar 2020 14:36:43 +0200 (CEST)
Date:   Sun, 29 Mar 2020 14:36:43 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Don't enable slot unless link or presence up
Message-ID: <20200329123643.eeqervkxcxzc3kjn@wunner.de>
References: <20200310182100.102987-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310182100.102987-1-stuart.w.hayes@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 10, 2020 at 01:21:00PM -0500, Stuart Hayes wrote:
> When a pciehp slot is powered down via /sys/bus/pci/slots/<slot>/power,
> and then the card is physically removed, the kernel will sometimes try to
> enable the slot as the card is removed, which results in an error in the
> kernel log.
> 
> This can happen if the presence detect and link active bits don't go down
> at the exact same time. When the card is disabled via /sys/.../power, the
> card is placed in OFF_STATE, but the presence detect and link active bits
> can still be up.  Then, when, say, presence detect goes down, an interrupt
> reports that the presence detect has changed, and the code in
> pciehp_handle_presence_or_link_change() will see that the link is up
> (because it hasn't gone down yet), and it will try to enable the slot.
> 
> This patch modifies that code so it won't try to enable a slot in OFF_STATE
> unless it sees the presence detect changed bit with presence detect active,
> or the link status changed bit with an active link. This will prevent the
> unwanted attempts to enable a card that's being removed, but will still
> allow the slot to come up if the slot is re-enabled by writing to
> /sys/.../power, or if a new card is added to the slot.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 6503d15effbb..f6cbf21711e0 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -267,16 +267,20 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  		cancel_delayed_work(&ctrl->button_work);
>  		/* fall through */
>  	case OFF_STATE:
> -		ctrl->state = POWERON_STATE;
> -		mutex_unlock(&ctrl->state_lock);
> -		if (present)
> -			ctrl_info(ctrl, "Slot(%s): Card present\n",
> -				  slot_name(ctrl));
> -		if (link_active)
> -			ctrl_info(ctrl, "Slot(%s): Link Up\n",
> -				  slot_name(ctrl));
> -		ctrl->request_result = pciehp_enable_slot(ctrl);
> -		break;
> +		if ((events & PCI_EXP_SLTSTA_PDC && present) ||
> +		    (events & PCI_EXP_SLTSTA_DLLSC && link_active)) {
> +			ctrl->state = POWERON_STATE;
> +			mutex_unlock(&ctrl->state_lock);
> +			if (present)
> +				ctrl_info(ctrl, "Slot(%s): Card present\n",
> +					  slot_name(ctrl));
> +			if (link_active)
> +				ctrl_info(ctrl, "Slot(%s): Link Up\n",
> +					  slot_name(ctrl));
> +			ctrl->request_result = pciehp_enable_slot(ctrl);
> +			break;
> +		}
> +		/* fall through */
>  	default:
>  		mutex_unlock(&ctrl->state_lock);
>  		break;

First of all:

Up until now, when the controller is in BLINKINGON_STATE and a PDC or
DLLSC event is received and PDS or DLLLA is on, the button_work is
canceled and the slot is brought up immediately.  The rationale is
that is doesn't make much sense to wait until the 5 second delay has
elapsed if we know there's a card in the slot or the link is already up.

However with the above change, it could happen that the button_work is
canceled even though the slot *isn't* brought up.  If the slot is only
brought up if ((PDC && PDS) || (DLLSC && DLLLA)) and those conditions
aren't satisfied at the moment, they might be once the 5 seconds have
elapsed.  So I think we should continue blinking and not cancel the
button_work.

Secondly, I'm wondering if this change might break hardware which doesn't
behave well.  If the slot signals e.g. PDC but takes a little while to
set PDS even though DLLLA is already set, then the current code will react
tolerantly, whereas the change proposed above may result in the slot not
being brought up at all.  Not sure if such hardware exists, just slightly
concerned.

IIUC, the only downside of the current code is an error message in dmesg
when trying to bring up a slot after the card has already been removed.
Maybe just toning down the message to KERN_INFO would be appropriate?

Thanks,

Lukas
