Return-Path: <linux-pci+bounces-32652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C35B0C6CE
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 16:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6F35403DB
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 14:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02532DEA93;
	Mon, 21 Jul 2025 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMdJSGsi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A432D3EF8
	for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109132; cv=none; b=UHqu1XBeZ6s7nJYp8/fYJPmbY3CDZHkRqTiK5x5hvcaV9fAN2Z6CyiYr4yKLPcNkPFHUUUVWwJTimjMqL5Brt6X3bRjVcAu3umhWjyOgWyF4S/pLSrX7/RzS2K4g1EDi52YYShKPm7uRLzOQo2NcJjB9EwkweTpl3Kl3qUIAfWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109132; c=relaxed/simple;
	bh=Sj0fSmXwhNPVbGOUYqvSNZOfw4E5wTjpQZzkolMZ1EM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QxkQqPv4aJcFJ7bRjfFucFJ46wkpEaRl+4k9TDLcUM3ehME9mBhPmP+fw5pnjdkJPwp7gzirx/XBTKdr9V7RkR5t5WcsatWhcnz/Vm5TY7YMj/jqHIjJ6Cwz87x3Jg5AB6bnB3C3ALF5V6JNh3aDwUE3dxOpTGfRVoaAdYVVX+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EMdJSGsi; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a58939191eso1973246f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753109129; x=1753713929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LtC4Z05mzhS7g6Ch1nM9DNQN8TmyFFO0SYlNTAxzNVw=;
        b=EMdJSGsi6rL8Di0gA0+6j2ht73EVqsqQkzrktc0IcvFDNdeUXS9ktzKTdluC2nO6C1
         mgqzWkK2Wbncw0Ml6ouSArTEZHIuyZvFrl+LFZjpZcmoMh8JmLqaTLw4+bZgKMdEiq6n
         I9oE0GebJhvk2A9I8ZZqQbccLC2//8n4O+kNVUkE1ZFV2sENRJGkrKAL3feBu4kDQgT+
         W6RsdFv9qQn6rfK7otCWJH9ufLZ6CVN0N6EGFJqljG8oGQ/vkdefJIlOKMSRAVT1AO2C
         A/qP2Y2OqfsrfaxanBzHZrActV28sAhALd0J7NDbL54Ol0/YXHPkC0bI9RW5nwDuFuOM
         kKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753109129; x=1753713929;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LtC4Z05mzhS7g6Ch1nM9DNQN8TmyFFO0SYlNTAxzNVw=;
        b=EDGL8LH3jBsr95BX8MW5llSf6EXeZJW4UOum3h3+5BhlXeLlT9P/Mc2jf6wNAaDofC
         8iKfpmzYFS7htFcPpmPUDxnKSIKr8p6jMpe442RysmDF8KmcOGWpNoMaGvUx/DP73ZUC
         sKo7KoAoEZygmTKrhk6kO/FZ71KtRvCtJAQQBd/CD/YyD+8+Q66KlP/uOLc8+PLEkD+w
         rttBS4ScyfZWQpBgg/SaYfYb2us1cnMv6mrQZGn4S9djWDu8X1FdLmBj1Nmr+in6iwOt
         2g16CCe4PkpxaBW3AltSAaZnUwJ+gQGBXQ4ziLfiXhioy2fPro8wGldzY0RTjDSYQLwd
         Wh7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJARB6z7//aDd5kAUMpilEou2tbgCli8X3QXXfo0b/o2uHsGWVTTjNkdt3X3rh2dcHc6PB4Y5n+NY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5yNVzwNq5FeizPCc7cH4eOHAXVoNan1u7kspJ3YlUp9U1hdSD
	nYjAUOZKyEfxJWT21LhVwg9GlDInszYDugtuaQpFCqPCRnQIGkD3zPgtKKSqQDcguStRGTAeprH
	MAA2o0KqOQXRc/Mh3Yw==
X-Google-Smtp-Source: AGHT+IHQcwTPd0muOeBCvdzly+/2PzxIp+TDasbSUibU61zmY2sdtIG0/XLeK/nAWWJK9P13/od4BgixR90u0OQ=
X-Received: from wmbdz10.prod.google.com ([2002:a05:600c:670a:b0:450:cf3f:2a89])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:280a:b0:3b6:18e5:6ec4 with SMTP id ffacd0b85a97d-3b618e57009mr6227745f8f.30.1753109129142;
 Mon, 21 Jul 2025 07:45:29 -0700 (PDT)
