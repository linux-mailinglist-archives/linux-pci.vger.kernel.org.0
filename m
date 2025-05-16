Return-Path: <linux-pci+bounces-27840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 231BBAB9882
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 11:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153BC1889B49
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 09:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE4B15530C;
	Fri, 16 May 2025 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqw4uHgr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B65218ADE;
	Fri, 16 May 2025 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747387012; cv=none; b=uHoF+1t32AiP0NpcoLT7SBNNFQkTKnk2iDt2vscL6CSkFZmmUAoSu67U5fYZoCyfAuPMqgs25ya04wNuvVBqeH/KRPxJXdtQ5qE0wdS4VLjz1PJ6W+Cgl7Y2I0CCD/CMR4EGmw6BJi/e6Nyx3WDjNExhQ+87rzYxmD3QufVu3m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747387012; c=relaxed/simple;
	bh=5bNokGWiUlhbfBOBRggN7GhZMFpZiGHRUlzivFTfzAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubdccjCpjs/dxtd0W+PO1WvSNbDFTFQt5DERCODznQP6p/6Lk7hjZ6zkztVcGMupY3XScEzuyBAlFipJ8I5tb/e090GYB/cUSLuvR8VtsiLm01WQpGua2w6KFqqsltiELNGY22rXC5ZlA5HgktWRSmtG1+LyR/GeAzHO4qiYxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqw4uHgr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747387011; x=1778923011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5bNokGWiUlhbfBOBRggN7GhZMFpZiGHRUlzivFTfzAc=;
  b=iqw4uHgrgco3f9XlG3GVPTsYEAnEYHNLhv3obUgj9t3eG2KKYINEEqSl
   JRBKWqIHiFRIPdE8trmtIszviJGWjl1rG67TrEa2APftsm8HgpzprrQ/v
   T2i/Aqr2Gj3WGowRPUQEffx9E+G4DC/7Dpj/TNZmIe6dZfCK64vPIR1bh
   iGqRp4yx8fBMp0zsP9vnhum9gk9BSqkf2IrOzDWJj6zQNyVeNqW0W2dht
   MJ8I1py3Hrao989DJp24BbeWtHxq6Z755NaMUnuJH09ohwwesvfiPEgeO
   1RpJYGwkxq2b/tJEWqNCZxMFi3OlnWuEY+/KnEOfvnPFozVO5+1wMi0Nh
   A==;
X-CSE-ConnectionGUID: 82IoawnFQJ+OvOILY+OvlA==
X-CSE-MsgGUID: 2zq0xG+ZQau8MoqZGbWefA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="60690653"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="60690653"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:16:51 -0700
X-CSE-ConnectionGUID: JzZeaai2Rz6LkmatA+ChmQ==
X-CSE-MsgGUID: n3qolihySfSuUaicXBZnsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="161947142"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:16:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uFrBN-000000025vO-1Kab;
	Fri, 16 May 2025 12:16:45 +0300
Date: Fri, 16 May 2025 12:16:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: phasta@kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 6/7] PCI: Remove unnecessary prototype from pci.h
Message-ID: <aCcCfeRqqOqWKG63@smile.fi.intel.com>
References: <20250515124604.184313-2-phasta@kernel.org>
 <20250515124604.184313-8-phasta@kernel.org>
 <aCXl-U5Dsv3hdCWa@smile.fi.intel.com>
 <3f1140397e628cfdf4156f02f5454f844003dc6d.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f1140397e628cfdf4156f02f5454f844003dc6d.camel@mailbox.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 15, 2025 at 03:37:06PM +0200, Philipp Stanner wrote:
> On Thu, 2025-05-15 at 16:02 +0300, Andy Shevchenko wrote:
> > On Thu, May 15, 2025 at 02:46:04PM +0200, Philipp Stanner wrote:
> > > pcim_intx() once was an internal PCI function, but since then has
> > > been
> > > published and is used by drivers, and, therefore, available in
> > > include/linux/pci.h. The function is not used within PCI anymore.
> > > 
> > > Remove pcim_intx()'s prototype from drivers/pci/pci.h
> > 
> > Can this be moved up in the series? Or is there other dependencies?
> > I.o.w. this
> > looks like a leftover from something of the previous work.
> 
> That can be moved to anywhere, including a separate patch. It's an
> independent patch, a leftover from last year. But it's related to
> devres, because it was also added because of the problem with
> pcim_enable_device().

When put at the end of the series it makes an illusion that there are
dependencies. Separate patch is ideal, being first is good enough to me.

-- 
With Best Regards,
Andy Shevchenko



