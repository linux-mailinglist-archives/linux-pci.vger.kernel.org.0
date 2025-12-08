Return-Path: <linux-pci+bounces-42759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AE5CAD540
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 14:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A349D302F69A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 13:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF02223323;
	Mon,  8 Dec 2025 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTNhmPHs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E617F20298D
	for <linux-pci@vger.kernel.org>; Mon,  8 Dec 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765201661; cv=none; b=R96DVkUNHBG3a9gC5SXSVqz82kTbnyZPr1EGtxClUGmNRuOigTulHO4WENbjcsB717m/krLVWsMe08k5pQlwQgOehIO0Qx5wGMmLyimyHpUf8UhiXRxY9i/TA81RWNLF/dzyl4MX+JHZRznK6tWwXu9I9HFHTMDSgneza+CoSFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765201661; c=relaxed/simple;
	bh=w8gzdfx6JQvIZ0Oqn3q2Q4JHYq2E2fO6PxK6hIxg6+Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNRr0jZ2L2p3JINkcQKnaYBqaj9mObOifXeWm9HhKOC787djAsP593GrxyBuiHc+bve6BOOBjcpi8IQc62sxmZFx2LAng7WDrs3ecXyO5dm946CUVRvVzwdlJAfBJI2hmNpfXYDE4wVCHURZla+tQ9jU85jDXuQ6Cw5bYV8z0rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTNhmPHs; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42e29739ff1so1840672f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Dec 2025 05:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765201658; x=1765806458; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t6wU/Qh8pwHSSzJMjj4mzq4XUPkn0V1TiolBocJSBw4=;
        b=VTNhmPHs9fBI+rVX2UI55JFR6oVa9sKZkxupxZOvu/Ogdrohfztc5fhZHdfor0d1Nt
         oq+GVreeNbCERHFRiAaXG0yCmxPtNom46aniYhOKHzKnXGZhoxMsgjMFuslgLg2Woiag
         S5yV6aK82KLeyVIqhR8BPBu4gVWTYUixXR7fc28VQS8+UdYhmdEWED7qY5EDNR1Y29V2
         43rX2BMIP2Ugf5IbLFwQ8p3a0YQyB1+SUveC3DLh8EkOgCF7B+WD/Pwp/LX6UJMWcyaN
         caQjBzbbYRhPOAE128ab7J9u1uBKRr8SIQ3Lq+gTpFNUDiF9G2izwmqA8FextAUP7hq0
         2qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765201658; x=1765806458;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6wU/Qh8pwHSSzJMjj4mzq4XUPkn0V1TiolBocJSBw4=;
        b=TnFUYpjYXX4fpPz43haeDvO+wyl1I4YS0ZM5Nd6T/+9yRiFxsD9nPgV3cUI+eYbWIj
         RcyT1mHNcuKuX6S/waFntwZrE6egYQpjdhQqhf/60wAuMOb9gUZlPTyRk/qT8YfOiD+x
         +WjsMaMeXxWxMbVvc/kiESjte9/Dck+MXZggsTkJMXErZ1uhAYmVnVMfi8DhpARGB0Mc
         2Srka1bSte8KGWYBJOQ1S3n8JTdFhOsRLC2aN8WOPlGSyOCFnS+gr1h1L7XVl6vjBpkx
         pMOS+jcBgKi4nWs0ghL3OBOuihnctKZilr+chrmpt+nOjokAAcEHFbMwfdzsvZ4dWKa3
         QZ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRoNIjnz7o2R2NjKDQOgvwVMeRo+YYbBcWzKRGvdjecrfKs6WtVlNSzq+mvWeV2uwHQQosYGJ+DZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ct9umWvEaY/wlJimjT57eHK/SVSk0k0RaTJR3rxxKQj0AeJY
	nntdNPhlbi926boeiXcJmKm3a8mtw4hxwS/A8uN7WSkvREosI9UEbAUa
X-Gm-Gg: ASbGncsdg9k2ZrYDstfjQczMZUDZgM1i6N5lUGhAziGewMkyPq9qh9gJwpa4pRWN67h
	y79ebmKD0YGTiptP3YZKnLl6ZehRxwu67h9nEH/sy7rGpRi5Nmq5X34AdQSDi/RFXOd/isPG5oU
	QfxMDy7B3rRsWMhISI+GE9Pg52/3uuhulTm/0f6YUvfz1Lp/lzG56Y/wjGiXCK79uka0juX3ueM
	zdPHDm9ZLVnzgA46RVCp2q+luay0yEwNluZFgHVMk1jJVFGaHQjEKZUCp24hSdA2ezCEBuEUXTe
	UPn+jA3y9m1TwCZUTaQTENG/Ly6VpYZBA41KhEERgg7E8LUd8sU3ByVor64OgDsDq2xs4duJXWB
	avOUn+yIYoM43bwmg6tj7bBXXTyQuIFk36bfJsWZ17rm3mOaElejzU9BMmfxatuUGMMjJSqpjjz
	C2XYvtJUFCZGxMtF7qH4jCyVTWD7ocug8vcs4Vq+4=
