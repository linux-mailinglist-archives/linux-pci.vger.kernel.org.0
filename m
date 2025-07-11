Return-Path: <linux-pci+bounces-31898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D1BB011F9
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 06:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1574A6F91
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 04:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D161C1F12;
	Fri, 11 Jul 2025 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuwhWvSf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F891B87F2;
	Fri, 11 Jul 2025 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752207031; cv=none; b=AbObG2RpSVtEirbh/XR+aL61e6OUB7uSOtbim7DomPLQ1yxZNXMaP0xaCIXWCDs7Vi6Oe0hnQmf48/kF4liqouna0bKNCfv7E+t3GHTbELCQfo41yeATWDweZNnG9SFxcbB58JTmv6eLF7XxpE6xJx6UxunzofmrnwK4QgZG93w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752207031; c=relaxed/simple;
	bh=LyLDiZQiInijvva1oOsPfQzFCieHR8L+i2c7EPsTlwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCC9UEckok01ArTgxBq1AZIPBYExDxvQBMYkGLBhtP2K4CMeaoQ8JPGF4aRa66/RPyKIodF/Vbv+MmMqb8Aj9WPI8V7A1Gm7/EX34FClrE766xtrkxljv30uEIJ7xDm5Sdb6+2YvAFlpGMSfGW9F4wNPYI2iK89yguySyCzwjnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuwhWvSf; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3122a63201bso1453485a91.0;
        Thu, 10 Jul 2025 21:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752207028; x=1752811828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezT4Ms7PLFObqMVGkF8Ub6RgV5PSvQW8O2CmBLmTgTM=;
        b=VuwhWvSfh/QWeZvNIhFDWfc4ATKO9JRheX6SoztoRCGbe0EbzIosfiC53MALOzB0gd
         FArkdAm81w+x+/hWHkmlu8AwyY5P40BTVvfnzUeasulf0BSHee7WW+Pa72EbNnYRB9u6
         wcBxF3s9jHtTqYx3eIKwBX2+r8auB/6jXWkmQ5/XohqHp7CmmSO+wqZfpu557Hsa73W8
         58UuLC6rPhOSR4i0z+a2cAvnLWgViX8/uomTM9SV6GbD6BIqDgweSW9QmdAHUrGc9NxN
         tj1F45myDtJtvdattno+I+8kB4zhsJqSe6BUKWczG27kKo+Wg9UzCj6urSu1ri8kuxKK
         RHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752207028; x=1752811828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezT4Ms7PLFObqMVGkF8Ub6RgV5PSvQW8O2CmBLmTgTM=;
        b=MjvX+gGfCMoTmxFapNepwBt3p9GECZf/OehZKBAhH7BHHp+GrpiqH7LadPBddp6GSx
         jCqvjnBA3KnT46EZPuYGEsyLC/pdT5KeqeSJytLXOtSJSUb9dmXLGP9yp+lLcU77VitH
         gOJHqDgMNxF77CK7cmOROM0eWYQraDfSZRRPAzsCL90oT1BUFfe9ps9h465tLqSuEGKa
         dUTUuTi4JX0aXOAyRphtzFrhnMyRP1t3n8FywqTueoy91eKxfQdsc3CrGxJvTDBlupqr
         uT2EPdNGdsk/BqXxwpubXfWsUgwzJwbrixyUesR7YNPkZhFdLIuWig+NUBkBBOuxk4Vk
         +KbA==
X-Forwarded-Encrypted: i=1; AJvYcCUngiE8FdjCwP6LJiqiW9lWe/05hKmOP7tWwWmV1DYFAtgkRqPhj2Qn24kLe0GK2ep+asGJJpMt@vger.kernel.org, AJvYcCUtthiPg+qeorV/vGBd714HsG0QCq/ODYM9iOMfdw0nRtullMgwUcoE1wEnOhEx9B1kwmKeWUIHf3lPzQra@vger.kernel.org, AJvYcCUvItQI4F7hG3Fl6unw/+PXaKVQ+rRk9wrgc9F6YMJy/qVXCYdWZ+9v/RvvyZ1W4JMYOuC+s2mYTI8XWA==@vger.kernel.org, AJvYcCVV/nr/BBfIEAuzBhVO6xWKFTCySs05uJsYewhk3akquXKMbBXE9rM6iNUodAg65FSlgGKzq1KhighzCJFYKWU=@vger.kernel.org, AJvYcCWK6A2+TU1g0uOGR7LgumE8+uPtgs9U6Fx/wBJ9pRHYdBM3VrfXI1zDnv1WaH7kfdtGpewa0lcB8oIh@vger.kernel.org, AJvYcCXlYikCHfII0JDJ16fjwL1PjWk4s6NTkyTGXtLvvdapzw8S76P03ZH7dhd2x9UoPDln0d5IMcl3uHTd@vger.kernel.org
X-Gm-Message-State: AOJu0YyY7qHCeiuxdBYfm139A9DqGxdLnVUmDeRVgvb7PSZpwzWa4mbt
	TfapjZQSoaFHkvahyk5XpCTlTo2nD/8hBcN95jpoJmRpjQu5Y6EZo8zvSZYpOb25
