Return-Path: <linux-pci+bounces-7106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6D68BCC53
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 12:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8094B213DD
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 10:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9518F757FC;
	Mon,  6 May 2024 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XAbUtn6Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FAB2BAE3;
	Mon,  6 May 2024 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992511; cv=none; b=bV04L1C747NZvP9LdF26Afuwyql++P5BPuF14PnrdOUwlVE5X1Dc0BMjAg5ZbWQK5KtElESU/jV6heyNjOmAQbm6CLQKKfU/6Fc5qNXo8KvzjBtXtEJ9eI0WipPJ7/sNpHj0Sf23CxmQe3eDDMpnjgrn2XxbN0q+R71MV4Lr4zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992511; c=relaxed/simple;
	bh=Hkr65neol7moVbYcz4JhrxGkKmAFlo3QCts5BAX/JeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3uwMgPw76GbI+awd0IJZE1uJkVPrMy5U89m9lkDYjk1fBTBi9cBvA3WHYj+djgrwxC5r1VqaABDGaJrDiNVlbQ8F7kP4y7ql4R97FoQG1Bmx61qlUWDJde+TTJXL9kL73vw9+A6P9fOIntdu3qmQOUAT1CMbm9qvd6osoQ8Hx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XAbUtn6Q; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714992510; x=1746528510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hkr65neol7moVbYcz4JhrxGkKmAFlo3QCts5BAX/JeA=;
  b=XAbUtn6Qv80eXDr4uDw1eV3REbc29NWJY0x76H0grR8b4Iyf5a76NYfD
   YEPa3nMSjfBhDTU6YDDCDHgxnYdfj6/w3Q0PYMCreHnqoBpVaYD7s55GY
   baOVta8yR6WFdSUvhCDWgDkzjOYagYRm+iGWn0ZM5jNCkJ/JgsM2LeXuS
   U7ZDFaw3Zp4J6bAnWQTr4BIleqDszm6uCxZnvOJBW/pRnwtkILLWqQu3L
   uxQd/02vYHNQsCv1b6FCRktWJ5y1mKt4POcsPFPn5YiZx8EnCPk+wwXPq
   Gwq1+d4MTfKXgpAl0UYQTP9P6G+6FA4ucEWjEtlH2KF5Fajh3NcxPXnvi
   w==;
X-CSE-ConnectionGUID: ztQmtLcdR3ir5hG91cx9qQ==
X-CSE-MsgGUID: 0ZIbtVTxRxux2V6h1JFd2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="22141455"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="22141455"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 03:48:29 -0700
X-CSE-ConnectionGUID: gfqCPeZeTiqvdoy3cHNrAg==
X-CSE-MsgGUID: TecDTmn/SAqaUoRMU8GFQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="65568146"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 03:48:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s3vtJ-00000004ehl-02rk;
	Mon, 06 May 2024 13:48:17 +0300
Date: Mon, 6 May 2024 13:48:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
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
Subject: Re: [PATCH v3 0/5] PCI: controller: Move to agnostic GPIO API
Message-ID: <Zji1cEqUMZOdk6QN@smile.fi.intel.com>
References: <20240429102510.2665280-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429102510.2665280-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 29, 2024 at 01:23:17PM +0300, Andy Shevchenko wrote:
> While at it, remove of_gpio.h leftover from some of the drivers.

Can this be moved forward?
Or should I do something additionally with it?

-- 
With Best Regards,
Andy Shevchenko



