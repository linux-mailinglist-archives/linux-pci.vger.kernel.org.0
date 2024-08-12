Return-Path: <linux-pci+bounces-11605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE9394F7B0
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 21:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446F4283BD4
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 19:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5745F190686;
	Mon, 12 Aug 2024 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UcoDhKrw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B74C2F2C;
	Mon, 12 Aug 2024 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723492130; cv=none; b=QbNrvwpk5erGCfGjwn8uZ9AZCtwpqJDn1Kpsw5NRj4zAunWt39JorC5U7YqpsX+t9k3wxmbcgvv1qpX1NBEVaDZ5/gy11zFXB9UGrkaEWeF9m7oUYUb9o5WMKboZP8isligt3jdq5A2IdPZ09LmEvgFh5q96KRSf2KfzCzsRTsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723492130; c=relaxed/simple;
	bh=BX906+U/g24A1On4VeGG6ZhXbaUsXkXBzswA+Kgwgqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hn6y7CaNFMo+utaXHy2KfGB80XoTPo3thc8Z6BcXq5EfQXjS1ssL8qbcng+PGukGFrH8attwLrrIDTyRTbpwxuskhfm9FxUGPun4WRjh2OmvlhcuAONnp4vlgZNeYTbVJhHE+fbW49+noA7FHju6qSZOK16s9sTIdCab/nTL+70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UcoDhKrw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723492128; x=1755028128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BX906+U/g24A1On4VeGG6ZhXbaUsXkXBzswA+Kgwgqk=;
  b=UcoDhKrw8yg9K/++Hkg71NOeRoriXDt25wgqf1yncC+fUU3r7I6pl4Nt
   OQf9DpwOguhC9oXBvMVlBXMwwPnqZmOinyNsNhCrnB11gts8yyjweEPBm
   M1JJT3XKA8Ev5BrkRxvPsJJqSeNhJxfHZNw/8CCESKPXoqrABQXrw543p
   bep0p1lyEFBiKiVzzcJoYVH/b39uyxtRyVEoWqqj1W8ciArQiP4JuJOyD
   QLMuxFJqPT7LeahPJxaqApLnCiRrjsoijUiGaq2u04Em1cE5geZK3jjhZ
   xJBm2R6YoZjjxGn8D2WMFV6PfoWva9h5SYCMWhXnFnQjjvGBnQW9NeWox
   g==;
X-CSE-ConnectionGUID: c8ROjb96Q1KCZG+4B4ooKA==
X-CSE-MsgGUID: fIUhis3PTHeTW3pYaSHdUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21495125"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="21495125"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 12:48:47 -0700
X-CSE-ConnectionGUID: 48zjjIv3Rc2lphamJMi6Tg==
X-CSE-MsgGUID: ebFuDCUbQoaftYjRH1VnzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="89210781"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 12:48:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sdb21-0000000EThZ-3n1z;
	Mon, 12 Aug 2024 22:48:41 +0300
Date: Mon, 12 Aug 2024 22:48:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 04/10] crypto: marvell - replace deprecated PCI
 functions
Message-ID: <ZrpnGTO5XGkk0TET@smile.fi.intel.com>
References: <20240805080150.9739-2-pstanner@redhat.com>
 <20240805080150.9739-6-pstanner@redhat.com>
 <Zrow42L9dYC6tSZr@smile.fi.intel.com>
 <70a70c74be9ba1a6ae6297ac646fa82600d9296c.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70a70c74be9ba1a6ae6297ac646fa82600d9296c.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 12, 2024 at 08:16:07PM +0200, Philipp Stanner wrote:
> On Mon, 2024-08-12 at 18:57 +0300, Andy Shevchenko wrote:
> > On Mon, Aug 05, 2024 at 10:01:31AM +0200, Philipp Stanner wrote:

...

> > > - /* Map PF's configuration registers */
> > > - err = pcim_iomap_regions_request_all(pdev, 1 <<
> > > PCI_PF_REG_BAR_NUM,
> > > -      OTX2_CPT_DRV_NAME);
> > > + err = pcim_request_all_regions(pdev, OTX2_CPT_DRV_NAME);
> > >   if (err) {
> > > - dev_err(dev, "Couldn't get PCI resources 0x%x\n", err);
> > > + dev_err(dev, "Couldn't request PCI resources 0x%x\n", err);
> > >   goto clear_drvdata;
> > >   }
> > 
> > I haven't looked at the implementation differences of those two, but
> > would it
> > be really an equivalent change now?
> 
> Well, if I weren't convinced that it's 100% equivalent I weren't
> posting it :)
> 
> pcim_iomap_regions_request_all() already uses
> pcim_request_all_regions() internally.
> 
> The lines you quote here are not equivalent to the old version, but in
> combination with the following lines the functionality is identical:
>    1. Request all regions
>    2. ioremap BAR OTX2_CPT_BAR_NUM
> 
> > 
> > Note, the resource may be requested, OR mapped, OR both.
> 
> Negative, that is not how pcim_iomap_regions_request_all() works.

(I was talking from the generic resource management in the kernel perspective)

> That
> overengineered function requests *all* PCI BARs and ioremap()s those
> specified in the bit mask.

> If you don't set a bit, you'll request all regions and ioremap() none.
> However you choose to use it, it will always request all regions and
> map between 0 and PCI_STD_NUM_BARS.

Oh, thanks to you we are getting rid of this awfully interfaced API!

> > In accordance with the
> > naming above I assume that this is not equivalent change with
> > potential
> > breakages.
> 
> The nasty thing of us in PCI is that you more or less already use the
> code above anyways, because in v6.11 I reworked most of
> drivers/pci/devres.c, so pcim_iomap_regions_request_all() uses both
> pcim_request_all_regions() and pcim_iomap() in precisely that order
> already.
> 
> The only hypothetical breakages which are not already in v6.11 anyways
> I could imagine are:
>  * Someone complaining about changed error codes in case of failure
>  * Someone racing between the calls to pcim_request_all_regions() and
>    pcim_iomap(). But that's why the region request is actually there in
>    the first place, to block off drivers competing for the same
>    resource. And AFAIU probe() functions don't race anyways.
> 
> Anything I might have overlooked?

Dunno, but the above sounds like a good explanation.

-- 
With Best Regards,
Andy Shevchenko



