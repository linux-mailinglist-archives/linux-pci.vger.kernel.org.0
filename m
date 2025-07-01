Return-Path: <linux-pci+bounces-31177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 461A9AEFBDE
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 16:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2E0188F314
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 14:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6507275872;
	Tue,  1 Jul 2025 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnVBHUi8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B36E13C3F2;
	Tue,  1 Jul 2025 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379270; cv=none; b=qYA3O9Vah3IRsNRbRXCYp7Xyjuyvy11c9vW94Dx0aXkqHLIhfHuQ7J7hDy+EkRM15sA2NLR9kqAEQHUNIk5JAYiNzX+QKjmZzkYkr1mbAxsPdukWvZhBUoY/m9oUqsyRCdg9+j8acLmkYvw2UGz53Nq5TQsaryBSZCYx03pKi74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379270; c=relaxed/simple;
	bh=DnWJ47zmIM3CNpSMLuoBSV5JDMZLwDBp7AxfPXYX8eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8QXTRN0WNo+6aeXIwJNZKARjTdoWDsQsIb1Kodd10I5Y6Sm6DOBZmsPp8/00+BHdcz9muJ0qA0V47CwUAoAiUeeL4nlDZGec99r5LIS0j7+ICA9pvzDHgbbYg9Om7PLPCQ9HX0kiR0FPxh3hBaOuX9ePkmCuBh5nKekLdojN20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnVBHUi8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23636167b30so30037875ad.1;
        Tue, 01 Jul 2025 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751379268; x=1751984068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOCKpsUZDZEoNUG++n7K5XV+fKbpAGpkvU6WO6gZ3IM=;
        b=PnVBHUi8gbxmTqKK6Vi6rtitWo7vvZgAbj11jrx1OgFVAOlQln2xoxjdQZt5Jkviik
         ITtIoWsp3txL2MXO7gKUQnBxLCUJboKOwRXaY9Lsf1p00Hbotr8iFvTEyeBHj7sGP50w
         qwwVVAu7HYtkP5vYQHrSqZ8d1zEt7xuatr7S2Zfo9JpLr9dtT7euSkYVHoqVZ7mz85jS
         sKJpsFHqF6G20oJ+pnB2SN3bHgs8otJk8PbowEPhOD6qfxc7vKcMRlqKTFz1pDUBulNr
         N+Hq7LUvdArzE515eIWvdTCndVIdLEPquRcV2KSXMs5k1F5Ns24KEQim6Yz42SEnOI5e
         Wlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751379268; x=1751984068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOCKpsUZDZEoNUG++n7K5XV+fKbpAGpkvU6WO6gZ3IM=;
        b=vHd1VuIsu8dknmX1vv4jOh60XRW3h/Zx+EtzMzw+pdpImlNbEpmzBRLRnMNiaE7xe5
         SMO+NmjAieQ9bhoVfi2D+KXSie3iX6nOatwCSG4cp+aY+z9WafnA9ObjI0PyP5gSv6CW
         BSQgPzCIie2B/hlhMM1cKL/Iv10MT09vlxU3QRSedt2L5rhMe6xTxQDk7vbBHgE2N8+L
         /vnMLF2WYEE9g4v9NAMkfcdj0yU1RM+FrtFQJXCIR3kOjj/1/8Z2fEJCYSLrOjV64huX
         1WRPMkxOPQe4x4wLP7ADhHAZEhdepJXkoyfslBw6kbTDtJwbkBMUszIRk5AsrxuO1R9i
         75nA==
