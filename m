Return-Path: <linux-pci+bounces-34175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D68B4B29BD2
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 10:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56701898CF6
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 08:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31022D0C68;
	Mon, 18 Aug 2025 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DunsvCyQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867C29B8C7;
	Mon, 18 Aug 2025 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504889; cv=none; b=R97DEHWQCJfjoVEHzwvu/mr+7woIW5PTzU8DG6dUu8TCEjlO2dEfxD34VEPmcEyLS80WBlMa9lD1H8ZwZP+GlbApvjgA4TkN+ssytGZk52YEgAuEIBy2MGcDEDI7ktcGonjBEDbFkKAQbRtLJh4QUp8UIHq98KA9JUn1xxgKz4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504889; c=relaxed/simple;
	bh=x1OLtmeZ2zgXp/x7VR6XCjBFWDq1zhyBgLoXLEs5BJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eVODLEkw3fSTcNskOrXO5Q7TWe0yzfSRaWdrPEZ7q4Oi4cq26kznAO00pyVgHrxNG035IBpHUsPsxIBiJYe/BjBeE9/xOJr5//TWzkUL6yP2WBx5ltrIQOnomzl0Hc1PDr8yYS3iOkYIQvwaSfgvV0fxiAJJaVQ+m6b91pBggGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DunsvCyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CE7C4CEEB;
	Mon, 18 Aug 2025 08:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755504889;
	bh=x1OLtmeZ2zgXp/x7VR6XCjBFWDq1zhyBgLoXLEs5BJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DunsvCyQ7zwDTKLQGOAn9qOyrlGtgSBw+bjSH6g9OOWK5XRKmSwANT+ZgcZsdnsPT
	 p2/svZ2Yxj6yKGFNsWAstEYKnck6W9RnxhzEYC8NxR9G1FPV1OCqDEqqyPzr+1ZBqS
	 j1XAF2GcFWuPhQd5uCBEGUzuXhHWl0aYzTxsizbg7J2s5wNa/qZhdRnCeTDahWYmU3
	 LaXGi8MAPs4W4S/pXN2+IKWP19U33XiPA7TVPO7/XvKHNOqHOlAnTi2/mCl2yOxZ2X
	 BhHGwiP8qCYgd/JpPFoTPVkiNpnyksFwt1ow/rjV2Os8JrBAkrfe5bBG98QOo1UCQK
	 LXixrfWOGFf4g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron
 <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>, Dirk
 Behme <dirk.behme@de.bosch.com>, Daniel Almeida
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH v9 3/7] rust: irq: add support for non-threaded IRQs and
 handlers
In-Reply-To: <20250811-topics-tyr-request_irq2-v9-3-0485dcd9bcbf@collabora.com>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
 <ZBiGWoEXSxAUvEwNj8vzyDa5L6KvqTuKBTKz3mzyhMGBAja6PJsMtIiSdAUKDmn_FumrmDYuOk4PKlXRW055Qw==@protonmail.internalid>
 <20250811-topics-tyr-request_irq2-v9-3-0485dcd9bcbf@collabora.com>
Date: Mon, 18 Aug 2025 10:14:38 +0200
Message-ID: <87wm71cahd.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

> This patch adds support for non-threaded IRQs and handlers through
> irq::Registration and the irq::Handler trait.
>
> Registering an irq is dependent upon having a IrqRequest that was
> previously allocated by a given device. This will be introduced in
> subsequent patches.
>
> Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/irq.c              |   9 ++
>  rust/kernel/irq.rs              |   5 +
>  rust/kernel/irq/request.rs      | 264 ++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 280 insertions(+)
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 84d60635e8a9baef1f1a1b2752dc0fa044f8542f..69a975da829f0c35760f71a1b=
32b8fcb12c8a8dc 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -52,6 +52,7 @@
>  #include <linux/ethtool.h>
>  #include <linux/file.h>
>  #include <linux/firmware.h>
> +#include <linux/interrupt.h>
>  #include <linux/fs.h>
>  #include <linux/ioport.h>
>  #include <linux/jiffies.h>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 7cf7fe95e41dd51717050648d6160bebebdf4b26..44b2005d50140d34a44ae37d0=
1c2ddbae6aeaa32 100644
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
> index 068df2fea31de51115c30344f7ebdb4da4ad86cc..c1019bc36ad1e7ae7dd3af8a8=
b5c14780bf70712 100644
> --- a/rust/kernel/irq.rs
> +++ b/rust/kernel/irq.rs
> @@ -13,4 +13,9 @@
>  /// Flags to be used when registering IRQ handlers.
>  mod flags;
>
> +/// IRQ allocation and handling.
> +mod request;
> +
>  pub use flags::Flags;
> +
> +pub use request::{Handler, IrqRequest, IrqReturn, Registration};
> diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..57e00ebf694d8e6e870d9ed57=
af7ee2ecf86ec05
> --- /dev/null
> +++ b/rust/kernel/irq/request.rs
> @@ -0,0 +1,264 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: Copyright 2025 Collabora ltd.
> +
> +//! This module provides types like [`Registration`] which allow users to
> +//! register handlers for a given IRQ line.
> +
> +use core::marker::PhantomPinned;
> +
> +use crate::alloc::Allocator;
> +use crate::device::{Bound, Device};

nit: I would suggest either normalizing all the imports, or using one
import per line consistently.

