Return-Path: <linux-pci+bounces-7828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8578CF119
	for <lists+linux-pci@lfdr.de>; Sat, 25 May 2024 21:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AE11C2093D
	for <lists+linux-pci@lfdr.de>; Sat, 25 May 2024 19:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2D68627B;
	Sat, 25 May 2024 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuD8TY5b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9543F9F8;
	Sat, 25 May 2024 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716665069; cv=none; b=hkznR8KqLlXhfzN7ZdRB9/RPT7lP2JOZFJj2oCdyVV+Iz1W2IRrpONIPDHJCMeFPhjQPxB62vBYvvDv7TqbBgLweMvGMwsGdB78DaOxs7OZjiB5MiFTSEjpRevZOq64riNx69DNTMaqs+cqyK20jDRGN6JxpVy+UeUuygFc1fvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716665069; c=relaxed/simple;
	bh=+kizM5lnYMs/tn9mhyuETjoPV0xSyPntJIHtU75whkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4DBmmFPLd0L42BAJDr8f3f2jMlm6yoNTt+f0QChi6sq53c5ZbgFbljLoh7IuSOYYvX1gu2WnQ6VTo9SGKhruzoSKv9yW/piLUatUhYs2OOXVUbN/Ocnz3TzWt2jIJcXAvtCwbHoYVnqweCoG66zI0T6AfFA9iDDmCji+Fk55mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuD8TY5b; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-62a2424ec39so2877547b3.1;
        Sat, 25 May 2024 12:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716665067; x=1717269867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+kizM5lnYMs/tn9mhyuETjoPV0xSyPntJIHtU75whkw=;
        b=QuD8TY5byoAdfnvDG9eXUeCwiP/Lb0+AC9Vl0VJ9qyn6hRyHizV9crwZJzqzGfBLAo
         7RJDa/ZBDVYNPfMzR1jTK2pQNl8NYnDOxoLfE0Xqy5ttu1ta0QHMMPcPbrPtOXyUNYj1
         n3Z6odHagI1wxajqTXy58dCYDvPBIeAZftqVSCgqMp8rQz02mpzx77QuNCZfx48SmVb2
         gxuPJxMeLvSgTrLcra92jBbBIStUbV1Cpakbud5IHwK1DfNGand8dooTjLbIcCgU+HDa
         EM4KLNT/O4R4a9boeszoN6ocRkW8oGa/PbMfDCmFpgVs7VuVH6C0N+MHzgx1/WsxIxos
         7BOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716665067; x=1717269867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+kizM5lnYMs/tn9mhyuETjoPV0xSyPntJIHtU75whkw=;
        b=fWxHFOpCNmRPZwkw0fUOdY8mUo9ccp5WeJMueJUq8VeyCIj9feI2aV+XVWG5PxApMt
         eArAnd3XkpgKfHfM52ZI9FWmDUHXjntFgzgnDKIa6fAfdAwUwo9NGJKcnXWwDfT50i8U
         cDJcH3qHMGHEUmyHhbsgJ2KZmKq2obFNlQKcnueM7Gf48y8cy+D9RQCLZ+01x2k8XRhU
         pXiqbg39XAZcPUJp/1yNpF1mdW9Q2vHuxCeK5i2tR2XEdvd3jLhktBFFrbPEIwIW3e3o
         fcMAkKXx1GxargxDe8DXhWqEZTLf94Jg+aqqHpfRZ3YTF9GWBxYjlzLWufiMfPjPBV8I
         8GSw==
X-Forwarded-Encrypted: i=1; AJvYcCUPFjTfgBNtLqrCK9q7xJbd4p/TVaW90UO0CJpHDRJqCyBiiCr0kLdq0pBgqHrPtJdUU4M8PAh6AEyU53vNlrhVKG4Zl4hDXI2E9VdJySB2I+Li9MhChemL/ghHJWtYUJWzaRWGBHlYQgnhlpg4X5xSUETQoxIMLO25dyLKyXnpgcFjCZgpkCE=
X-Gm-Message-State: AOJu0YxdGPTcdOGgOX2lL3/x7faLnN2a+GpWm+aULRvn6LemPTm6qULm
	xo+IILdwQ85nDa6pVFXCn9X0mONh2K6YfROGDWINEySX/rA9LH+7y3Fn4KHWgi364uDiuEIX+bh
	p12BD2t/QY7yI4txJrMmt7w/kDeg=
