Return-Path: <linux-pci+bounces-3994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0135C866B19
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 08:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950DE1F21DBA
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 07:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA3D1CA8A;
	Mon, 26 Feb 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFGl4nCL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D1C1BF28;
	Mon, 26 Feb 2024 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932946; cv=none; b=YPTWLUlzBDTwAv869BEt0heGhVHh+Qk99vs9+MITWL5s8lojbJ5OHOSng0aMDa7I8YQ2v1m+8hJ7D8WNCBC07TPm93+QYbReHJZDyEdR5tgLJ6GX5KUwyMiyeaerMYtzBwbKLqbnO5JoHILUXAztwoVqZCAAhwDGvgQuZk/ymYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932946; c=relaxed/simple;
	bh=ea7JHUhie8Kli8vmxWmR/LWrRmbZu8hDvuuE7vFplkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIXzaKdqkP84bdc7vwDzfztUFsW0LCGzITFQGP6JSf/1DbvdglslGEdHjxfNuJbPwCdR1vhQ+EvXWh4nSefvvMrYF0MT1cEhXWASj2GAqMEhigwzRuC0DFfjGZLe3C2buueFt5o+HLGC6XH1nesgkhrtvpK2ND6KpKEtHE5dz8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFGl4nCL; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708932945; x=1740468945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ea7JHUhie8Kli8vmxWmR/LWrRmbZu8hDvuuE7vFplkU=;
  b=HFGl4nCLlLqFuL61V3CWNUmE+aPohHkFRuCr7RRsHTjGM5nUmYKmUMj7
   tNbuzBmWpnYmbJ4UbCyYWfu2VBympTlCZdF3MHyRQfWAf/zYKeEIN52eW
   tDPMNsHHfx24FqEVDUwtaeAtw/IzCyEkFi6r0ciWndhxePTsmWuBqdw9M
   YTQGRNq6VxdgJ/sIofc7Eg/WwTQ5a4Vj6jO+lu/h0zD7oqp+uYCG84Mq7
   VI9C4M9DjzOqWkkwjwbKZDUntQ6Fk8l6kNGWxxHdv4beYBeNNs6VuHVCD
   HRlGtnBUN1PMnqdIwiNd82sJ96NTxGdio/o3gZBpF8NH5iftsaVg53alM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3366131"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3366131"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 23:35:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029406"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029406"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 23:35:40 -0800
Date: Mon, 26 Feb 2024 09:35:37 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, mika.westerberg@linux.intel.com
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, bhelgaas@google.com,
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
	stanislaw.gruszka@linux.intel.com, lukas@wunner.de,
	rafael@kernel.org, ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	sashal@kernel.org
Subject: Re: [PATCH v1] PCI / PM: Really allow runtime PM without callback
 functions
Message-ID: <Zdw_SV81YfJvCx2I@black.fi.intel.com>
References: <93c77778-fbdc-4345-be8b-04959d1ce929@linux.intel.com>
 <20240214165800.GA1254628@bhelgaas>
 <Zc0fW0ZIzfNOMj2w@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc0fW0ZIzfNOMj2w@black.fi.intel.com>

On Wed, Feb 14, 2024 at 10:15:29PM +0200, Raag Jadav wrote:
> On Wed, Feb 14, 2024 at 10:58:00AM -0600, Bjorn Helgaas wrote:
> > On Wed, Feb 14, 2024 at 08:58:48AM +0200, Jarkko Nikula wrote:
> > > On 2/13/24 22:06, Bjorn Helgaas wrote:
> > > > > Debugged-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > 
> > > > Sounds like this resolves a problem report?  Is there a URL we can
> > > > cite?  If not, at least a mention of what the user-visible problem is?
> > > > 
> > > >  From the c5eb1190074c commit log, it sounds like maybe this allows
> > > > devices to be autosuspended when they previously could not be?
> > > > 
> > > > Possibly this should have "Fixes: c5eb1190074c ("PCI / PM: Allow
> > > > runtime PM without callback functions")" since it sounds like it goes
> > > > with it?
> > > > 
> > > I don't think there's known regression but my above commit wasn't complete.
> > > Autosuspending works without runtime PM callback as long as the driver has
> > > the PM callbacks structure set.
> > 
> > I didn't suggest there was a regression, but if we mention that Mika
> > debugged something, I want to know what the something was.
> 
> Considering it's not a bug to begin with, perhaps we can change it to
> Suggested-by or Co-developed-by?

Hi Mika,

If you are okay with this, please let me know and perhaps suggest a better
fit for the scenario.

Raag

