Return-Path: <linux-pci+bounces-25994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E19EEA8B6AF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 12:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046CD4446B1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 10:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85722459F4;
	Wed, 16 Apr 2025 10:22:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0096D1B6556;
	Wed, 16 Apr 2025 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798957; cv=none; b=GncUwlxowf/xXys+75sKCIFvNHWQ2vJ4UdgQAS/QTWN2XFz6XwjaOmyuA6S+BY+dyB8RYaM9QFo6glNkTzaHOMJ7yH3NLVrKBqTKd+2t40v+aT2FRjnCRfhym92y0dmb6rOliSWsdakX+TCoigteD+l0hicRIfqQO9w5BEmDo2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798957; c=relaxed/simple;
	bh=SryNIjm2WO4TlAZiW3CNp5eTS7NgGyUNgyPARO/mMYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZXlyJUlX59VJ6hz5reWbzXHhbnJt+sincsPS4A7RDZC5w5OnLPxDIywTqO+gKxbzCmmKVJJ/cZ7ym58iK43ggU26LGcSCORGME7BkKGZS76l9X8ekw1PSPA7Y9HiFzTIIVCWGKccsuOPLyCuTqA0qZKJr7yzr1d9lGwwaBIGhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: //tZsc54RYKdxKjfcH5Fng==
X-CSE-MsgGUID: bCfLpz2LTU2hyLNKfVOjMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46053848"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="46053848"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 03:22:28 -0700
X-CSE-ConnectionGUID: wphZqYK4TZ+zZEWHTAf7Kw==
X-CSE-MsgGUID: QPwEK4DRS0CDo9CRDI+XmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="135270825"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 03:22:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u4zuP-0000000CozW-1TLO;
	Wed, 16 Apr 2025 13:22:21 +0300
Date: Wed, 16 Apr 2025 13:22:21 +0300
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
Message-ID: <Z_-E3W8i4EfxdBh3@smile.fi.intel.com>
References: <20250416101318.7313-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250416101318.7313-1-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 16, 2025 at 01:13:18PM +0300, Ilpo Järvinen wrote:
> Convert open coded resource size calculations to use
> resource_set_{range,size}() helpers.
> 
> While at it, use SZ_* for size parameter which makes the intent of code
> more obvious.

...

> +	resource_set_range(res, base, 1ULL << (segn_busn_bits + 20));

Then probably

	resource_set_range(res, base, BIT_ULL(segn_busn_bits) * SZ_1M);

to follow the same "While at it"?

...

> +			resource_set_range(res, 0xC0000, SZ_128K);
>  			res->flags = IORESOURCE_MEM | IORESOURCE_ROM_SHADOW |
>  				     IORESOURCE_PCI_FIXED;

I'm wondering why not DEFINE_RES_MEM() in such cases?

-- 
With Best Regards,
Andy Shevchenko



