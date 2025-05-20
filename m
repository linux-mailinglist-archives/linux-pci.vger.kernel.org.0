Return-Path: <linux-pci+bounces-28057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2AAABCDD0
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 05:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3158A1DB1
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 03:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE582571CA;
	Tue, 20 May 2025 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bL1jQTW2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77157256C60;
	Tue, 20 May 2025 03:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747711401; cv=none; b=TAYTZmnQmmNC5EBW4EXGVgfe3UDFiSNbW6YFN5HF1y4kNJrZn9QKak5JkTY1vBXzeyBb0Xz4Iuu7n9Jt5chRF7PHTGvDMKdOwK4jgaevMXYuko/Lny3JlAVELCrXMS5ZdxSKTdrNMY0hbkKeviBMVKF8JAYo/txElHZv6y+AVOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747711401; c=relaxed/simple;
	bh=085HP7XPilFAqMffUta5x9Z+kE/97G6V4mggr3IBiuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VS2ZcYYG5bVMsg5OUGd6d4soyxsprfibI6/pBUbfhMFUkHI8+i1DqGWzSCsXIObv3G7qxUnbONA8oztlreNQQINPZb6JIOv28UTyYuyvJC3FWg3We2JzTm/A7MWZLmgnd5dJDmjZyyvrSQm2zTWEAy5RKWZhqCOZc9xSVwICGzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bL1jQTW2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747711400; x=1779247400;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=085HP7XPilFAqMffUta5x9Z+kE/97G6V4mggr3IBiuE=;
  b=bL1jQTW2vhUE2HKlb2xdFajj3IPsog84DX27urgr/agM7T0BENhezVOV
   Ox+l6+8HPUYEtajj71DX/+HcuCZImmRrMAr7VO0K8u5fpZPbPLyB24JVg
   N/DczRZXtqFGcj5woaCuQgMBLIJkUWia0+fOKFDkDJgoL3Rk+QpAG4kk5
   m3hlnmPEK8SkXmEefsLYlM9XgRcUP0AyYtN4+FKgFTCpH9FIiyQbehv9R
   l6AP44xrheh5H8Rp0E4nBChAVCBjfm0j/zJXaZnLAUtDrBNwqdzfmMbvV
   Kkl8dpOw531I9orqKNCw3KXKmS76UHF5zGKZmiMaUJqdSw1iuLcoqmbLi
   g==;
X-CSE-ConnectionGUID: efESiNA4RXiwhkluJ2gB1g==
X-CSE-MsgGUID: DUNidpCcSkqHdfVczSmbxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49765905"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49765905"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 20:23:17 -0700
X-CSE-ConnectionGUID: 4BCxmwICTFGDp8jqz2FZ8w==
X-CSE-MsgGUID: 0tKkvGx6SbOIwqDZv62iGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139289141"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO [10.124.221.39]) ([10.124.221.39])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 20:23:15 -0700
Message-ID: <bcc3f629-7ada-4ec0-bcb1-92760583c9c1@linux.intel.com>
Date: Mon, 19 May 2025 20:23:13 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/16] PCI/AER: Make all pci_print_aer() log levels
 depend on error type
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
 <20250519213603.1257897-13-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250519213603.1257897-13-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> From: Karolina Stolarek <karolina.stolarek@oracle.com>
>
> Some existing logs in pci_print_aer() log with error severity by default.
> Convert them to depend on error type (consistent with rest of AER logging).
>
> Link: https://lore.kernel.org/r/20250321015806.954866-3-pandoh@google.com
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pcie/aer.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 73b03a195b14..06a7dda20846 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -788,15 +788,21 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   	layer = AER_GET_LAYER_ERROR(aer_severity, status);
>   	agent = AER_GET_AGENT(aer_severity, status);
>   
> -	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> +	aer_printk(info.level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n",
> +		   status, mask);
>   	__aer_print_error(dev, &info);
> -	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
> -		aer_error_layer[layer], aer_agent_string[agent]);
> +	aer_printk(info.level, dev, "aer_layer=%s, aer_agent=%s\n",
> +		   aer_error_layer[layer], aer_agent_string[agent]);
>   
>   	if (aer_severity != AER_CORRECTABLE)
> -		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
> -			aer->uncor_severity);
> +		aer_printk(info.level, dev, "aer_uncor_severity: 0x%08x\n",
> +			   aer->uncor_severity);
>   
> +	/*
> +	 * pcie_print_tlp_log() uses KERN_ERR, but we only call it when
> +	 * tlp_header_valid is set, and info.level is always KERN_ERR in
> +	 * that case.
> +	 */
>   	if (tlp_header_valid)
>   		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
>   }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


