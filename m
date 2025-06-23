Return-Path: <linux-pci+bounces-30374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D093AE3EBB
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 13:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D0C1883154
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 11:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E562405E8;
	Mon, 23 Jun 2025 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MAL5Igze"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722EB244663
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679805; cv=none; b=eVXuclCEeO8fLFCteUpAvU3v1/E4fc001cZOpx+hmXnCEo65f3PKOexiqSToX9RMF1k4m6OQB8tMJs+7mx8xENbUBJGxwbFiW/MVv6wYINfLANltijj6l6vOywJwjEsZ/B+WtwtuFX9i5+B10TqvsqaxmYuWWPBWxQ7Bji0eZFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679805; c=relaxed/simple;
	bh=UbxiP1HMzgRKP4//469z6CJnvQrWp32Me/Ig5nIpoJo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jyZqlZLUqlh5ikGXAWnQgOPQvEKXkQsw1B5K0agTYP5DUTT75SRep3CzbkfcGUCBPg/g70lxZ9nioXTGP1PdFwV41n3wGzC0sqSnESt9aFkDdulQ7q43vswA6qUlb5Ess6a7aFo1oadiGPoP1aS6Ocy0/A7SGwg2UDIk9jqigQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MAL5Igze; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-450d64026baso25136525e9.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 04:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750679802; x=1751284602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WznfPCr3ji0Qd/N5x0pdDuthOqQFGi24UpC7Z0hlolI=;
        b=MAL5IgzemLl1F9GKalaEsxRq6WVvyFphgHSRmEZgCiqbqbfQjawc/yQxNB9T2bXboK
         0O/ee3jPMshAAj/yGbmDn3fLUTv+Ve/SQpH5nHK2apNJJW8ydY12EjKSjM9DlxGvUFiZ
         Qk0ZZwMbeUPK+svNB0eoule9wdI9BriZE8Ja5ttg9TzvNjbkMElRM5CxOSUAnU4UnYOX
         VlBWyET8LbaV1BRvnvWDACZDdmvDzG20sAJ1/EDW4VUTH7TPmnXi/RrBlum0WRXrZZxh
         ys4BTfq75BoctV7eNnulFtqydtq1whj564kPtD+yKtNt/jGjsFJeTrW6kdcfY2OsGl/F
         qAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750679802; x=1751284602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WznfPCr3ji0Qd/N5x0pdDuthOqQFGi24UpC7Z0hlolI=;
        b=c+StnLLInhRXEXpFiQ67WpHbJE0fB5djVyfn3egAAV8gIyEhSsWPZ4IzFye9VIQtd+
         52DMLYqwpCblTrL97Hs/PK4+jprGZCTD7fPWicRMtCKkqRj3PEYXbqaqRPV9QfCb7c3K
         waZa2PgpjSBRb/wHJxn+y5Gslq7cN8Y6wsXyvpz/ekuEjSoE/G95g8WtLauphS1s04U9
         mZ2Do2xJXeLvfTVp5i9Y70G/bz14TQ0ONm5zCnwTAAe+qrqZiDLPCBgqECE1QI0XjvT9
         24Q9m98IftNq3fFkEp65Gh6kJc6xdSBwkOFbylTAq04dn6TpDSYmzygVLQDxTpaz56RB
         1nKg==
X-Forwarded-Encrypted: i=1; AJvYcCXK5/v3NcmHuYU/J7+UnejF1NpJ7cPbITQHa5OhVQbYQ+yFw6/J+9zDIKQ4S4vla2vBoASovn/WOmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRYXtauc9nOpFDYKY4+sglZnFHDst1Y6u4YMvXiM9pDMUuSJW
	6C3DKHdDgGWIwj2oS0rfle+afao7QoEJZhOdxKOiWwbUiuTkAI9MhZaVhv0+bkYDAMt15h2iO78
	1hzX7wsKb9b10//7DRQ==
