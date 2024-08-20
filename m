Return-Path: <linux-pci+bounces-11871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69650958499
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 12:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26652284E19
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 10:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08C218D646;
	Tue, 20 Aug 2024 10:32:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4677581F;
	Tue, 20 Aug 2024 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149952; cv=none; b=qa3lPxb6XLn8x4Rxy6Ogu3msWbxcM+zz810tcFkwOSTotukIwvM10vaZWHkk6ViMqDrDbP+ohquJmICVBj+kOHL/Q/hqj24ahTyNuHRS3meLfP0Lw50xEFhRnb8lm8BVlYObHtbtU6GJO65WqdA45Aju9syfxqUTR3Bpn8K7ifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149952; c=relaxed/simple;
	bh=lvkk7J36LjRCGB119bYJqgPFRlniQe5agdKkcWjCUcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlVMziyuKzksxEwOa+xWpB4FbWqfnG5fwYk6HTG81BqaPw7IbS+KfoSOm8u7C1uS6I4u3jRqIozDKq622lRm3zrlAVsWTcCvb+Lo2MnL3vSBV3RkVsMsZJM59LAu08MGGLI6wwKT4cfXmMlTynOYxzhJrabv/rsH9d7+jvnpNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 2dy3JasJS1GhUUHSGEoytw==
X-CSE-MsgGUID: iJ1Pfo9rQ36zDeQto52ScQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22324643"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22324643"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:32:30 -0700
X-CSE-ConnectionGUID: bgvkjWUKT6CGVtHoylpWSw==
X-CSE-MsgGUID: 3ydoSxXsQZCyk4cZEMBrXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="91458848"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:32:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sgM9w-0000000HGS5-2gMy;
	Tue, 20 Aug 2024 13:32:16 +0300
Date: Tue, 20 Aug 2024 13:32:16 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: onathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Hannes Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 6/9] ethernet: cavium: Replace deprecated PCI functions
Message-ID: <ZsRwsDWQT6dmwC1p@smile.fi.intel.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
 <20240819165148.58201-8-pstanner@redhat.com>
 <ZsONiNkdXGMKMbRL@smile.fi.intel.com>
 <5d70794731198ec7bc59bd95e50a8aa81cf97c7b.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d70794731198ec7bc59bd95e50a8aa81cf97c7b.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 20, 2024 at 09:40:09AM +0200, Philipp Stanner wrote:
> On Mon, 2024-08-19 at 21:23 +0300, Andy Shevchenko wrote:
> > On Mon, Aug 19, 2024 at 06:51:46PM +0200, Philipp Stanner wrote:

...

> > cavium_ptp_probe()
> > 
> > > -	pcim_iounmap_regions(pdev, 1 << PCI_PTP_BAR_NO);
> > > +	pcim_iounmap_region(pdev, PCI_PTP_BAR_NO);
> > >  
> > >  error_free:
> > >  	devm_kfree(dev, clock);
> > 
> > Both are questionable. Why do we need either of them?
> 
> You seem to criticize my pcim_iounmap_region() etc. in other unwind
> paths, too.

Yes, having devm/pcim/etc_m in the clean up / error paths seems at bare minimum
confusing, or reveals wrong use of them or even misunderstanding the concept...

And it's not your fault, it was already in those drivers like that...

> I think your criticism is often justified. This driver
> here, however, was the one which made me suspicious and hesitate and
> removing those calls; because of the code below:
> 
> 
> 	pcim_iounmap_region(pdev, PCI_PTP_BAR_NO);
> 
> error_free:
> 	devm_kfree(dev, clock);
> 
> error:
> 	/* For `cavium_ptp_get()` we need to differentiate between the case
> 	 * when the core has not tried to probe this device and the case when
> 	 * the probe failed.  In the later case we pretend that the
> 	 * initialization was successful and keep the error in
> 	 * `dev->driver_data`.
> 	 */
> 	pci_set_drvdata(pdev, ERR_PTR(err));
> 	return 0;
> }
> 
> So in case of an error they return 0 and do... stuff.
> 
> I don't want to touch that without someone who maintains (and, ideally,
> understands) the code details what's going on here.

Thanks for elaboration, indeed it was not enough context to see the full
picture. This seems like an ugly hack that has to be addressed at some point.
But again, not your fault.

-- 
With Best Regards,
Andy Shevchenko



