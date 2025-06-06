Return-Path: <linux-pci+bounces-29108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326ECAD0778
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 19:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7B8177577
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 17:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1AB28A1F9;
	Fri,  6 Jun 2025 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzeHH5ii"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89D912CDBE;
	Fri,  6 Jun 2025 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749230881; cv=none; b=H19jW+WMEET46yVGaA4SV3eKPE3VyGhCccFY3eaa07u6psiguvrZMhaCsN7lIvsbSeNCmXk66ReeBPbekCJrKL10XE35nc0gh45du3Wj301CHpIc2yGufO8WwBYUcE3yccJquNhVH73xvgHJ/su3gV/m9Koti0zcq9qtcur1D9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749230881; c=relaxed/simple;
	bh=J8G7cVDmZqNS5VPQ5fdctx1wA6Zh/OwxmAsrLM2vCr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eDKvWMTatOFPXpnQvDCjLiwUs7/KuOC5pLp8SAsZlPcAsOPH4UokoKl4EAmBwwpTEloJ3ktqJOkKx65oM2iKF08jtwHmVVtqc609a84x+CrVS/6FVEgnejYm0L6UoyyuPYmOn6qtR480UwsluuX2MRIBJb6lEFiIQZ15ja312jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzeHH5ii; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749230880; x=1780766880;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=J8G7cVDmZqNS5VPQ5fdctx1wA6Zh/OwxmAsrLM2vCr4=;
  b=lzeHH5iiUgYl3K54upK5MGPu7q7sckgiHjA7zSUHCbpKWOSApBdtUr8e
   M8cinklkDbdiBesuYVZ+cvy+bKBAtIx3Ty4P73/VVum4VWdQjuWehKXxv
   3mc1/qjkHZH5Tg773JClAlDF/kGbAFX0XPCiVyMCodcvHNoZa1T3KXw/y
   wBJnYRFZC7bItcql1I6TzRzhlQKh3mYew4yQtlLoGghFMvZAbYh8rhn5E
   ucGENhBWAvC/6kglmMcakorhQFBa5sE4IylxsD0TrVGauCjM+sF9ijnBB
   xeQJZxhSK/UERU5L5GHqKKzKVWe/GN9Mpr6hNQRTasDqPGyyke6THaVvP
   w==;
X-CSE-ConnectionGUID: ziwZrM1vS1+syWBwtRlgAA==
X-CSE-MsgGUID: bY2MzqtrQVqxN0qHII8/Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="68943910"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="68943910"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 10:27:59 -0700
X-CSE-ConnectionGUID: 2OGIbcAjTmePLFk5nu4cBA==
X-CSE-MsgGUID: XAVzpngtSnCy4oqWEKqJkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="149718475"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.111.33]) ([10.125.111.33])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 10:27:55 -0700
Message-ID: <48b438d2-c709-4355-bd9b-ebf24a96faac@intel.com>
Date: Fri, 6 Jun 2025 10:27:54 -0700
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
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, bp@alien8.de, ming.li@zohomail.com,
 shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-10-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250603172239.159260-10-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/25 10:22 AM, Terry Bowman wrote:
> The CXL RAS handlers do not currently log if the RAS registers are
> unmapped. This is needed in order to help debug CXL error handling. Update
> the CXL driver to log a warning message if the RAS register block is
> unmapped during RAS error handling.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/pci.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 78735da7e63d..186a5a20b951 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -670,8 +670,10 @@ static void __cxl_handle_cor_ras(struct device *dev,
>  	void __iomem *addr;
>  	u32 status;
>  
> -	if (!ras_base)
> +	if (!ras_base) {
> +		dev_warn_once(dev, "CXL RAS register block is not mapped");
>  		return;
> +	}
>  
>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> @@ -714,8 +716,10 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  	u32 status;
>  	u32 fe;
>  
> -	if (!ras_base)
> +	if (!ras_base) {
> +		dev_warn_once(dev, "CXL RAS register block is not mapped");
>  		return false;
> +	}
>  
>  	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);


