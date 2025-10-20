Return-Path: <linux-pci+bounces-38790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 863B2BF2F0A
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 20:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 040BC34E5D8
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 18:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223AD1EF09B;
	Mon, 20 Oct 2025 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxvfJTRZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC27E792;
	Mon, 20 Oct 2025 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760985067; cv=none; b=mrVuQeZya8djiEfEdewMctZPfoavPB/4TIw+xnZ4va5KyUFmQc0/CTZ9QqiPukhstNsD736iQj/PqXzLu2AqFpiUQIgDviuQeDjJ/OwSceC8raUWAG/QkwA2jGOHgQ3y2cW3/6pAvKXADgTNIN20+81gpkMTKz14oZaTmLLO8gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760985067; c=relaxed/simple;
	bh=2o7Fw/nuNxjKMu5KaUQiLbIYThAN0vNPulMcmo+DTu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvFzw/dYuHhgDD60TO2504LDDa1fwrP5FB7CKVLE5OchkOYjGzyMTGJoYPcJ20arqINj40NwogUBirieQPLqXfs68ACoNJ8oKR4mS7pzaOGOYE5hjxrcGV7KCv6qJb0sxY1f+k1V8HfEkovRkSqf2N6DNRfmEnMpiq7DM9Szxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxvfJTRZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760985064; x=1792521064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2o7Fw/nuNxjKMu5KaUQiLbIYThAN0vNPulMcmo+DTu4=;
  b=LxvfJTRZc+yLOkbFqnHo0M84m+6Rk5uleaMyrLe2Nxkppo9sMl5DuF+J
   Mf8Q9pa81MSA+VXAl/q4OhMLdOlltKkrsjv9vpmGiUmu8N6TL1G7U1beu
   cjbzOqcS8Kd46s/HVlel7mp40y9qgiY1MIu9YzKlpGZQJ3PKJapkZxXW0
   jCC3rh3Ek66lKuQjukINqaU+kqaehCDXQYoIU1EKYRN3kwAT3zYErl7UA
   evFfeCaXiEAJZS8/FxcWt4F3OjTBzC9LLZ/LWmlkO0Bsn50pMoFjTfe7x
   8zLVQeHGj4wbxV4RR/RCEEtZbymAl5YS5XPncRUKViNKP+NeWDUxcBYDI
   w==;
X-CSE-ConnectionGUID: qGt/oaGaRGqHxTXoBMXnfQ==
X-CSE-MsgGUID: tsZrIIF+THOiDTLrDEIIRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80732302"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="80732302"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 11:31:04 -0700
X-CSE-ConnectionGUID: bZFwYJreTOSJmvgQfFbUNw==
X-CSE-MsgGUID: HSYfEqkmStKEyzH8dwKxIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="183803554"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.62])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 11:31:02 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vAuep-00000001M7X-0k3W;
	Mon, 20 Oct 2025 21:30:59 +0300
Date: Mon, 20 Oct 2025 21:30:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>, Rob Herring <robh@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI: Do not coalesce host bridge resource structs in
 place
Message-ID: <aPZ_4qDfKdX3F_r3@smile.fi.intel.com>
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
 <20251010144231.15773-3-ilpo.jarvinen@linux.intel.com>
 <aO-vtdECWNpYpo6f@smile.fi.intel.com>
 <8401388b-2957-0853-d80b-4479e02c47f0@linux.intel.com>
 <aPZ09UZMfKhYSUZE@smile.fi.intel.com>
 <9d56e776-731a-7e25-60f0-44485cfbf12c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d56e776-731a-7e25-60f0-44485cfbf12c@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 20, 2025 at 09:15:08PM +0300, Ilpo Järvinen wrote:
> On Mon, 20 Oct 2025, Andy Shevchenko wrote:
> > On Mon, Oct 20, 2025 at 08:21:50PM +0300, Ilpo Järvinen wrote:
> > > On Wed, 15 Oct 2025, Andy Shevchenko wrote:
> > > > On Fri, Oct 10, 2025 at 05:42:30PM +0300, Ilpo Järvinen wrote:

