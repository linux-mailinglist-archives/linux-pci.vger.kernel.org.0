Return-Path: <linux-pci+bounces-44853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D964D21253
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A542E3035264
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB5332C924;
	Wed, 14 Jan 2026 20:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YNRLRMWP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E236A26D4E5;
	Wed, 14 Jan 2026 20:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768421754; cv=none; b=J63JLt6RRX5iHxPRcDirr5rxKY2j0NOYRhUL6/jZDVIrTp/dsrVmXjpjGzgcgNmf6/C+lJXdePJaXAsm8Mgsla2oT4JSqS8mbRtgFjD4G4+ehTF9kPODDL+MBQbM12tc0va+0Jmqi+bv7c0gV3InZB1QVW+o+Uzy0CeiAmZw7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768421754; c=relaxed/simple;
	bh=9+Ifv43aFCnC3+E6QRncNOlQ56S1tg531wRBasBSVNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqUWoiyynUMks2GZvMslFaqb6r2LmANmU0fNlNPi4YeEiU6VSscF/3gSOFiJMe1HGYtajt5a2DRtCI3xYrgvetSjCVyqx/STdShc38HWJvAzjzvvas8ThnH8/aI78pjldnKS06IusEzwj/niHgmOt1IPR1OQUs+bL9X7XldUKDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YNRLRMWP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768421753; x=1799957753;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9+Ifv43aFCnC3+E6QRncNOlQ56S1tg531wRBasBSVNw=;
  b=YNRLRMWPc6XfaQEMld1RzW2cjV9ScUyaoE1tSI2L7UpbQMALY9flAyou
   wVEdWaAwSZy5bz8mglkO00jdOSZeuhSQW1vzG83ZID0bjb97hjPTEqnDf
   ElCsMpy8fMnC61Kxa4EzGFlb119xTcVGv4OyntLs7Fm+IF54Jwxg6h0N9
   Sl7TjiUUkO1OY8ankt0HfiJI+bfKpgxudt7s1sUWxgfK/o+Rb6RleyP66
   qvG5H11/w87dflFjQbKunu0UYXtYPjAiPy0tjq007OjI5NoqalFLTeppU
   INkmgiKjIdUAh6xucMUWlCUxsgJhNa7Q3rovti6BGeelG8yLGj7Tcyxu1
   Q==;
X-CSE-ConnectionGUID: cSIv1Y2eTLuhQr/tTBPBbw==
X-CSE-MsgGUID: IOZlQLxcTTGj3nrXAEXIZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="73362593"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="73362593"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 12:15:52 -0800
X-CSE-ConnectionGUID: ruvZlI3WR8SGtIXF1BC/ow==
X-CSE-MsgGUID: i7WgodM5SeGodnaxHHYB2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="203909994"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 12:15:51 -0800
Message-ID: <ab1899d7-24cb-4861-ab38-443431bfb2c4@intel.com>
Date: Wed, 14 Jan 2026 13:15:49 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 06/34] PCI: Replace cxl_error_is_native() with
 pcie_aer_is_native()
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-7-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114182055.46029-7-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 11:20 AM, Terry Bowman wrote:
> The AER driver includes a CXL support function cxl_error_is_native(). This
> function adds no additional value from pcie_aer_is_native().
> 
> Simplify the codebase by removing cxl_error_is_native() and replace
> occurrences of cxl_error_is_native() with pcie_aer_is_native().
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> 
> ---
> 
> Changes in v13->v14:
> - New commit (Dan)
> ---
>  drivers/pci/pcie/aer.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e0bcaa896803..c99ba2a1159c 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1166,13 +1166,6 @@ static bool is_cxl_mem_dev(struct pci_dev *dev)
>  	return true;
>  }
>  
> -static bool cxl_error_is_native(struct pci_dev *dev)
> -{
> -	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> -
> -	return (pcie_ports_native || host->native_aer);
> -}
> -
>  static bool is_internal_error(struct aer_err_info *info)
>  {
>  	if (info->severity == AER_CORRECTABLE)
> @@ -1186,7 +1179,7 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  	struct aer_err_info *info = (struct aer_err_info *)data;
>  	const struct pci_error_handlers *err_handler;
>  
> -	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
> +	if (!is_cxl_mem_dev(dev) || !pcie_aer_is_native(dev))
>  		return 0;
>  
>  	/* Protect dev->driver */
> @@ -1227,7 +1220,7 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>  	bool *handles_cxl = data;
>  
>  	if (!*handles_cxl)
> -		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
> +		*handles_cxl = is_cxl_mem_dev(dev) && pcie_aer_is_native(dev);
>  
>  	/* Non-zero terminates iteration */
>  	return *handles_cxl;


