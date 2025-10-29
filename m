Return-Path: <linux-pci+bounces-39695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3401AC1CA30
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B44642B5C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E326734C9B5;
	Wed, 29 Oct 2025 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2af2bBXx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879C831283D
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758450; cv=none; b=gU1CR1woWHBmfPCNjgCi7n+7284ZajTl+lFom7pRZsE0OzAZuAuIijYit95WfPpA2WzThj1mnnhJ/YrE/UV9DM0SBGPZu4Q2pscl84UypuZYnaWgHO6XUYbyylULdvMxQBAmUwefPjOTFI+MjarSlqyN4yrQTEN7fX+ibk/2eUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758450; c=relaxed/simple;
	bh=U16m83/Gcf1XGqi+Rq2JmjjlOI++9MgmhO4/Qsx6nu8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tMdG6RMnUGVoxbMpYIAIrUZ7DQvaAQQWoZ2H8muxw6vbtn22d8A9MXBmVbUN5RR1b+ycXJWIyz870xGzERCLaXUTP1K0OwbZTtZNofPnnCpOS8VQ4JC7+zKL8wqOlKSOpwVYWBcf8udvxODCb84qp1QPu61Oxv1/CkijaEN2EVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2af2bBXx; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-6349af0e766so19655a12.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 10:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761758446; x=1762363246; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kM27j0DbRQduvVXbN4VD6lY5rFBEEc97ik8wcD70Nyk=;
        b=2af2bBXxTesuMB97Icyu7D+QHDdl7BS8TGYNbJ11wmAAPbg2NwqLxuiihE8Loltl5S
         OBOXipVR8rEnBmoaKxV6IvUIPSBhb/NUgCW4vcg9poq8/rKPtE3N76Ibkn9Bz1vjs8yc
         Jgs4JJNPRHUyqJ+r8GyLExJjI6qPR1Cw7EPExjk7odKxrXp1QmQJbN9NkXV4zkN92Lrl
         gW4Ir9AQ6jKFvMZKNOAO0Y+fsQ5nNF17BEi6MD81gfgnzIpJhb+El79LuuxcedqjpiX/
         fMqVi5CVmxw6+MWZq4ROntHlefQgfUHnwmnc+k0I9kChN5+Y0okBHQ8KGPdOKiB06GUz
         Uthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761758446; x=1762363246;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kM27j0DbRQduvVXbN4VD6lY5rFBEEc97ik8wcD70Nyk=;
        b=DcNSXFaPvOW/Nt3KjpGvWDqpC3Yjaiq/vxIKcNN15V9W1aVsc2jy1tsURtr7OZYeIv
         zvMoT/eKZBUg5+QGvHZyAOfnwCqbORCvSPrFszaJu9YUWl4gA2fc4pdrZsSkKsL4525F
         RltQmYb9d3OwCnPl8Uo0I7H+k6UAQkaSbBEBJh5YQfgyEkposSeOdFEjT66+Kt20FYWi
         iAYEMlwvFSs3KO5y9/2E2b+y6aggjmHLRLxa++wyM6IR0SCj3zMbWMPltSJ5fS/l5Ymx
         Upr/gCgpDf4by+WtaRdNGbOoQcsDMCwebbNcGvDrtemDnL/5HnoOTKkKn9OFPgi3fKJB
         kRVA==
X-Forwarded-Encrypted: i=1; AJvYcCVqvT5tm8TPMH04geybewF6OWPrX0tm0JULfsMpE8naniURwagvbyBgxLpbYIq3uTCYn+jW7HxnnQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgSZywoPtmCH8cNVnLb0OHw4xiacH8IUc5NK87bqndjMjpFeXC
	VPD411XrpYnWJn0ZwgdffxYucHQ0LC4MvGCItyBsq7fTvQphGBAHpD3LEGJY1KcpB2wReSFOedP
	wQ+1AOFVOffpadEtTnQ==
