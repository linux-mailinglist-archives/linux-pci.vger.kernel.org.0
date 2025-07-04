Return-Path: <linux-pci+bounces-31496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C811AF863C
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 06:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1C45667EF
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 04:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33A11F30AD;
	Fri,  4 Jul 2025 04:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgRWf10Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D919A27735;
	Fri,  4 Jul 2025 04:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751602246; cv=none; b=p1hH7h63p2jYahyw+/mTtIzKDHmYCUH+sYZ+y+HwIRmQjBovKQTaWlBBjVbYdDTglodRXQyIxNLY80XZmgDW1aFd0Vy5fXEXA0J0ozSNyZivvQPlMA2MbKLUNGWIUov5gbc3yb2JiUh72Stc4MWYGaROZ5lOMwRAU+Xr3uPdkvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751602246; c=relaxed/simple;
	bh=eNbksy8AOjNuAyIZhrJCd/5+MipiS6qBpV2tUg3eZjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzCdKRVjSxFw+WgEcwAUQzjD1GvhYdMp+KfqFggm14JqTOoz3eSOBYUxe+4aCmeIjJUDmqKZ31I4sEflNxXFcL9+c95FDXHqqR16IxXV6i1Y5VSYIr5y3C6CgFasCx59atnCBQaazfnUCp67NSx2gTsdcGzJw6yGBXv1ij0xwY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgRWf10Z; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b31e0ead80eso429385a12.0;
        Thu, 03 Jul 2025 21:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751602244; x=1752207044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLlW3cPUYyFonekL6aq/AJFh/MLlfDz3CJwgfxqEOeU=;
        b=TgRWf10Z5F+xYUle1GlauQNrjgjHbv1JTnLCO4Ohd8EuLpnx9vvncdc/PErq2rCXer
         hM5DlINoVVR4c+S2g1MMvclK3BCfDvQ5VF5Gw2etq2YemE14/7kTl+IJEqQvOiAYB9h/
         mJ+5iHHY1XeJom3W+lbMEqFyO5aLq1HtbTtO27BufPcW/6f6rAnMnsriOWFMajQEhOxz
         LGz3n/i5Niqmu9vv8k/Bx10JFe0IixcPUSHZ3L+lFwdGDro4hSu+F7Hvn3C/e17/6xzg
         f2wXduuzncIuylex3jgvzGa5EKRjcvnjJRDg7/H6MUzF4Y0jFKOc2nuzXcvrq7bDOXi9
         tfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751602244; x=1752207044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLlW3cPUYyFonekL6aq/AJFh/MLlfDz3CJwgfxqEOeU=;
        b=XXd1fmeZQ5obntM1H2au6UDIaH/JjIsMGQroK3bLSEkBlZORD3sBnbMa/+WR1NW69v
         m+mloqmAKCBK/UWO7wt1j/+ZnlFV7+oZxbF0QYxE3m+cyM8g7FtM85oMbPcy+YEvDM5v
         r0EkNapd/8lCn1n24mv4g9ojxEGxqUp+3uQYAJ7pPjQzsECoVcaSLJOecAQbD0atncgb
         UGuMurebrOcfUah/hUMFXEdeXuun4Qt4mPHC7+vejqt2ROcA9AZ2D+woEDcVSu0nO4Ae
         Kel2+Wp1VqRs6n/c6TRg13dcJMYMXHq3/ybIpHnsNAErqAHbwgnVvAA2XJLaEmMqs3uJ
         nlcA==
X-Forwarded-Encrypted: i=1; AJvYcCUdtmQBEm+JjEXIiANezW/utviDVwVXYQtlmh1pd+90xR8b5HCvwAg51yIruGbVN7LvWSNZuvrl@vger.kernel.org, AJvYcCV7AcBKyH+4xlow5LB6NDY2g6k7Z4l549AiKU+XrWUlacqrqpQsd1i0jFC4FKrfStqvVIF9s1inDFZ0fi9c@vger.kernel.org, AJvYcCWPOCppkjr3NPtCkowrTTlkafKLh4oTAZ8Seh5Y1b5bYBLt/MFKZa+h4IaJEwOHn8HThLSsP10MBPti@vger.kernel.org, AJvYcCWuxn3oNk84FB5ROsUaJXrNyZRMrctNJR1I6Eeguwc4sGuYO5lXexdvL9KCnRJIYB09euMNnUW/8bwm@vger.kernel.org, AJvYcCXzz6A5FpAqZAy+QHTz2bByMYCAr/THvjqmnXOvuhgqXpaDlvg/0/VHuEySQb91NkaGnykPDJIT+/CRjAqWh+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq94oxhbTRjZ3fBRdmxVuLhrRrGfd+sgngwo78G8B60pT/FUXZ
	sXDkSfa/T7RLLI9FNXUyMnc4RjkAlIq6u0Cv8Pof8lTUBndJZdkYZhCy