Date: Mon, 21 Jul 2025 14:45:28 +0000
In-Reply-To: <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com> <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>
Message-ID: <aH5SiKFESpnD4jvZ@google.com>
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and handlers
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 12:16:40PM -0300, Daniel Almeida wrote:
> This patch adds support for non-threaded IRQs and handlers through
> irq::Registration and the irq::Handler trait.
>=20
> Registering an irq is dependent upon having a IrqRequest that was
> previously allocated by a given device. This will be introduced in
> subsequent patches.
>=20
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Overall LGTM. Some very minor nits below.

> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 7e8f2285064797d5bbac5583990ff823b76c6bdc..fc73b89ff9d539e536a5da938=
8e4926a91a6130e 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -52,6 +52,7 @@
>  #include <linux/ethtool.h>
>  #include <linux/file.h>
>  #include <linux/firmware.h>
> +#include <linux/interrupt.h>
>  #include <linux/fs.h>
>  #include <linux/jiffies.h>
>  #include <linux/jump_label.h>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 0b09bd0e3561c7bf80bf79faf1aebd7eeb851984..653c3f7b85c5f7192b1584c74=
8a9d7e4af3796e9 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -22,6 +22,7 @@
>  #include "dma.c"
>  #include "drm.c"
>  #include "err.c"
> +#include "irq.c"
>  #include "fs.c"
>  #include "io.c"
>  #include "jump_label.c"
> diff --git a/rust/helpers/irq.c b/rust/helpers/irq.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..1faca428e2c047a656dec3171=
855c1508d67e60b
> --- /dev/null
> +++ b/rust/helpers/irq.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/interrupt.h>
> +
> +int rust_helper_request_irq(unsigned int irq, irq_handler_t handler,
> +			    unsigned long flags, const char *name, void *dev)
> +{
> +	return request_irq(irq, handler, flags, name, dev);
> +}
> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
> index 9abd9a6dc36f3e3ecc1f92ad7b0040176b56a079..01bd08884b72c2a3a9460897b=
ce751c732a19794 100644
> --- a/rust/kernel/irq.rs
> +++ b/rust/kernel/irq.rs
> @@ -12,3 +12,8 @@
> =20
>  /// Flags to be used when registering IRQ handlers.
>  pub mod flags;
> +
> +/// IRQ allocation and handling.
> +pub mod request;
> +
> +pub use request::{Handler, IrqRequest, IrqReturn, Registration};
> diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..2f4637d8bc4c9fda23cbc8307=
687035957b0042a
> --- /dev/null
> +++ b/rust/kernel/irq/request.rs
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: Copyright 2025 Collabora ltd.
> +
> +//! This module provides types like [`Registration`] which allow users t=
o
> +//! register handlers for a given IRQ line.
> +
> +use core::marker::PhantomPinned;
> +
> +use crate::alloc::Allocator;
> +use crate::device::Bound;
> +use crate::device::Device;

The usual style is to write this as:

use crate::device::{Bound, Device};

> +use crate::devres::Devres;
> +use crate::error::to_result;
> +use crate::irq::flags::Flags;
> +use crate::prelude::*;
> +use crate::str::CStr;
> +use crate::sync::Arc;
> +
> +/// The value that can be returned from an IrqHandler or a ThreadedIrqHa=
ndler.

Missing links:

