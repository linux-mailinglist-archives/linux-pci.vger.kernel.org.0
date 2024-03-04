Return-Path: <linux-pci+bounces-4475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 577A5870B36
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 21:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BFE1C221F0
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 20:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD097A150;
	Mon,  4 Mar 2024 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="choMJGc6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1127A12E;
	Mon,  4 Mar 2024 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583032; cv=none; b=uzDiGt7gnhQ8xY9dU8L+tpr+O1x/aLcArF7mUz0w1ojI3UHNKDVVJMtZXqw2q1HqMLcpghCpmbgSV/zFiN3fkSf1whmytd4dUHmzoSdbzqgyd6hARRPHRFZKaS/xCTEtCeu8c76cQtuoe0Wp4mY0f0zPAWbgRo6eyBpjk3hwAWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583032; c=relaxed/simple;
	bh=ORa3w3T3UxRI7Q/DXMeLntlDVqx5vmqR80tifIbBiwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tllK+ylHcrwWulDo/16PlSvgr1PlWuoRR4GAAb/h4Ytbz9xvj6Y4pP/+v/Yglehmeqm/tsTQyS/FBliW4JjDYPc5jGhuKeaQyuTHmn4FanAo/T5059302IV1bjQL3pgr8CiotCj3gUue9L3nzwYeueh7k5aQDvmFfPZwFI5DXUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=choMJGc6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709583030; x=1741119030;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ORa3w3T3UxRI7Q/DXMeLntlDVqx5vmqR80tifIbBiwY=;
  b=choMJGc6A2Hs9U6ffRkNFA1Hfm9aTU9yqOASEqam6JxtLWb+0Pq+SGpL
   zHBPol6F8p5dctjLb2S7CVVfTJVyZeMrGhh7XvaK7lyCNKCfXP5GhIdwm
   f9VaW3fteIeRLUbNwuk81wANo5KswMxg9mlodN1BuetQKUgkXE8IQ1tUw
   tC8XyQW0Aron7JUUuLZt1W63Bi9MjANr9azQ4xpGp2l50Fmzk4h9VeyRx
   B998FPzcPL2H0M+YiFH3m6EIZN3ukLE8qAQbJLCQ+ZqkbHW85KzNE9OzH
   lN3ZP7eZVD+VsHvierRFcI/UjtVe5EHzE3bOLmFTWGZP44DRSjKpMy6ms
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4224796"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="4224796"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 12:10:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9289124"
Received: from cbrown-mobl1.amr.corp.intel.com (HELO [10.209.66.113]) ([10.209.66.113])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 12:10:25 -0800
Message-ID: <71acbf58-a05d-4842-bc6b-c4e66e1a2b58@linux.intel.com>
Date: Mon, 4 Mar 2024 12:10:24 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH pci-next] pci/edr: Ignore Surprise Down error on hot
 removal
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, bhelgaas@google.com,
 lukas@wunner.de
Cc: Smita.KoralahalliChannabasappa@amd.com, ilpo.jarvinen@linux.intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kbusch@kernel.org
References: <20240304090819.3812465-1-haifeng.zhao@linux.intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240304090819.3812465-1-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/4/24 1:08 AM, Ethan Zhao wrote:
> Per PCI firmware spec r3.3 sec 4.6.12, for firmware first mode DPC
> handling path, FW should clear UC errors logged by port and bring link
> out of DPC, but because of ambiguity of wording in the spec, some BIOSes
> doesn't clear the surprise down error and the error bits in pci status,

As Lukas mentioned, please include the hardware and BIOS version
where you see this issue.

> still notify OS to handle it. thus following trick is needed in EDR when
> double reporting (hot removal interrupt && dpc notification) is hit.

EDR notification is generally used when a firmware wants OS to invalidate
or recover the error state of child devices when handling a containment event.
Since this DPC event is a side effect of async removal, there is no recovery
involved. So there is no value in firmware notifying the OS via an ACPI notification
and then OS ignoring it.

If you check the PCIe firmware spec, sec 4.6.12, IMPLEMENTATION NOTE, it
recommends firmware to ignore the DPC due to hotplug surprise.

>
> https://patchwork.kernel.org/project/linux-pci/patch/20240207181854.
> 121335-1-Smita.KoralahalliChannabasappa@amd.com/
>
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
>  drivers/pci/pci.h      | 1 +
>  drivers/pci/pcie/dpc.c | 9 +++++----
>  drivers/pci/pcie/edr.c | 3 +++
>  3 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 50134b5e3235..3787bb32e724 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -443,6 +443,7 @@ void pci_save_dpc_state(struct pci_dev *dev);
>  void pci_restore_dpc_state(struct pci_dev *dev);
>  void pci_dpc_init(struct pci_dev *pdev);
>  void dpc_process_error(struct pci_dev *pdev);
> +bool dpc_handle_surprise_removal(struct pci_dev *pdev);
>  pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
>  bool pci_dpc_recovered(struct pci_dev *pdev);
>  #else
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 98b42e425bb9..be79f205e04c 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -319,8 +319,10 @@ static void pci_clear_surpdn_errors(struct pci_dev *pdev)
>  	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, PCI_EXP_DEVSTA_FED);
>  }
>  
> -static void dpc_handle_surprise_removal(struct pci_dev *pdev)
> +bool  dpc_handle_surprise_removal(struct pci_dev *pdev)
>  {
> +	if (!dpc_is_surprise_removal(pdev))
> +		return false;
>  	if (!pcie_wait_for_link(pdev, false)) {
>  		pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n");
>  		goto out;
> @@ -338,6 +340,7 @@ static void dpc_handle_surprise_removal(struct pci_dev *pdev)
>  out:
>  	clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
>  	wake_up_all(&dpc_completed_waitqueue);
> +	return true;
>  }
>  
>  static bool dpc_is_surprise_removal(struct pci_dev *pdev)
> @@ -362,10 +365,8 @@ static irqreturn_t dpc_handler(int irq, void *context)
>  	 * According to PCIe r6.0 sec 6.7.6, errors are an expected side effect
>  	 * of async removal and should be ignored by software.
>  	 */
> -	if (dpc_is_surprise_removal(pdev)) {
> -		dpc_handle_surprise_removal(pdev);
> +	if (dpc_handle_surprise_removal(pdev))
>  		return IRQ_HANDLED;
> -	}
>  
>  	dpc_process_error(pdev);
>  
> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
> index 5f4914d313a1..556edfb2696a 100644
> --- a/drivers/pci/pcie/edr.c
> +++ b/drivers/pci/pcie/edr.c
> @@ -184,6 +184,9 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>  		goto send_ost;
>  	}
>  
> +	if (dpc_handle_surprise_removal(edev))
> +		goto send_ost;
> +
>  	dpc_process_error(edev);
>  	pci_aer_raw_clear_status(edev);
>  
>
> base-commit: a66f2b4a4d365dc4bac35576f3a9d4f5982f1d63

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


