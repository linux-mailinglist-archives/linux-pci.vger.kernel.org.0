Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADCEF19697D
	for <lists+linux-pci@lfdr.de>; Sat, 28 Mar 2020 22:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgC1V12 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Mar 2020 17:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgC1V11 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Mar 2020 17:27:27 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1889206F2;
        Sat, 28 Mar 2020 21:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585430847;
        bh=DyJvNGh61Two94QYigr+Bg5rkzIrG4wL94jZ7ZimsXg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dyshV2fwh428iMAm6gphwTlZ/Y/hQRTOaAl4dbe0qaUbiYMIF9sXLlcJ9SKgJy+UP
         E6Dp0ob8iVG+deLC5EbjJy4E8lADg84f9Notaqhh9zTObKBbhVEXSdBVF9bYZ3/2bj
         xjlIARqo3dbqIhx+RzWDs2eyGjgBLKChmBUhPn1o=
Date:   Sat, 28 Mar 2020 16:27:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <kbusch@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, narendra_k@dell.com,
        Enzo Matsumiya <ematsumiya@suse.com>
Subject: Re: [PATCH v4] PCI: pciehp: Fix MSI interrupt race
Message-ID: <20200328212725.GA127426@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78b4ced5072bfe6e369d20e8b47c279b8c7af12e.1582121613.git.lukas@wunner.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 19, 2020 at 03:31:13PM +0100, Lukas Wunner wrote:
> From: Stuart Hayes <stuart.w.hayes@gmail.com>
> 
> Without this commit, a PCIe hotplug port can stop generating interrupts
> on hotplug events, so device adds and removals will not be seen:
> 
> The pciehp interrupt handler pciehp_isr() reads the Slot Status register
> and then writes back to it to clear the bits that caused the interrupt.
> If a different interrupt event bit gets set between the read and the
> write, pciehp_isr() returns without having cleared all of the interrupt
> event bits.  If this happens when the MSI isn't masked (which by default
> it isn't in handle_edge_irq(), and which it will never be when MSI
> per-vector masking is not supported), we won't get any more hotplug
> interrupts from that device.
> 
> That is expected behavior, according to the PCIe Base Spec r5.0, section
> 6.7.3.4, "Software Notification of Hot-Plug Events".
> 
> Because the Presence Detect Changed and Data Link Layer State Changed
> event bits can both get set at nearly the same time when a device is
> added or removed, this is more likely to happen than it might seem.
> The issue was found (and can be reproduced rather easily) by connecting
> and disconnecting an NVMe storage device on at least one system model
> where the NVMe devices were being connected to an AMD PCIe port (PCI
> device 0x1022/0x1483).
> 
> Fix the issue by modifying pciehp_isr() to loop back and re-read the
> Slot Status register immediately after writing to it, until it sees that
> all of the event status bits have been cleared.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> [lukas: drop loop count limitation, write "events" instead of "status",
> don't loop back in INTx and poll modes, tweak code comment & commit msg]
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied to pci/hotplug for v5.7, thanks!

> ---
> v4 (lukas):
>   * drop "MAX_ISR_STATUS_READS" loop count limitation
>   * drop unnecessary braces around PCI_EXP_SLTSTA_* flags
>   * write "events" instead of "status" variable to Slot Status register
>     to avoid unnecessary loop iterations if the same bit gets set
>     repeatedly
>   * don't loop back in INTx and poll modes
>   * shorten and tweak code comment & commit message
> 
> v3:
>   * removed pvm_capable flag (from v2) since MSI may not be masked
>     regardless of whether per-vector masking is supported
>   * tweaked comments
> 
> v2:
>   * fixed ctrl_warn() call
>   * improved comments
>   * added pvm_capable flag and changed pciehp_isr() to loop back only when
>     pvm_capable flag not set (suggested by Lukas Wunner)
> 
>  drivers/pci/hotplug/pciehp_hpc.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 8a2cb1764386..f64d10df9eb5 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -527,7 +527,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  	struct controller *ctrl = (struct controller *)dev_id;
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
>  	struct device *parent = pdev->dev.parent;
> -	u16 status, events;
> +	u16 status, events = 0;
>  
>  	/*
>  	 * Interrupts only occur in D3hot or shallower and only if enabled
> @@ -552,6 +552,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  		}
>  	}
>  
> +read_status:
>  	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
>  	if (status == (u16) ~0) {
>  		ctrl_info(ctrl, "%s: no response from device\n", __func__);
> @@ -564,24 +565,37 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  	 * Slot Status contains plain status bits as well as event
>  	 * notification bits; right now we only want the event bits.
>  	 */
> -	events = status & (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
> -			   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
> -			   PCI_EXP_SLTSTA_DLLSC);
> +	status &= PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
> +		  PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
> +		  PCI_EXP_SLTSTA_DLLSC;
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
> +		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
> +
> +		/*
> +		 * In MSI mode, all event bits must be zero before the port
> +		 * will send a new interrupt (PCIe Base Spec r5.0 sec 6.7.3.4).
> +		 * So re-read the Slot Status register in case a bit was set
> +		 * between read and write.
> +		 */
> +		if (pci_dev_msi_enabled(pdev) && !pciehp_poll_mode)
> +			goto read_status;
> +	}
> +
>  	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
>  	if (parent)
>  		pm_runtime_put(parent);
> -- 
> 2.24.0
> 
