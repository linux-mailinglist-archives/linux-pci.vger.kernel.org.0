Return-Path: <linux-pci+bounces-9072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FEC912456
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 13:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C251C24F13
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 11:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF44172BCB;
	Fri, 21 Jun 2024 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gX4TUC9J"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B644B171E41
	for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2024 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718970457; cv=none; b=VB5LPklr/QaomaAW7YZNPtmkfiO32DlpRlM06pTlJQUJfemFB/k82RKHTGI+y8RkUNG1rRNeuyLYQPFyK81p1EXfTqznxVNPUDzSck+FUQUFq4xJLD6RXAVWcMOHEQVABiwsfyKq/A+YffM1ajyhTySo6TV05/C51s96IFFKgwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718970457; c=relaxed/simple;
	bh=BlGbgmoF+iZ4BHtGoLltAMguabDdtH20E6K3YI6aJHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDvAoRsz0zE+CqBvz3lPjOwVl7OoWP0qxjB/47LAehjlPZTTq3PN+QO31UJxN8zrL8H9vkSp0siBJLbQODtOy1/NuyW+0/WJ6MUITX19Q2TqcbdZfKLxHnDsh9/i9UN+6kvE/kOYSfzmTrZKOkJBctXM8m5Rgtd0/B7b9+wwlBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gX4TUC9J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718970454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbVc+Fc7RR7j8FqltSlekZqJ6xYlP8sXLN3JMfS3Tbg=;
	b=gX4TUC9Jow9vAp1APVszLylHyw1XsIHeK2Ub24EXNCo2crhj9XLmWlmm/BNMCQtScGVtul
	CsS7+L6hl1jtbpJUIbFqa2eS0NR2GNdaZafC/8NF3J2b+c4fGdlofS/7ngcpXPtrl03fLb
	avTlG0N2TqJ9HPa8iKkEqpoAwoUcoS0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-lmSnKeHeMHuxglJMZm11jw-1; Fri, 21 Jun 2024 07:47:33 -0400
X-MC-Unique: lmSnKeHeMHuxglJMZm11jw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ec3d6c2cf1so15945761fa.1
        for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2024 04:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718970452; x=1719575252;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbVc+Fc7RR7j8FqltSlekZqJ6xYlP8sXLN3JMfS3Tbg=;
        b=Klz+MYJQGfIPi9PJ3hm1g6U2mxivvcoJsCK1pyvRiQOdOIWMdD0/G0GYMEvh2caRQX
         4KAps7fXsUx9fhDKtbYI1jID4HIJsgfxUYBa98j7y1+ZOwyvHuzgJsThtv1YsfbuUEGT
         +oKzUdYAwoC6dLcaWMWdorRZKzcsszmNst/GuWeG0WensW+QTtEO7kssmwUN1BY/bTCH
         PopX6Lo12VjYLWaZzs/MfXM0lEN/Wk8s73YdaTdqYCqPN/vDWdEI2zqWjw521OqdBAex
         2KyYvWqbyGHFHiZPUXabJ4/M2GXRBgT29tkZyWHbG3TK1DNh4h0LmxNDXg489+stct2d
         8yIg==
X-Forwarded-Encrypted: i=1; AJvYcCXxrwBIYJXLxS5XHzna0hmUKnfuIRFpFN7JbFR03dq3s+xGB3cSq32xrmgSJEqZXt0GVmxi9z2x29IOJSosS5tUy8ct12moZfq4
X-Gm-Message-State: AOJu0YxQ6gFXtyXiX/tYni+wNOCqrAHyAh8ZkeHNc+v+Y2rzLf22I97U
	zbhdbrK6U/6MWMt1+q6R28y7VU2D+I5xDqOp3G3QsSLos+cL63kMA1qqBenRQxOwQZXBLO2Dvs6
	tq+1xByhiyMOoQa3bJo2PocORXjgv9bu+IgznZCeTYPu5nah3vGRtp3RFWg==
X-Received: by 2002:a2e:7d0a:0:b0:2ec:2a57:aee2 with SMTP id 38308e7fff4ca-2ec3cffe7b8mr52756841fa.52.1718970452003;
        Fri, 21 Jun 2024 04:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH95rXTqYwnXmHJHpILxoA4ZTURqCUFz0fuke2FBfMjWBqCo6+Tqeqn2pVQiB4JtM9QOqiOKA==
X-Received: by 2002:a2e:7d0a:0:b0:2ec:2a57:aee2 with SMTP id 38308e7fff4ca-2ec3cffe7b8mr52756551fa.52.1718970451527;
        Fri, 21 Jun 2024 04:47:31 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b85a2sm1496611f8f.42.2024.06.21.04.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:47:30 -0700 (PDT)
Date: Fri, 21 Jun 2024 13:47:27 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Philipp Stanner <pstanner@redhat.com>, rafael@kernel.org,
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, ajanulgu@redhat.com,
	lyude@redhat.com, robh@kernel.org, daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 07/10] rust: add `io::Io` base type
Message-ID: <ZnVoT4xJXtCDWixz@pollux>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-8-dakr@redhat.com>
 <2024062040-wannabe-composer-91bc@gregkh>
 <a43dc0512194042d762bf5bb5f1396d41fef5bce.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a43dc0512194042d762bf5bb5f1396d41fef5bce.camel@redhat.com>

On Fri, Jun 21, 2024 at 11:43:34AM +0200, Philipp Stanner wrote:

