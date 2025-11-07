Return-Path: <linux-pci+bounces-40593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555A6C414A1
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 19:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0074F3A2C01
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 18:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FCD2E040D;
	Fri,  7 Nov 2025 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjehJNty"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D065E212549;
	Fri,  7 Nov 2025 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540298; cv=none; b=f8JB+W0sS7oWJg8oJ7dwU863JpxUr8RCM3B46hs+cWFLGX4aDpG9SsqH5q/U45QvL08VrT8bVfDDyMr0YmMPeQyyzVk94py1y7pW02x9RkPGkk/utDwKPCrLNaPO5KoCTw9YCI5tlcOXoQNJurhTbizqBlJj+zL92BkE1l20aIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540298; c=relaxed/simple;
	bh=Ivwc2M/ZDTDNDN4wnIiRBUD82UImX2K8AEI+zfxIyOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBULh4tYApqcRbrfG8N30Udj+uyvIDnjyN5UIvktRjm0JLZxXLWHsPXWVZGmGGOniAc1T+Pvq/paGmXommbQeOL2fi1BaIkhzetne9wqqm9BH3TLiFaCbBtXvQ12PyEzbOW3nJlmiGGxOFZe+Tb/6LSFeZokc9KrTusHAmjZnp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QjehJNty; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762540297; x=1794076297;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ivwc2M/ZDTDNDN4wnIiRBUD82UImX2K8AEI+zfxIyOU=;
  b=QjehJNty07AyRTT8mFTZFkJ+gyf9Et8Lr4NdNSVcVtU0+GFYzjvt1SrT
   4XDxdgfdAbqpPC4sw6S24sGRs2PtwTrcsju1q4RYQr8ijMCB6/tk+UqlZ
   cGwMhk/4NyqPwn2nIXNIFco1oVMCCnYH8jE5kQo+bYgbNYdn3okm/LNZ5
   gMIJWHVtsaLEOC5PyvpiwsuWlet6Q4EJGvoI7bDIW0JBVGs5Zw5b+xXxT
   bdEeVrasIvMqph+Y8Pg6IufYK8grbgM5ZRf7Z6FgNmWAATNBE93XXvbrm
   uGlaXLWbevLmd5r0lLD2djNW+6b5y53CLm8aUn/DcvWm2EP076yTAxSYP
   g==;
X-CSE-ConnectionGUID: pf7D3dhER1C1k2StT3nfCw==
X-CSE-MsgGUID: nY4RxRUqRXCyd/GGoYa6Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64731682"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="64731682"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 10:31:36 -0800
X-CSE-ConnectionGUID: RgnJVNmPQuS+l15b/XeJnA==
X-CSE-MsgGUID: T3lEpinBQaalfC++rcdn3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="187355309"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.112]) ([10.125.111.112])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 10:31:35 -0800
Message-ID: <d84eafa5-0038-436e-aa53-9675d4e630b6@intel.com>
Date: Fri, 7 Nov 2025 11:31:34 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6 v7] acpi/ghes: Add helper to copy CXL protocol error
 info to work struct
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
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
References: <20251104182446.863422-1-fabio.m.de.francesco@linux.intel.com>
 <20251104182446.863422-6-fabio.m.de.francesco@linux.intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251104182446.863422-6-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/25 11:22 AM, Fabio M. De Francesco wrote:
> Make a helper out of cxl_cper_post_prot_err() that checks the CXL agent
> type and copy the CPER CXL protocol errors information to a work data
> structure.
> 
> Export the new symbol for reuse by ELOG.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/acpi/apei/ghes.c | 42 ++++++++++++++++++++++++++--------------
>  include/cxl/event.h      | 10 ++++++++++
>  2 files changed, 37 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index e69ae864f43d..2f4632d9855a 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -734,20 +734,12 @@ int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
>  }
>  EXPORT_SYMBOL_GPL(cxl_cper_sec_prot_err_valid);
>  
> -static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> -				   int severity)
> +int cxl_cper_setup_prot_err_work_data(struct cxl_cper_prot_err_work_data *wd,
> +				      struct cxl_cper_sec_prot_err *prot_err,
> +				      int severity)
>  {
> -	struct cxl_cper_prot_err_work_data wd;
>  	u8 *dvsec_start, *cap_start;
>  
> -	if (cxl_cper_sec_prot_err_valid(prot_err))
> -		return;
> -
> -	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
> -
> -	if (!cxl_cper_prot_err_work)
> -		return;
> -
>  	switch (prot_err->agent_type) {
>  	case RCD:
>  	case DEVICE:
> @@ -756,20 +748,40 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>  	case RP:
>  	case DSP:
>  	case USP:
> -		memcpy(&wd.prot_err, prot_err, sizeof(wd.prot_err));
> +		memcpy(&wd->prot_err, prot_err, sizeof(wd->prot_err));
>  
>  		dvsec_start = (u8 *)(prot_err + 1);
>  		cap_start = dvsec_start + prot_err->dvsec_len;
>  
> -		memcpy(&wd.ras_cap, cap_start, sizeof(wd.ras_cap));
> -		wd.severity = cper_severity_to_aer(severity);
> +		memcpy(&wd->ras_cap, cap_start, sizeof(wd->ras_cap));
> +		wd->severity = cper_severity_to_aer(severity);
>  		break;
>  	default:
>  		pr_err_ratelimited("CXL CPER invalid agent type: %d\n",
>  				   prot_err->agent_type);
> -		return;
> +		return -EINVAL;
>  	}
>  
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cxl_cper_setup_prot_err_work_data);
> +
> +static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> +				   int severity)
> +{
> +	struct cxl_cper_prot_err_work_data wd;
> +
> +	if (cxl_cper_sec_prot_err_valid(prot_err))
> +		return;
> +
> +	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
> +
> +	if (!cxl_cper_prot_err_work)
> +		return;
> +
> +	if (cxl_cper_setup_prot_err_work_data(&wd, prot_err, severity))
> +		return;
> +
>  	if (!kfifo_put(&cxl_cper_prot_err_fifo, wd)) {
>  		pr_err_ratelimited("CXL CPER kfifo overflow\n");
>  		return;
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index 4d7d1036ea9c..94081aec597a 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -322,12 +322,22 @@ static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data
>  
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
>  int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err);
> +int cxl_cper_setup_prot_err_work_data(struct cxl_cper_prot_err_work_data *wd,
> +				      struct cxl_cper_sec_prot_err *prot_err,
> +				      int severity);
>  #else
>  static inline int
>  cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int
> +cxl_cper_setup_prot_err_work_data(struct cxl_cper_prot_err_work_data *wd,
> +				  struct cxl_cper_sec_prot_err *prot_err,
> +				  int severity)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif
>  
>  #endif /* _LINUX_CXL_EVENT_H */


