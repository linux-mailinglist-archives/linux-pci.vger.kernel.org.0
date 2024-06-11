Return-Path: <linux-pci+bounces-8587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC23903DEB
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 15:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02731F23EEC
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 13:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EEB17D342;
	Tue, 11 Jun 2024 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLro9Lih"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492471E4AF;
	Tue, 11 Jun 2024 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113810; cv=none; b=OQIzbiQ6lxtQG4OKy/x4p9qF/Ja6haEmtBGSlKXrsDcwK97/bGFidLapqGyWOS9rdUBtUY8hhroHKcr1gJ0OFUbxyPDIAuRRhlwXoGP3aUMVqCvDOsKRnGi8LDKZls5OZ/S68iemFstrMJY0FhHY4EqRPwdgSY3YdF5ptChDY9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113810; c=relaxed/simple;
	bh=SEl+BDRhqHpRtt06RymqvtAudDdelCYnfVCZ/Mt8fgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rd+vkd8UdqCl5XpzprA0+p7XeoB3FjUu9lEkQT6saE/SQ2J96zjyZrRAZOIvlc/4kx3Aey8WJuBLgMOh88tki6d2FIX5otPQ+l1AsKSXf4lY+MUk6l1qkWvv766VnmyanZXx6kPjPEM9ltRJyRvScjLKjswhSewkmZNYsa9K+MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLro9Lih; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718113809; x=1749649809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SEl+BDRhqHpRtt06RymqvtAudDdelCYnfVCZ/Mt8fgY=;
  b=BLro9Lihr42FHKkeP6znxDDtvRowa4kRQY7y5IE4TukpwmBBZBiqD74H
   /ycnfD4MzZ5h1swGcptdIKqPipIEUXRfxnknDFOZkaMAjar9wccAsgBZf
   JLA9I7NwQQO/KdZ8lNiQZTJrrNhQ6Ua6wKTgQjzm7/r2xVUSIxqRFRAR1
   rCV1aQB9cO/Vci6rHtrkySqIaPkiiFVlKdho6/SHfHG0A8ANlUI+Zts5A
   jF72DT5nCQ3mZbigPTQAOVJn9VKY0ZmKI/lZZZZSeptaNeLXmWoThHt0V
   rJ+jo1OiA3Hlvl0X0DFBVWzkjd7O8MEWFogqFG1aUwKncIbOGTMF/70x4
   w==;
X-CSE-ConnectionGUID: YJD2DVSpTWeF7JDSKmq1bg==
X-CSE-MsgGUID: Wnbwty1RShuNPGQsBRgJDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18683180"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="18683180"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 06:50:08 -0700
X-CSE-ConnectionGUID: HlsCw25rSzSSk8Ds3ob0rg==
X-CSE-MsgGUID: EafsI8fuSeeQ89sjL4vxfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39293498"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 06:50:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sH1sx-0000000FYUE-01m6;
	Tue, 11 Jun 2024 16:50:03 +0300
Date: Tue, 11 Jun 2024 16:50:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: kirin: fix memory leak in kirin_pcie_parse_port()
Message-ID: <ZmhWCibpMLd1GPo2@smile.fi.intel.com>
References: <20240609-pcie-kirin-memleak-v1-1-62b45b879576@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609-pcie-kirin-memleak-v1-1-62b45b879576@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Jun 09, 2024 at 12:56:14PM +0200, Javier Carrasco wrote:
> The conversion of this file to use the agnostic GPIO API has introduced
> a new early return where the refcounts of two device nodes (parent and
> child) are not decremented.
> 
> Given that the device nodes are not required outside the loops where
> they are used, and to avoid potential bugs every time a new error path
> is introduced to the loop, the _scoped() versions of the macros have
> been applied. The bug was introduced recently, and the fix is not
> relevant for old stable kernels that might not support the scoped()
> variant.

Looks reasonable to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Thanks!

-- 
With Best Regards,
Andy Shevchenko



