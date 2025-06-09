Return-Path: <linux-pci+bounces-29237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE387AD23C4
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 18:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0A11882C35
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 16:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA61020A5C4;
	Mon,  9 Jun 2025 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="LRhwpuJN"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5D821579F;
	Mon,  9 Jun 2025 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486318; cv=pass; b=h5uuehR/fjt5yqd7mJoLqCRz8M/bk4dFo6vcDHPObgVs//SFCot5r/Xw0LZaM1z+ZEVq1KWn3XoCjEnn4NCCKn7T1zQTPUWIKPC/PreDQ0rO6j0CbSbsq7aE50qndqgmYQf7zzqjbcVEUgr4fr2i/FH8TIyLSY1nC+uRybGPSnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486318; c=relaxed/simple;
	bh=BH/AFH2sSVWQsK1efnNK1sKRL1sE/k1CKi5k+6t1RaI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aIApu5v2wTjAINK9cYam2bG3FcRNxDyPCckPySZ/xqTbuhs7XQvJ58w7p0JeUsZ5YOutf+gj4UxOoohYYfsQTu7DUSXnXKfwpkn4gf2FuNWzTmpFAJFmbq87FjiJJIVguoAimmyn9v1Firmtb098Zd9lJI1+kcAIwZGq8xk2T0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=LRhwpuJN; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749486299; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OAmaJU/UqlK4qLOX2XrvesDQsN7dkouIy4sYze84pYBc9fv4cncUOkvVo/5As1x17esr59GIFElZ36TYmq4Xly0UQhTpkUBVGfXbmUGrWFa9M/Fh3Rhi6q13EUFmlVeF1NW1chYCBLakodOGpK7rGdRxWCgue9qccKLKgIOhzOc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749486299; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=P0MMfzUdGCfaFTyAjkNQ8nuesuK8uFLeUs3/8X2xeqs=; 
	b=ZXZ+OOw+t+eaKc038SXspzRSB6epVAhHcuXebg6Z0AzXCdSmbShUwPeXpJBe119h++mIsw1OyxwBgBa/Telwc093/DvqTzOfzV3TM43g3um3OnMid2O1XPySZvYkY8EyMoGVzl10qcmlTNl3MKeJopO9/UIehJ62kGcRtlMalU0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749486299;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=P0MMfzUdGCfaFTyAjkNQ8nuesuK8uFLeUs3/8X2xeqs=;
	b=LRhwpuJNLrdYKbH0QiDNIm2K31CAQ8dcOEMsqpBGyn1CQrnDnC4xagKeeZsN0Niz
	gDsBOsDRlrlgjB0BoE61LYidzgXnh0pza68AeeFb8t0Yc0wxXO7wt5j4iNC6Qgmg2u6
	PRLA4KvAkkeNCjwUMtaqEwlUCRYnkVTUHPJBPBbg=
Received: by mx.zohomail.com with SMTPS id 1749486296923500.60919773970306;
	Mon, 9 Jun 2025 09:24:56 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 4/6] rust: irq: add support for threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aEbTOhdfmYmhPiiS@pollux>
Date: Mon, 9 Jun 2025 13:24:40 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Benno Lossin <lossin@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5B3865E5-E343-4B5D-9BF7-7B9086AA9857@collabora.com>
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
 <20250608-topics-tyr-request_irq-v4-4-81cb81fb8073@collabora.com>
 <aEbTOhdfmYmhPiiS@pollux>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Danilo,

