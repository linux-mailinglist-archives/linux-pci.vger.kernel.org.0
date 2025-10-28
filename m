Return-Path: <linux-pci+bounces-39548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0D4C15CD1
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 17:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B073B3F5A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 16:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6309728C5DE;
	Tue, 28 Oct 2025 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MiP0vk8Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DFE263F32;
	Tue, 28 Oct 2025 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668397; cv=none; b=oXOGiKDJUg2Ws1TXRmYKzkHrDwCX/FkVYsz6DwoZHp4Kvzp6L8MJTmv85OoWu9HK9IEymZ+v9npULJs4A/gyN1gu8nrZfNstuCVGabVJwBES9mpF/G9d+0AqmVR/W5777OlnuYZmt3Bc7sUNoUr4FFLI/6S4SA2y3wWBzn1svjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668397; c=relaxed/simple;
	bh=ql0oHBgcfkHjGUpO+SghiDYcqKotDono1NNct+0rvfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYcVHvPLGfxU+BqwFxU16+SkVdFqP2VZfsMppsE8DDyNLITtLqHNIpqGgmWQIcXsLFNuXxw8NEy83hquzzaat5oKKNufIxosQFs4GT5sgfwYnLVNZoYSV4Rdvi9IRj6FabXh1lDONl2yzCNGI5pdLimSpwtbKAu2EJgecn/W9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MiP0vk8Y; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761668395; x=1793204395;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ql0oHBgcfkHjGUpO+SghiDYcqKotDono1NNct+0rvfg=;
  b=MiP0vk8Yk6OlWfel7fsvba+m2Tm8UZIc6r01s2MGC+0/OkWVHrN5jRRa
   3fHYytH9gIR3NF18UjF5Vt/t5LTStzFDjcEWZbPFlPUQlp+lxFxoQfvQI
   uGtl6vzcVz6fKmfN2wznE5usqB2hCfs96OLOTFB3hclv0+TYLpFIXqrZr
   FALuKrX39QTM7eJ/5dbD3U3xcyKR7tf7l8/mjt0hsNiS0Xt4Rgp7rQ5+s
   Uca2Yjpf9xkKx9iNLvOAMeN5mtH8onU3bOwnMwJOQh42bjXlYdMwbUY3m
   XuBwstFT2q8zMN3VfUSNo8jgFaaFm/c1sumXAtFHWXnKOf/2jCRgPiAna
   Q==;
X-CSE-ConnectionGUID: 29TaYD4RRpWm1qtFNa9fqg==
X-CSE-MsgGUID: GjXZNZQlR4a9S/E7CVuDjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62979185"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="62979185"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 09:19:54 -0700
X-CSE-ConnectionGUID: UGf4618tTTyI56XQsvU/MQ==
X-CSE-MsgGUID: AY3nXcO2R7KvdLAQ9FIFXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="190528315"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 09:19:53 -0700
Message-ID: <bf4e81e4-70c2-434d-960d-d3b2277ac8ca@linux.intel.com>
Date: Tue, 28 Oct 2025 09:19:43 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6 v6] ACPI: extlog: Trace CPER Non-standard Section Body
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-cxl@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
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
 Karolina Stolarek <karolina.stolarek@oracle.com>,
 Jon Pan-Doh <pandoh@google.com>, Lukas Wunner <lukas@wunner.de>,
 Shiju Jose <shiju.jose@huawei.com>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
References: <20251023122612.1326748-1-fabio.m.de.francesco@linux.intel.com>
 <20251023122612.1326748-2-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20251023122612.1326748-2-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/23/2025 5:25 AM, Fabio M. De Francesco wrote:
> ghes_do_proc() has a catch-all for unknown or unhandled CPER formats
> (UEFI v2.10 Appendix N 2.3), extlog_print() does not. This gap was

Latest is v2.11, right? Why not use it for reference?

> noticed by a RAS test that injected CXL protocol errors which were
> notified to extlog_print() via the IOMCA (I/O Machine Check
> Architecture) mechanism. Bring parity to the extlog_print() path by
> including a similar log_non_standard_event().
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


>  drivers/acpi/acpi_extlog.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index f6b9562779de..47d11cb5c912 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -183,6 +183,12 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			if (gdata->error_data_length >= sizeof(*mem))
>  				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
>  						       (u8)gdata->error_severity);
> +		} else {
> +			void *err = acpi_hest_get_payload(gdata);
> +
> +			log_non_standard_event(sec_type, fru_id, fru_text,
> +					       gdata->error_severity, err,
> +					       gdata->error_data_length);
>  		}
>  	}
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


