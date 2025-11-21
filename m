Return-Path: <linux-pci+bounces-41839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDA3C76FE8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 03:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90766342310
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 02:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E70F1DF271;
	Fri, 21 Nov 2025 02:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="RvqFAzh+"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A77419C54F;
	Fri, 21 Nov 2025 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763691410; cv=none; b=qxaRT8kHWEqTDPy0Sfywovnrm9X2wOlOFgUqueIxSGVI6qc+W5MPtgksjdx8tEWWY+OBtTHUnEflLjW1X46NixkNFqX6NGJHcAxyq12IaIXCDrd1yOs6KmIfPK5bGxIAaTlV0wKVxxWKgLy5KFZlCYCV3hGZG3VB6tu1tfDChCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763691410; c=relaxed/simple;
	bh=b/uCKpPyaSdq9s3O9D7XRjoUvpaCH2BCenNh0lN9liQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=s+/gCgdgD/SiX1RTDREdykyEVklH4yNrW0etsopdbU5CuO4vL1wswk8KG5V0Lc4vdkMymM7OanJd/v1rU1FzM7DSR/nv6Bcsa7QdwnvWsaZFbBKSjRE3ayYdTJ0a66Q/FoNA4jeYO5uwwpvoo99rbrUCzajdUkQijh+tdstgVVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RvqFAzh+; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=unDFX70B+FQbAkazFOoPJRogIVHvfB0DVd2thP7YQjA=;
	b=RvqFAzh+qpKThBRqRW6kA80R70j3IuhxyjOmmvhA93YhlQPV1s8Zx8t8fVQ5t41sFFKciqovn
	K48KnlhRMiyY/v8UUuVtN8+wkrSevMoirig60uW9NKOgkl4my+p4EGMz5i+0lLr2JOomFfAOXok
	F/JwpkKB9oS/QfQG6Fk5OFE=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dCJhH4K5dzLlSZ;
	Fri, 21 Nov 2025 10:14:55 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FFE4180043;
	Fri, 21 Nov 2025 10:16:40 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Nov 2025 10:16:38 +0800
Subject: Re: [PATCH 4/6 v7] acpi/ghes: Add helper for CXL protocol errors
 checks
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	<linux-cxl@vger.kernel.org>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
References: <20251104182446.863422-1-fabio.m.de.francesco@linux.intel.com>
 <20251104182446.863422-5-fabio.m.de.francesco@linux.intel.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <356c8be5-1397-a317-2354-4e8e25bba305@huawei.com>
Date: Fri, 21 Nov 2025 10:16:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251104182446.863422-5-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/11/5 2:22, Fabio M. De Francesco wrote:
> Move the CPER CXL protocol errors validity check out of
> cxl_cper_post_prot_err() to new cxl_cper_sec_prot_err_valid() and limit
> the serial number check only to CXL agents that are CXL devices (UEFI
> v2.10, Appendix N.2.13).
> 
> Export the new symbol for reuse by ELOG.
> 
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>   drivers/acpi/apei/ghes.c | 32 ++++++++++++++++++++++----------
>   include/cxl/event.h      | 10 ++++++++++
>   2 files changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d6fe5f020e96..e69ae864f43d 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -706,30 +706,42 @@ static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
>   static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
>   struct work_struct *cxl_cper_prot_err_work;
>   
> -static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> -				   int severity)
> +int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
>   {
> -	struct cxl_cper_prot_err_work_data wd;
> -	u8 *dvsec_start, *cap_start;
> -
>   	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
>   		pr_err_ratelimited("CXL CPER invalid agent type\n");
> -		return;
> +		return -EINVAL;
>   	}
>   
>   	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
>   		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
> -		return;
> +		return -EINVAL;
>   	}
>   
>   	if (prot_err->err_len != sizeof(struct cxl_ras_capability_regs)) {
>   		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
>   				   prot_err->err_len);
> -		return;
> +		return -EINVAL;
>   	}
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
>   	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
>   
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index 6fd90f9cc203..4d7d1036ea9c 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -320,4 +320,14 @@ static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data
>   }
>   #endif
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
>   #endif /* _LINUX_CXL_EVENT_H */

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

