Return-Path: <linux-pci+bounces-28047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB82BABCBC2
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 01:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858D617172F
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1FD1E5B60;
	Mon, 19 May 2025 23:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8+hR1Xu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D861F4B1E5E;
	Mon, 19 May 2025 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747698613; cv=none; b=jl9rR7qt3L2T3f3sSGz6aboTx+xc6EEvKBVii//CAqXpYX+aGtyCa/r0vFYr+r7zqHAr1tzIOXKyAZb+uu2JqZLOhr29VncA6UKd3vEAtU3qN19zzFQ29R65wdCuc9yEuc4K/+7FkzqFLbYNO5lvJQj7Zq+ngfpV+xwrVCVZU+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747698613; c=relaxed/simple;
	bh=lZceSJXorFTEkulyn9ZEpocZ9KdHmanpjYWje8SpBZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jg/XVmBmF1cLLWND//ZrnHoncR+nPGJvtPIOdR4zJedwx8pKR3xsixpCRDDie/rpiR0r5PD3JVyN9b0+gOMEjup/sdcp++ZAASSw5apXIn19L+BWSXwFmGv8eazEFfgj0fIQ8bxgsOz9e2JaC3BzylBF9NDvLWFn3JCx2ahQdLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8+hR1Xu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747698612; x=1779234612;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lZceSJXorFTEkulyn9ZEpocZ9KdHmanpjYWje8SpBZE=;
  b=U8+hR1XuEHq5W7MzQ55Wyi7OAQp3Ju6potvVuHC9IYAh1w+92rP7AeYh
   AbqdN+j/Vk6klYQVRl6KEQu2U4lNRs4nAOIuoFSI3uO4OJ9fzSWOA30Vr
   lWkLd9YPKC052i1WAe5uhxo/TJF0YV5ZZbWd1X1r1LK8nXeCFJ7lrZwrF
   RO2DcrtrVbIl6Xwz9y1ZxUwqJU+2xk/1lceLu5nTRtmDIzvZKhAbAKzes
   Se0YA+3Xj01JZaNJdf4GTLY6myj9Jkit5TRKz8EdhwVl9ZHRhNT+43bdY
   vi8q0Mast6VjECsF9RCHMgnFjQjjAjtCnhugB0E+pO5eBdIOTKwHG35rX
   w==;
X-CSE-ConnectionGUID: G163r4SLSVaGQsShCi9gGA==
X-CSE-MsgGUID: cwN6R8WlR+yw0u/HmBpAlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49597529"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49597529"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 16:50:11 -0700
X-CSE-ConnectionGUID: BHWC+09MQHe2nNUF1Md6Uw==
X-CSE-MsgGUID: iqvNMD7aRDOTuCwHgojYgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="162811471"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO [10.124.221.39]) ([10.124.221.39])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 16:50:09 -0700
Message-ID: <ef2fec8c-2efa-44be-add7-480344d1c446@linux.intel.com>
Date: Mon, 19 May 2025 16:50:09 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/16] PCI/AER: Initialize aer_err_info before using it
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
 <20250519213603.1257897-8-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250519213603.1257897-8-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Previously the struct aer_err_info "e_info" was allocated on the stack
> without being initialized, so it contained junk except for the fields we
> explicitly set later.
>
> Initialize "e_info" at declaration with a designated initializer list,
> which initializes the other members to zero.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pcie/aer.c | 37 ++++++++++++++++---------------------
>   1 file changed, 16 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 95a4cab1d517..40f003eca1c5 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1281,7 +1281,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   		struct aer_err_source *e_src)
>   {
>   	struct pci_dev *pdev = rpc->rpd;
> -	struct aer_err_info e_info;
> +	u32 status = e_src->status;
>   
>   	pci_rootport_aer_stats_incr(pdev, e_src);
>   
> @@ -1289,14 +1289,13 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   	 * There is a possibility that both correctable error and
>   	 * uncorrectable error being logged. Report correctable error first.
>   	 */
> -	if (e_src->status & PCI_ERR_ROOT_COR_RCV) {
> -		e_info.id = ERR_COR_ID(e_src->id);
> -		e_info.severity = AER_CORRECTABLE;
> -
> -		if (e_src->status & PCI_ERR_ROOT_MULTI_COR_RCV)
> -			e_info.multi_error_valid = 1;
> -		else
> -			e_info.multi_error_valid = 0;
> +	if (status & PCI_ERR_ROOT_COR_RCV) {
> +		int multi = status & PCI_ERR_ROOT_MULTI_COR_RCV;
> +		struct aer_err_info e_info = {
> +			.id = ERR_COR_ID(e_src->id),
> +			.severity = AER_CORRECTABLE,
> +			.multi_error_valid = multi ? 1 : 0,
> +		};
>   
>   		if (find_source_device(pdev, &e_info)) {
>   			aer_print_source(pdev, &e_info, "");
> @@ -1304,18 +1303,14 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   		}
>   	}
>   
> -	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
> -		e_info.id = ERR_UNCOR_ID(e_src->id);
> -
> -		if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
> -			e_info.severity = AER_FATAL;
> -		else
> -			e_info.severity = AER_NONFATAL;
> -
> -		if (e_src->status & PCI_ERR_ROOT_MULTI_UNCOR_RCV)
> -			e_info.multi_error_valid = 1;
> -		else
> -			e_info.multi_error_valid = 0;
> +	if (status & PCI_ERR_ROOT_UNCOR_RCV) {
> +		int fatal = status & PCI_ERR_ROOT_FATAL_RCV;
> +		int multi = status & PCI_ERR_ROOT_MULTI_UNCOR_RCV;
> +		struct aer_err_info e_info = {
> +			.id = ERR_UNCOR_ID(e_src->id),
> +			.severity = fatal ? AER_FATAL : AER_NONFATAL,
> +			.multi_error_valid = multi ? 1 : 0,
> +		};
>   
>   		if (find_source_device(pdev, &e_info)) {
>   			aer_print_source(pdev, &e_info, "");

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


