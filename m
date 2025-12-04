Return-Path: <linux-pci+bounces-42655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C05CA5325
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 21:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9442E300D79D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 20:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED08306B2E;
	Thu,  4 Dec 2025 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cofUN0+9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B54301473;
	Thu,  4 Dec 2025 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878539; cv=none; b=T3g9RQwyhI7lsJQONSTvWT9f0/ynY3pu/cdN+GP0zOHeLhZEVtMQK5fFA8BJQIgw0FnZAPDvs21m7olP0TgjAFFSULs9Sj/3tWJBqiZWiujxcumkPXwhw5GCbJ5c3AzTKCDiIwf40ZXepdYarhUhhIfbDi7CZgh5kX8XYqEqwZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878539; c=relaxed/simple;
	bh=EenVVUAxOSgw7G6/S030AJLLLlIqaJaDOzdzGakEjWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUHRdgZUGczmzNDp+Vij1D1bd7HNyUGOydholGqn/xNIr+f1h+rpcsB1PVY41qu1dmo8z6KkOL8RIrkysLCeBYy5zNGRh08COOHGYdujzzIb2zIBo5z2e1h60+ClSdC+34Utc4TTUTa8+Fe0xCc+4QoM1eWyR0uSKj2e99cRxdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cofUN0+9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764878537; x=1796414537;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EenVVUAxOSgw7G6/S030AJLLLlIqaJaDOzdzGakEjWE=;
  b=cofUN0+9nojg8NgNbYG1Th3zh3MfnZzzXbWqoW7HTFWYhwusz7T535Nf
   pCyyy3a6lyEsCnhwBfPxhp236HGsfCc5LuCl6GzD4GRVj7ed4O1eExu2Y
   lBeQCNzRH0orcC2ICceVAfv4ONHphy/rlmuVICWT1GDxKaqgdjGINJ+JT
   zLNrAYQjSVkAVNpS4qSBLKdNKrqvOatvLTav4L5drEX/TUcdz5AnneYeL
   4D//4xjMmUgHUrs9CVwIrRKz9zaxM33q9Xl0sK/N0nE0DOlS/u3etRxWy
   oaN1jh9eOKOnv4ZZ6EDsBs4Kn9VPGzd2nn7nTaykGVO+op8qVjhknzs5/
   g==;
X-CSE-ConnectionGUID: D5PQ1jInRE+r7IbHJpeFpA==
X-CSE-MsgGUID: DCSbRofMQbe1OevW4pJe6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="84516367"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="84516367"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 12:02:17 -0800
X-CSE-ConnectionGUID: qSnNknKpSUOW1CnMyt3f4w==
X-CSE-MsgGUID: cRZ3BYMESvKN9V4VuJRppw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="226043898"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.95]) ([10.125.108.95])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 12:02:15 -0800
Message-ID: <f0fd0c4f-2995-45c4-88f1-bad9585a8bc3@intel.com>
Date: Thu, 4 Dec 2025 13:02:14 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] cxl/mem: Drop @host argument to devm_cxl_add_memdev()
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, alison.schofield@intel.com,
 terry.bowman@amd.com, alejandro.lucero-palau@amd.com,
 linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
 Alejandro Lucero <alucerop@amd.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-6-dan.j.williams@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251204022136.2573521-6-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/3/25 7:21 PM, Dan Williams wrote:
> In all cases the device that created the 'struct cxl_dev_state' instance is
> also the device to host the devm cleanup of devm_cxl_add_memdev(). This
> simplifies the function prototype, and limits a degree of freedom of the
> API.
> 
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/cxlmem.h         | 6 ++----
>  drivers/cxl/core/memdev.c    | 5 ++---
>  drivers/cxl/mem.c            | 9 +++++----
>  drivers/cxl/pci.c            | 2 +-
>  tools/testing/cxl/test/mem.c | 2 +-
>  5 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 012e68acad34..9db31c7993c4 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -95,10 +95,8 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>  	return is_cxl_memdev(port->uport_dev);
>  }
>  
> -struct cxl_memdev *__devm_cxl_add_memdev(struct device *host,
> -					 struct cxl_dev_state *cxlds);
> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> -				       struct cxl_dev_state *cxlds);
> +struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
> +struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
>  int devm_cxl_sanitize_setup_notifier(struct device *host,
>  				     struct cxl_memdev *cxlmd);
>  struct cxl_memdev_state;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index d0efc9ceda2a..7d85ba25835a 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1081,8 +1081,7 @@ DEFINE_FREE(put_cxlmd, struct cxl_memdev *,
>   * Core helper for devm_cxl_add_memdev() that wants to both create a device and
>   * assert to the caller that upon return cxl_mem::probe() has been invoked.
>   */
> -struct cxl_memdev *__devm_cxl_add_memdev(struct device *host,
> -					 struct cxl_dev_state *cxlds)
> +struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  {
>  	struct device *dev;
>  	int rc;
> @@ -1101,7 +1100,7 @@ struct cxl_memdev *__devm_cxl_add_memdev(struct device *host,
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> -	rc = devm_add_action_or_reset(host, cxl_memdev_unregister,
> +	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister,
>  				      no_free_ptr(cxlmd));
>  	if (rc)
>  		return ERR_PTR(rc);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index d62931526fd4..677996c65272 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -165,17 +165,18 @@ static int cxl_mem_probe(struct device *dev)
>  
>  /**
>   * devm_cxl_add_memdev - Add a CXL memory device
> - * @host: devres alloc/release context and parent for the memdev
>   * @cxlds: CXL device state to associate with the memdev
>   *
>   * Upon return the device will have had a chance to attach to the
>   * cxl_mem driver, but may fail if the CXL topology is not ready
>   * (hardware CXL link down, or software platform CXL root not attached)
> + *
> + * The parent of the resulting device and the devm context for allocations is
> + * @cxlds->dev.
>   */
> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> -				       struct cxl_dev_state *cxlds)
> +struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  {
> -	return __devm_cxl_add_memdev(host, cxlds);
> +	return __devm_cxl_add_memdev(cxlds);
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
>  
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0be4e508affe..1c6fc5334806 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1006,7 +1006,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_dbg(&pdev->dev, "No CXL Features discovered\n");
>  
> -	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
> +	cxlmd = devm_cxl_add_memdev(cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 176dcde570cd..8a22b7601627 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1767,7 +1767,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  
>  	cxl_mock_add_event_logs(&mdata->mes);
>  
> -	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
> +	cxlmd = devm_cxl_add_memdev(cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  


