Return-Path: <linux-pci+bounces-29219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA44AAD1DD3
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 14:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBFBA16CA24
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 12:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0912580CA;
	Mon,  9 Jun 2025 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEZuzpCB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3390257AF2;
	Mon,  9 Jun 2025 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749472066; cv=none; b=tOoPdpBrZI+/+Bwr2z+o+3DpKd884cuhfIwC/Fk5fT41402lVfBvpGpVWwCHc0nlDhAwLqmebmVwCkd6bJuDIa0amQxuugW/KbRI3fcTK6s/MrcOMC9xSxYwaWcSDOECkRyTa52NmunccgwKHhE0pjw8CRUxqG+223jBxINq0iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749472066; c=relaxed/simple;
	bh=TF0Lt8AnKHFIOMaW6x2e/lAW4/Cndmz2TrxEid2Il2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qn0ffQzUKHpGeAfYkmcK5SbuuqpUCD2Itkus2kjV1E+rNRh51DJ+F1Ev5H+L40YP4uub4E5NX/pUiErkqIIWZa2/W3k0x5W0/2dIwDGZA0WlugCc2vU9JfQrCML9uY1x+FLJxdJPnKvN3o4PC0a+GqIyw1c4GBPIeyHHuBk/sT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEZuzpCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F41C4CEEB;
	Mon,  9 Jun 2025 12:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749472065;
	bh=TF0Lt8AnKHFIOMaW6x2e/lAW4/Cndmz2TrxEid2Il2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEZuzpCBafD0g9kI5LVLV4dVO6iVQUURLLUZwqRWGNmODmzdRM8Cjf9mywTsT8edf
	 bz7Yl9rKwR2Cm4wr7gUG+dTuqQmBmjBLDYlv4yUDFga//1BxFIkNIBefPFmqVn7dl5
	 FW1xRGuHOe6vfQg7dY6fIfAcpBo5cNbsdY99vOj87QhBCZDqHDd2yH6XdMdjWbbQyk
	 HErRmDRrPAZfmbykXON4zUOyY2EDBCokY8R1V8JITv5x94/gxeu0Ln8VItC5aWDCzz
	 gDFknVcavuXjp8TuqvE7T8+sxTlgJiumJ+4TOnuK73Ya/TEXCsUT7wJyXLRau9ruaX
	 K/Ci5wstAormg==
Date: Mon, 9 Jun 2025 14:27:38 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Benno Lossin <lossin@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 4/6] rust: irq: add support for threaded IRQs and
 handlers
Message-ID: <aEbTOhdfmYmhPiiS@pollux>
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
 <20250608-topics-tyr-request_irq-v4-4-81cb81fb8073@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250608-topics-tyr-request_irq-v4-4-81cb81fb8073@collabora.com>

On Sun, Jun 08, 2025 at 07:51:09PM -0300, Daniel Almeida wrote:
> +/// Callbacks for a threaded IRQ handler.
> +pub trait ThreadedHandler: Sync {
> +    /// The actual handler function. As usual, sleeps are not allowed in IRQ
> +    /// context.
> +    fn handle_irq(&self) -> ThreadedIrqReturn;
> +
> +    /// The threaded handler function. This function is called from the irq
> +    /// handler thread, which is automatically created by the system.
> +    fn thread_fn(&self) -> IrqReturn;
> +}
> +
> +impl<T: ?Sized + ThreadedHandler + Send> ThreadedHandler for Arc<T> {
> +    fn handle_irq(&self) -> ThreadedIrqReturn {
> +        T::handle_irq(self)
> +    }
> +
> +    fn thread_fn(&self) -> IrqReturn {
> +        T::thread_fn(self)
> +    }
> +}

In case you intend to be consistent with the function pointer names in
request_threaded_irq(), it'd need to be handler() and thread_fn(). But I don't
think there's a need for that, both aren't really nice for names of trait
methods.

What about irq::Handler::handle() and irq::Handler::handle_threaded() for
instance?

Alternatively, why not just

	trait Handler {
	   fn handle(&self);
	}
	
	trait ThreadedHandler {
	   fn handle(&self);
	}

and then we ask for `T: Handler + ThreadedHandler`.

