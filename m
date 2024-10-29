Return-Path: <linux-pci+bounces-15516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FE49B4695
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 11:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4854C281A5F
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 10:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBBE204956;
	Tue, 29 Oct 2024 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BF+0jS9R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACB6204037
	for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2024 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197156; cv=none; b=THYD6VT3iVC+oBWOki1XblKIkphmVw7wYOw5o+ZCUQdZiSVEfs5YpTnICYvOeovZA2sfrWuU3lSIYYO52bKMryHsyco6N/OLjtWOBN7Y2rp3oFP5T0aHPfVYtuPTItF/gEFOSohZmkGkPeIdUf1GcjKlXoO2Qf0Z6mSzY5UsaM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197156; c=relaxed/simple;
	bh=d/cGJuC2Q58iecrEavLqBOu3zMwjpF2kwMvGbzASwQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZQ18FSHExOszxxmemouiyXwZeZvguIO0j3ZmkEQrEm826qBlJpVJUCO+vCuMwsi+yoxaQBH47IOZa6ZjGO5wtWDH7Orp18BQOtxptB/RDbKc4yDK43PLVKKKhz7wubeaswI5NZk2saBx5sIVkoxOD7fRRI2TLWVHRn9ZRVZlok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BF+0jS9R; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d50fad249so3922878f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2024 03:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730197151; x=1730801951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XgocmKm8OWehUfxM76kTsWdkf8OVwFn2L9ImJ7aTqE=;
        b=BF+0jS9RM4KcptjnjGB0HM8NC6NnSeH6X8/t7tI0DYBUmABsoTbko6PWXSCFNxAyvj
         /qM8FjFh5IEhIJ5FBu7KC7o/Bs8PG5TCI9dzfJ1ux6t59/JdEfzz5xKFDurVwXSXkIa8
         pqEnFSjCTwMMV9LQ3dHKyEa9Dd3mCZrYKkT/EKs8NcJ1KGFaLntmj0PQAGGs9MOBeil2
         ebjatT3F1MJpTFfhYhx+gZjw42f6l9hDdOTBwbaCP04qFHIkV5L5WVvcqIb7xtOBm8Nh
         5Jsc47L43U5e3adAR4ACELmzuxHU+vSz8THF4nbK+Ij2uft7wgW9HzviNxPQcNzWdTw5
         vw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730197151; x=1730801951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XgocmKm8OWehUfxM76kTsWdkf8OVwFn2L9ImJ7aTqE=;
        b=AGry2vht2+4ThLsLfQVVMxGR+xszhlSsSI2RApDUOpInxPtXYwHQfuUMh8jlXjy5BL
         lrVX8lyRcKNlY47MOjj+LTP26qNnJeqNuvsRQnSu/jfgemx6qtCruM1I5UbhndVs+lEK
         0jwoyMYqqOsCSmFzB2F74xd30uD1e4pwysAMMZihE2KBMNzxKHXROH3/+2GYCAUjsZL9
         1Ap0CP9Ua9+eHl6hHJUKX/js+NkyxZWe43yiaqFZXOo5jYUeMIfHkmu7bxIPTG+dZ2jC
         +8xedm7xUvWJdWHUFwKzpRrCdAcPa65AO4uDDRzPHshwUsDAfJ4sQ7+mBPXY6BW1t/mq
         oXhA==
X-Forwarded-Encrypted: i=1; AJvYcCX43pc20P1rPAAly5IByd9fpgM6Xe+Y97BmIPz5VqJiSb++E8Dwj2Gcg2AW13XYMGT2ZshsMQS8QWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVBkLu9Qe31+CAjB8GA+bof5UXpDa6t/uhr838xIRs32p/YyuT
	46Eb3aeny3JLKCIUY+l5wUdgM3hmASynBw31KOrMQDihq/xecu+VoGpx6PDFbBXkdxh+FvnTLBg
	7YyqCwIOIe/+LffflXMuHdyqoLeE+zFEL3ONz
X-Google-Smtp-Source: AGHT+IGWFO5YJYn8lgkZOi+IiNwCBAshqneyF0cW5trQzglUC0zODMaLZVGut3thtbV5H7YknoyRIa7QhRfPXIFaKyw=
X-Received: by 2002:adf:fbd2:0:b0:37d:5299:c406 with SMTP id
 ffacd0b85a97d-380611e4b44mr7845170f8f.38.1730197151035; Tue, 29 Oct 2024
 03:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-10-dakr@kernel.org>
 <CAH5fLggFD7pq0WCfMPYTZcFkvrXajPbxTBtkvSeh-N2isT1Ryw@mail.gmail.com> <ZyCo9SRP4aFZ6KsZ@pollux>
