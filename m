Return-Path: <linux-pci+bounces-25753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32566A87306
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 19:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5558318952D0
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA261F3B85;
	Sun, 13 Apr 2025 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6Xqpy0z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD031F37D4;
	Sun, 13 Apr 2025 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744565900; cv=none; b=TGe8/N65j5LGxUvDEAlc1RqG8DRUZDkLQL4zqT2bo7HrPbb9ehOabDy+YUuz+r7zoTCc8yU6nt/Qy0rG59IaM3KmeH+IzjF6wSYkKAcYKyqak7At/diFoB2VRCjrKFYVuS1kJ5gKhvTX6oX2/iGch7ItVO5KA+brrM7BM/uIE40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744565900; c=relaxed/simple;
	bh=ZI5lPPz6yGBCSm+t0Bi5DUr3i8+J68407FIIDtD2wsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kW5xTZGyee3ZqPXwU7Z4Kzh4jwQC2OAPEq1hN9pBpaNUqNuoStmg+cP6rYgW2hANKlNJWTsa+0h3BPHP1E+0IMTPO8YRMgegwpvlf+kupktJxr6TZw9ctPvsu9Y2Yjqi7ZJzGIXgLOn7YsN1mMKF15pr30xPrISVamczN2pXfHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6Xqpy0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A19C4CEE7;
	Sun, 13 Apr 2025 17:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744565898;
	bh=ZI5lPPz6yGBCSm+t0Bi5DUr3i8+J68407FIIDtD2wsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u6Xqpy0zLvOISYx/FpFw7Gf+A73MLZ+lPCnW91qLe+Iuj/pDnZF8IkbxVT8i9GjPU
	 cWruFqokFVboAecNLyS2aW0XB1k00lzZji2X8GmYc4PhvJ2lPCOPgCE4Rz7oFSp4fo
	 s7semkyUPjYu0Kj7nYpx9xokee7G2F5N+nlOou9IAYrA1dNWRcIW/rXdkkh5uHjxYi
	 84kMy7DqbdtIvLr/zHipZCWws10MccIdT7bbhTqxqZmCYH1Qss7L0FReFMLjgCVQBi
	 l7Fd3mp4+7+H8e9XyHThq5+w5j/dixyFk+GrMpS41vUmn6/agTyuiAqPlUAKqjKNYz
	 qTgyiNe9DoO0Q==
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
Subject: [PATCH v2 3/9] rust: device: implement device context for Device
Date: Sun, 13 Apr 2025 19:36:58 +0200
Message-ID: <20250413173758.12068-4-dakr@kernel.org>
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

Analogous to bus specific device, implement the DeviceContext generic
for generic devices.

This is used for APIs that work with generic devices (such as Devres) to
evaluate the device' context.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 26e71224460b..487211842f77 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -9,7 +9,7 @@
     str::CStr,
     types::{ARef, Opaque},
 };
-use core::{fmt, ptr};
+use core::{fmt, marker::PhantomData, ptr};
 
 #[cfg(CONFIG_PRINTK)]
 use crate::c_str;
@@ -42,7 +42,7 @@
 /// `bindings::device::release` is valid to be called from any thread, hence `ARef<Device>` can be
 /// dropped from any thread.
 #[repr(transparent)]
-pub struct Device(Opaque<bindings::device>);
+pub struct Device<Ctx: DeviceContext = Normal>(Opaque<bindings::device>, PhantomData<Ctx>);
 
 impl Device {
     /// Creates a new reference-counted abstraction instance of an existing `struct device` pointer.
@@ -59,7 +59,9 @@ pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
         // SAFETY: By the safety requirements ptr is valid
         unsafe { Self::as_ref(ptr) }.into()
     }
+}
 
+impl<Ctx: DeviceContext> Device<Ctx> {
     /// Obtain the raw `struct device *`.
     pub(crate) fn as_raw(&self) -> *mut bindings::device {
         self.0.get()
@@ -189,6 +191,11 @@ pub fn property_present(&self, name: &CStr) -> bool {
     }
 }
 
+// SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
+// argument.
+kernel::impl_device_context_deref!(unsafe { Device });
+kernel::impl_device_context_into_aref!(Device);
+
 // SAFETY: Instances of `Device` are always reference-counted.
 unsafe impl crate::types::AlwaysRefCounted for Device {
     fn inc_ref(&self) {
-- 
2.49.0


