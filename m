Return-Path: <linux-pci+bounces-42060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA3FC859AB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA4C94E39BC
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3053246F0;
	Tue, 25 Nov 2025 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDFdjEMj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FB521ABDC
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082684; cv=none; b=KXnlyylA84UkNffbubsnYEah36WplWSnRVSw0VLIfmHbrC86S1yg//QtFM/DHMCchvB4NX0UlaNqTXrNNGR6+yMlCjNDTayulP5PEzssilc2XxZOtxinV7ovpU0BSJiFp3XzsYa3tAAk2HzIdVkT2BIkkCQ4+ySndzvXluqOtcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082684; c=relaxed/simple;
	bh=fjugijEOxz+BkyK5AKUtMcxNz7174XLv/RiWHwnqUwc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CgbB8KCqG0SxXzF9zXUKze22dLdooAlqs4Z2tgW5ZahZ5cXijunU8XR4fiIjVnl+42bi9BvkCpxfNIetvK2yagyUmBiDS7BjGPKXKV8CDgUggxikLJa10mxlzha8PvMp0ltKJQvtrGzhtmWe7nCvfOrGAxrDvx3YlUtrv4IJFOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DDFdjEMj; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b72a8546d73so801941166b.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 06:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764082681; x=1764687481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7d9Dhi8u9HjjZyGZlutMjekjrjxxYZCytQjDsvZIFzo=;
        b=DDFdjEMjMLEbuC4jmjDHDeZTuISkYrTP5/EcW4TXup8qPl2Kerh4QiVAi8B2QitohM
         AYud0weWBxhw2X4Wmz+MFNvaoaq4oO/eQ/DRq2ZXeiCNMcsGNpiJxvyTVWGrY1zCxGcr
         DybjUbwLJ8O6P1JrQHa4VcCYBTDx5uOkPkDelAbo95/uuUyY2ClVJqi8K71uH+fb63TO
         AVBB7QsdbYTvHfFyifB6USj8Y7yGp5j+qdV+KolORSkaG59h7pybpVadpS6XJO5lKS1c
         37XM0HgPSzs9iD3eiayreblAEXsoLjv14SIPMyzgbUHpYzm+J0Mil81rQAexkK1vdPBz
         cYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764082681; x=1764687481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7d9Dhi8u9HjjZyGZlutMjekjrjxxYZCytQjDsvZIFzo=;
        b=KF2HV//9Y+7J18BO3flsEedooMsnFzq7TjoX9bi90QWterW2rikA1EL+4JY1qxbBSL
         Jrmvl69M8uAspdnNrG5fmCNJw+QF9isPIrsV1uls3MwcAhkC+0REWn3rxjomVD3p+sLX
         hZlrsEAq0WcFrlLMIsUGnatjaOSEgGicon8o++aCMqQkhlLIezmMFSduj/VB8+EA8uqL
         BdtIAIf10v7eXFijesFNFu+hir4lijgMocvOMPGDHJTsZ6Ex8VlmgZk9fFaAjbAZc7PO
         7UWPLQyf+o9Z48s7KEH1SvzilifYMvW8Q7Pz/8ttE391T1BLPyGTfmp0IHM8dZXC/GuS
         LAMA==
X-Forwarded-Encrypted: i=1; AJvYcCVnlqZ6nZ3NMfdIwJiNSc3M5tL49SmVtV/KE+qj7lgC5uE3PTfxEwR9OA/Alqn/rFhVEsWW6JyOrsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmDZZucs6HKne0awxz5lq0/eP/cAUe+BUJTOa6dp2GHwD2JoGX
	F9TJjHu1Levn3odarM6R8JBlUJGPIwHXUYtby3dKfx/qGm82k8E03OPhF4J8dcRE1KmV9rwjpN8
	kNmo3ZyXCcSq4Pyz/0g==
