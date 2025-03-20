Return-Path: <linux-pci+bounces-24194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07674A69E5B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 03:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4EE8A52A4
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 02:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3091A239F;
	Thu, 20 Mar 2025 02:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqiNKk56"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD855D477
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 02:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742438358; cv=none; b=Fxr9jTGbOUNXq17I5xGkxgo41iRhFbhWuIujKI0uPkizuf4XktC4POiDbmb01GepTw6u8w3XmRA72+5HQ3yaWv38e6AY5MmGxM7EUt9G4mW8OU2lpbwUT0P2vQhx/qiBQpQ4wWDe3EVVxJOFJMJHhwI8KtgDkMw9zHjxqJUlqKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742438358; c=relaxed/simple;
	bh=F9vIWIBUnGVyaMBX8lWx3h8tT4Q/E/Y84an6wjtpnWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOUwHeNLzTo1ZMxv/zjyXlRGWJtdGlpfu24+XnQpr4PE6Up+IFjyvxCyPqGGI9exBIrwjWmsDDR2BNpZPjmYTqOS07hyj83zgjFIGBLiifIVTWa6LYssQMKq1j0iSIJrB1CUulGbQAZeD17WUw3bdzPI18nd56YvdGebHcUFiQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqiNKk56; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742438357; x=1773974357;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F9vIWIBUnGVyaMBX8lWx3h8tT4Q/E/Y84an6wjtpnWE=;
  b=VqiNKk56mtFg+wetGE/rXGpGnVkeDYCpqjkBvJGJR9hmc+3OIYbno9g2
   Kmijbad5kSLVYZuFLD4QFvMs2omBsEACxJ/sAI9Coz9sbCFigxEtzanEg
   7YTD3U4nBjC6KtbcO4N6+Et7hSZFLaQUbH+8svUEl84eO++EycqhWU/cF
   lytgrXgCYtVa6tUrDjMhHRqGzrm/NM1uUtE5vdcrxqe4O/5aw2/NqBDnG
   sbTB4hQFx4SBO9PJcSkuNfEsNwbegw++kn2HN7v8pL0HCIZQDM/rKiLGA
   WNzXEU4k30CWATiSI8krp1MkWTzsWCFDEs29nF4rOEPAcwdEzr8Zu4I2c
   A==;
X-CSE-ConnectionGUID: /xF9caoBQTSotzTxmaNPXA==
X-CSE-MsgGUID: Lqbf4d1bTw6wQexKg4ioSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="69009436"
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="69009436"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 19:39:16 -0700
X-CSE-ConnectionGUID: e2yFTPjTSDyAt/Qv1qao+w==
X-CSE-MsgGUID: Lz3ppqZtTJy8fI4rWRjE2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="122905408"
Received: from uaeoff-desk2.amr.corp.intel.com (HELO [10.124.220.142]) ([10.124.220.142])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 19:39:15 -0700
Message-ID: <79f4ddd5-af44-4fc9-9f04-4e79f66db21e@linux.intel.com>
Date: Wed, 19 Mar 2025 19:39:14 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] PCI/AER: Make all pci_print_aer() log levels
 depend on error type
To: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Terry Bowman <Terry.bowman@amd.com>
References: <20250319084050.366718-1-pandoh@google.com>
 <20250319084050.366718-3-pandoh@google.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250319084050.366718-3-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/19/25 1:40 AM, Jon Pan-Doh wrote:
> From: Karolina Stolarek <karolina.stolarek@oracle.com>
>
> Some existing logs in pci_print_aer() log with error severity
> by default. Convert them to depend on error type (consistent
> with rest of AER logging).
>
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---

Since the original patch from Ilpo is not yet merged, may be it
worth considering add this change part of the same patch.

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pcie/aer.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index cc9c80cd88f3..7eeaad917134 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -784,14 +784,14 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   	info.mask = mask;
>   	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
>   
> -	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> +	aer_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>   	__aer_print_error(dev, &info, level);
> -	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
> -		aer_error_layer[layer], aer_agent_string[agent]);
> +	aer_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
> +		   aer_error_layer[layer], aer_agent_string[agent]);
>   
>   	if (aer_severity != AER_CORRECTABLE)
> -		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
> -			aer->uncor_severity);
> +		aer_printk(level, dev, "aer_uncor_severity: 0x%08x\n",
> +			   aer->uncor_severity);
>   
>   	if (tlp_header_valid)
>   		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