X-Gm-Gg: ASbGnct5iGlbx3Hhaidv6oxS73kDEJpjTQkK9/6BvPZheGMq6uk6HayVgkwRtovfBe9
	TPLNUlat1pO/5Uv4oYThR7P7E0RWdVHBAhmjDJw00yqk/irjQEWnZpttWCjwor2vi4qrgctOOio
	0EZ5FxDIIm+x2nOWEiOgUPYY3B182rLXwmDWZR6DNQPHfCKqhIuPlo/dMonRxOh+Y8TQp69o8Ox
	Ur+06Q3D/TxDROkR+cxpv5FKSsAGJw3W57p/ogndih9/hpUhpHT45Jty2BQrWHF4D9f+K+FtM/I
	TzhL+1EnxHwGaKzKK3sQhLTUWaVsng0V026ml6mvlQrMyJJkXOKmuCV5tsUylYu0z+sAPcI2SoG
	SxNaTTmzw6cazU9bWQfdYy8648e6Ajm4Co7utMPPKEnIGvw==
X-Google-Smtp-Source: AGHT+IHB5benb40weVsS/om26EMWrjUvnSEItDPkOuKwEXM1nyxNNczxCzTygFKqVoraa01oZ59IxA==
X-Received: by 2002:a05:6a21:6185:b0:1f5:619a:7f4c with SMTP id adf61e73a8af0-225c0de0c35mr2051539637.29.1751602243963;
        Thu, 03 Jul 2025 21:10:43 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35ccb9esm1055290b3a.50.2025.07.03.21.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 21:10:43 -0700 (PDT)
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
Subject: [PATCH v3 1/3] rust: device_id: split out index support into a separate trait
Date: Fri,  4 Jul 2025 13:10:01 +0900
Message-ID: <20250704041003.734033-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704041003.734033-1-fujita.tomonori@gmail.com>
References: <20250704041003.734033-1-fujita.tomonori@gmail.com>
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

Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/auxiliary.rs | 11 ++---
 rust/kernel/device_id.rs | 91 ++++++++++++++++++++++++++++------------
 rust/kernel/of.rs        | 15 ++++---
 rust/kernel/pci.rs       | 11 ++---
 4 files changed, 87 insertions(+), 41 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index d2cfe1eeefb6..526cb6dcad52 100644
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
@@ -140,13 +140,14 @@ pub const fn new(modname: &'static CStr, name: &'static CStr) -> Self {
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
index 3dc72ca8cfc2..242666c2409c 100644
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
 
@@ -68,7 +77,14 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
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
 
@@ -77,14 +93,17 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
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
@@ -92,7 +111,6 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
             infos[i] = MaybeUninit::new(unsafe { core::ptr::read(&ids[i].1) });
             i += 1;
         }
-
         core::mem::forget(ids);
 
         Self {
@@ -109,12 +127,33 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
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
index 40d1bd13682c..0c799a06371d 100644
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
-// * `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and does not add
-//   additional invariants, so it's safe to transmute to `RawType`.
-// * `DRIVER_DATA_OFFSET` is the offset to the `data` field.
+// SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct of_device_id` and does not add
+// additional invariants, so it's safe to transmute to `RawType`.
 unsafe impl RawDeviceId for DeviceId {
     type RawType = bindings::of_device_id;
+}
 
+// SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `data` field.
+unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::of_device_id, data);
 
     fn index(&self) -> usize {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 6b94fd7a3ce9..8012bfad3150 100644
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
@@ -161,13 +161,14 @@ pub const fn from_class(class: u32, class_mask: u32) -> Self {
     }
 }
 
-// SAFETY:
-// * `DeviceId` is a `#[repr(transparent)` wrapper of `pci_device_id` and does not add
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