/// The value that can be returned from an [`IrqHandler`] or a [`ThreadedIr=
qHandler`].

> +#[repr(u32)]
> +pub enum IrqReturn {
> +    /// The interrupt was not from this device or was not handled.
> +    None =3D bindings::irqreturn_IRQ_NONE,
> +
> +    /// The interrupt was handled by this device.
> +    Handled =3D bindings::irqreturn_IRQ_HANDLED,
> +}
> +
> +/// Callbacks for an IRQ handler.
> +pub trait Handler: Sync {
> +    /// The hard IRQ handler.
> +    ///
> +    /// This is executed in interrupt context, hence all corresponding
> +    /// limitations do apply.
> +    ///
> +    /// All work that does not necessarily need to be executed from
> +    /// interrupt context, should be deferred to a threaded handler.
> +    /// See also [`ThreadedRegistration`].
> +    fn handle(&self) -> IrqReturn;
> +}
> +
> +impl<T: ?Sized + Handler + Send> Handler for Arc<T> {
> +    fn handle(&self) -> IrqReturn {
> +        T::handle(self)
> +    }
> +}
> +
> +impl<T: ?Sized + Handler, A: Allocator> Handler for Box<T, A> {
> +    fn handle(&self) -> IrqReturn {
> +        T::handle(self)
> +    }
> +}
> +
> +/// # Invariants
> +///
> +/// - `self.irq` is the same as the one passed to `request_{threaded}_ir=
q`.
> +/// - `cookie` was passed to `request_{threaded}_irq` as the cookie. It
> +///    is guaranteed to be unique by the type system, since each call to
> +///    `new` will return a different instance of `Registration`.
> +#[pin_data(PinnedDrop)]
> +struct RegistrationInner {
> +    irq: u32,
> +    cookie: *mut c_void,
> +}
> +
> +impl RegistrationInner {
> +    fn synchronize(&self) {
> +        // SAFETY: safe as per the invariants of `RegistrationInner`
> +        unsafe { bindings::synchronize_irq(self.irq) };
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for RegistrationInner {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY:
> +        //
> +        // Safe as per the invariants of `RegistrationInner` and:
> +        //
> +        // - The containing struct is `!Unpin` and was initialized using
> +        // pin-init, so it occupied the same memory location for the ent=
irety of
> +        // its lifetime.
> +        //
> +        // Notice that this will block until all handlers finish executi=
ng,
> +        // i.e.: at no point will &self be invalid while the handler is =
running.
> +        unsafe { bindings::free_irq(self.irq, self.cookie) };
> +    }
> +}
> +
> +// SAFETY: We only use `inner` on drop, which called at most once with n=
o
> +// concurrent access.
> +unsafe impl Sync for RegistrationInner {}
> +
> +// SAFETY: It is safe to send `RegistrationInner` across threads.
> +unsafe impl Send for RegistrationInner {}
> +
> +/// A request for an IRQ line for a given device.
> +///
> +/// # Invariants
> +///
> +/// - `=C3=ACrq` is the number of an interrupt source of `dev`.
> +/// - `irq` has not been registered yet.
> +pub struct IrqRequest<'a> {
> +    dev: &'a Device<Bound>,
> +    irq: u32,
> +}
> +
> +impl<'a> IrqRequest<'a> {
> +    /// Creates a new IRQ request for the given device and IRQ number.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `irq` should be a valid IRQ number for `dev`.
> +    pub(crate) unsafe fn new(dev: &'a Device<Bound>, irq: u32) -> Self {
> +        IrqRequest { dev, irq }
> +    }
> +
> +    /// Returns the IRQ number of an [`IrqRequest`].
> +    pub fn irq(&self) -> u32 {
> +        self.irq
> +    }
> +}
> +
> +/// A registration of an IRQ handler for a given IRQ line.
> +///
> +/// # Examples
> +///
> +/// The following is an example of using `Registration`. It uses a
> +/// [`AtomicU32`](core::sync::AtomicU32) to provide the interior mutabil=
ity.
> +///
> +/// ```
> +/// use core::sync::atomic::AtomicU32;
> +/// use core::sync::atomic::Ordering;
> +///
> +/// use kernel::prelude::*;
> +/// use kernel::device::Bound;
> +/// use kernel::irq::flags;
> +/// use kernel::irq::Registration;
> +/// use kernel::irq::IrqRequest;
> +/// use kernel::irq::IrqReturn;

/// use kernel::irq::{Flags, IrqRequest, IrqReturn, Registration};

> +/// use kernel::sync::Arc;
> +/// use kernel::c_str;
> +/// use kernel::alloc::flags::GFP_KERNEL;

GFP_KERNEL is in the prelude.

> +/// // Declare a struct that will be passed in when the interrupt fires.=
 The u32
