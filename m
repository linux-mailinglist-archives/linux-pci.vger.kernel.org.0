Return-Path: <linux-pci+bounces-38592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 504CBBED574
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 19:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C66A4E60A4
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 17:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE1923D7C8;
	Sat, 18 Oct 2025 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+l7I6N6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3C016F288;
	Sat, 18 Oct 2025 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808835; cv=none; b=i0YrLmp2qYeIQWpkWdx+REu9YxarnM8mKgIXbZoF7gJzZPYF7PwZsYDE7ki340eSOOw8yp7b6qzMDaI9Kd58NupQQVjvppkg1zQZNeOP/awd5pSujiYsNC41/bbkdgnm/ERbGikVBvrblkbXpcAOMkN8TdGtxrEgiyIZuzGRurk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808835; c=relaxed/simple;
	bh=mqhP8QyGZTc4BwBAUo2/jUHYtMkloV7xLlgmDxkDDYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRhK/yY26DxXy9O0N4r+6ejrtLO1DCCJ7+K6dQsJk6meXMkW9XS0enMvBhg58m+cJfnU6hjR7CYymFX09uFa/1aK/1hQIi5j0M3kHOwWMiqEu0NdfwN5iJOmA20ZcPmkebPGJ77+vlhDUHVC1wpWjPumaJBn5t1oCb6176UG1ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+l7I6N6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760808834; x=1792344834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mqhP8QyGZTc4BwBAUo2/jUHYtMkloV7xLlgmDxkDDYI=;
  b=m+l7I6N6oZxxG7WMJObi6kMCjJemzSfMXNF+FXBNWjzE/SEM1AgfUgk3
   fcvm4r7B0PAjgT3nORLal3TVVnGuNWNPCCnF6VNSTmNYlcSKDzjlZMXb/
   Yepuqf+OOAIumo/6D/CREdgkyTWneKRL+r/xOSCF641/80rMZtFg905dk
   qKw2hh8L5mxowntDd84UCdblb7hZXcLBPJtIs4DUZflW39Vlvz1AdzSCu
   JiWKrBkdFMuJ1sm/sHdLRNJNA8C9gpsdUCz/SMUz59ionurWbChcU+PGQ
   CbvmsQoJK7j6vxzXTSh88mEhcSvKxq54y+Rkks4CkbNkkTZtdDo/HJujp
   Q==;
X-CSE-ConnectionGUID: vkDhOoe9RqaJDHXAySxAeA==
X-CSE-MsgGUID: iMoTfHlfT46mVV0Mw6T6Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62901807"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62901807"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:33:52 -0700
X-CSE-ConnectionGUID: 6kguCOd6RsmyWUWlxYPJrQ==
X-CSE-MsgGUID: bS/xrvw1ReeYI5ZbDKFaog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="183474260"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:33:49 -0700
Received: from andy by ashevche-desk with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1v92V3-00000000Kqx-2z8n;
	Wed, 15 Oct 2025 17:29:09 +0300
Date: Wed, 15 Oct 2025 17:29:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI: Do not coalesce host bridge resource structs in
 place
Message-ID: <aO-vtdECWNpYpo6f@smile.fi.intel.com>
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
 <20251010144231.15773-3-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251010144231.15773-3-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 10, 2025 at 05:42:30PM +0300, Ilpo Järvinen wrote:
> The resource coalescing for host bridge windows in
> pci_register_host_bridge() can alter the underlying struct resource
> which is inherently dangerous as this code has no knowledge of who else
> holds a pointer the same resource.
> 
> Merge the struct resource inside a newly added
> resource_list_merge_entries() which uses the internal __res member of
> the struct resource_entry to store the merged resource, thus preserving
> the original resource structs.

...

> +static void resource_clear_tree_links(struct resource *res)
> +{
> +	res->parent = NULL;
> +	res->child = NULL;
> +	res->sibling = NULL;
> +}

Not sure if this is the best location to inject a new helper to in the code
(I mean the position in the file). But I leave it to you just to give another
look in case something more suitable can be found.

>  static int __release_resource(struct resource *old, bool release_child)

...

> +/**
> + * resource_mergeable - Test if resources are contiguous and can be merged
> + * @r1: first resource
> + * @r2: second resource
> + *
> + * Tests @r1 is followed by @r2 contiguously and share the metadata.

This needs an additional explanation about name equivalence that's not only by
pointers, but by a content.

> + * Return: %true if resources are mergeable non-destructively.
> + */
> +static bool resource_mergeable(struct resource *r1, struct resource *r2)
> +{
> +	if ((r1->flags != r2->flags) ||
> +	    (r1->desc != r2->desc) ||
> +	    (r1->parent != r2->parent) ||
> +	    (r1->end + 1 != r2->start))
> +		return false;

> +	if (r1->name == r2->name)
> +		return true;
> +
> +	if (r1->name && r2->name && !strcmp(r1->name, r2->name))
> +		return true;
> +
> +	return false;

Hmm... Can we keep the logic more straight as in returning false cases as soon
as possible?

I think of something like this:

	if (r1->name && r2->name)
		return strcmp(r1->name, r2->name) == 0;

	return r1->name == r2->name;

> +}

...

> +	new_res->start = res->start;
> +	new_res->end = next_res->end;
> +	new_res->name = res->name;
> +	new_res->flags = res->flags;
> +	new_res->desc = res->desc;

Hmm... IIRC I saw similar code lines a few times in the kernel in resource.c
and might be elsewhere. Perhaps a time for another helper?


...

> +	/* prepare for step 2), find res & next_res from child/sibling chain. */
> +	p = &parent->child;
> +	while (1) {
> +		tmp = *p;
> +		if (tmp == res)
> +			break;
> +
> +		/*  No res in child/sibling, the resource tree is corrupted! */

Extra space which is not needed.

> +		if (WARN_ON_ONCE(!tmp))
> +			return -EINVAL;
> +
> +		p = &tmp->sibling;
> +	}

...

> static bool system_ram_resources_mergeable(struct resource *r1,
>  					   struct resource *r2)
>  {
>  	/* We assume either r1 or r2 is IORESOURCE_SYSRAM_MERGEABLE. */
> -	return r1->flags == r2->flags && r1->end + 1 == r2->start &&
> -	       r1->name == r2->name && r1->desc == r2->desc &&
> +	return resource_mergeable(r1, r2) &&
>  	       !r1->child && !r2->child;

Now one line?

>  }

> +struct resource_entry *resource_list_merge_entries(struct resource_entry *entry,
> +						   struct resource_entry *next)
> +{
> +	struct resource *res = entry->res, *next_res = next->res, *new_res;
> +	int ret;
> +
> +	if ((entry->offset != next->offset) ||
> +	    !resource_mergeable(res, next_res))

One line? (It's only 82 characters long)

> +		return ERR_PTR(-EINVAL);
> +
> +	/* Use the internal __res to not mutate the input resources. */
> +	struct resource_entry __free(kfree) *new = resource_list_create_entry(NULL, 0);
> +	if (!new)
> +		return ERR_PTR(-ENOMEM);
> +
> +	new->offset = next->offset;
> +	new_res = new->res;
> +
> +	ret = resource_coalesce(res, next_res, new_res);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	resource_list_add_tail(new, &entry->node);
> +	resource_list_destroy_entry(entry);
> +	resource_list_destroy_entry(next);
> +
> +	return no_free_ptr(new);
> +}

-- 
With Best Regards,
Andy Shevchenko



