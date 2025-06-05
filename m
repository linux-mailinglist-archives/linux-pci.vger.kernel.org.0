Return-Path: <linux-pci+bounces-29047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBD4ACF490
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 18:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05033AAA93
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF5326AD0;
	Thu,  5 Jun 2025 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XqBDlFh1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213A1F03D6;
	Thu,  5 Jun 2025 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749141777; cv=none; b=gGeeIjf/3Sw1oVXMJpITL5/cZmM+fsFHAVCjiZUeYPtTxTr/Vsbi0j2/LmcFTaokd6kdEfFbopQ7RSXPgGQGoVvh4cYdc65zIO5Ewv2YYccnI1QnLmWEp67is1fVwXqCNMk5C9FQ+Q6W6n59YXnuXyVeh8yQMMe7JPn9oMXUCA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749141777; c=relaxed/simple;
	bh=WjTp4XoB7XO70hqBUHfR0FwEfy2zmiNSDaaI0gw9QrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KHJYKcEdsM7XokQoAZT9uXuUQAsYMnyalRBaY4O0CiO6L5kWUM6FSg4aGiywYzNMpFHdMOYLszTyYOSJkdRdinqhFKutWeX5ifWW8M0C8AdZalLJoYnDHK5Gb+f2XBCO4y2D6Vl2gMnaA2yWy4fNLpw28RWM3T3bwzATv5pDAs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XqBDlFh1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749141776; x=1780677776;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=WjTp4XoB7XO70hqBUHfR0FwEfy2zmiNSDaaI0gw9QrU=;
  b=XqBDlFh1iAeRl4ZEQU9KeSUzEX+csZje9uoAG6MKd20iSJQtTP1Woxul
   xg2/9aj6IxH4XZf4sm7wYD6VKE14V8QV8bYuIfvWAq867i3GEOnGuzOjG
   tN2Lx/JkCP05DXZuz+YW8R0UBvI52anlXyIwNU+XWPFLUMvT+bc8QfNFX
   OFup2sk9jpz0GjrbnsxbY25gQnlhwHJ8Ij4C+8mNOiAPrswj7Kp550o0m
   DTlYJ+5oe+VEJzyN/OmVnUDsPS07la3gr41WITiqFcLhoZW0D3A7L+p9U
   CClLHX38xs0EbN2JdNa8eJ3dKQyIfLx996wAJQIGcp4xC9xbsL+jpi17u
   w==;
X-CSE-ConnectionGUID: 1ei5ChT6RbmaYAjnw82XMA==
X-CSE-MsgGUID: 3tR2qHw6ReKYvkuJGh9TZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="68710704"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="68710704"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 09:42:38 -0700
X-CSE-ConnectionGUID: tI7+wvQHQhyMdnbCyPZpoA==
X-CSE-MsgGUID: IG9nIYKlQI2KqYVz3SH3KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="146151085"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 09:42:37 -0700
Received: from [10.124.222.23] (unknown [10.124.222.23])
	by linux.intel.com (Postfix) with ESMTP id 37F6020B5736;
	Thu,  5 Jun 2025 09:42:34 -0700 (PDT)
Message-ID: <4419e62d-5e36-4776-ab3e-2b1b3702919b@linux.intel.com>
Date: Thu, 5 Jun 2025 09:42:33 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/16] cxl/pci: Log message if RAS registers are
 unmapped
To: Terry Bowman <terry.bowman@amd.com>, PradeepVineshReddy.Kodamati@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-10-terry.bowman@amd.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250603172239.159260-10-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/3/25 10:22 AM, Terry Bowman wrote:
> The CXL RAS handlers do not currently log if the RAS registers are
> unmapped. This is needed in order to help debug CXL error handling. Update
> the CXL driver to log a warning message if the RAS register block is
> unmapped during RAS error handling.
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/cxl/core/pci.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 78735da7e63d..186a5a20b951 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -670,8 +670,10 @@ static void __cxl_handle_cor_ras(struct device *dev,
>   	void __iomem *addr;
>   	u32 status;
>   
> -	if (!ras_base)
> +	if (!ras_base) {
> +		dev_warn_once(dev, "CXL RAS register block is not mapped");
>   		return;
> +	}
>   
>   	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>   	status = readl(addr);
> @@ -714,8 +716,10 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>   	u32 status;
>   	u32 fe;
>   
> -	if (!ras_base)
> +	if (!ras_base) {
> +		dev_warn_once(dev, "CXL RAS register block is not mapped");
>   		return false;
> +	}
>   
>   	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>   	status = readl(addr);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


