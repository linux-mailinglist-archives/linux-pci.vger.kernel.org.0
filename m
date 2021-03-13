Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2CD339B92
	for <lists+linux-pci@lfdr.de>; Sat, 13 Mar 2021 04:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhCMDfK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 22:35:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:47456 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233205AbhCMDfG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 22:35:06 -0500
IronPort-SDR: x4RoNiZqxZAtSjmt6xCPrgQBn8bOY9xFSXLEHGvze/9ZpMLQ89t6zvd3Pos/4dCWT7jCDv7OBl
 /Ln37GVfFjyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="176505656"
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="176505656"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 19:35:05 -0800
IronPort-SDR: 6nWU5CLnW3kF6B4QFZbFJBKVS0mF4dwyr3yugWo3s38CIl4/Ax1nA85BCNG/qexGRriF06SUdx
 qTf4jHzH3wvA==
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="411219740"
Received: from fgeisler-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.251.5.8])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 19:35:05 -0800
Subject: Re: [PATCH v2 1/1] PCI: pciehp: Skip DLLSC handling if DPC is
 triggered
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, dan.j.williams@intel.com, kbusch@kernel.org,
        lukas@wunner.de, knsathya@kernel.org
References: <59cb30f5e5ac6d65427ceaadf1012b2ba8dbf66c.1615606143.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <0bed11bd-8d77-eb30-15fe-2d6af942910a@linux.intel.com>
Date:   Fri, 12 Mar 2021 19:35:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <59cb30f5e5ac6d65427ceaadf1012b2ba8dbf66c.1615606143.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/12/21 7:32 PM, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> When hotplug and DPC are both enabled on a Root port or
> Downstream Port, during DPC events that cause a DLLSC link
> down/up events, such events (DLLSC) must be suppressed to
> let the DPC driver own the recovery path.
> 
> When DPC is present and enabled, hardware will put the port in
> containment state to allow SW to recover from the error condition
> in the seamless manner. But, during the DPC error recovery process,
> since the link is in disabled state, it will also raise the DLLSC
> event. In Linux kernel architecture, DPC events are handled by DPC
> driver and DLLSC events are handled by hotplug driver. If a hotplug
> driver is allowed to handle such DLLSC event (triggered by DPC
> containment), then we will have a race condition between error
> recovery handler (in DPC driver) and hotplug handler in recovering
> the contained port. Allowing such a race leads to a lot of stability
> issues while recovering the  device. So skip DLLSC handling in the
> hotplug driver when the PCIe port associated with the hotplug event is
> in DPC triggered state and let the DPC driver be responsible for the
> port recovery.
> 
> Following is the sample dmesg log which shows the contention
> between hotplug handler and error recovery handler. In this
> case, hotplug handler won the race and error recovery
> handler reported failure.
> 
> pcieport 0000:97:02.0: pciehp: Slot(4): Link Down
> pcieport 0000:97:02.0: DPC: containment event, status:0x1f01 source:0x0000
> pcieport 0000:97:02.0: DPC: unmasked uncorrectable error detected
> pcieport 0000:97:02.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> pcieport 0000:97:02.0:   device [8086:347a] error status/mask=00004000/00100020
> pcieport 0000:97:02.0:    [14] CmpltTO                (First)
> pci 0000:98:00.0: AER: can't recover (no error_detected callback)
> pcieport 0000:97:02.0: pciehp: Slot(4): Card present
> pcieport 0000:97:02.0: DPC: Data Link Layer Link Active not set in 1000 msec
> pcieport 0000:97:02.0: AER: subordinate device reset failed
> pcieport 0000:97:02.0: AER: device recovery failed
> pci 0000:98:00.0: [8086:0953] type 00 class 0x010802
> nvme nvme1: pci function 0000:98:00.0
> nvme 0000:98:00.0: enabling device (0140 -> 0142)
> nvme nvme1: 31/0/0 default/read/poll queues
>   nvme1n2: p1
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Raj Ashok <ashok.raj@intel.com>
> ---
Missed to add the change log. will include it in next version.

Changes since v1:
  * Trimmed down the kernel log in commit history.
  * Removed usage of !! in is_dpc_reset_active().
  * Addressed other minor comments from Bjorn.

