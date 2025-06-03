Return-Path: <linux-pci+bounces-28916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9C5ACCF20
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 23:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7546E7A43C1
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 21:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98920224B07;
	Tue,  3 Jun 2025 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODI6o1nK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4C4C74;
	Tue,  3 Jun 2025 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748987060; cv=none; b=sn5RaQ6bJP3YbGzWW7IBXkDMVLRhC2K2x78ghOIA2ERAnyC8emas5f1hxhFb2nHh77p91sai25gPoBLOwdBNcdVsb8OzXDiSoivPs/n7EqAQVqxYVJydK5VMaRxYVQO043CTMvN6mn4rwFjm+pTHWShzaZrDuZMn8470/q34NFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748987060; c=relaxed/simple;
	bh=p1rvwbNQb9+j9EK6XVoHifBzn4XFso0yGK8Ac/FTDC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRg8UAMVkYo0nTltk45ot9q9uxLseFbPZO7Q3eS5rj9iUp6ETQu/e08oi5qGmUHPkxYG39AVpazuS6gQauSwVQ0DlrdolETqeIQr/PAaUTsmP0SoKekVIFbO+C4lyNqV6sCRqQFXLKBii+1MxTIS0Ehtmr9Njel2jbYzPhHUYWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODI6o1nK; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748987059; x=1780523059;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p1rvwbNQb9+j9EK6XVoHifBzn4XFso0yGK8Ac/FTDC4=;
  b=ODI6o1nKS57NkyW+vibC/Rqk4Zl/yWYymJkBNLpoefAUl7bxiLXU72Xm
   IX5HJHtL8yeAKKDsOhHBkJIuE8wtX0HPDbBbXsv68IFLpgE9B0EVS6fmq
   ZLqh2dxgxfRbleuZjXDNRZrpg4dSGG6YN3r+cjpkl3J8MlU3bwSY4X+gl
   DTCPanZuU/juz024UmkTeBvYC9pghJvBwsgWy9Ld5rk79jHf6uG4PUr3u
   PgUC2Im8T92NFSZx1YhOIUBE3VmPVv5TkpMoPsBT0RM+B6wEQgbX5NR5K
   79GbYNYkv+F+fWvZNhmNAg9C4QTcc2NPVRQMwd6tJ6k7zQHF8rY9IHJFz
   w==;
X-CSE-ConnectionGUID: 0kB1rGdDR2KDRF7IhNOsXA==
X-CSE-MsgGUID: f0hnA+PlSIavgVSmFcf0Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="51118790"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="51118790"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 14:44:17 -0700
X-CSE-ConnectionGUID: Rf42UJcySw6yxIqBkbF+jw==
X-CSE-MsgGUID: ZNJm7pRQT1iF4jNdpWfDEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="150034204"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.110.198]) ([10.125.110.198])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 14:44:16 -0700
Message-ID: <372d01ff-2831-41c0-ac8f-2a09eca5c620@intel.com>
Date: Tue, 3 Jun 2025 14:44:14 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4 v3] ACPI: extlog: Trace CPER CXL Protocol Error
 Section
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, linux-edac@vger.kernel.org
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
References: <20250603155536.577493-1-fabio.m.de.francesco@linux.intel.com>
 <20250603155536.577493-5-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250603155536.577493-5-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/25 8:54 AM, Fabio M. De Francesco wrote:
