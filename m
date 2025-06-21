Return-Path: <linux-pci+bounces-30303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 675FCAE2BDE
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 21:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15DA91898BBB
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 19:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD1926FDBB;
	Sat, 21 Jun 2025 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPIx4PHB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515252701C8;
	Sat, 21 Jun 2025 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750535501; cv=none; b=vEIhOqR4MBpz5Aol7Yp8LaVHsSK+sRjKK1Fj9JiBo8W4WXok/FMLkkctk7KRrZ3Yj3wLyfQ6gjq69iuVxeuE3t3rjId6h4hoCEH2zj3JjzBFs9lB9uIlrca3wOpPRiClEEg4UU31Ok8OPr9xiX2WWyvEjwtscAolaD9QhDQQvD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750535501; c=relaxed/simple;
	bh=64LA9BPdINZxDweXi3XrPvDZBhIiC67sjGS0F3HdOPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbEg1qQaM3BwOu53FHbqekIZElx5fuJ1Sw40LTbR/FKccdOadyASym86tRYqh0iHoCcbSkga0DqhpHbUqb+rEQs/9kQ9/EKuUKKatgBVCIwp/7DNw/yEmb84T7D5H1hQy2i6NkUAQHO5x2B4KUYBgLUnh/fSE6fRvRyE2S0bIdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPIx4PHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0374FC4CEF0;
	Sat, 21 Jun 2025 19:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750535500;
	bh=64LA9BPdINZxDweXi3XrPvDZBhIiC67sjGS0F3HdOPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hPIx4PHBQ9WQfZht+Ufuepc4qS5Roc/26MRLN02aPZzGbw9qYrodi3BjLb0StRPzC
	 NJlj77yt+o9HTMKe2buOjP+U1Wb5ABZFKlND4Cw19YlOjjWfK89jjRy+joD78uzsCt
	 DyeQkN5ol//HC7ZY0lGkOwA7cGG35e8/q38RNQJHOTA46Rclm7crVRvKvFmfMnW58m
	 25lS9K9dxiHVzIG24n4EnSRb/hY4JFm67eif6rRTuJvfgwt9Npcoc8isoBlNri952h
	 ddimMd8GSOGONMB2AkAHvxbkOOcmiqEVdQtr8mfS5BCD+3ImtUrlPEzeRHsYo3AKBJ
	 1pmPkPBy10fEQ==
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
Subject: [PATCH 3/8] rust: platform: use generic device drvdata accessors
Date: Sat, 21 Jun 2025 21:43:29 +0200
Message-ID: <20250621195118.124245-4-dakr@kernel.org>
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

Take advantage of the generic drvdata accessors of the generic Device
type.

While at it, use from_result() instead of match.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/platform.c | 10 ----------
 rust/kernel/platform.rs | 36 +++++++++++++++++-------------------
 2 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/rust/helpers/platform.c b/rust/helpers/platform.c
index 82171233d12f..1ce89c1a36f7 100644
--- a/rust/helpers/platform.c
+++ b/rust/helpers/platform.c
@@ -2,16 +2,6 @@
 
 #include <linux/platform_device.h>
 
-void *rust_helper_platform_get_drvdata(const struct platform_device *pdev)
-{
-	return platform_get_drvdata(pdev);
-}
-
-void rust_helper_platform_set_drvdata(struct platform_device *pdev, void *data)
-{
-	platform_set_drvdata(pdev, data);
-}
-
 bool rust_helper_dev_is_platform(const struct device *dev)
 {
 	return dev_is_platform(dev);
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 5b21fa517e55..dc0c36d70963 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -6,11 +6,11 @@
 
 use crate::{
     bindings, container_of, device, driver,
-    error::{to_result, Result},
+    error::{from_result, to_result, Result},
     of,
     prelude::*,
     str::CStr,
-    types::{ForeignOwnable, Opaque},
+    types::Opaque,
     ThisModule,
 };
 
@@ -61,30 +61,28 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
         // `struct platform_device`.
         //
         // INVARIANT: `pdev` is valid for the duration of `probe_callback()`.
-        let pdev = unsafe { &*pdev.cast::<Device<device::Core>>() };
-
+        let pdev = unsafe { &*pdev.cast::<Device<device::Internal>>() };
         let info = <Self as driver::Adapter>::id_info(pdev.as_ref());
-        match T::probe(pdev, info) {
-            Ok(data) => {
-                // Let the `struct platform_device` own a reference of the driver's private data.
-                // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
-                // `struct platform_device`.
-                unsafe { bindings::platform_set_drvdata(pdev.as_raw(), data.into_foreign() as _) };
-            }
-            Err(err) => return Error::to_errno(err),
-        }
 
-        0
+        from_result(|| {
+            let data = T::probe(pdev, info)?;
+
+            pdev.as_ref().set_drvdata(data);
+            Ok(0)
+        })
     }
 
     extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
-        // SAFETY: `pdev` is a valid pointer to a `struct platform_device`.
-        let ptr = unsafe { bindings::platform_get_drvdata(pdev) }.cast();
+        // SAFETY: The platform bus only ever calls the remove callback with a valid pointer to a
+        // `struct platform_device`.
+        //
+        // INVARIANT: `pdev` is valid for the duration of `probe_callback()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::Internal>>() };
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
-        // `probe_callback`, hence it's guaranteed that `ptr` points to a valid and initialized
-        // `KBox<T>` pointer created through `KBox::into_foreign`.
-        let _ = unsafe { KBox::<T>::from_foreign(ptr) };
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `Pin<KBox<T>>`.
+        let _ = unsafe { pdev.as_ref().drvdata_obtain::<Pin<KBox<T>>>() };
     }
 }
 
-- 
2.49.0


