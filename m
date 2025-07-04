Return-Path: <linux-pci+bounces-31511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E45C7AF89FC
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 09:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578101C47F0D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 07:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AB02853E5;
	Fri,  4 Jul 2025 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQCMCuOl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAEF28505A
	for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 07:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615516; cv=none; b=tT+b/AoEyx9zUNVfjk6S72LgYvJ/cDAULFNCfphcqRRtKrQZXnr8aCWa47jYjNRs/2ddj2gFkqbTcVx5a6XdQKC3QV+qQKm0UYbOxBUwdA1ojrHPFcest9sVuPRKqOwdlERCMariLWdd8/MNhbMhdYznivJ0+73PQYWyO//NGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615516; c=relaxed/simple;
	bh=8+mt/NRCGieFtgq24xNxPLs2g7P52FR6xUWjy4SKTTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kVEZjk4rOZUsSxodNhWRaUdJKE0v3TqTtHfIfXfFnzal18x+QR7nmMEe+8SpVSDe8yRj3BlqCgW5r44UEmzpnZNKklWbi5Gf1NxqmnLbr47JITonAOFAQ+NKLkzGzj/ANp70pB7m0J/lIYnmDeC6fcT//ddtX8iIpu8Zy0S3fn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SQCMCuOl; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-453a190819bso4454875e9.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Jul 2025 00:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751615512; x=1752220312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKd8eptZkL7OKudvPnYzWX9vn9Ebsbo7yAT0QhSXSz8=;
        b=SQCMCuOlkfHpw970b1ipkaE7OMoTqKp2pq2MrInXE28nAKykOJK3Rz8ouJoOImjvd6
         w7gSJd68IRXkV3mJDKNDBwGz/PPJ5BOFNLTUX6K3prgHbd9Tv0Lw9Tp2PW0CaGtGap/f
         aoXEGIbwxfy10990NKQVjyU97sFg8FsvUS/S7WjkirVoToVwxWf3JmyPtwEHoQOniNP2
         ylcfWTBy+stDy23uOFJ691jlYSTZbER+UNEhfxDU04phDTKhoMIkupF1+fZcwEapmu+F
         Avq0RLLT3KnBKxj49oD0sCBezTo2CZPKJQ2cHSX7ZyzCDPwJewTT/jlcK22TXS6VBHy7
         0BRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751615512; x=1752220312;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RKd8eptZkL7OKudvPnYzWX9vn9Ebsbo7yAT0QhSXSz8=;
        b=fzkkX1q7p6g6F0ndB/iwggeT9P5SvS4CcwQash7c2exsB+WDLt3UHDfrhjiZ07348/
         OlfvZQ7vlWhhQagu0hnoXgg9fWpOSSeoGJpiDa5G1ShAtXJGfwb5RNScwRqRBmmXdhue
         wAVAGHO98eu3lf2s1Sv88wKZgVGgTcauRp11hVYg7ff4nHyhBg4/C+tP/1RW3A517cyW
         NCk8TSOXpVeO2J1tCvXP5Zk4TFZ9F9GS0qZZHWOTZowvtcsC8yqbo4RwmJqVkjvKlrYu
         FgFoEZiucfz1fHBrnbsryPhO5I1+0eMywImtks5Ck4mO/zQcayY7UTGkgl2fGgWOvNGG
         crtg==
X-Forwarded-Encrypted: i=1; AJvYcCWMtyizOkspcsfzR3Hm5XnBmQNAGjEPraNMfBfCnrdiT3eYqES+8+aO0a+SrX4pKOh4C4ubA3y4JME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2XxepUxzr83y1YxUqWAo9lOvy8ZwrqkWsCWm8OoFr+ROcv4o4
	3x7WIcg7/hJ7cKs8xq0X7HGkR5ixXI1B0OeooAMDcZlHPj3Ums8lfy7UG7fuctkHIAY2cm2n+ZT
	MXktkrKK6EZ2DLHM10Q==
X-Google-Smtp-Source: AGHT+IGXIQtapukJNLVd7QRtePhoB+p5QaPHUkrQNoQrbP3dt3oSHYBdXQZPDochTkCC+Wey+/9E7O2aR+gUfhI=
X-Received: from wmbek10.prod.google.com ([2002:a05:600c:3eca:b0:44a:b793:9e40])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b26:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-454b311551cmr13000885e9.32.1751615512505;
 Fri, 04 Jul 2025 00:51:52 -0700 (PDT)
