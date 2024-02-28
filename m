Return-Path: <linux-pci+bounces-4193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D12786B4C7
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 17:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B3A28C49A
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 16:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A646EEFD;
	Wed, 28 Feb 2024 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqG0KGBr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BFC6EEE1;
	Wed, 28 Feb 2024 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137549; cv=none; b=F+pRGjhrr+3zSgTZmxvylpdRRW2ASzUOSNqqvlGxgxaQJ1G3pw1gOth/ByFqf0Lh0aC0StcP2GW+e9agDdsyD3uhTM5VvH1Z7rdZO4xvyFxxGBBUKLYWjH98cNBpNi3etHewbnIvV2c7P2ttTaVsmfYL19ZXiahP1lOh9H869/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137549; c=relaxed/simple;
	bh=I3Ry+AyxVFp2fepKf56qSbxbBz0NZWBFMR4xiWNttqI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nSyg5lgWqTTUplOt3IkfHr2VxmZXK57Havn2V3SF/Ad3LLv0JOLXcOUj+R1McVLkerTNVj0HwZ3qw51x7nRnuM5yR3WlD0smcdlmpql9Kv1h9xxmbmTC3dqdGzsS3BBMUqLzgRJVYFIai4OVXkAyrRbRlh3rUOAGejpFylRVtL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqG0KGBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF09C43394;
	Wed, 28 Feb 2024 16:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709137548;
	bh=I3Ry+AyxVFp2fepKf56qSbxbBz0NZWBFMR4xiWNttqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RqG0KGBrnXVRymi9pbuDFcM0wj6P0BHkgpfBlPoNCDp399b4p7KA5grrqwGQvjy+C
	 CHcUrpacGUcBxGE+TsXaYYOQav5iZIHQeJVHbAByydpLI0jCH4vFo6fhN/09B3+e4I
	 mj4ol4hWIr9DA1DGIqPGpPvvcaTKv3Y2WONHFC5WZSoN6YA3lG3QY2IFl+BIYDEPHd
	 B7OW70RVzL/+BUPcne96Tf71ttuXhDKPLvhcQxmC7+Be5DG0mX4esdLvYl6SNs5QBv
	 Rx3/vePUySNOb3Q9RMPxYIggiO4U46gG9GdefU2nDvT5N/WdlwkPbO+WuOHdKKOx8e
	 JFDXh0JHRFAtg==
Date: Wed, 28 Feb 2024 10:25:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Lukas Wunner <lukas@wunner.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v9] PCI/DPC: Ignore Surprise Down error on hot removal
Message-ID: <20240228162546.GA275965@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207181854.121335-1-Smita.KoralahalliChannabasappa@amd.com>

On Wed, Feb 07, 2024 at 06:18:54PM +0000, Smita Koralahalli wrote:
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

I tweaked this citation to r6.0 since you cited r6.0 above, and I
don't think r6.0.1 changed anything in this section.

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

Applied to pci/dpc for v6.9, thanks!

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
> 
> v9:
> 	Handle errors from pci_write_config_word().
> 	Write 1 to clear PIO_STATUS.
> ---
>  drivers/pci/pcie/dpc.c | 60 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 94111e438241..17f166504b54 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -303,10 +303,70 @@ void dpc_process_error(struct pci_dev *pdev)
>  	}
>  }
>  
> +static void pci_clear_surpdn_errors(struct pci_dev *pdev)
> +{
> +	if (pdev->dpc_rp_extensions)
> +		pci_write_config_dword(pdev, pdev->dpc_cap +
> +				       PCI_EXP_DPC_RP_PIO_STATUS, ~0);
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
> +	if (pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS,
> +				 &status))
> +		return false;
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
> -- 
> 2.17.1
> 

