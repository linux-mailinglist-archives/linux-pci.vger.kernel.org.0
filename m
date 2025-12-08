Return-Path: <linux-pci+bounces-42758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 843B4CAD457
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 14:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB903302D2B5
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 13:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287DF314B6C;
	Mon,  8 Dec 2025 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IizGd6W0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027582F657C;
	Mon,  8 Dec 2025 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765200552; cv=none; b=rjk8VGFlrfCGehp58Y1aTSRVkt40L1xVxohbcz+gFBdCeiqTugzkM03Xf93xj2AezOipPXBqXDV16m2nvWv6JNvBmNt5dLlZT+Ctve9jKKahFlPYyTPCy7EMIS+FlDEZnUdtCYYJtwAnJ3Q1qfcw6DU4Z2OCpOOFMmCwfiVHq00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765200552; c=relaxed/simple;
	bh=WBjb6TegpC6Gfgcctf5LXeEnUGFh8SHGjABKTc4dNfY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ow54cjhg1yh2OguAXr49C70deAApgwfbG7rjCg4J1+ee1Sy9sVXM5+k5xw9KDOBJ8p+nMl/LKIcUV1HlIQQQGFPdfcmiv/vXJ8qvBrW/myx7s4wnlUwq2WPNiApAJyHniOsxi/FtNxwYqlhDFQ0TVCqD9Ne6Q51c4Gly9Fkas68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IizGd6W0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765200550; x=1796736550;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WBjb6TegpC6Gfgcctf5LXeEnUGFh8SHGjABKTc4dNfY=;
  b=IizGd6W0kbWvyagGdW/pYuU3x85ZXTLXomxQtI3Tq6Q2o4+Al59ckP9N
   4KCMnv71GQ3vqPnwUtnBzts7Hr5J1l6iV51ktju09xP5DFxsfSV5e15zS
   LU0figa/d0+gkYb4mEzlLZb7HfdncoHRgRMBtPeXZDYEihzXokuqCQPmr
   XWXCjH2wR5ZwqACE0xD6hBvXVLPIXoJ0CAGI00QtpqPuIlzdoXzuW9wQI
   dFf/OHl8Qg/kKuNPt1MeLDR+5OQ0eJj78rt6qDhUNgMMqq5xIAdB24FGV
   KSU2xphY9djLQtxKFUsYUewYuFeH7bP8WCdSTctFmlL4msc9B/1iO4LPG
   Q==;
X-CSE-ConnectionGUID: OQYd222tRLSJm/xVQSRtYg==
X-CSE-MsgGUID: BjNRzQhjSsyPMBqLvn+HYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67177531"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="67177531"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 05:29:08 -0800
X-CSE-ConnectionGUID: 8oX6ei5rRqSdJADh+sXjhw==
X-CSE-MsgGUID: iAbSLs9CSKCCYf/bATNsMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="195987567"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 05:29:05 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Dec 2025 15:29:01 +0200 (EET)
To: Christian Marangi <ansuelsmth@gmail.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Dan Williams <dan.j.williams@intel.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Jonathan Cameron <jonathan.cameron@huawei.com>, 
    Magnus Damm <damm@igel.co.jp>, LKML <linux-kernel@vger.kernel.org>, 
    "Rob Herring (Arm)" <robh@kernel.org>, stable@vger.kernel.org, 
    linux-pci@vger.kernel.org
Subject: Re: [PATCH] resource: handle wrong resource_size value on zero
 start/end resource
In-Reply-To: <20251207215359.28895-1-ansuelsmth@gmail.com>
Message-ID: <9c126c75-1d50-6315-4a15-e58e1adf20e4@linux.intel.com>
References: <20251207215359.28895-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 7 Dec 2025, Christian Marangi wrote:

