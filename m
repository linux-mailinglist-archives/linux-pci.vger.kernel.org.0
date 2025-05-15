Return-Path: <linux-pci+bounces-27798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D91AB8730
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 15:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ECE67A1193
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 12:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB8722257E;
	Thu, 15 May 2025 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c24Mrnlq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D50298CBE;
	Thu, 15 May 2025 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314019; cv=none; b=KUOtK/ePPwagfW//0HtCX4M8nxH2779qZts2sjMMzOhS2DqQbAOHzeuGTl2nMbg8XjZCoXVn40RT65awxZbI1LeDWcQznZ1yVMv5EAxv45JC0YoK9Pina3UQaxQqeWsPZ01UMaiSkFASSN47yw/wQYDBR5YZS6arl/2Hg+EW8Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314019; c=relaxed/simple;
	bh=Q13g0aWrsuqzk89AuygoyrM8D343SmJHNKTIC1D6zMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/iknqYCu25dxzkePAzGboQQovwfuDM6EWyJV8cEl6zjbACyeHodQsQduqSzsh7D4EAa6xlWGGOD2YcV7w4iST/BS5DUhOFZa5PoSTI3Dx1wITZfz08o+qTJ91HXg7r1LQMG5r4V+eBWo7YlHIr1xrsQj26XbU8eL1nl2xRsqwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c24Mrnlq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747314018; x=1778850018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q13g0aWrsuqzk89AuygoyrM8D343SmJHNKTIC1D6zMM=;
  b=c24MrnlqRkaJ761g5XSEJ39l0tSra3KzP7mmwVPqnKsxXV9TWArSuVCp
   2oN7QNAqC9HiccXt2m59F1wFQa8wTP8gpoimZXgQ4PAWinJo43D6zcnZ4
   Wu6zzBKlq4S3yn5tNSTbWZ2O//NiV2hZCFokrJ/Ob8gQArhMBihaLmAhI
   9/Ov+AyVoGbWP88pn45IjxxHR31hPiRarrF47+/cX/X+hRVRL8o+ViPXL
   ynA+PvWuluGvU1S/TgRJQnNOkAd0wlDD8J3gmvebq+5TWw1VVcSNGNjjt
   VkOG0uKKxloNvfxFZ6EeRZPbACvBdW/uxVY9QmoN3jazJexGeecutPRkF
   g==;
X-CSE-ConnectionGUID: LKMUsSUQQv2zsY3P+LL2wQ==
X-CSE-MsgGUID: M5YdPadFQ+WaZxOL6KD18Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="36864380"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="36864380"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 06:00:16 -0700
X-CSE-ConnectionGUID: sqiSQ7LKTeWbUoo6mz90kw==
X-CSE-MsgGUID: 9355O8KdTMKe3md0O/9sjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="138760565"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 06:00:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uFYC3-00000001qgJ-02mg;
	Thu, 15 May 2025 16:00:11 +0300
Date: Thu, 15 May 2025 16:00:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/7] PCI: Remove request_flags relict from devres
Message-ID: <aCXlWoPm2XVA5m7M@smile.fi.intel.com>
References: <20250515124604.184313-2-phasta@kernel.org>
 <20250515124604.184313-6-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515124604.184313-6-phasta@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 15, 2025 at 02:46:02PM +0200, Philipp Stanner wrote:
> pcim_request_region_exclusive(), the only user in PCI devres that needed
> exclusive region requests, has been removed.
> 
> All features related to exclusive requests can, therefore, be removed,
> too. Remove them.

...

>  int pcim_request_region(struct pci_dev *pdev, int bar, const char *name)
>  {
> -	return _pcim_request_region(pdev, bar, name, 0);
> +	int ret;
> +	struct pcim_addr_devres *res;
> +
> +	if (!pci_bar_index_is_valid(bar))
> +		return -EINVAL;
> +
> +	res = pcim_addr_devres_alloc(pdev);
> +	if (!res)
> +		return -ENOMEM;
> +	res->type = PCIM_ADDR_DEVRES_TYPE_REGION;
> +	res->bar = bar;
> +
> +	ret = __pcim_request_region(pdev, bar, name, 0);

> +	if (ret != 0) {

While at it, drop the  ' != 0' part?

> +		pcim_addr_devres_free(res);
> +		return ret;
> +	}
> +
> +	devres_add(&pdev->dev, res);
> +	return 0;
>  }

-- 
With Best Regards,
Andy Shevchenko



