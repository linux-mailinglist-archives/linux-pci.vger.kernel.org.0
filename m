Return-Path: <linux-pci+bounces-30304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DBDAE2BE2
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 21:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C1B3B6300
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 19:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4E127056E;
	Sat, 21 Jun 2025 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLJNMWFh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CE427056D;
	Sat, 21 Jun 2025 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750535505; cv=none; b=REB8w9pMzVZpJzboZ2q94IvPGaXGpFY2CQS9i9aEZud8h2FiH4Flx40QqbIelOWCeX8PPUYfem/xFQ75c/xsh57V2MK/4u5jqNVqqfzqZLI11fxn8q7GALllFex1PBnUb5SOX22PkyNTbgV+Vv97xjf6AYq4OijQHHrYEGBAbmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750535505; c=relaxed/simple;
	bh=o1NrCTqKOLaLyCyMx28sXtEauIeDFKCQj+3OLoj5FnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3GVO8Oh5x9JSZMic1KSmBOyIim/wnka1ePucBwQu+5OQMfFzGm1VHtINYXgLWqlVR3GVtkS3mdsdfS6YZe35RSDZqorx55+OcDBs4etiotsfe0Gd3upk8VyXbfm7Q/zCuxbVMo6KGSCHeFAfvvWtK9wKeYwOMDShKyrreO4I5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLJNMWFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA9BC4CEE7;
	Sat, 21 Jun 2025 19:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750535505;
	bh=o1NrCTqKOLaLyCyMx28sXtEauIeDFKCQj+3OLoj5FnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZLJNMWFhH1IC/AZMKYFp/cjcYO5RYN+pG5sN4ZnyCHyUyHLP+7OYy0ynXNyt8uSmZ
	 wfMoIKlomph/K0PwwyqGGPNa1EkR9nPWMvvKsoGMlzxWZ5H4xp+thExhCLrTf5/iaS
	 8vok5bSb92Nn3jqEV7turYM6K0OAa7Z1vk6oE+PNb3Ml3sUMk15UB+MqR7+6w+I0pt
	 Sj/PQOzSqd06euSR/ZlxZ9eiVUttELyk5OgUgKTbnD19Z3F9w7C0gvuk8GCUbyi/4S
	 N9u1FHAnxdSfBAz7kEvKWILV5qUQ8WHY7PzVc6k1VoQQWu/QtorbDkbUp4FtxO0neR
	 VPXgwT01t5nxA==
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
Subject: [PATCH 4/8] rust: pci: use generic device drvdata accessors
Date: Sat, 21 Jun 2025 21:43:30 +0200
Message-ID: <20250621195118.124245-5-dakr@kernel.org>
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
 rust/helpers/pci.c | 10 ----------
 rust/kernel/pci.rs | 31 ++++++++++++++-----------------
 2 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index cd0e6bf2cc4d..ef9cb38c81a6 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -2,16 +2,6 @@
 
 #include <linux/pci.h>
 
-void rust_helper_pci_set_drvdata(struct pci_dev *pdev, void *data)
-{
-	pci_set_drvdata(pdev, data);
-}
-
-void *rust_helper_pci_get_drvdata(struct pci_dev *pdev)
-{
-	return pci_get_drvdata(pdev);
-}
-
 resource_size_t rust_helper_pci_resource_len(struct pci_dev *pdev, int bar)
 {
 	return pci_resource_len(pdev, bar);
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 8435f8132e38..064e74a90904 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -10,11 +10,11 @@
     device_id::RawDeviceId,
     devres::Devres,
     driver,
-    error::{to_result, Result},
+    error::{from_result, to_result, Result},
     io::Io,
     io::IoRaw,
     str::CStr,
-    types::{ARef, ForeignOwnable, Opaque},
+    types::{ARef, Opaque},
     ThisModule,
 };
 use core::{
@@ -66,35 +66,32 @@ extern "C" fn probe_callback(
         // `struct pci_dev`.
         //
         // INVARIANT: `pdev` is valid for the duration of `probe_callback()`.
-        let pdev = unsafe { &*pdev.cast::<Device<device::Core>>() };
+        let pdev = unsafe { &*pdev.cast::<Device<device::Internal>>() };
 
         // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct pci_device_id` and
         // does not add additional invariants, so it's safe to transmute.
         let id = unsafe { &*id.cast::<DeviceId>() };
         let info = T::ID_TABLE.info(id.index());
 
-        match T::probe(pdev, info) {
-            Ok(data) => {
-                // Let the `struct pci_dev` own a reference of the driver's private data.
-                // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
-                // `struct pci_dev`.
-                unsafe { bindings::pci_set_drvdata(pdev.as_raw(), data.into_foreign() as _) };
-            }
-            Err(err) => return Error::to_errno(err),
-        }
+        from_result(|| {
+            let data = T::probe(pdev, info)?;
 
-        0
+            pdev.as_ref().set_drvdata(data);
+            Ok(0)
+        })
     }
 
     extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
         // SAFETY: The PCI bus only ever calls the remove callback with a valid pointer to a
         // `struct pci_dev`.
-        let ptr = unsafe { bindings::pci_get_drvdata(pdev) }.cast();
+        //
+        // INVARIANT: `pdev` is valid for the duration of `remove_callback()`.
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


