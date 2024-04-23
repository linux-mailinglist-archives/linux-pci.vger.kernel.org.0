Return-Path: <linux-pci+bounces-6593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E43E8AF7C1
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 22:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7471C22568
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 20:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1463142633;
	Tue, 23 Apr 2024 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vr0T6OQ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F55313D522;
	Tue, 23 Apr 2024 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902653; cv=none; b=DIWiWmrOTie9KGaMNdeuY1AixJ2kdggdLfVGZMVheUI7nQenmt0Ezi/PRpSlpNiXMvZknU1jp0tMpocag3yMPwpu13UhdekvFZzhix2P9Ap/bXMgo+ugyU3mQ269JLISwvGAH48rjxRrHUKX1rssLdTg4JqqOJWzfEC8Dsjy7eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902653; c=relaxed/simple;
	bh=EUJ5LGU/8rzeyG4lTaZK13osGBD9kQIZNmjQSYrpH2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaMP0MdlYrcj2/GTQPcqhcCEVMN1ZaTdzZXk53XYW9KX4ec0M7sS0HZCqj1CeCgLB1a8aMrbO+3b2helUNPaUMUpr/hEozf4YJAQFjNyljAJ07FsNFeFDUXHIUcyiNUIwsjqYjTN5dCpMbt8jwz94VwJCab7Ks2lMZj0C0SVPYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vr0T6OQ3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713902652; x=1745438652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EUJ5LGU/8rzeyG4lTaZK13osGBD9kQIZNmjQSYrpH2Y=;
  b=Vr0T6OQ3t9Q3rilG0yB1otA8yMdchpBned0AKgc2oy19zJPGbjs3FV9N
   Z0E+vY2up6g10A7/ADe7xYzz1xJ2T8WiIOOM4NS4ChNtUDNcMAo7CBFb6
   0SqVZazvuMyeiDCN3iTFHJI35NSYdivqfzjt+WMgb99Auqg9iFRN2708v
   jiuWjGMjbTurqFXaiLdGICnAOM1fI181R+7pjTKhTyVZR+UtrbmgL5eBy
   znhnvrzXB2SISpT7xRvhl734OcjtYYE1UhLQvq9Xo9e4YHH6nOKshuy6h
   Zfg0quoIOyBQpcyGELhx9xpUEaU+xPvNjSMrsH0N7vHivRQ2Oge8gKgt/
   A==;
X-CSE-ConnectionGUID: uRlxaBQZRIKsIj5uXLCP8A==
X-CSE-MsgGUID: nEHKLC5HQ7Ky7qRpWAPAWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20121410"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20121410"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:04:11 -0700
X-CSE-ConnectionGUID: jm0sMGbqTauuhA2EjqiNlA==
X-CSE-MsgGUID: 4AudXI+ZSV+tSzYw/JyrDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29124283"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:04:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzMMy-00000000SbY-00GQ;
	Tue, 23 Apr 2024 23:04:00 +0300
Date: Tue, 23 Apr 2024 23:03:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
Subject: Re: [PATCH v2 3/4] PCI: imx6: Convert to agnostic GPIO API
Message-ID: <ZigUL7exXBSbWDIR@smile.fi.intel.com>
References: <20240423172208.2723892-1-andriy.shevchenko@linux.intel.com>
 <20240423172208.2723892-4-andriy.shevchenko@linux.intel.com>
 <ZigSiCBIwoEIPYoG@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZigSiCBIwoEIPYoG@lizhi-Precision-Tower-5810>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 03:56:56PM -0400, Frank Li wrote:
> On Tue, Apr 23, 2024 at 08:19:06PM +0300, Andy Shevchenko wrote:

...

> > +	imx6_pcie->reset_gpiod =
> > +		devm_gpiod_get_optional(dev, "reset",
> > +			imx6_pcie->gpio_active_high ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
> > +	if (IS_ERR(imx6_pcie->reset_gpiod))
> > +		return dev_err_probe(dev, PTR_ERR(imx6_pcie->reset_gpiod),
> > +				     "unable to get reset gpio\n");
> 
> Small problem here. err message "unable to get reset gpio\n" will print
> when -EPROBE_DEFER happen. EPROBE_DEFER is quite common when use i2c
> expand gpio chip.

I'm not sure how you come to this conclusion. Can you elaborate, please?
P.S> I do not see a problem as described.

-- 
With Best Regards,
Andy Shevchenko



