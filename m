Return-Path: <linux-pci+bounces-14634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AD59A078E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 12:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0441F28EF1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 10:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A97206970;
	Wed, 16 Oct 2024 10:38:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939421DE3C9;
	Wed, 16 Oct 2024 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075099; cv=none; b=RD8ADKSLQxntoMwjlHVBlJu+stFHvR0KFTxq0lDy32/TpbrJzqFGkbOO9mzRT2nPVKMvKtvwLng5w6XuTeauX8oSTk3eNI6+DrXzGNVK1auldAi8m/H5MhuHrrU+CvJTPfndDp1sxaQ0XBBybwlj1AMWTKGjRgDlZI4+4T1BwoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075099; c=relaxed/simple;
	bh=0KzIclti6ghVRdDUnJmtsgvuMFVRjttfAfgAqkgstVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vxxv4BpEIUqxUYJJbtwkaWYSqEB4nKGyW6cR+fyNWRn1GQGr8gmP9CeaBFwOaES5yWIzE31/8eRVPOrClLGMCF0Zx/DAX/pmBFKocFTnHyWaGOrKGFR/wifKoBVCtOpbZLJBAoE4Yqs0v31S1jkPlvDfxObL5nw3AkW/kXCKTiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: UUk5fotKSROtlfsojQ/+RA==
X-CSE-MsgGUID: 3WHW+dFuT9WXzXGt0luxYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="31380903"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="31380903"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:38:17 -0700
X-CSE-ConnectionGUID: TPK2QQGoTzCKrKULTJkyPQ==
X-CSE-MsgGUID: Mr+ZtVIFT7WZBCYpV/jgYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82150795"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:38:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1t11Ps-00000003iuL-1qo4;
	Wed, 16 Oct 2024 13:38:08 +0300
Date: Wed, 16 Oct 2024 13:38:08 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Li Zetao <lizetao1@huawei.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 2/6] PCI: Deprecate pcim_iounmap_regions()
Message-ID: <Zw-XkFcaXjlF5az0@smile.fi.intel.com>
References: <20241016094911.24818-2-pstanner@redhat.com>
 <20241016094911.24818-4-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016094911.24818-4-pstanner@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 16, 2024 at 11:49:05AM +0200, Philipp Stanner wrote:
> pcim_ionumap_region() has recently been made a public function and does
> not have the disadvantage of having to deal with the legacy iomap table,
> as pcim_iounmap_regions() does.
> 
> Deprecate pcim_iounmap_regions().

...

> + * This function is DEPRECATED. Do not use it in new code.

Interestingly that the syntax of the DEPRECATED is not documented (yet?),
however the sphinx parser hints us about **DEPRECATED** format — see
Documentation/sphinx/parse-headers.pl:251. In any case the above seems
like second used (in a form of the full sentence) and will be updated
in accordance with the above mentioned script.

-- 
With Best Regards,
Andy Shevchenko



