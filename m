Return-Path: <linux-pci+bounces-34106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76BFB27FB5
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 14:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9183B97E6
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 12:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A38B29C346;
	Fri, 15 Aug 2025 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYw4H6xW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EBB28C2D1;
	Fri, 15 Aug 2025 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755259667; cv=none; b=psYuKKAzQRDWkw5M+r1ck7V7qQ2tXe1n/uEmyJy5A64y/037v7s5p+h4bGbUXcXZouXiY5x+uJFs//5hnIbe38/XhTkRsp91oWUr/qqdzmHfx5ky1N/AqwyJojWvHJ9cWCE4t+vxiy6a/Tj/SE1pcjJNtnl6rruRMR96ZkFGrvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755259667; c=relaxed/simple;
	bh=+zK6FWDvXXZlff+02xUXRsfbnd6zM/7GQBlYSioRBcU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NV5L1vRhEfl/AiC7/JiWmW65+fczbMDgRPEz8IxSSfzlWJ2J1jBfXZI+qte9x+AE3irdhMVfIrqfe08GdkIQZH7x3RS0tfNefkiQVDuC4dDcAklOqhiX/eQWny1EWt3wK0KBD4xoEhujtks/Ot8R0LrGetwrVwF7t7K9YIQ/4Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYw4H6xW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF91C4CEEB;
	Fri, 15 Aug 2025 12:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755259667;
	bh=+zK6FWDvXXZlff+02xUXRsfbnd6zM/7GQBlYSioRBcU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bYw4H6xWsoJO4pHYknubTtwVz1nXe5VvLf/vem/wB9vql1uVcLjbvYMyHhxJ1Se5a
	 VXHAs9wT6Cl8rpaESkwaNKoySvsH60j8iW5kGOHG7Y9FHtt40GXqFHCX0KjeVK06tM
	 Wj2UPX3h+uSGlLkrDMLEWRMZNRDLoxw3tOpI1Jwqnn1atxjkY5DXIbU/Lr3dhTlNTP
	 nF/xx87bWyZTOELLA99uNgtAMhyQchaGtit1ouBts7HrLCBLQXuzjeu1BSSC0CPbff
	 VluuhMv6rt9QQmGm5EvCqtSSeLeom/fGKxx282V5s8QFUshnlJlNENf1s6CToNyziU
	 MAsGVBHGBYkOA==
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
Subject: Re: [PATCH v9 2/7] rust: irq: add flags module
In-Reply-To: <20250811-topics-tyr-request_irq2-v9-2-0485dcd9bcbf@collabora.com>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
 <jjFmLoNIrT4EPz7LdN97j6uH8O6tsBHwC7-j9YfE6wdzydDFNRGMiVFcv5GI4waWhs_jdhILALP1ObzX7GEzzQ==@protonmail.internalid>
 <20250811-topics-tyr-request_irq2-v9-2-0485dcd9bcbf@collabora.com>
Date: Fri, 15 Aug 2025 14:02:36 +0200
Message-ID: <87349seqsj.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

> Manipulating IRQ flags (i.e.: IRQF_*) will soon be necessary, specially to
> register IRQ handlers through bindings::request_irq().
>
> Add a kernel::irq::Flags for that purpose.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/kernel/irq.rs       |   5 ++
>  rust/kernel/irq/flags.rs | 124 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 129 insertions(+)
>
> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
> index fae7b15effc80c936d6bffbd5b4150000d6c2898..068df2fea31de51115c30344f7ebdb4da4ad86cc 100644
> --- a/rust/kernel/irq.rs
> +++ b/rust/kernel/irq.rs
> @@ -9,3 +9,8 @@
>  //! drivers to register a handler for a given IRQ line.
>  //!
>  //! C header: [`include/linux/device.h`](srctree/include/linux/interrupt.h)
> +
> +/// Flags to be used when registering IRQ handlers.
> +mod flags;
> +
> +pub use flags::Flags;
> diff --git a/rust/kernel/irq/flags.rs b/rust/kernel/irq/flags.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..e62820ea67755123b4f96e4331244bbb4fbcfd9d
> --- /dev/null
> +++ b/rust/kernel/irq/flags.rs
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: Copyright 2025 Collabora ltd.
> +
> +use crate::bindings;
> +use crate::prelude::*;
> +
> +/// Flags to be used when registering IRQ handlers.
> +///
> +/// Flags can be used to request specific behaviors when registering an IRQ
> +/// handler, and can be combined using the `|`, `&`, and `!` operators to
> +/// further control the system's behavior.
> +///
> +/// A common use case is to register a shared interrupt, as sharing the line
> +/// between devices is increasingly common in modern systems and is even
> +/// required for some buses. This requires setting [`Flags::SHARED`] when
> +/// requesting the interrupt. Other use cases include setting the trigger type
> +/// through `Flags::TRIGGER_*`, which determines when the interrupt fires, or
> +/// controlling whether the interrupt is masked after the handler runs by using
> +/// [`Flags::ONESHOT`].
> +///
> +/// If an invalid combination of flags is provided, the system will refuse to
> +/// register the handler, and lower layers will enforce certain flags when
> +/// necessary. This means, for example, that all the
> +/// [`crate::irq::Registration`] for a shared interrupt have to agree on