In-Reply-To: <ZyCo9SRP4aFZ6KsZ@pollux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 29 Oct 2024 11:18:58 +0100
Message-ID: <CAH5fLgjC5Rcq5VJbEFSVP_rE0xjj8CGdqxZexhPVsGcTZ+85HA@mail.gmail.com>
Subject: Re: [PATCH v3 09/16] rust: add `io::Io` base type
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 10:21=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Mon, Oct 28, 2024 at 04:43:02PM +0100, Alice Ryhl wrote:
> > On Tue, Oct 22, 2024 at 11:33=E2=80=AFPM Danilo Krummrich <dakr@kernel.=
org> wrote:
> > >
> > > I/O memory is typically either mapped through direct calls to ioremap=
()
> > > or subsystem / bus specific ones such as pci_iomap().
> > >
> > > Even though subsystem / bus specific functions to map I/O memory are
> > > based on ioremap() / iounmap() it is not desirable to re-implement th=
em
> > > in Rust.
> > >
> > > Instead, implement a base type for I/O mapped memory, which generical=
ly
> > > provides the corresponding accessors, such as `Io::readb` or
> > > `Io:try_readb`.
> > >
> > > `Io` supports an optional const generic, such that a driver can indic=
ate
> > > the minimal expected and required size of the mapping at compile time=
.
> > > Correspondingly, calls to the 'non-try' accessors, support compile ti=
me
> > > checks of the I/O memory offset to read / write, while the 'try'
> > > accessors, provide boundary checks on runtime.
> >
> > And using zero works because the user then statically knows that zero
> > bytes are available ... ?
>
> Zero would mean that the (minimum) resource size is unknown at compile ti=
me.
> Correspondingly, any call to `read` and `write` would not compile, since =
the
> compile time check requires that `offset + type_size <=3D SIZE`.
>
> (Hope this answers the questions, I'm not sure I got it correctly.)

Yeah, thanks! I got it now.

> > > `Io` is meant to be embedded into a structure (e.g. pci::Bar or
> > > io::IoMem) which creates the actual I/O memory mapping and initialize=
s
> > > `Io` accordingly.
> > >
> > > To ensure that I/O mapped memory can't out-live the device it may be
> > > bound to, subsystems should embedd the corresponding I/O memory type
> > > (e.g. pci::Bar) into a `Devres` container, such that it gets revoked
> > > once the device is unbound.
> >
> > I wonder if `Io` should be a reference type instead. That is:
> >
> > struct Io<'a, const SIZE: usize> {
> >     addr: usize,
> >     maxsize: usize,
> >     _lifetime: PhantomData<&'a ()>,
> > }
> >
> > and then the constructor requires "addr must be valid I/O mapped
> > memory for maxsize bytes for the duration of 'a". And instead of
> > embedding it in another struct, the other struct creates an `Io` on
> > each access?
>
> So, we'd create the `Io` instance in `deref` of the parent structure, rig=
ht?
> What would be the advantage?

What you're doing now is a bit awkward to use. You have to make sure
that it never escapes the struct it's created for, so e.g. you can't
give out a mutable reference as the user could otherwise `mem::swap`
it with another Io. Similarly, the Io can never be in a public field.
Your safety comment on Io::new really needs to say something like
"while this struct exists, the `addr` must be a valid I/O region",
since I assume such regions are not valid forever? Similarly if we
look at [1], the I/O region actually gets unmapped *before* the Io is
destroyed since IoMem::drop runs before the fields of IoMem are
destroyed, so you really need something like "until the last use of
this Io" and not "until this Io is destroyed" in the safety comment.

If you compare similar cases in Rust, then they also do what I
suggested. For example, Vec<T> holds a raw pointer, and it uses unsafe
to assert that it's valid on each use of the raw pointer - it does not
create e.g. an `&'static mut [T]` to hold in a field of the Vec<T>.
Having an IoRaw<S> and an Io<'a, S> corresponds to what Vec<T> does
with IoRaw being like NonNull<T> and Io<'a, S> being like &'a T.

[1]: https://lore.kernel.org/all/20241024-topic-panthor-rs-platform_io_supp=
ort-v1-1-3d1addd96e30@collabora.com/

> > > diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> > > new file mode 100644
> > > index 000000000000..750af938f83e
> > > --- /dev/null
> > > +++ b/rust/kernel/io.rs
> > > @@ -0,0 +1,234 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +//! Memory-mapped IO.
> > > +//!
> > > +//! C header: [`include/asm-generic/io.h`](srctree/include/asm-gener=
ic/io.h)
> > > +
> > > +use crate::error::{code::EINVAL, Result};
> > > +use crate::{bindings, build_assert};
> > > +
> > > +/// IO-mapped memory, starting at the base address @addr and spannin=
g @maxlen bytes.
> > > +///
> > > +/// The creator (usually a subsystem / bus such as PCI) is responsib=
le for creating the
> > > +/// mapping, performing an additional region request etc.
> > > +///
> > > +/// # Invariant
> > > +///
> > > +/// `addr` is the start and `maxsize` the length of valid I/O mapped=
 memory region of size
> > > +/// `maxsize`.
> >
> > Do you not also need an invariant that `SIZE <=3D maxsize`?
>
> I guess so, yes. It's enforced by `Io::new`, which fails if `SIZE > maxsi=
ze`.

Sure. It's still an invariant.

Alice

