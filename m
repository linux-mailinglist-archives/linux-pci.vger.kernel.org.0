Return-Path: <linux-pci+bounces-28050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8435ABCC4B
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 03:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBFB37B02E1
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 01:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440921D89E3;
	Tue, 20 May 2025 01:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KuxyGbOl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D811136327;
	Tue, 20 May 2025 01:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747704765; cv=none; b=g6wnKDEr94IJfgUR6ZHQAQwEOmvP6wLy1fXvuCZpoTSMFgtgrw+6oVzOt80TfVmw8h3j9NEyTJtoC7+HGpST+X7BOfKAqBozCBJoY0cNwwLH/DRdhnxm2Gl3w91ApX2UeP+mN8CF6XRJX/K4F1a7bxHbBCB2sRRgmK4gFzEDnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747704765; c=relaxed/simple;
	bh=giaSwuHieTqwGgTsYdG88FEyVGxZpG3P9dwKAPi9yfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKgNMRn3qUYwZvikBfcSaaA2Fvy2JghZECN1YeKfZpOSYh5D21j45XWtagsH1HWCxBeIilQSpNwOpQYb4ELP/VY/aa50rZyjNT/BtO3LIaYuiwhkDqvMxnHNfthYvMf5JrPWanSI14q9xb63bzDwC+kSfGAqkZVLEC8/ePZTIf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KuxyGbOl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747704763; x=1779240763;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=giaSwuHieTqwGgTsYdG88FEyVGxZpG3P9dwKAPi9yfs=;
  b=KuxyGbOlSSuhZRxusgWfckgUbY3iBXnHwBzxESfrkh3AOETLauPhGd0X
   8WMJJxdk8ZvtGS5ralsN+wAcNz2RqBnoIHaCb6srTl3EFvlUHq1yNv6lg
   VkzlMDCq0KoNfpsu/rv2PHJnCsL46+qq7rRhYx91nrgeqeDDK8n2QG5H6
   6KpIDzOd6wL84cCMlmP0o5bI2Xad7IxnqkmJzkhX8o+/+ZOflzpfdvSL0
   LwHzkz+F46s+zH6yuXqwNDJiwVXH2GnNs9+M+Q6Yc2VGOgohJreCkLQ+Y
   5HCSrFBynU/+4Um8hR35N6oSfJnE6W4aOplF+K67ADTy6FlHougDSx5go
   A==;
X-CSE-ConnectionGUID: qzlAvQ4yTcmbObb3fxo9dA==
X-CSE-MsgGUID: LbvByP9lTmuZbHaHxt+IXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="48873790"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="48873790"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 18:32:42 -0700
X-CSE-ConnectionGUID: YZ3GzqMlTm2bKFghH6fY0w==
X-CSE-MsgGUID: w2CTRgTqTgqZy9BhjouVRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139373805"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO [10.124.221.39]) ([10.124.221.39])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 18:32:15 -0700
Message-ID: <92b8da5f-081d-4ca5-98f1-73d6bc3af743@linux.intel.com>
Date: Mon, 19 May 2025 18:32:13 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/16] PCI/AER: Update statistics early in logging
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
 <20250519213603.1257897-10-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250519213603.1257897-10-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> There are two AER logging entry points:
>
>    - aer_print_error() is used by DPC (dpc_process_error()) and native AER
>      handling (aer_process_err_devices()).
>
>    - pci_print_aer() is used by GHES (aer_recover_work_func()) and CXL
>      (cxl_handle_rdport_errors())
>
> Both use __aer_print_error() to print the AER error bits.  Previously
> __aer_print_error() also incremented the AER statistics via
> pci_dev_aer_stats_incr().
>
> Call pci_dev_aer_stats_incr() early in the entry points instead of in
> __aer_print_error() so we update the statistics even if the actual printing
> of error bits is rate limited by a future change.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pcie/aer.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 73d618354f6a..eb80c382187d 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -693,7 +693,6 @@ static void __aer_print_error(struct pci_dev *dev,
>   		aer_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
>   				info->first_error == i ? " (First)" : "");
>   	}
> -	pci_dev_aer_stats_incr(dev, info);
>   }
>   
>   static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
> @@ -714,6 +713,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   	int id = pci_dev_id(dev);
>   	const char *level;
>   
> +	pci_dev_aer_stats_incr(dev, info);
> +
>   	if (!info->status) {
>   		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
>   			aer_error_severity_string[info->severity]);
> @@ -782,6 +783,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   	info.status = status;
>   	info.mask = mask;
>   
> +	pci_dev_aer_stats_incr(dev, &info);
> +
>   	layer = AER_GET_LAYER_ERROR(aer_severity, status);
>   	agent = AER_GET_AGENT(aer_severity, status);
>   

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


