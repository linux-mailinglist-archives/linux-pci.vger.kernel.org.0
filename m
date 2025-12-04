Return-Path: <linux-pci+bounces-42646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B57BFCA50D1
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 20:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DFAA306D5A1
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 18:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193022FFF83;
	Thu,  4 Dec 2025 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/bGa8oF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B15315D3C;
	Thu,  4 Dec 2025 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764874704; cv=none; b=e6FuKPfHGDjx5XM7O9rj/8j5gytmdIsPxNPQj6o4qpuNyIWtbK6L+FvAYsV2hPXOVqyZdgmlODw0OrBpby0Y0I8PrU4zx0MSLvbwnDC4LxrLmxegssLZGf8IlNnRUvdZdoL+4gjBmejTm9esIrHpv0w8TMFDHODNQmZl4p0iN5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764874704; c=relaxed/simple;
	bh=71GCLR7TYyzr7ZNCt5BwPn8zUzJMbIyTwiyJZjTZUZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/Tu12qTAhW2wSxWc/XNzXpB/zll6FbtWyDLM6DM1rQbA6DpENIJD7uKnGWW6aiOw42qzWKyvcmNX94U3MJ2oZUiwqokfZSrKZkHnG7jQf27iWD77ETwmycjC8zXlb0zRWX15JoMZ4v75WL4pYX96Xs05tHY+KSISucZbqwlVyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/bGa8oF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764874702; x=1796410702;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=71GCLR7TYyzr7ZNCt5BwPn8zUzJMbIyTwiyJZjTZUZE=;
  b=P/bGa8oFkTxjF8WtxIBwkNwp2M3U8Z7p13odqfybeNL9EpnRG7nLeDRh
   wlnuCLxFsgPrm3G9NHH8FYhUZM4weD+kTlYQdyK5znYzXnmdqqqhZsgXR
   HgZRsGsYFh8yxcYXD3pfxBJ+4YDx5nIpchD1VjhPXclAc7q0HOLQviFFX
   0WZDB2Pr/rv4GRKenGL1DHG29nJw4jPvrsF40Py8QVKsF48eQL0vkVTqs
   Krb5M2WstntT8ZewVpEXbc6eWgZmUwa8pa08t+6TFHFXDS5hQQ1TGlQVM
   67KCLAi/Zr2PH12kCtqyeugu/K9y9gG8KP1zaVJBrObKMLAfSB/OcmE8M
   A==;
X-CSE-ConnectionGUID: Mis4lHGmS0ux07GyuF4jsQ==
X-CSE-MsgGUID: 7mht7WB6Rtyj48AYRZWBnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="66788025"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="66788025"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 10:58:22 -0800
X-CSE-ConnectionGUID: XOsHz/g6QceaCUE6IeynKA==
X-CSE-MsgGUID: L0q8bLyuREq0lnaoAyaNHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="225729906"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.95]) ([10.125.108.95])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 10:58:21 -0800
Message-ID: <1595e81f-cd7f-47c6-9bce-8070975e89a4@intel.com>
Date: Thu, 4 Dec 2025 11:58:20 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] cxl/mem: Convert devm_cxl_add_memdev() to
 scope-based-cleanup
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, alison.schofield@intel.com,
 terry.bowman@amd.com, alejandro.lucero-palau@amd.com,
 linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
 Alejandro Lucero <alucerop@amd.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-5-dan.j.williams@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251204022136.2573521-5-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/3/25 7:21 PM, Dan Williams wrote:
> In preparation for adding more setup steps, convert the current
> implementation to scope-based cleanup.
> 
> The cxl_memdev_shutdown() is only required after cdev_device_add(). With
> that moved to a helper function it precludes the need to add
> scope-based-handler for that cleanup if devm_add_action_or_reset() fails.
> 
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/memdev.c | 58 +++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 7a4153e1c6a7..d0efc9ceda2a 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1050,6 +1050,33 @@ static const struct file_operations cxl_memdev_fops = {
>  	.llseek = noop_llseek,
>  };
>  
> +/*
> + * Activate ioctl operations, no cxl_memdev_rwsem manipulation needed as this is
> + * ordered with cdev_add() publishing the device.
> + */
> +static int cxlmd_add(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
> +{
> +	int rc;
> +
> +	cxlmd->cxlds = cxlds;
> +	cxlds->cxlmd = cxlmd;
> +
> +	rc = cdev_device_add(&cxlmd->cdev, &cxlmd->dev);
> +	if (rc) {
> +		/*
> +		 * The cdev was briefly live, shutdown any ioctl operations that
> +		 * saw that state.
> +		 */
> +		cxl_memdev_shutdown(&cxlmd->dev);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +DEFINE_FREE(put_cxlmd, struct cxl_memdev *,
> +	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev);)
> +
>  /*
>   * Core helper for devm_cxl_add_memdev() that wants to both create a device and
>   * assert to the caller that upon return cxl_mem::probe() has been invoked.
> @@ -1057,45 +1084,28 @@ static const struct file_operations cxl_memdev_fops = {
>  struct cxl_memdev *__devm_cxl_add_memdev(struct device *host,
>  					 struct cxl_dev_state *cxlds)
>  {
> -	struct cxl_memdev *cxlmd;
>  	struct device *dev;
> -	struct cdev *cdev;
>  	int rc;
>  
> -	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
> +	struct cxl_memdev *cxlmd __free(put_cxlmd) =
> +		cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
>  	if (IS_ERR(cxlmd))
>  		return cxlmd;
>  
>  	dev = &cxlmd->dev;
>  	rc = dev_set_name(dev, "mem%d", cxlmd->id);
>  	if (rc)
> -		goto err;
> -
> -	/*
> -	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
> -	 * needed as this is ordered with cdev_add() publishing the device.
> -	 */
> -	cxlmd->cxlds = cxlds;
> -	cxlds->cxlmd = cxlmd;
> +		return ERR_PTR(rc);
>  
> -	cdev = &cxlmd->cdev;
> -	rc = cdev_device_add(cdev, dev);
> +	rc = cxlmd_add(cxlmd, cxlds);
>  	if (rc)
> -		goto err;
> +		return ERR_PTR(rc);
>  
> -	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
> +	rc = devm_add_action_or_reset(host, cxl_memdev_unregister,
> +				      no_free_ptr(cxlmd));
>  	if (rc)
>  		return ERR_PTR(rc);
>  	return cxlmd;
> -
> -err:
> -	/*
> -	 * The cdev was briefly live, shutdown any ioctl operations that
> -	 * saw that state.
> -	 */
> -	cxl_memdev_shutdown(dev);
> -	put_device(dev);
> -	return ERR_PTR(rc);
>  }
>  EXPORT_SYMBOL_FOR_MODULES(__devm_cxl_add_memdev, "cxl_mem");
>  


