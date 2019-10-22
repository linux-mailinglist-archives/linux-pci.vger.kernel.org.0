Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10565E0E69
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 01:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389599AbfJVXAK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Oct 2019 19:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730034AbfJVXAJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Oct 2019 19:00:09 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AD1C20700;
        Tue, 22 Oct 2019 23:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571785208;
        bh=Kx/1CWzHXPzAcA1vV8ItNIOLifm37pD99zDnJEvsW2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E36sPUzvdx7Y6sQcsthmUyMkk98NjVNb24eAKPfUZZ9u0hGnIJ/i2Fzur3mANemaw
         wseR1mwfyzhvy7bCG+qAlpXYdSxCXDBiLnp66ACVvXHpu6p5il7v4dCMM3KbfIG6PE
         Pkyxdfqir8RfVDryYUSpVnNvnolNXRfzXwmxdtjw=
Date:   Tue, 22 Oct 2019 18:00:06 -0500
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
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Prevent deadlock on disconnect
Message-ID: <20191022230006.GA46791@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812143133.75319-2-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 12, 2019 at 05:31:33PM +0300, Mika Westerberg wrote:
> If there are more than one PCIe switch with hotplug downstream ports
> hot-removing them leads to a following deadlock:
> 
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
> parent PCIe downstream port, who got the hot-remove event, starts
> removing devices below it taking pci_lock_rescan_remove() lock. When the
> child PCIe port is runtime resumed it calls pciehp_check_presence()
> which ends up calling pciehp_card_present() and pciehp_check_link_active().
> Both of these read their parts of PCIe config space by calling helper
> function pcie_capability_read_word(). Now, this function notices that
> the underlying device is already gone and returns PCIBIOS_DEVICE_NOT_FOUND
> with the capability value set to 0. When pciehp gets this value it
> thinks that its child device is also hot-removed and schedules its IRQ
> thread to handle the event.

I can't remember if there was a reason why 8c0d3a02c130 ("PCI: Add
accessors for PCI Express Capability") reset *val to 0 if
pci_read_config_word() fails.  It doesn't seem like the right thing;
it seems like it would be better for it to be consistent with a plain
pci_read_config_word().

> The deadlock happens when the child's IRQ thread runs and tries to
> acquire pci_lock_rescan_remove() which is already taken by the parent
> and the parent waits for the child's IRQ thread to finish.
> 
> We can prevent this from happening by checking the return value of
> pcie_capability_read_word() and if it is PCIBIOS_DEVICE_NOT_FOUND stop
> performing any hot-removal activities.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> No changes from the previous version.
> 
>  drivers/pci/hotplug/pciehp.h      |  6 +++---
>  drivers/pci/hotplug/pciehp_core.c | 11 ++++++++---
>  drivers/pci/hotplug/pciehp_ctrl.c |  4 ++--
>  drivers/pci/hotplug/pciehp_hpc.c  | 32 +++++++++++++++++++++++--------
>  4 files changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 8c51a04b8083..81c514ab9518 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -173,10 +173,10 @@ int pciehp_query_power_fault(struct controller *ctrl);
>  void pciehp_green_led_on(struct controller *ctrl);
>  void pciehp_green_led_off(struct controller *ctrl);
>  void pciehp_green_led_blink(struct controller *ctrl);
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
> index e9f82afa3773..4c032d75c874 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -134,10 +134,15 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
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
> @@ -153,13 +158,13 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
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
> index 631ced0ab28a..5a433cc8621f 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -221,7 +221,7 @@ void pciehp_handle_disable_request(struct controller *ctrl)
>  
>  void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  {
> -	bool present, link_active;
> +	int present, link_active;
>  
>  	/*
>  	 * If the slot is on and presence or link has changed, turn it off.
> @@ -252,7 +252,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  	mutex_lock(&ctrl->state_lock);
>  	present = pciehp_card_present(ctrl);
>  	link_active = pciehp_check_link_active(ctrl);
> -	if (!present && !link_active) {
> +	if (present <= 0 && link_active <= 0) {
>  		mutex_unlock(&ctrl->state_lock);
>  		return;
>  	}
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index bd990e3371e3..1f918b043adb 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -201,13 +201,16 @@ static void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask)
>  	pcie_do_write_cmd(ctrl, cmd, mask, false);
>  }
>  
> -bool pciehp_check_link_active(struct controller *ctrl)
> +int pciehp_check_link_active(struct controller *ctrl)
>  {
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
>  	u16 lnk_status;
> -	bool ret;
> +	int ret;
> +
> +	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> +	if (ret == PCIBIOS_DEVICE_NOT_FOUND)
> +		return -ENODEV;
>  
> -	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>  	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
>  
>  	if (ret)
> @@ -373,13 +376,17 @@ void pciehp_get_latch_status(struct controller *ctrl, u8 *status)
>  	*status = !!(slot_status & PCI_EXP_SLTSTA_MRLSS);
>  }
>  
> -bool pciehp_card_present(struct controller *ctrl)
> +int pciehp_card_present(struct controller *ctrl)
>  {
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
>  	u16 slot_status;
> +	int ret;
>  
> -	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> -	return slot_status & PCI_EXP_SLTSTA_PDS;
> +	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> +	if (ret == PCIBIOS_DEVICE_NOT_FOUND)
> +		return -ENODEV;

Isn't this racy?

                                        # pdev is present
  pci_read_config_word
    if (pci_dev_is_disconnected(pdev))  # currently false
                                        # pdev is removed
    pci_bus_read_config_word            # fails, returns ~0
  slot_status = ~0

I think pci_read_config_word() checks pci_dev_is_disconnected() merely
as an optimization.  Obviously it can't guarantee that the subsequent
config access will succeed.

If pci_dev_is_disconnected() was false but the config read fails, I
think we'll get ~0 data and return 1, i.e., "PDS was set".

Shouldn't we check for slot_status being an error response (~0)
instead of looking for PCIBIOS_DEVICE_NOT_FOUND?  There are 7 RsvdP
bits in Slot Status, so ~0 is not a valid value for the register.

All 16 bits of Link Status are defined, but ~0 is still an invalid
value because the Current Link Speed and Negotiated Link Width fields
only define a few valid encodings.

> +	return !!(slot_status & PCI_EXP_SLTSTA_PDS);
>  }
>  
>  /**
> @@ -390,10 +397,19 @@ bool pciehp_card_present(struct controller *ctrl)
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

The names of these functions seem misleading to me: all they can
really tell us is "the card *was* present" or "the link *was* active"
at some time in the past.  But the names make it so tempting to
pretend that "the card *is* present" or "the link *is* active", and
that may no longer be true.

I think names like "pciehp_card_absent()" and "pciehp_link_down()"
would make it easier to think about these situations.

>  }
>  
>  int pciehp_query_power_fault(struct controller *ctrl)
> -- 
> 2.20.1
> 