`rustdoc` will complain about this being undefined.

> +/// [`Flags::SHARED`] and on the same trigger type, if set.
> +#[derive(Clone, Copy, PartialEq, Eq)]
> +pub struct Flags(c_ulong);
> +
> +impl Flags {
> +    /// Use the interrupt line as already configured.
> +    pub const TRIGGER_NONE: Flags = Flags::new(bindings::IRQF_TRIGGER_NONE);
> +
> +    /// The interrupt is triggered when the signal goes from low to high.
> +    pub const TRIGGER_RISING: Flags = Flags::new(bindings::IRQF_TRIGGER_RISING);
> +
> +    /// The interrupt is triggered when the signal goes from high to low.
> +    pub const TRIGGER_FALLING: Flags = Flags::new(bindings::IRQF_TRIGGER_FALLING);
> +
> +    /// The interrupt is triggered while the signal is held high.
> +    pub const TRIGGER_HIGH: Flags = Flags::new(bindings::IRQF_TRIGGER_HIGH);
> +
> +    /// The interrupt is triggered while the signal is held low.
> +    pub const TRIGGER_LOW: Flags = Flags::new(bindings::IRQF_TRIGGER_LOW);
> +
> +    /// Allow sharing the IRQ among several devices.
> +    pub const SHARED: Flags = Flags::new(bindings::IRQF_SHARED);
> +
> +    /// Set by callers when they expect sharing mismatches to occur.
> +    pub const PROBE_SHARED: Flags = Flags::new(bindings::IRQF_PROBE_SHARED);
> +
> +    /// Flag to mark this interrupt as timer interrupt.
> +    pub const TIMER: Flags = Flags::new(bindings::IRQF_TIMER);
> +
> +    /// Interrupt is per CPU.
> +    pub const PERCPU: Flags = Flags::new(bindings::IRQF_PERCPU);
> +
> +    /// Flag to exclude this interrupt from irq balancing.
> +    pub const NOBALANCING: Flags = Flags::new(bindings::IRQF_NOBALANCING);
> +
> +    /// Interrupt is used for polling (only the interrupt that is registered
> +    /// first in a shared interrupt is considered for performance reasons).
> +    pub const IRQPOLL: Flags = Flags::new(bindings::IRQF_IRQPOLL);
> +
> +    /// Interrupt is not reenabled after the hardirq handler finished. Used by
> +    /// threaded interrupts which need to keep the irq line disabled until the
> +    /// threaded handler has been run.
> +    pub const ONESHOT: Flags = Flags::new(bindings::IRQF_ONESHOT);
> +
> +    /// Do not disable this IRQ during suspend. Does not guarantee that this
> +    /// interrupt will wake the system from a suspended state.
> +    pub const NO_SUSPEND: Flags = Flags::new(bindings::IRQF_NO_SUSPEND);
> +
> +    /// Force enable it on resume even if [`Flags::NO_SUSPEND`] is set.
> +    pub const FORCE_RESUME: Flags = Flags::new(bindings::IRQF_FORCE_RESUME);
> +
> +    /// Interrupt cannot be threaded.
> +    pub const NO_THREAD: Flags = Flags::new(bindings::IRQF_NO_THREAD);
> +
> +    /// Resume IRQ early during syscore instead of at device resume time.
> +    pub const EARLY_RESUME: Flags = Flags::new(bindings::IRQF_EARLY_RESUME);
> +
> +    /// If the IRQ is shared with a [`Flags::NO_SUSPEND`] user, execute this
> +    /// interrupt handler after suspending interrupts. For system wakeup devices
> +    /// users need to implement wakeup detection in their interrupt handlers.
> +    pub const COND_SUSPEND: Flags = Flags::new(bindings::IRQF_COND_SUSPEND);
> +
> +    /// Don't enable IRQ or NMI automatically when users request it. Users will
> +    /// enable it explicitly by `enable_irq` or `enable_nmi` later.
> +    pub const NO_AUTOEN: Flags = Flags::new(bindings::IRQF_NO_AUTOEN);
> +
> +    /// Exclude from runnaway detection for IPI and similar handlers, depends on
> +    /// `PERCPU`.

Should we link `PERCPU` here?

> +    pub const NO_DEBUG: Flags = Flags::new(bindings::IRQF_NO_DEBUG);
> +
> +    pub(crate) fn into_inner(self) -> c_ulong {

You need `#[expect(dead_code)]` here.

> +        self.0
> +    }
> +
> +    const fn new(value: u32) -> Self {
> +        build_assert!(value as u64 <= c_ulong::MAX as u64);

I am curious about this line. Can you add a short explanation?

I would think this can never assert. That would require c_ulong to be
less than 32 bits, right? Are there any configurations where that is the case?


Best regards,
Andreas Hindborg




