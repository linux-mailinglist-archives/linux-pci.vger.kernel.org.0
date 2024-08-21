Return-Path: <linux-pci+bounces-11945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC11A959B37
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 14:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA752B28821
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 12:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BBD199FC9;
	Wed, 21 Aug 2024 11:55:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D355A199FB3;
	Wed, 21 Aug 2024 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724241353; cv=none; b=BqsNsOEBoYSiXCXhhrV0k5diI3MlcsC0PC2xkfzjzAxO500LhnhonEDhkk3KIDPKcZ58Kk69aPiHXJUuhZEdD+qm3LwfRu2HIw0emWZc/Lzv1pTiobuLUWskEhUk0K14TBRjIQUbcBj9DiJkRQuasOWqt05/G3JXJXNpBmQzb/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724241353; c=relaxed/simple;
	bh=FOEYXw+MnaiZcb7e8v6V3s3UWS0YzfSHaV4+tYzJ1HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZOkhI41fsn4BvxyAv7WXKkQKm01A/W7VXuIumus1IjUFg2oiPbKkMOkXsLHSv/Q3UejZSL1wf0nHaX1AORxbSrRtzV0/mDVJPR/s86mshvQAP9TvIf5a/Ni+Q49h/WVWq5JCzjmPzoS5N6TrdR7I5pzdQYH8UsyC1kiLDdHW58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: jt8pRzARTIeOkyRSgZ48+g==
X-CSE-MsgGUID: UTjcuLwzTKuf1Y4LQBhu/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="26463238"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="26463238"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 04:55:50 -0700
X-CSE-ConnectionGUID: HStPPOxdS8Ck/2Tx3xAuhg==
X-CSE-MsgGUID: Jz531zfFTbKXF2EHryWZDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65758961"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 04:55:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1sgjwA-000000003O8-2q1s;
	Wed, 21 Aug 2024 14:55:38 +0300
Date: Wed, 21 Aug 2024 14:55:38 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
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
	Keith Busch <kbusch@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v2 6/9] ethernet: stmicro: Simplify PCI devres usage
Message-ID: <ZsXVuq2jthHoTHPO@smile.fi.intel.com>
References: <20240821071842.8591-2-pstanner@redhat.com>
 <20240821071842.8591-8-pstanner@redhat.com>
 <CAHp75VduuT=VLtXS+zha4ZNe3ZvBV-jgZpn2oP4WkzDdt6Pnog@mail.gmail.com>
 <be1c2f6fb63542ccdcb599956145575293625c37.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be1c2f6fb63542ccdcb599956145575293625c37.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 21, 2024 at 11:36:36AM +0200, Philipp Stanner wrote:
> On Wed, 2024-08-21 at 11:14 +0300, Andy Shevchenko wrote:
> > On Wed, Aug 21, 2024 at 10:19 AM Philipp Stanner
> > <pstanner@redhat.com> wrote:

...

> > > -       for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> > > -               if (pci_resource_len(pdev, i) == 0)
> > > -                       continue;
> > > -               pcim_iounmap_regions(pdev, BIT(i));
> > 
> > Here is the BARx, which contradicts the probe :-)
> 
> I'm not sure what should be done about it. The only interesting
> question is whether the other code with pcim_iomap_regions(... BIT(i)
> does also only grap BAR 0.
> In that case the driver wouldn't even be knowing what its own hardware
> is / does, though.

I think your patch does the right thing already.

> > > -               break;
> > > -       }

-- 
With Best Regards,
Andy Shevchenko



