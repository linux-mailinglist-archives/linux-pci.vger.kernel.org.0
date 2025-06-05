Return-Path: <linux-pci+bounces-29038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EFCACF2DE
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 17:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3123B1C63
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 15:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC3C199FBA;
	Thu,  5 Jun 2025 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4cnHgZD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F269F18C031;
	Thu,  5 Jun 2025 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136469; cv=none; b=Rmy7FlcmVphnPF4S0R+z1HphQ3iTNB7V0ELJrvbuYrL5HOTY4UKQ+ZOtwv7nlv4lIdcOC+hyXuaU00LxzEFQxW2g8eNfKmm8gJjeGwIoKs0WC1+gNoC2UD3xi7fK6hxO0DdfvKsoPxPNeODu8b3kLQ07DxJnNRPfZVw67dzdnA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136469; c=relaxed/simple;
	bh=v//kuvDRjkFsJodmvNXp9EqacxYN/MOn2NutkMRidaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hPJIVndC/oVZ7g5aF0AoD1fmlbncn55kVdv//j7wMED14TzU776cfxDI2BZVHq/tnVGVNq/soVWyyOcoNf/uzE6KzRS8Em/Z5BocEhyr0iPGsdLMvgaF12ad8wig0uwCWTlZKTtWnjpQy+WYuqJYlIxYi0+Wksg1ACx1SfITfJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4cnHgZD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749136467; x=1780672467;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=v//kuvDRjkFsJodmvNXp9EqacxYN/MOn2NutkMRidaU=;
  b=H4cnHgZDWQMz4CehaOL0gaDU73zegjpvcLXf8u90YJNSw9AHBYGaPutV
   rlxGMU9VfJ/8wheUT8tIsog7sL+8j0Xu9Ny33bpyTsK190DunCdPKnnxt
   RgUN0fFR3umjrKu4iDYHYZoVFKZ6QXDhhKNU2nqn5pSy6ern7oeETbJei
   efAk2gBUUq6CEBDa0pYeFxO//K97YIUUEJspwYIo1LK1l5Vdo0nNwnERe
   tZbLqrWByC47D9JmUjwRACvHJP7xfL2JXCXy7Rv/xitlSC3Wu35yIpjJw
   NwJJYGxq3KWdxAs/UWWUrCi/AvIERTbAfh6khfuR8/LLXHOUvr95nkIIP
   w==;
X-CSE-ConnectionGUID: rO/6xjBeQ9SYqv5wEUEeJw==
X-CSE-MsgGUID: gkTjivUJR8m+GgpRWLiDxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="53890522"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="53890522"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 08:14:26 -0700
X-CSE-ConnectionGUID: irVC1Tu9Q02tHxhaQcFhkQ==
X-CSE-MsgGUID: Hz/YMQ/4TpGO75h9LdCLnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="150421107"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 08:14:25 -0700
Received: from [10.124.222.23] (unknown [10.124.222.23])
	by linux.intel.com (Postfix) with ESMTP id E7AF220B5736;
	Thu,  5 Jun 2025 08:14:23 -0700 (PDT)
