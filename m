Return-Path: <linux-pci+bounces-27800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF769AB8755
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 15:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB2B1B657F6
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66A8298C12;
	Thu, 15 May 2025 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LSCvnkK3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DE529712C;
	Thu, 15 May 2025 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314500; cv=none; b=vF+orbcJeqLJ5mlVtklaSE3LprtIzgaYHmTa4cqOSZMrnwzvZ9qnxV269pIK6of6x3rz+DB7oAqruw3cuBy0AaK52DledQ8w+IrQo9YPPrzo5rn9bL/1Sf+Ps5bKUFiTVIZ7szRj25afe0ismKk5o1iV44vS5Ia3uA50jkySVvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314500; c=relaxed/simple;
	bh=e85/bhBHETcFCSUJZBS0UEVPKAob/R3o9IFPD/Ika/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFDITZg2sJhAPEtN3pXhhmbAUm+aTWzP/8H/ivulJuW1MsVY2CpaRm3CkbMgzG3hPyxs0MdNisLm0EO9ACacEsYv1LlAAL6HCoC4O+zz1ftGVr8sdBbp3GvRwvr0RhU9sugJfp3eLJbKnW+KXbIBeO6Iju6q0KIrTyIrt8gkXoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LSCvnkK3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747314499; x=1778850499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e85/bhBHETcFCSUJZBS0UEVPKAob/R3o9IFPD/Ika/w=;
  b=LSCvnkK3v8s5DDlX92qR33ozB/wpsU97XSuEJGvwZXGksJOzHpxgrTce
   mPSkiucoJL+EVPK9EYKDqikCifOIqw7Z37isKI5SFj94njRrkaadHTIYx
   9mTsicaRPHWHceJgK6SxrGmfYpZHMO3SIYb+zYgH3C8OZfNLfAOCIQs68
   N/wUmAa0EaZ62ksnfNagCCW3AoMNV27MnLLbw8KhPkPlSloGDAIr1F77z
   ZVLfaMHAMlToRAhODZlZImM9CWzYAQrKXnbMTfu12pgbw8E77XoHuKHdB
   coECFil4rrC3O6wqraD1g8PLN+eNmoqDqjLqI52SQb01m2AYS4MHjbbBw
   w==;
X-CSE-ConnectionGUID: vjV2fT8ORtSWk1jJnjYqZw==
X-CSE-MsgGUID: dOdB2U+sSu+RuZsDamuXNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="36865936"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="36865936"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 06:08:18 -0700
X-CSE-ConnectionGUID: UnPUDn06SxiC8UQ1Lg/NLg==
X-CSE-MsgGUID: VFJZK23ETZKHrNFMtW9LPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="138763592"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 06:08:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uFYJp-00000001qoN-0Ms4;
	Thu, 15 May 2025 16:08:13 +0300
Date: Thu, 15 May 2025 16:08:12 +0300
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
Subject: Re: [PATCH 0/7] PCI: Remove hybrid-devres region requests
Message-ID: <aCXnPHy5heHCKVd_@smile.fi.intel.com>
References: <20250515124604.184313-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515124604.184313-2-phasta@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 15, 2025 at 02:45:58PM +0200, Philipp Stanner wrote:
> Howdy,
> 
> the great day has finally arrived, I managed to get rid of one of the
> big three remaining problems in the PCI devres API (the other two being
> MSI having hybrid-devres, too, and the good old pcim_iomap_tablle)!
> 
> It turned out that there aren't even that many users of the hybrid API,
> where pcim_enable_device() switches certain functions in pci.c into
> managed devres mode, which we want to remove.
> 
> The affected drivers can be found with:
> 
> grep -rlZ "pcim_enable_device" | xargs -0 grep -l "pci_request"
> 
> These were:
> 
> 	ASoC [1]
> 	alsa [2] 

FWIW, tailing space here.

> 	cardreader [3]
> 	cirrus [4]
> 	i2c [5]
> 	mmc [6]
> 	mtd [7]
> 	mxser [8]
> 	net [9]
> 	spi [10]
> 	vdpa [11]
> 	vmwgfx [12]
> 
> All of those have been merged and are queued up for the merge window.
> The only possible exception is vdpa, but it seems to be ramped up right
> now; vdpa, however, doesn't even use the hybrid behavior, so that patch
> is just for generic cleanup anyways.
> 
> With the users of the hybrid feature gone, the feature itself can
> finally be burned.
> 
> So I'm sending out this series now to probe whether it's judged to be
> good enough for the upcoming merge window. If we could take it, we would
> make it impossible that anyone adds new users of the hybrid thing.
> 
> If it's too late for the merge window, then that's what it is, of
> course.
> 
> In any case I'm glad we can get rid of most of that legacy stuff now.

For all non-commented patches,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



