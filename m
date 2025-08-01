Return-Path: <linux-pci+bounces-33298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAA8B184BB
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 17:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 848B47B6844
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 15:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC349267F48;
	Fri,  1 Aug 2025 15:13:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2916C248868;
	Fri,  1 Aug 2025 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754061213; cv=none; b=QpMkHlXAeCqNbbPxY+/OvhPrGhHLI4FXqxtWozddbNNCFpcZpkd2H+jhTSJS1CuY+wA0kgTYIRzb5BYK3Bru7EnPY1mWfKJBsp9yPexLzx6UCTQYWJC0bFjEVwh0lr1CwBVNmyHaKQMqvVl3aoJYccqa4VUG5iJWlQJ8RUOVNSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754061213; c=relaxed/simple;
	bh=nBk+x/sL+91shEFy5WplqXsJOJbjQ0q5hTrrJ7agcU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ycaz4mRj2rsbP2/TFQSKX/yNgLMKOuiPOdig/6PCOVtVA1uYU+0kxVxgsggzqQXdP4WfiOQwD9QQvNyjQXDycgC8nJfBrjLVB5YfEDkCNX+UxIA/LHCxkHdbSrUMFP47SD9xa7vwlPNIxo6U0wu9JDdQVp1vb6tnNL+gSt5WcS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af8f5e38a9fso339813466b.0;
        Fri, 01 Aug 2025 08:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754061210; x=1754666010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLvAFPQ8DYraj8LtMTWkc3DYDv2AWsFej7nsT5sUEtI=;
        b=nRdzZ//A48eYJ6c4aZ46GzshZ7kIezOhRk9Yj7iejYBRu+af5wi3PKx/emb6NRcHPy
         8kPF+3kVqzEkF3DSuBia0EFJPvzU9nl98oDBLFui3e6VvQnI37+7UgeJW1ou0CxAkyGF
         5fxGtYPFCTWVGJfAH8NVGcpZG2If2CmhFYRqzHsjvPxxVEdjwRnisq2QSn93gjv57/lp
         uETo2UCvN7gYpUub+G1s95cEjjVvPlgceKDX8E1Lei89LltBXQx7PDOeM9h/TtMBQAk8
         iHeFFZyQGj3Jf5z2n8KosUx5tCabTFM+uOIxgKaYR94AT1IIgo0h7EhNF7pfcMPm+TJu
         Km0g==
X-Forwarded-Encrypted: i=1; AJvYcCV9AuUlWX8k8+T1AWZkGIfoWA2hrw/MQCUC5nYwLuI2LLUl9sqZ0DDaGer4O8JwgUaFv61e4juDDaHvHg==@vger.kernel.org, AJvYcCWex+DpUCqmAC75d3GVfBLyPJ2usWgxEdwXTHDNvhJBsWDmg0uqxP91l+/olNdvPVmozlTE2+KKlE0R@vger.kernel.org, AJvYcCWxdZUYCxH3lm8h9vBT5wZZOQBUxVP7Dmd1pDU4jmJhDj9XSnuud4cxlprjBGirkSwzSqJ6qIRjBjZT@vger.kernel.org, AJvYcCX3BHT7enYuvYS94XDGCsumeeqsVAbJGY/PKqz3AuWZVn2Zi0giY10u1XvgiFqXujVMV4xijOCo2kt8GKAk@vger.kernel.org
X-Gm-Message-State: AOJu0YydrK7Z6++57/OEMlVaI0gEiwDZ7SBqt3CNCKY85bCyDKwK41TV
	D6bNTTonpWbnxE8+5l81rW1DLaeWMorIuv9swhuXp6KZqzTMwTleEf6m
