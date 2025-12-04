Return-Path: <linux-pci+bounces-42645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DA8CA4F83
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 19:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A152730B8E7C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 18:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5C834F48F;
	Thu,  4 Dec 2025 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fc7104DP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7100534F488;
	Thu,  4 Dec 2025 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873379; cv=none; b=RmHEOH/e8HiWOTRigwOPpoGfd0b0Nj6mSgpqJRV+XUL2SIh1MLBR3mCVzaV4Xw9ULczGnNKWRQuNF9rag59eFqifLdMNUv3FWdcdjGav071NKOjjCDl4pXFNhNSyNCbwwBK1CNPIoOtST3VtUsWgYiNGtBAhQNcnZXeSIMQtkOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873379; c=relaxed/simple;
	bh=XVMPhtygNvc6V/khmfb52bstg5nyqz2r7aDePs43GEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXlbqmTRRH5jeWPYBix1XTlLhNBtW/WzHqrYbswfGUWz+7NH5y0j2XAyWWq0F9jaeob/7zA330cPneU/HPTtWY3YJvW0sZRrsutxyPnINyWNVpg7KrOifgSO5P8xNAjWkxn0aMfzduyIlAEPWwGPZ9rweCRTIXRZ+O8fUm2l6z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fc7104DP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764873378; x=1796409378;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XVMPhtygNvc6V/khmfb52bstg5nyqz2r7aDePs43GEI=;
  b=Fc7104DP/D9SYhG+t75P8wlXWZvjX05Fm7Mses9OHWuulB9d07OMyZX4
   u/vRBdvMAz6AcpBav/BcG5x+mzpvZ9hyaZPLaUr90gV8oTFedRI/gl6OV
   sRvklKgVHdG1aELQIJ+BJB1qh6slY2gvlA6hQ0fAFW9doe4cZym2PxIZU
   C3FuqCsfgtReL3ovqyOfw7ghrkrai8VQk+hFCJOjPzkGIV76eqQETysBQ
   I16KWFSwjmZEQZIm/xPHRwAAL3yUaZdgn9Kq2JVs6MP8P4qcFJG+blliW
   ak3JSZUsIGDpIrfyjk06awvmDoAxRI9/iEoP/GfTIaKd15g7SyTb/nJcR
   g==;
X-CSE-ConnectionGUID: tspmuYFMR6ayfFvxscf35A==
X-CSE-MsgGUID: AOdcz9vJRfWK/55e66pkNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="67067658"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="67067658"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 10:36:17 -0800
X-CSE-ConnectionGUID: q5A9B+wMQD+STGNUOGqYKg==
X-CSE-MsgGUID: xO4/wzLkQNKWSv48Xb1mtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="194946637"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.95]) ([10.125.108.95])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 10:36:16 -0800
Message-ID: <8018c7bf-87c7-4fb1-8398-15436ab0e5fa@intel.com>
Date: Thu, 4 Dec 2025 11:36:14 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] cxl/port: Arrange for always synchronous endpoint
 attach
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, alison.schofield@intel.com,
 terry.bowman@amd.com, alejandro.lucero-palau@amd.com,
 linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
 Alejandro Lucero <alucerop@amd.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-4-dan.j.williams@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251204022136.2573521-4-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/3/25 7:21 PM, Dan Williams wrote:
