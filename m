Return-Path: <linux-pci+bounces-6631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4C18B0C80
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 16:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8071C232E1
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 14:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8EB15E7F9;
	Wed, 24 Apr 2024 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjWge50t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0B915B15C;
	Wed, 24 Apr 2024 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968962; cv=none; b=iZnQITWmPwLUVfheyu+p5KEJoXRIQmoai9ggy9gC5Q+1Ck3tlIyfA6p+UVxoqOjIpHgVD3LcpwsA5ymZIqdrT1HP1kglMkWvII1IFexDLcEHhoxkJgt169IMyRXemLcPCJLMI3kZT7fBIGcjwAB5I/GYXAjWpI42vuncz/NPOcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968962; c=relaxed/simple;
	bh=WnfZajOmHIFhVo2TmxnugInu6gBY+wQy/yoWHmvGXAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WH6h3Xx+3XneFR11Cb38d8Gm66OpxTTcwwbPrg08diyYOUdb7bYMisInGzyB0fowrgszDaru46mheXrJjfyJIXCyGgPCfr4sNzoN7Or21ERr/UKnumOei4eHpWXiGqazjDf8dzJYfDC2ormLfPhdsjbuhis9FL3LjWjugvou+Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjWge50t; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713968962; x=1745504962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WnfZajOmHIFhVo2TmxnugInu6gBY+wQy/yoWHmvGXAc=;
  b=fjWge50tOh7FB7RT6wnhWGYNS2P1Klulq1gRYr8fUQi9KLUh5DUsPG3g
   W67XM65GL54vpqrpC7F9NjB3/HLMEqmGyXTp4Um78ZhKrQzIezPnH/sxy
   NAzZvYbE3iIZiNlbmNiETYrvdqxsoA159nw9NKm/bwVNRPPC4cqvu92Tc
   8m99JQHGWVcx3QKIC0Li7QxvrR8qsEbThQcKxssXkdgbHDEXuCz1j25vD
   Eu2UDPrkxf5AayEWSL4pho3Zm7ncSCapfrf0fyW7UB3vjSjie+SwHQwzn
   YWaJ2N8L4gmPMHmKs5BLvIxpgXwDCXUrMZIuMFUbfLu9Y0lyYRUifNn5i
   Q==;
X-CSE-ConnectionGUID: 2akSrfGbQa+jAEqUfuRhlQ==
X-CSE-MsgGUID: wcUfoYPxQwiNQ3quy/Gezw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="27058532"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="27058532"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:29:21 -0700
X-CSE-ConnectionGUID: C88DltovSWq1GS2a3z6jdw==
X-CSE-MsgGUID: M1TpDd9ySvC4wXOuBMxm9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29366565"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:29:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzdcU-00000000fvA-0mQd;
	Wed, 24 Apr 2024 17:29:10 +0300
Date: Wed, 24 Apr 2024 17:29:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
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
	Xiaowei Song <songxiaowei@hisilicon.com>
Subject: Re: [PATCH v2 2/4] PCI: dwc: Remove unused of_gpio.h
Message-ID: <ZikXNX_RZJWRso4d@smile.fi.intel.com>
References: <20240423172208.2723892-3-andriy.shevchenko@linux.intel.com>
 <202404240649.QgY8lto8-lkp@intel.com>
 <ZikT0lWPOQD3uuH0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZikT0lWPOQD3uuH0@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 24, 2024 at 05:14:43PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 24, 2024 at 06:51:05AM +0800, kernel test robot wrote:
> > Hi Andy,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on pci/next]
> > [also build test ERROR on pci/for-linus mani-mhi/mhi-next linus/master v6.9-rc5 next-20240423]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/PCI-aardvark-Remove-unused-of_gpio-h/20240424-012448
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> > patch link:    https://lore.kernel.org/r/20240423172208.2723892-3-andriy.shevchenko%40linux.intel.com
> > patch subject: [PATCH v2 2/4] PCI: dwc: Remove unused of_gpio.h
> > config: arm-defconfig (https://download.01.org/0day-ci/archive/20240424/202404240649.QgY8lto8-lkp@intel.com/config)
> > compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240424/202404240649.QgY8lto8-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202404240649.QgY8lto8-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> 
> Right, I need to add a chained_irq.h which I have in a separate patch for now.

This is here
20240423211817.3995488-1-andriy.shevchenko@linux.intel.com

Which should be applied before this one.

-- 
With Best Regards,
Andy Shevchenko



