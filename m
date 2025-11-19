Return-Path: <linux-pci+bounces-41648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18213C6F7D1
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 16:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id AA1782450A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 15:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76656288C3F;
	Wed, 19 Nov 2025 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kklr7JlJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A510D288C22;
	Wed, 19 Nov 2025 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763564454; cv=none; b=AKfNkV8bq8/+alRD0hvYA0laF+IVAZPDLWut5X1YUJtbgPxyGNZna0lCzge/CvgFakls7qf2cy655JqkxCbPuMotKB/fbOR2byBDKHxXHTQaeTh31RedexdKFQs+ZbBYc6/XPw81ttFXnnCsBmkREP6yU6cKT8/j3Rkmsm4DT+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763564454; c=relaxed/simple;
	bh=6VLOKmDo4WviGUhM4qQZA7IzCWHn1ZvDUbxiE4MHVTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kI75v+RobZF25UAlAyGXkQU5CcKzq7ygdY+d9UtDBX4ZdeWrwOwbDw9moyF7o5BN4rZqW5UCuMWyz6tmYqOcb8GrjBm/3rlDUoj+ng/Vr2qH6U08gg+QxbnHRFf5hb8HLtpz90I8TQD4g/qjBDVXW5PKFwNbDmsCAoO2pJ9+Zv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kklr7JlJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763564453; x=1795100453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6VLOKmDo4WviGUhM4qQZA7IzCWHn1ZvDUbxiE4MHVTw=;
  b=kklr7JlJYLLwcDw0/7uI+GKZ6LbAQf/gpqXFYcGpgrSIM62EpEJDo9/G
   qdKMXI4llO6u0oi7hu26V/GuF9S9iuQsvnFoq2jzo43ML+x45didwO8cp
   Azfxn2c0FiCm0UNR/EMla5oNaeFcTjegV2FaaGwUXExMI1WVRZu6qR+UH
   Cxw2f4tlrw4AUHm8G8rdsFhnv+o2c73I2J8Ji30Ei6Q3O8Nw0YkMwxFwK
   /6ez4/2dgOQguwWr6rncaZ+k4v1tz0eKsQ45i3AbjySYmaBdreC9u3uja
   OYip5+X47hmoIYAJqebcFYM3rQNeI54/gDPOd5IL9bqUaV1uzdc3zN2/D
   g==;
X-CSE-ConnectionGUID: UZizB8n9QQ+RLwBg9MkM8g==
X-CSE-MsgGUID: /6a6VS3sR5e9ISUGOzoYLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="91085416"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="91085416"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 06:59:36 -0800
X-CSE-ConnectionGUID: 1p6r6x9uS5u32zRd1eVaZg==
X-CSE-MsgGUID: voIFHWIqQSaE97KThetVqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="191329073"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 06:59:30 -0800
Date: Wed, 19 Nov 2025 16:59:28 +0200
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
Subject: Re: [PATCH v3 00/21] treewide: Introduce %ptS for struct timespec64
 and convert users
Message-ID: <aR3bUMvPCqZr5utj@smile.fi.intel.com>
References: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>
 <aR3B8ECx9W6F0BV_@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR3B8ECx9W6F0BV_@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 19, 2025 at 02:11:12PM +0100, Petr Mladek wrote:
> On Thu 2025-11-13 15:32:14, Andy Shevchenko wrote:
> > Here is the third part of the unification time printing in the kernel.
> > This time for struct timespec64. The first patch brings a support
> > into printf() implementation (test cases and documentation update
> > included) followed by the treewide conversion of the current users.
> > 
> > Petr, we got like more than a half being Acked, I think if you are okay
> > with this, the patches that have been tagged can be applied.
> > 
> > Note, not everything was compile-tested. Kunit test has been passed, though.
> 
> JFYI, the patchset has been committed into printk/linux.git,
> branch for-6.19-vsprintf-timespec64.
> 
> Note, that I have:
> 
>    + fixed the 19th patch as proposed, see
>      https://lore.kernel.org/all/aR2XAYWTEgMZu_Mx@pathway.suse.cz/
> 
>    + reviewed all patches but I triple checked 7th patch which
>      did not have any ack yet. And I added my Reviewed-by tag
>      there. ;-)
> 
>    + I tried build with allyesconfig. It succeeded. I am not 100%
>      sure that it built all modified sources but...

Thank you!

-- 
With Best Regards,
Andy Shevchenko



