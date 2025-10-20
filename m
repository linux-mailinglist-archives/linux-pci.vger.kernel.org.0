Return-Path: <linux-pci+bounces-38787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A38ADBF2C6E
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 19:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4859134CC2D
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 17:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08E43328F5;
	Mon, 20 Oct 2025 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kO35s21X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE13328F2;
	Mon, 20 Oct 2025 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982269; cv=none; b=cWOoRBmMxIu1zDZAYLUh0FR4w7rYIITNSz3IsViM8NV7TV3sdySEWjLTlRwmKAnweGWcQwDGmWq7YCTp5FLRW2DGW5QvPqaUDXaqQu8hLIqSdIW0J5Q0q0snLsKZIifAlAqUmyE71bg2i0kXxEeA2CYQdb7QBTONTOi0wrgzD+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982269; c=relaxed/simple;
	bh=32dtGpNdyTdYO53P8P14PmChbZsJYUzhABFWKdzmSx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+dgwQy67AeCg00YUN3ldEP+Bcl7/TnfLO6ouS9u7vtttEbA+CddG98xDEXKu7f2IjpML8nOYYE0TJYUgK8pJB0RUxxOVe8f+HEIUX8YldXjKz7sO0ttTuP58p6qvsGeMtT42RYCmMYWXCZDFOyT+lupKMzIdANFpY0+W4Zkp2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kO35s21X; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760982268; x=1792518268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=32dtGpNdyTdYO53P8P14PmChbZsJYUzhABFWKdzmSx8=;
  b=kO35s21XLoYP/hK1xhuZgzLT+KINBWOevuRqd13LIb4QYLEfbqOUWNXM
   fa7ciWsIWYVl2PGgQih2D/TMsRHjG5eFpfj5LbycRlWwu9XJdYj6qjqet
   39AOyU0i7F3gNFrOYUREQhQZditJJSzOPBIHHfGJPD0ENVHKQ78pW11kq
   3B0wKIPoXJsL3XSpbys4PAwmdTeRv41I8F1nfvYtW9rdwALbXCa20OaKz
   HN9rd8FBz8Q8C9AQSTaw2pwSEsjzkgsh73GSlbFaUW3L2xUFOzHxfEdJk
   BBquH/WJB1xwu9TdzHekdbB+GO7M5azK7vJlwf/DV2C5EIABNn5vAJExk
   A==;
X-CSE-ConnectionGUID: tsa/rKgzSfyhXWm54aLZcA==
X-CSE-MsgGUID: E+zX9kvmTiuKohPM/Z3w7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73393954"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="73393954"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 10:44:27 -0700
X-CSE-ConnectionGUID: 7A32v3lvRQKiBSJuiVID3w==
X-CSE-MsgGUID: kT+dY9Y6QqaYWgRNUUk8/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="184156966"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.62])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 10:44:24 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vAtvh-00000001Leh-3wxZ;
	Mon, 20 Oct 2025 20:44:21 +0300
Date: Mon, 20 Oct 2025 20:44:21 +0300
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
Message-ID: <aPZ09UZMfKhYSUZE@smile.fi.intel.com>
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
 <20251010144231.15773-3-ilpo.jarvinen@linux.intel.com>
 <aO-vtdECWNpYpo6f@smile.fi.intel.com>
 <8401388b-2957-0853-d80b-4479e02c47f0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8401388b-2957-0853-d80b-4479e02c47f0@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 20, 2025 at 08:21:50PM +0300, Ilpo Järvinen wrote:
> On Wed, 15 Oct 2025, Andy Shevchenko wrote:
> > On Fri, Oct 10, 2025 at 05:42:30PM +0300, Ilpo Järvinen wrote:

...

> > > +/**
> > > + * resource_mergeable - Test if resources are contiguous and can be merged
> > > + * @r1: first resource
> > > + * @r2: second resource
> > > + *
> > > + * Tests @r1 is followed by @r2 contiguously and share the metadata.
> > 
> > This needs an additional explanation about name equivalence that's not only by
> > pointers, but by a content.
> 
> Okay. The point was to check names are the same, the pointer check was 
> just an optimization as these resources are expected to carry the same 
> name even on the pointer level.
> 
> > > + * Return: %true if resources are mergeable non-destructively.
> > > + */
> > > +static bool resource_mergeable(struct resource *r1, struct resource *r2)
> > > +{
> > > +	if ((r1->flags != r2->flags) ||
> > > +	    (r1->desc != r2->desc) ||
> > > +	    (r1->parent != r2->parent) ||
> > > +	    (r1->end + 1 != r2->start))
> > > +		return false;
> > 
> > > +	if (r1->name == r2->name)
> > > +		return true;
> > > +
> > > +	if (r1->name && r2->name && !strcmp(r1->name, r2->name))
> > > +		return true;
> > > +
> > > +	return false;
> > 
> > Hmm... Can we keep the logic more straight as in returning false cases as soon
> > as possible?
> > 
> > I think of something like this:
> > 
> > 	if (r1->name && r2->name)
> > 		return strcmp(r1->name, r2->name) == 0;
> > 
> > 	return r1->name == r2->name;
> 
> But the point the order above was to avoid strcmp() when the pointer 
> itself is same which I think is quite common case. I don't think strcmp() 
> itself checks whether the pointer is the same.

On the second thought I think comparing by the content is quite a behavioural
change here. Perhaps we may start without doing that first? Theoretically it
might be the case when the content of names is different, but resources are
the same. The case when name is the same (by content, but pointers) with the
idea of having different resources sounds to me quite an awkward case. TL;
DR: What are the cases that we have in practice now?

-- 
With Best Regards,
Andy Shevchenko



