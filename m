Return-Path: <linux-pci+bounces-34787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BF7B37312
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 21:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF5046340D
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 19:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB06E23ABAB;
	Tue, 26 Aug 2025 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="BGw+fxlX"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EEA31A554;
	Tue, 26 Aug 2025 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236765; cv=pass; b=Mk+qkWlljoLYr5RadX0EiCTwhbysV3Ss7KDh9bKZOrKDl+CtqZvPrSGWm58G/IwWfCVUQuTQkBA88BhzoSJBZ0/YriJrzr++DkCWrk2uGvDjT9YavSjzFcVFz9mYLFpkPZ7rnGHEvzP+vP3lqImNe7ln8/ZFfLwADVSD7OrNlRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236765; c=relaxed/simple;
	bh=rgXk/32Xe+Vb7o5wsVOTizFKMmrltvf8Umvlt8UizWc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jrtNnEFhccynI8w7xrFndCu3xgNCK/UaJCPjv/0GkhA54GF274A6yFGtSkCw2l7KeMcy9XDjT4VbEgz/2nUT8g0SyjaNvDs3urh1lL6nmI0dO0iFB/2dWUrcjCvmk2hcwm4u4B5dEhdubjzYrSM0mLHA4g2hoEV2225YpwtD+A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=BGw+fxlX; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756236736; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bnbJGSaS0keVsAxSe5/d4DQtPvSHDqtsq0lYWwFcQL5P5AcjI9nz5IVApSDtHH87HN96NFfl3ircyoaMaFmGGkpx75a1TNsexNFtIS9aHtwvor56a40eg7F812kwC97/xuyddrF2I1W/LaaygvmKa0nKgYM7CJMZ1nT0F8RbUBs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756236736; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9xWGIw/zoeslyo9k5ADzrN9q1rmbAyUgqP4dfdLM7Z4=; 
	b=a87ObzX4Id2WJXuIOmTfMnXmczscOmPvPhN+Xt0Vdm/k0OVTQzWOtSwWpdaTcN0/ZRKcTcEIWDQ4YiR75FhL8BxfMwP0DVOKeNCa/SF3WQP00gDOOZBOvFnaLEGMj0cmvVGcTyqDHs5hMI7+AU8JCC7Ja6QGwax/4108upgR8VI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756236736;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=9xWGIw/zoeslyo9k5ADzrN9q1rmbAyUgqP4dfdLM7Z4=;
	b=BGw+fxlXxKc8wvRUpB4PAnVwvoXr8Pb32FGpdoC2eI5EYM+i5lHUh7AYGwDzNzCe
	Kj1+C6njQzMZYGWOCV7pU2efimYPIEgo/6zW0BAP+gxHtuvyml/rKDQkJ2nICWPyox/
	zfLSC28hRGttaBX63todFkexCGzIjr8Q3vDSJTVo=
Received: by mx.zohomail.com with SMTPS id 1756236733463308.1265295471261;
	Tue, 26 Aug 2025 12:32:13 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v9 3/7] rust: irq: add support for non-threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <87wm71cahd.fsf@t14s.mail-host-address-is-not-set>
Date: Tue, 26 Aug 2025 16:31:55 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Dirk Behme <dirk.behme@de.bosch.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A068CEC-E45F-44B1-9D16-D550835503F9@collabora.com>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
 <ZBiGWoEXSxAUvEwNj8vzyDa5L6KvqTuKBTKz3mzyhMGBAja6PJsMtIiSdAUKDmn_FumrmDYuOk4PKlXRW055Qw==@protonmail.internalid>
 <20250811-topics-tyr-request_irq2-v9-3-0485dcd9bcbf@collabora.com>
 <87wm71cahd.fsf@t14s.mail-host-address-is-not-set>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Andreas,

