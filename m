Return-Path: <linux-pci+bounces-25695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D0AA868DA
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 00:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBF89A5565
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 22:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E66D270ED8;
	Fri, 11 Apr 2025 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Byp2cU8d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB6A2248B9;
	Fri, 11 Apr 2025 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744410501; cv=none; b=oe9r2FC6QBIObDHmSSsa9FDQAY7/zbFO1fG2h/U80p+J5BYVB8NABPkB4Cc0gCPi0MAGnWM92QRkoGsVGGc/WS9bi1CyIggwgoEFEJtWCn/8jmMhYYCk9AZQ9wQZFpepxYxEK53NC4nXyxqIojSRNVMtz4wU4xGKccUZL8O3wz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744410501; c=relaxed/simple;
	bh=Tvk9VZHyYb9tjKFa3MIkAZKhNdkwpyoVkYVJ7jsToDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acmJJKLH0PIHlYWcc/VVznllhAluDUoJ0tgc3apBrOQM73JFPllp9ktQ91jC64rqFrA6zDcxxnlFpWE+PtHm/elf3Cjj8F7QxzWLZPXVnLCar53YczF70wzlE8zu3IkGCCTa8bNzl9laqFoNasg+LRrydFhZnXN1mC8bDmhUhf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Byp2cU8d; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744410498; x=1775946498;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Tvk9VZHyYb9tjKFa3MIkAZKhNdkwpyoVkYVJ7jsToDo=;
  b=Byp2cU8dmQ16plGDgw78cO1WzUyU5rqa/1y0SUIEm0b6IVf55sp3s4Kb
   XI50GsN2tW6SRuQVjWiyMpERoPv9Anq70c5pQb3Rbt9wWKFq8ZtzBHbnK
   Z51NBOVcWpGzqJ2oCvAQ3phkZPZMVtnchJNYdpAympAoDpoVfq99i7tjx
   aid+sC0BKcooOeYTclD/HBlIgE9UnBJ6LJPNY2PSmDLRCJbiTMA2vQjYa
   BZPXZX2Bso+xc7YLrcsnZQ3s3HjbNLf0BXpSbYmjntvl/O0n5RTbwrXQL
   1IlDvvfZ74p4gF0DIi+Wf2vKMqeFwtbANZrn2APxyr8JAHgjqSpNK4Sq7
   g==;
X-CSE-ConnectionGUID: sVrFnH2uQrKrmeTLk0TrmA==
X-CSE-MsgGUID: gN/D4ebvRomLh8DBtUJOsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45211656"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="45211656"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 15:28:17 -0700
X-CSE-ConnectionGUID: 4YZ/1ajEQmmSiUIa+tUjzQ==
X-CSE-MsgGUID: CehxX1nfSdK/Jhv8CB9GVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="134060905"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO [10.124.221.175]) ([10.124.221.175])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 15:28:16 -0700
Message-ID: <3e12d065-77b1-49f0-9ee7-32b49c3ab9ef@linux.intel.com>
Date: Fri, 11 Apr 2025 15:28:15 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: pciehp: Ignore Link Down/Up caused by Secondary
 Bus Reset
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>,
 linux-pci@vger.kernel.org, Stuart Hayes <stuart.w.hayes@gmail.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Joel Mathew Thomas <proxy0@tutamail.com>, Russ Weight
 <russ.weight@linux.dev>, Matthew Gerlach <matthew.gerlach@altera.com>,
 Yilun Xu <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
 Moshe Shemesh <moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <cover.1744298239.git.lukas@wunner.de>
 <d04deaf49d634a2edf42bf3c06ed81b4ca54d17b.1744298239.git.lukas@wunner.de>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <d04deaf49d634a2edf42bf3c06ed81b4ca54d17b.1744298239.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/10/25 8:27 AM, Lukas Wunner wrote:
