Return-Path: <linux-pci+bounces-11834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326FF95733C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 20:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EFD285803
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 18:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82C61898EF;
	Mon, 19 Aug 2024 18:28:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D0C18950C;
	Mon, 19 Aug 2024 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092138; cv=none; b=PNuPTKUcuaKYtBmL6mvrMyTGRa6QDlo2xMYSSKBlDORnky748QkgSK7qwsX/SPStZ9K9bATYJ4O7yLdy3MkvzPcJjSz/JZE8PLXEd6kvW+eHFlq7lCrFlPTOn2PfLXkED7rZp2g3A1xtHJ2RmBPGB0f6nji4UY5RXniH+x2YV/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092138; c=relaxed/simple;
	bh=3OpP+bqhJVDHcSAxWOKFA44A8FB0Ov6BwD42gecA730=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPMAsXIPNn4XiVzByTs7Oylv/tcfhc3L9OQg/uDhaI92/NhB/2IXAEIDfXPdSdz6bZan4T8+sHejSOBMiLouxCYuvtnQIhGuC0lJ1gguvATAdaRpkSzf707cAK6PV107U4di/cXjrLW0lNAuAaiVACr7AU7+TMZmYBjo6KGJYHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 7YV4mK3NRiCET6IxkR2q6A==
X-CSE-MsgGUID: 3oM5lze7RRC6ztkkgUoXZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22203761"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22203761"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 11:28:56 -0700
X-CSE-ConnectionGUID: UAbUuDuoSZiYgbMBfvamlQ==
X-CSE-MsgGUID: 2DCcbPAkTEGqJBxULC2sWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="61024672"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 11:28:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sg77S-0000000H2MX-2AEd;
	Mon, 19 Aug 2024 21:28:42 +0300
Date: Mon, 19 Aug 2024 21:28:42 +0300
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
Subject: Re: [PATCH 7/9] ethernet: stmicro: Simplify PCI devres usage
Message-ID: <ZsOO2uuGmD97Mocj@smile.fi.intel.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
 <20240819165148.58201-9-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819165148.58201-9-pstanner@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 19, 2024 at 06:51:47PM +0200, Philipp Stanner wrote:
> stmicro uses PCI devres in the wrong way. Resources requested
> through pcim_* functions don't need to be cleaned up manually in the
> remove() callback or in the error unwind path of a probe() function.
> 
> Moreover, there is an unnecessary loop which only requests and ioremaps
> BAR 0, but iterates over all BARs nevertheless.
> 
> Furthermore, pcim_iomap_regions() and pcim_iomap_table() have been
> deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> Replace these functions with pcim_iomap_region().
> 
> Remove the unnecessary manual pcim_* cleanup calls.
> 
> Remove the unnecessary loop over all BARs.

...

loongson_dwmac_probe()

> +	memset(&res, 0, sizeof(res));
> +	res.addr = pcim_iomap_region(pdev, 0, pci_name(pdev));
> +	if (IS_ERR(res.addr)) {
> +		ret = PTR_ERR(res.addr);
> +		goto err_disable_device;

It seems your series reveals issues in the error paths of .probe():s
in many drivers...

If we use pcim variant to enable device, why do we need to explicitly
disable it?

>  	}

...

loongson_dwmac_remove()

>  	pci_disable_msi(pdev);
>  	pci_disable_device(pdev);

Not sure why we need these either...

-- 
With Best Regards,
Andy Shevchenko