> On 9 Jun 2025, at 09:27, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Sun, Jun 08, 2025 at 07:51:09PM -0300, Daniel Almeida wrote:
>> +/// Callbacks for a threaded IRQ handler.
>> +pub trait ThreadedHandler: Sync {
>> +    /// The actual handler function. As usual, sleeps are not =
allowed in IRQ
>> +    /// context.
>> +    fn handle_irq(&self) -> ThreadedIrqReturn;
>> +
>> +    /// The threaded handler function. This function is called from =
the irq
>> +    /// handler thread, which is automatically created by the =
system.
>> +    fn thread_fn(&self) -> IrqReturn;
>> +}
>> +
>> +impl<T: ?Sized + ThreadedHandler + Send> ThreadedHandler for Arc<T> =
{
>> +    fn handle_irq(&self) -> ThreadedIrqReturn {
>> +        T::handle_irq(self)
>> +    }
>> +
>> +    fn thread_fn(&self) -> IrqReturn {
>> +        T::thread_fn(self)
>> +    }
>> +}
>=20
> In case you intend to be consistent with the function pointer names in
> request_threaded_irq(), it'd need to be handler() and thread_fn(). But =
I don't
> think there's a need for that, both aren't really nice for names of =
trait
> methods.
>=20
> What about irq::Handler::handle() and irq::Handler::handle_threaded() =
for
> instance?
>=20
> Alternatively, why not just
>=20
> trait Handler {
>   fn handle(&self);
> }
>=20
> trait ThreadedHandler {
>   fn handle(&self);
> }
>=20
> and then we ask for `T: Handler + ThreadedHandler`.

Sure, I am totally OK with renaming things, but IIRC I've tried  Handler =
+
ThreadedHandler in the past and found it to be problematic. I don't =
recall why,
though, so maybe it's worth another attempt.

>=20
>> +
>> +impl<T: ?Sized + ThreadedHandler, A: Allocator> ThreadedHandler for =
Box<T, A> {
>> +    fn handle_irq(&self) -> ThreadedIrqReturn {
>> +        T::handle_irq(self)
>> +    }
>> +
>> +    fn thread_fn(&self) -> IrqReturn {
>> +        T::thread_fn(self)
>> +    }
>> +}
>> +
>> +/// A registration of a threaded IRQ handler for a given IRQ line.
>> +///
>> +/// Two callbacks are required: one to handle the IRQ, and one to =
handle any
>> +/// other work in a separate thread.
>> +///
>> +/// The thread handler is only called if the IRQ handler returns =
`WakeThread`.
>> +///
>> +/// # Examples
>> +///
>> +/// The following is an example of using `ThreadedRegistration`. It =
uses a
>> +/// [`AtomicU32`](core::sync::AtomicU32) to provide the interior =
mutability.
>> +///
>> +/// ```
>> +/// use core::sync::atomic::AtomicU32;
>> +/// use core::sync::atomic::Ordering;
>> +///
>> +/// use kernel::prelude::*;
>> +/// use kernel::device::Bound;
>> +/// use kernel::irq::flags;
>> +/// use kernel::irq::ThreadedIrqReturn;
>> +/// use kernel::irq::ThreadedRegistration;
>> +/// use kernel::irq::IrqReturn;
>> +/// use kernel::platform;
>> +/// use kernel::sync::Arc;
>> +/// use kernel::sync::SpinLock;
>> +/// use kernel::alloc::flags::GFP_KERNEL;
>> +/// use kernel::c_str;
>> +///
>> +/// // Declare a struct that will be passed in when the interrupt =
fires. The u32
>> +/// // merely serves as an example of some internal data.
>> +/// struct Data(AtomicU32);
>> +///
>> +/// // [`handle_irq`] takes &self. This example illustrates interior
>> +/// // mutability can be used when share the data between process =
context and IRQ
>> +/// // context.
>> +///
>> +/// type Handler =3D Data;
>> +///
>> +/// impl kernel::irq::request::ThreadedHandler for Handler {
>> +///     // This is executing in IRQ context in some CPU. Other CPUs =
can still
>> +///     // try to access to data.
>> +///     fn handle_irq(&self) -> ThreadedIrqReturn {
>> +///         self.0.fetch_add(1, Ordering::Relaxed);
>> +///
>> +///         // By returning `WakeThread`, we indicate to the system =
that the
>> +///         // thread function should be called. Otherwise, return
>> +///         // ThreadedIrqReturn::Handled.
>> +///         ThreadedIrqReturn::WakeThread
>> +///     }
>> +///
>> +///     // This will run (in a separate kthread) if and only if =
`handle_irq`
>> +///     // returns `WakeThread`.
>> +///     fn thread_fn(&self) -> IrqReturn {
>> +///         self.0.fetch_add(1, Ordering::Relaxed);
>> +///
>> +///         IrqReturn::Handled
>> +///     }
>> +/// }
>> +///
>> +/// // This is running in process context.
>> +/// fn register_threaded_irq(handler: Handler, dev: =
&platform::Device<Bound>) -> Result<Arc<ThreadedRegistration<Handler>>> =
{
>> +///     let registration =3D dev.threaded_irq_by_index(0, =
flags::SHARED, c_str!("my-device"), handler)?;
>=20
> This doesn't compile (yet). I think this should be a "raw" example, =
i.e. the
> function should take an IRQ number.
>=20
> The example you sketch up here is for =
platform::Device::threaded_irq_by_index().

