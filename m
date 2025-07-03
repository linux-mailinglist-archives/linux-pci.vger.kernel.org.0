Return-Path: <linux-pci+bounces-31450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F77AF8162
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 21:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80F21C84143
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 19:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A6A2F2C56;
	Thu,  3 Jul 2025 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="VBp/1wBm"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF3C2F2736;
	Thu,  3 Jul 2025 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751571076; cv=pass; b=BQ2yyBl3KTi9g0eonV9gwBXoZp7BtMypWVKwYBrbzHB5/6iEdY+/i8Oy5OTdyC39mmtWyZx2otbfnyVtpBVjCwKXIC/uQpIX/tK36fruSBgH9jZJv5rWG79KnzbdKW1xM/+wKNcKgWU4mot4WIesaasfL5sm+xKK+sYT1Ycvtzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751571076; c=relaxed/simple;
	bh=FN+vUZHISonksf0avqO410vexj0U6dH3mX8aymZfaNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ufGFoF2dmDH33An3T+03/4QkY78p5y57MYkbsnIYNatt/SjJSLOhCW+tt3sCwxvvAQhTL56AXHXe+l7qmBOJJ796iQaH5Aha96s3V8GEKxA6wNH2u52eMgwy6Clak33wn86H390HpQ0EGKRzCQZiXyNteliKbMrc2402b+TetWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=VBp/1wBm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751571050; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C1e613ap+8bZOSYDqaWav5Uni3LvVQvymVpCvYDY6KjSqm5MBoKS+vnJEv9Mazn8rOQgdBDKGQr2M+I+B1XsEXDlM7Iwmn5h+/HDbE0ve3leK5t5QJL9G5nbwuyhiOm53USRAxJEwvp84IESpG+YxA/6VIZrQ2P76EHusN+CBMw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751571050; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=alrRo8Nvsmb0Eo4JXfNn9cIOlYnb8zdQKewhwjmgfsI=; 
	b=i+JAsoUrss7z73ptLOLaB4cPOd9PIRUZ5wLzyxHuLwSmHbWOwgEOLMKB+Jn2pMnVoO56Hu5PnP7BDMUJvX8/w6TZpM4/ZYmwZ+pXXeStq8t5OnLShwi/6mW2MKxuir/kOE+qE0znYXv9rcWxOX1NEiC/JpQbh2j6tFvbqfIctXM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751571050;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=alrRo8Nvsmb0Eo4JXfNn9cIOlYnb8zdQKewhwjmgfsI=;
	b=VBp/1wBmaYsblUSk7ICEeteA8s/DppKgO+J2GegWtroOiZ54G4Isc7io5KlGYL1d
	+8jO+18JotJrH/oEXYx6t1mNE1LA8y2wulegGmTdsUeDyt3T6Z+IvTZ29UAa2nYpJzx
	4igAq3nrcDEZjuXHv/8oS3G4mjtOJ4XuSfAVJ824=
Received: by mx.zohomail.com with SMTPS id 1751571047607576.0930779126198;
	Thu, 3 Jul 2025 12:30:47 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 03 Jul 2025 16:30:00 -0300
Subject: [PATCH v6 2/6] rust: irq: add flags module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-topics-tyr-request_irq-v6-2-74103bdc7c52@collabora.com>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
In-Reply-To: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Benno Lossin <lossin@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-pci@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

Manipulating IRQ flags (i.e.: IRQF_*) will soon be necessary, specially to
register IRQ handlers through bindings::request_irq().