X-Gm-Gg: ASbGnct2TcPCa1wYyTjzbUgu4b/n0lnBgmRQBuGjnAJE00KPxi8ii2HdzbFEpqY/2XV
	OlzGQRhzGCPUrg3gI5L4Sq9aloefCHCkV4LboHIm1MANId6fukC5LDrdDS49RFwQRBjx7XHtKNT
	+UPvkQuvYGV3b6tKVEbP3hdUjFsQ7PsGI6TbPvKYswwnpCiNXEcM7ZzAm4E0lInpcB6iz9LkjBh
	Z9nhta9Z1bcZPK0+w18NMP0XtrxgXHFdBVpbJLZUdvEKxPs5ArliqU+Mgwt1dKatn9gQ/chbj91
	SOSbudX7yZjfD3eU+LNU0n9vjc6P+pQqJ2ixCCyU31fdCfAzeN7wNa1KMY8Qv5QIJBbPPKUczJq
	lOCsKh8jYnFIkKIkHDnaQv3+sfbOMOWcjO9z4RPwnhEKe5ibrfkRnJuwsoFikLhLaW1owz5w=
X-Google-Smtp-Source: AGHT+IEdbQo15DQTIuzDEdYJAct5+7W0ur1LE/Qkw/aUTLWSQ9nnhjN0SK07zlHORp5a8N2bEMvXFQ==
X-Received: by 2002:a17:90b:3c12:b0:314:2bae:97d7 with SMTP id 98e67ed59e1d1-31c4f4cca77mr1809039a91.15.1752207028246;
        Thu, 10 Jul 2025 21:10:28 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6f4fc8sm3902095a12.51.2025.07.10.21.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 21:10:27 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: alex.gaynor@gmail.com,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	rafael@kernel.org,
	robh@kernel.org,
	saravanak@google.com,
	tmgross@umich.edu
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
	lenb@kernel.org,
	leon@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lossin@kernel.org,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v4 1/3] rust: device_id: split out index support into a separate trait
Date: Fri, 11 Jul 2025 13:09:45 +0900
Message-ID: <20250711040947.1252162-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711040947.1252162-1-fujita.tomonori@gmail.com>
References: <20250711040947.1252162-1-fujita.tomonori@gmail.com>
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
use the RawDeviceId trait.

The changes to acpi.rs and driver.rs were made by Danilo.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/acpi.rs      | 15 ++++---
 rust/kernel/auxiliary.rs | 11 ++---
 rust/kernel/device_id.rs | 91 +++++++++++++++++++++++++++++-----------
 rust/kernel/driver.rs    |  8 +++-
 rust/kernel/of.rs        | 15 ++++---
 rust/kernel/pci.rs       | 11 ++---
 6 files changed, 104 insertions(+), 47 deletions(-)

diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
index 2af4d4f92924..7ae317368b00 100644
--- a/rust/kernel/acpi.rs
+++ b/rust/kernel/acpi.rs
@@ -2,7 +2,11 @@
 
 //! Advanced Configuration and Power Interface abstractions.
 
-use crate::{bindings, device_id::RawDeviceId, prelude::*};
+use crate::{
+    bindings,
+    device_id::{RawDeviceId, RawDeviceIdIndex},
+    prelude::*,
+};
 
 /// IdTable type for ACPI drivers.
 pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;
@@ -12,13 +16,14 @@
 #[derive(Clone, Copy)]
 pub struct DeviceId(bindings::acpi_device_id);
 
