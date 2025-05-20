Return-Path: <linux-pci+bounces-28051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9838BABCC6F
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 03:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACAF97A61F7
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 01:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711A3253F35;
	Tue, 20 May 2025 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQw6p0QQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FAE4317D;
	Tue, 20 May 2025 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747705793; cv=none; b=bW0robq0Ry99igXoU9Q7veGIrtrFQLZYHrXVTN7rPHVbrzRhKf+PbaEi8h0c5SyFUuYGuALUTpWWy083Dmv21VKtyVtRYvhTyiQ1ZNlx5FMtUtmo+1VVbYD5s11+MPf+2+A15reQd15LZxXAFBmKssGNSjZPNtisfsQfokp6uNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747705793; c=relaxed/simple;
	bh=vsLxZwJQaEjAfR/JuZ5NYNwq+/uZf2rMOMPY+vUbdi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUVOna/FCb4eLL1eAudETBw1IYPbYv/9JWAA8tY6RQvauytUHc26bOFPdIvFsULDNUiguenf2ZAR/T7Pd5VSIZLqJzRpeaKRuHw8oneHjs8HRRdAW4vy3VaCmq/cYcPMH5GYQXT7zMve9JvTIzJntRm1UHdompzzshiIyqqjja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQw6p0QQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747705791; x=1779241791;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vsLxZwJQaEjAfR/JuZ5NYNwq+/uZf2rMOMPY+vUbdi0=;
  b=BQw6p0QQUSuA3FH7Bn22sQuFxguF44kmr578kw81fyIaIHxCk3/ehn7o
   1IAtkKx8IpPrWofYFGR9UjHhzOdpNjlPl73mZy0Wcw7b7U9YXOrecibTW
   UU3HoemryXH3ntH09jd/Rmfgc99PvuODGwhjO/Wg/DVp7o6HbCwicgWaq
   +AzgC/ngFRmr+R4/SvE0/sECy/Zf3rOxMRgl/tBi1VqKNmt9FsmtVf+A0
   ExegUnW2Lj6wboTU56CYd6l+Nzot1sqLSHs2Aclu2BekGNSVnn80Y43Jo
   hgfCFzUcwpLQP5KTTRVP/c1NTzLuP8wkAIby11P6sWl0QQo87LhlrANMr
   A==;
X-CSE-ConnectionGUID: n53HrImoS22L1ystEaXaOw==
X-CSE-MsgGUID: WCZ4yYPOQFu1+gQySEeyHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="48737300"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="48737300"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 18:49:50 -0700
X-CSE-ConnectionGUID: 0zrs3Y+BSOak+jEDiEkNbQ==
X-CSE-MsgGUID: md5biXXwRjyq3FH5wZYmvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140063943"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO [10.124.221.39]) ([10.124.221.39])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 18:49:49 -0700
Message-ID: <6774c3a6-9d0e-4a73-bfb1-91507ce85411@linux.intel.com>
Date: Mon, 19 May 2025 18:49:49 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/16] PCI/AER: Combine trace_aer_event() with
 statistics updates
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>,
 Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20250519213603.1257897-1-helgaas@kernel.org>
 <20250519213603.1257897-11-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250519213603.1257897-11-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> As with the AER statistics, we always want to emit trace events, even if
> the actual dmesg logging is rate limited.
>
> Call trace_aer_event() directly from pci_dev_aer_stats_incr(), where we
> update the statistics.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pcie/aer.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index eb80c382187d..4683a99c7568 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -625,6 +625,9 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
>   	u64 *counter = NULL;
>   	struct aer_stats *aer_stats = pdev->aer_stats;
>   
> +	trace_aer_event(pci_name(pdev), (info->status & ~info->mask),
> +			info->severity, info->tlp_header_valid, &info->tlp);
> +
>   	if (!aer_stats)
>   		return;
>   
> @@ -741,9 +744,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   out:
>   	if (info->id && info->error_dev_num > 1 && info->id == id)
>   		pci_err(dev, "  Error of this Agent is reported first\n");
> -
> -	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
> -			info->severity, info->tlp_header_valid, &info->tlp);
>   }
>   
>   #ifdef CONFIG_ACPI_APEI_PCIEAER
> @@ -782,6 +782,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   
>   	info.status = status;
>   	info.mask = mask;
> +	info.tlp_header_valid = tlp_header_valid;
> +	if (tlp_header_valid)

I think you can skip this check. The trace call checks for valid flag before accessing
the tlp buffer. If you want to keep it, try to set it to NULL for !tlp_header_valid case.

> +		info.tlp = aer->header_log;
>   
>   	pci_dev_aer_stats_incr(dev, &info);
>   
> @@ -799,9 +802,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   
>   	if (tlp_header_valid)
>   		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
> -
> -	trace_aer_event(pci_name(dev), (status & ~mask),
> -			aer_severity, tlp_header_valid, &aer->header_log);
>   }
>   EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>   

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


