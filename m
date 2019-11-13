Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 795DBFA71A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 04:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfKMDR5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 22:17:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfKMDR5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 22:17:57 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 534F6222BD;
        Wed, 13 Nov 2019 03:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573615075;
        bh=sneAMmdwrTCc4lWdcpMFIzqIcn7cyp1FwRmE3vxPD3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Lo86j8Nzm8cEO3r6DMPrCS5tMW9rupf/8R0yeAFKAVYlOJ8JAgcfvLD0gtT79vZmZ
         Q5GIAUOQ3v16niOB4v6f6mC9/clHot71Pa/SUenee8GwIUwLAaXQ3ZY6i0kE6LWfMu
         HL2BEByOlNZO8pT+bHjeBiTazuxu0C4B8Xig+rJA=
Date:   Tue, 12 Nov 2019 21:17:52 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: pciehp: Prevent deadlock on disconnect
Message-ID: <20191113031752.GA227753@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029170022.57528-2-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 29, 2019 at 08:00:22PM +0300, Mika Westerberg wrote:
> If there are more than one PCIe switch with hotplug downstream ports
> hot-removing them leads to a following deadlock:

Does this happen if two sibling switches are removed simultaneously,
or does this happen when switch A leads to switch B and you remove
switch A (with obviously also removes switch B)?  I'm guessing the
latter because it would be easier to reproduce.  And I guess that's
obvious from the text below.

>  INFO: task irq/126-pciehp:198 blocked for more than 120 seconds.
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  irq/126-pciehp  D    0   198      2 0x80000000
>  Call Trace:
>   __schedule+0x2a2/0x880
>   schedule+0x2c/0x80
>   schedule_timeout+0x246/0x350
>   ? ttwu_do_activate+0x67/0x90
>   wait_for_completion+0xb7/0x140
>   ? wake_up_q+0x80/0x80
>   kthread_stop+0x49/0x110
>   __free_irq+0x15c/0x2a0
>   free_irq+0x32/0x70
>   pcie_shutdown_notification+0x2f/0x50
>   pciehp_remove+0x27/0x50
>   pcie_port_remove_service+0x36/0x50
>   device_release_driver_internal+0x18c/0x250
>   device_release_driver+0x12/0x20
>   bus_remove_device+0xec/0x160
>   device_del+0x13b/0x350
>   ? pcie_port_find_device+0x60/0x60
>   device_unregister+0x1a/0x60
>   remove_iter+0x1e/0x30
>   device_for_each_child+0x56/0x90
>   pcie_port_device_remove+0x22/0x40
>   pcie_portdrv_remove+0x20/0x60
>   pci_device_remove+0x3e/0xc0
>   device_release_driver_internal+0x18c/0x250
>   device_release_driver+0x12/0x20
>   pci_stop_bus_device+0x6f/0x90
>   pci_stop_bus_device+0x31/0x90
>   pci_stop_and_remove_bus_device+0x12/0x20
>   pciehp_unconfigure_device+0x88/0x140
>   pciehp_disable_slot+0x6a/0x110
>   pciehp_handle_presence_or_link_change+0x263/0x400
>   pciehp_ist+0x1c9/0x1d0
>   ? irq_forced_thread_fn+0x80/0x80
>   irq_thread_fn+0x24/0x60
>   irq_thread+0xeb/0x190
>   ? irq_thread_fn+0x60/0x60
>   kthread+0x120/0x140
>   ? irq_thread_check_affinity+0xf0/0xf0
>   ? kthread_park+0x90/0x90
>   ret_from_fork+0x35/0x40
>  INFO: task irq/190-pciehp:2288 blocked for more than 120 seconds.
>  irq/190-pciehp  D    0  2288      2 0x80000000
>  Call Trace:
>   __schedule+0x2a2/0x880
>   schedule+0x2c/0x80
>   schedule_preempt_disabled+0xe/0x10
>   __mutex_lock.isra.9+0x2e0/0x4d0
>   ? __mutex_lock_slowpath+0x13/0x20
>   __mutex_lock_slowpath+0x13/0x20
>   mutex_lock+0x2c/0x30
>   pci_lock_rescan_remove+0x15/0x20
>   pciehp_unconfigure_device+0x4d/0x140
>   pciehp_disable_slot+0x6a/0x110
>   pciehp_handle_presence_or_link_change+0x263/0x400
>   pciehp_ist+0x1c9/0x1d0
>   ? irq_forced_thread_fn+0x80/0x80
>   irq_thread_fn+0x24/0x60
>   irq_thread+0xeb/0x190
>   ? irq_thread_fn+0x60/0x60
>   kthread+0x120/0x140
>   ? irq_thread_check_affinity+0xf0/0xf0
>   ? kthread_park+0x90/0x90
>   ret_from_fork+0x35/0x40
> 
> What happens here is that the whole hierarchy is runtime resumed and the

