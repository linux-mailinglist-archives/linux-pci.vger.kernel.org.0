Return-Path: <linux-pci+bounces-3213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3933D84CF95
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 18:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A2A28D0D6
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 17:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7565E823B9;
	Wed,  7 Feb 2024 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JveCaCXE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA51804F;
	Wed,  7 Feb 2024 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326111; cv=none; b=qTzMQ1GQQ01lpTiVNoMFeW/Eau0FUfbsG3z08Vw06RMeyGxAIhHVLTchhfJjbharQH1PU2Gojercm/sl0jbDZT6+955I0GShaEzYSsiRECt5kZsYzs/iknkyViID3xdIgrbrJhKh12fyH9zDBbwukRVKnbMqAwOIyVNvKI9VEag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326111; c=relaxed/simple;
	bh=lnTSBYc8jgGm1YGCpvFKFrTh0Tdzjt4IaajOxOS3E9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJ/LYkwIpyAUuPIXVW1W0LCo3EQkM4Lp0NWeAxyEPvy5CSXg8URoD8y7EcmJSpx0HZqt0AAmTt+MT4U5ivGWsTLCEjKO7T3jmxw/IQCQC6h3K2vnavd+jI9ZYCyWhVD2HfJZTButLEGjkRdZsXOr3Eu/Ui5dLrjtw9uKZc72Oww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JveCaCXE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707326110; x=1738862110;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lnTSBYc8jgGm1YGCpvFKFrTh0Tdzjt4IaajOxOS3E9s=;
  b=JveCaCXE0Hm0bGl3uuO6W8AhZTSOuAPUpDYqPWhuyyh18/imwAzAAYPF
   aBCIooBzhU+0ldrSjzBNeJshi1SdoK1r8LauCJpvMoI4s9SHwSqpNHfYU
   D/MwKyHAkPdo6uKPy81Buf/+GJEkE8Hnp/5RCG91463wwizbgTHD6Ta0+
   YLqm8St1HCALYE+HxWd9w4hQ+KnpBus8IEb1BO+noyeyd7jeQEupoXTV7
   YYesa6R5WnfyGypV1NlIfHjcElCX1CYK1FD/7u5TrFukg19Z6N2Pb3Kh4
   4vSo1UkP8BrOZ+a4qgp8Bf5tUsDOGNdnVJDS7Fy31Eee6YlGVLJdKSxGh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="23510889"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="23510889"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:15:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="32194314"
Received: from srussjr-mobl1.amr.corp.intel.com (HELO [10.209.91.249]) ([10.209.91.249])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:15:08 -0800
Message-ID: <01cc1ecc-5b61-42ab-8763-9194c4cbfc18@linux.intel.com>
Date: Wed, 7 Feb 2024 09:15:07 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] PCI/DPC: Ignore Surprise Down error on hot removal
Content-Language: en-US
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>,
 Yazen Ghannam <yazen.ghannam@amd.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