X-Google-Smtp-Source: AGHT+IFeI/lWgOxI9EhJhsy7efb6ErsnV+B/7YSHBNsEFaFOX35xaF7//pCcavnrCDXi6DKof40usW+WW6BwBvo=
X-Received: from edbes17.prod.google.com ([2002:a05:6402:3811:b0:640:3395:a2b5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:34d1:b0:628:b619:49bd with SMTP id 4fb4d7f45d1cf-640443ae15fmr2816033a12.25.1761758446036;
 Wed, 29 Oct 2025 10:20:46 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:20:45 +0000
In-Reply-To: <DDUYV4ETTD50.3UCGLW45AK740@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020223516.241050-1-dakr@kernel.org> <20251020223516.241050-3-dakr@kernel.org>
 <aQIPvaFJIXySV-Q5@google.com> <DDUWW90NZIDY.2TVA8S0RDSXZJ@kernel.org> <DDUYV4ETTD50.3UCGLW45AK740@kernel.org>
Message-ID: <aQJM7XPZ-0wtDDCX@google.com>
Subject: Re: [PATCH 2/8] rust: device: introduce Device::drvdata()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, david.m.ertman@intel.com, ira.weiny@intel.com, 
	leon@kernel.org, acourbot@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	pcolberg@redhat.com, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 29, 2025 at 06:02:45PM +0100, Danilo Krummrich wrote:
> On Wed Oct 29, 2025 at 4:30 PM CET, Danilo Krummrich wrote:
> > On Wed Oct 29, 2025 at 1:59 PM CET, Alice Ryhl wrote:
> >> Are you going to open that docs PR to the Rust compiler about the size
> >> of TypeID that we talked about? :)
> >
> > Yes, I will -- thanks for the reminder.
> >
> >> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> >>
> >>> +// Compile-time checks.
> >>> +const _: () = {
> >>> +    // Assert that we can `read()` / `write()` a `TypeId` instance from / into `struct driver_type`.
> >>> +    static_assert!(core::mem::size_of::<bindings::driver_type>() == core::mem::size_of::<TypeId>());
> >>> +};
> >>
> >> You don't need the "const _: ()" part. See the definition of
> >> static_assert! to see why.
> >
> > Indeed, good catch -- same for the suggestions below.
> >
> >> Also, I would not require equality. The Rust team did not think that it
> >> would ever increase in size, but it may decrease.
> >>
> >>>  /// The core representation of a device in the kernel's driver model.
> >>>  ///
> >>>  /// This structure represents the Rust abstraction for a C `struct device`. A [`Device`] can either
> >>> @@ -198,12 +204,29 @@ pub unsafe fn as_bound(&self) -> &Device<Bound> {
> >>>  }
> >>>  
> >>>  impl Device<CoreInternal> {
> >>> +    fn type_id_store<T: 'static>(&self) {
> >>
> >> This name isn't great. How about "set_type_id()" instead?
> 
> Here's the diff, including a missing check in case someone tries to call
> Device::drvdata() from probe().
> 
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 36c6eec0ceab..1a307be953c2 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -17,11 +17,8 @@
> 
>  pub mod property;
> 
> -// Compile-time checks.
> -const _: () = {
> -    // Assert that we can `read()` / `write()` a `TypeId` instance from / into `struct driver_type`.
> -    static_assert!(core::mem::size_of::<bindings::driver_type>() == core::mem::size_of::<TypeId>());
> -};
> +// Assert that we can `read()` / `write()` a `TypeId` instance from / into `struct driver_type`.
> +static_assert!(core::mem::size_of::<bindings::driver_type>() >= core::mem::size_of::<TypeId>());
> 
>  /// The core representation of a device in the kernel's driver model.
>  ///
> @@ -204,7 +201,7 @@ pub unsafe fn as_bound(&self) -> &Device<Bound> {
>  }
> 
>  impl Device<CoreInternal> {
> -    fn type_id_store<T: 'static>(&self) {
> +    fn set_type_id<T: 'static>(&self) {
>          // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
>          let private = unsafe { (*self.as_raw()).p };
> 
> @@ -226,7 +223,7 @@ pub fn set_drvdata<T: 'static>(&self, data: impl PinInit<T, Error>) -> Result {
> 
>          // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
>          unsafe { bindings::dev_set_drvdata(self.as_raw(), data.into_foreign().cast()) };
> -        self.type_id_store::<T>();
> +        self.set_type_id::<T>();
> 
>          Ok(())
>      }
> @@ -242,6 +239,9 @@ pub unsafe fn drvdata_obtain<T: 'static>(&self) -> Pin<KBox<T>> {
>          // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
>          let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
> 
> +        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
> +        unsafe { bindings::dev_set_drvdata(self.as_raw(), core::ptr::null_mut()) };
> +
>          // SAFETY:
>          // - By the safety requirements of this function, `ptr` comes from a previous call to
>          //   `into_foreign()`.
> @@ -286,7 +286,7 @@ unsafe fn drvdata_unchecked<T: 'static>(&self) -> Pin<&T> {
>          unsafe { Pin::<KBox<T>>::borrow(ptr.cast()) }
>      }
> 
> -    fn type_id_match<T: 'static>(&self) -> Result {
> +    fn match_type_id<T: 'static>(&self) -> Result {
>          // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
>          let private = unsafe { (*self.as_raw()).p };
> 
> @@ -311,11 +311,16 @@ fn type_id_match<T: 'static>(&self) -> Result {
>      /// Returns a pinned reference to the driver's private data or [`EINVAL`] if it doesn't match
>      /// the asserted type `T`.
>      pub fn drvdata<T: 'static>(&self) -> Result<Pin<&T>> {
> -        self.type_id_match::<T>()?;
> +        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
> +        if unsafe { bindings::dev_get_drvdata(self.as_raw()) }.is_null() {
> +            return Err(ENOENT);
> +        }
> +
> +        self.match_type_id::<T>()?;
> 
>          // SAFETY:
> -        // - The `Bound` device context guarantees that this is only ever call after a call
> -        //   to `set_drvdata()` and before `drvdata_obtain()`.
> +        // - The above check of `dev_get_drvdata()` guarantees that we are called after
> +        //   `set_drvdata()` and before `drvdata_obtain()`.
>          // - We've just checked that the type of the driver's private data is in fact `T`.
>          Ok(unsafe { self.drvdata_unchecked() })
>      }
> 

this looks ok to me.

