Return-Path: <linux-pci+bounces-30302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 664E4AE2BDC
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 21:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143D41898CD4
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 19:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CA826A0E3;
	Sat, 21 Jun 2025 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qY7VFCX/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5D6253F2C;
	Sat, 21 Jun 2025 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750535497; cv=none; b=NC5VxYhPgHE3A6HmjPfuiH0q8hM3W206Xthb58nPSifrCZtixReM+1tmg2fKL2zDv5u0VAaqCMC7DBZq1Q58UUsPdTwJohEFHozT0A5XZhMfcvt0EyehOhvqIIVyJ23lRSk8Y2j+Ww5E4XwJchGv0Q0AHus9J89cgj4NEyWNw6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750535497; c=relaxed/simple;
	bh=YHLg1VTNOxaRSyhsBjrCYNRgQ+pK9YBYD8hTsccsNsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgEHlPkecYBEpUk8KXPoMbZTsN7shsb4+RywwCY7MT6DLmHhhGxPaePYnox+mYNcHh3RMpzO9/tyiXmYGBUiyc5JYsLRUVkB7YO4jBfC+rpBL79hvW3T4lXY/IMWkTjSfnO7YppCxxcG+hRg9lngh2bEi6EB5qdwXP/IMCHfSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qY7VFCX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD986C4CEE7;
	Sat, 21 Jun 2025 19:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750535496;
	bh=YHLg1VTNOxaRSyhsBjrCYNRgQ+pK9YBYD8hTsccsNsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qY7VFCX/W4HfmbJ5ws7CF3ynLLx/ICx0MNP4LhvXZiPAj9UzLiwDi8atnPGnGiUsP
	 4Vi230AzK6ORztPoMWwVIVBHPUl7EIf4tA2tZVBaoWSSryj08fyrcSev/ArWtZaNKh
	 UimiXPhz7Zx9S5len76VVUbvwQt17SyJpEStoo7CykRI6D1DN3P8RWfmBFZZuVygGC
	 A4IoM8B7rSW14Axb2MYo1qG6BglEYCjn3edZGNT3y6zf6XEJXrRNIBKKDEWdE6xj8T
	 MB/DJ6+0SCgKbwai+L3Dma59wZRrDbsUcXM0yhQFmuiWna9v1GUFS/1OT3uW1thIKQ
	 yjLEMtdKQFMxw==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/8] rust: device: add drvdata accessors
Date: Sat, 21 Jun 2025 21:43:28 +0200
Message-ID: <20250621195118.124245-3-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250621195118.124245-1-dakr@kernel.org>
References: <20250621195118.124245-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement generic accessors for the private data of a driver bound to a
device.

Those accessors should be used by bus abstractions from their
corresponding core callbacks, such as probe(), remove(), etc.

Implementing them for device::Internal guarantees that driver's can't
interfere with the logic implemented by the bus abstraction.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/device.c | 10 ++++++++++
 rust/kernel/device.rs | 43 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/rust/helpers/device.c b/rust/helpers/device.c
index b2135c6686b0..9bf252649c75 100644
--- a/rust/helpers/device.c
+++ b/rust/helpers/device.c
@@ -8,3 +8,13 @@ int rust_helper_devm_add_action(struct device *dev,
 {
 	return devm_add_action(dev, action, data);
 }
+
+void *rust_helper_dev_get_drvdata(const struct device *dev)
+{
+	return dev_get_drvdata(dev);
+}
+
+void rust_helper_dev_set_drvdata(struct device *dev, void *data)
+{
+	dev_set_drvdata(dev, data);
+}
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index e9094d8322d5..146eba147d2f 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -6,7 +6,7 @@
 
 use crate::{
     bindings,
-    types::{ARef, Opaque},
+    types::{ARef, ForeignOwnable, Opaque},
 };
 use core::{fmt, marker::PhantomData, ptr};
 
@@ -62,6 +62,47 @@ pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
     }
 }
 
+impl Device<Internal> {
+    /// Store a pointer to the bound driver's private data.
+    pub fn set_drvdata(&self, data: impl ForeignOwnable) {
+        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
+        unsafe { bindings::dev_set_drvdata(self.as_raw(), data.into_foreign().cast()) }
+    }
+
+    /// Take ownership of the private data stored in this [`Device`].
+    ///
+    /// # Safety
+    ///
+    /// - Must only be called once after a preceding call to [`Device::set_drvdata`].
+    /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
+    ///   [`Device::set_drvdata`].
+    pub unsafe fn drvdata_obtain<T: ForeignOwnable>(&self) -> T {
+        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
+        let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
+
+        // SAFETY: By the safety requirements of this function, `ptr` comes from a previous call to
+        // `into_foreign()`.
+        unsafe { T::from_foreign(ptr.cast()) }
+    }
+
+    /// Borrow the driver's private data bound to this [`Device`].
+    ///
+    /// # Safety
+    ///
+    /// - Must only be called after a preceding call to [`Device::set_drvdata`] and before
+    ///   [`Device::drvdata_obtain`].
+    /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
+    ///   [`Device::set_drvdata`].
+    pub unsafe fn drvdata_borrow<T: ForeignOwnable>(&self) -> T::Borrowed<'_> {
+        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
+        let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
+
+        // SAFETY: By the safety requirements of this function, `ptr` comes from a previous call to
+        // `into_foreign()`.
+        unsafe { T::borrow(ptr.cast()) }
+    }
+}
+
 impl<Ctx: DeviceContext> Device<Ctx> {
     /// Obtain the raw `struct device *`.
     pub(crate) fn as_raw(&self) -> *mut bindings::device {
-- 
2.49.0


