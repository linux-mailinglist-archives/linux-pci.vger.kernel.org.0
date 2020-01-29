Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67B5E14C43A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 01:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgA2Avz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jan 2020 19:51:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbgA2Avy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jan 2020 19:51:54 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9738A2465B;
        Wed, 29 Jan 2020 00:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580259114;
        bh=3GJala7Uck+Sf9Z0MbiaM6YIYxARcaYuozJFoBDB9pY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=k2CUCaZQxZqFkOdMEBnmX8ilqchEuYnk0Ee/Azwobn668rAmmFh8hVU7eFQRJ2jOL
         Zsvw+RkCwDxJ1A6VERsDoie35AsCCRLPJVntgCPCUtVlpMEqrRKbeELH9hcyeo+avR
         7I9rgRBHqKwU9QAt7tYpTJ9+v8ZEF7wafuPqLGxI=
Date:   Tue, 28 Jan 2020 18:51:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH v2] PCI: pciehp: Make sure pciehp_isr clears interrupt
 events
Message-ID: <20200129005151.GA247355@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120222043.53432-1-stuart.w.hayes@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Enzo]

On Wed, Nov 20, 2019 at 05:20:43PM -0500, Stuart Hayes wrote:
> Without this patch, a pciehp hotplug port can stop generating interrupts
> on hotplug events, so device adds and removals will not be seen.
> 
> The pciehp interrupt handler pciehp_isr() will read the slot status
> register and then write back to it to clear the bits that caused the
> interrupt. If a different interrupt event bit gets set between the read and
> the write, pciehp_isr will exit without having cleared all of the interrupt
> event bits. If this happens, and the port is using an MSI interrupt where
> per-vector masking is not supported, we won't get any more hotplug
> interrupts from that device.
> 
> That is expected behavior, according to the PCI Express Base Specification
> Revision 5.0 Version 1.0, section 6.7.3.4, "Software Notification of Hot-
> Plug Events".
> 
> Because the "presence detect changed" and "data link layer state changed"
> event bits are both getting set at nearly the same time when a device is
> added or removed, this is more likely to happen than it might seem. The
> issue was found (and can be reproduced rather easily) by connecting and
> disconnecting an NVMe storage device on at least one system model.
> 
> This issue was found while adding and removing various NVMe storage devices
> on an AMD PCIe port (PCI device 0x1022/0x1483).
> 
> This patch fixes this issue by modifying pciehp_isr() by looping back and
> re-reading the slot status register immediately after writing to it, until
> it sees that all of the event status bits have been cleared.

I see that Lukas took a look at this earlier; I'd really like to have
his reviewed-by, since he's the expert on this code.

> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> ---
> v2:
>   * fixed ctrl_warn() call
>   * improved comments
>   * added pvm_capable flag and changed pciehp_isr() to loop back only when
>     pvm_capable flag not set (suggested by Lukas Wunner)
>   
>  drivers/pci/hotplug/pciehp.h     |  3 ++
>  drivers/pci/hotplug/pciehp_hpc.c | 50 ++++++++++++++++++++++++++++----
>  2 files changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 654c972b8ea0..1804277ec433 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -47,6 +47,8 @@ extern int pciehp_poll_time;
>   * struct controller - PCIe hotplug controller
>   * @pcie: pointer to the controller's PCIe port service device
>   * @slot_cap: cached copy of the Slot Capabilities register
> + * @pvm_capable: set if per-vector masking is supported (if not set, the ISR
> + *	needs to ensure all event bits cleared)
>   * @slot_ctrl: cached copy of the Slot Control register
>   * @ctrl_lock: serializes writes to the Slot Control register
>   * @cmd_started: jiffies when the Slot Control register was last written;
> @@ -83,6 +85,7 @@ struct controller {
>  	struct pcie_device *pcie;
>  
>  	u32 slot_cap;				/* capabilities and quirks */
> +	unsigned int pvm_capable:1;
>  
>  	u16 slot_ctrl;				/* control register access */
>  	struct mutex ctrl_lock;
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 1a522c1c4177..4ffd489a5413 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -487,12 +487,21 @@ void pciehp_power_off_slot(struct controller *ctrl)
>  		 PCI_EXP_SLTCTL_PWR_OFF);
>  }
>  
> +/*
> + * We should never need to re-read the slot status register this many times,
> + * because there are only six possible events that could generate this
> + * interrupt.  If we still see events after this many reads, there's a stuck
> + * bit.
> + */
> +#define MAX_ISR_STATUS_READS 6
> +
>  static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  {
>  	struct controller *ctrl = (struct controller *)dev_id;
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
>  	struct device *parent = pdev->dev.parent;
> -	u16 status, events;
> +	u16 status, events = 0;
> +	int status_reads = 0;
>  
>  	/*
>  	 * Interrupts only occur in D3hot or shallower and only if enabled
> @@ -517,6 +526,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  		}
>  	}
>  
> +read_status:
>  	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
>  	if (status == (u16) ~0) {
>  		ctrl_info(ctrl, "%s: no response from device\n", __func__);
> @@ -529,24 +539,44 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  	 * Slot Status contains plain status bits as well as event
>  	 * notification bits; right now we only want the event bits.
>  	 */
> -	events = status & (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
> -			   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
> -			   PCI_EXP_SLTSTA_DLLSC);
> +	status &= (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
> +		   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
> +		   PCI_EXP_SLTSTA_DLLSC);
>  
>  	/*
>  	 * If we've already reported a power fault, don't report it again
>  	 * until we've done something to handle it.
>  	 */
>  	if (ctrl->power_fault_detected)
> -		events &= ~PCI_EXP_SLTSTA_PFD;
> +		status &= ~PCI_EXP_SLTSTA_PFD;
>  
> +	events |= status;
>  	if (!events) {
>  		if (parent)
>  			pm_runtime_put(parent);
>  		return IRQ_NONE;
>  	}
>  
> -	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
> +	if (status) {
> +		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, status);
> +
> +		/*
> +		 * If MSI per-vector masking is not supported by the port,
> +		 * all of the event bits must be zero before the port will
> +		 * send a new interrupt (see PCI Express Base Specification
> +		 * Revision 5.0 Version 1.0, section 6.7.3.4, "Software
> +		 * Notification of Hot-Plug Events"). So in that case, if
> +		 * event bit gets set between the read and the write of
> +		 * PCI_EXP_SLTSTA, we need to loop back and try again.
> +		 */
> +		if (!ctrl->pvm_capable) {

I don't think this per-vector masking check is correct.  It's true
that if the device does not support masking, it must send an interrupt
every time this expression transitions from FALSE to TRUE:

  (INT ENABLE == 1) AND ((event status == 1) AND event enable == 1)

But if the device *does* support per-vector masking, an interrupt
message must be sent every time this expression transitions from FALSE
to TRUE:

  (MSI vector is unmasked) AND (INT ENABLE == 1) AND
    ((event status == 1) AND event enable == 1)

I don't know what whether the MSI vector is masked or not at this
point, and I don't think this code *should* know that.  All it should
know is "we got an interrupt via some mechanism".  Actually, it can't
even know that, because it should always be safe to call an ISR
because the interrupt may be shared with other devices, and this ISR
may be called because a different device interrupted.

So if we assume the vector is unmasked, the situation is the same as
when the device doesn't support per-vector masking.

> +			if (status_reads++ < MAX_ISR_STATUS_READS)
> +				goto read_status;

I don't understand this limit of six.  We clear a status bit above,
but what's to prevent that same bit from being set again after we read
it but before we write it?

> +			ctrl_warn(ctrl, "Hot plug event bit stuck (%x)\n",
> +				  status);
> +		}
> +	}
> +
>  	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
>  	if (parent)
>  		pm_runtime_put(parent);
> @@ -812,6 +842,7 @@ struct controller *pcie_init(struct pcie_device *dev)
>  {
>  	struct controller *ctrl;
>  	u32 slot_cap, link_cap;
> +	u16 msiflags;
>  	u8 poweron;
>  	struct pci_dev *pdev = dev->port;
>  	struct pci_bus *subordinate = pdev->subordinate;
> @@ -881,6 +912,13 @@ struct controller *pcie_init(struct pcie_device *dev)
>  		}
>  	}
>  
> +	ctrl->pvm_capable = 1;
> +	if (pdev->msi_enabled) {
> +		pci_read_config_word(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
> +				     &msiflags);
> +		ctrl->pvm_capable = !!(msiflags & PCI_MSI_FLAGS_MASKBIT);
> +	}
> +
>  	return ctrl;
>  }
>  
> -- 
> 2.18.1
> 
