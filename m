Return-Path: <linux-pci+bounces-40602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2055C417D8
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 20:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D96AE4EE79A
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 19:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16D2339707;
	Fri,  7 Nov 2025 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/UL/MF2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E71224AF7;
	Fri,  7 Nov 2025 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762545550; cv=none; b=F7OwPwiObkgcPqGe3pd06r/yBSuy0UVsRI0TvhH+wyKtOBC0GMcNBei/0LjkA+yze3V8Nw9Db3t5xC42a7ZtxnBWXHr1rqyjSMIMTAPQB427OwHW/Vtd8u/NVeJrHUfREoBN0PK1iGEgf3Vl2kKQUwqLrkaHtePU4mbcsVRtHWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762545550; c=relaxed/simple;
	bh=o6sCKaIr+Mcsm7DmCaTJx6MhTkgDqm5CM83QolZ5QBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOe3Kf9ECy15HZsqfzYBc8argxOv9pEdWPMXzZxBgq1xvzAQIxb+4jot7H1hUIHwC+vVPfzFyg6Ieme04jZufPCss9fG9ZRF4gylzjy+3hbfoDZ77DLsad0at6bf6pyB77hPbzypOQJP2CFMjj9Em36YOqCgNmEtxKUEgVporT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/UL/MF2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762545549; x=1794081549;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o6sCKaIr+Mcsm7DmCaTJx6MhTkgDqm5CM83QolZ5QBY=;
  b=V/UL/MF2Fk6EqDevXEbtY5iJx6iqZAJVzLiJit3mNWRoCCadPvcCWQd6
   tgiAA9MpgdBt25EZxMn/S+6obswZx41rZGPa+B+xqlPFEkorfmpNcpGqW
   4w+8FneJmpqkusOx2hIMXN2SRNCFptU5KpDBx3cfdN+z1TW5YmFJd4jGH
   /T1jhYXwoATEs8mjW+YA/YniNLxB1DdTiTKC7QTSq6KiqE8R0Y9W4HNT4
   uQVKSLxEYG3GyBYqeN/0OPjHMXC8K/GSveJi7eLbLb+EYuhHqch9Xu6Bf
   ZESM21VD3pj9syOUx3oohSZmKKegWcmRO334kkiylNqMjDeL0Ernfttik
   g==;
X-CSE-ConnectionGUID: 4QJBB2sZS9OGEOmAas+YvQ==
X-CSE-MsgGUID: p23x5m/TT5CTIAuNY1dUlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64737458"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="64737458"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 11:59:08 -0800
X-CSE-ConnectionGUID: WQraglFVTdSNTqRT+O0OdA==
X-CSE-MsgGUID: vV07ZoEeSlaSEo5q+8IIjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="187370899"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.112]) ([10.125.111.112])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 11:59:07 -0800
Message-ID: <85fa077c-0c69-452b-9503-0cd7f3e1b363@intel.com>
Date: Fri, 7 Nov 2025 12:59:05 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6 v7] ACPI: extlog: Trace CPER CXL Protocol Error
 Section
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-cxl@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20251104182446.863422-1-fabio.m.de.francesco@linux.intel.com>
 <20251104182446.863422-7-fabio.m.de.francesco@linux.intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251104182446.863422-7-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/25 11:22 AM, Fabio M. De Francesco wrote:
> When Firmware First is enabled, BIOS handles errors first and then it
> makes them available to the kernel via the Common Platform Error Record
> (CPER) sections (UEFI 2.11 Appendix N.2.13). Linux parses the CPER
> sections via one of two similar paths, either ELOG or GHES. The errors
> managed by ELOG are signaled to the BIOS by the I/O Machine Check
> Architecture (I/O MCA).
> 
> Currently, ELOG and GHES show some inconsistencies in how they report to
> userspace via trace events.
> 
> Therefore, make the two mentioned paths act similarly by tracing the CPER
> CXL Protocol Error Section.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/acpi/Kconfig       |  1 +
>  drivers/acpi/acpi_extlog.c | 22 ++++++++++++++++++++++
>  drivers/cxl/core/ras.c     |  3 ++-
>  include/cxl/event.h        |  2 ++
>  4 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index be02634f2320..c2ad24e77ddf 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -498,6 +498,7 @@ config ACPI_EXTLOG
>  	select ACPI_APEI
>  	select ACPI_APEI_PCIEAER
>  	select UEFI_CPER
> +	select CXL_BUS
>  	help
>  	  Certain usages such as Predictive Failure Analysis (PFA) require
>  	  more information about the error than what can be described in
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index b3976ceb4ee4..e6fb25395984 100644
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
> @@ -160,6 +161,21 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>  	pci_dev_put(pdev);
>  }
>  
> +static void
> +extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> +				int severity)
> +{
> +	struct cxl_cper_prot_err_work_data wd;
> +
> +	if (cxl_cper_sec_prot_err_valid(prot_err))
> +		return;
> +
> +	if (cxl_cper_setup_prot_err_work_data(&wd, prot_err, severity))
> +		return;
> +
> +	cxl_cper_handle_prot_err(&wd);
> +}
> +
>  static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			void *data)
>  {
> @@ -211,6 +227,12 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
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
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 2731ba3a0799..a90480d07c87 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -63,7 +63,7 @@ static int match_memdev_by_parent(struct device *dev, const void *uport)
>  	return 0;
>  }
>  
> -static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
> +void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  {
>  	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
>  				       data->prot_err.agent_addr.function);
> @@ -104,6 +104,7 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  	else
>  		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
>  }
> +EXPORT_SYMBOL_GPL(cxl_cper_handle_prot_err);
>  
>  static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>  {
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index 94081aec597a..ff97fea718d2 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -340,4 +340,6 @@ cxl_cper_setup_prot_err_work_data(struct cxl_cper_prot_err_work_data *wd,
>  }
>  #endif
>  
> +void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *wd);
> +
>  #endif /* _LINUX_CXL_EVENT_H */


