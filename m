Return-Path: <linux-pci+bounces-42361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CB7C9739E
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 13:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6436E342B2B
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 12:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3992930BB95;
	Mon,  1 Dec 2025 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L74OpQbM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D630BB8D
	for <linux-pci@vger.kernel.org>; Mon,  1 Dec 2025 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764591838; cv=none; b=leeNxuXA9SiO2u5G7jnuUyiCedfhArGpm78/AZomVNKnLdC06AI6zIQwKU2g49EDdNCoIHKAHeo8exDi82qPYY7VI5TrWqe8BrrpIO1pNFKeVkFk8VQaFPOFT9lJrXBF4BuW+C3cH4rF8AK9CxY+IykbnEkSsf3vveeFLzEcieQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764591838; c=relaxed/simple;
	bh=7FJu6G7py2hPi/gqPBGj3Rr40ECcla2mbeimGsmgkfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oAdrOHpvoEV9QKQeLSR83POJe8SXfNid46Og3jNPl5lBc4gGirsiO2KZ/GlhECXtCrVCZw+NDercLseglhsd6S2eQsE8a6+2T6D0gtdWwR6X8NYb9cD8t3/XDhw9OoYKHi4imGcwWSu84QJ90/MDkwqCsACNxO3pVDbKKGNywU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L74OpQbM; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477964c22e0so27185665e9.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Dec 2025 04:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764591834; x=1765196634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/SCAhmpvJBTo6EtHFLWFijtYJjxdGn01oZUMaCZ9TvA=;
        b=L74OpQbMxLsKa1o5e0mrvp68t1cAXcZAhWnRSN4QzHVMryvjj0y1Y5QQYlaZNeCGbX
         knUfPoYYzVhAI+z2JX3ypkTF7O84yvU7gaMzo2kwdYrI32uoBIpCUBlUtbbTMU7w4nZu
         4B9+upxaTErbOPXEBYelCyw0NBvCqzPZJHJO6gDtZgUsUNN/K7GN8tdQwKWYF8rxojl9
         2F3wBXt1E3o2VtMCGcKIUptrXX2va6zIIhFZCWNrxbPm57fykfdB8MerbLx3eGJ62/ix
         rh2GudPKPXTPKh49SppiabQtfr4tgNS+e8qQOq052CSSJkumK9p2x43DykzPuC2/afle
         QboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764591834; x=1765196634;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/SCAhmpvJBTo6EtHFLWFijtYJjxdGn01oZUMaCZ9TvA=;
        b=TJ189B4bx5xzykCSDSxqnfC2pgF7v7rsDJG7ibbQGc5n7BKM+86gvn3Qg010EfDkAs
         CHEykxmKEEHecrNdq3M3jdy/4PjRiAXlRNcf6Mht43WMX8II8PHFE//GV+Mc92g6Qde3
         hv2YMn81vz0Syv8YV/Ngc6kLG7TOonR1+7dBL/FXhBDEfERc2kMVPO8voC0zhp9NNcEx
         vUFfuL8Plf727rYF8rgc8+5H2YX1FlVWpqn/HY1y3RE/IEY+x8gRUkFVqbDMAfxOpUEl
         Lnlyflz8h1ztpYJgs5VII5y45nIk1Q/z3JhJbVolxW1tboILWzbAaINNCn7PRXaqWIOm
         WO9w==
X-Forwarded-Encrypted: i=1; AJvYcCV72+uxS1B1VOramKHDK1KmtpZvnlhwWOMF3iTr9F+4zJepoCUQ6srfLsDBR+ZEgVPP3dnSsc/fpUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7wdC+t5IiIIcKAKLI3izGSwaLdm5FmpnC2VisJi6iMjiZvvt/
	VgNwydcDWpzXTTHYs5iZJYdj4HQ6YZMkGfg302yOYPFWRHD5CCcL2OG/N+rlzIBG/PAcPUq/W+U
	yNw6ZDewFrNDJkqQ7Iw==
