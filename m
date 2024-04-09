Return-Path: <linux-pci+bounces-5970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2893A89E326
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 21:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D758D288BCE
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 19:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591A4157480;
	Tue,  9 Apr 2024 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSsRxTrL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDE2157462;
	Tue,  9 Apr 2024 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690153; cv=none; b=SzzP21ETR5J4Ixq3XwTMI4VHNgMpFMegvHbJ8H8BOhSU+UCkcsE/tbJ1vWjyRb+nZ+nZIteEUqDulUgJX40JsV1zRUzsAT5vSMAfGykmisEKHaPpGzPLGKjEox2TeOSxAr8opJCvaZCAUJHreVzoRwHqPL/Qxc18bdCasAS8jgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690153; c=relaxed/simple;
	bh=P3Z0Rgecbqy5GMoJK4XNHZXEK5RvpqeukRb0HOaJO/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nX20V7l4k7vAySZINJJt6RTUVMNkdqUhuM2KXw96HYN3hSVzHX7xDmCDRXCZltQKZta17imEwFYBXrD1RJ7fbzNQYpYkPXPU7qQC2/PuNWhM0a+hWHqLrEdCmYLOmELeGeV89qF75zMwxn40xcsNs1W7b+IN2s6YQKfL39cHKrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dSsRxTrL; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712690151; x=1744226151;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P3Z0Rgecbqy5GMoJK4XNHZXEK5RvpqeukRb0HOaJO/8=;
  b=dSsRxTrL4TlKGZeRIs0v4Q5uex9CkZEjXRYuKuCD0Qsc1mNMbApmoL+p
   MwbdX1ejrcwM5Bew0yIpbUdL2/I88FeTTwREpPncwCP0ttZe4ACHGF5wi
   MDfSdCiMMIeueYO6G6RlZS8pluC2G5GS94w00mhb3KrvdSubP0a+rk104
   zv50Ogh3QYy1yaNqhJpuaPfsb15L3rQXjAK0ugsCT8mp5LiyqO+TqzuKP
   +oIY3xjCr95173VPl51xeXyOhHODIpbYycF0+W9vvdMz79/PAF5iVbt/X
   Joz8RueHXjOYqyzj2kPcSDqlM/AcK/VOX93oh0vbRCYeI3+IYilzh6Nwx
   Q==;
X-CSE-ConnectionGUID: 98rE46KKS/qLZsRYigUARw==
X-CSE-MsgGUID: I/SV1O94SIOWwyy/qe7Ung==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7881509"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7881509"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 12:15:51 -0700
X-CSE-ConnectionGUID: VVzvsBA/Q8SPNaJnk07HcQ==
X-CSE-MsgGUID: wOsuXYO9RDOj0ZYquYcTMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="24814231"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.183.123]) ([10.213.183.123])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 12:15:51 -0700
Message-ID: <519bf934-840b-496d-9a5e-7b183c5be258@intel.com>
Date: Tue, 9 Apr 2024 12:15:50 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] cxl/core/regs: Add rcd_regs initialization at
 __rcrb_to_component()
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
 kobayashi.da-06@jp.fujitsu.com, linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com, linux-pci@vger.kernel.org, mj@ucw.cz,
 dan.j.williams@intel.com
References: <20240409073528.13214-1-kobayashi.da-06@fujitsu.com>
 <20240409073528.13214-3-kobayashi.da-06@fujitsu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240409073528.13214-3-kobayashi.da-06@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/9/24 12:35 AM, Kobayashi,Daisuke wrote:
> Add rcd_regs initialization at __rcrb_to_component() to cache the cxl1.1
> device link status information. Reduce access to the memory map area
> where the RCRB is located by caching the cxl1.1 device link status information.
> 
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> ---
>  drivers/cxl/core/regs.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 372786f80955..308eb951613e 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -514,6 +514,8 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  	u32 bar0, bar1;
>  	u16 cmd;
>  	u32 id;
> +	u16 offset;
> +	u32 cap_hdr;
>  
>  	if (which == CXL_RCRB_UPSTREAM)
>  		rcrb += SZ_4K;
> @@ -537,6 +539,22 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  	cmd = readw(addr + PCI_COMMAND);
>  	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
>  	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
> +
> +	offset = readw(addr + PCI_CAPABILITY_LIST);
> +	offset &= 0x00ff;

GENMASK(7,0) is preferred to 0x00ff. Although a properly defined mask would be nice.
Also please consider using FIELD_GET().

> +	cap_hdr = readl(addr + offset);
> +	while ((cap_hdr & 0x000000ff) != PCI_CAP_ID_EXP) {

Same comment as above


> +		offset = (cap_hdr >> 8) & 0x000000ff;

Also here

> +		if (offset == 0) // End of capability list

Please use /* */ instead of // for Linux kernel code

> +			break;
> +		cap_hdr = readl(addr + offset);
> +	}
> +	if (offset) {
> +		ri->rcd_lnkcap = readl(addr + offset + PCI_EXP_LNKCAP);
> +		ri->rcd_lnkctrl = readl(addr + offset + PCI_EXP_LNKCTL);
> +		ri->rcd_lnkstatus = readl(addr + offset + PCI_EXP_LNKSTA);
> +	}
> +
>  	iounmap(addr);
>  	release_mem_region(rcrb, SZ_4K);
>  

