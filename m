Return-Path: <linux-pci+bounces-30305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB04AE2BE3
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 21:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9C03AC80B
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 19:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BB7270EBB;
	Sat, 21 Jun 2025 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8Gce29k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951E6270EAA;
	Sat, 21 Jun 2025 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750535509; cv=none; b=Fh5uARy8Iv//2U+qJUADVeQnpIDIQyrHF4/b4Arf8FZvsl4hYi/ULCu7PnxeGP4/dDnjJ63hTlLStbT7p05JGHzRdexTe/5u97+4C3zEZ599oUHksnl83293bqw4zp/TcQ+iyTMxC+Pjkj4ksS3/30IMdcfGWdB2942xb8uTCLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750535509; c=relaxed/simple;
	bh=mM3PxOtUthJ3GpHeqpRPkpyqXw2y9hSUkmakMzIVsuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qm85ZbvcKId8AA7bgtkm35luBwyqO8zH5YWeSxWgERZcEm4f3OdcPeBoQTULk1XQr0oWdS2FrKbforX7d3G/C0tv3mMrxV4x729md0BHnc4yR8hZ7GQiKYI43ms7IpeY9pca6hdymZjlrwFLjahEZk/1vASiD7SsucWWEMTRbU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8Gce29k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984C3C4CEEF;
	Sat, 21 Jun 2025 19:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750535509;
	bh=mM3PxOtUthJ3GpHeqpRPkpyqXw2y9hSUkmakMzIVsuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I8Gce29k2Xe7ufysDGxaGpD+is6WimD/iLkCKTOTxiMyt4ctsXcx4KdhchiUDebi+
	 UhsS/QHqveQqmWR6qMwRO7bOsLtA0BOyUZ/fGi8sa+g9egext0skh2LtYrwCl23eWE
	 tDX9HcmpSutp4mwCclbVQoLoN8nRlKqA1EsNKnSdy+uea+yh5Zwg04NzcLpLwCLvqs
	 +R2GY/ClxnMkKCXcax4oB5uq6nUo9SQqRrTxw5vboN4dGyIACur1LXtsv+zboGX9+B
	 YXznmm5CpsAQlEiPpT/FJIFnWy/t0YIejZa0CSRa3gpd58bUYCdgnYz2yJgvxufXd7
	 b9DVIOBnuEGWg==
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
Subject: [PATCH 5/8] rust: auxiliary: use generic device drvdata accessors
Date: Sat, 21 Jun 2025 21:43:31 +0200
Message-ID: <20250621195118.124245-6-dakr@kernel.org>
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
 rust/helpers/auxiliary.c | 10 ----------
 rust/kernel/auxiliary.rs | 35 +++++++++++++++--------------------
 2 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/rust/helpers/auxiliary.c b/rust/helpers/auxiliary.c
index 0db3860d774e..8b5e0fea4493 100644
--- a/rust/helpers/auxiliary.c
+++ b/rust/helpers/auxiliary.c
@@ -2,16 +2,6 @@
 
 #include <linux/auxiliary_bus.h>
 
-void rust_helper_auxiliary_set_drvdata(struct auxiliary_device *adev, void *data)
-{
-	auxiliary_set_drvdata(adev, data);
-}
-
-void *rust_helper_auxiliary_get_drvdata(struct auxiliary_device *adev)
-{
-	return auxiliary_get_drvdata(adev);
-}
-
 void rust_helper_auxiliary_device_uninit(struct auxiliary_device *adev)
 {
 	return auxiliary_device_uninit(adev);
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index d2cfe1eeefb6..250d3178c334 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -8,10 +8,10 @@
     bindings, container_of, device,
     device_id::RawDeviceId,
     driver,
-    error::{to_result, Result},
+    error::{from_result, to_result, Result},
     prelude::*,
     str::CStr,
-    types::{ForeignOwnable, Opaque},
+    types::Opaque,
     ThisModule,
 };
 use core::{
@@ -61,37 +61,32 @@ extern "C" fn probe_callback(
         // `struct auxiliary_device`.
         //
         // INVARIANT: `adev` is valid for the duration of `probe_callback()`.
-        let adev = unsafe { &*adev.cast::<Device<device::Core>>() };
+        let adev = unsafe { &*adev.cast::<Device<device::Internal>>() };
 
         // SAFETY: `DeviceId` is a `#[repr(transparent)`] wrapper of `struct auxiliary_device_id`
         // and does not add additional invariants, so it's safe to transmute.
         let id = unsafe { &*id.cast::<DeviceId>() };
         let info = T::ID_TABLE.info(id.index());
 
-        match T::probe(adev, info) {
-            Ok(data) => {
-                // Let the `struct auxiliary_device` own a reference of the driver's private data.
-                // SAFETY: By the type invariant `adev.as_raw` returns a valid pointer to a
-                // `struct auxiliary_device`.
-                unsafe {
-                    bindings::auxiliary_set_drvdata(adev.as_raw(), data.into_foreign().cast())
-                };
-            }
-            Err(err) => return Error::to_errno(err),
-        }
+        from_result(|| {
+            let data = T::probe(adev, info)?;
 
-        0
+            adev.as_ref().set_drvdata(data);
+            Ok(0)
+        })
     }
 
     extern "C" fn remove_callback(adev: *mut bindings::auxiliary_device) {
-        // SAFETY: The auxiliary bus only ever calls the remove callback with a valid pointer to a
+        // SAFETY: The auxiliary bus only ever calls the probe callback with a valid pointer to a
         // `struct auxiliary_device`.
-        let ptr = unsafe { bindings::auxiliary_get_drvdata(adev) };
+        //
+        // INVARIANT: `adev` is valid for the duration of `probe_callback()`.
+        let adev = unsafe { &*adev.cast::<Device<device::Internal>>() };
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
-        // `probe_callback`, hence it's guaranteed that `ptr` points to a valid and initialized
-        // `KBox<T>` pointer created through `KBox::into_foreign`.
-        drop(unsafe { KBox::<T>::from_foreign(ptr.cast()) });
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `Pin<KBox<T>>`.
+        drop(unsafe { adev.as_ref().drvdata_obtain::<Pin<KBox<T>>>() });
     }
 }
 
-- 
2.49.0