X-Google-Smtp-Source: AGHT+IFknxl2+JN9VuOGneKx9mUzIGrKj8KO3g4UaOQwV/K6bceXaYHuc2HNujh3PftyeMvcd0IlJ2TVLLyMDL8=
X-Received: from wma6.prod.google.com ([2002:a05:600c:8906:b0:477:14b1:69d7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3549:b0:477:9fa0:7495 with SMTP id 5b1f17b1804b1-477c053069fmr363795915e9.14.1764591834264;
 Mon, 01 Dec 2025 04:23:54 -0800 (PST)
Date: Mon, 1 Dec 2025 12:23:53 +0000
In-Reply-To: <DEMV14GBQWMC.28TXT8E5YO5NW@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251119112117.116979-1-zhiw@nvidia.com> <20251119112117.116979-4-zhiw@nvidia.com>
 <aSB1Hcqr6W7EEjjK@google.com> <DEHTK1CK84WO.28LTX338E4PXQ@nvidia.com>
 <aSXD-I8bYUA-72vi@google.com> <DEIGORHCX5VR.2EIPZECA0XGVH@nvidia.com>
 <aSbNddXgvv5AXqkU@google.com> <DEIO1A8N2C66.11BXTCZW4MKWZ@nvidia.com> <DEMV14GBQWMC.28TXT8E5YO5NW@nvidia.com>
Message-ID: <aS2I2eHZ9G96ER-h@google.com>
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

On Mon, Dec 01, 2025 at 08:57:09PM +0900, Alexandre Courbot wrote:
> On Wed Nov 26, 2025 at 10:37 PM JST, Alexandre Courbot wrote:
> > On Wed Nov 26, 2025 at 6:50 PM JST, Alice Ryhl wrote:
> >> On Wed, Nov 26, 2025 at 04:52:05PM +0900, Alexandre Courbot wrote:
> >>> On Tue Nov 25, 2025 at 11:58 PM JST, Alice Ryhl wrote:
> >>> > On Tue, Nov 25, 2025 at 10:44:29PM +0900, Alexandre Courbot wrote:
> >>> >> On Fri Nov 21, 2025 at 11:20 PM JST, Alice Ryhl wrote:
> >>> >> > On Wed, Nov 19, 2025 at 01:21:13PM +0200, Zhi Wang wrote:
> >>> >> >> The previous Io<SIZE> type combined both the generic I/O access helpers
> >>> >> >> and MMIO implementation details in a single struct.
> >>> >> >> 
> >>> >> >> To establish a cleaner layering between the I/O interface and its concrete
> >>> >> >> backends, paving the way for supporting additional I/O mechanisms in the
> >>> >> >> future, Io<SIZE> need to be factored.
> >>> >> >> 
> >>> >> >> Factor the common helpers into new {Io, Io64} traits, and move the
> >>> >> >> MMIO-specific logic into a dedicated Mmio<SIZE> type implementing that
> >>> >> >> trait. Rename the IoRaw to MmioRaw and update the bus MMIO implementations
> >>> >> >> to use MmioRaw.
> >>> >> >> 
> >>> >> >> No functional change intended.
> >>> >> >> 
> >>> >> >> Cc: Alexandre Courbot <acourbot@nvidia.com>
> >>> >> >> Cc: Alice Ryhl <aliceryhl@google.com>
> >>> >> >> Cc: Bjorn Helgaas <helgaas@kernel.org>
> >>> >> >> Cc: Danilo Krummrich <dakr@kernel.org>
> >>> >> >> Cc: John Hubbard <jhubbard@nvidia.com>
> >>> >> >> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> >>> >> >
> >>> >> > I said this on a previous version, but I still don't buy the split
> >>> >> > into IoFallible and IoInfallible.
> >>> >> >
> >>> >> > For one, we're never going to have a method that can accept any Io - we
> >>> >> > will always want to accept either IoInfallible or IoFallible, so the
> >>> >> > base Io trait serves no purpose.
> >>> >> >
> >>> >> > For another, the docs explain that the distinction between them is
> >>> >> > whether the bounds check is done at compile-time or runtime. That is not
> >>> >> > the kind of capability one normally uses different traits to distinguish
> >>> >> > between. It makes sense to have additional traits to distinguish
> >>> >> > between e.g.:
> >>> >> >
> >>> >> > * Whether IO ops can fail for reasons *other* than bounds checks.
> >>> >> > * Whether 64-bit IO ops are possible.
> >>> >> >
> >>> >> > Well ... I guess one could distinguish between whether it's possible to
> >>> >> > check bounds at compile-time at all. But if you can check them at
> >>> >> > compile-time, it should always be possible to check at runtime too, so
> >>> >> > one should be a sub-trait of the other if you want to distinguish
> >>> >> > them. (And then a trait name of KnownSizeIo would be more idiomatic.)
> >>> >> >
> >>> >> > And I'm not really convinced that the current compile-time checked
> >>> >> > traits are a good idea at all. See:
> >>> >> > https://lore.kernel.org/all/DEEEZRYSYSS0.28PPK371D100F@nvidia.com/
> >>> >> >
> >>> >> > If we want to have a compile-time checked trait, then the idiomatic way
> >>> >> > to do that in Rust would be to have a new integer type that's guaranteed
> >>> >> > to only contain integers <= the size. For example, the Bounded integer
> >>> >> > being added elsewhere.
> >>> >> 
> >>> >> Would that be so different from using an associated const value though?
> >>> >> IIUC the bounded integer type would play the same role, only slightly
> >>> >> differently - by that I mean that if the offset is expressed by an
> >>> >> expression that is not const (such as an indexed access), then the
> >>> >> bounded integer still needs to rely on `build_assert` to be built.
> >>> >
> >>> > I mean something like this:
> >>> >
> >>> > trait Io {
> >>> >     const SIZE: usize;
> >>> >     fn write(&mut self, i: Bounded<Self::SIZE>);
> >>> > }
> >>> 
> >>> I have experimented a bit with this idea, and unfortunately expressing
> >>> `Bounded<Self::SIZE>` requires the generic_const_exprs feature and is
> >>> not doable as of today.
> >>> 
> >>> Bounding an integer with an upper/lower bound also proves to be more
> >>> demanding than the current `Bounded` design. For the `MIN` and `MAX`
> >>> constants must be of the same type as the wrapped `T` type, which again
> >>> makes rustc unhappy ("the type of const parameters must not depend on
> >>> other generic parameters"). A workaround would be to use a macro to
> >>> define individual types for each integer type we want to support - or to
> >>> just limit this to `usize`.
> >>> 
> >>> But the requirement for generic_const_exprs makes this a non-starter I'm
> >>> afraid. :/
> >>
> >> Can you try this?
> >>
> >> trait Io {
> >>     type IdxInt: Int;
> >>     fn write(&mut self, i: Self::IdxInt);
> >> }
> >>
> >> then implementers would write:
> >>
> >> impl Io for MyIo {
> >>     type IdxInt = Bounded<17>;
> >> }
> >>
> >> instead of:
> >> impl Io for MyIo {
> >>     const SIZE = 17;
> >> }
> >
> > The following builds (using the existing `Bounded` type for
> > demonstration purposes):
> >
> >     trait Io {
> >         // Type containing an index guaranteed to be valid for this IO.
> >         type IdxInt: Into<usize>;
> >
> >         fn write(&mut self, i: Self::IdxInt);
> >     }
> >
> >     struct FooIo;
> >
> >     impl Io for FooIo {
> >         type IdxInt = Bounded<usize, 8>;
> >
> >         fn write(&mut self, i: Self::IdxInt) {
> >             let idx: usize = i.into();
> >
> >             // Now do the IO knowing that `idx` is a valid index.
> >         }
> >     }
> >
> > That looks promising, and I like how we can effectively use a wider set
> > of index types - even, say, a `u16` if a particular I/O happens to have
> > a guaranteed size of 65536!
> >
> > I suspect it also changes how we would design the Io interfaces, but I
> > am not sure how yet. Maybe `IoKnownSize` being built on top of `Io`, and
> > either unwrapping the result of its fallible methods or using some
> > `unchecked` accessors?
> 
> Mmm, one important point I have neglected is that the index type will
> have to validate not only the range, but also the alignment of the
> index! And the valid alignment is dependent on the access width. So
> getting this right is going to take some time and some experimenting I'm
> afraid.
> 
> Meanwhile, it would be great if we could agree (and proceed) with the
> split of the I/O interface into a trait, as other work depends on it.
> Changing the index type of compile-time checked bounds is I think an
> improvement that is orthogonal to this task.



> I have been thinking a bit (too much? ^_^;) about the general design for
> this interface, how it would work with the `register!` macro, and how we
> could maybe limit the boilerplate. Sorry in advance for this is going to
> be a long post.
> 
> IIUC there are several aspects we need to tackle with the I/O interface:
> 
> - Raw IO access. Given an address, perform the IO operation without any
>   check. Depending on the bus, this might return the data directly (e.g.
>   `Mmio`), or a `Result` (e.g. the PCI `ConfigSpace`). The current
>   implementation ignores the bus error, which we probably shouldn't.
>   Also the raw access is reimplemented twice, in both the build-time and
>   runtime accessors, a fact that is mostly hidden by the use of macros.
> - Access with dynamic bounds check. This can return `EINVAL` if the
>   provided index is invalid (out-of-bounds or not aligned), on top of
>   the bus errors, if any.
> - Access with build-time index check. Same as above, but the error
>   occurs at build time if the index is invalid. Otherwise the return
>   type of the raw IO accessor is returned.
> 
> At the moment we have two traits for build-time and runtime index
> checks. What bothers me a bit about them is that they basically
> re-implement the same raw I/O accessors. This strongly hints that we
> should implement the raw accessors as a base trait, which the
> user-facing API would call into:
> 
>   pub trait Io {
>       /// Error type returned by IO accessors. Can be `Infallible` for e.g. `Mmio`.
>       type Error: Into<Error>;
> 
>       /// Returns the base address of this mapping.
>       fn addr(&self) -> usize;
> 
>       /// Returns the maximum size of this mapping.
>       fn maxsize(&self) -> usize;
> 
>       unsafe fn try_read8_unchecked(&self, addr: usize) -> Result<u8, Self::Error>;
>       unsafe fn try_write8_unchecked(&self, value: u8, addr: usize) -> Result<(), Self::Error>;
>       // etc. for 16/32 bits accessors.
>   }
> 
> Then we could build the current `IoFallible` trait on top of it:
> 
>   pub trait IoFallible: Io {
>       fn io_addr<U>(&self, offset: usize) -> Result<usize> {
>           if !offset_valid::<U>(offset, self.maxsize()) {
>               return Err(EINVAL);
>           }
> 
>           self.addr().checked_add(offset).ok_or(EINVAL)
>       }
> 
>       /// 8-bit read with runtime bounds check.
>       fn try_read8_checked(&self, offset: usize) -> Result<u8> {
>           let addr = self.io_addr::<u8>(offset)?;
> 
>           unsafe { self.try_read8_unchecked(addr) }.map_err(Into::into)
>       }
> 
>       /// 8-bit write with runtime bounds check.
>       fn try_write8_checked(&self, value: u8, offset: usize) -> Result {
>           let addr = self.io_addr::<u8>(offset)?;
> 
>           unsafe { self.try_write8_unchecked(value, addr) }.map_err(Into::into)
>       }
>   }
> 
> Note how this trait is now auto-implemented. Making it available for all
> implementers of `Io` is as simple as:
> 
>   impl<IO: Io> IoFallible for IO {}
> 
> (... which hints that maybe it should simply be folded into `Io`, as
> Alice previously suggested)

Yes, it probably should. At the very least, it should be an extension
trait, which means that it should never be used in trait bounds, since
T: IoFallible is equivalent to T: Io. But in this case, probably just
fold it into Io.

> `IoKnownSize` also calls into the base `Io` trait:
> 
>   /// Trait for IO with a build-time known valid range.
>   pub unsafe trait IoKnownSize: Io {
>       /// Minimum usable size of this region.
>       const MIN_SIZE: usize;
> 
>       #[inline(always)]
>       fn io_addr_assert<U>(&self, offset: usize) -> usize {
>           build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
> 
>           self.addr() + offset
>       }
> 
>       /// 8-bit read with compile-time bounds check.
>       #[inline(always)]
>       fn try_read8(&self, offset: usize) -> Result<u8, Self::Error> {
>           let addr = self.io_addr_assert::<u8>(offset);
> 
>           unsafe { self.try_read8_unchecked(addr) }
>       }
> 
>       /// 8-bit write with compile-time bounds check.
>       #[inline(always)]
>       fn try_write8(&self, value: u8, offset: usize) -> Result<(), Self::Error> {
>           let addr = self.io_addr_assert::<u8>(offset);
> 
>           unsafe { self.try_write8_unchecked(value, addr) }
>       }
>   }
> 
> Its accessors now return the error type of the bus, which is good for
> safety, but not for ergonomics when dealing with e.g. code that works
> with `Mmio`, which we know is infallible. But we can provide an extra
> set of methods in this trait for this case:
> 
>       /// Infallible 8-bit read with compile-time bounds check.
>       #[inline(always)]
>       fn read8(&self, offset: usize) -> u8
>       where
>           Self: Io<Error = Infallible>,
>       {
>           self.read8(offset).unwrap_or_else(|e| match e {})
>       }
> 
>       /// Infallible 8-bit write with compile-time bounds check.
>       #[inline(always)]
>       fn write8(&self, value: u8, offset: usize)
>       where
>           Self: Io<Error = Infallible>,
>       {
>           self.write8(value, offset).unwrap_or_else(|e| match e {})
>       }
> 
> `Mmio`'s impl blocks are now reduced to the following:
> 
>   impl<const SIZE: usize> Io for Mmio<SIZE> {
>       type Error = core::convert::Infallible;
> 
>       #[inline]
>       fn addr(&self) -> usize {
>           self.0.addr()
>       }
> 
>       #[inline]
>       fn maxsize(&self) -> usize {
>           self.0.maxsize()
>       }
> 
>       unsafe fn try_read8_unchecked(&self, addr: usize) -> Result<u8, Self::Error> {
>           Ok(unsafe { bindings::readb(addr as *const c_void) })
>       }
> 
>       unsafe fn try_write8_unchecked(&self, value: u8, addr: usize) -> Result<(), Self::Error> {
>           Ok(unsafe { bindings::writeb(value, addr as *mut c_void) })
>       }
>   }
> 
>   unsafe impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {
>       const MIN_SIZE: usize = SIZE;
>   }
> 
> ... and that's enough to provide everything we had so far - all of the
> accessors called by users are already implemented in the base traits.
> Note also the lack of macros.
> 
> Another point that I noticed was the relaxed MMIO accessors. They are
> currently implemented as a set of dedicated methods (e.g.
> `read8_relaxed`) that are not part of a trait. This results in a lot of
> additional methods, and limits their usefulness as the same generic
> function could not be used with both regular and relaxed accesses.
> 
> So I'd propose to implement them using a relaxed wrapper type:
> 
>   /// Wrapper for [`Mmio`] that performs relaxed I/O accesses.
>   pub struct RelaxedMmio<'a, const SIZE: usize>(&'a Mmio<SIZE>);
> 
>   impl<'a, const SIZE: usize> RelaxedMmio<'a, SIZE> {
>     pub fn new(mmio: &'a Mmio<SIZE>) -> Self {
>         Self(mmio)
>     }
>   }
> 
>   impl<'a, const SIZE: usize> Io for RelaxedMmio<'a, SIZE> {
>     fn addr(&self) -> usize {
>         self.0.addr()
>     }
> 
>     fn maxsize(&self) -> usize {
>         self.0.maxsize()
>     }
> 
>     type Error = <Mmio as Io>::Error;
> 
>     unsafe fn try_read8_unchecked(&self, addr: usize) -> Result<u8, Self::Error> {
>         Ok(unsafe { bindings::readb_relaxed(addr as *const c_void) })
>     }
> 
>     unsafe fn try_write8_unchecked(&self, value: u8, addr: usize) -> Result<(), Self::Error> {
>         Ok(unsafe { bindings::writeb_relaxed(value, addr as *mut c_void) })
>     }
> 
>     // SAFETY: `MIN_SIZE` is the same as the wrapped type, which also implements `IoKnownSize`.
>     unsafe impl<'a, const SIZE: usize> IoKnownSize for RelaxedMmio<'a, SIZE> {
>         const MIN_SIZE: usize = SIZE;
>     }
>   }
> 
> This way, when you need to do I/O using a register, you can either pass
> the `Mmio` instance or derive a `RelaxedMmio` from it, if that access
> pattern is more adequate.

This sounds like a reasonable way to handle relaxed mmio.

> How does this sound? I can share a branch with a basic implementation
> of this idea if that helps.

My main thoughts are:

First, we need to think some more about the naming. Currently you have
several methods with the same name. For example, you have a read8 method
implemented in terms of a different read8 method. It'd be nice with a
summary of the meaning of:

* try_ prefix
* _unchecked suffix
* _checked suffix (not the same as try_ prefix?)



Second, I think we need to think a bit more about the error types.
Perhaps the trait could define:

/// Error type used by `*_unchecked` methods.
type Error;

/// Error type that can be either `Self::Error` or a failed bounds
/// check.
type TryError: From<Self::Error> + From<BoundsError>;

where BoundsError is a new zero-sized error type we can define
somewhere. This way, Mmio can use these errors:

type Error = Infallible;
type TryError = BoundsError;

wheres cases that can fail with an IO error can use kernel::error::Error
for both cases.



Third, if we're going to postpone the custom integer type for
IoKnownSize, then I think we should get rid of build-checked IO ops
entirely for now.



Fourth, I didn't know about the alignment requirement. I would like to
know how that fits in with the rest of this. Is it treated like a bounds
check? That could make sense, and we could also have a custom integer
type that both has a max value and alignment invariant. But what about
the *_unchecked and runtime bounds-checked methods?

Alice

