Return-Path: <linux-pci+bounces-32688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B28B0CD39
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 00:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1466C0222
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 22:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5530723AB95;
	Mon, 21 Jul 2025 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTcczlLr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A211818C00;
	Mon, 21 Jul 2025 22:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753136285; cv=none; b=RA6yeR0za/gE3pYheFpZCbX+ZLHINZDB3PyR9v+k8PXuzszixSEe9CvEFbkc+R89IUCeRCV0ZuHx2gICcceFJf/vJ6ahYvhsuWVfwyQ7UcOj6taqNOFWH7hpsXdUJXLUxBmM2+oY4eviPkABKlkZF79MQu0DBUTBDgLe/kcUaDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753136285; c=relaxed/simple;
	bh=7B0wp5kjORmWUL+Gq3XbN1/gIt8JSXysB9+RlfhzCs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDss4QhxtNnbc2CMthwPc/+8BBEM4+k5DJ37d3XuFGKgSYeZcG6ViBllJfh3EN2lkpEfQTP1Q9FRGexdKpf0SfthqIjmTv4ihrLqpbGM1PEBvyh8Ra5UlI7Vtd5CYkisPrNmpY+QuZAsn7ro0tyoL4asCnMtsv4dwjrgZX+H5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTcczlLr; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753136284; x=1784672284;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7B0wp5kjORmWUL+Gq3XbN1/gIt8JSXysB9+RlfhzCs8=;
  b=bTcczlLr8y1RBjmG0onblz0NXUdMa7LZeCc1X74RJUuCBAx6PwGMi7v/
   KGbLzfr2ZYgxlKt6L2dcHQcBf8rm2chCbTrCovVGLjBoVSsCIOQ3i695+
   SBaMcooPVd7ZAP/EkiTP7jrB8A3M8LHu3O6nESRTO4mt4tQofcpM8OdB6
   DQsBWDI7+vE3g9hl/dMIkmJmXsUgbxwZZnJJc/PqK4J361JGxNT0phXUh
   FPAoVfW6e0bocFSua8benTHTNIxLMrYsWP3Z0YKzAYgOx3xHjOuP8HHma
   VCOiqwGmo6KCiZ+SBfO/gaplmPtK+RboKyQg/SK754cxj6cBuzBxsD3N8
   w==;
X-CSE-ConnectionGUID: 9ZHQUKfXR4u9/bE4Jo2HqA==
X-CSE-MsgGUID: efxavubqTcCz3Mr10X/pww==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55518682"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="55518682"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 15:18:03 -0700
X-CSE-ConnectionGUID: eIZY7DuMTVa6rz4U2l/xOA==
X-CSE-MsgGUID: ihEnIMoPRuqeytaheIKoiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="164447880"
Received: from vverma7-mobl3.amr.corp.intel.com (HELO [10.247.118.153]) ([10.247.118.153])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 15:17:54 -0700
Message-ID: <2dca3288-0824-4c44-a1f3-30b265ccb09f@intel.com>
Date: Mon, 21 Jul 2025 15:17:48 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 13/17] cxl/pci: Update cxl_handle_cor_ras() to return
 early if no RAS errors
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-14-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250626224252.1415009-14-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/26/25 3:42 PM, Terry Bowman wrote:
> Update cxl_handle_cor_ras() to exit early in the case there is no RAS
> errors detected after applying the status mask. This change will make
> the correctable handler's implementation consistent with the uncorrectable
> handler, cxl_handle_ras().
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pci.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 156ce094a8b9..887b54cf3395 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -677,10 +677,11 @@ static void cxl_handle_cor_ras(struct device *dev, u64 serial,
>  
>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(dev, serial, status);
> -	}
> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
> +		return;
> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +
> +	trace_cxl_aer_correctable_error(dev, serial, status);
>  }
>  
>  /* CXL spec rev3.0 8.2.4.16.1 */


