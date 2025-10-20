Return-Path: <linux-pci+bounces-38773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F713BF24B7
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 18:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A2018A6A77
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 16:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE0A2820A0;
	Mon, 20 Oct 2025 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JG4NnQgp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B0726B2B0;
	Mon, 20 Oct 2025 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976248; cv=none; b=Ig+CX6rF3WEJOLmFj7/OYYcWqf6jiAEqDk2u4BvLbwMoPMlRhFV50yJN4yNEqKQ6S1eqZ7qwgofOVXYrpjGN94gYqPXywEGKeQtHsHSBQtRK9ZPweRc4ZiAoKc/xQ51BldCcbVCzAnAA6NX6TwIIqi6F5DxU7moGAXd6d0p5ZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976248; c=relaxed/simple;
	bh=y87Qov3Jt4LC0JXlONBamFdqUvce5uT3fMcKNGfdSck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6x+0mo0f/YiHquohKY3Sk9JKOHztr9OuCC0jqO3tvgQE3RuFZhjOivYTKwgN1F/+fzZb4rLT53FtUPeuZgMFmg0+PHISW+R4mWe2qlp3wCzpQQPu0TvS/w3mWySUFF83ZjeeBy86+o+hFRvFvEp/vyeaqEUY4xhQzhAXcTEi6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JG4NnQgp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760976246; x=1792512246;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y87Qov3Jt4LC0JXlONBamFdqUvce5uT3fMcKNGfdSck=;
  b=JG4NnQgpEDpAkeQUJXH0uPPb/WDSFXn8qlR9IPiLGKamX9lCzFtqmqK0
   QX6wGrS7kwq5UuBSQrqhXD8l8MhZRaCeRnrws4ZFta+hjt7eUfGzwX51U
   uvz4cvnWOTeMMJhP61uVH8OUImH6DSm6Ex+XRdJe6ATuqKF5QGhJ7Zkhq
   HGQnDoEQ8P7BC6gXh8UC71GPLgk0v7Cc9chZRBkwJXfktT7ib6K4zWEuI
   ukvdPfbQa5AuAIbuTzi+1FfONqyy5wTNdTRjhKkDYnR3fdhYzypnc1k3V
   RqTmzFb+5RS5cWc1u+e7+YNgWfZhFNZp5+t30K3mqtDSyvEq9hmNeHWLo
   w==;
X-CSE-ConnectionGUID: kclfaq4xRUaerQvPFumMWQ==
X-CSE-MsgGUID: ktlgrbi1Qj++j1i5OUg0UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65709012"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="65709012"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 09:04:04 -0700
X-CSE-ConnectionGUID: +BNDHO+tROOuyxe325cjEA==
X-CSE-MsgGUID: tGqTHgdfTEq/PAYuNSvGDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="183379002"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.108.103]) ([10.125.108.103])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 09:04:02 -0700
Message-ID: <7d4a53ea-1d2b-42b5-ad22-3a023f415cd2@intel.com>
Date: Mon, 20 Oct 2025 09:04:01 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6 v5] acpi/ghes: Add helper for CPER CXL protocol errors
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
 Sunil V L <sunilvl@ventanamicro.com>, Xiaofei Tan <tanxiaofei@huawei.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Guo Weikang <guoweikang.kernel@gmail.com>,
 Xin Li <xin@zytor.com>, Will Deacon <will@kernel.org>,
 Huang Yiwei <quic_hyiwei@quicinc.com>, Gavin Shan <gshan@redhat.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Li Ming <ming.li@zohomail.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>,
 Jon Pan-Doh <pandoh@google.com>, Lukas Wunner <lukas@wunner.de>,
 Shiju Jose <shiju.jose@huawei.com>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
References: <20251017133357.1150982-1-fabio.m.de.francesco@linux.intel.com>
 <20251017133357.1150982-5-fabio.m.de.francesco@linux.intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251017133357.1150982-5-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/17/25 6:30 AM, Fabio M. De Francesco wrote:
> Move the CPER CXL protocol errors validity checks out of
> cxl_cper_post_prot_err() to cxl_cper_sec_prot_err_valid() and check the
> serial number only for CXL agents that are CXL devices (UEFI v2.10,
> Appendix N.2.13).
> 
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/acpi/apei/ghes.c | 32 ++++++++++++++++++++++----------
>  include/cxl/event.h      | 10 ++++++++++
>  2 files changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d6fe5f020e96e..e69ae864f43d3 100644
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
> index 6fd90f9cc2034..e1deb66c2197e 100644
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
> +	return -EINVAL;

-EOPNOTSUPP?

> +}
> +#endif
> +
>  #endif /* _LINUX_CXL_EVENT_H */



