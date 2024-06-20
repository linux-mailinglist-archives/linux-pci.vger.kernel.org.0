Return-Path: <linux-pci+bounces-9023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0A3910893
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 16:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494B4284663
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 14:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672D91AD9EB;
	Thu, 20 Jun 2024 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iJnC5K7k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB061ACE8B;
	Thu, 20 Jun 2024 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894306; cv=none; b=Lo8Qn2sevZfH6ljHUIjdvLMlFVbyyMHuRYgeB0ahrcb5vBB0OfHiwhhID1ARILmHsieYdOoyMY0eIgoNKHgUm9BQgX+DjN30+n98lTrJP3ePQTHTlD329Tk6tXop1lWSeY3zi95JArjgyQL8cJvWhcGZPsCrLbSlgbD9wuiRUSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894306; c=relaxed/simple;
	bh=fX8g97LeC90KHKI/LLjp+hRyWlk9uj+GqpfJJOyBbcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4qIBuDQO/0jMEYXlJfJKLbAMio43j/zF3Vx75jROo/UVdB7gAKrm/tw76MqGTOhAaJ0Egtbzd/ZuVH15u9rpmy1KG7Gw08hHWIwDSDTAttu/fzoL9jYUFcN5uDvpdZu0Bs2g5kh/BIVgaRwm2XNxuNbtd11VKXs5sVxn0s6T7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iJnC5K7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D286C2BD10;
	Thu, 20 Jun 2024 14:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718894305;
	bh=fX8g97LeC90KHKI/LLjp+hRyWlk9uj+GqpfJJOyBbcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJnC5K7kvbDkPc5c9MC6MXXohWivvhN8t1DD6N3k7dGgULVDGuD7c+Tn52hslw04p
	 6J9Nn0EL0a6vgR3eDxsbC6IZ4EZkyolaDQCLpis//NNnkgxsAAGsRkKUjA/Cc7C+4N
	 +0sF77lm7kff2eJuZR5cX5sCOHldmQTFtfmOD/Vw=
Date: Thu, 20 Jun 2024 16:38:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 05/10] rust: add `Revocable` type
Message-ID: <2024062032-simple-lunchbox-bf1b@gregkh>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-6-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618234025.15036-6-dakr@redhat.com>

On Wed, Jun 19, 2024 at 01:39:51AM +0200, Danilo Krummrich wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Revocable allows access to objects to be safely revoked at run time.
> 
> This is useful, for example, for resources allocated during device probe;
> when the device is removed, the driver should stop accessing the device
> resources even if another state is kept in memory due to existing
> references (i.e., device context data is ref-counted and has a non-zero
> refcount after removal of the device).

We are getting into the "removed" vs. "unbound" terminology again here
:(

How about this change in the text:
	This is useful, for example, for resources allocated during
	a device probe call; and need to be not accessed after the
	device remove call.

I am guessing this is an attempt to tie into something much like the
devm api, right?  If so, why not call it that?  Why name it something
different?  Revocable seems not tied to a device, and you REALLY want
this to be tied to the lifetime model of a struct device ownership of a
driver.  You don't want it tied to anything else that might come in as
part of another path into that driver (i.e. through a device node
access), right?




> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  rust/kernel/lib.rs       |   1 +
>  rust/kernel/revocable.rs | 209 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 210 insertions(+)
>  create mode 100644 rust/kernel/revocable.rs
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 98e1a1425d17..601c3d3c9d54 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -43,6 +43,7 @@
>  pub mod net;
>  pub mod prelude;
>  pub mod print;
> +pub mod revocable;
>  mod static_assert;
>  #[doc(hidden)]
>  pub mod std_vendor;
> diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
> new file mode 100644
> index 000000000000..3d13e7b2f2e8
> --- /dev/null
> +++ b/rust/kernel/revocable.rs
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Revocable objects.
> +//!
> +//! The [`Revocable`] type wraps other types and allows access to them to be revoked. The existence
> +//! of a [`RevocableGuard`] ensures that objects remain valid.
> +
> +use crate::{
> +    bindings,
> +    init::{self},
> +    prelude::*,
> +    sync::rcu,

Ah, this is why you wanted rcu.  Note that the devm api today does NOT
use rcu, so why use it here?  What is that going to get you?  Why not
keep it simple for now and then, if you REALLY want to use rcu, you can
at a later time, after ensuring that it will be a benefit.


> +};
> +use core::{
> +    cell::UnsafeCell,
> +    marker::PhantomData,
> +    mem::MaybeUninit,
> +    ops::Deref,
> +    ptr::drop_in_place,
> +    sync::atomic::{AtomicBool, Ordering},
> +};
> +
> +/// An object that can become inaccessible at runtime.
> +///
> +/// Once access is revoked and all concurrent users complete (i.e., all existing instances of
> +/// [`RevocableGuard`] are dropped), the wrapped object is also dropped.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::revocable::Revocable;
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// fn add_two(v: &Revocable<Example>) -> Option<u32> {
> +///     let guard = v.try_access()?;
> +///     Some(guard.a + guard.b)
> +/// }
> +///
> +/// let v = Box::pin_init(Revocable::new(Example { a: 10, b: 20 }), GFP_KERNEL).unwrap();
> +/// assert_eq!(add_two(&v), Some(30));
> +/// v.revoke();
> +/// assert_eq!(add_two(&v), None);
> +/// ```
> +///
> +/// Sample example as above, but explicitly using the rcu read side lock.
> +///
> +/// ```
> +/// # use kernel::revocable::Revocable;
> +/// use kernel::sync::rcu;
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// fn add_two(v: &Revocable<Example>) -> Option<u32> {
> +///     let guard = rcu::read_lock();
> +///     let e = v.try_access_with_guard(&guard)?;
> +///     Some(e.a + e.b)
> +/// }
> +///
> +/// let v = Box::pin_init(Revocable::new(Example { a: 10, b: 20 }), GFP_KERNEL).unwrap();
> +/// assert_eq!(add_two(&v), Some(30));
> +/// v.revoke();
> +/// assert_eq!(add_two(&v), None);
> +/// ```
> +#[pin_data(PinnedDrop)]
> +pub struct Revocable<T> {
> +    is_available: AtomicBool,
> +    #[pin]
> +    data: MaybeUninit<UnsafeCell<T>>,
> +}
> +
> +// SAFETY: `Revocable` is `Send` if the wrapped object is also `Send`. This is because while the
> +// functionality exposed by `Revocable` can be accessed from any thread/CPU, it is possible that
> +// this isn't supported by the wrapped object.
> +unsafe impl<T: Send> Send for Revocable<T> {}
> +
> +// SAFETY: `Revocable` is `Sync` if the wrapped object is both `Send` and `Sync`. We require `Send`
> +// from the wrapped object as well because  of `Revocable::revoke`, which can trigger the `Drop`
> +// implementation of the wrapped object from an arbitrary thread.
> +unsafe impl<T: Sync + Send> Sync for Revocable<T> {}
> +
> +impl<T> Revocable<T> {
> +    /// Creates a new revocable instance of the given data.
> +    pub fn new(data: impl PinInit<T>) -> impl PinInit<Self> {

Don't you want to tie this to a struct device?  If not, why not?  If so,
why not do it here?

thanks,

greg k-h

