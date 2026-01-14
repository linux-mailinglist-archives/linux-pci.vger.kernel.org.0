Return-Path: <linux-pci+bounces-44879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 227D5D21B35
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 00:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14AD83034A3E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 23:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BEE345CA2;
	Wed, 14 Jan 2026 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbgWfDIt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0D230C343;
	Wed, 14 Jan 2026 23:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431891; cv=none; b=A1YKop/bSG+A18bybOoKu6+jBWxGB5IshP7G/UpDCUWUfZodFdgbEdzml7Ati0Uyg/XkdaDs4UbNa+9dWYayhyf1QNBi684JeSok03eG37h8nfRUM4jpJ5/GSGh6fxhdClhTMjM5veLDXySt1MnxevyWPqmblyNDX+mrEXjT03I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431891; c=relaxed/simple;
	bh=J1dS/7JjVzpNnoW586MdDnZMVox8BiSc3ZfoP59XohM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dsMccTdVodwTRICzm5JbJCsGp6p/8POAWfJ+04w0NzIDt1Oha4Sr0T1sf29gZzJ9xTV1hcwjb78mOdJuem+rLNYDOTInXUqDyKUTakWK4jYAGkuPN0i286ebbR1kkagRPLBhJw/K6YJt0Bu/ZnFitDwCCgp2U+tscB/FJDTUzRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbgWfDIt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768431888; x=1799967888;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J1dS/7JjVzpNnoW586MdDnZMVox8BiSc3ZfoP59XohM=;
  b=fbgWfDItdOnkGhzYERNLq+QEqvf37kSXI0XdvaUX1mSNsMbgQS6EObjE
   2arLazlSsPkoCsX2j+4dRN6dmHv/atrpF9lynPRRYlLzfugnjXIMMTd44
   HR9clXuvIMwDdVB21b9bH4cFdkJoWtuWG9XbcFPM03ryZ5XN6X20UvYW6
   N1jdScR8bbLlqilf7wj5G4CvndQotz/XJmxzGCbRmDzQBeG/aAOgcM06x
   8gCOzgZzsTg8fRe6eCFgX/jL6TR7FBcnY03ITHItEXpCoWrZgp5kcDCmL
   a3eN7jMfnjdCCvKJcSVi70cVbCu0ivx+qlfcCWWVPJ9I9IBT9DlfgNJ+d
   Q==;
X-CSE-ConnectionGUID: aJIL/Ea2SKaP7fGSy+0xgQ==
X-CSE-MsgGUID: AJ7DohQWRMaypIlZpHqZCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="72323642"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="72323642"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 15:04:44 -0800
X-CSE-ConnectionGUID: Ah3e3iuKTCyEmMVHD2oqlA==
X-CSE-MsgGUID: Tr+2D2uaS/2MC4luNTh4Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="203940494"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 15:04:42 -0800
Message-ID: <4ba94bfe-4b80-49b8-92fe-6ac276372bc9@intel.com>
Date: Wed, 14 Jan 2026 16:04:42 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 29/34] cxl/port: Unify endpoint and switch port lookup
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
 <20260114182055.46029-30-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114182055.46029-30-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 11:20 AM, Terry Bowman wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> In support of generic CXL protocol error handling across various 'struct
> cxl_port' types, update find_cxl_port_by_uport() to retrieve endpoint CXL
> port companions from endpoint PCIe device instances.
> 
> The end result is that upstream switch ports and endpoint ports can share
> error handling and eventually delete the misplaced cxl_error_handlers from
> the cxl_pci class driver.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>

missing sign off

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> 
> Changes in v13->v14:
> - New patch
> ---
>  drivers/cxl/core/port.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 3f730511f11d..a535e57360e0 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1561,10 +1561,20 @@ static int match_port_by_uport(struct device *dev, const void *data)
>  		return 0;
>  
>  	port = to_cxl_port(dev);
> +	/* Endpoint ports are hosted by memdevs */
> +	if (is_cxl_memdev(port->uport_dev))
> +		return uport_dev == port->uport_dev->parent;
>  	return uport_dev == port->uport_dev;
>  }
>  
> -/*
> +/**
> + * find_cxl_port_by_uport - Find a CXL port device companion
> + * @uport_dev: Device that acts as a switch or endpoint in the CXL hierarchy
> + *
> + * In the case of endpoint ports recall that port->uport_dev points to a 'struct
> + * cxl_memdev' device. So, the @uport_dev argument is the parent device of the
> + * 'struct cxl_memdev' in that case.
> + *
>   * Function takes a device reference on the port device. Caller should do a
>   * put_device() when done.
>   */


