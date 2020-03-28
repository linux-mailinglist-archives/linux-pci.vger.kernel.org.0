Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25DC619693D
	for <lists+linux-pci@lfdr.de>; Sat, 28 Mar 2020 21:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgC1UjI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Mar 2020 16:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgC1UjI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Mar 2020 16:39:08 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FFDB206F6;
        Sat, 28 Mar 2020 20:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585427947;
        bh=BqRVW9QWi4Wj/EtZ4wBFyU8c5HfqMBu8VN/r94afdjM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=s8eKQOk1lUv9IElQSIM3cnh7/6pKzomZgQ4rR4ebeglcG16tSdhlxcBDYVpHBSSZ0
         tr1ijxKZgt91N7Ly1vmUVp9q6e42+Cmb9gN1ZpJgYHZgiKvhdb1RE1JvAWQYqkWetp
         p+OJgfDV1yzG4k16ILytv77uJL+ie5Ou8eS0+N/E=
Date:   Sat, 28 Mar 2020 15:39:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Don't enable slot unless link or presence up
Message-ID: <20200328203905.GA116560@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310182100.102987-1-stuart.w.hayes@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
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

Looking for a reviewed-by from Lukas for this.

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
> -- 
> 2.18.1
> 
