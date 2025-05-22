Return-Path: <linux-pci+bounces-28312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B8FAC18CD
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 02:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFD71C0634F
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 00:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FC724DCF4;
	Thu, 22 May 2025 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWNLtWMy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE924DCF6;
	Thu, 22 May 2025 23:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747958286; cv=none; b=tTkg6+TtO6pL1OALRFGLwfIXUE0m3eR+ui0yqyQFoQAVzox+DewrgLsbP4Yi1sXP2YjtTaT4SC2CzPViBIR87fyrdatC7tioXtcgHTF383adSZ04TkYKykKvoSbR15Vvl2w93DA1wjbRgSPnTd6wXebxiy9NfMSFwUQFX46gD34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747958286; c=relaxed/simple;
	bh=DHcfECq7IBIOTWyIdwrHZNjowJ0zmZT531wNLeqqEXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5j/p29bPEyC2mFgzlWzTm3hZRfW1gOC7fSHHTvpSO3DtuIA1ZwLz6/MWl6/JbQ+5H9/UUa4KUQOO9VIvA14v4Et2pd+N82k/viDZm9zcid4rcflCREtv1BB0ky2QSmt2A/VG/LeUJ2iF3yDjndGM+R7kQUTPlaicVqiBs8qbYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWNLtWMy; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747958285; x=1779494285;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DHcfECq7IBIOTWyIdwrHZNjowJ0zmZT531wNLeqqEXs=;
  b=mWNLtWMyvkpv0dQcU3fqJdCM863zBR+Mz+6JJbUcgdPahMSnOPVMSuaI
   hiz4L9o7HWtHmhg6nnxx/BUEL7ztkWplgyaY+50CtKzD7KTeKQAu+zVY3
   GHv0+N2EECN0yXKaRg9o0Scjl73UxeXWslFhh3yf0+AcDMr2VCfQWBnD2
   wsphz27N+HSgL3sAs3xM9y8sZQob+8Zci0w4/ZaDj6AtnNA9nqv+c32/5
   cb3JbwBw8QwRuU1sJiD4vsfg9PD3+RCKBFBLjLPeKMSdDT1HXXsUNegs8
   caktmGcw9XYkxNQJzel7/ezgZ/iMO7uMHLgprdmByuhmKeh9nyGVF1Flf
   g==;
X-CSE-ConnectionGUID: fpXaRyjkRLiJWZIyKakGmQ==
X-CSE-MsgGUID: duEocaC3QU25yTUy1pQ2Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60643757"
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="60643757"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 16:58:04 -0700
X-CSE-ConnectionGUID: EmapeLK0Shu0TLs2CApchQ==
X-CSE-MsgGUID: mLPKdty7TlSPc1ipuwDdGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="140657840"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.223.120]) ([10.124.223.120])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 16:58:03 -0700
Message-ID: <ac9b9e83-1f4d-46e9-ac15-60e5765a139f@linux.intel.com>
Date: Thu, 22 May 2025 16:58:02 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/20] PCI/AER: Convert aer_get_device_error_info(),
 aer_print_error() to index
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>,
 Weinan Liu <wnliu@google.com>, Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20250522232339.1525671-1-helgaas@kernel.org>
 <20250522232339.1525671-17-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250522232339.1525671-17-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/22/25 4:21 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Previously aer_get_device_error_info() and aer_print_error() took a pointer
