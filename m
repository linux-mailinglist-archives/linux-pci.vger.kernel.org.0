Return-Path: <linux-pci+bounces-27502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24844AB1245
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 13:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A63A508202
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 11:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5DC221D94;
	Fri,  9 May 2025 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UIgRaLKY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA59A1FDE19;
	Fri,  9 May 2025 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746790525; cv=none; b=kNpCw+zMP4fSHcVW6GB5dZuaadUZ3gaalf/HHBH3TFIi1+GZvwTZ6D6kzwl0yPmy8bucbKLiAk8FCtOkRqz30AOSHFW41BGl1uGz7KmxuM9W9ThnsjOSVkO4o7X+48f1Ea8m9CskzJpGB+nve+69XnRPqKPdi2xNl5BWxwP5Mcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746790525; c=relaxed/simple;
	bh=8KIHf9OmLLgE+hOeF978U0+HWSf5VFUlCD/UL8AeEME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooknfEWbDTg9U2Dwrwtr01Jisa4jkVPWXkkdTeXtL77SzFFpHUdls8+7jso2EQeYLEpsmMx+afPgPa4/WNZFVvzBlqmr16acMXXU3YEQYCa2vWDgJMhNwO5S5iL6Vj0CX2vr13xSWa4IOuTi9gE9urGCM7HgRobcyOW8Tx0Ri3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UIgRaLKY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746790524; x=1778326524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8KIHf9OmLLgE+hOeF978U0+HWSf5VFUlCD/UL8AeEME=;
  b=UIgRaLKYjlEXHY4jphyIO/xw+DPgP0+hbxEzPazGV9aqxqzC15MPMdIQ
   QHrnDQjyPs+Q+1JPzDXi1uCBe0BOZkHrwfwcIWF3yxv8tBnJn5+pvdEh0
   WUzGaW8ii42VYL91sDc9yjwE99xUoBMxi4c+EHjmaWmLIHsNyc6HiIewz
   6h60AtJzwV26VwR/yiVTAF3i9NSv2K3Faqz7HKxCUJnrM4dH+dJSdzvbs
   An0nK/XGOt9dcYuf14aDA4nSefXC6vgzWVURjeE9i3YPMRenyiJDZijaA
   RvUp4cZ1TFfIiKlluuTvcKumxVTmo3Mxa1vXZpzaZN9q0pj7Kqoq5bifA
   Q==;
X-CSE-ConnectionGUID: uavRL3aaS1yRHq9TDUFQYw==
X-CSE-MsgGUID: kJio2pVPRx6vWt3tD9EBnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="60018331"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="60018331"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 04:35:23 -0700
X-CSE-ConnectionGUID: dnI/PA9fR7C/uvI0OgZHvg==
X-CSE-MsgGUID: rir706HgTC2/66cqhrngjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="173761276"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 04:35:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uDM0X-000000004rY-0p0E;
	Fri, 09 May 2025 14:35:13 +0300
Date: Fri, 9 May 2025 14:35:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: dakr@kernel.org, airlied@gmail.com, simona@ffwll.ch,
	akpm@linux-foundation.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, gregkh@linuxfoundation.org, rafael@kernel.org,
	bhelgaas@google.com, kwilczynski@kernel.org, raag.jadav@intel.com,
	arnd@arndb.de, me@kloenk.dev, fujita.tomonori@gmail.com,
	daniel.almeida@collabora.com, nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 06/11] io: move PIO_OFFSET to linux/io.h
Message-ID: <aB3ocO8xh5GugfDD@smile.fi.intel.com>
References: <20250509031524.2604087-1-andrewjballance@gmail.com>
 <20250509031524.2604087-7-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509031524.2604087-7-andrewjballance@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 08, 2025 at 10:15:19PM -0500, Andrew Ballance wrote:
> From: Fiona Behrens <me@kloenk.dev>
> 
> Move the non arch specific PIO size to linux/io.h.
> 
> This allows rust to access `PIO_OFFSET`, `PIO_MASK` and
> `PIO_RESERVED`. This is required to implement `IO_COND` in rust.

...

> +/*
> + * We encode the physical PIO addresses (0-0xffff) into the

I know this is the original text, but we have a chance to improve it a bit by
saying range more explicitly:

 * We encode the physical PIO addresses (0x0000-0xffff) into the

> + * pointer by offsetting them with a constant (0x10000) and
> + * assuming that all the low addresses are always PIO. That means
> + * we can do some sanity checks on the low bits, and don't
> + * need to just take things for granted.
> + */
> +#define PIO_OFFSET	0x10000UL
> +#define PIO_MASK	0x0ffffUL
> +#define PIO_RESERVED	0x40000UL
> +#endif


-- 
With Best Regards,
Andy Shevchenko



