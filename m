Return-Path: <linux-pci+bounces-33758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A95B21169
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 18:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A8A6E0157
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E12B2E2EEA;
	Mon, 11 Aug 2025 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="krtOAyop"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3312E2F0B;
	Mon, 11 Aug 2025 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928256; cv=none; b=RcIgOt7wnfh2KuXXoLUpr2MtdZITfzTH5jqpye4W24ZxyqSWt0ALac30Hcq8Hr7cJtlq5fBmgcDUe0yPGPsOsqI+kmtKai3k+vP3AI5BFZeXZwMtvtKjOwyzpnhwxdw+B9Q3xevJ6si7ru1w7yrcsE/De/ErYVykDy0Mqn3KHS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928256; c=relaxed/simple;
	bh=53lmUqL5yPTzLf0HyVvpp4UBOwKDYAtc6kUVDMRosDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VJATN4ILsEzWyQ9nt9D6r1sQCBYRZ+PVl/QvMCFFrfOEdHfKhKAcRUhHmljViQ5zDAaxDRJWa07QUkherBntGx8/3RohkwobOgHNBLfYQ//k9puivahZfgZYx+j771W86tJEGGspHpp5XHW0MZ9LQ6j1ZhjBzMFHqMkoh5YBvaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=krtOAyop; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754928252;
	bh=53lmUqL5yPTzLf0HyVvpp4UBOwKDYAtc6kUVDMRosDI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=krtOAyopcZU0SEZ83hsNjZ0mJXv8o3lUxvpAkvdmlnEW7+bNxdNVKeZP+yixif2mx
	 t6WQrFg3HptdpMIjuVwvqz73YbgRp0ps6yn7FERIj3lPdFLafde622eSs1toyGn4e0
	 ALPt1m0clNmTwODBA1OxGa2VXMBYe7Hl93sU/QJ5vQ/Zt1TCuszKiZ/2yagj8w5L72
	 n+JjFoeuNN1sHEZ1mG032NOMaFJU/yUjCdAxWeCaPk0Gn7F2c50uh7QJWYVrsV2X4C
	 sKG383MWuz00HnlVni24wDaN5N+CmskmBdDhZTSxUfp9MX/ck8t8l9yPTSZax/5Rmo
	 hmHvEKKR2IoCA==
Received: from [192.168.0.23] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B562717E090E;
	Mon, 11 Aug 2025 18:04:08 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 11 Aug 2025 13:03:40 -0300
Subject: [PATCH v9 2/7] rust: irq: add flags module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-topics-tyr-request_irq2-v9-2-0485dcd9bcbf@collabora.com>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
In-Reply-To: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-pci@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>, 
 Dirk Behme <dirk.behme@de.bosch.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

Manipulating IRQ flags (i.e.: IRQF_*) will soon be necessary, specially to
register IRQ handlers through bindings::request_irq().

Add a kernel::irq::Flags for that purpose.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/irq.rs       |   5 ++
 rust/kernel/irq/flags.rs | 124 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)

diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
index fae7b15effc80c936d6bffbd5b4150000d6c2898..068df2fea31de51115c30344f7ebdb4da4ad86cc 100644
--- a/rust/kernel/irq.rs
+++ b/rust/kernel/irq.rs
@@ -9,3 +9,8 @@
 //! drivers to register a handler for a given IRQ line.
 //!
 //! C header: [`include/linux/device.h`](srctree/include/linux/interrupt.h)