> Make it so that upon return from devm_cxl_add_endpoint() that
> cxl_mem_probe() can assume that the endpoint has had a chance to complete
> cxl_port_probe().  I.e. cxl_port module loading has completed prior to
> device registration.
> 
> Delete the MODULE_SOFTDEP() as it is not sufficient for this purpose, but a
> hard link-time dependency is reliable. Specifically MODULE_SOFTDEP() does
> not guarantee that the module loading has completed prior to the completion
> of the current module's init.
> 
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/cxl.h  |  2 ++
>  drivers/cxl/mem.c  | 43 -------------------------------------------
>  drivers/cxl/port.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ba17fa86d249..c796c3db36e0 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -780,6 +780,8 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
>  				   struct cxl_dport *parent_dport);
>  struct cxl_root *devm_cxl_add_root(struct device *host,
>  				   const struct cxl_root_ops *ops);
> +int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
> +			  struct cxl_dport *parent_dport);
>  struct cxl_root *find_cxl_root(struct cxl_port *port);
>  
>  DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 55883797ab2d..d62931526fd4 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -45,44 +45,6 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>  	return 0;
>  }
>  
> -static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
> -				 struct cxl_dport *parent_dport)
> -{
> -	struct cxl_port *parent_port = parent_dport->port;
> -	struct cxl_port *endpoint, *iter, *down;
> -	int rc;
> -
> -	/*
> -	 * Now that the path to the root is established record all the
> -	 * intervening ports in the chain.
> -	 */
> -	for (iter = parent_port, down = NULL; !is_cxl_root(iter);
> -	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
> -		struct cxl_ep *ep;
> -
> -		ep = cxl_ep_load(iter, cxlmd);
> -		ep->next = down;
> -	}
> -
> -	/* Note: endpoint port component registers are derived from @cxlds */
> -	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
> -				     parent_dport);
> -	if (IS_ERR(endpoint))
> -		return PTR_ERR(endpoint);
> -
> -	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
> -	if (rc)
> -		return rc;
> -
> -	if (!endpoint->dev.driver) {
> -		dev_err(&cxlmd->dev, "%s failed probe\n",
> -			dev_name(&endpoint->dev));
> -		return -ENXIO;
> -	}
> -
> -	return 0;
> -}
> -
>  static int cxl_debugfs_poison_inject(void *data, u64 dpa)
>  {
>  	struct cxl_memdev *cxlmd = data;
> @@ -275,8 +237,3 @@ MODULE_DESCRIPTION("CXL: Memory Expansion");
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS("CXL");
>  MODULE_ALIAS_CXL(CXL_DEVICE_MEMORY_EXPANDER);
> -/*
> - * create_endpoint() wants to validate port driver attach immediately after
> - * endpoint registration.
> - */
> -MODULE_SOFTDEP("pre: cxl_port");
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 51c8f2f84717..7937e7e53797 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -156,10 +156,50 @@ static struct cxl_driver cxl_port_driver = {
>  	.probe = cxl_port_probe,
>  	.id = CXL_DEVICE_PORT,
>  	.drv = {
> +		.probe_type = PROBE_FORCE_SYNCHRONOUS,
>  		.dev_groups = cxl_port_attribute_groups,
>  	},
>  };
>  
> +int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
> +			  struct cxl_dport *parent_dport)
> +{
> +	struct cxl_port *parent_port = parent_dport->port;
> +	struct cxl_port *endpoint, *iter, *down;
> +	int rc;
> +
> +	/*
> +	 * Now that the path to the root is established record all the
> +	 * intervening ports in the chain.
> +	 */
> +	for (iter = parent_port, down = NULL; !is_cxl_root(iter);
> +	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
> +		struct cxl_ep *ep;
> +
> +		ep = cxl_ep_load(iter, cxlmd);
> +		ep->next = down;
> +	}
> +
> +	/* Note: endpoint port component registers are derived from @cxlds */
> +	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
> +				     parent_dport);
> +	if (IS_ERR(endpoint))
> +		return PTR_ERR(endpoint);
> +
> +	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
> +	if (rc)
> +		return rc;
> +
> +	if (!endpoint->dev.driver) {
> +		dev_err(&cxlmd->dev, "%s failed probe\n",
> +			dev_name(&endpoint->dev));
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(devm_cxl_add_endpoint, "cxl_mem");
> +
>  static int __init cxl_port_init(void)
>  {
>  	return cxl_driver_register(&cxl_port_driver);


