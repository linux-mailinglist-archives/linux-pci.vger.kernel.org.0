Return-Path: <linux-pci+bounces-11870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A72E8958475
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 12:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2181C2017B
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 10:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16D018CBE2;
	Tue, 20 Aug 2024 10:28:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E0E7581F;
	Tue, 20 Aug 2024 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149713; cv=none; b=qUwxUOO6YqmqE4zfVmiVrIfwl7sFLX5i4h/w+gWUuu8TuIo913vCVN+ArjS8LahKLkMYzsjNLKXoPC36n09FRUI1iGjLWISq4L+szMad3Zpy1n7XAy4ZGeTDZUWPTneHNzLsocPW5p4Li4336Zd/xY/Vf3SKjlnG1ziO7150m4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149713; c=relaxed/simple;
	bh=O5k60SiozUItOe57/Mfcp/M4CbNdahVcbyT/Wm67rEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9gDwZHGHVtGUPm/N0fKMwl7hnU+j24r5Gw4YaXnMV6KU/gEQ5xfC+caWQCH3xvJj9U2fDQffnw8iMofV4CbiAUuUoo4rN0eSGG/e2XRBb8tBs7rpBrY4U4l8oDVc9qD25/CzP4iE+eRZNAYIZ7g9Wo2+115J7VmMIDoA9fPmGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: SJHUM3mGQFGy0SMvf5/nCg==
X-CSE-MsgGUID: kT+KZVUQR0W9gpqzwdmEBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26306108"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="26306108"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:28:31 -0700
X-CSE-ConnectionGUID: i2TeOzYIRg25kacmae/h/Q==
X-CSE-MsgGUID: FG1tjdHOT4uS3xW62Fnj5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60664479"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:28:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sgM65-0000000HGOZ-3tRE;
	Tue, 20 Aug 2024 13:28:17 +0300
Date: Tue, 20 Aug 2024 13:28:17 +0300
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
Subject: Re: [PATCH 4/9] block: mtip32xx: Replace deprecated PCI functions
Message-ID: <ZsRvwVCzpLEQovmU@smile.fi.intel.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
 <20240819165148.58201-6-pstanner@redhat.com>
 <ZsOJONEA2x93bSpO@smile.fi.intel.com>
 <e406ba06180571564b47872f090623b19e4ad87e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e406ba06180571564b47872f090623b19e4ad87e.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 20, 2024 at 09:29:52AM +0200, Philipp Stanner wrote:
> On Mon, 2024-08-19 at 21:04 +0300, Andy Shevchenko wrote:
> > On Mon, Aug 19, 2024 at 06:51:44PM +0200, Philipp Stanner wrote:

...

> > int mtip_pci_probe()
> > 
> > >  setmask_err:
> > > -	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
> > > +	pcim_release_region(pdev, MTIP_ABAR);
> > 
> > But why?
> 
> EMOREINFOREQUIRED
> Why I replace it or why I don't remove it completely?

The latter one: Why did you leave it and not remove?

...

> > mtip_pci_remove()
> > 
> > >  	pci_disable_msi(pdev);
> > >  
> > > -	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
> > 
> > This is okay.
> 
> Removing it is okay, you mean.

Yes!

...

> > >  	pci_set_drvdata(pdev, NULL);
> > 
> > Side note: This is done by driver core for the last 10+ years…
> 
> Ah you know Andy, kernel programmers be like: "When you're hunting you
> better make sure the wild sow is really dead before you load it in your
> trunk" ;p

Indeed, I had been told many times myself to improve / cleanup things unrelated
to the working area before actually considering my little work...

But, I specifically mark it as a "Side note:", so it's up to you to address
or not.

-- 
With Best Regards,
Andy Shevchenko



