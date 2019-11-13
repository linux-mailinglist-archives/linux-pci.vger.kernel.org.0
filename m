Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1DCFA960
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 06:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbfKMFJt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 00:09:49 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:51099 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfKMFJt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2019 00:09:49 -0500
X-Greylist: delayed 606 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Nov 2019 00:09:47 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 763252800021B;
        Wed, 13 Nov 2019 05:59:39 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 38CC8477C16; Wed, 13 Nov 2019 05:59:39 +0100 (CET)
Date:   Wed, 13 Nov 2019 05:59:39 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Make sure pciehp_isr clears interrupt events
Message-ID: <20191113045939.hhmzfbx46vkgmsvn@wunner.de>
References: <20191112215938.1145-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112215938.1145-1-stuart.w.hayes@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 12, 2019 at 04:59:38PM -0500, Stuart Hayes wrote:
> The pciehp interrupt handler pciehp_isr() will read the slot status
> register and then write back to it to clear just the bits that caused the
> interrupt. If a different interrupt event bit gets set between the read and
> the write, pciehp_isr() will exit without having cleared all of the
> interrupt event bits, so we will never get another hotplug interrupt from
> that device.

The IRQ is masked when it occurs and unmasked after it's been handled.
See the invocation of mask_ack_irq() in handle_edge_irq() and
handle_level_irq() in kernel/irq/chip.c.

If the IRQ has fired in-between, the IRQ chip is expected to invoke
the IRQ handler again.  There is some support for IRQ chips not
capable of replaying interrupts in kernel/irq/resend.c, but in general,
if you do not get another hotplug interrupt, the hardware is broken.
What kind of IRQ chip are you using and what kind of chip is the
hotplug port built into?

I'm not opposed to quirks to support such broken hardware but the
commit message shouldn't purport that it's normal behavior and the
quirk should only be executed where necessary and be made explicit
in the code to be a quirk.

Thanks,

Lukas

> 
> That is expected behavior according to the PCI Express spec (v.5.0, section
> 6.7.3.4, "Software Notification of Hot-Plug Events").
> 
> Because the "presence detect changed" and "data link layer state changed"
> event bits are both getting set at nearly the same time when a device is
> added or removed, this is more likely to happen than it might seem. The
> issue can be reproduced rather easily by connecting and disconnecting an
> NVMe device on at least one system model.
> 
> This patch fixes the issue by modifying pciehp_isr() to loop back and
> re-read the slot status register immediately after writing to it, until
> it sees that all of the event status bits have been cleared.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 39 +++++++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 1a522c1c4177..8ec22a872b28 100644
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
> @@ -529,16 +539,34 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
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
> +
> +	if (status) {
> +		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, status);
> +		events |= status;
> +	}
> +
> +	/*
> +	 * All of the event bits must be zero before the port will send
> +	 * a new interrupt.  If an event bit gets set between the read
> +	 * and the write, we'll never get another interrupt, so loop until
> +	 * we see no event bits set.
> +	 */
> +	if (status && status_reads++ < MAX_ISR_STATUS_READS)
> +		goto read_status;
> +
> +	if (status_reads == MAX_ISR_STATUS_READS)
> +		ctrl_warn(ctrl, "Slot(%s): Hot plug event bit stuck, reading %x\n",
> +			  status, slot_name(ctrl));
>  
>  	if (!events) {
>  		if (parent)
> @@ -546,7 +574,6 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  		return IRQ_NONE;
>  	}
>  
> -	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
>  	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
>  	if (parent)
>  		pm_runtime_put(parent);
> -- 
> 2.18.1
> 