> +
> +impl<T: ?Sized + ThreadedHandler, A: Allocator> ThreadedHandler for Box<T, A> {
> +    fn handle_irq(&self) -> ThreadedIrqReturn {
> +        T::handle_irq(self)
> +    }
> +
> +    fn thread_fn(&self) -> IrqReturn {
> +        T::thread_fn(self)
> +    }
> +}
> +
> +/// A registration of a threaded IRQ handler for a given IRQ line.
> +///
> +/// Two callbacks are required: one to handle the IRQ, and one to handle any
> +/// other work in a separate thread.
> +///
> +/// The thread handler is only called if the IRQ handler returns `WakeThread`.
> +///
> +/// # Examples
> +///
> +/// The following is an example of using `ThreadedRegistration`. It uses a
> +/// [`AtomicU32`](core::sync::AtomicU32) to provide the interior mutability.
> +///
> +/// ```
> +/// use core::sync::atomic::AtomicU32;
> +/// use core::sync::atomic::Ordering;
> +///
> +/// use kernel::prelude::*;
> +/// use kernel::device::Bound;
> +/// use kernel::irq::flags;
> +/// use kernel::irq::ThreadedIrqReturn;
> +/// use kernel::irq::ThreadedRegistration;
> +/// use kernel::irq::IrqReturn;
> +/// use kernel::platform;
> +/// use kernel::sync::Arc;
> +/// use kernel::sync::SpinLock;
> +/// use kernel::alloc::flags::GFP_KERNEL;
> +/// use kernel::c_str;
> +///
> +/// // Declare a struct that will be passed in when the interrupt fires. The u32
> +/// // merely serves as an example of some internal data.
> +/// struct Data(AtomicU32);
> +///
> +/// // [`handle_irq`] takes &self. This example illustrates interior
> +/// // mutability can be used when share the data between process context and IRQ
> +/// // context.
> +///
> +/// type Handler = Data;
> +///
> +/// impl kernel::irq::request::ThreadedHandler for Handler {
> +///     // This is executing in IRQ context in some CPU. Other CPUs can still
> +///     // try to access to data.
> +///     fn handle_irq(&self) -> ThreadedIrqReturn {
> +///         self.0.fetch_add(1, Ordering::Relaxed);
> +///
> +///         // By returning `WakeThread`, we indicate to the system that the
> +///         // thread function should be called. Otherwise, return
> +///         // ThreadedIrqReturn::Handled.
> +///         ThreadedIrqReturn::WakeThread
> +///     }
> +///
> +///     // This will run (in a separate kthread) if and only if `handle_irq`
> +///     // returns `WakeThread`.
> +///     fn thread_fn(&self) -> IrqReturn {
> +///         self.0.fetch_add(1, Ordering::Relaxed);
> +///
> +///         IrqReturn::Handled
> +///     }
> +/// }
> +///
> +/// // This is running in process context.
> +/// fn register_threaded_irq(handler: Handler, dev: &platform::Device<Bound>) -> Result<Arc<ThreadedRegistration<Handler>>> {
> +///     let registration = dev.threaded_irq_by_index(0, flags::SHARED, c_str!("my-device"), handler)?;

This doesn't compile (yet). I think this should be a "raw" example, i.e. the
function should take an IRQ number.

The example you sketch up here is for platform::Device::threaded_irq_by_index().

> +///
> +///     // You can have as many references to the registration as you want, so
> +///     // multiple parts of the driver can access it.
> +///     let registration = Arc::pin_init(registration, GFP_KERNEL)?;
> +///
> +///     // The handler may be called immediately after the function above
> +///     // returns, possibly in a different CPU.
> +///
> +///     {
> +///         // The data can be accessed from the process context too.
> +///         registration.handler().0.fetch_add(1, Ordering::Relaxed);
> +///     }

Why the extra scope?

> +///
> +///     Ok(registration)
> +/// }
> +///
> +///
> +/// # Ok::<(), Error>(())
> +///```
> +///
> +/// # Invariants
> +///
> +/// * We own an irq handler using `&self` as its private data.
> +///
> +#[pin_data]
> +pub struct ThreadedRegistration<T: ThreadedHandler + 'static> {
> +    inner: Devres<RegistrationInner>,
> +
> +    #[pin]
> +    handler: T,
> +
> +    /// Pinned because we need address stability so that we can pass a pointer
> +    /// to the callback.
> +    #[pin]
> +    _pin: PhantomPinned,
> +}

Most of the code in this file is a duplicate of the non-threaded registration.

I think this would greatly generalize with specialization and an HandlerInternal
trait.

Without specialization I think we could use enums to generalize.

The most trivial solution would be to define the Handler trait as

	trait Handler {
	   fn handle(&self);
	   fn handle_threaded(&self) {};
	}

but that's pretty dodgy.

> +impl<T: ThreadedHandler + 'static> ThreadedRegistration<T> {
> +    /// Registers the IRQ handler with the system for the given IRQ number.
> +    pub(crate) fn register<'a>(
> +        dev: &'a Device<Bound>,
> +        irq: u32,
> +        flags: Flags,
> +        name: &'static CStr,
> +        handler: T,
> +    ) -> impl PinInit<Self, Error> + 'a {

What happens if `dev`  does not match `irq`? The caller is responsible to only
provide an IRQ number that was obtained from this device.

This should be a safety requirement and a type invariant.

