Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19723F541E
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 02:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhHXAig (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Aug 2021 20:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233360AbhHXAig (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Aug 2021 20:38:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12364611F0;
        Tue, 24 Aug 2021 00:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629765473;
        bh=c8B0rBovsBLEBI0TuOmV/QZyzMIZicWoE31njEO6kd4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pslhJVHYFMPYh1rSaZfq0i7PZg08+RU+E9f7DEv7zXgrc9TpUsjJTvWcSoJXczLRA
         cVuNf5uH9t58AxoUoi+SG/2CMe6B+FqqFwPVzSTZ2Zkwh7sHLoAmyffEdP2FFbrb/f
         Gb4I/UsOwT6LjjwBPM2jD1pqpWPDOlfB+xFz6+IU27rRazYXBgGjpB60ZDT+XZqmkV
         RXoQtEcmh9tyexYDj8qy6GUA5tos1hgcYTl1Z8UsyLPtf8InbZrhOpakVIrtAM/lRp
         t58GX2MecK0zHcSvmM7nEBTOgQlK7ayLFGtlVMujBXX1rEVu+m4tdxhHp5Z9JQ4eP1
         vjnxnE/KEOy3g==
Date:   Mon, 23 Aug 2021 19:37:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Lukas Wunner <lukas@wunner.de>, jonathan.derrick@linux.dev,
        James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: Re: [PATCH v2] PCI: pciehp: Quirk to ignore spurious DLLSC when off
Message-ID: <20210824003751.GA3417333@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823184919.3412-1-jonathan.derrick@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Subject should start with a verb (see history for examples).  "when
off"?  Needs a little more context to make sense by itself.

On Mon, Aug 23, 2021 at 12:49:19PM -0600, Jon Derrick wrote:
> From: James Puthukattukaran <james.puthukattukaran@oracle.com>
> 
> When a specific x8 CEM card is bifurcated into x4x4 mode, and the
> upstream ports both support hotplugging on each respective x4 device, a
> slot management system for the CEM card requires both x4 devices to be
> sysfs removed from the OS before it can safely turn-off physical power.
> The implications are that Slot Control will display Powered Off status
> for the device where the device is actually powered until both ports
> have powered off.

Apparently this is related to a "specific x8 CEM card"?  Please
identify it (marketing name, model, etc -- some way a user can tell
whether this quirk applies to the hardware he/she is holding),
describe it, and make a case for why we care about it.  E.g., if this
is a shipping product, we probably do care; if it's just a lab
fixture, maybe not.

> When power is removed from the first half, real power and link remains
> active while waiting for the second half to have power removed. When
> power is then removed from the second half, the first half starts
> shutdown sequence and will trigger a DLLSC event. This is misinterpreted
> as an enabling event and causes the first half to be re-enabled.
> 
> The spurious enable can be resolved by ignoring link status change
> events when no link is active when in the off state. This patch adds a
> quirk for the card.
> 
> Acked-by: Jon Derrick <jonathan.derrick@intel.com>
> Signed-off-by: James Puthukattukaran <james.puthukattukaran@oracle.com>
> ---
> v1->v2: Device-specific quirk
> 
>  drivers/pci/hotplug/pciehp_ctrl.c |  7 +++++++
>  drivers/pci/quirks.c              | 30 ++++++++++++++++++++++++++++++
>  include/linux/pci.h               |  1 +
>  3 files changed, 38 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 529c34808440..db41f78bfac8 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -225,6 +225,7 @@ void pciehp_handle_disable_request(struct controller *ctrl)
>  void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  {
>  	int present, link_active;
> +	struct pci_dev *pdev = ctrl->pcie->port;
>  
>  	/*
>  	 * If the slot is on and presence or link has changed, turn it off.
> @@ -265,6 +266,12 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  		cancel_delayed_work(&ctrl->button_work);
>  		fallthrough;
>  	case OFF_STATE:
> +		if (pdev->shared_pcc_and_link_slot &&
> +		    (events & PCI_EXP_SLTSTA_DLLSC) && !link_active) {
> +			mutex_unlock(&ctrl->state_lock);
> +			break;
> +		}
> +
>  		ctrl->state = POWERON_STATE;
>  		mutex_unlock(&ctrl->state_lock);
>  		if (present)
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 43fbf55871ef..92a5bae8926e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5749,3 +5749,33 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
>  			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
> +
> +/*
> + * This is a special card that sits in a x8 pciehp slot but is bifurcated as
> + * a x4x4 and manifests as two slots with respect to PCIe hot plug register
> + * states. However, the hotplug controller treats these slots as a single x8
> + * slot for link and power. Either one of the two slots can be powered down
> + * separately but real power and link will be active till the last of the two
> + * slots is powered down. When the last of the two x4 slots is turned off,
> + * power and link will be turned off for the x8 slot by the HP controller.
> + * This configuration causes some interesting behavior in bringup sequence
> + *
> + * When the second slot is powered off to remove the card, this will cause
> + * the link to go down for both x4 slots. So, the x4 that is already powered
> + * down earlier will see a DLLSC event and attempt to bring itself up (card
> + * present, link change event, link state is down). Special handling is
> + * required in pciehp_handle_presence_or_link_change to prevent this unintended
> + * bring up
> + *
> + */
> +static void shared_pcc_and_link_slot(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent = pci_upstream_bridge(pdev);
> +
> +	if (pdev->subsystem_vendor == 0x108e &&
> +	    pdev->subsystem_device == 0x487d) {
> +		if (parent)
> +			parent->shared_pcc_and_link_slot = 1;
> +	}
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0B60, shared_pcc_and_link_slot);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e752cc39a1fe..ba84f7c93c31 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -469,6 +469,7 @@ struct pci_dev {
>  
>  #ifdef CONFIG_HOTPLUG_PCI_PCIE
>  	unsigned int	broken_cmd_compl:1;	/* No compl for some cmds */
> +	unsigned int	shared_pcc_and_link_slot:1;
>  #endif
>  #ifdef CONFIG_PCIE_PTM
>  	unsigned int	ptm_root:1;
> -- 
> 2.27.0
> 
