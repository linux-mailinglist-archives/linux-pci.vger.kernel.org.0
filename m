Return-Path: <linux-pci+bounces-12021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F297195B8FD
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 16:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22991F268D0
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 14:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681881CC15B;
	Thu, 22 Aug 2024 14:49:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEDD1CB330;
	Thu, 22 Aug 2024 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724338196; cv=none; b=e7QHc/D7KZeiF4u8q4Tmexv9Q5Mp743BDi4EF7lJtTG26pSFhtHiDl7QxS60IYW1Y3azHKdIcAzub9kFgrjlMc29m4/3MFqvCK4RbAqNEa46bsWsvWE/gQpenJMdOTC1W/QYOFUgXFDOa88zlwLy7u8cS8/hleCRtIIrKGTaOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724338196; c=relaxed/simple;
	bh=yCgKpkfnhk4y7/fJ0zqFdzcBZCs/lTfZEG6IYNfdqgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgA5Lpt1iff6tu5ChMn5XucDfEuT5iWXe4bJXMGP9ko9w/jEQwD2RJ+9cGfqPNQlkAnXqlMLw2HQkTHj2GNt7etz+a8pokF2P8fYcWD7jd2M022dDIoOwcjwYmydlclkjNJOa+3AgNPZBKjBQWSXXdZDPXVZ8ad5wWgcK3X7/rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: JtyZWNNeQZuD3/gXcsFKaQ==
X-CSE-MsgGUID: +LVTpM9/R6yTIpHsbW7Oxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22941194"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="22941194"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 07:49:54 -0700
X-CSE-ConnectionGUID: y0FDeu5LQeO4Qzbust16qg==
X-CSE-MsgGUID: YMGGdoIlTGS26ZTcm+ckPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="66149796"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 07:49:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sh97e-00000000U8h-0kBa;
	Thu, 22 Aug 2024 17:49:10 +0300
Date: Thu, 22 Aug 2024 17:49:09 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
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
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v3 8/9] vdap: solidrun: Replace deprecated PCI functions
Message-ID: <ZsdP5ejfb2AH3nRW@smile.fi.intel.com>
References: <20240822134744.44919-1-pstanner@redhat.com>
 <20240822134744.44919-9-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822134744.44919-9-pstanner@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 22, 2024 at 03:47:40PM +0200, Philipp Stanner wrote:
> solidrun utilizes pcim_iomap_regions(), which has been deprecated by the
> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()"), among other
> things because it forces usage of quite a complicated bitmask mechanism.
> The bitmask handling code can entirely be removed by replacing
> pcim_iomap_regions() and pcim_iomap_table().
> 
> Replace pcim_iomap_regions() and pcim_iomap_table() with
> pcim_iomap_region().

...

>  	/* Request and map BAR */
> -	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
> -	if (ret) {
> +	snet->bar = pcim_iomap_region(pdev, snet->psnet->cfg.vf_bar, name);

PTR_ERR_OR_ZERO() ?

> +	if (IS_ERR(snet->bar)) {
>  		SNET_ERR(pdev, "Failed to request and map PCI BAR for a VF\n");
> -		return ret;
> +		return PTR_ERR(snet->bar);
>  	}

-- 
With Best Regards,
Andy Shevchenko



