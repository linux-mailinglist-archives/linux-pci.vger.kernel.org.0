Return-Path: <linux-pci+bounces-3141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 757A784B53D
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 13:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6441B28A09
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED043D54A;
	Tue,  6 Feb 2024 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A9UWKuJp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FAF1332A6;
	Tue,  6 Feb 2024 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221964; cv=none; b=Hjj71MGLnKZTNjAUPNQIaK6gdfW0Ap5DtY+YYANz+HAVuaZ3vIS22jACO7AmEnGDCJ+nGmG6GFz+BFY2PcMTaqzH/V3h7OrWEapOGSkJtYAcAplS4C2dEBPbyB3vHKp4tmKmXMtXNrkaBQNs+JuaJMa+knsg6uR99a+kKlSwjEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221964; c=relaxed/simple;
	bh=vOPlbom+hZu2FqS78/OBAPTU/ql3MwKYrdqCAkJSiKU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tiK5G1ylD15/VH2fpGmPpbujRRZjugO3Vj18byhu8R0AMxktqAzxUpLJfEBJBIr58qCCGCSeIhENb0IP2G7D7cGF4z/ZK5V5WkcW1D1CPF5IijoHRhotMX/qYYz+GRPox3tImbcu/GMX5ezmriRbnc4o8SVEUmZImCBQyfUipcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A9UWKuJp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707221963; x=1738757963;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vOPlbom+hZu2FqS78/OBAPTU/ql3MwKYrdqCAkJSiKU=;
  b=A9UWKuJpf0ja4NyaMtw8XyX4PiNzwv3v+pmFAPqjVVxKGm9sr0PeDo3l
   Dy0RL3IMfO57ofY02CT6KLcPKJNR6z5hBGcwd4cizz4cbiwW8aiC8o6EV
   mWlWlpJVonIb7RvjiyrZZeiv1wf6abc1topycwZ0fClpxiiQT/gL2ErjJ
   R/6KXTDGr7Glvo3m+oJfjy33V3TwwnbtpQEPH7RxqM38CgHGDkOkbeefP
   VUdtQbjbPCAhHjRS20uE0FmY1mNjBYQ/Ntww+z+rKHZk5/U94Lk1BTN43
   n/k1/Ka5WkPC8aHIyEw4wN59TzhiaCPsMixWzXpCHKb8JgzlP+o9JyuWO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="631608"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="631608"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:19:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="31826258"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.36.139])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:19:18 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Feb 2024 14:19:13 +0200 (EET)
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>, 
    Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v7] PCI/DPC: Ignore Surprise Down error on hot removal
In-Reply-To: <20240205190321.103164-1-Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <881a8ba0-729f-7d36-d696-4fa80b1b03c2@linux.intel.com>
References: <20240205190321.103164-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 5 Feb 2024, Smita Koralahalli wrote:

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
> ---
>  drivers/pci/pcie/dpc.c | 67 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 

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

> +	if (!(status & PCI_ERR_UNC_SURPDN))
> +		return false;
> +
> +	return true;

It would be simpler to just state and also easier to understand:

	return status & PCI_ERR_UNC_SURPDN;

C rules will handle the conversion to bool.

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
 i.


