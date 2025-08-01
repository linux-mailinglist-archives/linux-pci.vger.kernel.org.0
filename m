Return-Path: <linux-pci+bounces-33307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB76B18624
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 19:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8B1A7A6E4F
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 16:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3621DCB09;
	Fri,  1 Aug 2025 17:00:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A291AC44D;
	Fri,  1 Aug 2025 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754067640; cv=none; b=UoXmBdJr5+89wj2uQNfx32OjXKIMfbjWko3L48uUsczcpSHpvIzNmhqdR/8yvHimb+HKRfI++kx2jJvP9aKuhfpaphRu6c+S2X1D95dOQgu8GDYE3JvneA3H469CA+LuvmrFOxCEjp+Iq5LIy16zV/NqK3E/gdJufXfvDef2j1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754067640; c=relaxed/simple;
	bh=PykCCBJs105n+LC2iU2zPr6kU0wR30+97kLkwypCJZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOQj2pDITMDPsK3B56dYpdaRuphA1Cv4stDiQh6g7kra7S8bvpZp8tAxVCqhZQ1GDtAjADuLwNH3zTYBgXTa9oTHA2+gBGC3g9U61rq6pxUzMkUtSE7+becbltRWDE+5IUbB70yKZwKsaIgmCQIKTn+f5tzknm2CRL074ipt1Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae35f36da9dso386885266b.0;
        Fri, 01 Aug 2025 10:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754067637; x=1754672437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfCYUUeNzqTP+LwSzZh8YLP72/OXU9Xwsponm3y55nE=;
        b=qJAgddShz5EUoaefwc2/bFcDqcj0a2jX6CWUWIKOpTQBYiSg7aZndRhl0ugx9TfsZh
         UD7ujVN3nxaGmURENhi7VjOJwdpc+cyl4H/2LN3qPSMS/e+eVpZcCSrlNEzyHTkzAZW8
         UL4WT8xwiNl1+Fh1cL+AWlx7WuJ2c0zKy9rknsm8cwlvdYsuqXyZG1K2pGPScscag2tn
         7210uK+56mMi93ZH4HgKJ8MjBTcP6PF9AsRLcjcVUiD1/5k1WWa/7V/01ydhbFD6swva
         bQIsMn9jrnyxusiQlFYmBXg3gm0MMfTDuPomnCdADKdVwGX6A/l0s/2zjVqLei23qIlr
         LnjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU56DVN3oVnVdVTIs8+jFAcjV+3hwJyVxYEjXVbf/qxbfjpb2OCnXKBEcpuyH6BwieSqThMxAb+y2v0@vger.kernel.org, AJvYcCUOGFoL3OCoWvy4b8I0wakWA4/Qyvr3coNqY1HSKe5q4jW1sNkDTAg5b7aSqQtJEZ3nXtfyXGff1QwgFNQ6@vger.kernel.org, AJvYcCVB/SDZQ8SaUtrlALKYqxiZALWxBCSTMqFBRAKzoLewEwW8pp0EP8fbeDBKhiLM82f5YQutZnTM//wMWA==@vger.kernel.org, AJvYcCWB8CQ+kLnZ+r6uYg4yZLpaZYZ+1cSnnFR9OHWC8RoSFudytdz0r8AAFXalwl9cz1u4Qd6l985OdJAv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+CordjXFJUw/G81ItZec9hbkZbQ6re8L30kArwCQX3M7d8CyZ
	688ClHFsaX7UlidRYFLoCZQQpJHJZSsygWj2Ti507N1BuyJYuf+cwf63
X-Gm-Gg: ASbGncudsxMb9Iw0MIQn6KWSr3mwn4rJ5e9Cg0wQdmrKy30wiXn6Shv+m+VNMSH4nzT
	p28wS5sLg3FD4xLSbI4DoK+VpwaL5WkfIZcCKXOIPzevFFhepiZudiXDmflnSPFGosEosqKSCXz
	l0W0TB21FVtDXwKvPsomrNgoGIZbADBxpkcszELku2NvKODRGLS2YskRGVCL963E1duVrAUjDDF
	KotetEl+XzwSaDOLBBMZ7JW988kIxiYe1+aIWQzwylG/83z9rZuAN1VNEipE1ki+MhZt1zfGkRM
	XlI4si6VZ5/xyQwqzJhqG/s9CGw1IMKXt4K/QUGtAMusF+OJILUnr0PSerJPa+bZNuwD8XrRBXW
	wS3hjBwcItoW2Eg==
X-Google-Smtp-Source: AGHT+IGpq60CKY3QvKTsc9HB8eSUqXk3f/gsXwEntEJaK1GEY6vGj3gABeOiP8jIzbPXR/Pw3PU1uA==
X-Received: by 2002:a17:907:7fa3:b0:af9:2bb9:ea36 with SMTP id a640c23a62f3a-af93ffbe3c3mr59933566b.7.1754067637034;
        Fri, 01 Aug 2025 10:00:37 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91b36e91dsm295781466b.69.2025.08.01.10.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 10:00:36 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:00:33 -0700