-// SAFETY:
-// * `DeviceId` is a `#[repr(transparent)` wrapper of `struct acpi_device_id` and does not add
-//   additional invariants, so it's safe to transmute to `RawType`.
-// * `DRIVER_DATA_OFFSET` is the offset to the `data` field.
+// SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `acpi_device_id` and does not add
+// additional invariants, so it's safe to transmute to `RawType`.
 unsafe impl RawDeviceId for DeviceId {
     type RawType = bindings::acpi_device_id;
+}
 
+// SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
+unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::acpi_device_id, driver_data);
 
     fn index(&self) -> usize {
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 2985673181b7..12a4d36dc452 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -6,7 +6,7 @@
 
 use crate::{
     bindings, container_of, device,
-    device_id::RawDeviceId,
+    device_id::{RawDeviceId, RawDeviceIdIndex},
     driver,
     error::{from_result, to_result, Result},
     prelude::*,
@@ -134,13 +134,14 @@ pub const fn new(modname: &'static CStr, name: &'static CStr) -> Self {
     }
 }
 
-// SAFETY:
-// * `DeviceId` is a `#[repr(transparent)`] wrapper of `auxiliary_device_id` and does not add
-//   additional invariants, so it's safe to transmute to `RawType`.
-// * `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
+// SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `auxiliary_device_id` and does not add
+// additional invariants, so it's safe to transmute to `RawType`.
 unsafe impl RawDeviceId for DeviceId {
     type RawType = bindings::auxiliary_device_id;
+}
 
+// SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
+unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize =
         core::mem::offset_of!(bindings::auxiliary_device_id, driver_data);
 
diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index 0a4eb56d98f2..8ed2c946144c 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -14,32 +14,41 @@
 ///
 /// # Safety
 ///
-/// Implementers must ensure that:
-///   - `Self` is layout-compatible with [`RawDeviceId::RawType`]; i.e. it's safe to transmute to
-///     `RawDeviceId`.
+/// Implementers must ensure that `Self` is layout-compatible with [`RawDeviceId::RawType`];
+/// i.e. it's safe to transmute to `RawDeviceId`.
 ///
-///     This requirement is needed so `IdArray::new` can convert `Self` to `RawType` when building
-///     the ID table.
+/// This requirement is needed so `IdArray::new` can convert `Self` to `RawType` when building
+/// the ID table.
 ///
-///     Ideally, this should be achieved using a const function that does conversion instead of
-///     transmute; however, const trait functions relies on `const_trait_impl` unstable feature,
-///     which is broken/gone in Rust 1.73.
-///
-///   - `DRIVER_DATA_OFFSET` is the offset of context/data field of the device ID (usually named
-///     `driver_data`) of the device ID, the field is suitable sized to write a `usize` value.
-///
-///     Similar to the previous requirement, the data should ideally be added during `Self` to
-///     `RawType` conversion, but there's currently no way to do it when using traits in const.
+/// Ideally, this should be achieved using a const function that does conversion instead of
+/// transmute; however, const trait functions relies on `const_trait_impl` unstable feature,
+/// which is broken/gone in Rust 1.73.
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
+/// Implementers must ensure that `DRIVER_DATA_OFFSET` is the correct offset (in bytes) to
+/// the context/data field (e.g., the `driver_data` field) within the raw device ID structure.
+/// This field must be correctly sized to hold a `usize`.
+///
+/// Ideally, the data should be added during `Self` to `RawType` conversion,
+/// but there's currently no way to do it when using traits in const.
+pub unsafe trait RawDeviceIdIndex: RawDeviceId {
+    /// The offset (in bytes) to the context/data field in the raw device ID.
     const DRIVER_DATA_OFFSET: usize;
 
-    /// The index stored at `DRIVER_DATA_OFFSET` of the implementor of the [`RawDeviceId`] trait.
+    /// The index stored at `DRIVER_DATA_OFFSET` of the implementor of the [`RawDeviceIdIndex`]
+    /// trait.
     fn index(&self) -> usize;
 }
 
@@ -68,7 +77,15 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
     /// Creates a new instance of the array.
     ///
     /// The contents are derived from the given identifiers and context information.
-    pub const fn new(ids: [(T, U); N]) -> Self {
+    ///
+    /// # Safety
+    ///
+    /// `data_offset` as `None` is always safe.
+    /// If `data_offset` is `Some(data_offset)`, then:
+    /// - `data_offset` must be the correct offset (in bytes) to the context/data field
+    ///   (e.g., the `driver_data` field) within the raw device ID structure.
+    /// - The field at `data_offset` must be correctly sized to hold a `usize`.
+    const unsafe fn build(ids: [(T, U); N], data_offset: Option<usize>) -> Self {
         let mut raw_ids = [const { MaybeUninit::<T::RawType>::uninit() }; N];
         let mut infos = [const { MaybeUninit::uninit() }; N];
 
@@ -77,14 +94,16 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
             // SAFETY: by the safety requirement of `RawDeviceId`, we're guaranteed that `T` is
             // layout-wise compatible with `RawType`.
             raw_ids[i] = unsafe { core::mem::transmute_copy(&ids[i].0) };
-            // SAFETY: by the safety requirement of `RawDeviceId`, this would be effectively
-            // `raw_ids[i].driver_data = i;`.
-            unsafe {
-                raw_ids[i]
-                    .as_mut_ptr()
-                    .byte_offset(T::DRIVER_DATA_OFFSET as _)
-                    .cast::<usize>()
-                    .write(i);
+            if let Some(data_offset) = data_offset {
+                // SAFETY: by the safety requirement of this function, this would be effectively
+                // `raw_ids[i].driver_data = i;`.
+                unsafe {
+                    raw_ids[i]
+                        .as_mut_ptr()
+                        .byte_offset(data_offset as _)
+                        .cast::<usize>()
+                        .write(i);
+                }
             }
 
             // SAFETY: this is effectively a move: `infos[i] = ids[i].1`. We make a copy here but
@@ -109,12 +128,34 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
         }
     }
 
+    /// Creates a new instance of the array without writing index values.
+    ///
+    /// The contents are derived from the given identifiers and context information.
+    /// If the device implements [`RawDeviceIdIndex`], consider using [`IdArray::new`] instead.
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
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index f8dd7593e8dc..a8f2675ba7a7 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -170,7 +170,7 @@ fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
                 // and does not add additional invariants, so it's safe to transmute.
                 let id = unsafe { &*raw_id.cast::<acpi::DeviceId>() };
 
-                Some(table.info(<acpi::DeviceId as crate::device_id::RawDeviceId>::index(id)))
+                Some(table.info(<acpi::DeviceId as crate::device_id::RawDeviceIdIndex>::index(id)))
             }
         }
     }