> +use crate::devres::Devres;
> +use crate::error::to_result;
> +use crate::irq::flags::Flags;
> +use crate::prelude::*;
> +use crate::str::CStr;
> +use crate::sync::Arc;
> +
> +/// The value that can be returned from a [`Handler`] or a [`ThreadedHan=
dler`].

error: unresolved link to `ThreadedHandler`
  --> /home/aeh/src/linux-rust/request-irq/rust/kernel/irq/request.rs:18:62
   |
18 | /// The value that can be returned from a [`Handler`] or a [`ThreadedH=
andler`].
   |                                                              ^^^^^^^^^=
^^^^^^ no item named `ThreadedHandler` in scope
   |

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

Could you do a vocabulary somewhere? What does it mean that the handler
is hard?

> +    ///
> +    /// This is executed in interrupt context, hence all corresponding
> +    /// limitations do apply.
> +    ///
> +    /// All work that does not necessarily need to be executed from
> +    /// interrupt context, should be deferred to a threaded handler.
> +    /// See also [`ThreadedRegistration`].

error: unresolved link to `ThreadedRegistration`
  --> /home/aeh/src/linux-rust/request-irq/rust/kernel/irq/request.rs:37:20
   |
37 |     /// See also [`ThreadedRegistration`].
   |                    ^^^^^^^^^^^^^^^^^^^^ no item named `ThreadedRegistr=
ation` in scope
   |

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
> +/// - `cookie` was passed to `request_{threaded}_irq` as the cookie. It =
is guaranteed to be unique
> +///   by the type system, since each call to `new` will return a differe=
nt instance of
> +///   `Registration`.

This seems like a mix of invariant declaration and conformance. I don't
think the following belongs here:

  It is guaranteed to be unique
  by the type system, since each call to `new` will return a different inst=
ance of
  `Registration`.

You could replace it with a uniqueness requirement.

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
> +// SAFETY: We only use `inner` on drop, which called at most once with no
> +// concurrent access.
> +unsafe impl Sync for RegistrationInner {}
> +
> +// SAFETY: It is safe to send `RegistrationInner` across threads.

Why?

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

This needs `#[expect(dead_code)]`.

> +        // INVARIANT: `irq` is a valid IRQ number for `dev`.

I would suggest rephrasing:

  By function safety requirement, irq` is a valid IRQ number for `dev`.

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
> +/// [`Completion`] to coordinate between the IRQ
> +/// handler and process context. [`Completion`] uses interior mutability=
, so the
> +/// handler can signal with [`Completion::complete_all()`] and the proce=
ss
> +/// context can wait with [`Completion::wait_for_completion()`] even tho=
ugh
> +/// there is no way to get a mutable reference to the any of the fields =
in
> +/// `Data`.
> +///
> +/// [`Completion`]: kernel::sync::Completion
> +/// [`Completion::complete_all()`]: kernel::sync::Completion::complete_a=
ll
> +/// [`Completion::wait_for_completion()`]: kernel::sync::Completion::wai=
t_for_completion
> +///
> +/// ```
> +/// use kernel::c_str;
> +/// use kernel::device::Bound;
> +/// use kernel::irq::{self, Flags, IrqRequest, IrqReturn, Registration};
> +/// use kernel::prelude::*;
> +/// use kernel::sync::{Arc, Completion};
> +///
> +/// // Data shared between process and IRQ context.
> +/// #[pin_data]
> +/// struct Data {
> +///     #[pin]
> +///     completion: Completion,
> +/// }
> +///
> +/// impl irq::Handler for Data {
> +///     // Executed in IRQ context.
> +///     fn handle(&self) -> IrqReturn {
> +///         self.completion.complete_all();
> +///         IrqReturn::Handled
> +///     }
> +/// }
> +///
> +/// // Registers an IRQ handler for the given IrqRequest.
> +/// //
> +/// // This runs in process context and assumes `request` was previously=
 acquired from a device.
> +/// fn register_irq(
> +///     handler: impl PinInit<Data, Error>,
> +///     request: IrqRequest<'_>,
> +/// ) -> Result<Arc<Registration<Data>>> {
> +///     let registration =3D Registration::new(request, Flags::SHARED, c=
_str!("my_device"), handler);
> +///
> +///     let registration =3D Arc::pin_init(registration, GFP_KERNEL)?;
> +///
> +///     registration.handler().completion.wait_for_completion();
> +///
> +///     Ok(registration)
> +/// }
> +/// # Ok::<(), Error>(())
> +/// ```
> +///
> +/// # Invariants
> +///
> +/// * We own an irq handler using `&self.handler` as its private data.
> +#[pin_data]
> +pub struct Registration<T: Handler + 'static> {
> +    #[pin]
> +    inner: Devres<RegistrationInner>,

Soundness of this API requires `inner` to be dropped before `handler`.
Maybe we should have a comment specifying that the order of these fields
is important?

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

Could this be "... for the IRQ number represented by `request`."? Because we
don't pass in an actual number here.

> +    pub fn new<'a>(
> +        request: IrqRequest<'a>,
> +        flags: Flags,
> +        name: &'static CStr,
> +        handler: impl PinInit<T, Error> + 'a,
> +    ) -> impl PinInit<Self, Error> + 'a {
> +        try_pin_init!(&this in Self {
> +            handler <- handler,
> +            inner <- Devres::new(
> +                request.dev,
> +                try_pin_init!(RegistrationInner {
> +                    // SAFETY: `this` is a valid pointer to the `Registr=
ation` instance
> +                    cookie: unsafe { &raw mut (*this.as_ptr()).handler }=
cast(),
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

I think this safety requirement is inadequate. We must require `ptr` to
be valid for use as a reference to `T`. When we install the pointer to
this function, we should certify why safety requirements are fulfilled
when C calls through the pointer.

> +unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *mu=
t c_void) -> c_uint {
> +    // SAFETY: `ptr` is a pointer to T set in `Registration::new`
> +    let handler =3D unsafe { &*(ptr as *const T) };
> +    T::handle(handler) as c_uint
> +}


Best regards,
Andreas Hindborg



