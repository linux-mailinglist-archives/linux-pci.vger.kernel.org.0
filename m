Return-Path: <linux-pci+bounces-14854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C469A3E84
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 14:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08129B21A6E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 12:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57A418028;
	Fri, 18 Oct 2024 12:36:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD9C3207;
	Fri, 18 Oct 2024 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255006; cv=none; b=n+d3zUfsULLGiJFt0Jyr1FfEbbkpuU47CB5HeYVbVSp9kZiJKW5dB52izR1d2o3p/1OXZ3dFRmskk352Kev8/RpWWfJXRIwl33CmeIk+HW6onrxT+ZynEtFbfGr/REio3CXiOPcTwgeSY/31QDhpfIVtrnAU+SDm1QJW+nMMPmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255006; c=relaxed/simple;
	bh=tyMewtQqpHxg4qbfOy5HqA9327malShWrnPYHfuO2vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/jnKojaQEjhdZ/dbrb9d/GchnYJJJw6g0bQTaJq9dbjPoeDN1Q1T+tJrIu4n8xVUa3WhUJ/QEb2D/8rF1M/Cn3oIyg7wxjThN8X80+QMaGyxTT1ZiWlKbwq9443LC/rUnC91mKQTvGfmPKEI2k0ctFApUDN058gDswlTV7Wkho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 0cXE/RMeS8il+576EWH2vg==
X-CSE-MsgGUID: r0T/vuPmQYqRHeav2DZvew==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39326594"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39326594"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:36:45 -0700
X-CSE-ConnectionGUID: m9kwGWSOS+q+2j/CwHgoLQ==
X-CSE-MsgGUID: Ks+uPRRJR+C757twukfZZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="79663802"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:36:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1t1mDa-00000004Sex-2cSq;
	Fri, 18 Oct 2024 15:36:34 +0300
Date: Fri, 18 Oct 2024 15:36:34 +0300
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
Message-ID: <ZxJWUoMg9vYyXwMW@smile.fi.intel.com>
References: <20241016094911.24818-2-pstanner@redhat.com>
 <20241016094911.24818-4-pstanner@redhat.com>
 <Zw-XkFcaXjlF5az0@smile.fi.intel.com>
 <0cf0ffed63a8645c49f043877c526b2ab0abf96e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cf0ffed63a8645c49f043877c526b2ab0abf96e.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 18, 2024 at 12:52:15PM +0200, Philipp Stanner wrote:
> On Wed, 2024-10-16 at 13:38 +0300, Andy Shevchenko wrote:
> > On Wed, Oct 16, 2024 at 11:49:05AM +0200, Philipp Stanner wrote:

...

> > > + * This function is DEPRECATED. Do not use it in new code.
> > 
> > Interestingly that the syntax of the DEPRECATED is not documented
> > (yet?),
> > however the sphinx parser hints us about **DEPRECATED** format — see
> > Documentation/sphinx/parse-headers.pl:251. In any case the above
> > seems
> > like second used (in a form of the full sentence) and will be updated
> > in accordance with the above mentioned script.
> 
> Can't completely follow – so one should always write "**DEPRECATED**",
> correct?

I can't answer to this, because there may be "rendered" form and in this case
it should not be surrounded by double asterisks, otherwise it's better to have
at the start.

> Is that a blocker for you?

Nope, I mentioned this in the last sentence in my previous reply.

> All the docstrings in pci/pci.c and pci/devres.c so far just use
> "DEPRECATED".

Yeah, this, if ever needed, has to be changed at once.

-- 
With Best Regards,
Andy Shevchenko



