Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF1F34F28A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 22:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhC3Uxk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 16:53:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:43085 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232531AbhC3UxQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Mar 2021 16:53:16 -0400
IronPort-SDR: NsHOU4UCk03AD0SnfqVOJW21JLWRrH021VGH0ZLhgH4hwtAQi1Oodls/xiYOGUZuNkKlSd9Tdj
 0qneVbvuH5ng==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="191329024"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="191329024"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 13:53:14 -0700
IronPort-SDR: Hm3f6Lmq23Os4rKdqSRo6sbvkRusMPjFAAxy+TQhzuJIZLXEJAbwrHHyKq2xkocQ5Yk3OzApGl
 GMH5COAZXneQ==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="527481301"
Received: from valbert-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.205.200])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 13:53:13 -0700
Subject: Re: [PATCH] PCI: pciehp: Ignore Link Down/Up caused by DPC
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ethan Zhao <haifeng.zhao@intel.com>, Sinan Kaya <okaya@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <b70e19324bbdded90b728a5687aa78dc17c20306.1616921228.git.lukas@wunner.de>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <13bbd4f9-dff4-be79-d80a-342399961939@linux.intel.com>
Date:   Tue, 30 Mar 2021 13:53:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b70e19324bbdded90b728a5687aa78dc17c20306.1616921228.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/28/21 1:52 AM, Lukas Wunner wrote:
> Downstream Port Containment (PCIe Base Spec, sec. 6.2.10) disables the
> link upon an error and attempts to re-enable it when instructed by the
> DPC driver.
> 
> A slot which is both DPC- and hotplug-capable is currently brought down
> by pciehp once DPC is triggered (due to the link change) and brought up
> on successful recovery.  That's undesirable, the slot should remain up
> so that the hotplugged device remains bound to its driver.  DPC notifies
> the driver of the error and of successful recovery in pcie_do_recovery()
> and the driver may then restore the device to working state.
> 
> Moreover, Sinan points out that turning off slot power by pciehp may
> foil recovery by DPC:  Power off/on is a cold reset concurrently to
> DPC's warm reset.  Sathyanarayanan reports extended delays or failure
> in link retraining by DPC if pciehp brings down the slot.
> 
> Fix by detecting whether a Link Down event is caused by DPC and awaiting
> recovery if so.  On successful recovery, ignore both the Link Down and
> the subsequent Link Up event.
> 
> Afterwards, check whether the link is down to detect surprise-removal or
> another DPC event immediately after DPC recovery.  Ensure that the
> corresponding DLLSC event is not ignored by synthesizing it and
> invoking irq_wake_thread() to trigger a re-run of pciehp_ist().
> 
> The IRQ threads of the hotplug and DPC drivers, pciehp_ist() and
> dpc_handler(), race against each other.  If pciehp is faster than DPC,
> it will wait until DPC recovery completes.
> 
> Recovery consists of two steps:  The first step (waiting for link
> disablement) is recognizable by pciehp through a set DPC Trigger Status
> bit.  The second step (waiting for link retraining) is recognizable
> through a newly introduced PCI_DPC_RECOVERING flag.
> 
> If DPC is faster than pciehp, neither of the two flags will be set and
> pciehp may glean the recovery status from the new PCI_DPC_RECOVERED flag.
> The flag is zero if DPC didn't occur at all, hence DLLSC events are not
> ignored by default.
> 
> This commit draws inspiration from previous attempts to synchronize DPC
> with pciehp:
> 
> By Sinan Kaya, August 2018:
> https://lore.kernel.org/linux-pci/20180818065126.77912-1-okaya@kernel.org/
> 
> By Ethan Zhao, October 2020:
> https://lore.kernel.org/linux-pci/20201007113158.48933-1-haifeng.zhao@intel.com/
> 
> By Sathyanarayanan Kuppuswamy, March 2021:
> https://lore.kernel.org/linux-pci/59cb30f5e5ac6d65427ceaadf1012b2ba8dbf66c.1615606143.git.sathyanarayanan.kuppuswamy@linux.intel.com/
Looks good to me. This patch fixes the reported issue in our environment.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Tested-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> 
> Reported-by: Sinan Kaya <okaya@kernel.org>
> Reported-by: Ethan Zhao <haifeng.zhao@intel.com>
> Reported-by: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/pci/hotplug/pciehp_hpc.c | 36 ++++++++++++++++
>   drivers/pci/pci.h                |  4 ++
>   drivers/pci/pcie/dpc.c           | 73 +++++++++++++++++++++++++++++---
>   3 files changed, 108 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index fb3840e222ad..9d06939736c0 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -563,6 +563,32 @@ void pciehp_power_off_slot(struct controller *ctrl)
>   		 PCI_EXP_SLTCTL_PWR_OFF);
>   }
>   
> +static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
> +					  struct pci_dev *pdev, int irq)
> +{
> +	/*
> +	 * Ignore link changes which occurred while waiting for DPC recovery.
> +	 * Could be several if DPC triggered multiple times consecutively.
> +	 */
> +	synchronize_hardirq(irq);
> +	atomic_and(~PCI_EXP_SLTSTA_DLLSC, &ctrl->pending_events);
> +	if (pciehp_poll_mode)
> +		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
> +					   PCI_EXP_SLTSTA_DLLSC);
> +	ctrl_info(ctrl, "Slot(%s): Link Down/Up ignored (recovered by DPC)\n",
> +		  slot_name(ctrl));
> +
> +	/*
> +	 * If the link is unexpectedly down after successful recovery,
> +	 * the corresponding link change may have been ignored above.
> +	 * Synthesize it to ensure that it is acted on.
> +	 */
> +	down_read(&ctrl->reset_lock);
> +	if (!pciehp_check_link_active(ctrl))
> +		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
> +	up_read(&ctrl->reset_lock);
> +}
> +
>   static irqreturn_t pciehp_isr(int irq, void *dev_id)
>   {
>   	struct controller *ctrl = (struct controller *)dev_id;
> @@ -706,6 +732,16 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>   				      PCI_EXP_SLTCTL_ATTN_IND_ON);
>   	}
>   
> +	/*
> +	 * Ignore Link Down/Up events caused by Downstream Port Containment
> +	 * if recovery from the error succeeded.
> +	 */
> +	if ((events & PCI_EXP_SLTSTA_DLLSC) && pci_dpc_recovered(pdev) &&
> +	    ctrl->state == ON_STATE) {
> +		events &= ~PCI_EXP_SLTSTA_DLLSC;
> +		pciehp_ignore_dpc_link_change(ctrl, pdev, irq);
> +	}
> +
>   	/*
>   	 * Disable requests have higher priority than Presence Detect Changed
>   	 * or Data Link Layer State Changed events.
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9684b468267f..e5ae5e860431 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -392,6 +392,8 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
>   
>   /* pci_dev priv_flags */
>   #define PCI_DEV_ADDED 0
> +#define PCI_DPC_RECOVERED 1
> +#define PCI_DPC_RECOVERING 2
>   
>   static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
>   {
> @@ -446,10 +448,12 @@ void pci_restore_dpc_state(struct pci_dev *dev);
>   void pci_dpc_init(struct pci_dev *pdev);
>   void dpc_process_error(struct pci_dev *pdev);
>   pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
> +bool pci_dpc_recovered(struct pci_dev *pdev);
>   #else
>   static inline void pci_save_dpc_state(struct pci_dev *dev) {}
>   static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
>   static inline void pci_dpc_init(struct pci_dev *pdev) {}
> +static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
>   #endif
>   
>   #ifdef CONFIG_PCIEPORTBUS
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index e05aba86a317..da47c448db8a 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -71,6 +71,57 @@ void pci_restore_dpc_state(struct pci_dev *dev)
>   	pci_write_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL, *cap);
>   }
>   
> +static DECLARE_WAIT_QUEUE_HEAD(dpc_completed_waitqueue);
> +
> +#ifdef CONFIG_HOTPLUG_PCI_PCIE
> +static bool dpc_completed(struct pci_dev *pdev)
> +{
> +	u16 status;
> +
> +	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS, &status);
> +	if ((status != 0xffff) && (status & PCI_EXP_DPC_STATUS_TRIGGER))
> +		return false;
> +
> +	if (test_bit(PCI_DPC_RECOVERING, &pdev->priv_flags))
> +		return false;
> +
> +	return true;
> +}
> +
> +/**
> + * pci_dpc_recovered - whether DPC triggered and has recovered successfully
> + * @pdev: PCI device
> + *
> + * Return true if DPC was triggered for @pdev and has recovered successfully.
> + * Wait for recovery if it hasn't completed yet.  Called from the PCIe hotplug
> + * driver to recognize and ignore Link Down/Up events caused by DPC.
> + */
> +bool pci_dpc_recovered(struct pci_dev *pdev)
> +{
> +	struct pci_host_bridge *host;
> +
> +	if (!pdev->dpc_cap)
> +		return false;
> +
> +	/*
> +	 * Synchronization between hotplug and DPC is not supported
> +	 * if DPC is owned by firmware and EDR is not enabled.
> +	 */
> +	host = pci_find_host_bridge(pdev->bus);
> +	if (!host->native_dpc && !IS_ENABLED(CONFIG_PCIE_EDR))
> +		return false;
> +
> +	/*
> +	 * Need a timeout in case DPC never completes due to failure of
> +	 * dpc_wait_rp_inactive().
> +	 */
> +	wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
> +			   msecs_to_jiffies(3000));
> +
> +	return test_and_clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
> +}
> +#endif /* CONFIG_HOTPLUG_PCI_PCIE */
> +
>   static int dpc_wait_rp_inactive(struct pci_dev *pdev)
>   {
>   	unsigned long timeout = jiffies + HZ;
> @@ -91,8 +142,11 @@ static int dpc_wait_rp_inactive(struct pci_dev *pdev)
>   
>   pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>   {
> +	pci_ers_result_t ret;
>   	u16 cap;
>   
> +	set_bit(PCI_DPC_RECOVERING, &pdev->priv_flags);
> +
>   	/*
>   	 * DPC disables the Link automatically in hardware, so it has
>   	 * already been reset by the time we get here.
> @@ -106,18 +160,27 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>   	if (!pcie_wait_for_link(pdev, false))
>   		pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n");
>   
> -	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
> -		return PCI_ERS_RESULT_DISCONNECT;
> +	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev)) {
> +		clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
> +		ret = PCI_ERS_RESULT_DISCONNECT;
> +		goto out;
> +	}
>   
>   	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
>   			      PCI_EXP_DPC_STATUS_TRIGGER);
>   
>   	if (!pcie_wait_for_link(pdev, true)) {
>   		pci_info(pdev, "Data Link Layer Link Active not set in 1000 msec\n");
> -		return PCI_ERS_RESULT_DISCONNECT;
> +		clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
> +		ret = PCI_ERS_RESULT_DISCONNECT;
> +	} else {
> +		set_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
> +		ret = PCI_ERS_RESULT_RECOVERED;
>   	}
> -
> -	return PCI_ERS_RESULT_RECOVERED;
> +out:
> +	clear_bit(PCI_DPC_RECOVERING, &pdev->priv_flags);
> +	wake_up_all(&dpc_completed_waitqueue);
> +	return ret;
>   }
>   
>   static void dpc_process_rp_pio_error(struct pci_dev *pdev)
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
