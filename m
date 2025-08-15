Return-Path: <linux-pci+bounces-34091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C68AB27829
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 07:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D1A3BC2F2
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 05:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7666D2561C9;
	Fri, 15 Aug 2025 05:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8h1RDPw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F28245020;
	Fri, 15 Aug 2025 05:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755234725; cv=none; b=E2yBgV+VCK3xr3mSU8BbYMII9pLqLMPP8zMmQDodQMLWlWn0yUly2VYHjrZDW9iGfVZhdi2qimhXUTTjceAXRamfH6R+qDu4uPl+3F8NXf2LQBrNpdtzDv0K4jTdwVJxo0BBiMYxdSTfIIcqta/zkwaq0WOAEV1pXmnyO2Ica/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755234725; c=relaxed/simple;
	bh=piFJDMoWgMoAcz5ZrOxOxHNp2cNxC29xMo9DwzCJmRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dsE92wQ1fA7XtsdgP/vcxWzR00/dlf8Nmx/raXF8dlMUiLWgTljL9eVsEYcvTFWLjSUL7ARCHR/np7hqoWPf6E9J3AmB8dsZSVe6CqQqARrm9xuxp9mV3xfxE3Z+BG2NkLY790eqB78dWDHUpd9ENJ7COrTv/pn8+5uOH5bXr/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8h1RDPw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755234724; x=1786770724;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=piFJDMoWgMoAcz5ZrOxOxHNp2cNxC29xMo9DwzCJmRM=;
  b=n8h1RDPwgubFjM4uC5h8bpQqxyknnlL0YxZBHxqITuri/5B+A0OhXw41
   uqHyDeExnn5TRa3fDn3zIILalV8IWxOKFc8rcSQ7HhtjVQn7jsYNn4dk5
   EdUdRfRNiHzXr8ZAj7hWYsY3/1Qk1iPYBSwQHK6Z4xGW1qBqxA3pbu4v/
   l36EnTHiJX1psKU5wGPkmduARKNBcyZi/gphB2PHbpXTfeLMYDHCO+Fmc
   Frq+M/j66QIDWJ7DAsNiRJVLK8WQcq3/Q6LpHD9S6EodzbrLjgOGNSkW2
   Eb9GsiK4436Td1ci950LXAF0Hbxjfwb0K39f7UI/0irc+ygxrqf2mv3hX
   w==;
X-CSE-ConnectionGUID: vW3KyP2FSg6f25rN1OVg1w==
X-CSE-MsgGUID: KVABhgCgTnq2Vqx9wXLJqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="68646434"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="68646434"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 22:12:03 -0700
X-CSE-ConnectionGUID: z3XLWN8JSkSewaRE53xizA==
X-CSE-MsgGUID: k+jCi0MrTzK5WA2i0FqSdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="197786291"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 22:11:57 -0700
Message-ID: <eb248b73-7fb6-47cd-9e10-5c54ca2391b2@linux.intel.com>
Date: Fri, 15 Aug 2025 13:09:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] iommu: Lock group->mutex in iommu_deferred_attach
To: Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
 joro@8bytes.org, bhelgaas@google.com, jgg@nvidia.com
Cc: will@kernel.org, robin.clark@oss.qualcomm.com, yong.wu@mediatek.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 rafael@kernel.org, lenb@kernel.org, kevin.tian@intel.com,
 yi.l.liu@intel.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, patches@lists.linux.dev, pjaroszynski@nvidia.com,
 vsethi@nvidia.com, helgaas@kernel.org, etzhao1900@gmail.com
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <44783ca52e17a9ca0ce7acfe8daae3edc3d7b45b.1754952762.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <44783ca52e17a9ca0ce7acfe8daae3edc3d7b45b.1754952762.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 06:59, Nicolin Chen wrote:
> The iommu_deferred_attach() is a runtime asynchronous function called by
> iommu-dma function, which could race against other attach functions if it
> accesses something in the dev->iommu_group.
> 
> So, grab the mutex to guard __iommu_attach_device() like other callers.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 060ebe330ee16..1e0116bce0762 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2144,10 +2144,17 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
>   
>   int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
>   {
> -	if (dev->iommu && dev->iommu->attach_deferred)
> -		return __iommu_attach_device(domain, dev);
> +	/*
> +	 * This is called on the dma mapping fast path so avoid locking. This is
> +	 * racy, but we have an expectation that the driver will setup its DMAs

Why not making it like this,

int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
{
         /* Caller must be a probed driver on dev */
         if (!dev->iommu_group)
                 return 0;

         guard(mutex)(&dev->iommu_group->mutex);
         if (!dev->iommu->attach_deferred)
                 return 0;

         return __iommu_attach_device(domain, dev);
}

?

> +	 * inside probe while being single threaded to avoid racing.
> +	 */
> +	if (!dev->iommu || !dev->iommu->attach_deferred)
> +		return 0;
>   
> -	return 0;
> +	guard(mutex)(&dev->iommu_group->mutex);
> +
> +	return __iommu_attach_device(domain, dev);
>   }
>   
>   void iommu_detach_device(struct iommu_domain *domain, struct device *dev)

Thanks,
baolu

