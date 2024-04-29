Return-Path: <linux-pci+bounces-6757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B164E8B536E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 10:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3788B213E4
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6DF18AE0;
	Mon, 29 Apr 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOSmcDJu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E29C1AAA5;
	Mon, 29 Apr 2024 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714380490; cv=none; b=svX9UbSGokzMiRTeop5nHOYgq0/rHSjaGsTanuiQX2T2aHKYZJ5N5nGXdePzfJ8Kk93Ai+xd2yb+ospht45LUS3xrL8XbbOyguEQ46Vyq1yDuLncVsAtGtBX9SyOqyf2KdMbQ8oWC3k9v1hByx42FczSc62nlwmjVJVLKf/HSVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714380490; c=relaxed/simple;
	bh=Z8WLMcuvoc4LDhYSNGhPtCPz11xVNOa8e2sBdMQx030=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LU8pmNDFjdxqcEJspwrs7GZOhYsLMMwDxu9yyURl7jk9mki+FfuPRmrHltlQld6IGd3UJdTsxQsObexiFtSjxMcCJjfeDbd6RGsjdnN4fVq3IUStN59VWX92gvAb7NRAznKeWjROdWhEuqjLjVsISaLtLRapM1F1qvtkJmgLJL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOSmcDJu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714380490; x=1745916490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z8WLMcuvoc4LDhYSNGhPtCPz11xVNOa8e2sBdMQx030=;
  b=FOSmcDJu44C083S4JlMZxHp+qKWrKPRNOGVrCzZzoS0fE7CUgb/GOj5V
   jseUQScfmI+Gkq7KsNfy0ERtujsFIlqc9dD2G58HAwWWqWZndC6e2RwYZ
   MyaS8EmnClerF8aqri0jgxomZHKbFg/Sikln1stzeYFd00ngjqo7+iWdW
   hdQ5oOrckfHTchrCuvRtH5wLDS1KQWtm9/MWCvdStd7UweDC8t6dSSQPL
   qw6ouV6rCZDSvyw1Tx+gn0QIywBzUXDogFmoyhjII0tGojTnMwEaZrrAs
   bpVd8kKBXj6wPFeXsEgllTbOXT9OBbt0JlclMm/N3FIvSY2XtenRnGVif
   w==;
X-CSE-ConnectionGUID: tNHTSfA8TG67aYLUZN/j+Q==
X-CSE-MsgGUID: gElrVSdDRh253NE7vcJSAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10143321"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="10143321"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 01:48:09 -0700
X-CSE-ConnectionGUID: 6In1FgQkScO0LRKeS9iqeA==
X-CSE-MsgGUID: HTM8jSzOS9CfPGqWX67RQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="57235629"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 01:48:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s1Mg1-00000002GCn-2sLU;
	Mon, 29 Apr 2024 11:47:57 +0300
Date: Mon, 29 Apr 2024 11:47:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Yue Wang <yue.wang@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH v2 4/4] PCI: kirin: Convert to agnostic GPIO API
Message-ID: <Zi9eve2brQvKwAKm@smile.fi.intel.com>
References: <20240423172208.2723892-1-andriy.shevchenko@linux.intel.com>
 <20240423172208.2723892-5-andriy.shevchenko@linux.intel.com>
 <20240427072335.GC1981@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427072335.GC1981@thinkpad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Apr 27, 2024 at 12:53:35PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 23, 2024 at 08:19:07PM +0300, Andy Shevchenko wrote:
> > The of_gpio.h is going to be removed. In preparation of that convert
> > the driver to the agnostic API.

...

> > +		pcie->id_clkreq_gpio[i] = devm_gpiod_get_index(dev,
> > +							"hisilicon,clken", i,
> > +							GPIOD_ASIS);
> 
> Please don't use GPIOD_ASIS even if the old code was using it.
> 
> For all 3 GPIOs in this driver, GPIOD_OUT_LOW flag should be used as the default
> state is assert (considering the fact that the DT uses GPIO_ACTIVE_HIGH).

And if not? I believe we may not assume that all of DTBs around the globe put
the flags correctly. But I think you know much more about them than me, hence
I am okay to update this.

-- 
With Best Regards,
Andy Shevchenko