X-Google-Smtp-Source: AGHT+IFAk0L7Yy/cvufYoYyUIG8/CK919SkwakepzRxAgIht3daWeoHvt9gxR2iHyoZC4EAiRssQv2HNLcAs0IU=
X-Received: from wmbfs5.prod.google.com ([2002:a05:600c:3f85:b0:450:cfda:ece7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5025:b0:450:d386:1afb with SMTP id 5b1f17b1804b1-453659c5915mr133240875e9.9.1750679801773;
 Mon, 23 Jun 2025 04:56:41 -0700 (PDT)
Date: Mon, 23 Jun 2025 11:56:39 +0000
In-Reply-To: <20250622164050.20358-3-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250622164050.20358-1-dakr@kernel.org> <20250622164050.20358-3-dakr@kernel.org>
Message-ID: <aFlA92ooeQsSThLh@google.com>
Subject: Re: [PATCH v2 2/4] rust: devres: replace Devres::new_foreign_owned()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com, 
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Dave Airlie <airlied@redhat.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="utf-8"

On Sun, Jun 22, 2025 at 06:40:39PM +0200, Danilo Krummrich wrote:
> Replace Devres::new_foreign_owned() with devres::register().
> 
> The current implementation of Devres::new_foreign_owned() creates a full
> Devres container instance, including the internal Revocable and
> completion.
> 
> However, none of that is necessary for the intended use of giving full
> ownership of an object to devres and getting it dropped once the given
> device is unbound.
> 
> Hence, implement devres::register(), which is limited to consume the
> given data, wrap it in a KBox and drop the KBox once the given device is
> unbound, without any other synchronization.
> 
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

overall looks good
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/helpers/device.c     |  7 ++++
>  rust/kernel/cpufreq.rs    | 11 +++---
>  rust/kernel/devres.rs     | 70 +++++++++++++++++++++++++++++++++------
>  rust/kernel/drm/driver.rs | 14 ++++----
>  4 files changed, 82 insertions(+), 20 deletions(-)
> 
> diff --git a/rust/helpers/device.c b/rust/helpers/device.c
> index b2135c6686b0..502fef7e9ae8 100644
> --- a/rust/helpers/device.c
> +++ b/rust/helpers/device.c
> @@ -8,3 +8,10 @@ int rust_helper_devm_add_action(struct device *dev,
>  {
>  	return devm_add_action(dev, action, data);
>  }
> +
> +int rust_helper_devm_add_action_or_reset(struct device *dev,
> +					 void (*action)(void *),
> +					 void *data)
> +{
> +	return devm_add_action_or_reset(dev, action, data);
> +}
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index 11b03e9d7e89..dd84e2b4d7ae 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -13,7 +13,7 @@
>      cpu::CpuId,
>      cpumask,
>      device::{Bound, Device},
> -    devres::Devres,
> +    devres,
>      error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
>      ffi::{c_char, c_ulong},
>      prelude::*,
> @@ -1046,10 +1046,13 @@ pub fn new() -> Result<Self> {
>  
>      /// Same as [`Registration::new`], but does not return a [`Registration`] instance.
>      ///
> -    /// Instead the [`Registration`] is owned by [`Devres`] and will be revoked / dropped, once the
> +    /// Instead the [`Registration`] is owned by [`devres::register`] and will be dropped, once the
>      /// device is detached.
> -    pub fn new_foreign_owned(dev: &Device<Bound>) -> Result {
> -        Devres::new_foreign_owned(dev, Self::new()?, GFP_KERNEL)
> +    pub fn new_foreign_owned(dev: &Device<Bound>) -> Result
> +    where
> +        T: 'static,
> +    {
> +        devres::register(dev, Self::new()?, GFP_KERNEL)
>      }
>  }
>  
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 544e50efab43..250073749279 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -9,12 +9,12 @@
>      alloc::Flags,
>      bindings,
>      device::{Bound, Device},
> -    error::{Error, Result},
> +    error::{to_result, Error, Result},
>      ffi::c_void,
>      prelude::*,
>      revocable::{Revocable, RevocableGuard},
>      sync::{rcu, Arc, Completion},
> -    types::ARef,
> +    types::{ARef, ForeignOwnable},
>  };
>  
>  #[pin_data]
> @@ -184,14 +184,6 @@ pub fn new(dev: &Device<Bound>, data: T, flags: Flags) -> Result<Self> {
>          Ok(Devres(inner))
>      }
>  
> -    /// Same as [`Devres::new`], but does not return a `Devres` instance. Instead the given `data`
> -    /// is owned by devres and will be revoked / dropped, once the device is detached.
> -    pub fn new_foreign_owned(dev: &Device<Bound>, data: T, flags: Flags) -> Result {
> -        let _ = DevresInner::new(dev, data, flags)?;
> -
> -        Ok(())
> -    }
> -
>      /// Obtain `&'a T`, bypassing the [`Revocable`].
>      ///
>      /// This method allows to directly obtain a `&'a T`, bypassing the [`Revocable`], by presenting
> @@ -261,3 +253,61 @@ fn drop(&mut self) {
>          }
>      }
>  }
> +
> +/// Consume `data` and [`Drop::drop`] `data` once `dev` is unbound.
> +fn register_foreign<P: ForeignOwnable>(dev: &Device<Bound>, data: P) -> Result {
> +    let ptr = data.into_foreign();
> +
> +    #[allow(clippy::missing_safety_doc)]
> +    unsafe extern "C" fn callback<P: ForeignOwnable>(ptr: *mut kernel::ffi::c_void) {
> +        // SAFETY: `ptr` is the pointer to the `ForeignOwnable` leaked above and hence valid.
> +        let _ = unsafe { P::from_foreign(ptr.cast()) };

Nit: I usually write this
drop(unsafe { P::from_foreign(ptr.cast()) });

> +    }
> +
> +    // SAFETY:
> +    // - `dev.as_raw()` is a pointer to a valid and bound device.
> +    // - `ptr` is a valid pointer the `ForeignOwnable` devres takes ownership of.
> +    to_result(unsafe {
> +        // `devm_add_action_or_reset()` also calls `callback` on failure, such that the
> +        // `ForeignOwnable` is released eventually.
> +        bindings::devm_add_action_or_reset(dev.as_raw(), Some(callback::<P>), ptr.cast())
> +    })
> +}
> +
> +/// Encapsulate `data` in a [`KBox`] and [`Drop::drop`] `data` once `dev` is unbound.
> +///
> +/// # Examples
> +///
> +/// ```no_run
> +/// use kernel::{device::{Bound, Device}, devres};
> +///
> +/// /// Registration of e.g. a class device, IRQ, etc.
> +/// struct Registration;
> +///
> +/// impl Registration {
> +///     fn new() -> Self {
> +///         // register
> +///
> +///         Self
> +///     }
> +/// }
> +///
> +/// impl Drop for Registration {
> +///     fn drop(&mut self) {
> +///        // unregister
> +///     }
> +/// }
> +///
> +/// fn from_bound_context(dev: &Device<Bound>) -> Result {
> +///     devres::register(dev, Registration::new(), GFP_KERNEL)
> +/// }
> +/// ```
> +pub fn register<T, E>(dev: &Device<Bound>, data: impl PinInit<T, E>, flags: Flags) -> Result
> +where
> +    T: 'static,
> +    Error: From<E>,
> +{
> +    let data = KBox::pin_init(data, flags)?;

Wouldn't we also want to expose the ForeignOwnable version? It seems
likely someone would want to avoid the allocation.

> +    register_foreign(dev, data)
> +}
> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> index acb638086131..f63addaf7235 100644
> --- a/rust/kernel/drm/driver.rs
> +++ b/rust/kernel/drm/driver.rs
> @@ -5,9 +5,7 @@
>  //! C header: [`include/linux/drm/drm_drv.h`](srctree/include/linux/drm/drm_drv.h)
>  
>  use crate::{
> -    bindings, device,
> -    devres::Devres,
> -    drm,
> +    bindings, device, devres, drm,
>      error::{to_result, Result},
>      prelude::*,
>      str::CStr,
> @@ -130,18 +128,22 @@ fn new(drm: &drm::Device<T>, flags: usize) -> Result<Self> {
>      }
>  
>      /// Same as [`Registration::new`}, but transfers ownership of the [`Registration`] to
> -    /// [`Devres`].
> +    /// [`devres::register`].
>      pub fn new_foreign_owned(
>          drm: &drm::Device<T>,
>          dev: &device::Device<device::Bound>,
>          flags: usize,
> -    ) -> Result {
> +    ) -> Result
> +    where
> +        T: 'static,
> +    {
>          if drm.as_ref().as_raw() != dev.as_raw() {
>              return Err(EINVAL);
>          }
>  
>          let reg = Registration::<T>::new(drm, flags)?;
> -        Devres::new_foreign_owned(dev, reg, GFP_KERNEL)
> +
> +        devres::register(dev, reg, GFP_KERNEL)
>      }
>  
>      /// Returns a reference to the `Device` instance for this registration.
> -- 
> 2.49.0
> 

