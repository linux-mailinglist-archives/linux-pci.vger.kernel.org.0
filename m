Return-Path: <linux-pci+bounces-20261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83799A19DCB
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 05:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B466A167387
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 04:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046FC1ADC6E;
	Thu, 23 Jan 2025 04:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTX3KxKC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BA81ADC72;
	Thu, 23 Jan 2025 04:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737608048; cv=none; b=iVCH8vkT3POd/9TELxnWmkUe4sk4hTOom0d1emol13fteUgwBhZ3P/aApDSmA/xo+UKCcR1HPxhFoECCt7dytvi0LGdQ+JrNY5IzUGwLaOIHW3A/giXKbmYXKydqc2sbGbIiS1k+/NBZ7dmGjLL6eMgugqMgMXiXFDHxlQAIOdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737608048; c=relaxed/simple;
	bh=VHtOVhntom8BTB/HjIiTtRyLLhH4JYi4Dw+wmQMvLB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMMpEpAyaec0pKX9aETK/qnkStm6Uto1gd0Oed5N7KJZ30l8wN832JOswKfj+M70sfZ5ZgMvjEX4VtG0y0zWD+zqy5LWLUzptB0jFORK7kUiuTHSFmBS403PjQnQL73x8fi1CGbnBq6oYsQLWMZj/Mfi2nv0UPd8AFKbxZ3xvxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTX3KxKC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737608047; x=1769144047;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VHtOVhntom8BTB/HjIiTtRyLLhH4JYi4Dw+wmQMvLB8=;
  b=UTX3KxKC7+wrq55vOgEp7hLOU91Mda959HmJAFeuYzr5Ajmzbr2Bzi8/
   E4W72Uynz6o1//PIR8ch+GMGyT5GC8JS3Hcsac4mBrjuuvCh3kYs5uFZd
   BJEbBDsDwwFWU9CM9eSfILNIbcumDVu6n9q6E11H3j8Odvf9odcJyK2vF
   pkdJwKcQssqRXyH/+vu1H+TctBDEvQYyOxKco6+pAa5oE2UOLfqADdP8f
   f+KTQRzJSfqo/x9NF0XGnn6CYswtMgazCKANCF0oUEljbyRNwgarSJdW9
   Z8LWSNCvdf3cKSN3+NHwPYH1I5HF9LTk3Slrg0pFWn5dEu4Pc0zf8Oky+
   g==;
X-CSE-ConnectionGUID: wp4jsG3cTdeNwLhf9j7aZA==
X-CSE-MsgGUID: kK+p3YxMTIefLFZ8e/uPPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="37973431"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="37973431"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 20:54:06 -0800
X-CSE-ConnectionGUID: ywOf4q6/SX+lRRBTyVEc0Q==
X-CSE-MsgGUID: MJk9QptgQA6OEDkWOIVucg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112457096"
Received: from johunt-mobl9.ger.corp.intel.com (HELO [10.124.223.40]) ([10.124.223.40])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 20:54:05 -0800
Message-ID: <b109aca6-1eb2-43d2-b9c9-fb014d00bf7d@linux.intel.com>
Date: Wed, 22 Jan 2025 20:53:48 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI/DPC: Run recovery on device that detected the
 error
To: Shuai Xue <xueshuai@linux.alibaba.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bhelgaas@google.com, kbusch@kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com
References: <20241112135419.59491-1-xueshuai@linux.alibaba.com>
 <20241112135419.59491-2-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20241112135419.59491-2-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/12/24 5:54 AM, Shuai Xue wrote:
> The current implementation of pcie_do_recovery() assumes that the
> recovery process is executed on the device that detected the error.
> However, the DPC driver currently passes the error port that experienced
> the DPC event to pcie_do_recovery().
>
> Use the SOURCE ID register to correctly identify the device that detected the
> error. By passing this error device to pcie_do_recovery(), subsequent
> patches will be able to accurately access AER status of the error device.