>   drivers/pci/hotplug/pciehp_hpc.c | 19 +++++++++++++++++
>   drivers/pci/pci.h                |  2 ++
>   drivers/pci/pcie/dpc.c           | 36 ++++++++++++++++++++++++++++++--
>   include/linux/pci.h              |  1 +
>   4 files changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index fb3840e222ad..55da5208c7e5 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -691,6 +691,25 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>   		goto out;
>   	}
>   
> +	/*
> +	 * If the DLLSC link up/down event is generated due to DPC containment
> +	 * in the PCIe port, skip the DLLSC event handling and let the DPC
> +	 * driver own the port recovery. Allowing both hotplug DLLSC event
> +	 * handler and DPC event trigger handler to attempt recovery on the
> +	 * same port leads to stability issues. If DPC recovery is successful,
> +	 * is_dpc_reset_active() will return false and the hotplug handler will
> +	 * not suppress the DLLSC event. If DPC recovery fails and the link is
> +	 * left in disabled state, once the user changes the faulty card, the
> +	 * hotplug handler can still handle the PRESENCE change event and bring
> +	 * the device back up.
> +	 */
> +	if ((events == PCI_EXP_SLTSTA_DLLSC) && is_dpc_reset_active(pdev)) {
> +		ctrl_info(ctrl, "Slot(%s): DLLSC event(DPC), skipped\n",
> +			  slot_name(ctrl));
> +		ret = IRQ_HANDLED;
> +		goto out;
> +	}
> +
>   	/* Check Attention Button Pressed */
>   	if (events & PCI_EXP_SLTSTA_ABP) {
>   		ctrl_info(ctrl, "Slot(%s): Attention button pressed\n",
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ef7c4661314f..cee7095483bd 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -446,10 +446,12 @@ void pci_restore_dpc_state(struct pci_dev *dev);
>   void pci_dpc_init(struct pci_dev *pdev);
>   void dpc_process_error(struct pci_dev *pdev);
>   pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
> +bool is_dpc_reset_active(struct pci_dev *pdev);
>   #else
>   static inline void pci_save_dpc_state(struct pci_dev *dev) {}
>   static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
>   static inline void pci_dpc_init(struct pci_dev *pdev) {}
> +static inline bool is_dpc_reset_active(struct pci_dev *pdev) { return false; }
>   #endif
>   
>   #ifdef CONFIG_PCIEPORTBUS
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index e05aba86a317..9157d70ebe21 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -71,6 +71,33 @@ void pci_restore_dpc_state(struct pci_dev *dev)
>   	pci_write_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL, *cap);
>   }
>   
> +bool is_dpc_reset_active(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +	u16 status;
> +
> +	if (!dev->dpc_cap)
> +		return false;
> +
> +	/*
> +	 * If DPC is owned by firmware and EDR is not supported, there is
> +	 * no race between hotplug and DPC recovery handler. So return
> +	 * false.
> +	 */
> +	if (!host->native_dpc && !IS_ENABLED(CONFIG_PCIE_EDR))
> +		return false;
> +
> +	if (atomic_read_acquire(&dev->dpc_reset_active))
> +		return true;
> +
> +	pci_read_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_STATUS, &status);
> +
> +	if (status & PCI_EXP_DPC_STATUS_TRIGGER)
> +		return true;
> +
> +	return false;
> +}
> +
>   static int dpc_wait_rp_inactive(struct pci_dev *pdev)
>   {
>   	unsigned long timeout = jiffies + HZ;
> @@ -91,6 +118,7 @@ static int dpc_wait_rp_inactive(struct pci_dev *pdev)
>   
>   pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>   {
> +	pci_ers_result_t status = PCI_ERS_RESULT_RECOVERED;
>   	u16 cap;
>   
>   	/*
> @@ -109,15 +137,19 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>   	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
>   		return PCI_ERS_RESULT_DISCONNECT;
>   
> +	atomic_inc_return_acquire(&pdev->dpc_reset_active);
> +
>   	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
>   			      PCI_EXP_DPC_STATUS_TRIGGER);
>   
>   	if (!pcie_wait_for_link(pdev, true)) {
>   		pci_info(pdev, "Data Link Layer Link Active not set in 1000 msec\n");
> -		return PCI_ERS_RESULT_DISCONNECT;
> +		status = PCI_ERS_RESULT_DISCONNECT;
>   	}
>   
> -	return PCI_ERS_RESULT_RECOVERED;
> +	atomic_dec_return_release(&pdev->dpc_reset_active);
> +
> +	return status;
>   }
>   
>   static void dpc_process_rp_pio_error(struct pci_dev *pdev)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 86c799c97b77..3314f616520d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -479,6 +479,7 @@ struct pci_dev {
>   	u16		dpc_cap;
>   	unsigned int	dpc_rp_extensions:1;
>   	u8		dpc_rp_log_size;
> +	atomic_t	dpc_reset_active;	/* DPC trigger is active */
>   #endif
>   #ifdef CONFIG_PCI_ATS
>   	union {
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
