Return-Path: <linux-pci+bounces-25751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D28E5A87303
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 19:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E8D188DAB3
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED791F3BAB;
	Sun, 13 Apr 2025 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSpehm4j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1B41A0711;
	Sun, 13 Apr 2025 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744565890; cv=none; b=WzxkP87hCKd53N387tzbmWJo3y34G6IMsn/1G/q0ja6VdTi+6lnM86bZThL9swvOMOxd5i83ljgPQ1T9mCB8IoBz6aifVmIF+0fj0rD4p1QVa6aCXwvrlX0YIIOH5AGvCaNOc4MrVMRzPSqIk21WXpMoRk7cgwoNTDwvqpZdB9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744565890; c=relaxed/simple;
	bh=Lp95DzubEoanpikgjlhKpvhsatoB28z6K99cNgw02kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isrERo8E9Yh0yYNOSYORoncIKDAoWDbbnrY/CnbDPrB0ojc+SUSXiPVuHhhc0YWCvlTMn+BNiFQgI14gNN9NElawoyiRIZK8OxHkC4EN3UrWAOCqGxHzJmo+JN8js6Sldk+I9eD8SYWLRsuiWdRY7PBudrktEVVnDGVvGbIw29I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSpehm4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F65C4CEEC;
	Sun, 13 Apr 2025 17:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744565889;
	bh=Lp95DzubEoanpikgjlhKpvhsatoB28z6K99cNgw02kE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HSpehm4jXfYAIeWh1yAB4yRcxihPnRgbeqpUza2oB14Y5bLbvjjBIErCJq8cvbHFs
	 HWGejaIjT1Xhr1AGK8UJFDCETlDztxYPC+rTcJfqAchKI8oUsObfYNyptqy7SvUdRc
	 Toa3N9I8faIPJrio1GgkJ2LYwZuW9yCqo5m2xnZ/wubfrRuj04WL73fCAPATw1qgIZ
	 r9izjrgP8tS1YdqXfBTcRNvPRYg+V81fQ6i7bamsJsODpRQDhSmie/2npDXQJPXgCy
	 8RyZIcf0kjZXRJ8r6mbFnGYpbYbeXFixcMwuPw09Z5RiC95Yrv1bZSPzAmSo9ySmN8
	 ztZBoXG+xWyqA==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	kwilczynski@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	abdiel.janulgue@gmail.com
Cc: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	robin.murphy@arm.com,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 1/9] rust: device: implement impl_device_context_deref!
Date: Sun, 13 Apr 2025 19:36:56 +0200
Message-ID: <20250413173758.12068-2-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413173758.12068-1-dakr@kernel.org>
References: <20250413173758.12068-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Deref hierarchy for device context generics is the same for every
(bus specific) device.

Implement those with a generic macro to avoid duplicated boiler plate
code and ensure the correct Deref hierarchy for every device
implementation.

Co-developed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs   | 44 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/pci.rs      | 16 +++------------
 rust/kernel/platform.rs | 17 +++-------------
 3 files changed, 50 insertions(+), 27 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 21b343a1dc4d..7cb6f0fc005d 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -235,6 +235,50 @@ impl Sealed for super::Normal {}
 impl DeviceContext for Core {}
 impl DeviceContext for Normal {}
 
+/// # Safety
+///
+/// The type given as `$device` must be a transparent wrapper of a type that doesn't depend on the
+/// generic argument of `$device`.
+#[doc(hidden)]
+#[macro_export]
+macro_rules! __impl_device_context_deref {
+    (unsafe { $device:ident, $src:ty => $dst:ty }) => {
+        impl ::core::ops::Deref for $device<$src> {
+            type Target = $device<$dst>;
+
+            fn deref(&self) -> &Self::Target {
+                let ptr: *const Self = self;
+
+                // CAST: `$device<$src>` and `$device<$dst>` transparently wrap the same type by the
+                // safety requirement of the macro.
+                let ptr = ptr.cast::<Self::Target>();
+
+                // SAFETY: `ptr` was derived from `&self`.
+                unsafe { &*ptr }
+            }
+        }
+    };
+}
+
+/// Implement [`core::ops::Deref`] traits for allowed [`DeviceContext`] conversions of a (bus
+/// specific) device.
+///
+/// # Safety
+///
+/// The type given as `$device` must be a transparent wrapper of a type that doesn't depend on the
+/// generic argument of `$device`.
+#[macro_export]
+macro_rules! impl_device_context_deref {
+    (unsafe { $device:ident }) => {
+        // SAFETY: This macro has the exact same safety requirement as
+        // `__impl_device_context_deref!`.
+        kernel::__impl_device_context_deref!(unsafe {
+            $device,
+            $crate::device::Core => $crate::device::Normal
+        });
+    };
+}
+
 #[doc(hidden)]
 #[macro_export]
 macro_rules! dev_printk {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index c97d6d470b28..8474608e7a90 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -422,19 +422,9 @@ pub fn set_master(&self) {
     }
 }
 
-impl Deref for Device<device::Core> {
-    type Target = Device;
-
-    fn deref(&self) -> &Self::Target {
-        let ptr: *const Self = self;
-
-        // CAST: `Device<Ctx>` is a transparent wrapper of `Opaque<bindings::pci_dev>`.
-        let ptr = ptr.cast::<Device>();
-
-        // SAFETY: `ptr` was derived from `&self`.
-        unsafe { &*ptr }
-    }
-}
+// SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
+// argument.
+kernel::impl_device_context_deref!(unsafe { Device });
 
 impl From<&Device<device::Core>> for ARef<Device> {
     fn from(dev: &Device<device::Core>) -> Self {
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 4917cb34e2fe..22590bdff7bb 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -16,7 +16,6 @@
 
 use core::{
     marker::PhantomData,
-    ops::Deref,
     ptr::{addr_of_mut, NonNull},
 };
 
@@ -190,19 +189,9 @@ fn as_raw(&self) -> *mut bindings::platform_device {
     }
 }
 
-impl Deref for Device<device::Core> {
-    type Target = Device;
-
-    fn deref(&self) -> &Self::Target {
-        let ptr: *const Self = self;
-
-        // CAST: `Device<Ctx>` is a transparent wrapper of `Opaque<bindings::platform_device>`.
-        let ptr = ptr.cast::<Device>();
-
-        // SAFETY: `ptr` was derived from `&self`.
-        unsafe { &*ptr }
-    }
-}
+// SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
+// argument.
+kernel::impl_device_context_deref!(unsafe { Device });
 
 impl From<&Device<device::Core>> for ARef<Device> {
     fn from(dev: &Device<device::Core>) -> Self {
-- 
2.49.0


