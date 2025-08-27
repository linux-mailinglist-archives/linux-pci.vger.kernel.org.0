Return-Path: <linux-pci+bounces-34888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14508B37C2F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 09:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61331773AF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 07:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA8032142E;
	Wed, 27 Aug 2025 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6aYxye9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128D01E9B12;
	Wed, 27 Aug 2025 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281012; cv=none; b=CtZOSXDfgiUhjdYYnZOhYEe0d6o+S3X+cqKA8m6DSuoLal7/CGHQJdp1Pq3ufsXkj+9wH7u7RHx75hnKOLSIixixlczSxSxqmFSxuaoknLsqVN8UOOvsNTWAhlBmZy6LXhQcaLuwoX2nbtgsrMNZyLy/brYJHwbe6QQ7VKXEE+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281012; c=relaxed/simple;
	bh=TLzcboUlgUgMPALkL0SEtfnA51JYIowP1RwyrX89uEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FTko9FZLXTBaRoy1Fmz/t2RNfGywyZntb7nRtSm4hhlvWh2UDDdbvrEUz1QuLN5lPpIzG4QYJbLaRR2ZwrY4yKITntD2oJvhvE6krLjZ/k73m5MMueHjzGdmZqrw2O0S9qt7Q9RoUntL6W6UgVagrkgAIlcTzNx0G5n7D4u9LRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6aYxye9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2F0C4CEEB;
	Wed, 27 Aug 2025 07:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756281011;
	bh=TLzcboUlgUgMPALkL0SEtfnA51JYIowP1RwyrX89uEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=b6aYxye9kjJ0n3mTyqm8rDastOST5yPxY6ekrsaxf3rkjdj3GKngY5omQLurQTtM0
	 Sz81uyl/ZFZuigFcpLZiixDuX+TxmkdggOiIAnNgFPI4CyliAAmPA4xrearCzihTlT
	 OrI6lKxJeA0GW58PrwXKcD1kT1UzOpGT7+ivJk4qtu2ia59UVA7jcE7GjYUw/3ICQ0
	 QLs2BCH6LRhJwXyHLDMj7QUS0wj/lMnbDyOidygdISLev1LjMvSsL/TPe7QU5WvyUQ
	 NNKsGBCqU3ZAY/3uEzT6kJCmcbu5bDYwkmQgaR1TXKPJtxCKmsy6z1gTxeOXbgsi0x
	 MauTe/42e87vQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Bjorn
 Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Benno Lossin <lossin@kernel.org>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>, Dirk
 Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH v9 3/7] rust: irq: add support for non-threaded IRQs and
 handlers
In-Reply-To: <9A068CEC-E45F-44B1-9D16-D550835503F9@collabora.com>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
 <ZBiGWoEXSxAUvEwNj8vzyDa5L6KvqTuKBTKz3mzyhMGBAja6PJsMtIiSdAUKDmn_FumrmDYuOk4PKlXRW055Qw==@protonmail.internalid>
 <20250811-topics-tyr-request_irq2-v9-3-0485dcd9bcbf@collabora.com>
 <87wm71cahd.fsf@t14s.mail-host-address-is-not-set>
 <AEwfSACv6dV1KuKmY7ufNvpYacRoT4xbJRGQJP7zfeV2GfeKcNpXZqsOQJw_w4lqbjqIsMjt-NZqp4OqBeIFpA==@protonmail.internalid>
 <9A068CEC-E45F-44B1-9D16-D550835503F9@collabora.com>
Date: Wed, 27 Aug 2025 09:50:00 +0200
Message-ID: <87zfblurtj.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

