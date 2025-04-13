Return-Path: <linux-pci+bounces-25752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5367A87305
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 19:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730A716FEE4
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49F21F3FD3;
	Sun, 13 Apr 2025 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqNoY+1S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4F91A0711;
	Sun, 13 Apr 2025 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744565894; cv=none; b=c+Von5ffs+04vM7TbHG7qEhJHXMBgeU9OpHSsMx9a4VDKGHHy3nV0Zds3qvSobPU0H5rYMvZkLg9GwqFXJwD1csjsGY7sF2cqfgcAbelcSBs+vZ0rlBWEdRazPMQvHt0+n0rs9JdE/34kCFnQuH76Sc+nRH4ArjA9vH5EmvVY2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744565894; c=relaxed/simple;
	bh=gLqLj4ZQ3X469fEAy6+OfUy9C5xFQ/xnWlLGjxKPDdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QA+AO+5v0r3WngV/fpxIX7Z7eaejk1s+MZCaQEEs6PwoDq161k/iQW3dxQ4Gy5RNEG7snKe9fJHATXLrlMfvwbAejaGB0ldq0K4/kGP5SXyOIABprqQnOHTP3A9yIriboEnBiioJCWgMPtBzE3BxVI2qV8Xscqkv8wrugwINtGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqNoY+1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5FCC4CEDD;
	Sun, 13 Apr 2025 17:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744565894;
	bh=gLqLj4ZQ3X469fEAy6+OfUy9C5xFQ/xnWlLGjxKPDdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PqNoY+1Sbb8ws1gk+lhHsYus7extZBWNS0adWIh8h2kkORY1cd9KsZHi9+chPh4ZO
	 r8v59lAfsL1jiH583LXSzfx2+zPPbxpQyhjEBA0z6gq9s1s2Zh3XN/8SSqlxGnnNdk
	 n0Dp4brGhoAtmZGcAOKvhwS7wjOle7ize6Vvbn5R7XYoM5w1PdnkWBA/ccgQmdK48G
	 1J1pO70YtahXPemE0DBX4fFnytt0ML+YfuQYIvnJvbLzNYjRArFyg/8s+Ce5KQwf4p
	 UcwGtrFAHf2G4qWVk1UZsU38fY6Orspp7W5Wiq4hIGAeSNG+gbJ0+0hmeSp9Iu43xR
	 FcOkY/p1/yl+g==
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
Subject: [PATCH v2 2/9] rust: device: implement impl_device_context_into_aref!
Date: Sun, 13 Apr 2025 19:36:57 +0200
Message-ID: <20250413173758.12068-3-dakr@kernel.org>
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
index 7cb6f0fc005d..26e71224460b 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -279,6 +279,27 @@ macro_rules! impl_device_context_deref {
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
index 8474608e7a90..7c6ec05383e0 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -425,12 +425,7 @@ pub fn set_master(&self) {
 // SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
 // argument.
 kernel::impl_device_context_deref!(unsafe { Device });
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
index 22590bdff7bb..9476b717c425 100644
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
 
@@ -192,12 +192,7 @@ fn as_raw(&self) -> *mut bindings::platform_device {
 // SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
 // argument.
 kernel::impl_device_context_deref!(unsafe { Device });
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


