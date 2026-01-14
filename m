Return-Path: <linux-pci+bounces-44865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD48D21462
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 22:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD220301EA0F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F7333B6E4;
	Wed, 14 Jan 2026 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7GnvFGP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EF030FC36;
	Wed, 14 Jan 2026 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768424908; cv=none; b=TaVDA8k+sFdBXIBT96RmQeqJBn9RWokp/VNNECNQfBF4kt0WgQeEg5/YGMfvAJCPXVnWAiL8MaTFVoJuvm5IHlFs7x3rXCSKR2/o5jdvb2Yk2LuUakOGsWwMC5Y78927UVe+prO/m3iBvt+127p5WUNnruF67vQsXZ9uTfyzruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768424908; c=relaxed/simple;
	bh=4+9n7aPYqpPaJ/s1uD7OCmqA5xZpZDwHLLdKXyWwscw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kw8bggExXp79D6MCKcIDmhVtKlL8OPeBxXnFvkjpJHFOEdEo+myxUWII17JoDpLoOeEWd7RnWyCExMpdLxPk8N/r5jcX7uN7Iivv/rya5a7rczEPh2jD1lTiy+cS9s4z19+yMrwTH6/OUIcNhYWReXC91PgovJFbe5/TQyrYIzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7GnvFGP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768424907; x=1799960907;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4+9n7aPYqpPaJ/s1uD7OCmqA5xZpZDwHLLdKXyWwscw=;
  b=a7GnvFGP9oTW+/QtDXdiXhj/nO6Ui8zwculgDLXI86lg+dFjj6TH30pg
   d86YrkyXA8YNb02rf2BwVliDosp+0HrhashhEJN9f/x3SdL2dzBUBYOJj
   ki/xdgVLPZyvUTaYKem/0TqtambSxEj5cRn3MXYqrHG/j+JNdhX7qGPRd
   /QxCOcVDrGWVTbiLJMvSDqvhbkTll62nwUJkHsYZd7kb+pp8RzSY9xW9V
   hbbBxIRgSAgq2RFDm7pGmNL/z8+t4uKjYz8VUAcEcoMsAJlPEC0fdMBy0
   arW2RpJSpJLJom4Ck9FUtYr3loVAB+mn5rr7X5S8S27135NJd3OnRmINU
   Q==;
X-CSE-ConnectionGUID: wjrruVDAScejs599QwmCOg==
X-CSE-MsgGUID: qwQU1bq2QgKBo0zCZfjyOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69817469"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="69817469"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:08:26 -0800
X-CSE-ConnectionGUID: y3bsYlu2S96l9f/vTJer2Q==
X-CSE-MsgGUID: qTAKWYcBRZ6wLiFInSzjoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="205200103"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:08:24 -0800
Message-ID: <7a02a650-cbd6-46a8-a6b1-b0d816dd6376@intel.com>
Date: Wed, 14 Jan 2026 14:08:23 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 16/34] cxl/mem: Clarify @host for
 devm_cxl_add_nvdimm()
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
 <20260114182055.46029-17-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114182055.46029-17-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 11:20 AM, Terry Bowman wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> The convention for devm_ helpers in the CXL driver is that the first
> argument is the @host for the operation (locked driver::probe() context).
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

A nit below

> 
> ---
> 
> Changes in v13 -> v14:
> - New patch
> ---
>  drivers/cxl/core/pmem.c | 13 +++++++------
>  drivers/cxl/cxl.h       |  3 ++-
>  drivers/cxl/mem.c       |  2 +-
>  3 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index 8853415c106a..e7b1e6fa0ea0 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -237,12 +237,13 @@ static void cxlmd_release_nvdimm(void *_cxlmd)
>  
>  /**
>   * devm_cxl_add_nvdimm() - add a bridge between a cxl_memdev and an nvdimm
> - * @parent_port: parent port for the (to be added) @cxlmd endpoint port
> - * @cxlmd: cxl_memdev instance that will perform LIBNVDIMM operations
> + * @host: host device for devm operations
> + * @port: any port in the CXL topology to find the nvdimm-bridge device
> + * @cxlmd: parent of the to be created cxl_nvdimm device
>   *
>   * Return: 0 on success negative error code on failure.
>   */
> -int devm_cxl_add_nvdimm(struct cxl_port *parent_port,
> +int devm_cxl_add_nvdimm(struct device *host, struct cxl_port *port,

s/port/parent_port/ to maintain clarity of the port

DJ

>  			struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_nvdimm_bridge *cxl_nvb;
> @@ -250,7 +251,7 @@ int devm_cxl_add_nvdimm(struct cxl_port *parent_port,
>  	struct device *dev;
>  	int rc;
>  
> -	cxl_nvb = cxl_find_nvdimm_bridge(parent_port);
> +	cxl_nvb = cxl_find_nvdimm_bridge(port);
>  	if (!cxl_nvb)
>  		return -ENODEV;
>  
> @@ -270,10 +271,10 @@ int devm_cxl_add_nvdimm(struct cxl_port *parent_port,
>  	if (rc)
>  		goto err;
>  
> -	dev_dbg(&cxlmd->dev, "register %s\n", dev_name(dev));
> +	dev_dbg(host, "register %s\n", dev_name(dev));
>  
>  	/* @cxlmd carries a reference on @cxl_nvb until cxlmd_release_nvdimm */
> -	return devm_add_action_or_reset(&cxlmd->dev, cxlmd_release_nvdimm, cxlmd);
> +	return devm_add_action_or_reset(host, cxlmd_release_nvdimm, cxlmd);
>  
>  err:
>  	put_device(dev);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 42a76a7a088f..6f3741a57932 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -887,7 +887,8 @@ struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
>  						     struct cxl_port *port);
>  struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev);
>  bool is_cxl_nvdimm(struct device *dev);
> -int devm_cxl_add_nvdimm(struct cxl_port *parent_port, struct cxl_memdev *cxlmd);
> +int devm_cxl_add_nvdimm(struct device *host, struct cxl_port *port,
> +			struct cxl_memdev *cxlmd);
>  struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
>  
>  #ifdef CONFIG_CXL_REGION
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 6e6777b7bafb..c2ee7f7f6320 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -153,7 +153,7 @@ static int cxl_mem_probe(struct device *dev)
>  	}
>  
>  	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> -		rc = devm_cxl_add_nvdimm(parent_port, cxlmd);
> +		rc = devm_cxl_add_nvdimm(dev, parent_port, cxlmd);
>  		if (rc) {
>  			if (rc == -ENODEV)
>  				dev_info(dev, "PMEM disabled by platform\n");


