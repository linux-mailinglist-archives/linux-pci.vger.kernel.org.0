Return-Path: <linux-pci+bounces-42104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC2CC891F3
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 10:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96903A2C7A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 09:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EB03009D4;
	Wed, 26 Nov 2025 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKV0l3OR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192E23016F9
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764150650; cv=none; b=TjR/pDnG9CAdtQkJ2HILYDRWqF0iykfQ5GZimBTRNzVjqh5Gkj33fd+94LGv3UqThCwCWdOnU8LbQ83C2zqgmEiRB/ts+gEhJEkXfFOncBxGvrC0LoGZfQf437zIV2Wvps3PAzzqxZU5eR9HddtisFw7wApne+DVZVrcOwYU9ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764150650; c=relaxed/simple;
	bh=E/RU1dhL7sHkXwY6wCpifQdBufsgzqGxIPaX5zPDkrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dx/+m6HMv8pPBLZ4BmSHYrLS6IXikiBuV2weKLQYrYACYUL8FL7/SaQiZMqDetsonn6VElqqobByLl+Pn4QJtDAiDxOBOg27iWVCQXyqmAd6Fdq3G0m2wLapOZrN3k23EO4mctLp3abD1icJ7TAWXJQ0Y0xQ9eVCW5X5hHvCXBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GKV0l3OR; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4779d8fd4ecso3271575e9.1
        for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 01:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764150646; x=1764755446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jSvzj95/YOMgXX2WrYYsc8VQubWjVbTM1tYJZOPIebA=;
        b=GKV0l3ORf0zahec9/CeZZJhBSUxshL4seiMyY3dvKuImJJWX7Ytx3GETkxeYtNt5OB
         GxIMCIoD8olQ92i3Ry0QtwsIimAsV2ciziioIGM0kghNKnRA0TUPT1RPU4nRuKl/3QIl
         PycoN7ZXbesNDLnE3YbzW6dTOPcSrI91BRAsW3epYYvciR/4AcB4lYd0eUGXT3EtLH2W
         L+XFdv7hgccDI1W/8ldn6jNNN9YPah1X8Cwkqb7kUzYJC+8nw6aUxM5tnWLzi8UoiuQm
         +cVOPs34KkSvRHby1hTihLWUdaS+BIQ/+wFfNvZSXYlAUstdfIVfDP7VhffdzY9f5QBO
         Ejug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764150646; x=1764755446;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSvzj95/YOMgXX2WrYYsc8VQubWjVbTM1tYJZOPIebA=;
        b=YDgNZN/pz5n7rnZE3QI3F0NvbBa3T+/kU0tS40EC4wgBOIds7YL0391zo34H+LZigt
         Va0FSUGpm+8TRJTWHSaMj1bL+t2lHt6p+rW2zgdL63CNC/zP11M1eQGBJgNT71TNIvW1
         eJgEny1lZx87ONPYV51cn6uKFkMT6n8LXQi+IZa1ytcP/AafY1Ti3V6rSf+HWgnI2R0o
         k2E+iZiSQULNFkgq6w1wYlpTVtzPTRkIbuutOqTfSDOdYbsljX0PUNVJeCZl/HawfKRV
         fUVApLPuGzoPkj5EoiR1BVPDmCSof6tcyOjhOHpxmcpcbaS0eJw0KmM/DP4Ydy9Qpv2f
         kj3g==
X-Forwarded-Encrypted: i=1; AJvYcCXMw0Pl8H+d6UYQHjcldGAB719wTkxYi4o25GP2orqobatBMjrKQi6KY4qlt54kt67iaJoSRyV3Nd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTVA5YCDRcObMwlHvLcjsFGuXqmlxxyMANx5NLSOiKkbgUa4Jt
	BUVgfBVn1oaLiiv2vYecmtO6GAqUdU+R3syaUQr9FxIgM0dJEdKt4bpfMa1x1MFnZEoye16JICT
	rYiqkZNVxofuhFRuZmw==
X-Google-Smtp-Source: AGHT+IEqNy6XkLEGvnBrcIM1oqNkFhyCHgbUhLMFwOhqN/xcPMxU4ziKwD306VJn7O/813l4Ug2PbJ6oZFBRHDE=
X-Received: from wmdn1.prod.google.com ([2002:a05:600c:2941:b0:477:103e:8e30])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4eca:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-477c0540a68mr204945775e9.16.1764150646449;
 Wed, 26 Nov 2025 01:50:46 -0800 (PST)
Date: Wed, 26 Nov 2025 09:50:45 +0000
In-Reply-To: <DEIGORHCX5VR.2EIPZECA0XGVH@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251119112117.116979-1-zhiw@nvidia.com> <20251119112117.116979-4-zhiw@nvidia.com>
 <aSB1Hcqr6W7EEjjK@google.com> <DEHTK1CK84WO.28LTX338E4PXQ@nvidia.com>
 <aSXD-I8bYUA-72vi@google.com> <DEIGORHCX5VR.2EIPZECA0XGVH@nvidia.com>
