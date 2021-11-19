Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA8645768D
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 19:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhKSSnz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 13:43:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234697AbhKSSnz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 13:43:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8AD96138D;
        Fri, 19 Nov 2021 18:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637347251;
        bh=y3DkpihsiL0fQSHXzb5rNT/A7Cua9WK/u4fClJT9hSg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DfQQdIGUlNgYgvl/iBBdHUO+TX6UvgX0rPS0q52rwPvgZol4xeIuqH//9OPN2soDu
         WNHHkBWK+wprVBFv0OD9e9xDnHl/7mHeuvofZSVSnncFQ6XZEFXY0EIjl/hNF/nJDN
         Cqqc8KdMzU7Qd+Enm7uDkDoXs5V0FPE8Z8u9RaC0rSkg8dUUg4Mp+S8s4I7PiPmDmu
         NzdZ+0+yzU4cd7QRiFKd4HTt7xItojqSBamjjCGsTiNSQL/5PS5eOMbloRlxIuJk8d
         53+6qirbkz/+7gB/CTzKSa5m3h+cpMVDsEriKG51mL8V4FJkIndea4ZG3xBJ9pLURK
         HxcM/7iqKNj3A==
Date:   Fri, 19 Nov 2021 12:40:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Joseph Bao <joseph.bao@intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>, kw@linux.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Fix infinite loop in IRQ handler upon power
 fault
Message-ID: <20211119184049.GA1950305@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66eaeef31d4997ceea357ad93259f290ededecfd.1637187226.git.lukas@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 17, 2021 at 11:22:09PM +0100, Lukas Wunner wrote:
> The Power Fault Detected bit in the Slot Status register differs from
> all other hotplug events in that it is sticky:  It can only be cleared
> after turning off slot power.  Per PCIe r5.0, sec. 6.7.1.8:
> 
>   If a power controller detects a main power fault on the hot-plug slot,
>   it must automatically set its internal main power fault latch [...].
>   The main power fault latch is cleared when software turns off power to
>   the hot-plug slot.
> 
> The stickiness used to cause interrupt storms and infinite loops which
> were fixed in 2009 by commits 5651c48cfafe ("PCI pciehp: fix power fault
> interrupt storm problem") and 99f0169c17f3 ("PCI: pciehp: enable
> software notification on empty slots").
> 
> Unfortunately in 2020 the infinite loop issue was inadvertently
> reintroduced by commit 8edf5332c393 ("PCI: pciehp: Fix MSI interrupt
> race"):  The hardirq handler pciehp_isr() clears the PFD bit until
> pciehp's power_fault_detected flag is set.  That happens in the IRQ
> thread pciehp_ist(), which never learns of the event because the hardirq
> handler is stuck in an infinite loop.  Fix by setting the
> power_fault_detected flag already in the hardirq handler.
> 
> Fixes: 8edf5332c393 ("PCI: pciehp: Fix MSI interrupt race")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=214989
> Link: https://lore.kernel.org/linux-pci/DM8PR11MB5702255A6A92F735D90A4446868B9@DM8PR11MB5702.namprd11.prod.outlook.com
> Reported-by: Joseph Bao <joseph.bao@intel.com>
> Tested-by: Joseph Bao <joseph.bao@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.19+
> Cc: Stuart Hayes <stuart.w.hayes@gmail.com>

Applied to pci/hotplug for v5.17, thanks very much!

> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 83a0fa119cae..9535c61cbff3 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -642,6 +642,8 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  	 */
>  	if (ctrl->power_fault_detected)
>  		status &= ~PCI_EXP_SLTSTA_PFD;
> +	else if (status & PCI_EXP_SLTSTA_PFD)
> +		ctrl->power_fault_detected = true;
>  
>  	events |= status;
>  	if (!events) {
> @@ -651,7 +653,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  	}
>  
>  	if (status) {
> -		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
> +		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, status);
>  
>  		/*
>  		 * In MSI mode, all event bits must be zero before the port
> @@ -725,8 +727,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>  	}
>  
>  	/* Check Power Fault Detected */
> -	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
> -		ctrl->power_fault_detected = 1;
> +	if (events & PCI_EXP_SLTSTA_PFD) {
>  		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(ctrl));
>  		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
>  				      PCI_EXP_SLTCTL_ATTN_IND_ON);
> -- 
> 2.33.0
> 