X-Forwarded-Encrypted: i=1; AJvYcCVALlddOvC/WbYyN/Az1vo+XcAQdsOIFlC+ZTsW3OlzjtauAYbWSpzQbAoO5s5hPdyUkeeFylRLhHOZX7jsZ38=@vger.kernel.org, AJvYcCVFMEYZLVv74VssdG09fqessGyh2pc4OJc468JdRUgdcv5xfSIppvBCECwJUSoBYUJ6My21WuRevlqy@vger.kernel.org, AJvYcCVPWXlnhYUbMOI7GPHlJWAEmIKfTTZqm+kSOEas2XMninzr5XCbsoaiJ4kbJ/EtB1LiJN1Ps/o3wdd0@vger.kernel.org, AJvYcCXF+uFak/1zGAPTCQuuwwkp2s8d5DtP7zorq4+3bk6ga7W/aNYJvpSzdt+WNK6PM5MEdMm10YzVPL0cuuft@vger.kernel.org, AJvYcCXd7fyNSIHv4i19Sm71SP2f29hDaGULVguzvOUIQsDOfyGOw7PDRk50seOUPRvwmsCSVGoRUUmv@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm0w6TVk4z92eP/BBEHQL6x0zDIv145lOeyB+go2HIFL5KPLvW
	KZRNi4BEaeD7R+NAWzGTXHTQOE/ASTXHWLObRPwHpBAGFnsbgJbT+IuG
X-Gm-Gg: ASbGnctVhorvphNNlPo875sDJIqOrkVZKi98ijh0kxG+yl7Rnm8jv95ks9Ky4D/xFef
	U/pmVyWc1BERV1JthC+w5u7qA8Ndr/LDMrW9nL73YZm5ukV08juYDQ+jWfiABOxoMZk6mMofFiE
	kWLThG2sIGFJiqaE2yjwkDUCGnrsV22uknOeCPfhuTzraGcDkFTcuRR70BhODGzLY0QMRpRoSA5
	QMOvvJxg/k6oPg4qtNxGsZrqgGkTJOxKvWxsKgmLVSMG9hUj5kvmdaGV7vpK6b/LHxV5P92T8qb
	c/7arAEOWeUodHspbrhFmNNi0C4+gJoqIjOm0DsXqcgRWhZ8HakInwnnBSAc5SuEAvf3qHHQVkv
	JBriw2lcGl6ps+Gj9Oas2kXqlBZF+eoXtwIM=
X-Google-Smtp-Source: AGHT+IFMCaqKWcoT+iQosvdy9MhDIaWNRFN+aa8mzb6/3XLacvz2stzxPzWfOox4CKyORbY+yZ8pcw==
X-Received: by 2002:a17:903:2445:b0:237:f76f:ce21 with SMTP id d9443c01a7336-23ac3deb3a4mr212940675ad.20.1751379267840;
        Tue, 01 Jul 2025 07:14:27 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b8324sm107240885ad.178.2025.07.01.07.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:14:27 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: alex.gaynor@gmail.com,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	rafael@kernel.org,
	robh@kernel.org,
	saravanak@google.com
Cc: a.hindborg@kernel.org,
	aliceryhl@google.com,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	david.m.ertman@intel.com,
	devicetree@vger.kernel.org,
	gary@garyguo.net,
	ira.weiny@intel.com,
	kwilczynski@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lossin@kernel.org,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: [PATCH v2 1/3] rust: device_id: split out index support into a separate trait
Date: Tue,  1 Jul 2025 23:12:50 +0900
Message-ID: <20250701141252.600113-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701141252.600113-1-fujita.tomonori@gmail.com>
References: <20250701141252.600113-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new trait `RawDeviceIdIndex`, which extends `RawDeviceId`
to provide support for device ID types that include an index or
context field (e.g., `driver_data`). This separates the concerns of
layout compatibility and index-based data embedding, and allows
`RawDeviceId` to be implemented for types that do not contain a
`driver_data` field. Several such structures are defined in
include/linux/mod_devicetable.h.

Refactor `IdArray::new()` into a generic `build()` function, which
takes an optional offset. Based on the presence of `RawDeviceIdIndex`,
index writing is conditionally enabled. A new `new_without_index()`
constructor is also provided for use cases where no index should be
written.

