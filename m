Return-Path: <linux-pci+bounces-25019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C55CA76F45
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 22:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C02016B3A1
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 20:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C5E21C9FF;
	Mon, 31 Mar 2025 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEJGvFVW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01D521B9DC;
	Mon, 31 Mar 2025 20:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452938; cv=none; b=oDyEQo7PjvRPohdgPuGxTTBu2hxDjB8IjQwJYJT/SU8LY0YRerunjC8vVEry+dZYDDprtdRiwnPPniTrc3U38A8detyazlhZQkbzce1kHU5ReL/5iLmVGuIvyn098MVUBuAk0T7SQ9JCId+24O7B+b7cVMFn8A0278DG1k7V+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452938; c=relaxed/simple;
	bh=E8LvxAEPSE3C1ltgikB5ignndFPecSrN9rb0pMCJ7ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndIl/Bro2ysQboNH+F1sO4FPa+vJvNfjfkQoQTJzSStU9e/nltCj0mIAfHKUewMc3P6aD6MdihY7bQGslEPIA3OvAp6YLnCrbizvfCNEEzLlU7LO6102NRPFoi50wfQk6WTWE8PyehOpJ3DifC2TAnpL6iFUq/lUcbCGoV5B0rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEJGvFVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4E4C4CEED;
	Mon, 31 Mar 2025 20:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743452937;
	bh=E8LvxAEPSE3C1ltgikB5ignndFPecSrN9rb0pMCJ7ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pEJGvFVWkUIYq7gvPiP2/39DUdzWlVXPB65bfUy8K9T1eG5OiKu9fcYN+EHpT2YQJ
	 ZXksRN/D48IWVTWsiOrxMposIWC2kucl8aLMmKl4tbLhSXeTA0N5H18iucmVEGnXR0
	 so6QvsRg2tjQA9KSDotB4bEniU4rl1k8VwLG8gHJCtzND7HzNZNeoi0gg1P/mv3hv5
	 qdB6/wI6gGeSTuMiiU1VvhGGxtXQhBkkIe2GgpXsWRmo0uS8mJBv4GpAOgc8iIDIKO
	 pzzQbNbwe/3/dAtDr/D9YW7Y0gC8wHVssOxpTViTgG9PdOkeW4Hb1UA/0Ru3VdUexq
	 BrGugvfe3ltgw==
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
Subject: [PATCH 2/9] rust: device: implement impl_device_context_into_aref!
Date: Mon, 31 Mar 2025 22:27:55 +0200
Message-ID: <20250331202805.338468-3-dakr@kernel.org>
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

Implement a macro to implement all From conversions of a certain device
to ARef<Device>.

This avoids unnecessary boiler plate code for every device
implementation.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs   | 21 +++++++++++++++++++++
 rust/kernel/pci.rs      |  7 +------
 rust/kernel/platform.rs |  9 ++-------
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index e3ab8980270e..68652ba62b02 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -264,6 +264,27 @@ macro_rules! impl_device_context_deref {
     };
 }
 
+#[doc(hidden)]
+#[macro_export]
+macro_rules! __impl_device_context_into_aref {
+    ($src:ty, $device:tt) => {
+        impl core::convert::From<&$device<$src>> for $crate::types::ARef<$device> {
+            fn from(dev: &$device<$src>) -> Self {
+                (&**dev).into()
+            }
+        }
+    };
+}
+
+/// Implement [`core::convert::From`], such that all `&Device<Ctx>` can be converted to an
+/// `ARef<Device>`.
+#[macro_export]
+macro_rules! impl_device_context_into_aref {
+    ($device:tt) => {
+        kernel::__impl_device_context_into_aref!($crate::device::Core, $device);
+    };
+}
+
 #[doc(hidden)]
 #[macro_export]
 macro_rules! dev_printk {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 0e735409bfc4..e235aa23c63a 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -423,12 +423,7 @@ pub fn set_master(&self) {
 }
 
 kernel::impl_device_context_deref!(Device);
-
-impl From<&Device<device::Core>> for ARef<Device> {
-    fn from(dev: &Device<device::Core>) -> Self {
-        (&**dev).into()
-    }
-}
+kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
 unsafe impl crate::types::AlwaysRefCounted for Device {
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 9268e1edca9b..9133490ea4c9 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -10,7 +10,7 @@
     of,
     prelude::*,
     str::CStr,
-    types::{ARef, ForeignOwnable, Opaque},
+    types::{ForeignOwnable, Opaque},
     ThisModule,
 };
 
@@ -190,12 +190,7 @@ fn as_raw(&self) -> *mut bindings::platform_device {
 }
 
 kernel::impl_device_context_deref!(Device);
-
-impl From<&Device<device::Core>> for ARef<Device> {
-    fn from(dev: &Device<device::Core>) -> Self {
-        (&**dev).into()
-    }
-}
+kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
 unsafe impl crate::types::AlwaysRefCounted for Device {
-- 
2.49.0


