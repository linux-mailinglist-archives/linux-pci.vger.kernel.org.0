Return-Path: <linux-pci+bounces-11830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B1E9572A0
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 20:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557781C23392
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 18:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD55D189505;
	Mon, 19 Aug 2024 18:04:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199D317C98C;
	Mon, 19 Aug 2024 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724090699; cv=none; b=lDbA0Tp6Z1QaGYjRBTBWka/By3N5N3LbY6LwOKvBDS11cNd58x4k37IDH5zMmIawDJgPXOC+95v7NgBFIZCUcEMFxE620f/BddCUORxRJWn0+8UChf5OVGWck+a9NC3IwhBZM7aJa737Er43oTu6GLnFbmOuJ96ut3nal46Xj74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724090699; c=relaxed/simple;
	bh=uhcHWPb2xTrhdnPGHS3qLJd7wXvBdsT9BOPncAM9mUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiZukWVtTfbcMPii5WtDPtyHgSdq2I9SZ/AidVR1XzPRnbswybQH4q4/wgjKnvd6/zM35xay4J/+msOdVF/Q5gSbWUAsaJBugmwwDw7nhFgAKv/m4csEhPJG92+o69jGUxFqWLow3tTB4VJAbR7UVMX8YwMBRfKrfznrmYGuWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: pZ8XfnpBRge2m6Qh8H1BJA==
X-CSE-MsgGUID: Km54+G1dQjuHHcanrzTuSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22533078"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22533078"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 11:04:54 -0700
X-CSE-ConnectionGUID: tSCzEHZcRx6b1ETz2cciBg==
X-CSE-MsgGUID: kxzUu48nQpaoQdK3Fh2GyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="91187343"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 11:04:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sg6kC-0000000H1wA-3FW0;
	Mon, 19 Aug 2024 21:04:40 +0300
Date: Mon, 19 Aug 2024 21:04:40 +0300
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
Message-ID: <ZsOJONEA2x93bSpO@smile.fi.intel.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
 <20240819165148.58201-6-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240819165148.58201-6-pstanner@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 19, 2024 at 06:51:44PM +0200, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> In mtip32xx, these functions can easily be replaced by their respective
> successors, pcim_request_region() and pcim_iomap(). Moreover, the
> driver's call to pcim_iounmap_regions() is not necessary, because it's
> invoked in the remove() function. Cleanup can, hence, be performed by
> PCI devres automatically.
> 
> Replace pcim_iomap_regions() and pcim_iomap_table().
> 
> Remove the call to pcim_iounmap_regions().

...

int mtip_pci_probe()

>  setmask_err:
> -	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
> +	pcim_release_region(pdev, MTIP_ABAR);

But why?

...

mtip_pci_remove()

>  	pci_disable_msi(pdev);
>  
> -	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);

This is okay.

...

>  	pci_set_drvdata(pdev, NULL);

Side note: This is done by driver core for the last 10+ years…

-- 
With Best Regards,
Andy Shevchenko



