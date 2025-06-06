Return-Path: <linux-pci+bounces-29106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCA3AD06DE
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 18:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930E73AA8F9
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 16:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00961DE892;
	Fri,  6 Jun 2025 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XLzZd3Oo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64B91A275;
	Fri,  6 Jun 2025 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749228322; cv=none; b=f/LNREUiq6Aw2jtf7fPQ5yBrQYjplsXkm9Aus5iRn9pFlMGJEezb652VFALcbfahk6vV5D9C6ATnDxh20VzJTnoMupCneDjSIUR+VbISPMB1gMs6280Qyi7Qmvqy/cH04jUxwTkTpKbHhxsZivF7J2OpJax9pLu1Jf8MxV741ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749228322; c=relaxed/simple;
	bh=ifEGRdXupqHRyKQoe1mn0yoz5/alcvkhY2fZ5Bb+/jY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ov/BXi/tT9a0GboyxYTKno2MW5l9K2v0MWrAVHACC+ldajrdAj3XsCXiu0y+L9bCAXsKIsJLEp/d9SIWz8+M97+EMoHolufFuaAvIRnRtgJHv1EnfsdJVbVPZg9JQX0UvgrmJtp+JB7E8Ub4DqnbltlfsIwhoB79SVL2WLTLKXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XLzZd3Oo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749228321; x=1780764321;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ifEGRdXupqHRyKQoe1mn0yoz5/alcvkhY2fZ5Bb+/jY=;
  b=XLzZd3OobZ9nTbl1q1Vf8KPlZxSjNosOfnkWCUW43lj3NTZ0GfdWG1y9
   IFStcxB0nA5LSWhkxqUw2WyWkUYHpSbFQtkmddUeK4C/xdJsVePWWQYL8
   pJbzFdH52jVrghG2fI6Ff74UC9MSqiSmW6zoTulPJlW+gspUUkN8SnDUn
   EALV3ztinPM3ndMMari94o7zmbukUTDnW0+RCpRm++StJG/zrYFATZ4ZO
   QHiTybC9m1ghRUb4pFiG4phVXTQIbXzYjFIMTvSxlxnzI6Ja0CxQtbOxT
   UhPgNKNT+CE6KuSbjcJiFLFYe/23m5QQFSLfzLbQf2TddbZo5wUiKa60b
   A==;
X-CSE-ConnectionGUID: 0KgFQlE8TRK3luMbKM8jjQ==
X-CSE-MsgGUID: o/PRnVD3S5Oei68CBRJIIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="50493871"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="50493871"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 09:45:20 -0700
X-CSE-ConnectionGUID: 3dRkmlYlRQaHv0l//0yKdw==
X-CSE-MsgGUID: 8xfLrMufTpSGvspxgMEHXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="150885773"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.111.33]) ([10.125.111.33])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 09:45:18 -0700
Message-ID: <02f8b7dc-b9e0-4b0d-bbd4-b0fa66715208@intel.com>
Date: Fri, 6 Jun 2025 09:45:17 -0700
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
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, bp@alien8.de, ming.li@zohomail.com,
 shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-6-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250603172239.159260-6-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
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
>  drivers/cxl/core/ras.c | 79 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h    |  3 ++
>  2 files changed, 82 insertions(+)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 9ed5c682e128..715f7221ea3a 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -110,8 +110,87 @@ static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  
>  #ifdef CONFIG_PCIEAER_CXL
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

Lock here before getting driver data instead of later?

guard(device)(&pdev->dev);

> +	cxlds = pci_get_drvdata(pdev);

Add a comment for the ref grab

DJ

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
>  static void cxl_do_recovery(struct pci_dev *pdev)
>  {
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
> +		pcie_clear_device_status(pdev);
> +		pci_aer_clear_nonfatal_status(pdev);
> +		pci_aer_clear_fatal_status(pdev);
> +	}
> +
> +	pci_info(pdev, "CXL uncorrectable error.\n");
>  }
>  
>  static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cd53715d53f3..b0e7545162de 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -870,6 +870,9 @@ enum pci_ers_result {
>  
>  	/* No AER capabilities registered for the driver */
>  	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
> +
> +	/* System is unstable, panic  */
> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
>  };
>  
>  /* PCI bus error event callbacks */


