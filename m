Return-Path: <linux-pci+bounces-41840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF5DC77000
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 03:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2F2A3424DC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 02:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECA42749C7;
	Fri, 21 Nov 2025 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="R1hj1NNz"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5185271468;
	Fri, 21 Nov 2025 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763691768; cv=none; b=MaEIyvneXMhzTJsr5h+wDMipbS8I5p8tLCT9/Vwsv/q2vQ9Aup3pcoqB5YDBXvLGmmitpA6io0EosOziKotc8djkZImTIFztsC139jOGhAWoNeLL+MFaWL4qiEq0UHqTnzrLpsFYNkZR242HijGnJGFFYFqUjHeuNgpf3RcL87c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763691768; c=relaxed/simple;
	bh=imOM9ispNwy0dbIWzenEKC4Q4T3ugDuuj8Sub6JuHXY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uRHTa281iAVUYU8E0SubcPTcyLOFlJiS9ocHd/4wb/BY3/dECNpYll3rSamGYFeSzG+Rlya/tpnDg3SZgFJnHV0mX7HbPokODXy3b6EmqO9N24d+nvxMQmIt53c5Bs1QvVknJqJRammUMkmnfaiG+cNLzNOLETHNAUe6UQVFSoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=R1hj1NNz; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OWpop7EczyzMtxVk1H5X074PcZRbXBU8JW4kSewAWro=;
	b=R1hj1NNznJn+tfgB0ayfX5o8vmLAqmDbDTi1fp3nnhDkgAf6rMG/ePZi+uUhRMkQV4/vAbCoN
	Poc/xtx15swDW+oJSzVQMLYtuQYTppIcU7FHk/aGDH+GjZutx7oVhiNgAd+CjL9/xHjmo4B6B9Q
	jJ8vGiLRCyw+nWn0bw39sao=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dCJq63xSKz1cyQG;
	Fri, 21 Nov 2025 10:20:50 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id AB8A8140295;
	Fri, 21 Nov 2025 10:22:35 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Nov 2025 10:22:34 +0800
Subject: Re: [PATCH 5/6 v7] acpi/ghes: Add helper to copy CXL protocol error
 info to work struct
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
 <20251104182446.863422-6-fabio.m.de.francesco@linux.intel.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <db92285d-43ec-c057-ad35-bbbdff7b8608@huawei.com>
Date: Fri, 21 Nov 2025 10:22:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251104182446.863422-6-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/11/5 2:22, Fabio M. De Francesco wrote:
> Make a helper out of cxl_cper_post_prot_err() that checks the CXL agent
> type and copy the CPER CXL protocol errors information to a work data
> structure.
> 
> Export the new symbol for reuse by ELOG.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>   drivers/acpi/apei/ghes.c | 42 ++++++++++++++++++++++++++--------------
>   include/cxl/event.h      | 10 ++++++++++
>   2 files changed, 37 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index e69ae864f43d..2f4632d9855a 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -734,20 +734,12 @@ int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
>   }
>   EXPORT_SYMBOL_GPL(cxl_cper_sec_prot_err_valid);
>   
> -static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> -				   int severity)
> +int cxl_cper_setup_prot_err_work_data(struct cxl_cper_prot_err_work_data *wd,
> +				      struct cxl_cper_sec_prot_err *prot_err,
> +				      int severity)
>   {
> -	struct cxl_cper_prot_err_work_data wd;
>   	u8 *dvsec_start, *cap_start;
>   
> -	if (cxl_cper_sec_prot_err_valid(prot_err))
> -		return;
> -
> -	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
> -
> -	if (!cxl_cper_prot_err_work)
> -		return;
> -
>   	switch (prot_err->agent_type) {
>   	case RCD:
>   	case DEVICE:
> @@ -756,20 +748,40 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>   	case RP:
>   	case DSP:
>   	case USP:
> -		memcpy(&wd.prot_err, prot_err, sizeof(wd.prot_err));
> +		memcpy(&wd->prot_err, prot_err, sizeof(wd->prot_err));
>   
>   		dvsec_start = (u8 *)(prot_err + 1);
>   		cap_start = dvsec_start + prot_err->dvsec_len;
>   
> -		memcpy(&wd.ras_cap, cap_start, sizeof(wd.ras_cap));
> -		wd.severity = cper_severity_to_aer(severity);
> +		memcpy(&wd->ras_cap, cap_start, sizeof(wd->ras_cap));
> +		wd->severity = cper_severity_to_aer(severity);
>   		break;
>   	default:
>   		pr_err_ratelimited("CXL CPER invalid agent type: %d\n",
>   				   prot_err->agent_type);
> -		return;
> +		return -EINVAL;
>   	}
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
>   	if (!kfifo_put(&cxl_cper_prot_err_fifo, wd)) {
>   		pr_err_ratelimited("CXL CPER kfifo overflow\n");
>   		return;
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index 4d7d1036ea9c..94081aec597a 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -322,12 +322,22 @@ static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data
>   
>   #ifdef CONFIG_ACPI_APEI_PCIEAER
>   int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err);
> +int cxl_cper_setup_prot_err_work_data(struct cxl_cper_prot_err_work_data *wd,
> +				      struct cxl_cper_sec_prot_err *prot_err,
> +				      int severity);
>   #else
>   static inline int
>   cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
>   {
>   	return -EOPNOTSUPP;
>   }
> +static inline int
> +cxl_cper_setup_prot_err_work_data(struct cxl_cper_prot_err_work_data *wd,
> +				  struct cxl_cper_sec_prot_err *prot_err,
> +				  int severity)
> +{
> +	return -EOPNOTSUPP;
> +}
>   #endif
>   
>   #endif /* _LINUX_CXL_EVENT_H */

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

