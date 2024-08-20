Return-Path: <linux-pci+bounces-11874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CAE9584B9
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 12:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25771C232C9
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 10:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C101318DF6F;
	Tue, 20 Aug 2024 10:37:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEA718D63C;
	Tue, 20 Aug 2024 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150264; cv=none; b=GkPBeJ3g/uOP3PF3EgPQWSaIZ9vKVszEcqDHH+7nJf0Xa7d3wqbmELedHABo5VzRd/WAavAmNS6h7zKIvsCSk3MNrPFDKBrR9jN/EAwk35e0v79juZeWr9TCHoEKuEgIK3r2CX6EJq3OEWqv1ccQOaDJxDGJaCxRr8q/bSkcDus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150264; c=relaxed/simple;
	bh=BiM4kMQSNEJETUXiJ+hSIuDZviDrLdvpvTm9Yc3dcAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFnqXOWIYI+ZLdRq4PmtdePSZ9ba3o75FekiJMnd9i/cSPR2ajwLAJ8//UkhS0c3Dq2f3iE2VpTksY65kk/3pXqrLdwaPr4ypxATvQKLGiJcbS+9Mos6G7QJk8SHtt4Nw5yRpbMUAfFPX6Z00or94h//lgxNuLuq9EdySZNge0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 9zdztoD5Tm6xpX5GchjYMA==
X-CSE-MsgGUID: Wj2Dp5apRsCr0CGlIvz8MA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26307087"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="26307087"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:37:42 -0700
X-CSE-ConnectionGUID: nWFywAqfTeSsKI2HcF+BTA==
X-CSE-MsgGUID: LFqzb9g/TbCg/PzI2I/nxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60665629"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:37:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sgMEy-0000000HGXR-3q0A;
	Tue, 20 Aug 2024 13:37:28 +0300
Date: Tue, 20 Aug 2024 13:37:28 +0300
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
Message-ID: <ZsRx6OyqHPL0ws0e@smile.fi.intel.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
 <20240819165148.58201-9-pstanner@redhat.com>
 <ZsOO2uuGmD97Mocj@smile.fi.intel.com>
 <ef48369d230ef1912da157e7b437040bece6b5f4.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef48369d230ef1912da157e7b437040bece6b5f4.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 20, 2024 at 09:52:40AM +0200, Philipp Stanner wrote:
> On Mon, 2024-08-19 at 21:28 +0300, Andy Shevchenko wrote:
> > On Mon, Aug 19, 2024 at 06:51:47PM +0200, Philipp Stanner wrote:

...

> > loongson_dwmac_probe()
> > 
> > > +	memset(&res, 0, sizeof(res));
> > > +	res.addr = pcim_iomap_region(pdev, 0, pci_name(pdev));
> > > +	if (IS_ERR(res.addr)) {
> > > +		ret = PTR_ERR(res.addr);
> > > +		goto err_disable_device;
> > 
> > It seems your series reveals issues in the error paths of .probe():s
> > in many drivers...
> > 
> > If we use pcim variant to enable device, why do we need to explicitly
> > disable it?
> 
> No.

Can you elaborate? No issues being revealed, or no need to disable it
explicitly, or...?

> > >  	}

...

> > loongson_dwmac_remove()
> > 
> > >  	pci_disable_msi(pdev);
> > >  	pci_disable_device(pdev);
> > 
> > Not sure why we need these either...
> 
> It's complicated.
> 
> The code uses pciM_enable_device(), but here in remove
> pci_disable_device().
> 
> pcim_enable_device() sets up a disable callback which only calls
> pci_disable_device() if pcim_pin_device() has not been called.
> 
> This code doesn't seem to call pcim_pin_device(), so I think
> pci_disable_device() could be removed.
> 
> 
> I definitely would not feel confident touching pci_disable_msi(),
> though. The AFAIK biggest problem remaining in PCI devres is that the
> MSI code base implicitly calls into devres, see here [1]

But isn't it a busyness of PCI core to call pci_disable_msi() at the right
moment? Okay, I admit that there might be devices that require a special
workflow WRT MSI, is this the case here?

> [1] https://lore.kernel.org/all/ee44ea7ac760e73edad3f20b30b4d2fff66c1a85.camel@redhat.com/

-- 
With Best Regards,
Andy Shevchenko



