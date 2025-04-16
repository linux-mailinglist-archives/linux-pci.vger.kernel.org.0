Return-Path: <linux-pci+bounces-25997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EDFA8B833
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 14:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD575445DD7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 12:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EB424729E;
	Wed, 16 Apr 2025 12:03:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1F5248893;
	Wed, 16 Apr 2025 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744805001; cv=none; b=hsf+uK5m1gtlWDza9kfUKvmXxpM/ma4ZG5/On6PnG0O7PFjnNUMqA1ov40QwrZA6js2hVvNhnsPrvnow28riGsq0W1cybP+3YbGGJP0VDrurGFXH1fYt7tjjcr19HeB/smE3sy3V7jhXm/vU9Sp6VPY4/w/qVVFEYFlqkij/q78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744805001; c=relaxed/simple;
	bh=Fd+W9CjO5d9kB35ZI0RnHNWj1wpgnArBWJxv+jgCc4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdWz2aCixJApJQy4xUadOxOVmpA7Eh97e26Zw+boDh19eTz2jb02DvXSBWAdfwsY4LXAewypW5m6JJqZh2bqP10n9pzXg0syDZmNGZgGa6tC81GCg5UspAz5VAef4iZDvWuFND7OIwM4W+lgZiLjMi76/4ZapVApxN1uU+dAdpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: JAcJZtEdTyuFSOW+X8JWYA==
X-CSE-MsgGUID: pO2iESYQROaO8OlQSOUCzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46238939"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="46238939"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 05:03:19 -0700
X-CSE-ConnectionGUID: rZsEcAhtTU+IXw8AkJz4MA==
X-CSE-MsgGUID: ISgYA7SHRiGfC442U/jbNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="135521346"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 05:03:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u51U1-0000000CqQW-00w5;
	Wed, 16 Apr 2025 15:03:13 +0300
Date: Wed, 16 Apr 2025 15:03:12 +0300
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
Message-ID: <Z_-cgFJWZTjMl_ud@smile.fi.intel.com>
References: <20250416101318.7313-1-ilpo.jarvinen@linux.intel.com>
 <Z_-E3W8i4EfxdBh3@smile.fi.intel.com>
 <a046f6bb-0b6e-a431-eaa5-ecd279459f86@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a046f6bb-0b6e-a431-eaa5-ecd279459f86@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 16, 2025 at 02:53:51PM +0300, Ilpo Järvinen wrote:
> On Wed, 16 Apr 2025, Andy Shevchenko wrote:
> > On Wed, Apr 16, 2025 at 01:13:18PM +0300, Ilpo Järvinen wrote:

> > > +			resource_set_range(res, 0xC0000, SZ_128K);
> > >  			res->flags = IORESOURCE_MEM | IORESOURCE_ROM_SHADOW |
> > >  				     IORESOURCE_PCI_FIXED;
> > 
> > I'm wondering why not DEFINE_RES_MEM() in such cases?
> 
> I guess you meant DEFINE_RES() as that seems to allow giving custom flags.
> However, DEFINE_RES*() will overwrite ->name which seems something that 
> ought to not be done here.

Okay, I haven't checked the initial state of name field here, so then
DEFINE_RES_MEM_NAMED()?  Or don't we have one?

In any case I would rather see a one assignment for these cases than something
hidden behind proposed conversions.

> I found one other case from the same file though which is truly defines
> a resource from scratch.


-- 
With Best Regards,
Andy Shevchenko



