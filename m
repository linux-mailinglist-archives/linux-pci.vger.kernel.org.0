Return-Path: <linux-pci+bounces-21233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE10A31791
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 22:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110C63A10EC
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 21:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3570F2627E4;
	Tue, 11 Feb 2025 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="murUbaTw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAB22627E0;
	Tue, 11 Feb 2025 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309044; cv=none; b=d2P2HjTk/mmGgcvrIFkDvSDD/6jFmtDpkavptAkylDdNiM+9MPPXE9DHyIslAZIACqnIlI23BVEi+4gaaPK76SakWhc8o2EmI+4e0ySm6wxcN1Z0+GoW2mhGKWQpzGgP19NZ4Mq7oQc0VG8jrN4/TwJbG9r4tDqm03aryqTVJ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309044; c=relaxed/simple;
	bh=6pPNSu5khxEBFBWsc9uEcZ7LoQqrd8LuHQ1iOQbmUx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLRJHdllC1EXDG8Q3OCFu7joea0VtLBbXFtoBJu3Zj6n1h+oFTYMZrBOAfXo8n/pN+rFjU5i6ny+DqKSIrV3qI9Hl+sBpxan77neo5zRQRtszRLikEHQON5zpSwRaKfisarb0xegs+tZiFxSbRCZM8w4SPO0+7jaGPturV6v5UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=murUbaTw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739309043; x=1770845043;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6pPNSu5khxEBFBWsc9uEcZ7LoQqrd8LuHQ1iOQbmUx8=;
  b=murUbaTw9AN4M1vGL4+czDUHxaFU2UAAHgknmc0zdhLfAtVPNK+3H+CC
   IyM5Snk0q19Hicp3coLcTBmU/Yptr49neT9pzRcB6sjXuaw6P5QcLc/Ok
   7L/LRZYvxn9xmenOL0m/xVXzRT8dki3M2KVAs+KEOVi0uty/iMqVfAZ5w
   FXhDDWDHymACnMokjYRKelNOjawBIgnDQKSfCpZlhRkTSgHSlC/l8lrrx
   2Ks3IexhXQ2FTKdPwUmRqLBYOsnbbuPKIQT3AoUdvjvF0KGzXziuNeICu
   /CN9w89dr08VwbiU6v0GQvkg/15F/OyGVOlZpikhVWcubiNUopP7BjOwy
   Q==;
X-CSE-ConnectionGUID: /p1keLGXRT2Bkndf1DGrjQ==
X-CSE-MsgGUID: 6h7udgKTRESx18XTABge/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39183693"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39183693"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:24:02 -0800
X-CSE-ConnectionGUID: X6nVqjD8SWG1wP9zerP9Cg==
X-CSE-MsgGUID: vDvaQ1dTRTmqZ8Kg8ZeVFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="117708689"
Received: from jdoman-desk1.amr.corp.intel.com (HELO [10.124.222.44]) ([10.124.222.44])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:24:01 -0800
Message-ID: <c1837324-98b0-4548-893f-b14e89ced9db@linux.intel.com>
Date: Tue, 11 Feb 2025 13:23:30 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] PCI/DPC: Run recovery on device that detected the
 error
To: Shuai Xue <xueshuai@linux.alibaba.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bhelgaas@google.com, kbusch@kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
 terry.bowman@amd.com
References: <20250207093500.70885-1-xueshuai@linux.alibaba.com>
 <20250207093500.70885-4-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250207093500.70885-4-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/7/25 1:34 AM, Shuai Xue wrote:
> The current implementation of pcie_do_recovery() assumes that the
> recovery process is executed on the device that detected the error.
> However, the DPC driver currently passes the error port that experienced
> the DPC event to pcie_do_recovery().
>
> Use the SOURCE ID register to correctly identify the device that detected the
> error. By passing this error device to pcie_do_recovery(), subsequent
> patches will be able to accurately access AER status of the error device.

I also recommend adding info about the fact that pcie_do_recovery() finds
upstream bridge to run the recovery process and hence should not observe
any functional changes (compared to previous version)


