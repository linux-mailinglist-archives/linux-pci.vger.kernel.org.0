Return-Path: <linux-pci+bounces-40592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361D2C41486
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 19:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4DB3A2FCC
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 18:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC3227145F;
	Fri,  7 Nov 2025 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kmi8jiMJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9DA191;
	Fri,  7 Nov 2025 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540251; cv=none; b=PEu6++UD3OsJx4NBhQju8zc5ceDeNDmfQcmyEVo4WePA3KEdeV9njF3dixzebaL2ETnt+hNKrSaVEJ9t/OlzNc1qdXqTjKFXCTTsklxOFID1qKK8PtgSnB6EdZe/fNFlEIO5+Bgb7W7zY/y2xG7R1Mgol+uZj+2APZDdiqYU+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540251; c=relaxed/simple;
	bh=NQMzSf1AbuMYunJf1VM25Q78A/AsP25m0nmjU1brY+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=slwQMUMMBhSZMkjdVynAIN1W0DMChOZ/Ek8IyX0bisGS5TZ2fkUGMqNdUJSrUnPSiGplxN4IDGw9ESYVZ5Rqvqd4nDPaB5ANIKWNTekuRHjAQruNOaTA80f7isPR18nFpXoN7b64Dc+ICqs5u3lj6ZKGEhukN8843qVEjjj4/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kmi8jiMJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762540249; x=1794076249;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NQMzSf1AbuMYunJf1VM25Q78A/AsP25m0nmjU1brY+o=;
  b=Kmi8jiMJ2HmSAuEXfLKs752IK5loHZAFqkRioF89GUC1UcM9C+SnBHmY
   O3NRwVPmbbqp7u+I6qbMDrmcZDRIxFDtB77fGlsv5R6vib+/JQbBF1kWa
   cm7bOwowtSOsYqj9wMwYW8M/0MvbRCMeGHJC0IiO8V5fE+1kicvGfWS8P
   RFClEe8dOCwRM++czT6NZbQyV7N4x6lTIgoHFgUteMIGc299LoNOQhGMn
   qvtVc+SOGfnmqmzuWsMOU9oYiSlcDc8BVioFUwE2YXq5bBQZau0xz2x1c
   WZLJw2/I27Cdp36ZRvYfgfWUu8KUfpUK0rjgMq27i0mVoK/Iu4IyS4Oil
   A==;
X-CSE-ConnectionGUID: KalzoUi/RLC+T/IpuTiBeA==
X-CSE-MsgGUID: oDz5vkHhReyNkTqHaWFmaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64609698"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="64609698"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 10:30:48 -0800
X-CSE-ConnectionGUID: EXjax2rlQKKiYHZkpDrlCA==
X-CSE-MsgGUID: opz/TgNzSJqcl3I4SWkXtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="187355089"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.112]) ([10.125.111.112])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 10:30:47 -0800
Message-ID: <02a7c72f-6d8f-4cd9-af97-9b5e0b6093cb@intel.com>
Date: Fri, 7 Nov 2025 11:30:46 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6 v7] acpi/ghes: Add helper for CXL protocol errors
 checks
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
 <20251104182446.863422-5-fabio.m.de.francesco@linux.intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251104182446.863422-5-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/25 11:22 AM, Fabio M. De Francesco wrote:
> Move the CPER CXL protocol errors validity check out of
> cxl_cper_post_prot_err() to new cxl_cper_sec_prot_err_valid() and limit
> the serial number check only to CXL agents that are CXL devices (UEFI
> v2.10, Appendix N.2.13).
> 
> Export the new symbol for reuse by ELOG.
> 
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/acpi/apei/ghes.c | 32 ++++++++++++++++++++++----------
>  include/cxl/event.h      | 10 ++++++++++
>  2 files changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d6fe5f020e96..e69ae864f43d 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -706,30 +706,42 @@ static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
>  static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
>  struct work_struct *cxl_cper_prot_err_work;
>  
> -static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> -				   int severity)
> +int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
>  {
> -	struct cxl_cper_prot_err_work_data wd;
> -	u8 *dvsec_start, *cap_start;
> -
>  	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
>  		pr_err_ratelimited("CXL CPER invalid agent type\n");
> -		return;
> +		return -EINVAL;
>  	}
>  
>  	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
>  		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
> -		return;
> +		return -EINVAL;
>  	}
>  
>  	if (prot_err->err_len != sizeof(struct cxl_ras_capability_regs)) {
>  		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
>  				   prot_err->err_len);
> -		return;
> +		return -EINVAL;
>  	}
>  
> -	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
> -		pr_warn(FW_WARN "CXL CPER no device serial number\n");
> +	if ((prot_err->agent_type == RCD || prot_err->agent_type == DEVICE ||
> +	     prot_err->agent_type == LD || prot_err->agent_type == FMLD) &&
> +	    !(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
> +		pr_warn_ratelimited(FW_WARN
> +				    "CXL CPER no device serial number\n");
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cxl_cper_sec_prot_err_valid);
> +
> +static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> +				   int severity)
> +{
> +	struct cxl_cper_prot_err_work_data wd;
> +	u8 *dvsec_start, *cap_start;
> +
> +	if (cxl_cper_sec_prot_err_valid(prot_err))
> +		return;
>  
>  	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
>  
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index 6fd90f9cc203..4d7d1036ea9c 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -320,4 +320,14 @@ static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data
>  }
>  #endif
>  
> +#ifdef CONFIG_ACPI_APEI_PCIEAER
> +int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err);
> +#else
> +static inline int
> +cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +
>  #endif /* _LINUX_CXL_EVENT_H */