> On 18 Aug 2025, at 05:14, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> "Daniel Almeida" <daniel.almeida@collabora.com> writes:
>=20
>> This patch adds support for non-threaded IRQs and handlers through
>> irq::Registration and the irq::Handler trait.
>>=20
>> Registering an irq is dependent upon having a IrqRequest that was
>> previously allocated by a given device. This will be introduced in
>> subsequent patches.
>>=20
>> Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
>> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>> ---
>> rust/bindings/bindings_helper.h |   1 +
>> rust/helpers/helpers.c          |   1 +
>> rust/helpers/irq.c              |   9 ++
>> rust/kernel/irq.rs              |   5 +
>> rust/kernel/irq/request.rs      | 264 =
++++++++++++++++++++++++++++++++++++++++
>> 5 files changed, 280 insertions(+)
>>=20
>> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
>> index =
84d60635e8a9baef1f1a1b2752dc0fa044f8542f..69a975da829f0c35760f71a1b32b8fcb=
12c8a8dc 100644
>> --- a/rust/bindings/bindings_helper.h
>> +++ b/rust/bindings/bindings_helper.h
>> @@ -52,6 +52,7 @@
>> #include <linux/ethtool.h>
>> #include <linux/file.h>
>> #include <linux/firmware.h>
>> +#include <linux/interrupt.h>
>> #include <linux/fs.h>
>> #include <linux/ioport.h>
>> #include <linux/jiffies.h>
>> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
>> index =
7cf7fe95e41dd51717050648d6160bebebdf4b26..44b2005d50140d34a44ae37d01c2ddba=
e6aeaa32 100644
>> --- a/rust/helpers/helpers.c
>> +++ b/rust/helpers/helpers.c
>> @@ -22,6 +22,7 @@
>> #include "dma.c"
>> #include "drm.c"
>> #include "err.c"
>> +#include "irq.c"
>> #include "fs.c"
>> #include "io.c"
>> #include "jump_label.c"
>> diff --git a/rust/helpers/irq.c b/rust/helpers/irq.c
>> new file mode 100644
>> index =
0000000000000000000000000000000000000000..1faca428e2c047a656dec3171855c150=
8d67e60b
>> --- /dev/null
>> +++ b/rust/helpers/irq.c
>> @@ -0,0 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/interrupt.h>
>> +
>> +int rust_helper_request_irq(unsigned int irq, irq_handler_t handler,
>> +     unsigned long flags, const char *name, void *dev)
>> +{
>> + return request_irq(irq, handler, flags, name, dev);
>> +}
>> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
>> index =
068df2fea31de51115c30344f7ebdb4da4ad86cc..c1019bc36ad1e7ae7dd3af8a8b5c1478=
0bf70712 100644
>> --- a/rust/kernel/irq.rs
>> +++ b/rust/kernel/irq.rs
>> @@ -13,4 +13,9 @@
>> /// Flags to be used when registering IRQ handlers.
>> mod flags;
>>=20
>> +/// IRQ allocation and handling.
>> +mod request;
>> +
>> pub use flags::Flags;
>> +
>> +pub use request::{Handler, IrqRequest, IrqReturn, Registration};
>> diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
>> new file mode 100644
>> index =
0000000000000000000000000000000000000000..57e00ebf694d8e6e870d9ed57af7ee2e=
cf86ec05
>> --- /dev/null
>> +++ b/rust/kernel/irq/request.rs
>> @@ -0,0 +1,264 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// SPDX-FileCopyrightText: Copyright 2025 Collabora ltd.
>> +
>> +//! This module provides types like [`Registration`] which allow =
users to
>> +//! register handlers for a given IRQ line.
>> +
>> +use core::marker::PhantomPinned;
>> +
>> +use crate::alloc::Allocator;
>> +use crate::device::{Bound, Device};
>=20
> nit: I would suggest either normalizing all the imports, or using one
> import per line consistently.
>=20
>> +use crate::devres::Devres;
>> +use crate::error::to_result;
>> +use crate::irq::flags::Flags;
>> +use crate::prelude::*;
>> +use crate::str::CStr;
>> +use crate::sync::Arc;
>> +
>> +/// The value that can be returned from a [`Handler`] or a =
[`ThreadedHandler`].
>=20
> error: unresolved link to `ThreadedHandler`
>  --> =
/home/aeh/src/linux-rust/request-irq/rust/kernel/irq/request.rs:18:62
>   |
> 18 | /// The value that can be returned from a [`Handler`] or a =
[`ThreadedHandler`].
>   |                                                              =
^^^^^^^^^^^^^^^ no item named `ThreadedHandler` in scope
>   |

