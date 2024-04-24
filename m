Return-Path: <linux-pci+bounces-6627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402228B0C31
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 16:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70FFB1C214F2
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 14:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0F415E5BD;
	Wed, 24 Apr 2024 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lhtt4Am7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808FB158DDD;
	Wed, 24 Apr 2024 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968095; cv=none; b=eXLMLQjkA9jI1yYPXI1drTwXpddLnwFl5e83GKToHwE6bWdIjTpFk28B+bydBt26R3nP1MVWZM64pIxO2hHdxvqjmMQfOYUOdANm3xE0egq6k+D9nbG8JGOCftEjctjopBL3zRcIzj3t2L+WFaqil+4wBo69OlEnGjEVBdbhJJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968095; c=relaxed/simple;
	bh=ll03pwob+gLokLHhKJ9wKqSKaJJ7BhxC+kqwsk3GZ64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrHxRdS8TdRfwbrxwi4ZS+Zpn0s3x9uCs+4l2exn7GNtF5hRG1Yo3WqqQUuponOSzx3etLW/r+g00rUU9xXtPjPNZhNm7QqLF3anGSHSO+IAleHKs4JurA2VAnVqlML6CK4fo378AefJhGWZAx2upGIxUcKLqLiFjV/9U59aUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lhtt4Am7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713968095; x=1745504095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ll03pwob+gLokLHhKJ9wKqSKaJJ7BhxC+kqwsk3GZ64=;
  b=Lhtt4Am77xmVtd0WOFi+gkqwfaLXJsU+oY7n2tjLYsEWNaWmuHjyLNJt
   Vkw/RC0x+k2EGUTd6tizyO0i6nd9SKFzearGRTbvDSqJEtwEkxEQQbmQR
   MCoJhv3C8EBgBVSHz1F2wIKMKON5/TWchVfUDcQvdwHiToicfD/Md0qWL
   abBoPLY29gALZBMwvB7Tqzo/WeGJeHGeOVMDxyw0eTG3gG8KS9SEdbCMx
   GX8jmHmEcSE2UEswjE8vrqAfIdijhfzDtMzcJf7svrAU3dD9xgh6VGrFD
   dvUczGwHgooRAgVPs+4H+EvwBWxwl7yDiNZs7Qi7YuKSsubeCUMPf4qht
   g==;
X-CSE-ConnectionGUID: pJyG7e2nSOickmoWv3fHsQ==
X-CSE-MsgGUID: PcTFPJ6eSfSVY5BbO6EFsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="27055532"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="27055532"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:14:54 -0700
X-CSE-ConnectionGUID: jF/bLxj+TMOWgskL6OyzxQ==
X-CSE-MsgGUID: /E2UezzlQCWzmgGctGONLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29364232"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:14:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzdOV-00000000ff8-0bTg;
	Wed, 24 Apr 2024 17:14:43 +0300
Date: Wed, 24 Apr 2024 17:14:42 +0300
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
Message-ID: <ZikT0lWPOQD3uuH0@smile.fi.intel.com>
References: <20240423172208.2723892-3-andriy.shevchenko@linux.intel.com>
 <202404240649.QgY8lto8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404240649.QgY8lto8-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 24, 2024 at 06:51:05AM +0800, kernel test robot wrote:
> Hi Andy,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on pci/next]
> [also build test ERROR on pci/for-linus mani-mhi/mhi-next linus/master v6.9-rc5 next-20240423]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/PCI-aardvark-Remove-unused-of_gpio-h/20240424-012448
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> patch link:    https://lore.kernel.org/r/20240423172208.2723892-3-andriy.shevchenko%40linux.intel.com
> patch subject: [PATCH v2 2/4] PCI: dwc: Remove unused of_gpio.h
> config: arm-defconfig (https://download.01.org/0day-ci/archive/20240424/202404240649.QgY8lto8-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240424/202404240649.QgY8lto8-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404240649.QgY8lto8-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):

Right, I need to add a chained_irq.h which I have in a separate patch for now.

-- 
With Best Regards,
Andy Shevchenko