Please find a few additions below.

But as mentioned, please let us sort out [1] first.

[1] https://lore.kernel.org/lkml/ZnSeAZu3IMA4fR8P@cassiopeiae/

> On Thu, 2024-06-20 at 16:53 +0200, Greg KH wrote:
> > On Wed, Jun 19, 2024 at 01:39:53AM +0200, Danilo Krummrich wrote:
> > > I/O memory is typically either mapped through direct calls to
> > > ioremap()
> > > or subsystem / bus specific ones such as pci_iomap().
> > > 
> > > Even though subsystem / bus specific functions to map I/O memory
> > > are
> > > based on ioremap() / iounmap() it is not desirable to re-implement
> > > them
> > > in Rust.
> > 
> > Why not?
> 
> Because you'd then up reimplementing all that logic that the C code
> already provides. In the worst case that could lead to you effectively
> reimplemting the subsystem instead of wrapping it. And that's obviously
> uncool because you'd then have two of them (besides, the community in
> general rightfully pushes back against reimplementing stuff; see the
> attempts to provide redundant Rust drivers in the past).
> 
> The C code already takes care of figuring out region ranges and all
> that, and it's battle hardened.

To add an example, instead of reimplementing things like pci_iomap() we use
`Io` as base type providing the accrssors like readl() and let the resource
implement the mapping parts, such as `pci::Bar`.

> 
> The main point of Rust is to make things safer; so if that can be
> achieved without rewrite, as is the case with the presented container
> solution, that's the way to go.
> 
> > 
> > > Instead, implement a base type for I/O mapped memory, which
> > > generically
> > > provides the corresponding accessors, such as `Io::readb` or
> > > `Io:try_readb`.
> > 
> > It provides a subset of the existing accessors, one you might want to
> > trim down for now, see below...
> > 
> > > +/* io.h */
> > > +u8 rust_helper_readb(const volatile void __iomem *addr)
> > > +{
> > > +       return readb(addr);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rust_helper_readb);
> > 
> > <snip>
> > 
> > You provide wrappers for a subset of what io.h provides, why that
> > specific subset?
> > 
> > Why not just add what you need, when you need it?  I doubt you need
> > all
> > of these, and odds are you will need more.
> > 
> 
> That was written by me as a first play set to test. Nova itself
> currently reads only 8 byte from a PCI BAR, so we could indeed drop
> everything but readq() for now and add things subsequently later, as
> you suggest.

I think it is reasonable to start with the most common accessors
{read,write}{b,w,l,q and maybe their relaxed variants.

We generate them through the `define_read!` and `define_write!` macros anyways
and the only difference between all the variants is only the size type (u8, u16,
etc.) we pass to the macro.

> 
> 
> 
> > > +u32 rust_helper_readl_relaxed(const volatile void __iomem *addr)
> > > +{
> > > +       return readl_relaxed(addr);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rust_helper_readl_relaxed);
> > 
> > I know everyone complains about wrapper functions around inline
> > functions, so I'll just say it again, this is horrid.  And it's going
> > to
> > hurt performance, so any rust code people write is not on a level
> > playing field here.
> > 
> > Your call, but ick...
> 
> Well, can anyone think of another way to do it?
> 
> > 
> > > +#ifdef CONFIG_64BIT
> > > +u64 rust_helper_readq_relaxed(const volatile void __iomem *addr)
> > > +{
> > > +       return readq_relaxed(addr);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rust_helper_readq_relaxed);
> > > +#endif
> > 
> > Rust works on 32bit targets in the kernel now?
> 
> Ahm, afaik not. That's some relic. Let's address that with your subset
> comment from above.

I think we should keep this guard; readq() implementations in the arch code have
this guard as well.

Should we ever add a 32bit target for Rust we also don't want this to break.

> 
> > 
> > > +macro_rules! define_read {
> > > +    ($(#[$attr:meta])* $name:ident, $try_name:ident,
> > > $type_name:ty) => {
> > > +        /// Read IO data from a given offset known at compile
> > > time.
> > > +        ///
> > > +        /// Bound checks are performed on compile time, hence if
> > > the offset is not known at compile
> > > +        /// time, the build will fail.
> > 
> > offsets aren't know at compile time for many implementations, as it
> > could be a dynamically allocated memory range.  How is this going to
> > work for that?  Heck, how does this work for DT-defined memory ranges
> > today?
> 
> The macro below will take care of those where it's only knowable at
> runtime I think.
> 
> Rust has this feature (called "const generic") that can be used for
> APIs where ranges which are known at compile time, so the compiler can
> check all the parameters at that point. That has been judged to be
> positive because errors with the range handling become visible before
> the kernel runs and because it gives some performance advantages.

Let's add an exammple based on `pci::Bar` here.

As a driver you can optionally map a `pci::Bar` with an additional `SIZE`
constant, e.g.

```
let bar = pdev.iomap_region_sized::<0x1000>(0)?;
```

This call only succeeds of the actual bar size is *at least* 4k. Subsequent
calls to, let's say, `bar.readl(0x10)` can boundary check things on compile
time, such that `bar.readl(0x1000)` would fail on compile time.

This is useful when a driver knows the minum required / expected size of this
memory region.

Alternatively, a driver cann always fall back to a runtime check, e.g.

```
let bar = pdev.iomap_region(0)?;
let val = bar.try_readl(0x1000)?;
```

- Danilo

> 
> 
> P.
> 
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 


