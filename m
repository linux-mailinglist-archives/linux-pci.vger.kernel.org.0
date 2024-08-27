Return-Path: <linux-pci+bounces-12233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CD295FFD1
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 05:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98260B2176A
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 03:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3AC1B977;
	Tue, 27 Aug 2024 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXJl1j/A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DC9199BC;
	Tue, 27 Aug 2024 03:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724729495; cv=none; b=pTRiacEWFCOzwwcjg2sonbdunYoyx8cb86rTcuuRFZ07derQtxr3FqG5g9S9wMT7Ns1k81FTLvHHQkoeKoPiVYd678vfFZ2SLzQG2a/OfIP8Gc3/rLmUKP+cEdJmnO8fKut1kLzWwGkqbG9lYOGhrl5lja6dzn/EGJEwvRPPgeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724729495; c=relaxed/simple;
	bh=ZsAX6fYNBN8s4cM6prV7+Nw4KR6G6zRcui+vpWCXiiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8KwqSUTeDlG+sKSDBnVKCOjj9tPDr6vNiEuvIYximkZjNp3Ob4nCZOVxw4TOgMMoHl9d2zAzfbRg9o0OjWUfR0Oi42GDYIBDskuWqDjRipxQvnImc7pAQUPmhUAzF+qGzvBk1t6qTCOy16qNq5R2ZqZ/yxl4LIAErb5wGNLLFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXJl1j/A; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724729492; x=1756265492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZsAX6fYNBN8s4cM6prV7+Nw4KR6G6zRcui+vpWCXiiM=;
  b=FXJl1j/AyNRlQ0Km+tpPSaeXKtVgDT3lDNvXqNlbwOQdHImGWzHSyKke
   bqz17w95kcG1tC0Af6f67Dlm8yMfHIdILGlrTX3ovKVa5pQ+66zPo+Hj5
   gjNlqzGc9ZvTuDfDs+VGIPURzrWGByAq1N2Kq0IXCMK7rpn4JRghg8aRG
   Rth7SNULAidyorGbn2sHqXGYlAuvlib4TnhW8Ogo0JLuwL7ijqB3ouX0k
   dWRIergQTl41uO5gL3h5f0GQRSl46/JcuM3FaDBGsIAk/LJOuSU3t9td1
   MAsLUiCfwg/EmJQQFKls+ertCa5P+Cr0tdpq7MsPZN2Jrs4VT1Kh6gYvu
   w==;
X-CSE-ConnectionGUID: U0VsYO+CQ5mT+4pCIfODow==
X-CSE-MsgGUID: UI3+y8WLQ4i8nk9v/4WsOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23154137"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="23154137"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 20:31:30 -0700
X-CSE-ConnectionGUID: QDU5QLH3TqucnA37kaonFw==
X-CSE-MsgGUID: w9+02ioqSw6jKQ/o9ovjaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="62698679"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 26 Aug 2024 20:31:22 -0700
Date: Tue, 27 Aug 2024 11:28:59 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
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
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v3 2/9] fpga/dfl-pci.c: Replace deprecated PCI functions
Message-ID: <Zs1H+zgzZAuLUnza@yilunxu-OptiPlex-7050>
References: <20240822134744.44919-1-pstanner@redhat.com>
 <20240822134744.44919-3-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822134744.44919-3-pstanner@redhat.com>

On Thu, Aug 22, 2024 at 03:47:34PM +0200, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> Port dfl-pci.c to the successor, pcim_iomap_region().
> 
> Consistently, replace pcim_iounmap_regions() with pcim_iounmap_region().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Thanks.

