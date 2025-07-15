Return-Path: <linux-pci+bounces-32168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ACBB062BE
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 17:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FFD1AA22D7
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 15:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8666124677B;
	Tue, 15 Jul 2025 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FrdFChsB"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633C244675;
	Tue, 15 Jul 2025 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592626; cv=none; b=gPLhV485iMFn80NgtYukEzpcGtQlrPXJJmeNwCa6d07FqrYTTv88PIRCiBaGJTV3hNtlP2IK+3i6LiV/6+s/uvxXj1wNjei6hVl/ZuG6/V3naK1Hw8YY5FDHItOFFcq83GA92V8SLkphMV0mM/oi37UqeJw8mFNI/YvmkPnAB+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592626; c=relaxed/simple;
	bh=bEgEWNhssQSJW2BrmbFAEaknmVdtS6hkCDnTTi167Bw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b25mBSbh5z4YRyqnyaMvHYHuxvEBrOufPskuBwgTscS7IA6vUVM0jkM9ECNHKm0cEvde+lGH2TQrODAKaV0uMEVcm22GAfTfC0xsfIBUUpsHRxhQ3xMb1zZTg1BZ0Mq6K4siQn+81F5mN39flckss/7NvBu9JOTn2C9DG5wkTNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FrdFChsB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752592622;
	bh=bEgEWNhssQSJW2BrmbFAEaknmVdtS6hkCDnTTi167Bw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FrdFChsBWqizUsSnKEbnhqAhI+3iWVPWydeFcdvotgO/JtTERZVS2ab4vSPZFe6Sk
	 jDvqRQLkn9ou2Tj+okgaEmV3JH37bZiteXBWS4vR8JmYat1BEFUI47DHAw3nZPbW7T
	 8JGu9joWj23xIT/GfzFv1q0yMPtL+fP9udvCIXFfoxzpSh6HlQL5Q43dm0rZ2jE4rn
	 vMlNXiZ51y8qeVpXew/HQn51396bNJdtVrEboLK0/sLkUdig+dh7NpznJr8EFlsQS3
	 OPBp6P4/8/6aktu/jn3XG/mS0j4EthuMGAJzIzhvee83bqwxDV+j3RVby2xB/rKy/k
	 WFXzpMObdPUXg==
Received: from [192.168.0.2] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F255C17E0FFA;
	Tue, 15 Jul 2025 17:16:59 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 15 Jul 2025 12:16:39 -0300
Subject: [PATCH v7 2/6] rust: irq: add flags module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-topics-tyr-request_irq2-v7-2-d469c0f37c07@collabora.com>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
In-Reply-To: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
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
 linux-pci@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

Manipulating IRQ flags (i.e.: IRQF_*) will soon be necessary, specially to
register IRQ handlers through bindings::request_irq().

Add a kernel::irq::Flags for that purpose.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/irq.rs       |   3 ++
 rust/kernel/irq/flags.rs | 124 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
index fae7b15effc80c936d6bffbd5b4150000d6c2898..9abd9a6dc36f3e3ecc1f92ad7b0040176b56a079 100644
--- a/rust/kernel/irq.rs
+++ b/rust/kernel/irq.rs
@@ -9,3 +9,6 @@
 //! drivers to register a handler for a given IRQ line.
 //!
 //! C header: [`include/linux/device.h`](srctree/include/linux/interrupt.h)
+
+/// Flags to be used when registering IRQ handlers.
+pub mod flags;
diff --git a/rust/kernel/irq/flags.rs b/rust/kernel/irq/flags.rs
new file mode 100644
index 0000000000000000000000000000000000000000..a4882851d21f3e841862875ad7286ea6a2dfd2dd
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
+    /// Force enable it on resume even if [`NO_SUSPEND`] is set.
+    pub const FORCE_RESUME: Flags = Flags::new(bindings::IRQF_FORCE_RESUME);
+
+    /// Interrupt cannot be threaded.
+    pub const NO_THREAD: Flags = Flags::new(bindings::IRQF_NO_THREAD);
+
+    /// Resume IRQ early during syscore instead of at device resume time.
+    pub const EARLY_RESUME: Flags = Flags::new(bindings::IRQF_EARLY_RESUME);
+
+    /// If the IRQ is shared with a [`NO_SUSPEND`] user, execute this interrupt
+    /// handler after suspending interrupts. For system wakeup devices users
+    /// need to implement wakeup detection in their interrupt handlers.
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
2.50.0


