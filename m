Return-Path: <linux-pci+bounces-4341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7351C86E776
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 18:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BDAD1C251D3
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 17:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A274F79C2;
	Fri,  1 Mar 2024 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HOcQe2rB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1A1883B;
	Fri,  1 Mar 2024 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314781; cv=none; b=FBRY/5xVZ8A3HK2MqGdoPjLY81UmE16DTDKYsyjB5CP0+/fmkgyvf4dUjg0QPt7HdWuRNKiBzSAes0fMIuZXiCZNnPL+S4h/NnJDAGbVfGKrWRkL0ZbCg2ykUHViptFkY31jF36df7w8UlKO9bxhBorr+JFklbiFkChnJuGfq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314781; c=relaxed/simple;
	bh=OnSvXIOnwUU6cdJ19YrwD0B9B6AD5ASiecWfFIx+5R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIa7ph6RuoPpGozHQHBhU1s5tvSiZADehHI0D0HE/Zy4yi59r461spIcrSb0Zu5kQKAnTATMJM1DdWCiASkZwwzLc4jYQTAIpLr/p+tHl5OeQ8mqaH4lLWYo9C5ZyXgSJzSU0GhDQwIk7qLRbYALGFFAX/lpYsKGsQKU1UQflAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HOcQe2rB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709314780; x=1740850780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OnSvXIOnwUU6cdJ19YrwD0B9B6AD5ASiecWfFIx+5R8=;
  b=HOcQe2rBf9LAjiAj10XPxCtrzn3VPWVchM+34VehXWtE8XHrdT76R2ud
   pQvxLpOwtC7JQemhHhPwkIrCjEkoVf+kHpfFv+AqL+yKp6Umpv+D8t82P
   BNs2hVbUdEWHVakpu17CmiukTWZtVwxuYjkdqdqJ0nkiei+Iva7878BhX
   vYok3umcliVyqMPC3PGUBVZ2IKtretSVeh7NpSWmmslUe3i/51JwRaAbs
   czv7taq/Fse27UcnG9k+kgOP7xhbMtf9Mo8xvjQJ3F+yzkBLezJxqS469
   4gC11MA2QMkyvw44qa7IW9q2lfFh5FpJnE1N/HdzKL5RGXM7hTdgwgzbF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3724347"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="3724347"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:39:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="914021208"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="914021208"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:39:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rg6r8-0000000918C-2OKc;
	Fri, 01 Mar 2024 19:39:34 +0200
Date: Fri, 1 Mar 2024 19:39:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: platform-driver-x86@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Klara Modin <klarasmodin@gmail.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] platform/x86: p2sb: Defer P2SB device scan when P2SB
 device has func 0
Message-ID: <ZeIS1pUcIlfDAcb8@smile.fi.intel.com>
References: <20240301134504.1887132-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301134504.1887132-1-shinichiro.kawasaki@wdc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 01, 2024 at 10:45:04PM +0900, Shin'ichiro Kawasaki wrote:
> The commit 5913320eb0b3 ("platform/x86: p2sb: Allow p2sb_bar() calls
> during PCI device probe") triggered repeated ACPI errors on ASUS
> VivoBook D540NV-GQ065T [1]. It was confirmed that the P2SB device scan
> and remove at the fs_initcall stage triggered the errors.
> 
> To avoid the error, defer the P2SB device scan on the concerned device.
> The error was observed on the system with Pentium N4200 in Goldmont micro-
> architecture, and on which P2SB has function 0. Then refer to the P2SB
> function to decide whether to defer or not.
> 
> When the device scan is deferred, do the scan later when p2sb_bar() is
> called for the first time. If this first scan is triggered by sysfs
> pci bus rescan, deadlock happens. In most cases, the scan happens during
> system boot process, then there is no chance of deadlock.

...

> +static bool p2sb_resource_cached(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < NR_P2SB_RES_CACHE; i++)
> +		if (p2sb_valid_resource(&p2sb_resources[i].res))
> +			return true;
> +
> +	return false;
> +}

We don't need this. It's enough to check the cache for P2SB device itself...

...

> +	/*
> +	 * On ASUS VivoBook D540NV-GQ065T which has Goldmont CPU family Pentium
> +	 * N4200, P2SB device scan including function 0 at fs_initcall step

fs_initcall()

> +	 * causes ACPI errors. To avoid the errors, defer P2SB device scan and
> +	 * cache when P2SB devices has function 0.
> +	 */

> +	if (!p2sb_resource_cached())
> +		p2sb_cache_resources(false);

Move this after we new devfn of the P2SB and modify to something like

	if (!p2sb_valid_resources(...p2sb_devfn...))
		...

-- 
With Best Regards,
Andy Shevchenko