> Hi Andreas,
>
>> On 18 Aug 2025, at 05:14, Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>> "Daniel Almeida" <daniel.almeida@collabora.com> writes:
>>
>>> This patch adds support for non-threaded IRQs and handlers through
>>> irq::Registration and the irq::Handler trait.
>>>
>>> Registering an irq is dependent upon having a IrqRequest that was
>>> previously allocated by a given device. This will be introduced in
>>> subsequent patches.
>>>
>>> Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
>>> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
>>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>>> ---
>>> rust/bindings/bindings_helper.h |   1 +
>>> rust/helpers/helpers.c          |   1 +
>>> rust/helpers/irq.c              |   9 ++
>>> rust/kernel/irq.rs              |   5 +
>>> rust/kernel/irq/request.rs      | 264 ++++++++++++++++++++++++++++++++++++++++
>>> 5 files changed, 280 insertions(+)
>>>
>>> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
>>> index 84d60635e8a9baef1f1a1b2752dc0fa044f8542f..69a975da829f0c35760f71a1b32b8fcb12c8a8dc 100644
>>> --- a/rust/bindings/bindings_helper.h
>>> +++ b/rust/bindings/bindings_helper.h
>>> @@ -52,6 +52,7 @@
>>> #include <linux/ethtool.h>
>>> #include <linux/file.h>
>>> #include <linux/firmware.h>
>>> +#include <linux/interrupt.h>
>>> #include <linux/fs.h>
>>> #include <linux/ioport.h>
>>> #include <linux/jiffies.h>
>>> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
>>> index 7cf7fe95e41dd51717050648d6160bebebdf4b26..44b2005d50140d34a44ae37d01c2ddbae6aeaa32 100644
>>> --- a/rust/helpers/helpers.c
>>> +++ b/rust/helpers/helpers.c
>>> @@ -22,6 +22,7 @@
>>> #include "dma.c"
>>> #include "drm.c"
>>> #include "err.c"
>>> +#include "irq.c"
>>> #include "fs.c"
>>> #include "io.c"
>>> #include "jump_label.c"
>>> diff --git a/rust/helpers/irq.c b/rust/helpers/irq.c
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..1faca428e2c047a656dec3171855c1508d67e60b
>>> --- /dev/null
>>> +++ b/rust/helpers/irq.c
>>> @@ -0,0 +1,9 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +#include <linux/interrupt.h>
>>> +
>>> +int rust_helper_request_irq(unsigned int irq, irq_handler_t handler,
>>> +     unsigned long flags, const char *name, void *dev)
>>> +{
>>> + return request_irq(irq, handler, flags, name, dev);
>>> +}
>>> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
>>> index 068df2fea31de51115c30344f7ebdb4da4ad86cc..c1019bc36ad1e7ae7dd3af8a8b5c14780bf70712 100644
>>> --- a/rust/kernel/irq.rs
>>> +++ b/rust/kernel/irq.rs
>>> @@ -13,4 +13,9 @@
>>> /// Flags to be used when registering IRQ handlers.
>>> mod flags;
>>>
>>> +/// IRQ allocation and handling.
>>> +mod request;
>>> +
>>> pub use flags::Flags;
>>> +
>>> +pub use request::{Handler, IrqRequest, IrqReturn, Registration};
>>> diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..57e00ebf694d8e6e870d9ed57af7ee2ecf86ec05
>>> --- /dev/null
>>> +++ b/rust/kernel/irq/request.rs
>>> @@ -0,0 +1,264 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +// SPDX-FileCopyrightText: Copyright 2025 Collabora ltd.
>>> +
>>> +//! This module provides types like [`Registration`] which allow users to
>>> +//! register handlers for a given IRQ line.
>>> +
>>> +use core::marker::PhantomPinned;
>>> +
>>> +use crate::alloc::Allocator;
>>> +use crate::device::{Bound, Device};
>>
>> nit: I would suggest either normalizing all the imports, or using one
>> import per line consistently.
>>
>>> +use crate::devres::Devres;
>>> +use crate::error::to_result;
>>> +use crate::irq::flags::Flags;
>>> +use crate::prelude::*;
>>> +use crate::str::CStr;
>>> +use crate::sync::Arc;
>>> +
>>> +/// The value that can be returned from a [`Handler`] or a [`ThreadedHandler`].
>>
>> error: unresolved link to `ThreadedHandler`
>>  --> /home/aeh/src/linux-rust/request-irq/rust/kernel/irq/request.rs:18:62
>>   |
>> 18 | /// The value that can be returned from a [`Handler`] or a [`ThreadedHandler`].
>>   |                                                              ^^^^^^^^^^^^^^^ no item named `ThreadedHandler` in scope
>>   |
>
> This was introduced by the next commit. I wonder what is the right thing to do
> here now?

I would suggest (next time, since this is applied) not linking the
symbol in this patch and then adding the link in the patch that adds the
link target.

Or, adding the paragraph with the patch that adds the link target.

