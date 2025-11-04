Return-Path: <linux-pci+bounces-40290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A881FC32D82
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 20:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31FC71899442
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 19:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B811267B94;
	Tue,  4 Nov 2025 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTxj0SL/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A6270809;
	Tue,  4 Nov 2025 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762286040; cv=none; b=fURtuR1524p47wvrIe2ALCW2FNAyOQV3OfLFc77REZIN2uJXTDL7lC3hwSjCIfeZjrk9fnhHJBuA9AL/9Pg+ECMNFw2r0Jg9/1CvBFMmDh0iaF/32nGesBqp2BvrhjQTDxrjhgP6DAQxNIejB073IZDqAhdD2BqLjoMN+aHU+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762286040; c=relaxed/simple;
	bh=Na6wOFDxkSHIlRuw/ec8tWC8EkqwA7jq4ATjtLjtE18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sNqdsB/CfJ1sCF+b9ecVbrFBpIhSOFENKZfKCLvAmugG41bzFifbe5Gu2c+o1Q7WrbVzGFhUjO9HhvRX6F0K/nr1g7Bba2VJXJWkgmJljkWtEPGJcGx7j7+WQB9CVeyVu4d6pu0wWXxSZRcmY45zmm2L0jHYU78VtHITAmAliEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTxj0SL/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762286038; x=1793822038;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Na6wOFDxkSHIlRuw/ec8tWC8EkqwA7jq4ATjtLjtE18=;
  b=NTxj0SL/pi73dmylmtTmakQvbY0Le9iHzMcyxKa7qNlue0nJojqlc1qo
   FbRcmw82cL0zMLMpkRLH02u7LuaGjpE7JhAzTUihx8m/YD+3kvY8sqb/W
   FsU7KMeZG5ht2sttGMHz38wck5M30pPzSNtjB4ThHV1O1pS8v7xkWMxhn
   OWWwnsUKZBlO7vby03VdAOzqkuN37WXdSJJtK+7hVoLu+JlSStK74Xvcw
   hB74dNpp1XmYJDGIGbFMjKZ+rBPDKGT9cim+WJyO+sGjRFdkmBJgYn5dv
   vwcZFDrYM8QPkxuzwDilNX5SABru1U49oNRVJVP9XFZe+hhw6NsJJG9Ok
   A==;
X-CSE-ConnectionGUID: Lao2wvp5SVyPG07tBf1YjQ==
X-CSE-MsgGUID: TuuJh6oWRJeO8q3FcAvh+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="68252219"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="68252219"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 11:53:57 -0800
X-CSE-ConnectionGUID: mhFQtr/yQfahHP6Jcd71Cg==
X-CSE-MsgGUID: Th50s3DWQrKQXhIHAEEHKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="187194920"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.110.201]) ([10.125.110.201])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 11:53:56 -0800
Message-ID: <97762104-b660-4b72-ad7b-37b88f5c8f64@intel.com>
Date: Tue, 4 Nov 2025 12:53:55 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v13 07/25] CXL/AER: Replace device_lock() in
 cxl_rch_handle_error_iter() with guard() lock
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-8-terry.bowman@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251104170305.4163840-8-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/25 10:02 AM, Terry Bowman wrote:
> cxl_rch_handle_error_iter() includes a call to device_lock() using a goto
> for multiple return paths. Improve readability and maintainability by
> using the guard() lock variant.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> 
> ---
> 
> Changes in v12->v13:
> - New patch
> ---
>  drivers/pci/pcie/aer.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 0b5ed4722ac3..cbaed65577d9 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1187,12 +1187,11 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>  		return 0;
>  
> -	/* Protect dev->driver */
> -	device_lock(&dev->dev);
> +	guard(device)(&dev->dev);
>  
>  	err_handler = dev->driver ? dev->driver->err_handler : NULL;
>  	if (!err_handler)
> -		goto out;
> +		return 0;
>  
>  	if (info->severity == AER_CORRECTABLE) {
>  		if (err_handler->cor_error_detected)
> @@ -1203,8 +1202,6 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  		else if (info->severity == AER_FATAL)
>  			err_handler->error_detected(dev, pci_channel_io_frozen);
>  	}
> -out:
> -	device_unlock(&dev->dev);
>  	return 0;
>  }
>  


