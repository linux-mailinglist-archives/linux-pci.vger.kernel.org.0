Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3E0443881
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 23:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhKBWgj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 18:36:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbhKBWgi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Nov 2021 18:36:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C69561053;
        Tue,  2 Nov 2021 22:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635892443;
        bh=xdhIBZKPp6GOknBcvDS3bNXUcF7QFXzPUbqIM4rpfMc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HaWtAZisLGv+tlpNXhDA1RgThrW/BaKiZzztkr+PCC7vjblqaCu+PL7HBHC4FT8pG
         up6ahRHmLot5hKXorarKcBKuFKog1VKLj3szc+RQUlP4BJaOHEpyVfFb4IVdF0sHQp
         rnZ+PDzM2CoR/DVTb6oaB8NZTJDgrYPhhYaIsGtVVPlzcExFvTjeEg/PbE54HtVe6a
         7BF5avIilsBnypcNY/q7Z3UEdPBq7CHpe5sx8f0SPbuXs5vGPbMFE6WM8gawaKv4fP
         Zf4g1OIAlUSh1M46/26+3TomQpXcqvvH8fUXgzvJHk1aE12sSW2qltfjJtFfGLZEcS
         4gpgaSJUmMkuA==
Date:   Tue, 2 Nov 2021 17:34:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Bao, Joseph" <joseph.bao@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: HW power fault defect cause system hang on kernel 5.4.y
Message-ID: <20211102223401.GA651784@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5702255A6A92F735D90A4446868B9@DM8PR11MB5702.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Stuart, author of 8edf5332c393 ("PCI: pciehp: Fix MSI interrupt race"),
Lukas, pciehp expert]

On Tue, Nov 02, 2021 at 03:45:00AM +0000, Bao, Joseph wrote:
> Hi, dear kernel developer,
> 
> Recently we encounter system hang (dead spinlock) when move to
> kernel linux-5.4.y. 
> 
> Finally, we use bisect to locate the suspicious commit
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=4667358dab9cc07da044d5bc087065545b1000df.

4667358dab9c backported upstream commit 8edf5332c393 ("PCI: pciehp:
Fix MSI interrupt race") to v5.4.69 just over a year ago.

> Our system has some HW defect, which will wrongly set
> PCI_EXP_SLTSTA_PFD high, and this commit will lead to infinite loop
> jumping to read_status (no chance to clear status PCI_EXP_SLTSTA_PFD
> bit since ctrl is not updated), I know this is our HW defect, but
> this commit makes kernel trapped in this isr function and leads to
> kernel hang (then the user could not get useful information to show
> what's wrong), which I think is not expected behavior, so I would
> like to report to you for discussion.

I guess this happens because the first time we handle PFD,
pciehp_ist() sets "ctrl->power_fault_detected = 1", and when
power_fault_detected is set, pciehp_isr() won't clear PFD from
PCI_EXP_SLTSTA?

It looks like the only place we clear power_fault_detected is in
pciehp_power_on_slot(), and I don't think we call that unless we have
a presence detect or link status change.

It would definitely be nice if we could arrange so this hardware
defect didn't cause a kernel hang.

I think the diff below is the backport of 8edf5332c393 ("PCI: pciehp:
Fix MSI interrupt race").

> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 356786a3b7f4b..88b996764ff95 100644
> --- a/https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/pci/hotplug/pciehp_hpc.c?h=linux-5.4.y&id=ca767cf0152d18fc299cde85b18d1f46ac21e1ba
> +++ b/https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/pci/hotplug/pciehp_hpc.c?h=linux-5.4.y&id=4667358dab9cc07da044d5bc087065545b1000df
> @@ -529,7 +529,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  	struct controller *ctrl = (struct controller *)dev_id;
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
>  	struct device *parent = pdev->dev.parent;
> -	u16 status, events;
> +	u16 status, events = 0;
>  
>  	/*
>  	 * Interrupts only occur in D3hot or shallower and only if enabled
> @@ -554,6 +554,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  		}
>  	}
>  
> +read_status:
>  	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
>  	if (status == (u16) ~0) {
>  		ctrl_info(ctrl, "%s: no response from device\n", __func__);
> @@ -566,24 +567,37 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
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