From: Breno Leitao <leitao@debian.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, osandov@osandov.com, 
	xueshuai@linux.alibaba.com, konrad.wilk@oracle.com, linux-edac@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, kernel-team@meta.com, osandov@fb.com
Subject: Re: [PATCH v4] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <buhwuankenpnvmio6jeoxverixoyfpn2eh62ix7vzxw7xvlxcv@rpibcrufr2yg>
References: <20250801-vmcore_hw_error-v4-1-fa1fe65edb83@debian.org>
 <85663f65-d746-4e2c-b8a6-d594d9d0ba42@intel.com>
 <f3yl424iqiyctgz4j36hzjrhkgae3a2h5smhalm2qbmq3nrpzd@oeuprthscfez>
 <0c045f1b-44d0-430c-9e8a-58b65dd84453@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c045f1b-44d0-430c-9e8a-58b65dd84453@intel.com>

hello Dave,

On Fri, Aug 01, 2025 at 09:24:43AM -0700, Dave Hansen wrote:
> On 8/1/25 08:13, Breno Leitao wrote:
> > On Fri, Aug 01, 2025 at 07:52:17AM -0700, Dave Hansen wrote:
> >> On 8/1/25 05:31, Breno Leitao wrote:
> >>> Introduce a generic infrastructure for tracking recoverable hardware
> >>> errors (HW errors that are visible to the OS but does not cause a panic)
> >>> and record them for vmcore consumption.
> >> ...
> >>
> >> Are there patches for the consumer side of this, too? Or do humans
> >> looking at crash dumps have to know what to go digging for?
> >>
> >> In either case, don't we need documentation for this new ABI?
> > 
> > I have considered this, but the documentation for vmcoreinfo
> > (admin-guide/kdump/vmcoreinfo.rst) solely documents what is explicitly
> > exposed by vmcore, which differs from the nature of these counters.
> > 
> > Where would be a good place to document it?
> 
> I'm not picky. But you also didn't quite answer the question I was asking.
> 
> Is this new data for humans or machines to read?

I would say that the main consumer for this are post-mortem tools that
collect information of the vmcore and do diagnostic and correlation.
This is a common tooling for cloud providers, AFAIK.

In my work environment, there is a script that runs `drgn` on every
vmcore to capture information that would help operator to address the
problem. The information that this patch is proposing adds another field
that would help to potentially correlate crashes with recoverable error.

> >> Does "MCE" mean anything outside of x86?
> > 
> > AFAIK this is a MCE concept.
> 
> I'm not really sure what that response means.
> 
> There are two problems here. First is that HWERR_RECOV_MCE is defined in
> arch-generic code, but it may never get used by anything other than x86
> when CONFIG_X86_MCE.
> 
> That also completely wastes space in your data structure when
> HWERR_RECOV_MCE=n. Not a huge deal as-is, but it's still a bit sloppy
> and wasteful.

Would a solution like this look better?

	enum hwerr_error_type {
		HWERR_RECOV_CPU,
		HWERR_RECOV_MEMORY,
		HWERR_RECOV_PCI,
		HWERR_RECOV_CXL,
		HWERR_RECOV_OTHERS,
	#ifdef CONFIG_X86_MCE
		HWERR_RECOV_MCE,
	#endif
		HWERR_RECOV_MAX,
	};

Or, would you prefer to have HWERR_RECOV_ARCH and keep it always there?

> >> I'd also love to hear more about _actual_ users of this. Surely, someone
> >> hit a real world problem and thought this would be a nifty solution. Who
> >> was that? What problem did they hit? How does this help them?
> > 
> > Yes, this has been extensively discussed in the very first version of
> > the patch. Borislav raised the same question, which was discussed in the
> > following link:
> > 
> > https://lore.kernel.org/all/20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local/
> 
> When someone raises a concern, we usually try to alleviate the concern
> in a way that is self-contained in the next posting. A cover letter with
> a full explanation would be one place to put the reasoning, for example.
> 
> But expecting future reviewers to plod through all the old threads isn't
> really feasible.

Sorry. I tried to improve the documentation and wrote the following
message to the commit message, which was clearly not enough.

	This helps fleet operators quickly triage whether a crash may be
	influenced by hardware recoverable errors (which executes a uncommon
	code path in the kernel), especially when recoverable errors occurred
	shortly before a panic, such as the bug fixed by
	commit ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them
	when destroying the pool")

For next commit I will add a cover-letter, with the summary of the
details of that discussion.

Thanks for the review and suggestions,
--breno