This refactoring is a preparation for enabling the PHY abstractions to
use device_id trait.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/auxiliary.rs |  7 +++-
 rust/kernel/device_id.rs | 80 +++++++++++++++++++++++++++++++---------
 rust/kernel/of.rs        | 11 +++++-
 rust/kernel/pci.rs       |  7 +++-
 4 files changed, 81 insertions(+), 24 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index d2cfe1eeefb6..655ed61247d0 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -6,7 +6,7 @@
 
 use crate::{
     bindings, container_of, device,
-    device_id::RawDeviceId,
+    device_id::{RawDeviceId, RawDeviceIdIndex},
     driver,
     error::{to_result, Result},
     prelude::*,
@@ -143,10 +143,13 @@ pub const fn new(modname: &'static CStr, name: &'static CStr) -> Self {
 // SAFETY:
 // * `DeviceId` is a `#[repr(transparent)`] wrapper of `auxiliary_device_id` and does not add
 //   additional invariants, so it's safe to transmute to `RawType`.
-// * `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
 unsafe impl RawDeviceId for DeviceId {
     type RawType = bindings::auxiliary_device_id;
+}
 
+// SAFETY:
+// * `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
+unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize =
         core::mem::offset_of!(bindings::auxiliary_device_id, driver_data);
 
diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index 3dc72ca8cfc2..3bcab2310087 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -24,22 +24,36 @@
 ///     Ideally, this should be achieved using a const function that does conversion instead of
 ///     transmute; however, const trait functions relies on `const_trait_impl` unstable feature,
 ///     which is broken/gone in Rust 1.73.
-///
-///   - `DRIVER_DATA_OFFSET` is the offset of context/data field of the device ID (usually named
-///     `driver_data`) of the device ID, the field is suitable sized to write a `usize` value.
-///
-///     Similar to the previous requirement, the data should ideally be added during `Self` to
-///     `RawType` conversion, but there's currently no way to do it when using traits in const.
 pub unsafe trait RawDeviceId {
     /// The raw type that holds the device id.
     ///
     /// Id tables created from [`Self`] are going to hold this type in its zero-terminated array.
     type RawType: Copy;
+}
 
-    /// The offset to the context/data field.
+/// Extension trait for [`RawDeviceId`] for devices that embed an index or context value.
+///
+/// This is typically used when the device ID struct includes a field like `driver_data`
+/// that is used to store a pointer-sized value (e.g., an index or context pointer).
+///
+/// # Safety
+///
+/// Implementers must ensure that:
+///   - `DRIVER_DATA_OFFSET` is the correct offset (in bytes) to the context/data field (e.g., the
+///     `driver_data` field) within the raw device ID structure. This field must be correctly sized
+///     to hold a `usize`.
+///
+///     Ideally, the data should ideally be added during `Self` to `RawType` conversion,
+///     but there's currently no way to do it when using traits in const.
+///
+///   - The `index` method must return the value stored at the location specified
+///     by `DRIVER_DATA_OFFSET`, assuming `self` is layout-compatible with `RawType`.
+pub unsafe trait RawDeviceIdIndex: RawDeviceId {
+    /// The offset (in bytes) to the context/data field in the raw device ID.
     const DRIVER_DATA_OFFSET: usize;
 
-    /// The index stored at `DRIVER_DATA_OFFSET` of the implementor of the [`RawDeviceId`] trait.
+    /// The index stored at `DRIVER_DATA_OFFSET` of the implementor of the [`RawDeviceIdIndex`]
+    /// trait.
     fn index(&self) -> usize;
 }
 
@@ -68,7 +82,14 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
     /// Creates a new instance of the array.
     ///
     /// The contents are derived from the given identifiers and context information.
-    pub const fn new(ids: [(T, U); N]) -> Self {
+    ///
+    /// # Safety
+    ///
+    /// If `offset` is `Some(offset)`, then:
+    /// - `offset` must be the correct offset (in bytes) to the context/data field
+    ///   (e.g., the `driver_data` field) within the raw device ID structure.
+    /// - The field at `offset` must be correctly sized to hold a `usize`.
+    const unsafe fn build(ids: [(T, U); N], offset: Option<usize>) -> Self {
         let mut raw_ids = [const { MaybeUninit::<T::RawType>::uninit() }; N];
         let mut infos = [const { MaybeUninit::uninit() }; N];
 
@@ -77,14 +98,17 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
             // SAFETY: by the safety requirement of `RawDeviceId`, we're guaranteed that `T` is
             // layout-wise compatible with `RawType`.
             raw_ids[i] = unsafe { core::mem::transmute_copy(&ids[i].0) };
-            // SAFETY: by the safety requirement of `RawDeviceId`, this would be effectively
-            // `raw_ids[i].driver_data = i;`.
-            unsafe {
-                raw_ids[i]
-                    .as_mut_ptr()
-                    .byte_add(T::DRIVER_DATA_OFFSET)
-                    .cast::<usize>()
-                    .write(i);
+
+            if let Some(offset) = offset {
+                // SAFETY: by the safety requirement of this function, this would be effectively
+                // `raw_ids[i].driver_data = i;`.
+                unsafe {
+                    raw_ids[i]
+                        .as_mut_ptr()
+                        .byte_add(offset)
+                        .cast::<usize>()
+                        .write(i);
+                }
             }
 
             // SAFETY: this is effectively a move: `infos[i] = ids[i].1`. We make a copy here but
@@ -92,7 +116,6 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
             infos[i] = MaybeUninit::new(unsafe { core::ptr::read(&ids[i].1) });
             i += 1;
         }
-
         core::mem::forget(ids);
 
         Self {
@@ -109,12 +132,33 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
         }
     }
 
+    /// Creates a new instance of the array without writing index values.
+    ///
+    /// The contents are derived from the given identifiers and context information.
+    pub const fn new_without_index(ids: [(T, U); N]) -> Self {
+        // SAFETY: Calling `Self::build` with `offset = None` is always safe,
+        // because no raw memory writes are performed in this case.
+        unsafe { Self::build(ids, None) }
+    }
+
     /// Reference to the contained [`RawIdArray`].
     pub const fn raw_ids(&self) -> &RawIdArray<T, N> {
         &self.raw_ids
     }
 }
 
+impl<T: RawDeviceId + RawDeviceIdIndex, U, const N: usize> IdArray<T, U, N> {
+    /// Creates a new instance of the array.
+    ///
+    /// The contents are derived from the given identifiers and context information.
+    pub const fn new(ids: [(T, U); N]) -> Self {
+        // SAFETY: by the safety requirement of `RawDeviceIdIndex`,
+        // `T::DRIVER_DATA_OFFSET` is guaranteed to be the correct offset (in bytes) to
+        // a field within `T::RawType`.
+        unsafe { Self::build(ids, Some(T::DRIVER_DATA_OFFSET)) }
+    }
+}
+
 /// A device id table.
 ///
 /// This trait is only implemented by `IdArray`.
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index 40d1bd13682c..c690bceb0d73 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -2,7 +2,11 @@
 
 //! Device Tree / Open Firmware abstractions.
 
-use crate::{bindings, device_id::RawDeviceId, prelude::*};
+use crate::{
+    bindings,
+    device_id::{RawDeviceId, RawDeviceIdIndex},
+    prelude::*,
+};
 
 /// IdTable type for OF drivers.
 pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;
@@ -15,10 +19,13 @@
 // SAFETY:
 // * `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and does not add
 //   additional invariants, so it's safe to transmute to `RawType`.
-// * `DRIVER_DATA_OFFSET` is the offset to the `data` field.
 unsafe impl RawDeviceId for DeviceId {
     type RawType = bindings::of_device_id;
+}
 
+// SAFETY:
+// * `DRIVER_DATA_OFFSET` is the offset to the `data` field.
+unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::of_device_id, data);
 
     fn index(&self) -> usize {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 6b94fd7a3ce9..96d6275c7afb 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -7,7 +7,7 @@
 use crate::{
     alloc::flags::*,
     bindings, container_of, device,
-    device_id::RawDeviceId,
+    device_id::{RawDeviceId, RawDeviceIdIndex},
     devres::Devres,
     driver,
     error::{to_result, Result},
@@ -164,10 +164,13 @@ pub const fn from_class(class: u32, class_mask: u32) -> Self {
 // SAFETY:
 // * `DeviceId` is a `#[repr(transparent)` wrapper of `pci_device_id` and does not add
 //   additional invariants, so it's safe to transmute to `RawType`.
-// * `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
 unsafe impl RawDeviceId for DeviceId {
     type RawType = bindings::pci_device_id;
+}
 
+// SAFETY:
+// * `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
+unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::pci_device_id, driver_data);
 
     fn index(&self) -> usize {
-- 
2.43.0