Add a kernel::irq::Flags for that purpose.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/irq.rs       |   3 ++
 rust/kernel/irq/flags.rs | 102 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

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
index 0000000000000000000000000000000000000000..3cfaef65ae14f6c02f55ebcf4d52450c0052df30
--- /dev/null
+++ b/rust/kernel/irq/flags.rs
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright 2025 Collabora ltd.
+
+use crate::bindings;
+
+/// Flags to be used when registering IRQ handlers.
+///
+/// They can be combined with the operators `|`, `&`, and `!`.
+#[derive(Clone, Copy, PartialEq, Eq)]
+pub struct Flags(u64);
+
+impl Flags {
+    pub(crate) fn into_inner(self) -> u64 {
+        self.0
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
+
+/// Use the interrupt line as already configured.
+pub const TRIGGER_NONE: Flags = Flags(bindings::IRQF_TRIGGER_NONE as u64);
+
+/// The interrupt is triggered when the signal goes from low to high.
+pub const TRIGGER_RISING: Flags = Flags(bindings::IRQF_TRIGGER_RISING as u64);
+
+/// The interrupt is triggered when the signal goes from high to low.
+pub const TRIGGER_FALLING: Flags = Flags(bindings::IRQF_TRIGGER_FALLING as u64);
+
+/// The interrupt is triggered while the signal is held high.
+pub const TRIGGER_HIGH: Flags = Flags(bindings::IRQF_TRIGGER_HIGH as u64);
+
+/// The interrupt is triggered while the signal is held low.
+pub const TRIGGER_LOW: Flags = Flags(bindings::IRQF_TRIGGER_LOW as u64);
+
+/// Allow sharing the irq among several devices.
+pub const SHARED: Flags = Flags(bindings::IRQF_SHARED as u64);
+
+/// Set by callers when they expect sharing mismatches to occur.
+pub const PROBE_SHARED: Flags = Flags(bindings::IRQF_PROBE_SHARED as u64);
+
+/// Flag to mark this interrupt as timer interrupt.
+pub const TIMER: Flags = Flags(bindings::IRQF_TIMER as u64);
+
+/// Interrupt is per cpu.
+pub const PERCPU: Flags = Flags(bindings::IRQF_PERCPU as u64);
+
+/// Flag to exclude this interrupt from irq balancing.
+pub const NOBALANCING: Flags = Flags(bindings::IRQF_NOBALANCING as u64);
+
+/// Interrupt is used for polling (only the interrupt that is registered
+/// first in a shared interrupt is considered for performance reasons).
+pub const IRQPOLL: Flags = Flags(bindings::IRQF_IRQPOLL as u64);
+
+/// Interrupt is not reenabled after the hardirq handler finished. Used by
+/// threaded interrupts which need to keep the irq line disabled until the
+/// threaded handler has been run.
+pub const ONESHOT: Flags = Flags(bindings::IRQF_ONESHOT as u64);
+
+/// Do not disable this IRQ during suspend. Does not guarantee that this
+/// interrupt will wake the system from a suspended state.
+pub const NO_SUSPEND: Flags = Flags(bindings::IRQF_NO_SUSPEND as u64);
+
+/// Force enable it on resume even if [`NO_SUSPEND`] is set.
+pub const FORCE_RESUME: Flags = Flags(bindings::IRQF_FORCE_RESUME as u64);
+
+/// Interrupt cannot be threaded.
+pub const NO_THREAD: Flags = Flags(bindings::IRQF_NO_THREAD as u64);
+
+/// Resume IRQ early during syscore instead of at device resume time.
+pub const EARLY_RESUME: Flags = Flags(bindings::IRQF_EARLY_RESUME as u64);
+
+/// If the IRQ is shared with a [`NO_SUSPEND`] user, execute this interrupt
+/// handler after suspending interrupts. For system wakeup devices users
+/// need to implement wakeup detection in their interrupt handlers.
+pub const COND_SUSPEND: Flags = Flags(bindings::IRQF_COND_SUSPEND as u64);
+
+/// Don't enable IRQ or NMI automatically when users request it. Users will
+/// enable it explicitly by `enable_irq` or `enable_nmi` later.
+pub const NO_AUTOEN: Flags = Flags(bindings::IRQF_NO_AUTOEN as u64);
+
+/// Exclude from runnaway detection for IPI and similar handlers, depends on
+/// `PERCPU`.
+pub const NO_DEBUG: Flags = Flags(bindings::IRQF_NO_DEBUG as u64);

-- 
2.50.0