> +/// // merely serves as an example of some internal data.
> +/// struct Data(AtomicU32);
> +///
> +/// // [`kernel::irq::request::Handler::handle`] takes `&self`. This exa=
mple
> +/// // illustrates how interior mutability can be used when sharing the =
data
> +/// // between process context and IRQ context.
> +///
> +/// type Handler =3D Data;
> +///
> +/// impl kernel::irq::request::Handler for Handler {
> +///     // This is executing in IRQ context in some CPU. Other CPUs can =
still
> +///     // try to access to data.
> +///     fn handle(&self) -> IrqReturn {
> +///         self.0.fetch_add(1, Ordering::Relaxed);
> +///
> +///         IrqReturn::Handled
> +///     }
> +/// }
> +///
> +/// // Registers an IRQ handler for the given IrqRequest.
> +/// //
> +/// // This is executing in process context and assumes that `request` w=
as
> +/// // previously acquired from a device.
> +/// fn register_irq(handler: Handler, request: IrqRequest<'_>) -> Result=
<Arc<Registration<Handler>>> {
> +///     let registration =3D Registration::new(request, flags::SHARED, c=
_str!("my_device"), handler);
> +///
> +///     let registration =3D Arc::pin_init(registration, GFP_KERNEL)?;
> +///
> +///     // The data can be accessed from process context too.
> +///     registration.handler().0.fetch_add(1, Ordering::Relaxed);
> +///
> +///     Ok(registration)
> +/// }
> +/// # Ok::<(), Error>(())
> +/// ```
> +///
> +/// # Invariants
> +///
> +/// * We own an irq handler using `&self.handler` as its private data.
> +///
> +#[pin_data]
> +pub struct Registration<T: Handler + 'static> {
> +    #[pin]
> +    inner: Devres<RegistrationInner>,
> +
> +    #[pin]
> +    handler: T,
> +
> +    /// Pinned because we need address stability so that we can pass a p=
ointer
> +    /// to the callback.
> +    #[pin]
> +    _pin: PhantomPinned,
> +}
> +
> +impl<T: Handler + 'static> Registration<T> {
> +    /// Registers the IRQ handler with the system for the given IRQ numb=
er.
> +    pub fn new<'a>(
> +        request: IrqRequest<'a>,
> +        flags: Flags,
> +        name: &'static CStr,
> +        handler: T,
> +    ) -> impl PinInit<Self, Error> + 'a {
> +        try_pin_init!(&this in Self {
> +            handler,
> +            inner <- Devres::new(
> +                request.dev,
> +                try_pin_init!(RegistrationInner {
> +                    // SAFETY: `this` is a valid pointer to the `Registr=
ation` instance
> +                    cookie: unsafe { &raw mut (*this.as_ptr()).handler }=
.cast(),
> +                    irq: {
> +                        // SAFETY:
> +                        // - The callbacks are valid for use with reques=
t_irq.
> +                        // - If this succeeds, the slot is guaranteed to=
 be valid until the
> +                        //   destructor of Self runs, which will deregis=
ter the callbacks
> +                        //   before the memory location becomes invalid.
> +                        to_result(unsafe {
> +                            bindings::request_irq(
> +                                request.irq,
> +                                Some(handle_irq_callback::<T>),
> +                                flags.into_inner(),
> +                                name.as_char_ptr(),
> +                                (&raw mut (*this.as_ptr()).handler).cast=
(),
> +                            )
> +                        })?;
> +                        request.irq
> +                    }
> +                })
> +            ),
> +            _pin: PhantomPinned,
> +        })
> +    }
> +
> +    /// Returns a reference to the handler that was registered with the =
system.
> +    pub fn handler(&self) -> &T {
> +        &self.handler
> +    }
> +
> +    /// Wait for pending IRQ handlers on other CPUs.
> +    ///
> +    /// This will attempt to access the inner [`Devres`] container.
> +    pub fn try_synchronize(&self) -> Result {
> +        let inner =3D self.inner.try_access().ok_or(ENODEV)?;
> +        inner.synchronize();
> +        Ok(())
> +    }
> +
> +    /// Wait for pending IRQ handlers on other CPUs.
> +    pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
> +        let inner =3D self.inner.access(dev)?;
> +        inner.synchronize();
> +        Ok(())
> +    }
> +}
> +
> +/// # Safety
> +///
> +/// This function should be only used as the callback in `request_irq`.
> +unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *mu=
t c_void) -> c_uint {
> +    // SAFETY: `ptr` is a pointer to T set in `Registration::new`
> +    let handler =3D unsafe { &*(ptr as *const T) };
> +    T::handle(handler) as c_uint
> +}
>=20
> --=20
> 2.50.0
>=20