This was introduced by the next commit. I wonder what is the right thing =
to do
here now?

>=20
>> +#[repr(u32)]
>> +pub enum IrqReturn {
>> +    /// The interrupt was not from this device or was not handled.
>> +    None =3D bindings::irqreturn_IRQ_NONE,
>> +
>> +    /// The interrupt was handled by this device.
>> +    Handled =3D bindings::irqreturn_IRQ_HANDLED,
>> +}
>> +
>> +/// Callbacks for an IRQ handler.
>> +pub trait Handler: Sync {
>> +    /// The hard IRQ handler.
>=20
> Could you do a vocabulary somewhere? What does it mean that the =
handler
> is hard?


This nomenclature is borrowed from the C part of the kernel. The hard =
part is
what runs immediately in interrupt context while the bottom half runs =
later. In
this case, the bottom half is a threaded handler, i.e.: code running in =
a
separate kthread.

I think this is immediately understandable most of the time because it's =
a term
that is often used in the kernel. Do you still feel that I should expand =
the
docs in this case?

>=20
>> +    ///
>> +    /// This is executed in interrupt context, hence all =
corresponding
>> +    /// limitations do apply.
>> +    ///
>> +    /// All work that does not necessarily need to be executed from
>> +    /// interrupt context, should be deferred to a threaded handler.
>> +    /// See also [`ThreadedRegistration`].
>=20
> error: unresolved link to `ThreadedRegistration`
>  --> =
/home/aeh/src/linux-rust/request-irq/rust/kernel/irq/request.rs:37:20
>   |
> 37 |     /// See also [`ThreadedRegistration`].
>   |                    ^^^^^^^^^^^^^^^^^^^^ no item named =
`ThreadedRegistration` in scope
>   |
>=20

Same as the previous doc issue you highlighted.

>> +    fn handle(&self) -> IrqReturn;
>> +}
>> +
>> +impl<T: ?Sized + Handler + Send> Handler for Arc<T> {
>> +    fn handle(&self) -> IrqReturn {
>> +        T::handle(self)
>> +    }
>> +}
>> +
>> +impl<T: ?Sized + Handler, A: Allocator> Handler for Box<T, A> {
>> +    fn handle(&self) -> IrqReturn {
>> +        T::handle(self)
>> +    }
>> +}
>> +
>> +/// # Invariants
>> +///
>> +/// - `self.irq` is the same as the one passed to =
`request_{threaded}_irq`.
>> +/// - `cookie` was passed to `request_{threaded}_irq` as the cookie. =
It is guaranteed to be unique
>> +///   by the type system, since each call to `new` will return a =
different instance of
>> +///   `Registration`.
>=20
> This seems like a mix of invariant declaration and conformance. I =
don't
> think the following belongs here:
>=20
>  It is guaranteed to be unique
>  by the type system, since each call to `new` will return a different =
instance of
>  `Registration`.
>=20
> You could replace it with a uniqueness requirement.

WDYM? This invariant is indeed provided by the type system and we do =
rely on it
to make the abstraction work.

>=20
>> +#[pin_data(PinnedDrop)]
>> +struct RegistrationInner {
>> +    irq: u32,
>> +    cookie: *mut c_void,
>> +}
>> +
>> +impl RegistrationInner {
>> +    fn synchronize(&self) {
>> +        // SAFETY: safe as per the invariants of `RegistrationInner`
>> +        unsafe { bindings::synchronize_irq(self.irq) };
>> +    }
>> +}
>> +
>> +#[pinned_drop]
>> +impl PinnedDrop for RegistrationInner {
>> +    fn drop(self: Pin<&mut Self>) {
>> +        // SAFETY:
>> +        //
>> +        // Safe as per the invariants of `RegistrationInner` and:
>> +        //
>> +        // - The containing struct is `!Unpin` and was initialized =
using
>> +        // pin-init, so it occupied the same memory location for the =
entirety of
>> +        // its lifetime.
>> +        //
>> +        // Notice that this will block until all handlers finish =
executing,
>> +        // i.e.: at no point will &self be invalid while the handler =
is running.
>> +        unsafe { bindings::free_irq(self.irq, self.cookie) };
>> +    }
>> +}
>> +
>> +// SAFETY: We only use `inner` on drop, which called at most once =
with no
>> +// concurrent access.
>> +unsafe impl Sync for RegistrationInner {}
>> +
>> +// SAFETY: It is safe to send `RegistrationInner` across threads.
>=20
> Why?

