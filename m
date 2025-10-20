Return-Path: <linux-pci+bounces-38776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FFDBF2785
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 18:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 363D04E89E9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 16:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09772853EF;
	Mon, 20 Oct 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="as/MNCVJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D338B22172E;
	Mon, 20 Oct 2025 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978250; cv=none; b=V9ArlMP+nGHZgAfGJT5AoCG0DOCplbZ4a/bbnahQ3AS0xmlQ6P6CInoNtwYRyQYM/bs9igQvLSwbAfWxteJ5e5Wm9PUXF4XqO/GwKBSnOu522/fpTodLssEhxzuAXEeUlKBW0BWLQMGJ9arJdIhL3xWddH8/eEDv4UY0JWGe3HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978250; c=relaxed/simple;
	bh=+qZlyl7YWbY2lLgbuJo2hAw91ag2rew7u58FOPhtmUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vur5FNfifWmpQRJldMSCd4mVByB8/aX8XiPr6Vzj8+wkRyzm+WR4iLAP56NuKUF05zsK+UZXsgO8Bmy/i9bPduIo4glSiBrxf9ygM95GuDlm7Yztk6hWNbjrQPPWdymwMhxVYaulyyj79mvaXTrspF373q/6HTySmm+K2qixi30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=as/MNCVJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760978249; x=1792514249;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+qZlyl7YWbY2lLgbuJo2hAw91ag2rew7u58FOPhtmUc=;
  b=as/MNCVJcrzmNh+0bn6hh1WJNoRzwygBr6cr8DU3pvqEtXW6zHouvebC
   WpODTllRf00Rg6p3B1Sx9TKjnP3cZdhfW1BJN7IjKyODEhUw1DO7coUzw
   SX7AeEfBSNwxsDYHw4dEZ9XcQ0ZwWTgEOBEVERMxGnX8I7yFU7/4VZPWB
   LZxH8WtBjGgEW8D1y7JcCPN+AO3vWXtbwpJ5cJwX2Xc6JCu+Dc8rkxEc/
   hxxVIjqmbp4Utz/dLKh1EJD/iwQLLs40BFC7uA7gv/NQD0GIdpAxjfDWW
   KRH4IfDBkJ7KIYvy9n21OEnHPNkUwsV2SnXmcBYtZ5WTMIZWy8qffMhRs
   Q==;
X-CSE-ConnectionGUID: McZZEvecSS2YqWEVpaigCQ==
X-CSE-MsgGUID: CMrSmZBjRpOfNm+xecXq1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62128784"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="62128784"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 09:37:28 -0700
X-CSE-ConnectionGUID: +UyQQ5tfSKWNT1m4Aaq+lw==
X-CSE-MsgGUID: MUZlesziQx6BDxCrg5eraA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="183385703"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.108.103]) ([10.125.108.103])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 09:37:25 -0700
Message-ID: <ca6e8c5f-4420-4efa-93fc-0c79774e8a96@intel.com>
Date: Mon, 20 Oct 2025 09:37:24 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6 v5] acpi/ghes: Add helper to copy CXL protocol error
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
 <20251017133357.1150982-6-fabio.m.de.francesco@linux.intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251017133357.1150982-6-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/17/25 6:30 AM, Fabio M. De Francesco wrote:
> Make a helper out of cxl_cper_post_prot_err() that checks the CXL agent
> type and copy the CPER CXL protocol errors information to a work data
> structure.
> 
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/acpi/apei/ghes.c | 42 ++++++++++++++++++++++++++--------------
>  include/cxl/event.h      | 10 ++++++++++
>  2 files changed, 37 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index e69ae864f43d3..e0f8b8ed2b7c4 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -734,20 +734,12 @@ int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
>  }
>  EXPORT_SYMBOL_GPL(cxl_cper_sec_prot_err_valid);
>  
> -static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> -				   int severity)
> +int cxl_cper_sec_prot_err_copy_to_wd(struct cxl_cper_prot_err_work_data *wd,

Function name a bit awkward. Maybe cxl_cper_setup_error_work_data()?

> +				     struct cxl_cper_sec_prot_err *prot_err,
> +				     int severity)
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
> +		memcpy(wd->prot_err, prot_err, sizeof(wd->prot_err));
>  
>  		dvsec_start = (u8 *)(prot_err + 1);
>  		cap_start = dvsec_start + prot_err->dvsec_len;
>  
> -		memcpy(&wd.ras_cap, cap_start, sizeof(wd.ras_cap));
> -		wd.severity = cper_severity_to_aer(severity);
> +		memcpy(wd->ras_cap, cap_start, sizeof(wd->ras_cap));
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
> +EXPORT_SYMBOL_GPL(cxl_cper_sec_prot_err_copy_to_wd);
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
> +	if (cxl_cper_sec_prot_err_copy_to_wd(&wd, prot_err, severity))
> +		return;
> +
>  	if (!kfifo_put(&cxl_cper_prot_err_fifo, wd)) {
>  		pr_err_ratelimited("CXL CPER kfifo overflow\n");
>  		return;
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index e1deb66c2197e..5f06cea5d6005 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -322,12 +322,22 @@ static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data
>  
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
>  int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err);
> +int cxl_cper_sec_prot_err_copy_to_wd(struct cxl_cper_prot_err_work_data *wd,
> +				     struct cxl_cper_sec_prot_err *prot_err,
> +				     int severity);
>  #else
>  static inline int
>  cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
>  {
>  	return -EINVAL;
>  }
> +static inline int
> +cxl_cper_sec_prot_err_copy_to_wd(struct cxl_cper_prot_err_work_data *wd,
> +				 struct cxl_cper_sec_prot_err *prot_err,
> +				 int severity)
> +{
> +	return -EINVAL;

-EOPNOTSUPP

> +}
>  #endif
>  
>  #endif /* _LINUX_CXL_EVENT_H */


