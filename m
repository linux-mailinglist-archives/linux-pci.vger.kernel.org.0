Return-Path: <linux-pci+bounces-11596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D1994F230
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 17:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9449E1C2113D
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 15:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4BD184559;
	Mon, 12 Aug 2024 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWYeOvfc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D6C4D112;
	Mon, 12 Aug 2024 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478252; cv=none; b=olmBHnOphJ5u0xNGRxmhuHbGBsd8f6HkG9I5uPAIR/ZvadhgxmwMtHt/1uHl0mVFwoKiuRKB+hjj5nQcnRqb/JO4oJtSMN7eMnEZeCBfhON+tzl1w/WuNbABZ+f9ORozzQSf4LatoB2jACiY5k5IJBa3omDKtwrtYlFkCVz/Llg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478252; c=relaxed/simple;
	bh=1jY8JH1fwPEsXZDvtF095Z8nEO4cx3OboyXPTVEElpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHf0RI2hPcvqRNEXLsYuW6hpMp5WOujO41uIBuhaDhD6Gv6SzzWoFSMjlx/VqzaM31/hbZiMfm2TyWyqLDVS2YH07r360MsaTZKHmc7pTRrZi6yEcU8/ZiRApat9pLt602NnO7CmO4MCCUFwL8ckNzTlt2zFsZJf/h1ymvq9nZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWYeOvfc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723478251; x=1755014251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1jY8JH1fwPEsXZDvtF095Z8nEO4cx3OboyXPTVEElpc=;
  b=FWYeOvfco2x9jdkfnz1SPksE3GYHi0meQv9dCRe6dtnVjRyTIn6RC2dK
   HLIeKoo+HQWEefFXbKhiaH+89I+383UJoMJzuLdkFQ07LqB3hdkFPG5rQ
   MkCy/71TFlQhZvA/c1vxCqHI0NB4oFssoWcjXMTu/5Pe3zHwhliIP0OUP
   dz8sR8dX71SZhgtuPFtksRpJ9M5Qy21f8MWupUzk8c0AuFylNPoaZPTj6
   GTqZRMtsvhLzvUeDFgpCoFU07DdcLVvSLMVBCB1Ti0w58AIgCbxN/Dh95
   J2WDqRKAx9NhVInTSFawRPQElN5c6Uen1AY+4t0nirQ4Pif5h+DBA/dph
   A==;
X-CSE-ConnectionGUID: IvtU40hGTKSINbWbNSXNsg==
X-CSE-MsgGUID: vKRj3uKcSeG+wH8B8LrIog==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="39050272"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="39050272"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:57:30 -0700
X-CSE-ConnectionGUID: McHd87mUTm2WpZAKFI1cEA==
X-CSE-MsgGUID: a4xXCGiXS7y7C8xvK+qjfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="88946016"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:57:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sdXQC-0000000EOzu-0scM;
	Mon, 12 Aug 2024 18:57:24 +0300
Date: Mon, 12 Aug 2024 18:57:23 +0300
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
Message-ID: <Zrow42L9dYC6tSZr@smile.fi.intel.com>
References: <20240805080150.9739-2-pstanner@redhat.com>
 <20240805080150.9739-6-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805080150.9739-6-pstanner@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

(Reduced Cc list a lot)

On Mon, Aug 05, 2024 at 10:01:31AM +0200, Philipp Stanner wrote:
> pcim_iomap_table() and pcim_iomap_regions_request_all() have been
> deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> Replace these functions with their successors, pcim_iomap() and
> pcim_request_all_regions()

Missing period at the end.

...

> -	/* Map PF's configuration registers */
> -	err = pcim_iomap_regions_request_all(pdev, 1 << PCI_PF_REG_BAR_NUM,
> -					     OTX2_CPT_DRV_NAME);
> +	err = pcim_request_all_regions(pdev, OTX2_CPT_DRV_NAME);
>  	if (err) {
> -		dev_err(dev, "Couldn't get PCI resources 0x%x\n", err);
> +		dev_err(dev, "Couldn't request PCI resources 0x%x\n", err);
>  		goto clear_drvdata;
>  	}

I haven't looked at the implementation differences of those two, but would it
be really an equivalent change now?

Note, the resource may be requested, OR mapped, OR both. In accordance with the
naming above I assume that this is not equivalent change with potential
breakages.


> -	cptpf->reg_base = pcim_iomap_table(pdev)[PCI_PF_REG_BAR_NUM];
> +	/* Map PF's configuration registers */
> +	cptpf->reg_base = pcim_iomap(pdev, PCI_PF_REG_BAR_NUM, 0);
> +	if (!cptpf->reg_base) {
> +		err = -ENOMEM;
> +		dev_err(dev, "Couldn't ioremap PCI resource 0x%x\n", err);
> +		goto clear_drvdata;
> +	}

(Yes, I see this).

...

> --- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
> +++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c

Ditto. here.

-- 
With Best Regards,
Andy Shevchenko



