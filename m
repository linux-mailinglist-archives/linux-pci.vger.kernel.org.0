Return-Path: <linux-pci+bounces-6584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 298F58AF465
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 18:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0B228E8C4
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 16:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D69613D294;
	Tue, 23 Apr 2024 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IuaknStN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B147C13CF90;
	Tue, 23 Apr 2024 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890401; cv=none; b=nijC9K0LSEfMMo96+S7aVFXXx+Nbb7Bojab7ty7LdKtUOVbzg+MPdUTYBTk1hvoC2QDf6SJAAnKc65EuW0LE7dvGU0/4eVeYyZXcg6+aFGIx90IQzZtG3CD3fo5FLoGbeH/XJRaBKxXYdFNg/vTnaZFNYEGxdFQLsQLTKfnGp+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890401; c=relaxed/simple;
	bh=UZSu4Bcaj41tuZdLznVgg+wmyuxc9D7LdkUtpGpC5uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dmu2cbloSvaGTOhQq+Aq4/MfFx5b8DTi48jyOE6KYRKKtRCgGvFgNsmqJYpdg7Bde8aMwLrVCgI3JlaWsgB6ui3RFX4Mi0LlXgjaKNp5zinFxVyrqrTJsGY+ik3HO9/PVWL98mdJshNGWAo4ifUUA/ebc/yNPWf9qevhNsEMDIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IuaknStN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713890399; x=1745426399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UZSu4Bcaj41tuZdLznVgg+wmyuxc9D7LdkUtpGpC5uk=;
  b=IuaknStN+PJTN+p6rf2cVouE9vKxsi6c1aUCtoLb+933wuJFSK16alM5
   b3xv1QkWx08xBhf36Kmm3UulUcW84YppNHDp1zYEhN7qjURaQstxQK9QX
   fkEUabmpvHnQR0yRNsK1ocuC6Ze00RDsV2Kk0UWXeiOR4u6mcvIlL5pLQ
   qHt3QANurPij5D2SJk4GCsSpQMlVhLpwKcWj+N/+iLCqC8T/lqHvOcY+1
   37m9ANzlZwO2BYQgwcVLWVby6mRh7f5JShM+YyohkqaHOZt5Td06yaBVM
   NXryFy8kNu7a1UBqiJbkffXltTvU/1zVzJ2S/NvoMCrOxM+MZvVEZXvzO
   Q==;
X-CSE-ConnectionGUID: MCmU9BFESaW5pZR8GKn2bA==
X-CSE-MsgGUID: ZrHrDf4uS7WsIuNovrr8HA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20182269"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20182269"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:39:58 -0700
X-CSE-ConnectionGUID: i4kDePn9TVuD6B1wLCiCiA==
X-CSE-MsgGUID: ce04Eyj5Q5WWfqulzqJizA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="55624711"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:39:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzJBN-00000000Ojk-2cFZ;
	Tue, 23 Apr 2024 19:39:49 +0300
Date: Tue, 23 Apr 2024 19:39:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Yue Wang <yue.wang@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v1 1/1] PCI: dwc: Remove unused of_gpio.h
Message-ID: <ZifkVRL5Uvoso2O4@smile.fi.intel.com>
References: <20240307122840.3682287-1-andriy.shevchenko@linux.intel.com>
 <20240308095547.GI3789@thinkpad>
 <Zer_9VTVJqCNoOFG@smile.fi.intel.com>
 <20240308171029.GB53064@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308171029.GB53064@thinkpad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 08, 2024 at 10:40:29PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Mar 08, 2024 at 02:09:25PM +0200, Andy Shevchenko wrote:
> > On Fri, Mar 08, 2024 at 03:25:47PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Mar 07, 2024 at 02:28:40PM +0200, Andy Shevchenko wrote:
> > > > of_gpio.h is deprecated and subject to remove.
> > > > The driver doesn't use it, simply remove the unused header.
> > 
> > > What about the rest?
> > > 
> > > drivers/pci/controller/dwc/pcie-kirin.c
> > > drivers/pci/controller/dwc/pci-imx6.c
> > 
> > Have you chance to look at them?
> 
> Ok. I failed to spot the usage of of_get_named_gpio() in both drivers. But you
> already submitted a patch to convert kirin last year [1], and that didn't get
> any love from the maintainers. Could you please respin?

Sure.

> Perhaps convert imx6 also?

I'll look at it, if it's easy enough, why not, otherwise let it rotten for a while.

> [1] https://lore.kernel.org/all/20230213180735.42117-1-andriy.shevchenko@linux.intel.com/
> 
> > > There is also one non-dwc driver:
> > > 
> > > drivers/pci/controller/pci-aardvark.c
> > 
> > Keyword: non-dwc.
> > This patch is for DesignWare controllers that confirmed not using the header.
> > 
> > > It is better to remove it from all PCI drivers in a single patch.
> > 
> > I disagree on this. These are different drivers and even inside DesignWare not
> > all of them can be converted with a simple change like this one.
> > 
> 
> Since this is just a header removal I thought you can just send a single patch
> for these drivers since there is nothing special that warrants a separate patch
> for aardvark (both are inside the drivers/pci/ hierarchy).

I'll look at aadvark as well, I dunno if it's simple removal enough there.

> But anyway, I wouldn't press for it.
> 
> > That said, please consider applying this one as is.
> 
> I can give my R-o-b tag, but Lorenzo or Krzysztof will apply this.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



