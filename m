Return-Path: <linux-pci+bounces-7110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7786C8BCDE3
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 14:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A622A1C237B7
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BD8143C51;
	Mon,  6 May 2024 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCvgzkq2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238D0143C44;
	Mon,  6 May 2024 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714998368; cv=none; b=Q002/L4pmiYx997PeZVbZjPnUm/aFVmisAjm4LDa/NBpSLWrLhIJHWiHWhZSGaB5EdjqiFDGyYv+kASaFwq4d7uft63vosPuw80+BVN4W0ak0iMVzb4H1fZb3nKRvSqeDAVHOPtYCMYbA2PrG5n9NnAbSnmgg3svNWbGy72MT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714998368; c=relaxed/simple;
	bh=yim39yRqN4bdpfi/yZPkyOfIHeiJsr3OoFhecZ7dSX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxROAHW2OjO7yC5130xPZBiVPJ6PmvkTPpp28aDbW2AYZRTMLuzFolOZ80dJil5pij4eAQGG3mDH6Gxc4uZ8Djgi6xS8WF27BSz1Pkg/1LL6TLFxSIbdWMFLsjCFhr6pZVNxROAgN0YErn20JEM1SLIKRTITCBtumUiVANxodbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCvgzkq2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714998366; x=1746534366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yim39yRqN4bdpfi/yZPkyOfIHeiJsr3OoFhecZ7dSX8=;
  b=ZCvgzkq2FrVYthP2jVKlAfB01bIBcwCDZcUWMke/J9PPTn6+3MnqV9hO
   zeBEoBCM0LvLVsocgxvSzx3CDR4P2JtEbBazL/Hu0RqutrTH1wrMKQyat
   anxDzndHigUmTiiaYQCx59a0PWm6Hx36Vt1qVeZJwsUZ5CeBEIP4hkYxS
   Q9aV/IKi2P7es8Rtx7aqWAyW4vS53IQYbkrR4dB9RHDefxmY39wVtNNGR
   pBR2ikBAjU2vDERWBgVHryGU0LBr4SOreplQKoQ8ICLlfu9iN5oVILQvg
   kZaitMf1A+RPr5OC9/mOM/l7YePioDeTqMU7yGU/2VWcObQTUQL7gvRhp
   w==;
X-CSE-ConnectionGUID: 8A2f7UADSgi9LQWnGahorA==
X-CSE-MsgGUID: uUZbPi9UQYe73UyGMy/jXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="21352626"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="21352626"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 05:26:05 -0700
X-CSE-ConnectionGUID: i/6U48ZHSka9s8R3PJyNXw==
X-CSE-MsgGUID: UQissWGdTaOeNacEhtYQ9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28116539"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 05:25:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s3xPl-00000004gZr-3aNZ;
	Mon, 06 May 2024 15:25:53 +0300
Date: Mon, 6 May 2024 15:25:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
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
Subject: Re: [PATCH v3 4/5] PCI: imx6: Convert to agnostic GPIO API
Message-ID: <ZjjMUSj3cZTI56wE@smile.fi.intel.com>
References: <20240429102510.2665280-1-andriy.shevchenko@linux.intel.com>
 <20240429102510.2665280-5-andriy.shevchenko@linux.intel.com>
 <CACRpkdZUsA034L5GjF_-XELX9369PwNjONfsDV-_EC564R0QWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZUsA034L5GjF_-XELX9369PwNjONfsDV-_EC564R0QWg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 06, 2024 at 02:10:24PM +0200, Linus Walleij wrote:
> On Mon, Apr 29, 2024 at 12:25 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > The of_gpio.h is going to be removed. In preparation of that convert
> > the driver to the agnostic API.
> >
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I think there is a bug here, the code is respecting the OF property
> "reset-gpio-active-high"
> but the code in drivers/gpio/gpiolib-of.h actually has a quirk for
> this so you can just
> delete all the active high handling and rely on 1 = asserted and 0 =
> deasserted when
> using GPIO descriptors.
> 
> Just delete this thing:
> imx6_pcie->gpio_active_high = of_property_read_bool(node,
>                                            "reset-gpio-active-high");

Good catch! Thank you, I'll update it in the next version. Can you review
the rest meanwhile?

-- 
With Best Regards,
Andy Shevchenko



