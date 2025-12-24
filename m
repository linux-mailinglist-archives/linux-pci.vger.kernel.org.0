Return-Path: <linux-pci+bounces-43625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A6ACDB1D9
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 02:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAB1A3021E5C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 01:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F72285CB6;
	Wed, 24 Dec 2025 01:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BGvBXEBr"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326A32765C0;
	Wed, 24 Dec 2025 01:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766541503; cv=none; b=BuI5No7NdfHfJTzXe2Q+tf8CufacYbRBQwqoqHkRSzQ35uuqvTOnckgYC53a1XoCg90K0Ef9RD0NGWdCGenuzWmoE3QilZDMsevDoglSmOw8TAqT2nznEZcI+0bUeLEMlh4A/7HcriKynnL/MzUZgfd4/7VGCxXOL1VpwwVjkFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766541503; c=relaxed/simple;
	bh=m/XRO2FBMScXGiJHPuEPh4Kr05SMipu8waJ+Pl6bQN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRsXwnqQUd8BaZm0TGiIxX2/A4vFYONHotvHEF1UhKGyfS3VZQgCPIIkQpOGFWnO1CPZg1dmEwcbEyPDjmwHUjfkAsF1npg4HoaMp47/zGFdmC5Sy+hdHXSoIVp+VrIqyez3rXrHM5Q2SXcwMvuS2s5HsD+4I/NSJ0k9j6wGCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BGvBXEBr; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766541492; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vpb/Ndy+7I56xYp04RK+U275InGboh5GyjLPiBNNVmE=;
	b=BGvBXEBrWR7/KzLo2KNjbkw5hBC+NeQjOor44Ea/i4fwe+9Sseo/aRhcEZO5d41nrUkXDYX8CR9uE5EeUr4Ay0Rrync7/93xEhtU281Ft3ERmDK/7bAdId6KneMrW8NJNeI5Zs5JA3k4CQpjScbXF4sqTUtZdpeGbkZTb0m9ctg=
Received: from 30.246.163.226(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WvZQeTD_1766541489 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Dec 2025 09:58:10 +0800
Message-ID: <b1b0071f-ce69-41ac-adc8-54fb0bdb7116@linux.alibaba.com>
Date: Wed, 24 Dec 2025 09:58:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5 v8] ACPI: extlog: Trace CPER Non-standard Section Body
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-cxl@vger.kernel.org
Cc: Rafael J Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>
References: <20251219124042.3759749-1-fabio.m.de.francesco@linux.intel.com>
 <20251219124042.3759749-2-fabio.m.de.francesco@linux.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20251219124042.3759749-2-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/19/25 8:39 PM, Fabio M. De Francesco wrote:
> ghes_do_proc() has a catch-all for unknown or unhandled CPER formats
> (UEFI v2.11 Appendix N 2.3), extlog_print() does not. This gap was
> noticed by a RAS test that injected CXL protocol errors which were
> notified to extlog_print() via the IOMCA (I/O Machine Check
> Architecture) mechanism. Bring parity to the extlog_print() path by
> including a similar log_non_standard_event().
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>   drivers/acpi/acpi_extlog.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index f6b9562779de0..47d11cb5c9120 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -183,6 +183,12 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>   			if (gdata->error_data_length >= sizeof(*mem))
>   				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
>   						       (u8)gdata->error_severity);
> +		} else {
> +			void *err = acpi_hest_get_payload(gdata);
> +
> +			log_non_standard_event(sec_type, fru_id, fru_text,
> +					       gdata->error_severity, err,
> +					       gdata->error_data_length);
>   		}
>   	}
>   

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai

