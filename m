Return-Path: <linux-pci+bounces-25995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 488E7A8B6B4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 12:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E80116F523
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 10:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B55022B8A8;
	Wed, 16 Apr 2025 10:23:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75308233712;
	Wed, 16 Apr 2025 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799034; cv=none; b=EloUlzbIMbB6x1axycusXxtSc/+qj+Zm7rL8i2yA1JIXdCKIlq+h4iC9rs0awzerdePKxlx4GSR8COQ4njhUI7cq4uvvc9HVzEN5sfCYCIf4xA/pZy9THwV8aPUG+/mtI91LwTiGy2etKAvgGQMxg/Zuia01mQ3Esj1uHuECDK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799034; c=relaxed/simple;
	bh=l2Hcyo7ULtuCNEmt04dECGpCF6AzwmE4nkggzDrXWaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mquoGgVkzmEON1xumdFTw6US0wgBEZ7fz9gRUafwePKP6fHUbJ7DgaB2sPpA19xiWvIWtDcDt279AQPiu6UfnFIYKsCiUUgEQJJyiXJ0Em3w70JSMZAwf+KGjszmq4VuYC5Ti/94ca0kcKxAZrUICo2eFfHIQTorW137TPH5TmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: gJY+GaqJTIKxBJC1pk0Z6A==
X-CSE-MsgGUID: ehakHWhDQwynH44V0hHk/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46228814"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="46228814"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 03:23:51 -0700
X-CSE-ConnectionGUID: XPRICFYqSp2DjYPmlu/eJA==
X-CSE-MsgGUID: ZSmYWC7gRNWZhlXxpZtRpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="130265485"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 03:23:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u4zvk-0000000Cp1y-2nX5;
	Wed, 16 Apr 2025 13:23:44 +0300
Date: Wed, 16 Apr 2025 13:23:44 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] x86: Use resource_set_{range,size}() helpers
Message-ID: <Z_-FMP0lGxG2aio0@smile.fi.intel.com>
References: <20250416101318.7313-1-ilpo.jarvinen@linux.intel.com>
 <Z_-E3W8i4EfxdBh3@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_-E3W8i4EfxdBh3@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 16, 2025 at 01:22:21PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 16, 2025 at 01:13:18PM +0300, Ilpo Järvinen wrote:

...

> > +			resource_set_range(res, 0xC0000, SZ_128K);
> >  			res->flags = IORESOURCE_MEM | IORESOURCE_ROM_SHADOW |
> >  				     IORESOURCE_PCI_FIXED;
> 
> I'm wondering why not DEFINE_RES_MEM() in such cases?

For the reference:
1af56ff09e67 ("resource: replace open coded variants of DEFINE_RES_*_NAMED()")

-- 
With Best Regards,
Andy Shevchenko