When passing the error device, I assume pcie_do_recovery() will find the
upstream bride and run the recovery logic .

>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---

IMO, moving the "err_port" rename to a separate patch will make this change
more clear.  But it is up to you.

>   drivers/pci/pci.h      |  2 +-
>   drivers/pci/pcie/dpc.c | 30 ++++++++++++++++++++++++------
>   drivers/pci/pcie/edr.c | 35 ++++++++++++++++++-----------------
>   3 files changed, 43 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 14d00ce45bfa..0866f79aec54 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -521,7 +521,7 @@ struct rcec_ea {
>   void pci_save_dpc_state(struct pci_dev *dev);
>   void pci_restore_dpc_state(struct pci_dev *dev);
>   void pci_dpc_init(struct pci_dev *pdev);
> -void dpc_process_error(struct pci_dev *pdev);
> +struct pci_dev *dpc_process_error(struct pci_dev *pdev);
>   pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
>   bool pci_dpc_recovered(struct pci_dev *pdev);
>   #else
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 2b6ef7efa3c1..62a68cde4364 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -257,10 +257,17 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>   	return 1;
>   }
>   
> -void dpc_process_error(struct pci_dev *pdev)
> +/**
> + * dpc_process_error - handle the DPC error status

Handling the DPC error status has nothing to do with finding
the error source. Why not add a new helper function?

> + * @pdev: the port that experienced the containment event
> + *
> + * Return the device that experienced the error.
detected the error?
> + */
> +struct pci_dev *dpc_process_error(struct pci_dev *pdev)
>   {
>   	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
>   	struct aer_err_info info;
> +	struct pci_dev *err_dev = NULL;

I don't think you need NULL initialization here.

>   
>   	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
>   	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
> @@ -283,6 +290,13 @@ void dpc_process_error(struct pci_dev *pdev)
>   		 "software trigger" :
>   		 "reserved error");
>   
> +	if (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE ||
> +	    reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE)
> +		err_dev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
> +					    PCI_BUS_NUM(source), source & 0xff);
> +	else
> +		err_dev = pci_dev_get(pdev);
> +
>   	/* show RP PIO error detail information */
>   	if (pdev->dpc_rp_extensions &&
>   	    reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_IN_EXT &&
> @@ -295,6 +309,8 @@ void dpc_process_error(struct pci_dev *pdev)
>   		pci_aer_clear_nonfatal_status(pdev);
>   		pci_aer_clear_fatal_status(pdev);
>   	}
> +
> +	return err_dev;
>   }
>   
>   static void pci_clear_surpdn_errors(struct pci_dev *pdev)
> @@ -350,21 +366,23 @@ static bool dpc_is_surprise_removal(struct pci_dev *pdev)
>   
>   static irqreturn_t dpc_handler(int irq, void *context)
>   {
> -	struct pci_dev *pdev = context;
> +	struct pci_dev *err_port = context, *err_dev = NULL;

NULL initialization is not needed.

>   
>   	/*
>   	 * According to PCIe r6.0 sec 6.7.6, errors are an expected side effect
>   	 * of async removal and should be ignored by software.
>   	 */
> -	if (dpc_is_surprise_removal(pdev)) {
> -		dpc_handle_surprise_removal(pdev);
> +	if (dpc_is_surprise_removal(err_port)) {
> +		dpc_handle_surprise_removal(err_port);
>   		return IRQ_HANDLED;
>   	}
>   
> -	dpc_process_error(pdev);
> +	err_dev = dpc_process_error(err_port);
>   
>   	/* We configure DPC so it only triggers on ERR_FATAL */
> -	pcie_do_recovery(pdev, pci_channel_io_frozen, dpc_reset_link);
> +	pcie_do_recovery(err_dev, pci_channel_io_frozen, dpc_reset_link);
> +
> +	pci_dev_put(err_dev);
>   
>   	return IRQ_HANDLED;
>   }
> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
> index e86298dbbcff..6ac95e5e001b 100644
> --- a/drivers/pci/pcie/edr.c
> +++ b/drivers/pci/pcie/edr.c
> @@ -150,7 +150,7 @@ static int acpi_send_edr_status(struct pci_dev *pdev, struct pci_dev *edev,
>   
>   static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>   {
> -	struct pci_dev *pdev = data, *edev;
> +	struct pci_dev *pdev = data, *err_port, *err_dev = NULL;
>   	pci_ers_result_t estate = PCI_ERS_RESULT_DISCONNECT;
>   	u16 status;
>   
> @@ -169,36 +169,36 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>   	 * may be that port or a parent of it (PCI Firmware r3.3, sec
>   	 * 4.6.13).
>   	 */
> -	edev = acpi_dpc_port_get(pdev);
> -	if (!edev) {
> +	err_port = acpi_dpc_port_get(pdev);
> +	if (!err_port) {
>   		pci_err(pdev, "Firmware failed to locate DPC port\n");
>   		return;
>   	}
>   
> -	pci_dbg(pdev, "Reported EDR dev: %s\n", pci_name(edev));
> +	pci_dbg(pdev, "Reported EDR dev: %s\n", pci_name(err_port));
>   
>   	/* If port does not support DPC, just send the OST */
> -	if (!edev->dpc_cap) {
> -		pci_err(edev, FW_BUG "This device doesn't support DPC\n");
> +	if (!err_port->dpc_cap) {
> +		pci_err(err_port, FW_BUG "This device doesn't support DPC\n");
>   		goto send_ost;
>   	}
>   
>   	/* Check if there is a valid DPC trigger */
> -	pci_read_config_word(edev, edev->dpc_cap + PCI_EXP_DPC_STATUS, &status);
> +	pci_read_config_word(err_port, err_port->dpc_cap + PCI_EXP_DPC_STATUS, &status);
>   	if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
> -		pci_err(edev, "Invalid DPC trigger %#010x\n", status);
> +		pci_err(err_port, "Invalid DPC trigger %#010x\n", status);
>   		goto send_ost;
>   	}
>   
> -	dpc_process_error(edev);
> -	pci_aer_raw_clear_status(edev);
> +	err_dev = dpc_process_error(err_port);
> +	pci_aer_raw_clear_status(err_port);
>   
>   	/*
>   	 * Irrespective of whether the DPC event is triggered by ERR_FATAL
>   	 * or ERR_NONFATAL, since the link is already down, use the FATAL
>   	 * error recovery path for both cases.
>   	 */
> -	estate = pcie_do_recovery(edev, pci_channel_io_frozen, dpc_reset_link);
> +	estate = pcie_do_recovery(err_dev, pci_channel_io_frozen, dpc_reset_link);
>   
>   send_ost:
>   
> @@ -207,15 +207,16 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>   	 * to firmware. If not successful, send _OST(0xF, BDF << 16 | 0x81).
>   	 */
>   	if (estate == PCI_ERS_RESULT_RECOVERED) {
> -		pci_dbg(edev, "DPC port successfully recovered\n");
> -		pcie_clear_device_status(edev);
> -		acpi_send_edr_status(pdev, edev, EDR_OST_SUCCESS);
> +		pci_dbg(err_port, "DPC port successfully recovered\n");
> +		pcie_clear_device_status(err_port);
> +		acpi_send_edr_status(pdev, err_port, EDR_OST_SUCCESS);
>   	} else {
> -		pci_dbg(edev, "DPC port recovery failed\n");
> -		acpi_send_edr_status(pdev, edev, EDR_OST_FAILED);
> +		pci_dbg(err_port, "DPC port recovery failed\n");
> +		acpi_send_edr_status(pdev, err_port, EDR_OST_FAILED);
>   	}
>   
> -	pci_dev_put(edev);
> +	pci_dev_put(err_port);
> +	pci_dev_put(err_dev);
>   }
>   
>   void pci_acpi_add_edr_notifier(struct pci_dev *pdev)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