> Commit 900730dc4705 ("wifi: ath: Use
> of_reserved_mem_region_to_resource() for "memory-region"") uncovered a
> massive problem with the usage of resource_size() helper.
> 
> The reported commit caused a regression with ath11k WiFi firmware
> loading and the change was just a simple replacement of duplicate code
> with a new helper of_reserved_mem_region_to_resource().
> 
> On reworking this, in the commit also a check for the presence of the
> node was replaced with resource_size(&res). This was done following the
> logic that if the node wasn't present then it's expected that also the
> resource_size is zero, mimicking the same if-else logic.

So what's the actual resource that causes this ath11 regression? You seem 
possess that knowledge as you knew to create this patch.

of_reserved_mem_region_to_resource() does use resource_set_range() so how 
did the end address become 0? Is there perhaps some other bug being 
covered up with this patch to resource_size()?

> This was also the reason the regression was mostly hard to catch at
> first sight as the rework is correctly done given the assumption on the
> used helpers.
> 
> BUT this is actually not the case. On further inspection on
> resource_size() it was found that it NEVER actually returns 0.
>
> Even if the resource value of start and end are 0, the return value of
> resource_size() will ALWAYS be 1, resulting in the broken if-else
> condition ALWAYS going in the first if condition.
> 
> This was simply confirmed by reading the resource_size() logic:
> 
> 	return res->end - res->start + 1;

???

resource_size() does return 0 when ->start = 0 and ->end = - 1 which is 
the correctly setup of a zero-sized resource (when flags are non-zero).

> Given the confusion,

There's lots of resource setup code which does set resource end address 
properly by applying -1 to it.

> also other case of such usage were searched in the
> kernel and with great suprise it seems LOTS of place assume
> resource_size() should return zero in the context of the resource start
> and end set to 0.
>
> Quoting for example comments in drivers/vfio/pci/vfio_pci_core.c:
> 
> 		/*
> 		 * The PCI core shouldn't set up a resource with a
> 		 * type but zero size. But there may be bugs that
> 		 * cause us to do that.
> 		 */
> 		if (!resource_size(res))
> 			goto no_mmap;

This place does not tell you what ->end is expected to be set? Where did 
you infer that information?

I suspect this code would want to do resource_is_assigned() (which doesn't 
exists yet but would check only res->parent != NULL) or base the check on 
IORESOURCE_UNSET|IORESOURCE_DISABLED.

Often using resourse_size() (or a few other address based checks) in 
drivers is misguided, what drivers are more interested in is if the 
resource is valid and/or properly in the resource tree (assigned by 
the PCI core which implies it's valid too and has a non-zero size), not so 
much about it's size. As you can see, size itself not even used here at 
all, that is, this place never was interested in size but uses it as a 
proxy for something else (like also many other drivers do)!

> It really seems resource_size() was tought with the assumption that
> resource struct was always correctly initialized before calling it and
> never set to zero.
> 
> But across the year this got lost and now there are lots of driver that
> assume resource_size() returns 0 if start and end are also 0.

Who creates such resources?

If flags are non-zero, those places should be fixed (I'm currently fixing 
one case from drivers/pci/probe.c thanks to you bringing this up :-)) but 
I think the number of places to fix are fewer than you seem to think. I 
read though all end assignments in PCI core and found only this single(!) 
problem there.

> To better handle this and make resource_size() returns correct value in
> such case, add a simple check and return 0 if both resource start and
> resource end are zero.
>
> Cc: Rob Herring (Arm) <robh@kernel.org>
> Cc: stable@vger.kernel.org
> Fixes: 1a4e564b7db9 ("resource: add resource_size()")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  include/linux/ioport.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 9afa30f9346f..1b8ce62255db 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -288,6 +288,9 @@ static inline void resource_set_range(struct resource *res,
>  
>  static inline resource_size_t resource_size(const struct resource *res)
>  {
> +	if (!res->start && !res->end)
> +		return 0;

This looks wrong to me.

Lets try to fix the resource setup side instead. The real problem is in 
any code that sets ->end to zero when it wanted to set resource size to 
zero, which are not the same thing. To make it simpler (no need to 
manually apply -1 to the end address) and less error prone, we have 
helpers resource_set_range/size() and DEFINE_RES() that handle applying -1 
correctly.

> +
>  	return res->end - res->start + 1;
>  }
>  static inline unsigned long resource_type(const struct resource *res)


Taking this suggestion from your other email:

> if (!res.flags && !res.start && !res.end)
> 	return 0;

IMO, the caller shouldn't be calling resource_size() at all when 
!res.flags as that indicates the caller is confused and doesn't really 
know what it is even checking for. If a driver does even know if the 
resource is valid (has a valid type) or not, it should be checking that 
_first_ (it might needs the size for valid resources but it should IMO 
still check validity of the resource first).

Also, as mentioned above, some/many drivers are not fundamentally 
interested in validity itself but whether the resource is assigned to the 
resource tree.

For valid resources, this extra check is entirely unnecessary.

I'd be supportive of adding

WARN_ON_ONCE(!res.flags)

...here but that will be likely a bit too noisy without first auditting 
many places (from stable people's perspective a triggering WARN_ON() => 
DoS). But that's IMO the direction kernel code should be heading.

-- 
 i.