@@ -204,7 +204,11 @@ fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
                 // and does not add additional invariants, so it's safe to transmute.
                 let id = unsafe { &*raw_id.cast::<of::DeviceId>() };
 
-                Some(table.info(<of::DeviceId as crate::device_id::RawDeviceId>::index(id)))
+                Some(
+                    table.info(<of::DeviceId as crate::device_id::RawDeviceIdIndex>::index(
+                        id,
+                    )),
+                )
             }
         }
     }
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index 52fe0c77b9a1..0888469bddb7 100644
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
@@ -12,13 +16,14 @@
 #[derive(Clone, Copy)]
 pub struct DeviceId(bindings::of_device_id);
 
-// SAFETY:
-// * `DeviceId` is a `#[repr(transparent)]` wrapper of `struct of_device_id` and does not add
-//   additional invariants, so it's safe to transmute to `RawType`.
-// * `DRIVER_DATA_OFFSET` is the offset to the `data` field.
+// SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct of_device_id` and
+// does not add additional invariants, so it's safe to transmute to `RawType`.
 unsafe impl RawDeviceId for DeviceId {
     type RawType = bindings::of_device_id;
+}
 
+// SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `data` field.
+unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::of_device_id, data);
 
     fn index(&self) -> usize {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 8b884e324dcf..ba9a5c6fc513 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -6,7 +6,7 @@
 
 use crate::{
     bindings, container_of, device,
-    device_id::RawDeviceId,
+    device_id::{RawDeviceId, RawDeviceIdIndex},
     devres::Devres,
     driver,
     error::{from_result, to_result, Result},
@@ -159,13 +159,14 @@ pub const fn from_class(class: u32, class_mask: u32) -> Self {
     }
 }
 
-// SAFETY:
-// * `DeviceId` is a `#[repr(transparent)]` wrapper of `pci_device_id` and does not add
-//   additional invariants, so it's safe to transmute to `RawType`.
-// * `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
+// SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `pci_device_id` and does not add
+// additional invariants, so it's safe to transmute to `RawType`.
 unsafe impl RawDeviceId for DeviceId {
     type RawType = bindings::pci_device_id;
+}
 
+// SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
+unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::pci_device_id, driver_data);
 
     fn index(&self) -> usize {
-- 
2.43.0