> When a Secondary Bus Reset is issued at a hotplug port, it causes a Data
> Link Layer State Changed event as a side effect.  On hotplug ports using
> in-band presence detect, it additionally causes a Presence Detect Changed
> event.
>
> These spurious events should not result in teardown and re-enumeration of
> the device in the slot.  Hence commit 2e35afaefe64 ("PCI: pciehp: Add
> reset_slot() method") masked the Presence Detect Changed Enable bit in the
> Slot Control register during a Secondary Bus Reset.  Commit 06a8d89af551
> ("PCI: pciehp: Disable link notification across slot reset") additionally
> masked the Data Link Layer State Changed Enable bit.
>
> However masking those bits only disables interrupt generation (PCIe r6.2
> sec 6.7.3.1).  The events are still visible in the Slot Status register
> and picked up by the IRQ handler if it runs during a Secondary Bus Reset.
> This can happen if the interrupt is shared or if an unmasked hotplug event
> occurs, e.g. Attention Button Pressed or Power Fault Detected.
>
> The likelihood of this happening used to be small, so it wasn't much of a
> problem in practice.  That has changed with the recent introduction of
> bandwidth control in v6.13-rc1 with commit 665745f27487 ("PCI/bwctrl:
> Re-add BW notification portdrv as PCIe BW controller"):
>
> Bandwidth control shares the interrupt with PCIe hotplug.  A Secondary Bus
> Reset causes a Link Bandwidth Notification, so the hotplug IRQ handler
> runs, picks up the masked events and tears down the device in the slot.
>
> As a result, Joel reports VFIO passthrough failure of a GPU, which Ilpo
> root-caused to the incorrect handling of masked hotplug events.
>
> Clearly, a more reliable way is needed to ignore spurious hotplug events.
>
> For Downstream Port Containment, a new ignore mechanism was introduced by
> commit a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC").
> It has been working reliably for the past four years.
>
> Adapt it for Secondary Bus Resets.
>
> Introduce two helpers to annotate code sections which cause spurious link
> changes:  pci_hp_ignore_link_change() and pci_hp_unignore_link_change()
> Use those helpers in lieu of masking interrupts in the Slot Control
> register.
>
> Introduce a helper to check whether such a code section is executing
> concurrently and if so, await it:  pci_hp_spurious_link_change()
> Invoke the helper in the hotplug IRQ thread pciehp_ist().  Re-use the
> IRQ thread's existing code which ignores DPC-induced link changes unless
> the link is unexpectedly down after reset recovery or the device was
> replaced during the bus reset.
>
> That code block in pciehp_ist() was previously only executed if a Data
> Link Layer State Changed event has occurred.  Additionally execute it for
> Presence Detect Changed events.  That's necessary for compatibility with
> PCIe r1.0 hotplug ports because Data Link Layer State Changed didn't exist
> before PCIe r1.1.  DPC was added with PCIe r3.1 and thus DPC-capable
> hotplug ports always support Data Link Layer State Changed events.
> But the same cannot be assumed for Secondary Bus Reset, which already
> existed in PCIe r1.0.
>
> Secondary Bus Reset is only one of many causes of spurious link changes.
> Others include runtime suspend to D3cold, firmware updates or FPGA
> reconfiguration.  The new pci_hp_{,un}ignore_link_change() helpers may be
> used by all kinds of drivers to annotate such code sections, hence their
> declarations are publicly visible in <linux/pci.h>.  A case in point is
> the Mellanox Ethernet driver which disables a firmware reset feature if
> the Ethernet card is attached to a hotplug port, see commit 3d7a3f2612d7
> ("net/mlx5: Nack sync reset request when HotPlug is enabled").  Going
> forward, PCIe hotplug will be able to cope gracefully with all such use
> cases once the code sections are properly annotated.
>
> The new helpers internally use two bits in struct pci_dev's priv_flags as
> well as a wait_queue.  This mirrors what was done for DPC by commit
> a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC").  That may
> be insufficient if spurious link changes are caused by multiple sources
> simultaneously.  An example might be a Secondary Bus Reset issued by AER
> during FPGA reconfiguration.  If this turns out to happen in real life,
> support for it can easily be added by replacing the PCI_LINK_CHANGING flag
> with an atomic_t counter incremented by pci_hp_ignore_link_change() and
> decremented by pci_hp_unignore_link_change().  Instead of awaiting a zero
> PCI_LINK_CHANGING flag, the pci_hp_spurious_link_change() helper would
> then simply await a zero counter.
>
> Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")
> Reported-by: Joel Mathew Thomas <proxy0@tutamail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219765
> Tested-by: Joel Mathew Thomas <proxy0@tutamail.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   drivers/pci/hotplug/pci_hotplug_core.c | 69 ++++++++++++++++++++++++++++++++++
>   drivers/pci/hotplug/pciehp_hpc.c       | 35 ++++++-----------
>   drivers/pci/pci.h                      |  3 ++
>   include/linux/pci.h                    |  8 ++++
>   4 files changed, 92 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
> index d30f131..d8c5856 100644
> --- a/drivers/pci/hotplug/pci_hotplug_core.c
> +++ b/drivers/pci/hotplug/pci_hotplug_core.c
> @@ -492,6 +492,75 @@ void pci_hp_destroy(struct hotplug_slot *slot)
>   }
>   EXPORT_SYMBOL_GPL(pci_hp_destroy);
>   
> +static DECLARE_WAIT_QUEUE_HEAD(pci_hp_link_change_wq);
> +
> +/**
> + * pci_hp_ignore_link_change - begin code section causing spurious link changes
> + * @pdev: PCI hotplug bridge
> + *
> + * Mark the beginning of a code section causing spurious link changes on the
> + * Secondary Bus of @pdev, e.g. as a side effect of a Secondary Bus Reset,
> + * D3cold transition, firmware update or FPGA reconfiguration.
> + *
> + * Hotplug drivers can thus check whether such a code section is executing
> + * concurrently, await it with pci_hp_spurious_link_change() and ignore the
> + * resulting link change events.
> + *
> + * Must be paired with pci_hp_unignore_link_change().  May be called both
> + * from the PCI core and from Endpoint drivers.  May be called for bridges
> + * which are not hotplug-capable, in which case it has no effect because
> + * no hotplug driver is bound to the bridge.
> + */
> +void pci_hp_ignore_link_change(struct pci_dev *pdev)
> +{
> +	set_bit(PCI_LINK_CHANGING, &pdev->priv_flags);
> +	smp_mb__after_atomic(); /* pairs with implied barrier of wait_event() */
> +}
> +
> +/**
> + * pci_hp_unignore_link_change - end code section causing spurious link changes
> + * @pdev: PCI hotplug bridge
> + *
> + * Mark the end of a code section causing spurious link changes on the
> + * Secondary Bus of @pdev.  Must be paired with pci_hp_ignore_link_change().
> + */
> +void pci_hp_unignore_link_change(struct pci_dev *pdev)
> +{
> +	set_bit(PCI_LINK_CHANGED, &pdev->priv_flags);
> +	mb(); /* ensure pci_hp_spurious_link_change() sees either bit set */
> +	clear_bit(PCI_LINK_CHANGING, &pdev->priv_flags);
> +	wake_up_all(&pci_hp_link_change_wq);
> +}
> +
> +/**
> + * pci_hp_spurious_link_change - check for spurious link changes
> + * @pdev: PCI hotplug bridge
> + *
> + * Check whether a code section is executing concurrently which is causing
> + * spurious link changes on the Secondary Bus of @pdev.  Await the end of the
> + * code section if so.
> + *
> + * Return %true if such a code section has been executing concurrently,
> + * otherwise %false.  Also return %true if such a code section has not been
> + * executing concurrently, but at least once since the last invocation of this
> + * function.
> + *
> + * May be called by hotplug drivers to check whether a link change is spurious
> + * and can be ignored.
> + *
> + * Because a genuine link change may have occurred in-between a spurious link
> + * change and the invocation of this function, hotplug drivers should perform
> + * sanity checks such as retrieving the current link state and bringing down
> + * the slot if the link is down.
> + */
> +bool pci_hp_spurious_link_change(struct pci_dev *pdev)
> +{
> +	wait_event(pci_hp_link_change_wq,
> +		   !test_bit(PCI_LINK_CHANGING, &pdev->priv_flags));
> +
> +	return test_and_clear_bit(PCI_LINK_CHANGED, &pdev->priv_flags);
> +}
> +
>   static int __init pci_hotplug_init(void)
>   {
>   	int result;
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 388fbed..c98d310 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -592,21 +592,21 @@ bool pciehp_device_replaced(struct controller *ctrl)
>   	return false;
>   }
>   
> -static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
> -					  struct pci_dev *pdev, int irq,
> -					  u16 ignored_events)
> +static void pciehp_ignore_link_change(struct controller *ctrl,
> +				      struct pci_dev *pdev, int irq,
> +				      u16 ignored_events)
>   {
>   	/*
>   	 * Ignore link changes which occurred while waiting for DPC recovery.
>   	 * Could be several if DPC triggered multiple times consecutively.
> +	 * Also ignore link changes caused by Secondary Bus Reset etc.
>   	 */
>   	synchronize_hardirq(irq);
>   	atomic_and(~ignored_events, &ctrl->pending_events);
>   	if (pciehp_poll_mode)
>   		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
>   					   ignored_events);
> -	ctrl_info(ctrl, "Slot(%s): Link Down/Up ignored (recovered by DPC)\n",
> -		  slot_name(ctrl));
> +	ctrl_info(ctrl, "Slot(%s): Link Down/Up ignored\n", slot_name(ctrl));
>   
>   	/*
>   	 * If the link is unexpectedly down after successful recovery,
> @@ -762,9 +762,11 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>   
>   	/*
>   	 * Ignore Link Down/Up events caused by Downstream Port Containment
> -	 * if recovery from the error succeeded.
> +	 * if recovery succeeded, or caused by Secondary Bus Reset,
> +	 * suspend to D3cold, firmware update, FPGA reconfiguration, etc.
>   	 */
> -	if ((events & PCI_EXP_SLTSTA_DLLSC) && pci_dpc_recovered(pdev) &&
> +	if ((events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) &&
> +	    (pci_dpc_recovered(pdev) || pci_hp_spurious_link_change(pdev)) &&
>   	    ctrl->state == ON_STATE) {
>   		u16 ignored_events = PCI_EXP_SLTSTA_DLLSC;
>   
> @@ -772,7 +774,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>   			ignored_events |= events & PCI_EXP_SLTSTA_PDC;
>   
>   		events &= ~ignored_events;
> -		pciehp_ignore_dpc_link_change(ctrl, pdev, irq, ignored_events);
> +		pciehp_ignore_link_change(ctrl, pdev, irq, ignored_events);
>   	}
>   
>   	/*
> @@ -937,7 +939,6 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, bool probe)
>   {
>   	struct controller *ctrl = to_ctrl(hotplug_slot);
>   	struct pci_dev *pdev = ctrl_dev(ctrl);
> -	u16 stat_mask = 0, ctrl_mask = 0;
>   	int rc;
>   
>   	if (probe)
> @@ -945,23 +946,11 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, bool probe)
>   
>   	down_write_nested(&ctrl->reset_lock, ctrl->depth);
>   
> -	if (!ATTN_BUTTN(ctrl)) {
> -		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
> -		stat_mask |= PCI_EXP_SLTSTA_PDC;
> -	}
> -	ctrl_mask |= PCI_EXP_SLTCTL_DLLSCE;
> -	stat_mask |= PCI_EXP_SLTSTA_DLLSC;
> -
> -	pcie_write_cmd(ctrl, 0, ctrl_mask);
> -	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
> -		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
> +	pci_hp_ignore_link_change(pdev);
>   
>   	rc = pci_bridge_secondary_bus_reset(ctrl->pcie->port);
>   
> -	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, stat_mask);
> -	pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
> -	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
> -		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
> +	pci_hp_unignore_link_change(pdev);
>   

Since most of the changes in this patch is related to adding framework to
ignore spurious hotplug event, why not split it in to a separate patch?

Is this fix tested in any platform?

>   	up_write(&ctrl->reset_lock);
>   	return rc;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b81e99c..7db798b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -227,6 +227,7 @@ static inline bool pcie_downstream_port(const struct pci_dev *dev)
>   
>   /* Functions for PCI Hotplug drivers to use */
>   int pci_hp_add_bridge(struct pci_dev *dev);
> +bool pci_hp_spurious_link_change(struct pci_dev *pdev);

Do you expect this function used outside hotplug code? If not why not 
leave the
declaration in pciehp.h?

>   
>   #if defined(CONFIG_SYSFS) && defined(HAVE_PCI_LEGACY)
>   void pci_create_legacy_files(struct pci_bus *bus);
> @@ -557,6 +558,8 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
>   #define PCI_DPC_RECOVERED 1
>   #define PCI_DPC_RECOVERING 2
>   #define PCI_DEV_REMOVED 3
> +#define PCI_LINK_CHANGED 4
> +#define PCI_LINK_CHANGING 5
>   
>   static inline void pci_dev_assign_added(struct pci_dev *dev)
>   {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0e8e3fd..833b54f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1848,6 +1848,14 @@ static inline void pcie_no_aspm(void) { }
>   static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
>   #endif
>   
> +#ifdef CONFIG_HOTPLUG_PCI
> +void pci_hp_ignore_link_change(struct pci_dev *pdev);
> +void pci_hp_unignore_link_change(struct pci_dev *pdev);
> +#else
> +static inline void pci_hp_ignore_link_change(struct pci_dev *pdev) { }
> +static inline void pci_hp_unignore_link_change(struct pci_dev *pdev) { }
> +#endif
> +

Generally we expose APIs when we really need it.  Since you have already
identified some use cases where you will use it in other drivers, why not
include one such change as an example?

>   #ifdef CONFIG_PCIEAER
>   bool pci_aer_available(void);
>   #else

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