X-Google-Smtp-Source: AGHT+IEqenzXLwwGg7TYSHroaRfAGGHh19mwBZbgMyJIVeDiK9FNZlW1ZlXkTIHmuEtgE422k64IplXnp16dEfk=
X-Received: from ejctx8.prod.google.com ([2002:a17:907:8e88:b0:b72:41e4:751c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:2401:b0:b76:74b6:dbf8 with SMTP id a640c23a62f3a-b7674b6dda1mr1210417466b.14.1764082681631;
 Tue, 25 Nov 2025 06:58:01 -0800 (PST)
Date: Tue, 25 Nov 2025 14:58:00 +0000
In-Reply-To: <DEHTK1CK84WO.28LTX338E4PXQ@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251119112117.116979-1-zhiw@nvidia.com> <20251119112117.116979-4-zhiw@nvidia.com>
 <aSB1Hcqr6W7EEjjK@google.com> <DEHTK1CK84WO.28LTX338E4PXQ@nvidia.com>
Message-ID: <aSXD-I8bYUA-72vi@google.com>
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

On Tue, Nov 25, 2025 at 10:44:29PM +0900, Alexandre Courbot wrote:
> On Fri Nov 21, 2025 at 11:20 PM JST, Alice Ryhl wrote:
> > On Wed, Nov 19, 2025 at 01:21:13PM +0200, Zhi Wang wrote:
> >> The previous Io<SIZE> type combined both the generic I/O access helpers
> >> and MMIO implementation details in a single struct.
> >> 
> >> To establish a cleaner layering between the I/O interface and its concrete
> >> backends, paving the way for supporting additional I/O mechanisms in the
> >> future, Io<SIZE> need to be factored.
> >> 
> >> Factor the common helpers into new {Io, Io64} traits, and move the
> >> MMIO-specific logic into a dedicated Mmio<SIZE> type implementing that
> >> trait. Rename the IoRaw to MmioRaw and update the bus MMIO implementations
> >> to use MmioRaw.
> >> 
> >> No functional change intended.
> >> 
> >> Cc: Alexandre Courbot <acourbot@nvidia.com>
> >> Cc: Alice Ryhl <aliceryhl@google.com>
> >> Cc: Bjorn Helgaas <helgaas@kernel.org>
> >> Cc: Danilo Krummrich <dakr@kernel.org>
> >> Cc: John Hubbard <jhubbard@nvidia.com>
> >> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> >
> > I said this on a previous version, but I still don't buy the split
> > into IoFallible and IoInfallible.
> >
> > For one, we're never going to have a method that can accept any Io - we
> > will always want to accept either IoInfallible or IoFallible, so the
> > base Io trait serves no purpose.
> >
> > For another, the docs explain that the distinction between them is
> > whether the bounds check is done at compile-time or runtime. That is not
> > the kind of capability one normally uses different traits to distinguish
> > between. It makes sense to have additional traits to distinguish
> > between e.g.:
> >
> > * Whether IO ops can fail for reasons *other* than bounds checks.
> > * Whether 64-bit IO ops are possible.
> >
> > Well ... I guess one could distinguish between whether it's possible to
> > check bounds at compile-time at all. But if you can check them at
> > compile-time, it should always be possible to check at runtime too, so
> > one should be a sub-trait of the other if you want to distinguish
> > them. (And then a trait name of KnownSizeIo would be more idiomatic.)
> >
> > And I'm not really convinced that the current compile-time checked
> > traits are a good idea at all. See:
> > https://lore.kernel.org/all/DEEEZRYSYSS0.28PPK371D100F@nvidia.com/
> >
> > If we want to have a compile-time checked trait, then the idiomatic way
> > to do that in Rust would be to have a new integer type that's guaranteed
> > to only contain integers <= the size. For example, the Bounded integer
> > being added elsewhere.
> 
> Would that be so different from using an associated const value though?
> IIUC the bounded integer type would play the same role, only slightly
> differently - by that I mean that if the offset is expressed by an
> expression that is not const (such as an indexed access), then the
> bounded integer still needs to rely on `build_assert` to be built.

I mean something like this:

trait Io {
    const SIZE: usize;
    fn write(&mut self, i: Bounded<Self::SIZE>);
}

You know that Bounded<SIZE> contains a number less than SIZE, so you
know it's in-bounds without any build_assert required.

Yes, if there's a constructor for Bounded that utilizes build_assert,
then you end up with a build_assert to create it. But I think in many
cases it's avoidable depending on where the index comes from.

For example if you iterate all indices 0..SIZE, there could be a way to
directly create Bounded<SIZE> values from an iterator. Or if the index
comes from an ioctl, then you probably runtime check the integer at the
ioctl entrypoint, in which case you want the runtime-checked
constructor.

Alice