>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>   drivers/pci/pci.h      |  2 +-
>   drivers/pci/pcie/dpc.c | 25 +++++++++++++++++++++----
>   drivers/pci/pcie/edr.c |  7 ++++---
>   3 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 01e51db8d285..870d2fbd6ff2 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -572,7 +572,7 @@ struct rcec_ea {
>   void pci_save_dpc_state(struct pci_dev *dev);
>   void pci_restore_dpc_state(struct pci_dev *dev);
>   void pci_dpc_init(struct pci_dev *pdev);
> -void dpc_process_error(struct pci_dev *pdev);
> +struct pci_dev *dpc_process_error(struct pci_dev *pdev);
>   pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
>   bool pci_dpc_recovered(struct pci_dev *pdev);
>   unsigned int dpc_tlp_log_len(struct pci_dev *dev);
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 1a54a0b657ae..a91440f3b118 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -253,10 +253,17 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>   	return 1;
>   }
>   
> -void dpc_process_error(struct pci_dev *pdev)
> +/**
> + * dpc_process_error - handle the DPC error status
> + * @pdev: the port that experienced the containment event
> + *
> + * Return the device that detected the error.
> + */

Add a note about calling pci_dev_put() after using this function.

> +struct pci_dev *dpc_process_error(struct pci_dev *pdev)
>   {
>   	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
>   	struct aer_err_info info;
> +	struct pci_dev *err_dev;
>   
>   	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
>   	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
> @@ -279,6 +286,13 @@ void dpc_process_error(struct pci_dev *pdev)
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
> @@ -291,6 +305,8 @@ void dpc_process_error(struct pci_dev *pdev)
>   		pci_aer_clear_nonfatal_status(pdev);
>   		pci_aer_clear_fatal_status(pdev);
>   	}
> +
> +	return err_dev;
>   }
>   
>   static void pci_clear_surpdn_errors(struct pci_dev *pdev)
> @@ -346,7 +362,7 @@ static bool dpc_is_surprise_removal(struct pci_dev *pdev)
>   
>   static irqreturn_t dpc_handler(int irq, void *context)
>   {
> -	struct pci_dev *err_port = context;
> +	struct pci_dev *err_port = context, *err_dev;
>   
>   	/*
>   	 * According to PCIe r6.0 sec 6.7.6, errors are an expected side effect
> @@ -357,10 +373,11 @@ static irqreturn_t dpc_handler(int irq, void *context)
>   		return IRQ_HANDLED;
>   	}
>   
> -	dpc_process_error(err_port);
> +	err_dev = dpc_process_error(err_port);
>   
>   	/* We configure DPC so it only triggers on ERR_FATAL */
> -	pcie_do_recovery(err_port, pci_channel_io_frozen, dpc_reset_link);
> +	pcie_do_recovery(err_dev, pci_channel_io_frozen, dpc_reset_link);
> +	pci_dev_put(err_dev);
>   
>   	return IRQ_HANDLED;
>   }
> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
> index 521fca2f40cb..088f3e188f54 100644
> --- a/drivers/pci/pcie/edr.c
> +++ b/drivers/pci/pcie/edr.c
> @@ -150,7 +150,7 @@ static int acpi_send_edr_status(struct pci_dev *pdev, struct pci_dev *edev,
>   
>   static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>   {
> -	struct pci_dev *pdev = data, *err_port;
> +	struct pci_dev *pdev = data, *err_port, *err_dev;
>   	pci_ers_result_t estate = PCI_ERS_RESULT_DISCONNECT;
>   	u16 status;
>   
> @@ -190,7 +190,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>   		goto send_ost;
>   	}
>   
> -	dpc_process_error(err_port);
> +	err_dev = dpc_process_error(err_port);
>   	pci_aer_raw_clear_status(err_port);
>   
>   	/*
> @@ -198,7 +198,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>   	 * or ERR_NONFATAL, since the link is already down, use the FATAL
>   	 * error recovery path for both cases.
>   	 */
> -	estate = pcie_do_recovery(err_port, pci_channel_io_frozen, dpc_reset_link);
> +	estate = pcie_do_recovery(err_dev, pci_channel_io_frozen, dpc_reset_link);
>   
>   send_ost:
>   
> @@ -216,6 +216,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>   	}
>   
>   	pci_dev_put(err_port);
> +	pci_dev_put(err_dev);
>   }
>   
>   void pci_acpi_add_edr_notifier(struct pci_dev *pdev)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