X-Gm-Gg: ASbGncvPL1gClnWPHrmAfYezdMKWqla8OIN3VSWet0oXFDRUEe/yle0rcCTkVLwssFe
	toEknconVpV/q1cW17EnmMqEuYtkR8Sj4O+3RT0h4khYYq1w29CKg2jYdEc2ZUEtha8zhxwkyZ4
	2v0K4h0RSui3oLMxHSJusxxchM1tk4h/MSBo3A4eNuWAw8sd787zmPUHrnXQPfR1Mn0lHT60oFc
	XgUm/0fpsom6yvJHBhj/FtTFxEA5/SiJ5EIfPnyMDkA+2ieBxkyl9723FsvSKdMTIvgTj1BDYzO
	1ZMLr0CZbL07ImZuAJ7AA/wNziftHqp5rzBwyrjlR/LI5/kwTfsr6Uw1vlOhQZ3Ls8sI7FVdGtd
	vWfGiZqaccAZRPw==
X-Google-Smtp-Source: AGHT+IHxwNCV+mxtZBzz5cvZjpfuoqtgwb9V8VUnUiYcYZ36deiu6WNQjZZGI0DAGbFT+RybIxFgAA==
X-Received: by 2002:a17:907:9706:b0:ae3:cd73:efde with SMTP id a640c23a62f3a-af9401b0c5emr13383466b.44.1754061210083;
        Fri, 01 Aug 2025 08:13:30 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a24062esm303137466b.126.2025.08.01.08.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 08:13:29 -0700 (PDT)
Date: Fri, 1 Aug 2025 08:13:26 -0700
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
Message-ID: <f3yl424iqiyctgz4j36hzjrhkgae3a2h5smhalm2qbmq3nrpzd@oeuprthscfez>
References: <20250801-vmcore_hw_error-v4-1-fa1fe65edb83@debian.org>
 <85663f65-d746-4e2c-b8a6-d594d9d0ba42@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85663f65-d746-4e2c-b8a6-d594d9d0ba42@intel.com>

Hello Dave,

On Fri, Aug 01, 2025 at 07:52:17AM -0700, Dave Hansen wrote:
> On 8/1/25 05:31, Breno Leitao wrote:
> > Introduce a generic infrastructure for tracking recoverable hardware
> > errors (HW errors that are visible to the OS but does not cause a panic)
> > and record them for vmcore consumption.
> ...
> 
> Are there patches for the consumer side of this, too? Or do humans
> looking at crash dumps have to know what to go digging for?
> 
> In either case, don't we need documentation for this new ABI?

I have considered this, but the documentation for vmcoreinfo
(admin-guide/kdump/vmcoreinfo.rst) solely documents what is explicitly
exposed by vmcore, which differs from the nature of these counters.

Where would be a good place to document it?

> > @@ -1690,6 +1691,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
> >  	}
> >  
> >  out:
> > +	/* Given it didn't panic, mark it as recoverable */
> > +	hwerr_log_error_type(HWERR_RECOV_MCE);
> > +
> 
> Does "MCE" mean anything outside of x86?

AFAIK this is a MCE concept.

> I wonder if this would be better left as "HWERR_RECOV_ARCH" or something.

Sure. I can update it to be more generic.

> > +void hwerr_log_error_type(enum hwerr_error_type src)
> > +{
> > +	if (src < 0 || src >= HWERR_RECOV_MAX)
> > +		return;
> > +
> > +	/* No need to atomics/locks given the precision is not important */
> 
> Sure, but it's not even more lines of code to do:
> 
> 	atomic_inc(&hwerr_data[src].count);
> 	WRITE_ONCE(hwerr_data[src].timestamp, ktime_get_real_seconds());
> 
> So why not?

Sure, we can do that, I will update it also.

> > +	hwerr_data[src].count++;
> > +	hwerr_data[src].timestamp = ktime_get_real_seconds();
> > +}
> > +EXPORT_SYMBOL_GPL(hwerr_log_error_type);
> 
> I'd also love to hear more about _actual_ users of this. Surely, someone
> hit a real world problem and thought this would be a nifty solution. Who
> was that? What problem did they hit? How does this help them?

Yes, this has been extensively discussed in the very first version of
the patch. Borislav raised the same question, which was discussed in the
following link:

https://lore.kernel.org/all/20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local/

Thanks for the review,
--breno

