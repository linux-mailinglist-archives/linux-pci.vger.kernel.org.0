Return-Path: <linux-pci+bounces-33678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E127B1FD4A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 02:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C735176793
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 00:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B5619CD13;
	Mon, 11 Aug 2025 00:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kptm4sJ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BE01925BC;
	Mon, 11 Aug 2025 00:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754872377; cv=none; b=e/2/7NPBpGTTeq4YNvBXqCpV3wLcZeOUc3o+lFP0FSUsUy5+u3SzWiK4FX9DzU87CrH8LDXXGZDIRqC5lX+BENvdxfKfemY0GgGaf6siscohsoZ+sFQxnE+zVLL+mF/qrftvvnMiqs8QQkddCopFCuXf8bh5VlkoXXkeEKVIG9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754872377; c=relaxed/simple;
	bh=ckoYEKjaaGomzDV+K9P2gebpsjCQQj7rVpnFR9cKnt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pGFG0nZ0LifD0rCNzVM36B3NFk66x0aggsS/Q/xMeidttPioDbO8J7GY0wOPpakE0GfuHQsqStt0Xo9elzPMAoWWdYz3SqeYF6T4yXy/0iOi8DlWCP4+TSNDcKnDGnOy3oEYyvsc5ssz7kLFkFKrH0JuXCPR3e4NmW/nAXarHWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kptm4sJ9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754872373;
	bh=ckoYEKjaaGomzDV+K9P2gebpsjCQQj7rVpnFR9cKnt4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kptm4sJ9JfwDm+wlVhSL3e0ENTusyh8PIgjhmZ64u0GExssSxTnxMTgJMPmt7U1Nw
	 6TgzosxTYjwZ133m+pim9iD7Mxf5s6JwOtW1Q7D0FXGXTvlq7jciyQL/Qp8TDvX5nW
	 CmhPJozU1Qy0USWVjgo8U50KSLEonxEjfdC2UEsJ+Qe/x/+wqU2DfpWAly3MOO11uI
	 mORty3AmXuprE85GaLiJZGrS+BKoxflVP8Wzqv0RxwG/SRb0Thu81871E7b5XSlLEL
	 OegAFcSIMnMg3piNenxIUaPeTEZ2h6ekZyF9fwVEQy/jTLleGu3j49ehfbpOoNcqEe
	 AyHA0BIJ2UdXA==
Received: from [192.168.0.23] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 27B3F17E0B8C;
	Mon, 11 Aug 2025 02:32:48 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Sun, 10 Aug 2025 21:32:15 -0300
Subject: [PATCH v8 2/6] rust: irq: add flags module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-topics-tyr-request_irq2-v8-2-8163f4c4c3a6@collabora.com>
References: <20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com>
In-Reply-To: <20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com>
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
 rust/kernel/irq.rs       |   6 +++
 rust/kernel/irq/flags.rs | 124 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
index fae7b15effc80c936d6bffbd5b4150000d6c2898..d6306415f561f94a05b1c059eaa937b0b585471d 100644
--- a/rust/kernel/irq.rs
+++ b/rust/kernel/irq.rs
@@ -9,3 +9,9 @@
 //! drivers to register a handler for a given IRQ line.
 //!
 //! C header: [`include/linux/device.h`](srctree/include/linux/interrupt.h)
+
+/// Flags to be used when registering IRQ handlers.
+pub mod flags;
+
+#[doc(inline)]
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


