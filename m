Return-Path: <linux-pci+bounces-41593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD33AC6DB95
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 10:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93F474FD30A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 09:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E322C337101;
	Wed, 19 Nov 2025 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cekMWXcD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED65335573;
	Wed, 19 Nov 2025 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543691; cv=none; b=mgL6KwTkzI5ZRjKIHdtXCYHpw/4yzEQbf6SIXAEq+dFoX2beJBlEcQNCa7T2Hg945ER10AGVjuOIAW8RiKM1el+CfYS8wMjOmwqX+uTiZnhbHt8nvvMg3qzwngYLTkd5hJ5c+ne+3cV9lS4aan9MXx6KpNGY0agAmxpm826XVmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543691; c=relaxed/simple;
	bh=q6da8jLQtnLnim6HyWRfNmg8bV209AFrRAch7qncfbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6RxXuTVjqJ32ZE1S2NexV0Sbp/FCGCB4jW5PxmYW5FZad2iW43KyjRaI8ZpsfrGon0aGnSCrxrtXpRBJELfUhW+h8jJx1Z8BYrfyG+2gTLS/O3NifzTWcgFYikd+8/57usV3pnNq8v4WSHb/7m32uIWyXpq/7aVI4VjTARnKdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cekMWXcD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763543690; x=1795079690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q6da8jLQtnLnim6HyWRfNmg8bV209AFrRAch7qncfbs=;
  b=cekMWXcD4aJBhqzu2a/2fPvj8qaxdpzbQGuSHMilqF2V+cbAekelvhKK
   +DUjCDRwzR9B8+If3AgHJCVbL2XZ/pg2HA8ozhEW68p8MQNWHfAlxoh9V
   wqw2ba1B2LLzlVhch/3eUZGlnyfau2sb2qeljWzb7RPZL0nxRWkpExT84
   Axk8Zh6wVDrR6e4RDEJQf/l5IDqS0eOM3FTrLK45SnQpmkJ56iFDgGMZL
   Ejqf5IvlRKN4dliHJIcMhFi4SDWDxTAyeQqaP4bGS+qrFeTxn5/Qdm727
   uexSKOp5A5GZHggrajymje87+RT3504euXkA3s9e+Q2w+f4pFpl/Rsnyt
   A==;
X-CSE-ConnectionGUID: gxkYeciaTGmtHocQixgCHA==
X-CSE-MsgGUID: K4vUq2axReywThG1raWong==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="88232433"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="88232433"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 01:14:47 -0800
X-CSE-ConnectionGUID: oHYrWS8ATQebFcLjYXGykg==
X-CSE-MsgGUID: DikRyuhjQLyYtee9Ng8YEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="228346786"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 01:14:41 -0800
Date: Wed, 19 Nov 2025 11:14:38 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
	ceph-devel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 01/21] lib/vsprintf: Add specifier for printing struct
 timespec64
Message-ID: <aR2KfgzV1_3ZzXhT@smile.fi.intel.com>
References: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>
 <20251113150217.3030010-2-andriy.shevchenko@linux.intel.com>
 <aRcnug35DOZ3IGNi@pathway.suse.cz>
 <aRd5HHUBu2ookDv_@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRd5HHUBu2ookDv_@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 14, 2025 at 08:46:52PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 14, 2025 at 01:59:38PM +0100, Petr Mladek wrote:
> > On Thu 2025-11-13 15:32:15, Andy Shevchenko wrote:

...

> > I wonder how to move forward. I could take the whole patchset via
> > printk tree. There is no conflict with linux-next at the moment.
> > 
> > It seems that only 3 patches haven't got any ack yet. I am going
> > to wait for more feedback and push it later the following week
> > (Wednesday or so) unless anyone complains.
> 
> Sounds good to me!
> 
> But in the worst case all but untagged can be pushed, the rest can go
> to the next cycle.

Just got a "BUILD SUCCESS" from LKP and since we gained even more tags
I think it's ready to go.

-- 
With Best Regards,
Andy Shevchenko