X-Google-Smtp-Source: AGHT+IHCdpyV3KxmP7sGntNXImivmdG6WMeeujjPbe1bccBlcrbU9AdpiYvRbyyH9n6/nm/QpNZ/+APhIVz8K8AisOA=
X-Received: by 2002:a81:4ece:0:b0:627:ddf1:1497 with SMTP id
 00721157ae682-62a08f3a28fmr51030727b3.45.1716665066545; Sat, 25 May 2024
 12:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520172554.182094-1-dakr@redhat.com> <20240520172554.182094-11-dakr@redhat.com>
 <CANiq72kHrgOVrdw7rB9KpHvOMy244TgmEzAcL=v5O9rchs8T1g@mail.gmail.com>
 <CAPM=9txb5STBo05xiTy9+wF7=mMO=X2==BP4JVORPFAtX=nS0g@mail.gmail.com>
 <CANeycqpNeHFUu-RwSc6Ewa3r5TMhYYFDC6bO+sj3OZ398JfJ1A@mail.gmail.com> <1c8bb8044bc1943ad8d19cd6fc84a2d886004163.camel@redhat.com>
In-Reply-To: <1c8bb8044bc1943ad8d19cd6fc84a2d886004163.camel@redhat.com>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Sat, 25 May 2024 16:24:18 -0300
Message-ID: <CANeycqoWVygXBO_Kzq6QaLDjp3W+66YrOi7_dK8zRVpDONJ=AA@mail.gmail.com>
Subject: Re: [RFC PATCH 10/11] rust: add basic abstractions for iomem operations
To: Philipp Stanner <pstanner@redhat.com>
Cc: Dave Airlie <airlied@gmail.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Danilo Krummrich <dakr@redhat.com>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, ajanulgu@redhat.com, 
	lyude@redhat.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 May 2024 at 05:03, Philipp Stanner <pstanner@redhat.com> wrote:
>
> On Tue, 2024-05-21 at 00:01 -0300, Wedson Almeida Filho wrote:
> > On Mon, 20 May 2024 at 23:07, Dave Airlie <airlied@gmail.com> wrote:
> > >
> > > >
> > > > Wedson wrote a similar abstraction in the past
> > > > (`rust/kernel/io_mem.rs` in the old `rust` branch), with a
> > > > compile-time `SIZE` -- it is probably worth taking a look.
> > > >
> > >
> > > Just on this point, we can't know in advance what size the IO BARs
> > > are
> > > at compile time.
> > >
> > > The old method just isn't useful for real devices with runtime IO
> > > BAR sizes.
> >
> > The compile-time `SIZE` in my implementation is a minimum size.
> >
> > Attempts to read/write with constants within that size (offset +
> > size)
> > were checked at compile time, that is, they would have zero
> > additional
> > runtime cost when compared to C. Reads/writes beyond the minimum
> > would
> > have to be checked at runtime.
> >
>
> We looked at this implementation
>
> Its disadvantage is that it moves the responsibility for setting that
> minimum size to the driver programmer. Andreas Hindborg is using that
> currently for rnvme [1].
>
> I believe that the driver programmer in Rust should not be responsible
> for controlling such sensitive parameters (one could far more easily
> provide invalid values), but the subsystem (e.g. PCI) should do it,
> because it knows about the exact resource lengths.

There is no responsibility being moved. The bus is still that one that
knows about the resources attached to the device.

The driver, however, can say for example: I need at least 4 registers
of 32 bits starting at offset X, which results in a minimum size of X
+ 16. If at runtime a device compatible with this driver appears and
has an io mem of at least that size, then the driver can drive it
without any additional runtime checks. I did this in the gpio driver
here: https://lwn.net/Articles/863459/

Note that in addition to not having to check offset at runtime, the
reads/writes are also infallible because all failures are caught at
compile time.

Obviously not all drivers can benefit from this, but it is
considerable simplification for the ones that can.

> The only way to set the actual, real value is through subsystem code.
> But when we (i.e., currently, the driver programmer) have to use that
> anyways, we can just use it from the very beginning and have the exact
> valid parameters.

Yes, only the bus knows. But to reiterate: if the driver declares and
checks a minimum size at attach time, it obviates the needs to check
again throughout the lifetime of the driver, which is more performant
and eliminates error paths.

