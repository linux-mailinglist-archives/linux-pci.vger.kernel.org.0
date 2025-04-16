Return-Path: <linux-pci+bounces-26010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD75FA907A3
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 17:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F531907523
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F20F207E0C;
	Wed, 16 Apr 2025 15:25:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7359C1F2BB8;
	Wed, 16 Apr 2025 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817143; cv=none; b=Df9ZA6jFjaZ4vSYgY6TvHbgZBzMDgsGUPuHrIR+O2aEN8RMFhK59cwWHh3ptArnvexFxgBt7L0KTgqBiDrPpM+F1Yv6G799PdQJ+47UQCd8/3cbriXmEE2l0tum/Q7D0QJme7QG9SinG3HcbVTjPwQ5v81ZhXKs6CkXr9NuLx0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817143; c=relaxed/simple;
	bh=O5FMiRNmXONBj5vEoQeS1NbCje5WLfuFhlB24NHiGQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bs89LAM45oa6Agcx+ozkpEM85qjQMeRAPivdR0IJd0ToXVk0VH+dChrx1gKtz2Ipr6PQB2+9ID/1sfSHgDQcMw6d4MDgeiI8p5HH9jWOcrZYA658IrKrWccIbfh6zebIQsk/gImTN68F1kEQ4iUi93PaRI7Qjk3PzbQCZABPex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: T8h3y34CQ0Kef6Te0F2NmA==
X-CSE-MsgGUID: TBb9XAL/RV66VOZu/ahaKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="33991791"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="33991791"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 08:25:41 -0700
X-CSE-ConnectionGUID: kyEB3oc4ScS6ug5XPSkAsQ==
X-CSE-MsgGUID: D8o68JBeR0OJKKTKIBdG9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="161544205"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 08:25:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u54do-0000000CtiF-3vqA;
	Wed, 16 Apr 2025 18:25:32 +0300
Date: Wed, 16 Apr 2025 18:25:32 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] x86: Use resource_set_{range,size}() helpers
Message-ID: <Z__L7DHHvMdmH4bk@smile.fi.intel.com>
References: <20250416101318.7313-1-ilpo.jarvinen@linux.intel.com>
 <Z_-E3W8i4EfxdBh3@smile.fi.intel.com>
 <a046f6bb-0b6e-a431-eaa5-ecd279459f86@linux.intel.com>
 <Z_-cgFJWZTjMl_ud@smile.fi.intel.com>
 <7f0d376c-2d03-8e09-5d85-e53b0bce0cc5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f0d376c-2d03-8e09-5d85-e53b0bce0cc5@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 16, 2025 at 03:18:56PM +0300, Ilpo Järvinen wrote:
> On Wed, 16 Apr 2025, Andy Shevchenko wrote:
> > On Wed, Apr 16, 2025 at 02:53:51PM +0300, Ilpo Järvinen wrote:
> > > On Wed, 16 Apr 2025, Andy Shevchenko wrote:
> > > > On Wed, Apr 16, 2025 at 01:13:18PM +0300, Ilpo Järvinen wrote:

...

> > > > > +			resource_set_range(res, 0xC0000, SZ_128K);
> > > > >  			res->flags = IORESOURCE_MEM | IORESOURCE_ROM_SHADOW |
> > > > >  				     IORESOURCE_PCI_FIXED;
> > > > 
> > > > I'm wondering why not DEFINE_RES_MEM() in such cases?
> > > 
> > > I guess you meant DEFINE_RES() as that seems to allow giving custom flags.
> > > However, DEFINE_RES*() will overwrite ->name which seems something that 
> > > ought to not be done here.
> > 
> > Okay, I haven't checked the initial state of name field here, so then
> > DEFINE_RES_MEM_NAMED()?  Or don't we have one?
> 
> There's pre-existing res->name on it and your suggestion would have 
> resulted in overwriting it with NULL. res->name seems to be filled earlier 
> by PCI probe code.

Okay, then the resource_*() may make more sense, indeed.

> > In any case I would rather see a one assignment for these cases than something
> > hidden behind proposed conversions.
> 
> TBH, these DEFINE_RES*() helpers are doing hidden things such as 
> blantantly overwriting ->name which I only realized after I had already 
> converted to it as per your suggestion.

They are specifically named in  capital letters, so main use is in static
assignments, but they are made compound literals, so it's possible to
initialise the on-stack or on-heap at run-time with this be kept in mind.
That's why there is nothing hidden, it implies that the struct is fully
assigned (with the provided fields and some defaults).

> And yes, it is possible to pass the pre-existing res->name to 
> DEFINE_RES_NAMED() if that what you insist, though it seems doing it for 
> the sake of DEFINE_RES*() interface rather than this code wanting to 
> really define the resource from scratch.
> 
> Given the hidden overwriting, please be careful on suggesting 
> DEFINE_RES*() conversions as it's not as trivial as it seems.

Yeah, seems not everybody aware of the difference with
foo_init_something() vs. FOO_INIT_SOMETHING() :-)

> > > I found one other case from the same file though which is truly defines
> > > a resource from scratch.

-- 
With Best Regards,
Andy Shevchenko