Yes, I originally had an example along the lines of what you mentioned. =
Except
that with the changes in register() from pub to pub(crate) they stopped
compiling.

I am not sure how the doctest to kunit machinery works, but I was =
expecting
tests to have access to everything within the module they're defined in, =
but
this is apparently not the case.

>=20
>> +///
>> +///     // You can have as many references to the registration as =
you want, so
>> +///     // multiple parts of the driver can access it.
>> +///     let registration =3D Arc::pin_init(registration, =
GFP_KERNEL)?;
>> +///
>> +///     // The handler may be called immediately after the function =
above
>> +///     // returns, possibly in a different CPU.
>> +///
>> +///     {
>> +///         // The data can be accessed from the process context =
too.
>> +///         registration.handler().0.fetch_add(1, =
Ordering::Relaxed);
>> +///     }
>=20
> Why the extra scope?

There used to be a lock here instead of AtomicU32. This extra scope was =
there to drop it.

It=E2=80=99s gone now so there=E2=80=99s no reason to have the extra =
scope indeed.

>=20
>> +///
>> +///     Ok(registration)
>> +/// }
>> +///
>> +///
>> +/// # Ok::<(), Error>(())
>> +///```
>> +///
>> +/// # Invariants
>> +///
>> +/// * We own an irq handler using `&self` as its private data.
>> +///
>> +#[pin_data]
>> +pub struct ThreadedRegistration<T: ThreadedHandler + 'static> {
>> +    inner: Devres<RegistrationInner>,
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
>=20
> Most of the code in this file is a duplicate of the non-threaded =
registration.
>=20
> I think this would greatly generalize with specialization and an =
HandlerInternal
> trait.
>=20
> Without specialization I think we could use enums to generalize.
>=20
> The most trivial solution would be to define the Handler trait as
>=20
> trait Handler {
>   fn handle(&self);
>   fn handle_threaded(&self) {};
> }
>=20
> but that's pretty dodgy.

A lot of the comments up until now have touched on somehow having =
threaded and
non-threaded versions implemented together. I personally see no problem =
in
having things duplicated here, because I think it's easier to reason =
about what
is going on this way. Alice has expressed a similar view in a previous =
iteration.

Can you expand a bit more on your suggestion? Perhaps there's a clean =
way to do
it (without macros and etc), but so far I don't see it.

>=20
>> +impl<T: ThreadedHandler + 'static> ThreadedRegistration<T> {
>> +    /// Registers the IRQ handler with the system for the given IRQ =
number.
>> +    pub(crate) fn register<'a>(
>> +        dev: &'a Device<Bound>,
>> +        irq: u32,
>> +        flags: Flags,
>> +        name: &'static CStr,
>> +        handler: T,
>> +    ) -> impl PinInit<Self, Error> + 'a {
>=20
> What happens if `dev`  does not match `irq`? The caller is responsible =
to only
> provide an IRQ number that was obtained from this device.
>=20
> This should be a safety requirement and a type invariant.

This iteration converted register() from pub to pub(crate). The idea was =
to
force drivers to use the accessors. I assumed this was enough to make =
the API
safe, as the few users in the kernel crate (i.e.: so far platform and =
pci)
could be manually checked for correctness.

To summarize my point, there is still the possibility of misusing this =
from the
kernel crate itself, but that is no longer possible from a driver's
perspective.

=E2=80=94 Daniel