References: <20240207111256.110982-1-Smita.KoralahalliChannabasappa@amd.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240207111256.110982-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/7/24 3:12 AM, Smita Koralahalli wrote:
> According to PCIe r6.0 sec 6.7.6 [1], async removal with DPC may result in
> surprise down error. This error is expected and is just a side-effect of
> async remove.
>
> Ignore surprise down error generated as a side-effect of async remove.
> Typically, this error is benign as the pciehp handler invoked by PDC
> or/and DLLSC alongside DPC, de-enumerates and brings down the device
> appropriately. But the error messages might confuse users. Get rid of
> these irritating log messages with a 1s delay while pciehp waits for
> dpc recovery.
>
> The implementation is as follows: On an async remove a DPC is triggered
> along with a Presence Detect State change and/or DLL State Change.
> Determine it's an async remove by checking for DPC Trigger Status in DPC
> Status Register and Surprise Down Error Status in AER Uncorrected Error
> Status to be non-zero. If true, treat the DPC event as a side-effect of
> async remove, clear the error status registers and continue with hot-plug
> tear down routines. If not, follow the existing routine to handle AER and
> DPC errors.
>
> Please note that, masking Surprise Down Errors was explored as an
> alternative approach, but left due to the odd behavior that masking only
> avoids the interrupt, but still records an error per PCIe r6.0.1 Section
> 6.2.3.2.2. That stale error is going to be reported the next time some
> error other than Surprise Down is handled.
>
> Dmesg before:
>
>   pcieport 0000:00:01.4: DPC: containment event, status:0x1f01 source:0x0000
>   pcieport 0000:00:01.4: DPC: unmasked uncorrectable error detected
>   pcieport 0000:00:01.4: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
>   pcieport 0000:00:01.4:   device [1022:14ab] error status/mask=00000020/04004000
>   pcieport 0000:00:01.4:    [ 5] SDES (First)
>   nvme nvme2: frozen state error detected, reset controller
>   pcieport 0000:00:01.4: DPC: Data Link Layer Link Active not set in 1000 msec
>   pcieport 0000:00:01.4: AER: subordinate device reset failed
>   pcieport 0000:00:01.4: AER: device recovery failed
>   pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
>   nvme2n1: detected capacity change from 1953525168 to 0
>   pci 0000:04:00.0: Removing from iommu group 49
>
> Dmesg after:
>
>  pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
>  nvme1n1: detected capacity change from 1953525168 to 0
>  pci 0000:04:00.0: Removing from iommu group 37
>
> [1] PCI Express Base Specification Revision 6.0, Dec 16 2021.
>     https://members.pcisig.com/wg/PCI-SIG/document/16609
>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> v2:
> 	Indentation is taken care. (Bjorn)
> 	Unrelevant dmesg logs are removed. (Bjorn)
> 	Rephrased commit message, to be clear on native vs FW-First
> 	handling. (Bjorn and Sathyanarayanan)
> 	Prefix changed from pciehp_ to dpc_. (Lukas)
> 	Clearing ARI and AtomicOp Requester are performed as a part of
> 	(de-)enumeration in pciehp_unconfigure_device(). (Lukas)
> 	Changed to clearing all optional capabilities in DEVCTL2.
> 	OS-First -> native. (Sathyanarayanan)
>
> v3:
> 	Added error message when root port become inactive.
> 	Modified commit description to add more details.
> 	Rearranged code comments and function calls with no functional
> 	change.
> 	Additional check for is_hotplug_bridge.
> 	dpc_completed_waitqueue to wakeup pciehp handler.
> 	Cleared only Fatal error detected in DEVSTA.
>
> v4:
> 	Made read+write conditional on "if (pdev->dpc_rp_extensions)"
> 	for DPC_RP_PIO_STATUS.
> 	Wrapped to 80 chars.
> 	Code comment for clearing PCI_STATUS and PCI_EXP_DEVSTA.
> 	Added pcie_wait_for_link() check.
> 	Removed error message for root port inactive as the message
> 	already existed.
> 	Check for is_hotplug_bridge before registers read.
> 	Section 6.7.6 of the PCIe Base Spec 6.0 -> PCIe r6.0 sec 6.7.6.
> 	Made code comment more meaningful.
>
> v5:
> 	$SUBJECT correction.
> 	Added "Reviewed-by" tag.
> 	No code changes. Re-spin on latest base to get Bjorn's
> 	attention.
>
> v6:
> 	Change to write 1's to clear error. (Sathyanarayanan)
>
> v7:
> 	No changes. Rebasing on pci main branch as per Bjorn comments.
>
> v8:
> 	Just return "status & PCI_ERR_UNC_SURPDN" instead of true and
> 	false and allow C to handle the conversion to bool. (Ilpo)
> ---
>  drivers/pci/pcie/dpc.c | 64 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 94111e438241..ba7240a2ba2f 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -303,10 +303,74 @@ void dpc_process_error(struct pci_dev *pdev)
>  	}
>  }
>  
> +static void pci_clear_surpdn_errors(struct pci_dev *pdev)
> +{
> +	u32 reg32;
> +
> +	if (pdev->dpc_rp_extensions) {
> +		pci_read_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS,
> +				      &reg32);
> +		pci_write_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS,
> +				       reg32);
> +	}

Nit: Since you don't care about value in PIO_STATUS, you can just write all 1 (~0).

> +
> +	/*
> +	 * In practice, Surprise Down errors have been observed to also set
> +	 * error bits in the Status Register as well as the Fatal Error
> +	 * Detected bit in the Device Status Register.
> +	 */
> +	pci_write_config_word(pdev, PCI_STATUS, 0xffff);
> +
> +	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, PCI_EXP_DEVSTA_FED);
> +}
> +
> +static void dpc_handle_surprise_removal(struct pci_dev *pdev)
> +{
> +	if (!pcie_wait_for_link(pdev, false)) {
> +		pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n");
> +		goto out;
> +	}
> +
> +	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
> +		goto out;
> +
> +	pci_aer_raw_clear_status(pdev);
> +	pci_clear_surpdn_errors(pdev);
> +
> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
> +			      PCI_EXP_DPC_STATUS_TRIGGER);
> +
> +out:
> +	clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
> +	wake_up_all(&dpc_completed_waitqueue);
> +}
> +
> +static bool dpc_is_surprise_removal(struct pci_dev *pdev)
> +{
> +	u16 status;
> +
> +	if (!pdev->is_hotplug_bridge)
> +		return false;
> +
> +	pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS,
> +			     &status);
> +
> +	return status & PCI_ERR_UNC_SURPDN;
> +}
> +
>  static irqreturn_t dpc_handler(int irq, void *context)
>  {
>  	struct pci_dev *pdev = context;
>  
> +	/*
> +	 * According to PCIe r6.0 sec 6.7.6, errors are an expected side effect
> +	 * of async removal and should be ignored by software.
> +	 */
> +	if (dpc_is_surprise_removal(pdev)) {
> +		dpc_handle_surprise_removal(pdev);
> +		return IRQ_HANDLED;
> +	}
> +
>  	dpc_process_error(pdev);
>  
>  	/* We configure DPC so it only triggers on ERR_FATAL */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


