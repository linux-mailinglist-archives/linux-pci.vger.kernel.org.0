Return-Path: <linux-pci+bounces-42636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E452CA4A0B
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 17:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 716653022348
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46B5346FDF;
	Thu,  4 Dec 2025 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/QMXN3x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AF5346FC3;
	Thu,  4 Dec 2025 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764866897; cv=none; b=RMTl/MpO2ezNc/rvXQyzXmSN2+bvwcRjisCic/Bog9bubfx/+gpY0JQxuN+Cxvd8n6Vtp+5Mh5NPAiaWnD214/i2qZugqx+lPKq3IgzOFg9Z0/tzUe7gifL6+XqSYwgcrSQl2WpRqFNXTUvrKnL7rwY/IhyPuNcDBnSZas9U2gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764866897; c=relaxed/simple;
	bh=Ss3M8z+aKjSM9Ih0OM3WyHut07k+69cuXb727C3E748=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djXATwWIQih9g5mk+2TVy7Z9V7Z4k4Wf3qe5XCV9zhOQW6dhjuWlmkQ7YekhEE3mfj8F8EZoqdm+JHcN8Y9m1f7rCZ+NOGvYer0ySE8QNWYlSaTity3vudqq3yeGMcBFQ9SXPct7eim4ioOmg1J7TEnZY5HrQ4KITDuIoUStlWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/QMXN3x; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764866896; x=1796402896;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ss3M8z+aKjSM9Ih0OM3WyHut07k+69cuXb727C3E748=;
  b=E/QMXN3xQzzu9AbOAPXm0oTwPIBdmg/qLvB5t+xRaoqL9QOZGMd3hxUb
   +6goDW9kWUOZxdRn+Et3qveAAZdPg4XijWMOlKOuSwMXd8jfaaBe0zQG6
   oopYHroCBaqkDNtO+3Z+IBm39RjCFyGNNMt0UIdRvif0BeXeXcAl7OI6R
   TBr3c4oeJgPfHH+7N1mgquyeizFXzNKG/AIRO9KUwQJh38vmiMc/ozQJu
   3ZmBVFzc5jAF45Jc/85hgE4KO2sYM2PL6BlsJ6xjah0f+SWrevrlo3GAy
   SnIuByW7/wEdkt7Sb416cNjwMnIDf1rGEt54S/jaVAk+2ISdVuO8gyuRn
   Q==;
X-CSE-ConnectionGUID: TWQuOIxYRw2pHjuLMSnG4Q==
X-CSE-MsgGUID: B+6osZ3NQ+WnULQxjPZPtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="89543224"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="89543224"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 08:48:15 -0800
X-CSE-ConnectionGUID: l3XiH4VZSTO8zV9XlMTQ5Q==
X-CSE-MsgGUID: AFEFfjxRT8y4v2VNHGS72g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="225694942"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.95]) ([10.125.108.95])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 08:48:15 -0800
Message-ID: <2010f8dc-7cc6-4a42-a181-37e65fffd22f@intel.com>
Date: Thu, 4 Dec 2025 09:48:13 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] cxl/mem: Fix devm_cxl_memdev_edac_release() confusion
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, alison.schofield@intel.com,
 terry.bowman@amd.com, alejandro.lucero-palau@amd.com,
 linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
 Shiju Jose <shiju.jose@huawei.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-2-dan.j.williams@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251204022136.2573521-2-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/3/25 7:21 PM, Dan Williams wrote:
> A device release method is only for undoing allocations on the path to
> preparing the device for device_add(). In contrast, devm allocations are
> post device_add(), are acquired during / after ->probe() and are released
> synchronous with ->remove().
> 
> So, a "devm" helper in a "release" method is a clear anti-pattern.
> 
> Move this devm release action where it belongs, an action created at edac
> object creation time. Otherwise, this leaks resources until
> cxl_memdev_release() time which may be long after these xarray and error
> record caches have gone idle.
> 
> Note, this also fixes up the type of @cxlmd->err_rec_array which needlessly
> dropped type-safety.
> 
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Shiju Jose <shiju.jose@huawei.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

This can go into fixes right? Does not look like a dependency for the rest of the series.

