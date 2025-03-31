Return-Path: <linux-pci+bounces-25018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B16A76F44
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 22:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF32188D322
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 20:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A5521C188;
	Mon, 31 Mar 2025 20:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmIje9AY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C62821B9D1;
	Mon, 31 Mar 2025 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452934; cv=none; b=oZz1k8sr2Ly4/u258cCEP8FODTFF63bKxraB9TMEnwmrK/HjMyXJqfgogaK4Fp95WwdzSu70Tb9Hf2wooHzhOmrpDug+sV4dGDTfWfcVcIFho61SWlu4RxiCiI71+uW1nQoFOldPl0YNqZWesVKkoPTquP+gAhkS1JGIhxv1VLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452934; c=relaxed/simple;
	bh=YtAeePVBbSHdITuUrszzto4t2A2eShloNRdKMMuxwuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JA9WAxSzdziqVA7S58PGUADWviGkW5sjR3oxJJbaiBw9SK1mwnsVj9dwfRAaSn4dk3rs1HvkDOUnV18AUZkbGy+SNTskZjPFsBLfUzfXqrzaa02I1m95RO2pikGVkF3AXVPynPo0w4ieimtMnBgFcq8toKTWys0/mYfBnM0KnDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmIje9AY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58CEC4CEE5;
	Mon, 31 Mar 2025 20:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743452933;
	bh=YtAeePVBbSHdITuUrszzto4t2A2eShloNRdKMMuxwuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AmIje9AYESzfS4539CMNdY4OTlfZ3CgR9MThTKrMIsb3g00LVmBOD60EM79vzpfnD
	 9rbmRbMx5+pvJ2u9Xf6whbfCior//uiQ44IRMhIrxPEQZQSNBZs1/zwQNjuV8+t3F9
	 BOYSAoP09cKXgNzECVdgS5O/8DaIb4Ml24UGaFvcB1zR8i433CsAV4bmkkdKkD0Q5C
	 QdGK3UkJT7LwQQxX4Fq2PG/VGaOUs3QQWf/B/7ZRV5LZRM2KUyDN+G8Y0cPOf+llFJ
	 9DoHmNt3+MDxANmZJPQPEtAr0NvY1LRusxJ59iNIPGpceZjF5O+J+Xy2l3Jc34x397
	 uXMY3cuXFA8yg==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
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
Subject: [PATCH 1/9] rust: device: implement impl_device_context_deref!
Date: Mon, 31 Mar 2025 22:27:54 +0200
Message-ID: <20250331202805.338468-2-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331202805.338468-1-dakr@kernel.org>
References: <20250331202805.338468-1-dakr@kernel.org>
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

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs   | 29 +++++++++++++++++++++++++++++
 rust/kernel/pci.rs      | 14 +-------------
 rust/kernel/platform.rs | 15 +--------------
 3 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 21b343a1dc4d..e3ab8980270e 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -235,6 +235,35 @@ impl Sealed for super::Normal {}
 impl DeviceContext for Core {}
 impl DeviceContext for Normal {}
 
+#[doc(hidden)]
+#[macro_export]
+macro_rules! __impl_device_context_deref {
+    ($src:ty, $dst:ty, $device:tt) => {
+        impl core::ops::Deref for $device<$src> {
+            type Target = $device<$dst>;
+
+            fn deref(&self) -> &Self::Target {
+                let ptr: *const Self = self;
+
+                // CAST: `Device<Ctx: DeviceContext>` types are transparent to each other.
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
+#[macro_export]
+macro_rules! impl_device_context_deref {
+    ($device:tt) => {
+        kernel::__impl_device_context_deref!($crate::device::Core, $crate::device::Normal, $device);
+    };
+}
+
 #[doc(hidden)]
 #[macro_export]
 macro_rules! dev_printk {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index c97d6d470b28..0e735409bfc4 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -422,19 +422,7 @@ pub fn set_master(&self) {
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
+kernel::impl_device_context_deref!(Device);
 
 impl From<&Device<device::Core>> for ARef<Device> {
     fn from(dev: &Device<device::Core>) -> Self {
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 4917cb34e2fe..9268e1edca9b 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -16,7 +16,6 @@
 
 use core::{
     marker::PhantomData,
-    ops::Deref,
     ptr::{addr_of_mut, NonNull},
 };
 
@@ -190,19 +189,7 @@ fn as_raw(&self) -> *mut bindings::platform_device {
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
+kernel::impl_device_context_deref!(Device);
 
 impl From<&Device<device::Core>> for ARef<Device> {
     fn from(dev: &Device<device::Core>) -> Self {
-- 
2.49.0