> When Firmware First is enabled, BIOS handles errors first and then it makes
> them available to the kernel via the Common Platform Error Record (CPER)
> sections (UEFI 2.10 Appendix N). Linux parses the CPER sections via one of
> two similar paths, either ELOG or GHES. The errors managed by ELOG are
> signaled to the BIOS by the I/O Machine Check Architecture (I/O MCA).
> 
> Currently, ELOG and GHES show some inconsistencies in how they report to
> userspace via trace events.
> 
> Therefore, make the two mentioned paths act similarly by tracing the CPER
> CXL Protocol Error Section (UEFI v2.10, Appendix N.2.13).
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/acpi/acpi_extlog.c | 64 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/ras.c     |  6 ++++
>  include/cxl/event.h        |  2 ++
>  3 files changed, 72 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index b2928ff297eda..de4f617f32d49 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -12,6 +12,7 @@
>  #include <linux/ratelimit.h>
>  #include <linux/edac.h>
>  #include <linux/ras.h>
> +#include <cxl/event.h>
>  #include <acpi/ghes.h>
>  #include <asm/cpu.h>
>  #include <asm/mce.h>
> @@ -160,6 +161,62 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>  	pci_dev_put(pdev);
>  }
>  
> +static void
> +extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> +				int severity)
> +{
> +#ifdef CONFIG_ACPI_APEI_PCIEAER
The ifdef should be in a header file?

> +	struct cxl_cper_prot_err_work_data wd;
> +	u8 *dvsec_start, *cap_start;
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
> +		pr_err_ratelimited("CXL CPER invalid agent type\n");
pr_warn_ratelimited()?
> +		return;
> +	}
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
> +		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
pr_warn_ratelimited()?
> +		return;
> +	}
> +
> +	if (prot_err->err_len != sizeof(struct cxl_ras_capability_regs)) {
> +		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
> +				   prot_err->err_len);
pr_warn_ratelimited()?
> +		return;
> +	}
> +
> +	if ((prot_err->agent_type == RCD || prot_err->agent_type == DEVICE ||
> +	     prot_err->agent_type == LD || prot_err->agent_type == FMLD) &&
> +	    !(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
> +		pr_warn(FW_WARN "CXL CPER no device serial number\n");

Why are the earlier emits ratelimited, but not this one?

DJ

> +
> +	switch (prot_err->agent_type) {
> +	case RCD:
> +	case DEVICE:
> +	case LD:
> +	case FMLD:
> +	case RP:
> +	case DSP:
> +	case USP:
> +		memcpy(&wd.prot_err, prot_err, sizeof(wd.prot_err));
> +
> +		dvsec_start = (u8 *)(prot_err + 1);
> +		cap_start = dvsec_start + prot_err->dvsec_len;
> +
> +		memcpy(&wd.ras_cap, cap_start, sizeof(wd.ras_cap));
> +		wd.severity = cper_severity_to_aer(severity);
> +		break;
> +	default:
> +		pr_err_ratelimited("CXL CPER reserved agent type: %d\n",
> +				   prot_err->agent_type);
> +		return;
> +	}
> +
> +	cxl_cper_ras_handle_prot_err(&wd);
> +
> +#endif
> +}
> +
>  static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			void *data)
>  {
> @@ -211,6 +268,12 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			if (gdata->error_data_length >= sizeof(*mem))
>  				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
>  						       (u8)gdata->error_severity);
> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
> +			struct cxl_cper_sec_prot_err *prot_err =
> +				acpi_hest_get_payload(gdata);
> +
> +			extlog_cxl_cper_handle_prot_err(prot_err,
> +							gdata->error_severity);
>  		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>  			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
>  
> @@ -378,3 +441,4 @@ module_exit(extlog_exit);
>  MODULE_AUTHOR("Chen, Gong <gong.chen@intel.com>");
>  MODULE_DESCRIPTION("Extended MCA Error Log Driver");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("CXL");
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 485a831695c70..56db290c88d35 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -98,6 +98,12 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  		cxl_cper_trace_uncorr_prot_err(pdev, data->ras_cap);
>  }
>  
> +void cxl_cper_ras_handle_prot_err(struct cxl_cper_prot_err_work_data *wd)
> +{
> +	cxl_cper_handle_prot_err(wd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_ras_handle_prot_err, "CXL");
> +
>  static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>  {
>  	struct cxl_cper_prot_err_work_data wd;
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index f9ae1796da85f..aef906e260330 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -285,4 +285,6 @@ static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data
>  }
>  #endif
>  
> +void cxl_cper_ras_handle_prot_err(struct cxl_cper_prot_err_work_data *wd);
> +
>  #endif /* _LINUX_CXL_EVENT_H */