X-Google-Smtp-Source: AGHT+IFj+2cOI4kjvHler5IESWTnnJEbnElZQx8nQOnGL3+h4sAa+Kibogq8Dpac3faT3gjHlpDegA==
X-Received: by 2002:a05:6000:40dc:b0:429:a89d:ecef with SMTP id ffacd0b85a97d-42f78875bbamr18362849f8f.13.1765201657918;
        Mon, 08 Dec 2025 05:47:37 -0800 (PST)
Received: from Ansuel-XPS. (93-34-88-81.ip49.fastwebnet.it. [93.34.88.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d22249esm25647216f8f.25.2025.12.08.05.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 05:47:37 -0800 (PST)
Message-ID: <6936d6f9.5d0a0220.2a4b1f.ab28@mx.google.com>
X-Google-Original-Message-ID: <aTbW9w11QYqIvStQ@Ansuel-XPS.>
Date: Mon, 8 Dec 2025 14:47:35 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Magnus Damm <damm@igel.co.jp>, LKML <linux-kernel@vger.kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] resource: handle wrong resource_size value on zero
 start/end resource
References: <20251207215359.28895-1-ansuelsmth@gmail.com>
 <9c126c75-1d50-6315-4a15-e58e1adf20e4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c126c75-1d50-6315-4a15-e58e1adf20e4@linux.intel.com>

On Mon, Dec 08, 2025 at 03:29:01PM +0200, Ilpo Järvinen wrote:
> On Sun, 7 Dec 2025, Christian Marangi wrote:
> 
> > Commit 900730dc4705 ("wifi: ath: Use
> > of_reserved_mem_region_to_resource() for "memory-region"") uncovered a
> > massive problem with the usage of resource_size() helper.
> > 
> > The reported commit caused a regression with ath11k WiFi firmware
> > loading and the change was just a simple replacement of duplicate code
> > with a new helper of_reserved_mem_region_to_resource().
> > 
> > On reworking this, in the commit also a check for the presence of the
> > node was replaced with resource_size(&res). This was done following the
> > logic that if the node wasn't present then it's expected that also the
> > resource_size is zero, mimicking the same if-else logic.
> 
> So what's the actual resource that causes this ath11 regression? You seem 
> possess that knowledge as you knew to create this patch.
>

I'm not gatekeeping the information. Just trying to get involved as much
people as possible in checking this.

This helper is used in generic OF and PCI code and since there is the
combo 2008 code + no comments, then it's sensible to make sure no
confusion was applied across the year.

> of_reserved_mem_region_to_resource() does use resource_set_range() so how 
> did the end address become 0? Is there perhaps some other bug being 
> covered up with this patch to resource_size()?
> 

This IS EXACTLY the problem HERE. There is the assumption that
resource_size() MUST be used ALWAYS after a resource struct is used.

But this is not alywas the case... nothing stops to call resource_size()
on a a local

struct resource res = {}

and assume resource_size() returning 0 (as struct resource is all zero
and assuming logically the size to be zero) (this assumption has been
already proved to be wrong by the previous message but it's very common
to assume that an helper called on an all zero struct returns 0 if the
subject is about size or range of address)

> > This was also the reason the regression was mostly hard to catch at
> > first sight as the rework is correctly done given the assumption on the
> > used helpers.
> > 
> > BUT this is actually not the case. On further inspection on
> > resource_size() it was found that it NEVER actually returns 0.
> >
> > Even if the resource value of start and end are 0, the return value of
> > resource_size() will ALWAYS be 1, resulting in the broken if-else
> > condition ALWAYS going in the first if condition.
> > 
> > This was simply confirmed by reading the resource_size() logic:
> > 
> > 	return res->end - res->start + 1;
> 
> ???
> 
> resource_size() does return 0 when ->start = 0 and ->end = - 1 which is 
> the correctly setup of a zero-sized resource (when flags are non-zero).
> 

Again IF the resource struct is correctly init, in the case of
kmalloc-ed stuff or local variables init to zero, then you quickly
trigger the bug as both start and end will be zero.

Also I honestly found some difficulties finding where end is set to -1.

I actually found case in OF code where both start and end are set to -1
resulting.

Can you point me where is this init code?

> > Given the confusion,
> 
> There's lots of resource setup code which does set resource end address 
> properly by applying -1 to it.
> 
> > also other case of such usage were searched in the
> > kernel and with great suprise it seems LOTS of place assume
> > resource_size() should return zero in the context of the resource start
> > and end set to 0.
> >
> > Quoting for example comments in drivers/vfio/pci/vfio_pci_core.c:
> > 
> > 		/*
> > 		 * The PCI core shouldn't set up a resource with a
> > 		 * type but zero size. But there may be bugs that
> > 		 * cause us to do that.
> > 		 */
> > 		if (!resource_size(res))
> > 			goto no_mmap;
> 
> This place does not tell you what ->end is expected to be set? Where did 
> you infer that information?
> 
> I suspect this code would want to do resource_is_assigned() (which doesn't 
> exists yet but would check only res->parent != NULL) or base the check on 
> IORESOURCE_UNSET|IORESOURCE_DISABLED.
> 
> Often using resourse_size() (or a few other address based checks) in 
> drivers is misguided, what drivers are more interested in is if the 
> resource is valid and/or properly in the resource tree (assigned by 
> the PCI core which implies it's valid too and has a non-zero size), not so 
> much about it's size. As you can see, size itself not even used here at 
> all, that is, this place never was interested in size but uses it as a 
> proxy for something else (like also many other drivers do)!
> 

Yes I agree that resource_size() is not the correct way to check if a
resource is valid but it seems to be used for this task in some code.

> > It really seems resource_size() was tought with the assumption that
> > resource struct was always correctly initialized before calling it and
> > never set to zero.
> > 
> > But across the year this got lost and now there are lots of driver that
> > assume resource_size() returns 0 if start and end are also 0.
> 
> Who creates such resources?
> 

It's more a matter of using resource_size() in place where struct
resource is optionally used. 

> If flags are non-zero, those places should be fixed (I'm currently fixing 
> one case from drivers/pci/probe.c thanks to you bringing this up :-)) but 
> I think the number of places to fix are fewer than you seem to think. I 
> read though all end assignments in PCI core and found only this single(!) 
> problem there.
> 

Thanks a lot for checking the PCI code, that is one of my concern
subsystem where this might be problematic. The other is the OF code.

> > To better handle this and make resource_size() returns correct value in
> > such case, add a simple check and return 0 if both resource start and
> > resource end are zero.
> >
> > Cc: Rob Herring (Arm) <robh@kernel.org>
> > Cc: stable@vger.kernel.org
> > Fixes: 1a4e564b7db9 ("resource: add resource_size()")
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  include/linux/ioport.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > index 9afa30f9346f..1b8ce62255db 100644
> > --- a/include/linux/ioport.h
> > +++ b/include/linux/ioport.h
> > @@ -288,6 +288,9 @@ static inline void resource_set_range(struct resource *res,
> >  
> >  static inline resource_size_t resource_size(const struct resource *res)
> >  {
> > +	if (!res->start && !res->end)
> > +		return 0;
> 
> This looks wrong to me.
> 

Yes it's indded wrong as I didn't think of case where start and end can
match and correctly return a size of 1.

> Lets try to fix the resource setup side instead. The real problem is in 
> any code that sets ->end to zero when it wanted to set resource size to 
> zero, which are not the same thing. To make it simpler (no need to 
> manually apply -1 to the end address) and less error prone, we have 
> helpers resource_set_range/size() and DEFINE_RES() that handle applying -1 
> correctly.
> 

OK! Thanks for the pointer so there is a DEFINE_RES() for local
variables!

> > +
> >  	return res->end - res->start + 1;
> >  }
> >  static inline unsigned long resource_type(const struct resource *res)
> 
> 
> Taking this suggestion from your other email:
> 
> > if (!res.flags && !res.start && !res.end)
> > 	return 0;
> 
> IMO, the caller shouldn't be calling resource_size() at all when 
> !res.flags as that indicates the caller is confused and doesn't really 
> know what it is even checking for. If a driver does even know if the 
> resource is valid (has a valid type) or not, it should be checking that 
> _first_ (it might needs the size for valid resources but it should IMO 
> still check validity of the resource first).
> 
> Also, as mentioned above, some/many drivers are not fundamentally 
> interested in validity itself but whether the resource is assigned to the 
> resource tree.
> 
> For valid resources, this extra check is entirely unnecessary.
> 
> I'd be supportive of adding
> 
> WARN_ON_ONCE(!res.flags)
> 
> ...here but that will be likely a bit too noisy without first auditting 
> many places (from stable people's perspective a triggering WARN_ON() => 
> DoS). But that's IMO the direction kernel code should be heading.
> 

I'm more than happy to send a v2 of this fixing ath11k and adding the
WARN_ON_ONCE with res.flags.

Seems the only correct way to track this down and improve this in the
next kernel versions.

Also thanks to Andy and you for explaining this and reasurme me there
wasn't a big bug around this helper but just some minor logical
confusion.

Do you agree on the plan for v2? (we can assume the noise won't be so
much as I expect only SOME driver to be affected by this problem) (I
hope)

> -- 
>  i.
> 

-- 
	Ansuel

