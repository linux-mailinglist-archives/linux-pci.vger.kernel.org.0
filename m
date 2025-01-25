Return-Path: <linux-pci+bounces-20352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76816A1C0F1
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 05:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE843AC08F
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 04:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0457184D29;
	Sat, 25 Jan 2025 04:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ne6/HIk+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CD21D6DA8
	for <linux-pci@vger.kernel.org>; Sat, 25 Jan 2025 04:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737779874; cv=none; b=expGbtUV1YjkBmPWa5oDkm790G8/IAmfLrml/wbfQabKHP6CELSFAGxydDPf/tYtnRLFwLfvZ9ICv6rhEMbiNDxQZbvAkPemJKYmshnBsjoKXXEttq2h32aRbVxgP2cJfqqblwIfhWwlk9BR6usaPU2qx/mKeQ1SzbrqLW5C6Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737779874; c=relaxed/simple;
	bh=y0Yf4dv3EApdgW/5YdafrSjV4T+ztcgnOQJd1+lhbRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCo0jrv/fX6w2qS3+zD3ZEOwfxFufWyFN2EV8Ep/6CdejuUCJ+kQ7VVpAzGJxoN7FZ5mpFRaSd6QsljvZkeUtaasv9cDK0sVLbRTdCG6OeA10OWu9C/YC+SrMZXOlZSZoIlegpByIZf2TwtbEV7QlqhiKH/NpSTNYs7Qh6UkTAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ne6/HIk+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737779873; x=1769315873;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y0Yf4dv3EApdgW/5YdafrSjV4T+ztcgnOQJd1+lhbRI=;
  b=ne6/HIk+pvE+MrYnfPVhpPnZqSFMcpt6yb/Ly0jhAI8xZQgsEH/3xJTu
   ZlwEXOyWFWBizxpYIcQJVkb2pXnv4qTDppHB4aHwtJ2o7FzkRXBCG72MB
   w9YDKq8VeaoorUoflDW2o5A/wOoNwtV/89Q0PgyG6J5dtJlOvJDHvq7eD
   0W1h1TIwZ7kZlBVI6OgwtzV52//zXksI7041M6EubdZtWiDGTFd8aYYLi
   8Bh9iQQb3YXV3T99pS7DJ4nvODI69e0/1XnKhVUwq0QNRRFQO7glZefCm
   r7wiFvN2Bdyu20ifvWXka2d4P+BWNp/8TeKLJxPJJNzXQ8Zw3wZBb9els
   w==;
X-CSE-ConnectionGUID: Z1NOb07MSyeZxWj6xglaLw==
X-CSE-MsgGUID: HoAAFZfaSpi+/+kkYuaN5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="48981817"
X-IronPort-AV: E=Sophos;i="6.13,233,1732608000"; 
   d="scan'208";a="48981817"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 20:37:53 -0800
X-CSE-ConnectionGUID: V0SsHOoXSaaH2QZulIUvjA==
X-CSE-MsgGUID: 3ALKT5XJTC+xsxSF+5NQKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113087679"
Received: from dgramcko-desk.amr.corp.intel.com (HELO [10.124.223.250]) ([10.124.223.250])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 20:37:51 -0800
Message-ID: <a41ccd31-5d0f-40e2-863d-5a4548d98064@linux.intel.com>
Date: Fri, 24 Jan 2025 20:37:51 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] PCI/AER: Move AER stat collection out of
 __aer_print_error
To: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
References: <20250115074301.3514927-1-pandoh@google.com>
 <20250115074301.3514927-3-pandoh@google.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250115074301.3514927-3-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/14/25 11:42 PM, Jon Pan-Doh wrote:
> Decouple stat collection from internal AER print functions. AERs from ghes
> or cxl drivers have stat collection in pci_print_aer as that is where
> aer_err_info is populated.

Isn't pci_print_ear() internally calls __aer_print_error()? So the stat 
collection
should work fine even now. Can you give more info on why you want to
decouple here.

>
> Tested using aer-inject[1] tool. AER sysfs counters still updated
> correctly.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---
>   drivers/pci/pcie/aer.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ba40800b5494..4bb0b3840402 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -695,7 +695,6 @@ static void __aer_print_error(struct pci_dev *dev,
>   		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
>   				info->first_error == i ? " (First)" : "");
>   	}
> -	pci_dev_aer_stats_incr(dev, info);
>   }
>   
>   void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
> @@ -775,6 +774,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   	info.mask = mask;
>   	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
>   
> +	pci_dev_aer_stats_incr(dev, &info);
> +
>   	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>   	__aer_print_error(dev, &info);
>   	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
> @@ -1249,8 +1250,10 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
>   
>   	/* Report all before handle them, not to lost records by reset etc. */
>   	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
> -		if (aer_get_device_error_info(e_info->dev[i], e_info))
> +		if (aer_get_device_error_info(e_info->dev[i], e_info)) {
> +			pci_dev_aer_stats_incr(e_info->dev[i], e_info);
>   			aer_print_error(e_info->dev[i], e_info);
> +		}
>   	}
>   	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>   		if (aer_get_device_error_info(e_info->dev[i], e_info))

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