Message-ID: <4ceb5bef-d5f2-4552-a1aa-c282286bf10f@linux.intel.com>
Date: Thu, 5 Jun 2025 08:14:23 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/16] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
To: Terry Bowman <terry.bowman@amd.com>, PradeepVineshReddy.Kodamati@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-6-terry.bowman@amd.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250603172239.159260-6-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/3/25 10:22 AM, Terry Bowman wrote:
> Create cxl_do_recovery() to provide uncorrectable protocol error (UCE)
> handling. Follow similar design as found in PCIe error driver,
> pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
> as fatal with a kernel panic. This is to prevent corruption on CXL memory.
>
> Copy the PCI error driver's merge_result() and rename as cxl_merge_result().
> Introduce PCI_ERS_RESULT_PANIC and add support in the cxl_merge_result()
> routine.
>
> Copy pci_walk_bridge() to cxl_walk_bridge(). Make a change to walk the
> first device in all cases.
>
> Copy the PCI error driver's report_error_detected() to cxl_report_error_detected().
> Note, only CXL Endpoints are currently supported. Add locking for PCI
> device as done in PCI's report_error_detected(). Add reference counting for
> the CXL device responsible for cleanup of the CXL RAS. This is necessary
> to prevent the RAS registers from disappearing before logging is completed.
>
> Call panic() to halt the system in the case of uncorrectable errors (UCE)
> in cxl_do_recovery(). Export pci_aer_clear_fatal_status() for CXL to use
> if a UCE is not found. In this case the AER status must be cleared and
> uses pci_aer_clear_fatal_status().
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>   drivers/cxl/core/ras.c | 79 ++++++++++++++++++++++++++++++++++++++++++
>   include/linux/pci.h    |  3 ++
>   2 files changed, 82 insertions(+)
>
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 9ed5c682e128..715f7221ea3a 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -110,8 +110,87 @@ static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>   
>   #ifdef CONFIG_PCIEAER_CXL
>   
> +static pci_ers_result_t cxl_merge_result(enum pci_ers_result orig,
> +					 enum pci_ers_result new)
> +{
> +	if (new == PCI_ERS_RESULT_PANIC)
> +		return PCI_ERS_RESULT_PANIC;
> +
> +	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
> +		return PCI_ERS_RESULT_NO_AER_DRIVER;
> +
> +	if (new == PCI_ERS_RESULT_NONE)
> +		return orig;
> +
> +	switch (orig) {
> +	case PCI_ERS_RESULT_CAN_RECOVER:
> +	case PCI_ERS_RESULT_RECOVERED:
> +		orig = new;
> +		break;
> +	case PCI_ERS_RESULT_DISCONNECT:
> +		if (new == PCI_ERS_RESULT_NEED_RESET)
> +			orig = PCI_ERS_RESULT_NEED_RESET;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return orig;
> +}
> +
> +static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
> +{
> +	pci_ers_result_t vote, *result = data;
> +	struct cxl_dev_state *cxlds;
> +
> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END))
> +		return 0;
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
> +
> +	device_lock(&pdev->dev);
> +	vote = cxl_error_detected(pdev, pci_channel_io_frozen);
> +	*result = cxl_merge_result(*result, vote);
> +	device_unlock(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static void cxl_walk_bridge(struct pci_dev *bridge,
> +			    int (*cb)(struct pci_dev *, void *),
> +			    void *userdata)
> +{
> +	if (cb(bridge, userdata))
> +		return;
> +
> +	if (bridge->subordinate)
> +		pci_walk_bus(bridge->subordinate, cb, userdata);
> +}
> +
>   static void cxl_do_recovery(struct pci_dev *pdev)
>   {
> +	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> +
> +	cxl_walk_bridge(pdev, cxl_report_error_detected, &status);
> +	if (status == PCI_ERS_RESULT_PANIC)
> +		panic("CXL cachemem error.");
> +
> +	/*
> +	 * If we have native control of AER, clear error status in the device
> +	 * that detected the error.  If the platform retained control of AER,
> +	 * it is responsible for clearing this status.  In that case, the
> +	 * signaling device may not even be visible to the OS.
> +	 */
> +	if (host->native_aer) {

You don't need to check for pcie_ports_native ?

> +		pcie_clear_device_status(pdev);
> +		pci_aer_clear_nonfatal_status(pdev);
> +		pci_aer_clear_fatal_status(pdev);
> +	}

Since you want to clear all AER error status, what about correctable status?

> +
> +	pci_info(pdev, "CXL uncorrectable error.\n");

pci_errr?

>   }
>   
>   static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cd53715d53f3..b0e7545162de 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -870,6 +870,9 @@ enum pci_ers_result {
>   
>   	/* No AER capabilities registered for the driver */
>   	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
> +
> +	/* System is unstable, panic  */
> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,

Since this error state is specific to CXL, add it part of the comment. Otherwise,
other PCIe drivers may also use it.


>   };
>   
>   /* PCI bus error event callbacks */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


