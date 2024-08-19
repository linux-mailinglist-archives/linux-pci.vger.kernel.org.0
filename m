Return-Path: <linux-pci+bounces-11839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5BE957376
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 20:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89CBB1C22EFF
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 18:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11951898F5;
	Mon, 19 Aug 2024 18:37:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3002C15278E;
	Mon, 19 Aug 2024 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092635; cv=none; b=guVOo2lqkhCqbUr5qeifEjmFdMNoGkxibTxIRPNJzYJIfKyKQbuUVon+5WMhHlP2sT02QkopuoJCfEbJ7Lr+qXN0qHxn4KifX74ZY91Da7vCUrkLW9oLG65WnRR4vcaXNAfBCm93l95Y49jCNrkXHHEPQcbh27bIOoFpefGlsdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092635; c=relaxed/simple;
	bh=IJJ/7NACcG6bgEk2zs2Z2/1SJph89bZtzQlJ3XACtcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLzUXysZJ/vEf/CsWY9hfaOxJ/HDi1RLguV/TuDarIwOPIPsbqJk35yoUrleF/FmeRAP9GPFZME/xvQmVAB1GRsf4UGzgFjflgxDyw/LART1j3a5GzZ3H5t+HpMbEkwRpevwperx5icFuIAfj1i8Bt5XhpFSUdrdMQjeoH75lNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: mV3q11aMTia14IbnxQZ9aQ==
X-CSE-MsgGUID: MofqpuNxQOmLpYRdH0aPLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22536728"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22536728"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 11:37:13 -0700
X-CSE-ConnectionGUID: RyFwEX5bROyf8abY2ZSm9w==
X-CSE-MsgGUID: +aUUQjLnRli3CXGq2n2fpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64851993"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 11:37:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sg7FU-0000000H2Uv-09RB;
	Mon, 19 Aug 2024 21:37:00 +0300
Date: Mon, 19 Aug 2024 21:36:59 +0300
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
Subject: Re: [PATCH 8/9] vdap: solidrun: Replace deprecated PCI functions
Message-ID: <ZsOQy5BVRVf16ryw@smile.fi.intel.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
 <20240819165148.58201-10-pstanner@redhat.com>
 <ZsOPnwQO8sppwI8u@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsOPnwQO8sppwI8u@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 19, 2024 at 09:32:00PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 19, 2024 at 06:51:48PM +0200, Philipp Stanner wrote:

...

> >  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> > +		if (pci_resource_len(pdev, i)) {

Btw, looking at this you may invert the conditional

	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
		if (!pci_resource_len(pdev, i))
			continue;

It might make patch neater.

> > +			psnet->bars[i] = pcim_iomap_region(pdev, i, name);
> > +			if (IS_ERR(psnet->bars[i])) {
> > +				SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
> > +				return PTR_ERR(psnet->bars[i]);
> > +			}
> > +		}

> >  
> 
> Blank line leftover.
> 
> >  	}

-- 
With Best Regards,
Andy Shevchenko