Message-ID: <aSbNddXgvv5AXqkU@google.com>
Subject: Re: [PATCH v7 3/6] rust: io: factor common I/O helpers into Io trait
From: Alice Ryhl <aliceryhl@google.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, dakr@kernel.org, 
	bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, markus.probst@posteo.de, helgaas@kernel.org, 
	cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com, 
	kwankhede@nvidia.com, targupta@nvidia.com, joelagnelf@nvidia.com, 
	jhubbard@nvidia.com, zhiwang@kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Nov 26, 2025 at 04:52:05PM +0900, Alexandre Courbot wrote:
> On Tue Nov 25, 2025 at 11:58 PM JST, Alice Ryhl wrote:
> > On Tue, Nov 25, 2025 at 10:44:29PM +0900, Alexandre Courbot wrote:
> >> On Fri Nov 21, 2025 at 11:20 PM JST, Alice Ryhl wrote:
> >> > On Wed, Nov 19, 2025 at 01:21:13PM +0200, Zhi Wang wrote:
> >> >> The previous Io<SIZE> type combined both the generic I/O access helpers
> >> >> and MMIO implementation details in a single struct.
> >> >> 
> >> >> To establish a cleaner layering between the I/O interface and its concrete
> >> >> backends, paving the way for supporting additional I/O mechanisms in the
> >> >> future, Io<SIZE> need to be factored.
> >> >> 
> >> >> Factor the common helpers into new {Io, Io64} traits, and move the
> >> >> MMIO-specific logic into a dedicated Mmio<SIZE> type implementing that
> >> >> trait. Rename the IoRaw to MmioRaw and update the bus MMIO implementations
> >> >> to use MmioRaw.
> >> >> 
> >> >> No functional change intended.
> >> >> 
> >> >> Cc: Alexandre Courbot <acourbot@nvidia.com>
> >> >> Cc: Alice Ryhl <aliceryhl@google.com>
> >> >> Cc: Bjorn Helgaas <helgaas@kernel.org>
> >> >> Cc: Danilo Krummrich <dakr@kernel.org>
> >> >> Cc: John Hubbard <jhubbard@nvidia.com>
> >> >> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> >> >
> >> > I said this on a previous version, but I still don't buy the split
> >> > into IoFallible and IoInfallible.
> >> >
> >> > For one, we're never going to have a method that can accept any Io - we
> >> > will always want to accept either IoInfallible or IoFallible, so the
> >> > base Io trait serves no purpose.
> >> >
> >> > For another, the docs explain that the distinction between them is
> >> > whether the bounds check is done at compile-time or runtime. That is not
> >> > the kind of capability one normally uses different traits to distinguish
> >> > between. It makes sense to have additional traits to distinguish
> >> > between e.g.:
> >> >
> >> > * Whether IO ops can fail for reasons *other* than bounds checks.
> >> > * Whether 64-bit IO ops are possible.
> >> >
> >> > Well ... I guess one could distinguish between whether it's possible to
> >> > check bounds at compile-time at all. But if you can check them at
> >> > compile-time, it should always be possible to check at runtime too, so
> >> > one should be a sub-trait of the other if you want to distinguish
> >> > them. (And then a trait name of KnownSizeIo would be more idiomatic.)
> >> >
> >> > And I'm not really convinced that the current compile-time checked
> >> > traits are a good idea at all. See:
> >> > https://lore.kernel.org/all/DEEEZRYSYSS0.28PPK371D100F@nvidia.com/
> >> >
> >> > If we want to have a compile-time checked trait, then the idiomatic way
> >> > to do that in Rust would be to have a new integer type that's guaranteed
> >> > to only contain integers <= the size. For example, the Bounded integer
> >> > being added elsewhere.
> >> 
> >> Would that be so different from using an associated const value though?
> >> IIUC the bounded integer type would play the same role, only slightly
> >> differently - by that I mean that if the offset is expressed by an
> >> expression that is not const (such as an indexed access), then the
> >> bounded integer still needs to rely on `build_assert` to be built.
> >
> > I mean something like this:
> >
> > trait Io {
> >     const SIZE: usize;
> >     fn write(&mut self, i: Bounded<Self::SIZE>);
> > }
> 
> I have experimented a bit with this idea, and unfortunately expressing
> `Bounded<Self::SIZE>` requires the generic_const_exprs feature and is
> not doable as of today.
> 
> Bounding an integer with an upper/lower bound also proves to be more
> demanding than the current `Bounded` design. For the `MIN` and `MAX`
> constants must be of the same type as the wrapped `T` type, which again
> makes rustc unhappy ("the type of const parameters must not depend on
> other generic parameters"). A workaround would be to use a macro to
> define individual types for each integer type we want to support - or to
> just limit this to `usize`.
> 
> But the requirement for generic_const_exprs makes this a non-starter I'm
> afraid. :/

Can you try this?

trait Io {
    type IdxInt: Int;
    fn write(&mut self, i: Self::IdxInt);
}

then implementers would write:

impl Io for MyIo {
    type IdxInt = Bounded<17>;
}

instead of:
impl Io for MyIo {
    const SIZE = 17;
}

Alice

