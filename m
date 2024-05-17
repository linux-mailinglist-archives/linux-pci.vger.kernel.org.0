Return-Path: <linux-pci+bounces-7625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6BB8C8750
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 15:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0521F21855
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 13:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488B35491D;
	Fri, 17 May 2024 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLVE1+TD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DC6548F1;
	Fri, 17 May 2024 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715952988; cv=none; b=NxNVtsDM95ZaoPtfDfW0OKN+549X3/33Dn6vKDYlkABE7k2FAutXZQQE+08hyvC4ffHSUnvPjT87dvvOqqWsyloGso+iu95qS++ZiI0YzMb9HL4bt4AsKl1B0FJ8ZpuhSVArApCQTuQM43xpa6DNHdl8+4XrCUwCy6eLcw5AIdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715952988; c=relaxed/simple;
	bh=Jn7zwgtw8zPXbp3XlrdrrybXQAtHJe4Qo6Tf/v8KOUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBYIeYeM/H10MQUUVydQVJrfavqczaAU56q91fexMu+oObPYZe3USwrlbmvhatFvP19vNai3D3G04dmwbIXEALNky3GGKqa7+QDXCqdW/JXtwSc7KJIy8f2dNpTyJA99hwjNa5mmcTYMc14XGxqhFh81zu3u9ozKU01x4d+Nx1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLVE1+TD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715952987; x=1747488987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Jn7zwgtw8zPXbp3XlrdrrybXQAtHJe4Qo6Tf/v8KOUU=;
  b=GLVE1+TDn1+B+Yvz1TDYsrnHwHKuwnEaOHON1aDguXhPcSKWapzQLrCP
   Zmm3BPBcaZWWLB8tof7gthuCMyKUFnH+GP+BEsNKSz6FMQeEevVLyJAdD
   UHGs6MTuFP9+dARRoni9Bmz4N3hMR5j4y/mt6n5sV9h8ZJqm1NXqrHWVZ
   jPp01eiWt3JeJ/3kkkIza+YMCjVKAFbbQvyIqvhJiGMabQR2d9nWijfO+
   iQo90bw7saGxZOZCwRvQ74lemjNcdVoi0NBb5fXiplIeBJRJZCmDs2UaD
   jnnEZUqE4zExEzIi81yKZ4JNhaPkZmOTpxPrWJC2PeMSYSU4F8dhwzDKM
   A==;
X-CSE-ConnectionGUID: kPiR+F8/Rqmslq0Yx1dcVg==
X-CSE-MsgGUID: ePwl3apbSpquXl+4wUveJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15956634"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="15956634"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 06:36:26 -0700
X-CSE-ConnectionGUID: hv+jf/nYRMKp252TDzhWlA==
X-CSE-MsgGUID: rHPZ9NOjRN2blqqMK8l1iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="55005642"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 06:36:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s7xks-00000008Lkv-21yz;
	Fri, 17 May 2024 16:36:14 +0300
Date: Fri, 17 May 2024 16:36:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Frank Li <Frank.Li@nxp.com>, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 0/5] PCI: controller: Move to agnostic GPIO API
Message-ID: <ZkddTpyC177ZGoMH@smile.fi.intel.com>
References: <20240506142142.4042810-1-andriy.shevchenko@linux.intel.com>
 <20240517102234.GA333779@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240517102234.GA333779@rocinante>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 17, 2024 at 07:22:34PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > While at it, remove of_gpio.h leftover from some of the drivers.
> 
> Applied to gpio, thank you!

Thank you!

-- 
With Best Regards,
Andy Shevchenko