It's a u32 and an opaque pointer. The pointer itself (which is what =
demands a
manual send/sync impl) is only used on drop() and there are no =
restrictions
that prevent freeing an irq from another thread.

The cookie points to the handler, i.e.:

+                    cookie: unsafe { &raw mut (*this.as_ptr()).handler =
}cast(),

Perhaps we can add a bound on Send for Handler if that helps?

>=20
>> +unsafe impl Send for RegistrationInner {}
>> +
>> +/// A request for an IRQ line for a given device.
>> +///
>> +/// # Invariants
>> +///
>> +/// - `=C3=ACrq` is the number of an interrupt source of `dev`.
>> +/// - `irq` has not been registered yet.
>> +pub struct IrqRequest<'a> {
>> +    dev: &'a Device<Bound>,
>> +    irq: u32,
>> +}
>> +
>> +impl<'a> IrqRequest<'a> {
>> +    /// Creates a new IRQ request for the given device and IRQ =
number.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// - `irq` should be a valid IRQ number for `dev`.
>> +    pub(crate) unsafe fn new(dev: &'a Device<Bound>, irq: u32) -> =
Self {
>=20
> This needs `#[expect(dead_code)]`.

Danilo did that already before applying.

>=20
>> +        // INVARIANT: `irq` is a valid IRQ number for `dev`.
>=20
> I would suggest rephrasing:
>=20
>  By function safety requirement, irq` is a valid IRQ number for `dev`.

Ack, I can send a patch.

>=20
>> +        IrqRequest { dev, irq }
>> +    }
>> +
>> +    /// Returns the IRQ number of an [`IrqRequest`].
>> +    pub fn irq(&self) -> u32 {
>> +        self.irq
>> +    }
>> +}
>> +
>> +/// A registration of an IRQ handler for a given IRQ line.
>> +///
>> +/// # Examples
>> +///
>> +/// The following is an example of using `Registration`. It uses a
>> +/// [`Completion`] to coordinate between the IRQ
>> +/// handler and process context. [`Completion`] uses interior =
mutability, so the
>> +/// handler can signal with [`Completion::complete_all()`] and the =
process
>> +/// context can wait with [`Completion::wait_for_completion()`] even =
though
>> +/// there is no way to get a mutable reference to the any of the =
fields in
>> +/// `Data`.
>> +///
>> +/// [`Completion`]: kernel::sync::Completion
>> +/// [`Completion::complete_all()`]: =
kernel::sync::Completion::complete_all
>> +/// [`Completion::wait_for_completion()`]: =
kernel::sync::Completion::wait_for_completion
>> +///
>> +/// ```
>> +/// use kernel::c_str;
>> +/// use kernel::device::Bound;
>> +/// use kernel::irq::{self, Flags, IrqRequest, IrqReturn, =
Registration};
>> +/// use kernel::prelude::*;
>> +/// use kernel::sync::{Arc, Completion};
>> +///
>> +/// // Data shared between process and IRQ context.
>> +/// #[pin_data]
>> +/// struct Data {
>> +///     #[pin]
>> +///     completion: Completion,
>> +/// }
>> +///
>> +/// impl irq::Handler for Data {
>> +///     // Executed in IRQ context.
>> +///     fn handle(&self) -> IrqReturn {
>> +///         self.completion.complete_all();
>> +///         IrqReturn::Handled
>> +///     }
>> +/// }
>> +///
>> +/// // Registers an IRQ handler for the given IrqRequest.
>> +/// //
>> +/// // This runs in process context and assumes `request` was =
previously acquired from a device.
>> +/// fn register_irq(
>> +///     handler: impl PinInit<Data, Error>,
>> +///     request: IrqRequest<'_>,
>> +/// ) -> Result<Arc<Registration<Data>>> {
>> +///     let registration =3D Registration::new(request, =
Flags::SHARED, c_str!("my_device"), handler);
>> +///
>> +///     let registration =3D Arc::pin_init(registration, =
GFP_KERNEL)?;
>> +///
>> +///     registration.handler().completion.wait_for_completion();
>> +///
>> +///     Ok(registration)
>> +/// }
>> +/// # Ok::<(), Error>(())
>> +/// ```
>> +///
>> +/// # Invariants
>> +///
>> +/// * We own an irq handler using `&self.handler` as its private =
data.
>> +#[pin_data]
>> +pub struct Registration<T: Handler + 'static> {
>> +    #[pin]
>> +    inner: Devres<RegistrationInner>,
>=20
> Soundness of this API requires `inner` to be dropped before `handler`.
> Maybe we should have a comment specifying that the order of these =
fields
> is important?