What is the runtime resume connection here?  I do see that
pcie_portdrv_remove() may call pm_runtime_forbid(), which looks like
it resumes devices, but I don't see whether that's actually relevant
to the deadlock.

> parent PCIe downstream port, who got the hot-remove event, starts
> removing devices below it taking pci_lock_rescan_remove() lock. When the
> child PCIe port is runtime resumed it calls pciehp_check_presence()
> which ends up calling pciehp_card_present() and pciehp_check_link_active().

Oh, I see, pciehp_resume() calls pciehp_check_presence(), which
schedules the IRQ thread via pciehp_request().  So does this deadlock
only happen if the port(s) have been runtime suspended?

> Both of these read their parts of PCIe config space by calling helper
> function pcie_capability_read_word(). Now, this function notices that
> the underlying device is already gone and returns PCIBIOS_DEVICE_NOT_FOUND
> with the capability value set to 0.  When pciehp gets this value it
> thinks that its child device is also hot-removed and schedules its IRQ
> thread to handle the event.

The child device actually *has* been hot-removed, right? :)

In addition to checking for PCIBIOS_DEVICE_NOT_FOUND, you added checks
for ~0:

> +	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || lnk_status == (u16)~0)
> +		return -ENODEV;

That makes sense to me and I think it's the right thing to do.

But I do wonder whether pcie_capability_read_word() is doing the wrong
thing when it sets "*val = 0" in the error case.  I suspect that just
complicates the callers for no good reason.  The callers could
otherwise simply check for ~0 as a "this may be an error response"
value.