...

> > > > > +/**
> > > > > + * resource_mergeable - Test if resources are contiguous and can be merged
> > > > > + * @r1: first resource
> > > > > + * @r2: second resource
> > > > > + *
> > > > > + * Tests @r1 is followed by @r2 contiguously and share the metadata.
> > > > 
> > > > This needs an additional explanation about name equivalence that's not only by
> > > > pointers, but by a content.
> > > 
> > > Okay. The point was to check names are the same, the pointer check was 
> > > just an optimization as these resources are expected to carry the same 
> > > name even on the pointer level.
> > > 
> > > > > + * Return: %true if resources are mergeable non-destructively.
> > > > > + */
> > > > > +static bool resource_mergeable(struct resource *r1, struct resource *r2)
> > > > > +{
> > > > > +	if ((r1->flags != r2->flags) ||
> > > > > +	    (r1->desc != r2->desc) ||
> > > > > +	    (r1->parent != r2->parent) ||
> > > > > +	    (r1->end + 1 != r2->start))
> > > > > +		return false;
> > > > 
> > > > > +	if (r1->name == r2->name)
> > > > > +		return true;
> > > > > +
> > > > > +	if (r1->name && r2->name && !strcmp(r1->name, r2->name))
> > > > > +		return true;
> > > > > +
> > > > > +	return false;
> > > > 
> > > > Hmm... Can we keep the logic more straight as in returning false cases as soon
> > > > as possible?
> > > > 
> > > > I think of something like this:
> > > > 
> > > > 	if (r1->name && r2->name)
> > > > 		return strcmp(r1->name, r2->name) == 0;
> > > > 
> > > > 	return r1->name == r2->name;
> > > 
> > > But the point the order above was to avoid strcmp() when the pointer 
> > > itself is same which I think is quite common case. I don't think strcmp() 
> > > itself checks whether the pointer is the same.
> > 
> > On the second thought I think comparing by the content is quite a behavioural
> > change here.
> 
> Compared to what?
> 
> This code was previously only used for merging contiguous "System RAM" 
> resources (AFAICT, I don't have way to check what the names in all those
> resources truly were but in any case, the check was even stricter earlier, 
> comparing pointer equality only so definitely the names were not different 
> before this).
> 
> > Perhaps we may start without doing that first? Theoretically it
> > might be the case when the content of names is different, but resources are
> > the same.
> 
> Resources are NOT same, they're two contiguous memory regions and may 
> originate from different source, and thus have different names.
> 
> Not caring about the names will lose one of them from /proc/iomem.
> 
> > The case when name is the same (by content, but pointers) with the
> > idea of having different resources sounds to me quite an awkward case. TL;
> > DR: What are the cases that we have in practice now?
> 
> In the original thread [1], PCI side resource coalescing did break the 
> resources by merging without caring what the resource internals were. That 
> problem was found after trying to fix another problem, thus it might not 
> happen in practice except after fixing the other problem with root bus 
> resources.
> 
> In the common case when merging PCI root bus resources, the resources 
> typically have the same name - this happens all the time (e.g. io port 
> ranges are split to many small ranges which form a contiguous region 
> when coalesced). But that's not always the case, why do you think these 
> two names should be merged losing some information:
> 
>      ee080000-ee08ffff : pci@ee090000
>        ...
>      ee090000-ee090bff : ee090000.pci pci@ee090000
> 
> ?

I don't think it's a good idea (after reading the nice elaboration from you).
It seems I misunderstood the use case(s). That's why I asked for some elaboration
about the (new?) requirement to test the content of the names and not only pointer
equivalency.

> (Also, the careless change in the underlying resource by the code this 
> series tries to fix would have likely broken also devres release of the 
> mangled resource, which admittedly, is not related to name at all).
> 
> [1] https://lore.kernel.org/linux-pci/CAMuHMdVgCHU80mRm1Vwo6GFgNAtQcf50yHBz_oAk4TrtjcMpYg@mail.gmail.com/


-- 
With Best Regards,
Andy Shevchenko



