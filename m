Return-Path: <linux-pci+bounces-29175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF5AAD1566
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 00:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F9F3A7805
	for <lists+linux-pci@lfdr.de>; Sun,  8 Jun 2025 22:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F28220A5DD;
	Sun,  8 Jun 2025 22:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="iL1MAuDB"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E181C8603;
	Sun,  8 Jun 2025 22:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749423435; cv=pass; b=TlLpoFRQHPuy5XHz5+ZR11rA2Lpr+9BJfR9xTdsAlnexORJ6HSLKghd5Q887wauj2vwswRcB2cCDvs/DoowvahQP8k4W8YTtEScwDTtl4c3H0PsswSWq60WPfzKMF1MJj0SeT8XyNXS9MNa2yvhhgg4pyfbjLOi71eV3x7kMLGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749423435; c=relaxed/simple;
	bh=D+CyuytDee/7x+SzsS6MCMBXXMo7QSX9uKrPnark6LQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kguma+uG3yE0mQEKQUIliTREvl89GBKL2Lth89P7DQMFWWfAEcDUooQkkxVkdgUEkSE+x69b/7+oL5g1+k6ZQH9h/vJ3OQsAJs6WKV3al2lq7a1DgrKWYOA/Vq0mq0AN9WfZL3WEgjS0MhgE6bpd4bzQeDvWseMTBqvPG328JH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=iL1MAuDB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749423413; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bz5xBYKQmcUpuvQ4e295VeLqRYMKfms8w8eGr9zgD6WUZiH4FiRh1SStVZbQQK22TjRHV/yeNXrTyn45F8XcRP4obp3Y7r7EhgCJm4KL8mikoivhySgi+rEIeXOKCbjufIRUiLwEPO+ZO8Iz9z3wtC/adGyyYv0zn4WyHPhfCME=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749423413; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OvbJmosZb6mPGinMPs6gOBBNcXp1JW4POuqGZZfMR84=; 
	b=DxBK5/sDMmWWIiS7vH8Gxrcv6QUeTU31udTYHLdo1PdMHm24wUQ8fYo6GnIQMPDA54po6Ec3aWka/z1LGB2vOtgWvWdWuf4OhXTYKgLi7YEeCozpSS/ydgs8LuqyQEyJqj347r9vopOqfrQhqFRj0qfORdueICyVMFWU1f9HU7o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749423413;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=OvbJmosZb6mPGinMPs6gOBBNcXp1JW4POuqGZZfMR84=;
	b=iL1MAuDB7zHMK7fj08pXn0ZIMnuynJ6nPF1fmNYwFhMB2kzLJoN9PCRuTVP67QJw
	o9MpDMCRI14n21mhqZw63acsTgduvPZXGwlcCG628bhcjoUgdzhFogYNCEvhMq/ed3s
	CsU1YGpBZaeKXKlHrg3aINDxUuWYHFksgs1jZBYo=
Received: by mx.zohomail.com with SMTPS id 17494234115054.640567995217907;
	Sun, 8 Jun 2025 15:56:51 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Sun, 08 Jun 2025 19:51:07 -0300
Subject: [PATCH v4 2/6] rust: irq: add flags module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250608-topics-tyr-request_irq-v4-2-81cb81fb8073@collabora.com>
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
In-Reply-To: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
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
2.49.0


