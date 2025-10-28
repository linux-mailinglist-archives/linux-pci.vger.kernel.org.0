Return-Path: <linux-pci+bounces-39541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B9BC15456
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 15:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BBCF4FA1A0
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 14:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606B7258ECF;
	Tue, 28 Oct 2025 14:54:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7A7257459;
	Tue, 28 Oct 2025 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663263; cv=none; b=OpA45wc50LygbacS9ts+PPMGvuuzxHTT+1rtBV38/yjJAfx/+c/LIIjuo/jRypkZNhva7GaKeti2IZo2FFrpMhTA8lUW0kI7kd0MBKuxpdIhou1wpXXgeCPZL02qtKmgYvpnDf/EA8QKtPhLdpcuPoGfbY9UMp6fqd4U6goXaaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663263; c=relaxed/simple;
	bh=tEm0ctuGcJVbOHoM49mfD+yuwiiIfZ3nZWVWiNSlIPM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjhUMUNsyL0GCO8DKhQh3lC+KGlii2Wh//OXBVQP8Pm1YZNBi8tmpLLrlQez8aRukeHMuxml4X75YVshCQpOAJTenyMf2UcoZ+h+f39Ns20MIxzm+Fx8hPA1qQI+2zHmDcabjpzXaq90tU1TNcNsXeQx6ZFWlVgMV4dAktvf9VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cwtbY1HTSz6HJcR;
	Tue, 28 Oct 2025 22:50:49 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 303081402EF;
	Tue, 28 Oct 2025 22:54:19 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 14:54:17 +0000
Date: Tue, 28 Oct 2025 14:54:15 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: <linux-cxl@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	"Len Brown" <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav
 Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho
 Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
	"Davidlohr Bueso" <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	"Alison Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Sunil V L <sunilvl@ventanamicro.com>, Xiaofei Tan <tanxiaofei@huawei.com>,
	Mario Limonciello <mario.limonciello@amd.com>, Huacai Chen
	<chenhuacai@kernel.org>, Heinrich Schuchardt
	<heinrich.schuchardt@canonical.com>, Arnd Bergmann <arnd@arndb.de>, "Peter
 Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Guo
 Weikang" <guoweikang.kernel@gmail.com>, Xin Li <xin@zytor.com>, Will Deacon
	<will@kernel.org>, Huang Yiwei <quic_hyiwei@quicinc.com>, Gavin Shan
	<gshan@redhat.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6n?=
 =?ISO-8859-1?Q?ig?= <u.kleine-koenig@baylibre.com>, Li Ming
	<ming.li@zohomail.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Karolina Stolarek
	<karolina.stolarek@oracle.com>, Jon Pan-Doh <pandoh@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Shiju Jose <shiju.jose@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 4/6 v6] acpi/ghes: Add helper for CXL protocol errors
 checks
Message-ID: <20251028145415.000034bd@huawei.com>
In-Reply-To: <20251023122612.1326748-5-fabio.m.de.francesco@linux.intel.com>
References: <20251023122612.1326748-1-fabio.m.de.francesco@linux.intel.com>
	<20251023122612.1326748-5-fabio.m.de.francesco@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 23 Oct 2025 14:25:39 +0200
"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:

> Move the CPER CXL protocol errors validity out of

validity check

> cxl_cper_post_prot_err() to cxl_cper_sec_prot_err_valid() and limit the

to new cxl_cper_sec_prot_err_valid() 

as otherwise it sounds like it already exists.

> serial number check only to CXL agents that are CXL devices (UEFI v2.10,
> Appendix N.2.13).

Perhaps a little more here on why.  I assume because you are going to have
a second user for it, but good to say that. Also serves to justify the
export.

> 
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
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

Useful to return an error number?  Or would a bool be better given it is either
valid or not?

Otherwise looks good to me,

Jonathan

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