> The deadlock happens when the child's IRQ thread runs and tries to
> acquire pci_lock_rescan_remove() which is already taken by the parent
> and the parent waits for the child's IRQ thread to finish.
> 
> We can prevent this from happening by checking the return value of
> pcie_capability_read_word() and if it is PCIBIOS_DEVICE_NOT_FOUND stop
> performing any hot-removal activities.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> Changes from v2 (https://patchwork.kernel.org/patch/11089973/):
> 
>   * Check for ~0 as well
>   * Added tag from Kai-Heng
>   * Always log lnk_status in pciehp_check_link_active()
>   * I also experimented renaming the two functions to pciehp_card_absent()
>     and pciehp_check_link_down() but it ended up looking odd because now we
>     check for !pciehp_card_absent() and so on and we still need to take
>     into account the possible error return value (since we need to deal
>     with that to avoid accessing hardware upon resume). So instead I added
>     kernel-doc to both functions mentioning that the card may not be
>     present after the function has returned.
> 
>  drivers/pci/hotplug/pciehp.h      |  6 ++--
>  drivers/pci/hotplug/pciehp_core.c | 11 ++++--
>  drivers/pci/hotplug/pciehp_ctrl.c |  4 +--
>  drivers/pci/hotplug/pciehp_hpc.c  | 59 +++++++++++++++++++++++++------
>  4 files changed, 61 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 654c972b8ea0..afea59a3aad2 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -172,10 +172,10 @@ void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn);
>  
>  void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
>  int pciehp_query_power_fault(struct controller *ctrl);
> -bool pciehp_card_present(struct controller *ctrl);
> -bool pciehp_card_present_or_link_active(struct controller *ctrl);
> +int pciehp_card_present(struct controller *ctrl);
> +int pciehp_card_present_or_link_active(struct controller *ctrl);
>  int pciehp_check_link_status(struct controller *ctrl);
> -bool pciehp_check_link_active(struct controller *ctrl);
> +int pciehp_check_link_active(struct controller *ctrl);
>  void pciehp_release_ctrl(struct controller *ctrl);
>  
>  int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index 56daad828c9e..312cc45c44c7 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -139,10 +139,15 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
>  {
>  	struct controller *ctrl = to_ctrl(hotplug_slot);
>  	struct pci_dev *pdev = ctrl->pcie->port;
> +	int ret;
>  
>  	pci_config_pm_runtime_get(pdev);
> -	*value = pciehp_card_present_or_link_active(ctrl);
> +	ret = pciehp_card_present_or_link_active(ctrl);
>  	pci_config_pm_runtime_put(pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	*value = ret;
>  	return 0;
>  }
>  
> @@ -158,13 +163,13 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
>   */
>  static void pciehp_check_presence(struct controller *ctrl)
>  {
> -	bool occupied;
> +	int occupied;
>  
>  	down_read(&ctrl->reset_lock);
>  	mutex_lock(&ctrl->state_lock);
>  
>  	occupied = pciehp_card_present_or_link_active(ctrl);
> -	if ((occupied && (ctrl->state == OFF_STATE ||
> +	if ((occupied > 0 && (ctrl->state == OFF_STATE ||
>  			  ctrl->state == BLINKINGON_STATE)) ||
>  	    (!occupied && (ctrl->state == ON_STATE ||
>  			   ctrl->state == BLINKINGOFF_STATE)))
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 21af7b16d7a4..c760a13ec7b1 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -226,7 +226,7 @@ void pciehp_handle_disable_request(struct controller *ctrl)
>  
>  void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  {
> -	bool present, link_active;
> +	int present, link_active;
>  
>  	/*
>  	 * If the slot is on and presence or link has changed, turn it off.
> @@ -257,7 +257,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  	mutex_lock(&ctrl->state_lock);
>  	present = pciehp_card_present(ctrl);
>  	link_active = pciehp_check_link_active(ctrl);
> -	if (!present && !link_active) {
> +	if (present <= 0 && link_active <= 0) {
>  		mutex_unlock(&ctrl->state_lock);
>  		return;
>  	}
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 1a522c1c4177..526a8f70bac5 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -201,17 +201,29 @@ static void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask)
>  	pcie_do_write_cmd(ctrl, cmd, mask, false);
>  }
>  
> -bool pciehp_check_link_active(struct controller *ctrl)
> +/**
> + * pciehp_check_link_active() - Is the link active
> + * @ctrl: PCIe hotplug controller
> + *
> + * Check whether the downstream link is currently active. Note it is
> + * possible that the card is removed immediately after this so the
> + * caller may need to take it into account.
> + *
> + * If the hotplug controller itself is not available anymore returns
> + * %-ENODEV.
> + */
> +int pciehp_check_link_active(struct controller *ctrl)
>  {
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
>  	u16 lnk_status;
> -	bool ret;
> +	int ret;
>  
> -	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> -	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> +	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || lnk_status == (u16)~0)
> +		return -ENODEV;
>  
> -	if (ret)
> -		ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
> +	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> +	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
>  
>  	return ret;
>  }
> @@ -373,13 +385,29 @@ void pciehp_get_latch_status(struct controller *ctrl, u8 *status)
>  	*status = !!(slot_status & PCI_EXP_SLTSTA_MRLSS);
>  }
>  
> -bool pciehp_card_present(struct controller *ctrl)
> +/**
> + * pciehp_card_present() - Is the card present
> + * @ctrl: PCIe hotplug controller
> + *
> + * Function checks whether the card is currently present in the slot and
> + * in that case returns true. Note it is possible that the card is
> + * removed immediately after the check so the caller may need to take
> + * this into account.
> + *
> + * It the hotplug controller itself is not available anymore returns
> + * %-ENODEV.
> + */
> +int pciehp_card_present(struct controller *ctrl)
>  {
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
>  	u16 slot_status;
> +	int ret;
>  
> -	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> -	return slot_status & PCI_EXP_SLTSTA_PDS;
> +	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || slot_status == (u16)~0)
> +		return -ENODEV;
> +
> +	return !!(slot_status & PCI_EXP_SLTSTA_PDS);
>  }
>  
>  /**
> @@ -390,10 +418,19 @@ bool pciehp_card_present(struct controller *ctrl)
>   * Presence Detect State bit, this helper also returns true if the Link Active
>   * bit is set.  This is a concession to broken hotplug ports which hardwire
>   * Presence Detect State to zero, such as Wilocity's [1ae9:0200].
> + *
> + * Returns: %1 if the slot is occupied and %0 if it is not. If the hotplug
> + *	    port is not present anymore returns %-ENODEV.
>   */
> -bool pciehp_card_present_or_link_active(struct controller *ctrl)
> +int pciehp_card_present_or_link_active(struct controller *ctrl)
>  {
> -	return pciehp_card_present(ctrl) || pciehp_check_link_active(ctrl);
> +	int ret;
> +
> +	ret = pciehp_card_present(ctrl);
> +	if (ret)
> +		return ret;
> +
> +	return pciehp_check_link_active(ctrl);
>  }
>  
>  int pciehp_query_power_fault(struct controller *ctrl)
> -- 
> 2.23.0
> 