Ack.

>=20
>> +
>> +    #[pin]
>> +    handler: T,
>> +
>> +    /// Pinned because we need address stability so that we can pass =
a pointer
>> +    /// to the callback.
>> +    #[pin]
>> +    _pin: PhantomPinned,
>> +}
>> +
>> +impl<T: Handler + 'static> Registration<T> {
>> +    /// Registers the IRQ handler with the system for the given IRQ =
number.
>=20
> Could this be "... for the IRQ number represented by `request`."? =
Because we
> don't pass in an actual number here.

Ack.

>=20
>> +    pub fn new<'a>(
>> +        request: IrqRequest<'a>,
>> +        flags: Flags,
>> +        name: &'static CStr,
>> +        handler: impl PinInit<T, Error> + 'a,
>> +    ) -> impl PinInit<Self, Error> + 'a {
>> +        try_pin_init!(&this in Self {
>> +            handler <- handler,
>> +            inner <- Devres::new(
>> +                request.dev,
>> +                try_pin_init!(RegistrationInner {
>> +                    // SAFETY: `this` is a valid pointer to the =
`Registration` instance
>> +                    cookie: unsafe { &raw mut =
(*this.as_ptr()).handler }cast(),
>> +                    irq: {
>> +                        // SAFETY:
>> +                        // - The callbacks are valid for use with =
request_irq.
>> +                        // - If this succeeds, the slot is =
guaranteed to be valid until the
>> +                        //   destructor of Self runs, which will =
deregister the callbacks
>> +                        //   before the memory location becomes =
invalid.
>> +                        to_result(unsafe {
>> +                            bindings::request_irq(
>> +                                request.irq,
>> +                                Some(handle_irq_callback::<T>),
>> +                                flags.into_inner(),
>> +                                name.as_char_ptr(),
>> +                                (&raw mut =
(*this.as_ptr()).handler).cast(),
>> +                            )
>> +                        })?;
>> +                        request.irq
>> +                    }
>> +                })
>> +            ),
>> +            _pin: PhantomPinned,
>> +        })
>> +    }
>> +
>> +    /// Returns a reference to the handler that was registered with =
the system.
>> +    pub fn handler(&self) -> &T {
>> +        &self.handler
>> +    }
>> +
>> +    /// Wait for pending IRQ handlers on other CPUs.
>> +    ///
>> +    /// This will attempt to access the inner [`Devres`] container.
>> +    pub fn try_synchronize(&self) -> Result {
>> +        let inner =3D self.inner.try_access().ok_or(ENODEV)?;
>> +        inner.synchronize();
>> +        Ok(())
>> +    }
>> +
>> +    /// Wait for pending IRQ handlers on other CPUs.
>> +    pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
>> +        let inner =3D self.inner.access(dev)?;
>> +        inner.synchronize();
>> +        Ok(())
>> +    }
>> +}
>> +
>> +/// # Safety
>> +///
>> +/// This function should be only used as the callback in =
`request_irq`.
>=20
> I think this safety requirement is inadequate. We must require `ptr` =
to
> be valid for use as a reference to `T`. When we install the pointer to
> this function, we should certify why safety requirements are fulfilled
> when C calls through the pointer.

Ack.

>=20
>> +unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: =
*mut c_void) -> c_uint {
>> +    // SAFETY: `ptr` is a pointer to T set in `Registration::new`
>> +    let handler =3D unsafe { &*(ptr as *const T) };
>> +    T::handle(handler) as c_uint
>> +}
>=20
>=20
> Best regards,
> Andreas Hindborg