Date: Fri, 4 Jul 2025 07:51:51 +0000
In-Reply-To: <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
Message-ID: <aGeIF_LcesUM9DHk@google.com>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and handlers
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Benno Lossin <lossin@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2025 at 04:30:01PM -0300, Daniel Almeida wrote:
> This patch adds support for non-threaded IRQs and handlers through
> irq::Registration and the irq::Handler trait.
>=20
> Registering an irq is dependent upon having a IrqRequest that was
> previously allocated by a given device. This will be introduced in
> subsequent patches.
>=20
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/irq.c              |   9 ++
>  rust/kernel/irq.rs              |   5 +
>  rust/kernel/irq/request.rs      | 273 ++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 289 insertions(+)
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 8cbb660e2ec218021d16e6e0144acf6f4d7cca13..da0bd23fad59a2373bd873d12=
ad69c55208aaa38 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -51,6 +51,7 @@
>  #include <linux/ethtool.h>
>  #include <linux/file.h>
>  #include <linux/firmware.h>
> +#include <linux/interrupt.h>
>  #include <linux/fs.h>
>  #include <linux/jiffies.h>
>  #include <linux/jump_label.h>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 393ad201befb80a9ae39866a725744ab88620fbb..e3579fc7e1cfc30c913207a4a=
78b790259d7ae7a 100644
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
> index 0000000000000000000000000000000000000000..4f4beaa3c7887660440b9ddc5=
2414020a0d165ac
> --- /dev/null
> +++ b/rust/kernel/irq/request.rs
> @@ -0,0 +1,273 @@
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
> +use crate::devres::Devres;
> +use crate::error::to_result;
> +use crate::irq::flags::Flags;
> +use crate::prelude::*;
> +use crate::str::CStr;
> +use crate::sync::Arc;
> +
> +/// The value that can be returned from an IrqHandler or a ThreadedIrqHa=
ndler.
> +pub enum IrqReturn {
> +    /// The interrupt was not from this device or was not handled.
> +    None,
> +
> +    /// The interrupt was handled by this device.
> +    Handled,
> +}
> +
> +impl IrqReturn {
> +    fn into_inner(self) -> u32 {
> +        match self {
> +            IrqReturn::None =3D> bindings::irqreturn_IRQ_NONE,
> +            IrqReturn::Handled =3D> bindings::irqreturn_IRQ_HANDLED,

One option is to specify these in the enum:

/// The value that can be returned from an IrqHandler or a ThreadedIrqHandl=
er.
pub enum IrqReturn {
    /// The interrupt was not from this device or was not handled.
    None =3D bindings::irqreturn_IRQ_NONE,

    /// The interrupt was handled by this device.
    Handled =3D bindings::irqreturn_IRQ_HANDLED,
}

impl IrqReturn {
    fn into_inner(self) -> c_uint {
        self as c_uint
    }
}

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
> +/// is guaranteed to be unique by the type system, since each call to
> +/// `new` will return a different instance of `Registration`.

I recall there being a clippy lint about the indentation here. Did it
not trigger?

/// - `cookie` was passed to `request_{threaded}_irq` as the cookie. It
///   is guaranteed to be unique by the type system, since each call to
///   `new` will return a different instance of `Registration`.

> +#[pin_data(PinnedDrop)]
> +struct RegistrationInner {
> +    irq: u32,
> +    cookie: *mut kernel::ffi::c_void,

The c_void type is in the prelude.

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
> +/// use kernel::sync::Arc;
> +/// use kernel::c_str;
> +/// use kernel::alloc::flags::GFP_KERNEL;
> +///
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
> +                        // destructor of Self runs, which will deregiste=
r the callbacks
> +                        // before the memory location becomes invalid.
> +                        to_result(unsafe {
> +                            bindings::request_irq(
> +                                request.irq,
> +                                Some(handle_irq_callback::<T>),
> +                                flags.into_inner() as usize,
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
> +unsafe extern "C" fn handle_irq_callback<T: Handler>(
> +    _irq: i32,
> +    ptr: *mut core::ffi::c_void,
> +) -> core::ffi::c_uint {

You should just use `c_uint` without the prefix. This way you get it
from `kernel::prelude::*` which has the correct typedefs rather than
`core::ffi`.

> +    // SAFETY: `ptr` is a pointer to T set in `Registration::new`
> +    let handler =3D unsafe { &*(ptr as *const T) };
> +    T::handle(handler).into_inner()
> +}
>=20
> --=20
> 2.50.0
>=20