> to struct aer_err_info and a pointer to a pci_dev.  Typically the pci_dev
> was one of the elements of the aer_err_info.dev[] array (DPC was an
> exception, where the dev[] array was unused).
>
> Convert aer_get_device_error_info() and aer_print_error() to take an index
> into the aer_err_info.dev[] array instead.  A future patch will add
> per-device ratelimit information, so the index makes it convenient to find
> the ratelimit associated with the device.
>
> To accommodate DPC, set info->dev[0] to the DPC port before using these
> interfaces.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pci.h      |  4 ++--
>   drivers/pci/pcie/aer.c | 33 +++++++++++++++++++++++----------
>   drivers/pci/pcie/dpc.c |  8 ++++++--
>   3 files changed, 31 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 1a9bfc708757..e1a28215967f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -605,8 +605,8 @@ struct aer_err_info {
>   	struct pcie_tlp_log tlp;	/* TLP Header */
>   };
>   
> -int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
> -void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
> +int aer_get_device_error_info(struct aer_err_info *info, int i);
> +void aer_print_error(struct aer_err_info *info, int i);
>   
>   int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>   		      unsigned int tlp_len, bool flit,
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 787a953fb331..237741e66d28 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -705,12 +705,18 @@ static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
>   		 found ? "" : " (no details found");
>   }
>   
> -void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
> +void aer_print_error(struct aer_err_info *info, int i)
>   {
> -	int layer, agent;
> -	int id = pci_dev_id(dev);
> +	struct pci_dev *dev;
> +	int layer, agent, id;
>   	const char *level = info->level;
>   
> +	if (i >= AER_MAX_MULTI_ERR_DEVICES)
> +		return;
> +
> +	dev = info->dev[i];
> +	id = pci_dev_id(dev);
> +
>   	pci_dev_aer_stats_incr(dev, info);
>   	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
>   			info->severity, info->tlp_header_valid, &info->tlp);
> @@ -1193,19 +1199,26 @@ EXPORT_SYMBOL_GPL(aer_recover_queue);
>   
>   /**
>    * aer_get_device_error_info - read error status from dev and store it to info
> - * @dev: pointer to the device expected to have an error record
>    * @info: pointer to structure to store the error record
> + * @i: index into info->dev[]
>    *
>    * Return: 1 on success, 0 on error.
>    *
>    * Note that @info is reused among all error devices. Clear fields properly.
>    */
> -int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
> +int aer_get_device_error_info(struct aer_err_info *info, int i)
>   {
> -	int type = pci_pcie_type(dev);
> -	int aer = dev->aer_cap;
> +	struct pci_dev *dev;
> +	int type, aer;
>   	u32 aercc;
>   
> +	if (i >= AER_MAX_MULTI_ERR_DEVICES)
> +		return 0;
> +
> +	dev = info->dev[i];
> +	aer = dev->aer_cap;
> +	type = pci_pcie_type(dev);
> +
>   	/* Must reset in this function */
>   	info->status = 0;
>   	info->tlp_header_valid = 0;
> @@ -1257,11 +1270,11 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
>   
>   	/* Report all before handling them, to not lose records by reset etc. */
>   	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
> -		if (aer_get_device_error_info(e_info->dev[i], e_info))
> -			aer_print_error(e_info->dev[i], e_info);
> +		if (aer_get_device_error_info(e_info, i))
> +			aer_print_error(e_info, i);
>   	}
>   	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
> -		if (aer_get_device_error_info(e_info->dev[i], e_info))
> +		if (aer_get_device_error_info(e_info, i))
>   			handle_error_source(e_info->dev[i], e_info);
>   	}
>   }
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 7ae1590ea1da..fc18349614d7 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -253,6 +253,10 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>   		info->severity = AER_NONFATAL;
>   
>   	info->level = KERN_ERR;
> +
> +	info->dev[0] = dev;
> +	info->error_dev_num = 1;
> +
>   	return 1;
>   }
>   
> @@ -270,8 +274,8 @@ void dpc_process_error(struct pci_dev *pdev)
>   		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
>   			 status);
>   		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
> -		    aer_get_device_error_info(pdev, &info)) {
> -			aer_print_error(pdev, &info);
> +		    aer_get_device_error_info(&info, 0)) {
> +			aer_print_error(&info, 0);
>   			pci_aer_clear_nonfatal_status(pdev);
>   			pci_aer_clear_fatal_status(pdev);
>   		}

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


