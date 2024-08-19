Return-Path: <linux-pci+bounces-11836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D4D957364
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 20:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936451F2229A
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 18:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9356D1898EF;
	Mon, 19 Aug 2024 18:34:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E183A187859;
	Mon, 19 Aug 2024 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092491; cv=none; b=MRzmlLtUnPQz75c30UdOxj+hvLqYShdsPweGoprBvSRFwO4yIuX2+xGzkRTjisuv/CYjuhG+r1JxQS+V1fml7Mufbp3MLS3B2tH4TQYio0qUyOm2W7TeJzDkbnXY0HR9aU20AgRiErCDENokw8ymfGpwFXEg+OirEbkGr2v7oUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092491; c=relaxed/simple;
	bh=GuMlA90NQAu4M2qW5V+1aRrdJOdxFtzBbySVfiE0gnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLQxGKjdrKWIpn97+d4TaI8AsT6DyyoddQxpwZA7GgQauzut6WZtHrkbyl5YyTUiH2mjO542BYAIgXLSCT6PwIdiCAhAboJ1ThGy6Wy+amw/Ua/fROa80Fm+DzualS9hGKehNZr1CGaA9QD4WTYPjzDPUNCYRVORMPptqd16gRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: a2qk4upyQ1u5xGdFIQGJDg==
X-CSE-MsgGUID: V+KtM0k5SbKKc4i+n24LlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33775991"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="33775991"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 11:34:49 -0700
X-CSE-ConnectionGUID: 5FtwFPEET8aOxXDZI/74iw==
X-CSE-MsgGUID: 6Xvndym9QEafUJ88JEQXcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64640739"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 11:34:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sg7DC-0000000H2SS-0eRd;
	Mon, 19 Aug 2024 21:34:38 +0300
Date: Mon, 19 Aug 2024 21:34:37 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Philipp Stanner <pstanner@redhat.com>, onathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
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
	Mark Brown <broonie@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 8/9] vdap: solidrun: Replace deprecated PCI functions
Message-ID: <ZsOQPbVGQFtUYSww@smile.fi.intel.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
 <20240819165148.58201-10-pstanner@redhat.com>
 <74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 19, 2024 at 08:19:28PM +0200, Christophe JAILLET wrote:
> Le 19/08/2024 à 18:51, Philipp Stanner a écrit :


...

> Unrelated to the patch, but is is safe to have 'name' be on the stack?
> 
> pcim_iomap_region()
> --> __pcim_request_region()
> --> __pcim_request_region_range()
> --> request_region() or __request_mem_region()
> --> __request_region()
> --> __request_region_locked()
> --> res->name = name;
> 
> So an address on the stack ends in the 'name' field of a "struct resource".
> 
> According to a few grep, it looks really unusual.
> 
> I don't know if it is used, but it looks strange to me.

It might be used when printing /proc/iomem, but I don't remember by heart.

> If it is an issue, it was apparently already there before this patch.

This series seems to reveal a lot of issues with the probe/remove in many
drivers. I think it's better to make fixes of them before this series for
the sake of easier backporting.

If here is a problem, the devm_kasprintf() should be used.

-- 
With Best Regards,
Andy Shevchenko



