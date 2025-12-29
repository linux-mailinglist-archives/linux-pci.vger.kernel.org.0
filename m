Return-Path: <linux-pci+bounces-43801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5840CE6EF0
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 14:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0A23300795E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 13:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B964C313E20;
	Mon, 29 Dec 2025 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ix+aSw1b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE72C3164AA;
	Mon, 29 Dec 2025 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016702; cv=none; b=qUx4icsLmhjlxBHmSdO4fSGMIU/4N6Vqb+nwymWS/b8j4PZgs24aTCc3GTI5rpv89DbQzbgJIXbfTuk5dcJtXlAzc4t+fl7NanHjPnjXC3hnUmpcFVFKTgdiOlFN/K0FnVZEXTks1jqgFeNAhDolquQHZTTrMvtMdNvFlbEyWHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016702; c=relaxed/simple;
	bh=wjLcMD0qGW0E+ZyDIf9hcocUQCpvukGWYx3eueWZI3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skHMGetYqsvSYSAyX4x90ppYF3Lq1x1n4jadlUxQtjDZGSOfN7V2VwEcXg7uP/ha0p5JcZOo+UmwV2hA7bAVHNl5kDRkh82L10pqg+uMDeyT0iYzMddOnt58QtgQ5976rGBEESCxw9I7N6l5QzXgSUCfIus7W/gm96jiqOhvA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ix+aSw1b; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767016701; x=1798552701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wjLcMD0qGW0E+ZyDIf9hcocUQCpvukGWYx3eueWZI3U=;
  b=Ix+aSw1bfpj/ur8zK32rDTn/nhC7L+cA+nCDgtApJRC1zRe6SQP8fTmz
   hrPe/byXB/pGFlRW9zuaiFS2i9cNgtbgWZidhFb8bc40O8l1tJ1ALxfsW
   Qwjzd77pHPtRc3vyXRk7+DaCacLEJSBX+JQH5J9kNgRkkxqDhh3qk/oqT
   M+68l33+9aSjO/3uTfQexlgzZ8/Swy0qBjTuRU2M3ygrRbyC7SvWLxI/c
   vDbMWK3vzPWsMCDJw7qLR9vO//mPjQCmKJVp4aHqf9ww5N8Mwajs9ZwuQ
   EGJFg2A5hmfnt76qA+gJOY2ztOHnjeTcXKmz4cojmaHtTejvzJecOEB/G
   w==;
X-CSE-ConnectionGUID: w9tI/sFsTnu+Hgpg2998IA==
X-CSE-MsgGUID: 6Mxk75cEQnKLM4W0ppBI8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="79256633"
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="79256633"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 05:58:20 -0800
X-CSE-ConnectionGUID: I5n7O36SSpyDY118sODhvA==
X-CSE-MsgGUID: jpD4gO7sQeWu1GPuEJU7Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="205449882"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.31])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 05:58:17 -0800
Date: Mon, 29 Dec 2025 15:58:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Alex Hung <alexhung@gmail.com>, Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	AceLan Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH v1 1/4] ACPI: PNP: Drop PNP0C01 and PNP0C02 from
 acpi_pnp_device_ids[]
Message-ID: <aVKI9lVAepGw4lVg@smile.fi.intel.com>
References: <7888874.EvYhyI6sBW@rafael.j.wysocki>
 <9550709.CDJkKcVGEf@rafael.j.wysocki>
 <aVGA9Mgwht_4nlPD@smile.fi.intel.com>
 <CAJZ5v0h-uOs1Q3RXxsbw4AOxTvY5siGrnxSLfXfk+Ea-ZUz7bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h-uOs1Q3RXxsbw4AOxTvY5siGrnxSLfXfk+Ea-ZUz7bQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 29, 2025 at 02:12:10PM +0100, Rafael J. Wysocki wrote:
> On Sun, Dec 28, 2025 at 8:11 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Dec 15, 2025 at 02:34:06PM +0100, Rafael J. Wysocki wrote:

...

> > > +     if (match_string(acpi_system_dev_ids, -1, acpi_device_hid(device)) >= 0) {
> >
> > Using -1 makes sense when we have no direct visibility of the mentioned array.
> > Here we have it visible and statically defined, hence the ARRAY_SIZE() is more
> > appropriate.
> 
> But as it stands it is more consistent with what happens elsewhere in this file.

It's not a big deal, especially if there is some consistency involved.

...

> > > +static void acpi_scan_claim_resources(struct acpi_device *adev)
> > > +{
> > > +     struct list_head resource_list = LIST_HEAD_INIT(resource_list);
> > > +     struct resource_entry *rentry;
> > > +     unsigned int count = 0;
> > > +     const char *regionid;
> >
> > > +     if (acpi_dev_get_resources(adev, &resource_list, NULL, NULL) <= 0)
> > > +             return;
> >
> > Strictly speaking the acpi_dev_free_resource_list() still needs to be called
> > on 0 return as it's called only for the error cases.
> 
> The return value of 0 means that the list is empty, so there's nothing to free.
> 
> > I think this is the first and the only time I see a combined comparison <= 0
> > for the acpi_dev_get_resources().
> 
> I don't see a problem here though.

There is no problem, the only minor thing is that the pattern I see seems only
here.

> > > +     regionid = kstrdup(dev_name(&adev->dev), GFP_KERNEL);
> > > +     if (!regionid)
> > > +             goto exit;
> > > +
> > > +     list_for_each_entry(rentry, &resource_list, node) {
> > > +             struct resource *res = rentry->res;
> > > +             struct resource *r;
> > > +
> > > +             /* Skip disabled and invalid resources. */
> > > +             if ((res->flags & IORESOURCE_DISABLED) || res->end < res->start)
> > > +                     continue;
> >
> > > +             if (res->flags & IORESOURCE_IO) {
> >
> > We have resource_type() helper.
> 
> I had considered using it, but then I couldn't convince myself that it
> would matter, so I went for simpler code.
> 
> > And I believe the direct comparison in this case is better.
> 
> You seem to be arguing that it matters after all, so why does it matter?

In the light of the resent findings of the resource_size() use on zeroed data
it also might be that in some cases the opposite happens, i.e. the resource had
initially a more bits of type assigned while checked for the certain one(s).
In such case the resource_type() == IORESOURCE_foo will fail on those.

I assume, nevertheless, that the code in question is quite unlikely exposed to
such mistakes.

-- 
With Best Regards,
Andy Shevchenko