+
+/// Flags to be used when registering IRQ handlers.
+mod flags;
+
+pub use flags::Flags;
diff --git a/rust/kernel/irq/flags.rs b/rust/kernel/irq/flags.rs
new file mode 100644
index 0000000000000000000000000000000000000000..e62820ea67755123b4f96e4331244bbb4fbcfd9d
--- /dev/null
+++ b/rust/kernel/irq/flags.rs
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright 2025 Collabora ltd.
+
+use crate::bindings;
+use crate::prelude::*;
+
+/// Flags to be used when registering IRQ handlers.
+///
+/// Flags can be used to request specific behaviors when registering an IRQ
+/// handler, and can be combined using the `|`, `&`, and `!` operators to
+/// further control the system's behavior.
+///
+/// A common use case is to register a shared interrupt, as sharing the line
+/// between devices is increasingly common in modern systems and is even
+/// required for some buses. This requires setting [`Flags::SHARED`] when
+/// requesting the interrupt. Other use cases include setting the trigger type
+/// through `Flags::TRIGGER_*`, which determines when the interrupt fires, or
+/// controlling whether the interrupt is masked after the handler runs by using
+/// [`Flags::ONESHOT`].
+///
+/// If an invalid combination of flags is provided, the system will refuse to
+/// register the handler, and lower layers will enforce certain flags when
+/// necessary. This means, for example, that all the
+/// [`crate::irq::Registration`] for a shared interrupt have to agree on
+/// [`Flags::SHARED`] and on the same trigger type, if set.
+#[derive(Clone, Copy, PartialEq, Eq)]
+pub struct Flags(c_ulong);
+
+impl Flags {
+    /// Use the interrupt line as already configured.
+    pub const TRIGGER_NONE: Flags = Flags::new(bindings::IRQF_TRIGGER_NONE);
+
+    /// The interrupt is triggered when the signal goes from low to high.
+    pub const TRIGGER_RISING: Flags = Flags::new(bindings::IRQF_TRIGGER_RISING);
+
+    /// The interrupt is triggered when the signal goes from high to low.
+    pub const TRIGGER_FALLING: Flags = Flags::new(bindings::IRQF_TRIGGER_FALLING);
+
+    /// The interrupt is triggered while the signal is held high.
+    pub const TRIGGER_HIGH: Flags = Flags::new(bindings::IRQF_TRIGGER_HIGH);
+
+    /// The interrupt is triggered while the signal is held low.
+    pub const TRIGGER_LOW: Flags = Flags::new(bindings::IRQF_TRIGGER_LOW);
+
+    /// Allow sharing the IRQ among several devices.
+    pub const SHARED: Flags = Flags::new(bindings::IRQF_SHARED);
+
+    /// Set by callers when they expect sharing mismatches to occur.
+    pub const PROBE_SHARED: Flags = Flags::new(bindings::IRQF_PROBE_SHARED);
+
+    /// Flag to mark this interrupt as timer interrupt.
+    pub const TIMER: Flags = Flags::new(bindings::IRQF_TIMER);
+
+    /// Interrupt is per CPU.
+    pub const PERCPU: Flags = Flags::new(bindings::IRQF_PERCPU);
+
+    /// Flag to exclude this interrupt from irq balancing.
+    pub const NOBALANCING: Flags = Flags::new(bindings::IRQF_NOBALANCING);
+
+    /// Interrupt is used for polling (only the interrupt that is registered
+    /// first in a shared interrupt is considered for performance reasons).
+    pub const IRQPOLL: Flags = Flags::new(bindings::IRQF_IRQPOLL);
+
+    /// Interrupt is not reenabled after the hardirq handler finished. Used by
+    /// threaded interrupts which need to keep the irq line disabled until the
+    /// threaded handler has been run.
+    pub const ONESHOT: Flags = Flags::new(bindings::IRQF_ONESHOT);
+
+    /// Do not disable this IRQ during suspend. Does not guarantee that this
+    /// interrupt will wake the system from a suspended state.
+    pub const NO_SUSPEND: Flags = Flags::new(bindings::IRQF_NO_SUSPEND);
+
+    /// Force enable it on resume even if [`Flags::NO_SUSPEND`] is set.
+    pub const FORCE_RESUME: Flags = Flags::new(bindings::IRQF_FORCE_RESUME);
+
+    /// Interrupt cannot be threaded.
+    pub const NO_THREAD: Flags = Flags::new(bindings::IRQF_NO_THREAD);
+
+    /// Resume IRQ early during syscore instead of at device resume time.
+    pub const EARLY_RESUME: Flags = Flags::new(bindings::IRQF_EARLY_RESUME);
+
+    /// If the IRQ is shared with a [`Flags::NO_SUSPEND`] user, execute this
+    /// interrupt handler after suspending interrupts. For system wakeup devices
+    /// users need to implement wakeup detection in their interrupt handlers.
+    pub const COND_SUSPEND: Flags = Flags::new(bindings::IRQF_COND_SUSPEND);
+
+    /// Don't enable IRQ or NMI automatically when users request it. Users will
+    /// enable it explicitly by `enable_irq` or `enable_nmi` later.
+    pub const NO_AUTOEN: Flags = Flags::new(bindings::IRQF_NO_AUTOEN);
+
+    /// Exclude from runnaway detection for IPI and similar handlers, depends on
+    /// `PERCPU`.
+    pub const NO_DEBUG: Flags = Flags::new(bindings::IRQF_NO_DEBUG);
+
+    pub(crate) fn into_inner(self) -> c_ulong {
+        self.0
+    }
+
+    const fn new(value: u32) -> Self {
+        build_assert!(value as u64 <= c_ulong::MAX as u64);
+        Self(value as c_ulong)
+    }
+}
+
+impl core::ops::BitOr for Flags {
+    type Output = Self;
+    fn bitor(self, rhs: Self) -> Self::Output {
+        Self(self.0 | rhs.0)
+    }
+}
+
+impl core::ops::BitAnd for Flags {
+    type Output = Self;
+    fn bitand(self, rhs: Self) -> Self::Output {
+        Self(self.0 & rhs.0)
+    }
+}
+
+impl core::ops::Not for Flags {
+    type Output = Self;
+    fn not(self) -> Self::Output {
+        Self(!self.0)
+    }
+}

-- 
2.50.1