>
>>
>>> +#[repr(u32)]
>>> +pub enum IrqReturn {
>>> +    /// The interrupt was not from this device or was not handled.
>>> +    None = bindings::irqreturn_IRQ_NONE,
>>> +
>>> +    /// The interrupt was handled by this device.
>>> +    Handled = bindings::irqreturn_IRQ_HANDLED,
>>> +}
>>> +
>>> +/// Callbacks for an IRQ handler.
>>> +pub trait Handler: Sync {
>>> +    /// The hard IRQ handler.
>>
>> Could you do a vocabulary somewhere? What does it mean that the handler
>> is hard?
>
>
> This nomenclature is borrowed from the C part of the kernel. The hard part is
> what runs immediately in interrupt context while the bottom half runs later. In
> this case, the bottom half is a threaded handler, i.e.: code running in a
> separate kthread.
>
> I think this is immediately understandable most of the time because it's a term
> that is often used in the kernel. Do you still feel that I should expand the
> docs in this case?

Yes, I do. We have to consider that some people reading this API might
not be aware of this tribal knowledge. This is our chance to properly
document public kernel APIs.

If you feel that you would be duplicating existing documentation, I
would suggest linking to that documentation.

We could just add a paragraph inline:

  The hard IRQ handler.

  A "hard" handler in the context of the Linux kernel is the part of an
  interrupt handler that runs in interrupt context. The hard handler
  usually defers time consuming processing to run in process context,
  for instance by queuing the work on a work queue for later execution.

(I am not sure if this description is correct, and I would suggest also
describing "bottom half" if you are going to use that term.)

>
>>
>>> +    ///
>>> +    /// This is executed in interrupt context, hence all corresponding
>>> +    /// limitations do apply.
>>> +    ///
>>> +    /// All work that does not necessarily need to be executed from
>>> +    /// interrupt context, should be deferred to a threaded handler.
>>> +    /// See also [`ThreadedRegistration`].
>>
>> error: unresolved link to `ThreadedRegistration`
>>  --> /home/aeh/src/linux-rust/request-irq/rust/kernel/irq/request.rs:37:20
>>   |
>> 37 |     /// See also [`ThreadedRegistration`].
>>   |                    ^^^^^^^^^^^^^^^^^^^^ no item named `ThreadedRegistration` in scope
>>   |
>>
>
> Same as the previous doc issue you highlighted.
>
>>> +    fn handle(&self) -> IrqReturn;
>>> +}
>>> +
>>> +impl<T: ?Sized + Handler + Send> Handler for Arc<T> {
>>> +    fn handle(&self) -> IrqReturn {
>>> +        T::handle(self)
>>> +    }
>>> +}
>>> +
>>> +impl<T: ?Sized + Handler, A: Allocator> Handler for Box<T, A> {
>>> +    fn handle(&self) -> IrqReturn {
>>> +        T::handle(self)
>>> +    }
>>> +}
>>> +
>>> +/// # Invariants
>>> +///
>>> +/// - `self.irq` is the same as the one passed to `request_{threaded}_irq`.
>>> +/// - `cookie` was passed to `request_{threaded}_irq` as the cookie. It is guaranteed to be unique
>>> +///   by the type system, since each call to `new` will return a different instance of
>>> +///   `Registration`.
>>
>> This seems like a mix of invariant declaration and conformance. I don't
>> think the following belongs here:
>>
>>  It is guaranteed to be unique
>>  by the type system, since each call to `new` will return a different instance of
>>  `Registration`.
>>
>> You could replace it with a uniqueness requirement.
>
> WDYM? This invariant is indeed provided by the type system and we do rely on it
> to make the abstraction work.

The invariant section of the type documentation should be a list of
invariants, not reasoning about why the invariants hold. The reasoning
goes in the code where we construct the type, where we momentarily
break invariants, or where we change the value of the type.

In this case, I think the invariant is that `cookie` is unique. How we
conform to this invariant does not belong in the list. When you
construct the type, you should have an `// INVARIANT:` comment
explaining why the newly constructed type upholds the invariant.

At least that is how I understand intended use of the framework.

>
>>
>>> +#[pin_data(PinnedDrop)]
>>> +struct RegistrationInner {
>>> +    irq: u32,
>>> +    cookie: *mut c_void,
>>> +}
>>> +
>>> +impl RegistrationInner {
>>> +    fn synchronize(&self) {
>>> +        // SAFETY: safe as per the invariants of `RegistrationInner`
>>> +        unsafe { bindings::synchronize_irq(self.irq) };
>>> +    }
>>> +}
>>> +
>>> +#[pinned_drop]
>>> +impl PinnedDrop for RegistrationInner {
>>> +    fn drop(self: Pin<&mut Self>) {
>>> +        // SAFETY:
>>> +        //
>>> +        // Safe as per the invariants of `RegistrationInner` and:
>>> +        //
>>> +        // - The containing struct is `!Unpin` and was initialized using
>>> +        // pin-init, so it occupied the same memory location for the entirety of
>>> +        // its lifetime.
>>> +        //
>>> +        // Notice that this will block until all handlers finish executing,
>>> +        // i.e.: at no point will &self be invalid while the handler is running.
>>> +        unsafe { bindings::free_irq(self.irq, self.cookie) };
>>> +    }
>>> +}
>>> +
>>> +// SAFETY: We only use `inner` on drop, which called at most once with no
>>> +// concurrent access.
>>> +unsafe impl Sync for RegistrationInner {}
>>> +
>>> +// SAFETY: It is safe to send `RegistrationInner` across threads.
>>
>> Why?
>
> It's a u32 and an opaque pointer. The pointer itself (which is what demands a
> manual send/sync impl) is only used on drop() and there are no restrictions
> that prevent freeing an irq from another thread.

Then use this as your safety comment. This text way more informative to
the reader than the original. Perhaps something like this:

  It is safe to transfer ownership of `RegistrationInner` from another
  thread, because it has no shared mutable state. The IRQ owned by
  `RegistrationInner` via `cookie` can be dropped from any thread.


Best regards,
Andreas Hindborg