> ---
>  drivers/cxl/cxlmem.h      |  5 +--
>  drivers/cxl/core/edac.c   | 64 ++++++++++++++++++++++-----------------
>  drivers/cxl/core/memdev.c |  1 -
>  3 files changed, 38 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 434031a0c1f7..c12ab4fc9512 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -63,7 +63,7 @@ struct cxl_memdev {
>  	int depth;
>  	u8 scrub_cycle;
>  	int scrub_region_id;
> -	void *err_rec_array;
> +	struct cxl_mem_err_rec *err_rec_array;
>  };
>  
>  static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
> @@ -877,7 +877,6 @@ int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd);
>  int devm_cxl_region_edac_register(struct cxl_region *cxlr);
>  int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt);
>  int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt);
> -void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd);
>  #else
>  static inline int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
>  { return 0; }
> @@ -889,8 +888,6 @@ static inline int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd,
>  static inline int cxl_store_rec_dram(struct cxl_memdev *cxlmd,
>  				     union cxl_event *evt)
>  { return 0; }
> -static inline void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd)
> -{ return; }
>  #endif
>  
>  #ifdef CONFIG_CXL_SUSPEND
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 79994ca9bc9f..81160260e26b 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -1988,6 +1988,40 @@ static int cxl_memdev_soft_ppr_init(struct cxl_memdev *cxlmd,
>  	return 0;
>  }
>  
> +static void err_rec_free(void *_cxlmd)
> +{
> +	struct cxl_memdev *cxlmd = _cxlmd;
> +	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
> +	struct cxl_event_gen_media *rec_gen_media;
> +	struct cxl_event_dram *rec_dram;
> +	unsigned long index;
> +
> +	cxlmd->err_rec_array = NULL;
> +	xa_for_each(&array_rec->rec_dram, index, rec_dram)
> +		kfree(rec_dram);
> +	xa_destroy(&array_rec->rec_dram);
> +
> +	xa_for_each(&array_rec->rec_gen_media, index, rec_gen_media)
> +		kfree(rec_gen_media);
> +	xa_destroy(&array_rec->rec_gen_media);
> +	kfree(array_rec);
> +}
> +
> +static int devm_cxl_memdev_setup_err_rec(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_mem_err_rec *array_rec =
> +		kzalloc(sizeof(*array_rec), GFP_KERNEL);
> +
> +	if (!array_rec)
> +		return -ENOMEM;
> +
> +	xa_init(&array_rec->rec_gen_media);
> +	xa_init(&array_rec->rec_dram);
> +	cxlmd->err_rec_array = array_rec;
> +
> +	return devm_add_action_or_reset(&cxlmd->dev, err_rec_free, cxlmd);
> +}
> +
>  int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
>  {
>  	struct edac_dev_feature ras_features[CXL_NR_EDAC_DEV_FEATURES];
> @@ -2038,15 +2072,9 @@ int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
>  		}
>  
>  		if (repair_inst) {
> -			struct cxl_mem_err_rec *array_rec =
> -				devm_kzalloc(&cxlmd->dev, sizeof(*array_rec),
> -					     GFP_KERNEL);
> -			if (!array_rec)
> -				return -ENOMEM;
> -
> -			xa_init(&array_rec->rec_gen_media);
> -			xa_init(&array_rec->rec_dram);
> -			cxlmd->err_rec_array = array_rec;
> +			rc = devm_cxl_memdev_setup_err_rec(cxlmd);
> +			if (rc)
> +				return rc;
>  		}
>  	}
>  
> @@ -2088,22 +2116,4 @@ int devm_cxl_region_edac_register(struct cxl_region *cxlr)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_region_edac_register, "CXL");
>  
> -void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd)
> -{
> -	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
> -	struct cxl_event_gen_media *rec_gen_media;
> -	struct cxl_event_dram *rec_dram;
> -	unsigned long index;
> -
> -	if (!IS_ENABLED(CONFIG_CXL_EDAC_MEM_REPAIR) || !array_rec)
> -		return;
> -
> -	xa_for_each(&array_rec->rec_dram, index, rec_dram)
> -		kfree(rec_dram);
> -	xa_destroy(&array_rec->rec_dram);
>  
> -	xa_for_each(&array_rec->rec_gen_media, index, rec_gen_media)
> -		kfree(rec_gen_media);
> -	xa_destroy(&array_rec->rec_gen_media);
> -}
> -EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_edac_release, "CXL");
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index e370d733e440..4dff7f44d908 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -27,7 +27,6 @@ static void cxl_memdev_release(struct device *dev)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  
>  	ida_free(&cxl_memdev_ida, cxlmd->id);
> -	devm_cxl_memdev_edac_release(cxlmd);
>  	kfree(cxlmd);
>  }
>  


